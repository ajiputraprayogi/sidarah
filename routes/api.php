<?php

use Illuminate\Support\Facades\Route;
use Illuminate\Support\Facades\RateLimiter;
use Illuminate\Cache\RateLimiting\Limit;
use App\Http\Controllers\Api\AuthApiController;
use App\Http\Controllers\Api\StokDarahController;
use App\Http\Controllers\Api\PengeluaranDarahController;

RateLimiter::for('api', function ($request) {
    return Limit::perMinute(60)->by(
        optional($request->user())->id ?: $request->ip()
    );
});

// API ROUTES
Route::post('/register', [AuthApiController::class, 'register']);
Route::post('/login', [AuthApiController::class, 'login']);
Route::middleware('auth:sanctum')->group(function () {
    Route::get('/me', [AuthApiController::class, 'me']);
    Route::post('/logout', [AuthApiController::class, 'logout']);

    // Stok Darah Routes
    Route::apiResource('/stok-darah', StokDarahController::class);

    // Pengeluaran Darah (CRUD)
    Route::apiResource('/pengeluaran-darah', PengeluaranDarahController::class);
    Route::get('/pengeluaran-darah-list', [PengeluaranDarahController::class, 'list']);

    // Total Stok per Golongan Darah
    Route::get('/total-stok', [PengeluaranDarahController::class, 'index']);
    Route::get('/chart-stok', [PengeluaranDarahController::class, 'chartStok']);
    Route::get('/chart-pengeluaran', [PengeluaranDarahController::class, 'chartPengeluaran']);
    Route::get('/chart-pemasukan', [PengeluaranDarahController::class, 'chartPemasukan']);
});
