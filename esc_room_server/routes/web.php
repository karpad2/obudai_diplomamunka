<?php

use Illuminate\Foundation\Application;
use Illuminate\Http\Request;
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
use App\Models\Cameras;
use App\Models\ETeams;
use App\Models\Programs;

//use GuzzleHttp\Psr7\Request;

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

$id=Auth::id();
/*Tests*/
Route::get('test',function()
{
    return 'k';

});
/*End Tests*/

/*Inertia pages*/
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
    return Inertia::render('rooms',[
     'rooms'=> Room::where('user_id',Auth::id())->get()   
    ]);
})->name('rooms');

Route::middleware(['auth:sanctum', 'verified'])->get('/room/{room_id}', function ($room_id) {
    return Inertia::render('room',[
        'room'=>Room::findorFail($room_id)
    ]);
})->name('room');

Route::middleware(['auth:sanctum', 'verified'])->get('/devices', function () {
    return Inertia::render('devices',[
        'devices'=>Devices::where(['user_id',Auth::id()])
    ]);
})->name('devices');

Route::middleware(['auth:sanctum', 'verified'])->get('/device/{device_id}', function ($device_id) {
    return Inertia::render('device',[
        'device'=> Devices::findorFail($device_id)
    ]);
})->name('device');

Route::middleware(['auth:sanctum', 'verified'])->get('/programs', function () {
    return Inertia::render('programs',[
        'programs'=>Programs::where(['user_id',Auth::id()])
    ]);
})->name('programs');

Route::middleware(['auth:sanctum', 'verified'])->get('/program/{program_id}', function ($program_id) {
    return Inertia::render('program',[
        'program'=>Programs::findorFail($program_id)
    ]);
})->name('program');

Route::middleware(['auth:sanctum', 'verified'])->get('/cameras', function () {
    return Inertia::render('cameras',[
        'cameras'=>Cameras::where(['user_id',Auth::id()])
    ]);
})->name('cameras');

Route::middleware(['auth:sanctum', 'verified'])->get('/rteams', function () {
    return Inertia::render('teams',[
        'teams'=>ETeams::all()
    ]);
})->name('teams');
/*End Inertia pages*/

/* Devices*/
Route::middleware(['auth:sanctum', 'verified'])->post('add-user-device',function (Request $request){
    $id=Auth::id();
    Devices::where('password',$request->device_id)->where('user_id',1)->update(['user_id',$id]);
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
/*End Devices*/
/*Rooms*/
Route::middleware(['auth:sanctum', 'verified'])->post('create-room',function (Request $request){
    Room::create(["name"=>$request->name,"user_id"=>Auth::id()]);
    return 'ok';
});

Route::middleware(['auth:sanctum', 'verified'])->post('update-room',function (Request $request,$room_id){
    
    Room::create(["name"=>$request->name,"user_id"=>Auth::id()]);
    return 'ok';
});
/*End programs*/

/*Programs*/
Route::middleware(['auth:sanctum', 'verified'])->post('create-program/{room_id}',function (Request $request,$room_id){
    Programs::where(['room_id',$room_id])->update(['active'=>0]);
    Programs::create(['name'=>$request->name,'active'=>1,'javascript_block'=>$request->javascript_block,'xml_block'=>$request->xml_block,'room_id'=>$room_id]);
    return 'ok';
});

Route::middleware(['auth:sanctum', 'verified'])->post('update-program/{program_id}',function (Request $request,$program_id){
    Programs::where(['program_id',$program_id])->update(['name'=>$request->name,'active'=>1,'javascript_block'=>$request->javascript_block,'xml_block'=>$request->xml_block]);
    return 'ok';
});
/*End Programs*/

/*Cams*/
Route::middleware(['auth:sanctum', 'verified'])->post('create-cam/{room_id}',function (Request $request,$room_id){
    Cameras::create(['name'=>$request->name,'url'=>$request->camera_url,'room_id'=>$room_id]);
    return 'ok';
});
Route::middleware(['auth:sanctum', 'verified'])->post('update-cam/{camera_id}',function (Request $request,$camera_id){
    Cameras::findorFail($camera_id)->update(['name'=>$request->name,'url'=>$request->camera_url]);
    return 'ok';
});

/*End Cams*/

/*Teams*/
Route::middleware(['auth:sanctum', 'verified'])->get('create-rteam',function (Request $request){
    ETeams::create(['name'=>$request->name]);
    return 'ok';
});
Route::middleware(['auth:sanctum', 'verified'])->post('update-rteams/{teams_id}',function (Request $request,$teams_id){
    Cameras::findorFail($teams_id)->update(['name'=>$request->name]);
    return 'ok';
});

/*End Teams*/