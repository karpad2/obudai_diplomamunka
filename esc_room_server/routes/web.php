<?php

use Illuminate\Foundation\Application;
use Illuminate\Support\Facades\Route;
use Illuminate\Support\Facades\Auth;
use Inertia\Inertia;
use App\Models\Devices;
use App\Models\Room;

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


Route::get('test',function()
{
    return 'k';

});


Route::get('/', function () {
    return Inertia::render('Welcome', [
        'canLogin' => Route::has('login'),
        'canRegister' => Route::has('register'),
        'laravelVersion' => Application::VERSION
    ]);
});

Route::middleware(['auth:sanctum', 'verified'])->get('/dashboard', function () {
    return Inertia::render('Dashboard');
})->name('dashboard');

Route::middleware(['auth:sanctum', 'verified'])->get('/rooms', function () {
    return Inertia::render('rooms',[]);
})->name('rooms');

Route::middleware(['auth:sanctum', 'verified'])->get('/room/{room_id}', function ($room_id) {
    return Inertia::render('room',[]);
})->name('room');

Route::middleware(['auth:sanctum', 'verified'])->get('/devices', function () {
    return Inertia::render('devices',[]);
})->name('devices');

Route::middleware(['auth:sanctum', 'verified'])->get('/device/{device_id}', function ($device_id) {
    return Inertia::render('device',[]);
})->name('device');

Route::middleware(['auth:sanctum', 'verified'])->get('/programs', function () {
    return Inertia::render('programs',[]);
})->name('programs');

Route::middleware(['auth:sanctum', 'verified'])->get('/program/{program_id}', function ($device_password) {
    return Inertia::render('program',[]);
})->name('program');

Route::middleware(['auth:sanctum', 'verified'])->get('/cameras', function () {
    return Inertia::render('cameras',[]);
})->name('cameras');

Route::middleware(['auth:sanctum', 'verified'])->get('add-user-device/{device_password}',function ($device_password){
    $id=Auth::id();
    Devices::where('password',$device_password)->where('user_id',1)->update(['user_id',$id]);
    return 'ok';
});

Route::middleware(['auth:sanctum', 'verified'])->get('assign-device/{dev_id}/{room_id}',function ($dev_id,$room_id){
    Devices::findorFail($dev_id)->update(['room_id',$room_id]);
    return 'ok';
});

Route::middleware(['auth:sanctum', 'verified'])->get('assign-device/{dev_id}/{room_id}',function ($dev_id,$room_id){
    Devices::findorFail($dev_id)->update(['room_id',$room_id]);
    return 'ok';
});