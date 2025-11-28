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
        $data = DB::table('stok_darah')
            ->select('golongan_darah', DB::raw('SUM(jumlah) as total_stok'))
            ->groupBy('golongan_darah')
            ->get();

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
            'stok_id' => 'required|integer|exists:stok_darah,id',
            'jumlah' => 'required|integer|min:1',
            'tanggal_pengeluaran' => 'required|date',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'status' => false,
                'message' => 'Validasi gagal',
                'errors' => $validator->errors()
            ], 422);
        }

        // Ambil stok
        $stok = DB::table('stok_darah')->where('id', $request->stok_id)->first();

        // Cek stok cukup?
        if ($stok->jumlah < $request->jumlah) {
            return response()->json([
                'status' => false,
                'message' => 'Stok tidak mencukupi'
            ], 400);
        }

        // Simpan pengeluaran
        $id = DB::table('pengeluaran_darah')->insertGetId([
            'stok_id' => $stok->id,
            'golongan_darah' => $stok->golongan_darah,
            'jumlah' => $request->jumlah,
            'tanggal_pengeluaran' => $request->tanggal_pengeluaran,
            'created_at' => now(),
            'updated_at' => now(),
        ]);

        // Kurangi stok
        DB::table('stok_darah')->where('id', $stok->id)->update([
            'jumlah' => $stok->jumlah - $request->jumlah,
            'updated_at' => now()
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
        ]);

        if ($validator->fails()) {
            return response()->json([
                'status' => false,
                'message' => 'Validasi gagal',
                'errors' => $validator->errors()
            ], 422);
        }

        // Jika jumlah diubah → sesuaikan stok
        if ($request->has('jumlah')) {
            $stok = DB::table('stok_darah')->where('id', $data->stok_id)->first();

            $selisih = $request->jumlah - $data->jumlah;

            // Jika selisih > stok → stok kurang
            if ($selisih > 0 && $stok->jumlah < $selisih) {
                return response()->json([
                    'status' => false,
                    'message' => 'Stok tidak mencukupi untuk perubahan jumlah'
                ], 400);
            }

            // Update stok sesuai selisih
            DB::table('stok_darah')->where('id', $data->stok_id)->update([
                'jumlah' => $stok->jumlah - $selisih,
                'updated_at' => now()
            ]);
        }

        // Update data pengeluaran
        DB::table('pengeluaran_darah')->where('id', $id)->update(array_merge(
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

        // Kembalikan stok
        DB::table('stok_darah')->where('id', $data->stok_id)->increment('jumlah', $data->jumlah);

        // Hapus data
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
                's.total_stok'
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
            ->select(DB::raw('s.golongan_darah,s.total_stok - IFNULL(p.total_pengeluaran, 0) as total_pemasukan'))
            ->orderBy('s.golongan_darah', 'asc')
            ->get();

        return response()->json([
            'status' => true,
            'data' => $data
        ]);
    }
}
