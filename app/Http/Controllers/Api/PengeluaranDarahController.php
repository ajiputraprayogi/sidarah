<?php

namespace App\Http\Controllers\api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;

class PengeluaranDarahController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        // Total stok per golongan
        $stok = DB::table('stok_darah')
            ->select(
                'golongan_darah',
                DB::raw('SUM(jumlah) as total_stok')
            )
            ->groupBy('golongan_darah');

        // Total pengeluaran per golongan
        $pengeluaran = DB::table('pengeluaran_darah')
            ->select(
                'golongan_darah',
                DB::raw('SUM(jumlah) as total_pengeluaran')
            )
            ->groupBy('golongan_darah');

        // Join hasil agregasi
        $data = DB::query()
            ->fromSub($stok, 's')
            ->leftJoinSub($pengeluaran, 'p', function ($join) {
                $join->on('s.golongan_darah', '=', 'p.golongan_darah');
            })
            ->select(
                's.golongan_darah',
                's.total_stok',
                DB::raw('COALESCE(p.total_pengeluaran, 0) as total_pengeluaran'),
                DB::raw('(s.total_stok - COALESCE(p.total_pengeluaran, 0)) as sisa_stok')
            )
            ->orderBy('s.golongan_darah', 'asc')
            ->get();

        return response()->json([
            'status' => true,
            'data' => $data
        ]);
    }

    public function list(Request $request)
    {
        $data = DB::table('pengeluaran_darah')
            ->select(
                'id',
                'golongan_darah',
                'jumlah',
                'tanggal_pengeluaran',
                'created_at'
            )
            ->orderBy('tanggal_pengeluaran', 'desc')
            ->orderBy('id', 'desc')
            ->paginate(10); // 10 data per halaman

        return response()->json([
            'status' => true,
            'data' => $data
        ]);
    }



    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'golongan_darah' => 'required|in:A,B,AB,O',
            'jumlah' => 'required|integer|min:1',
            'tanggal_pengeluaran' => 'required|date',
        ], [
            'golongan_darah.required' => 'Golongan darah wajib diisi',
            'golongan_darah.in' => 'Golongan darah harus A, B, AB, atau O',
            'jumlah.required' => 'Jumlah wajib diisi',
            'jumlah.integer' => 'Jumlah harus berupa angka',
            'jumlah.min' => 'Jumlah minimal 1',
            'tanggal_pengeluaran.required' => 'Tanggal wajib diisi',
            'tanggal_pengeluaran.date' => 'Format tanggal tidak valid',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'status' => false,
                'message' => 'Validasi gagal',
                'errors' => $validator->errors()
            ], 422);
        }

        // ✅ Hitung TOTAL STOK berdasarkan golongan
        $totalStok = DB::table('stok_darah')
            ->where('golongan_darah', $request->golongan_darah)
            ->sum('jumlah');

        // ✅ Hitung TOTAL PENGELUARAN berdasarkan golongan
        $totalKeluar = DB::table('pengeluaran_darah')
            ->where('golongan_darah', $request->golongan_darah)
            ->sum('jumlah');

        // ✅ Hitung SISA STOK
        $sisaStok = $totalStok - $totalKeluar;

        // ✅ Validasi stok cukup
        if ($sisaStok < $request->jumlah) {
            return response()->json([
                'status' => false,
                'message' => 'Stok tidak mencukupi. Sisa stok saat ini: ' . $sisaStok
            ], 400);
        }

        // ✅ Simpan pengeluaran TANPA stok_id
        $id = DB::table('pengeluaran_darah')->insertGetId([
            'golongan_darah' => $request->golongan_darah,
            'jumlah' => $request->jumlah,
            'tanggal_pengeluaran' => $request->tanggal_pengeluaran,
            'created_at' => now(),
            'updated_at' => now(),
        ]);

        $data = DB::table('pengeluaran_darah')->where('id', $id)->first();

        return response()->json([
            'status' => true,
            'message' => 'Pengeluaran darah berhasil ditambahkan',
            'data' => $data
        ], 201);
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(string $id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        // Ambil data pengeluaran lama
        $data = DB::table('pengeluaran_darah')->where('id', $id)->first();

        if (!$data) {
            return response()->json([
                'status' => false,
                'message' => 'Data tidak ditemukan'
            ], 404);
        }

        $validator = Validator::make($request->all(), [
            'jumlah' => 'sometimes|required|integer|min:1',
            'tanggal_pengeluaran' => 'sometimes|required|date',
        ], [
            'jumlah.integer' => 'Jumlah harus berupa angka',
            'jumlah.min' => 'Jumlah minimal 1',
            'tanggal_pengeluaran.date' => 'Format tanggal tidak valid',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'status' => false,
                'message' => 'Validasi gagal',
                'errors' => $validator->errors()
            ], 422);
        }

        // ✅ Jika JUMLAH diubah → validasi ulang ke total stok
        if ($request->has('jumlah')) {

            // Total stok per golongan
            $totalStok = DB::table('stok_darah')
                ->where('golongan_darah', $data->golongan_darah)
                ->sum('jumlah');

            // Total pengeluaran per golongan
            $totalKeluar = DB::table('pengeluaran_darah')
                ->where('golongan_darah', $data->golongan_darah)
                ->sum('jumlah');

            // ✅ Kembalikan jumlah lama dulu sebelum validasi
            $sisaStok = $totalStok - ($totalKeluar - $data->jumlah);

            if ($sisaStok < $request->jumlah) {
                return response()->json([
                    'status' => false,
                    'message' => 'Stok tidak mencukupi untuk perubahan. Sisa stok saat ini: ' . $sisaStok
                ], 400);
            }
        }

        // ✅ Update data pengeluaran
        DB::table('pengeluaran_darah')
            ->where('id', $id)
            ->update(array_merge(
                $request->only(['jumlah', 'tanggal_pengeluaran']),
                ['updated_at' => now()]
            ));

        $updated = DB::table('pengeluaran_darah')->where('id', $id)->first();

        return response()->json([
            'status' => true,
            'message' => 'Data pengeluaran berhasil diperbarui',
            'data' => $updated
        ]);
    }


    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        $data = DB::table('pengeluaran_darah')->where('id', $id)->first();

        if (!$data) {
            return response()->json([
                'status' => false,
                'message' => 'Data tidak ditemukan'
            ], 404);
        }

        DB::table('pengeluaran_darah')->where('id', $id)->delete();

        return response()->json([
            'status' => true,
            'message' => 'Data pengeluaran berhasil dihapus'
        ]);
    }

    public function chartStok()
    {
        // Total stok per golongan
        $stok = DB::table('stok_darah')
            ->select(
                'golongan_darah',
                DB::raw('SUM(jumlah) as total_stok')
            )
            ->groupBy('golongan_darah');

        // Total pengeluaran per golongan
        $pengeluaran = DB::table('pengeluaran_darah')
            ->select(
                'golongan_darah',
                DB::raw('SUM(jumlah) as total_pengeluaran')
            )
            ->groupBy('golongan_darah');

        // Join hasil agregasi
        $data = DB::query()
            ->fromSub($stok, 's')
            ->leftJoinSub($pengeluaran, 'p', function ($join) {
                $join->on('s.golongan_darah', '=', 'p.golongan_darah');
            })
            ->select(
                's.golongan_darah',
                DB::raw('(s.total_stok - COALESCE(p.total_pengeluaran, 0)) as total_stok')
            )
            ->orderBy('s.golongan_darah', 'asc')
            ->get();

        return response()->json([
            'status' => true,
            'data' => $data
        ]);
    }

    public function chartPengeluaran()
    {
        // Total stok per golongan
        $stok = DB::table('stok_darah')
            ->select(
                'golongan_darah',
                DB::raw('SUM(jumlah) as total_stok')
            )
            ->groupBy('golongan_darah');

        // Total pengeluaran per golongan
        $pengeluaran = DB::table('pengeluaran_darah')
            ->select(
                'golongan_darah',
                DB::raw('SUM(jumlah) as total_pengeluaran')
            )
            ->groupBy('golongan_darah');

        // Join hasil agregasi
        $data = DB::query()
            ->fromSub($stok, 's')
            ->leftJoinSub($pengeluaran, 'p', function ($join) {
                $join->on('s.golongan_darah', '=', 'p.golongan_darah');
            })
            ->select(
                's.golongan_darah',
                'p.total_pengeluaran'
            )
            ->orderBy('s.golongan_darah', 'asc')
            ->get();

        return response()->json([
            'status' => true,
            'data' => $data
        ]);
    }

    public function chartPemasukan()
    {
        $startDate = now()->subDays(30)->startOfDay();
        $endDate   = now()->endOfDay();

        // Total stok per golongan
        $stok = DB::table('stok_darah')
            ->select(
                'golongan_darah',
                DB::raw('SUM(jumlah) as total_stok')
            )
            ->wherebetween('tanggal', [$startDate, $endDate])
            ->groupBy('golongan_darah');

        // Total pengeluaran per golongan
        $pengeluaran = DB::table('pengeluaran_darah')
            ->select(
                'golongan_darah',
                DB::raw('SUM(jumlah) as total_pengeluaran')
            )
            ->wherebetween('tanggal', [$startDate, $endDate])
            ->groupBy('golongan_darah');

        // Join hasil agregasi
        $data = DB::query()
            ->fromSub($stok, 's')
            ->leftJoinSub($pengeluaran, 'p', function ($join) {
                $join->on('s.golongan_darah', '=', 'p.golongan_darah');
            })
            ->select(DB::raw('s.golongan_darah,s.total_stok - IFNULL(p.total_pengeluaran, 0) as total_pemasukan'))
            ->orderBy('s.golongan_darah', 'asc')
            ->get();

        return response()->json([
            'status' => true,
            'data' => $data
        ]);
    }
}
