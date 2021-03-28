<?php

use Illuminate\Foundation\Application;
use Illuminate\Support\Facades\Route;
use Inertia\Inertia;
use App\Http\Controllers\DevicesController;
use App\Http\Controllers\CamerasController;
use App\Http\Controllers\EteamsController;
use App\Http\Controllers\ProgramsController;
use App\Http\Controllers\RoomController;


/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/', function () {
    return Inertia::render('Welcome', [
        'canLogin' => Route::has('login'),
        'canRegister' => Route::has('register'),
        'laravelVersion' => Application::VERSION,
        'phpVersion' => PHP_VERSION,
    ]);
});

Route::middleware(['auth:sanctum', 'verified'])->get('/dashboard', function () {
    return Inertia::render('Dashboard');
})->name('dashboard');

Route::middleware(['auth:sanctum', 'verified'])->get('/rooms', function () {
    return Inertia::render('rooms');
})->name('rooms');
Route::middleware(['auth:sanctum', 'verified'])->get('/devices', function () {
    return Inertia::render('devices');
})->name('devices');

Route::middleware(['auth:sanctum', 'verified'])->get('/programs', function () {
    return Inertia::render('programs');
})->name('programs');

Route::middleware(['auth:sanctum', 'verified'])->get('/cameras', function () {
    return Inertia::render('cameras');
})->name('cameras');
/*
Route::resource('rooms', RoomController::class);
Route::resource('devices', DevicesController::class);
Route::resource('teams', ETeamsController::class);
Route::resource('cameras', CamerasController::class);
Route::resource('programs', ProgramsController::class);*/