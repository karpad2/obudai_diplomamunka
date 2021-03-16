<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::middleware('auth:api')->get('/run', function (Request $request) {
    return $request->user();
});


Route::middleware('auth:api')->get('/run-start', function (Request $request) {
    return $request->user();
});

Route::middleware('auth:api')->get('/run-stop', function (Request $request) {
    return $request->user();
});

Route::middleware('auth:api')->get('/run-lobby', function (Request $request) {
    return $request->user();
});

Route::middleware('auth:api')->get('/device-set', function (Request $request) {
    return $request->user();
});