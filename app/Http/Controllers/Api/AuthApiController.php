<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\Auth\LoginRequest;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Validation\ValidationException;

class AuthApiController extends Controller
{
    /**
     * Handle API Login (mirip login web tapi JSON+Token)
     */
    public function login(Request $request)
    {
        try {
            // Validasi input
            $request->validate([
                'email' => ['required', 'string', 'email'],
                'password' => ['required', 'string'],
            ]);

            // Cek kredensial
            if (!Auth::attempt($request->only('email', 'password'))) {
                return response()->json([
                    'status' => false,
                    'message' => 'Email atau password salah',
                    'errors' => [
                        'email' => ['Email atau password salah'],
                        'password' => ['Email atau password salah'],
                    ],
                ], 401);
            }

            // Ambil user yang berhasil login
            $user = Auth::user();

            // Single device login (hapus token lama)
            $user->tokens()->delete();

            // Generate token baru
            $token = $user->createToken('api_token')->plainTextToken;

            return response()->json([
                'status' => true,
                'message' => 'Login berhasil',
                'token' => $token,
                'user' => $user,
            ], 200);

        } catch (ValidationException $e) {
            return response()->json([
                'status' => false,
                'message' => 'Validasi gagal',
                'errors' => $e->errors(),
            ], 422);
        }
    }

    public function register(Request $request)
    {
        try {
            // Validasi input
            $validatedData = $request->validate([
                'name' => ['required', 'string', 'max:255'],
                'email' => ['required', 'string', 'email', 'max:255', 'unique:users,email'],
                'password' => ['required', 'confirmed', 'min:6'],
            ], [
                'name.required' => 'Nama wajib diisi.',
                'name.string' => 'Nama harus berupa teks.',
                'name.max' => 'Nama maksimal 255 karakter.',
                
                'email.required' => 'Email wajib diisi.',
                'email.string' => 'Email harus berupa teks.',
                'email.email' => 'Format email tidak valid.',
                'email.max' => 'Email maksimal 255 karakter.',
                'email.unique' => 'Email sudah digunakan.',

                'password.required' => 'Password wajib diisi.',
                'password.confirmed' => 'Konfirmasi password tidak sesuai.',
                'password.min' => 'Password minimal 6 karakter.',
            ]);

            // Buat user
            $user = \App\Models\User::create([
                'name' => $validatedData['name'],
                'email' => $validatedData['email'],
                'password' => Hash::make($validatedData['password']),
            ]);

            // Trigger event Registered (opsional)
            event(new \Illuminate\Auth\Events\Registered($user));

            // Login otomatis + buat token API
            $token = $user->createToken('api_token')->plainTextToken;

            return response()->json([
                'status' => true,
                'message' => 'Registrasi berhasil',
                'token' => $token,
                'user' => $user,
            ], 201);

        } catch (ValidationException $e) {
            // Kirim response JSON khusus untuk error validasi
            return response()->json([
                'status' => false,
                'message' => 'Validasi gagal',
                'errors' => $e->errors(), // array berisi error per field
            ], 422);
        }
    }

    /**
     * Ambil profil user dari token
     */
    public function me(Request $request)
    {
        return response()->json([
            'status' => true,
            'user' => $request->user()
        ]);
    }

    /**
     * Logout dengan menghapus token saat ini
     */
    
    public function logout(Request $request)
    {
        $request->user()->currentAccessToken()->delete();

        return response()->json([
            'status' => true,
            'message' => 'Logout berhasil'
        ]);
    }
}
