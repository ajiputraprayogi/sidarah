<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;

class StokDarahController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $stok = DB::table('stok_darah')->get();

        return response()->json([
            'status' => true,
            'data' => $stok
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
            'golongan_darah' => 'required|string|max:5',
            'jumlah' => 'required|integer|min:0',
            'tanggal' => 'required|date',
        ], [
            'golongan_darah.required' => 'Golongan darah wajib diisi.',
            'golongan_darah.string' => 'Golongan darah harus berupa teks.',
            'golongan_darah.max' => 'Golongan darah maksimal 5 karakter.',

            'jumlah.required' => 'Jumlah wajib diisi.',
            'jumlah.integer' => 'Jumlah harus berupa angka.',
            'jumlah.min' => 'Jumlah minimal 0.',

            'tanggal.required' => 'Tanggal wajib diisi.',
            'tanggal.date' => 'Format tanggal tidak valid.',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'status' => false,
                'message' => 'Validasi gagal',
                'errors' => $validator->errors()
            ], 422);
        }

        $id = DB::table('stok_darah')->insertGetId([
            'golongan_darah' => $request->golongan_darah,
            'jumlah' => $request->jumlah,
            'tanggal' => $request->tanggal,
            'created_at' => now(),
            'updated_at' => now(),
        ]);

        $stok = DB::table('stok_darah')->where('id', $id)->first();

        return response()->json([
            'status' => true,
            'message' => 'Data stok darah berhasil ditambahkan.',
            'data' => $stok
        ], 201);
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        $stok = DB::table('stok_darah')->where('id', $id)->first();

        if (!$stok) {
            return response()->json([
                'status' => false,
                'message' => 'Data tidak ditemukan.'
            ], 404);

        }
        
        return response()->json([
            'status' => true,
            'data' => $stok
        ]);
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
        $stok = DB::table('stok_darah')->where('id', $id)->first();

        if (!$stok) {
            return response()->json([
                'status' => false,
                'message' => 'Data tidak ditemukan.'
            ], 404);
        }

        $validator = Validator::make($request->all(), [
            'golongan_darah' => 'sometimes|required|string|max:5',
            'jumlah' => 'sometimes|required|integer|min:0',
            'tanggal' => 'sometimes|required|date',
        ], [
            'golongan_darah.required' => 'Golongan darah wajib diisi.',
            'golongan_darah.string' => 'Golongan darah harus berupa teks.',
            'golongan_darah.max' => 'Golongan darah maksimal 5 karakter.',

            'jumlah.required' => 'Jumlah wajib diisi.',
            'jumlah.integer' => 'Jumlah harus berupa angka.',
            'jumlah.min' => 'Jumlah minimal 0.',

            'tanggal.required' => 'Tanggal wajib diisi.',
            'tanggal.date' => 'Format tanggal tidak valid.',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'status' => false,
                'message' => 'Validasi gagal',
                'errors' => $validator->errors()
            ], 422);
        }

        DB::table('stok_darah')->where('id', $id)->update(array_merge(
            $request->only(['golongan_darah', 'jumlah', 'tanggal']),
            ['updated_at' => now()]
        ));

        $stok = DB::table('stok_darah')->where('id', $id)->first();

        return response()->json([
            'status' => true,
            'message' => 'Data stok darah berhasil diperbarui.',
            'data' => $stok
        ]);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        $stok = DB::table('stok_darah')->where('id', $id)->first();

        if (!$stok) {
            return response()->json([
                'status' => false,
                'message' => 'Data tidak ditemukan.'
            ], 404);
        }

        DB::table('stok_darah')->where('id', $id)->delete();

        return response()->json([
            'status' => true,
            'message' => 'Data stok darah berhasil dihapus.'
        ]);
    }
}
