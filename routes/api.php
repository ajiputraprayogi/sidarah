<?php

use Illuminate\Support\Facades\Route;
use Illuminate\Support\Facades\RateLimiter;
use Illuminate\Cache\RateLimiting\Limit;
use App\Http\Controllers\Api\AuthApiController;
use App\Http\Controllers\Api\StokDarahController;

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
});
