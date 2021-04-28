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
use App\Models\Run;

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
        'room'=>Room::where('id',$room_id)->get()
    ]);
})->name('room');

Route::middleware(['auth:sanctum', 'verified'])->get('/devices', function () {
    return Inertia::render('devices',[
        'devices'=>Devices::join('rooms','devices.room_id','=','rooms.id')->where(['user_id',Auth::id()])
    ]);
})->name('devices');

Route::middleware(['auth:sanctum', 'verified'])->get('/device/{device_id}', function ($device_id) {
    return Inertia::render('device',[
        'device'=> Devices::findorFail($device_id)
    ]);
})->name('device');

Route::middleware(['auth:sanctum', 'verified'])->get('/programs', function () {
    return Inertia::render('programs',[
        'rooms'=> Room::where('user_id',Auth::id())->get(),
        'programs'=>DB::select('select * from programs join rooms r on programs.room_id = r.id where r.user_id = ?', [Auth::id()])
        //join('rooms','programs.room_id','=','room.id')->where(['user_id',Auth::id()])->

    ]);
})->name('programs');

Route::middleware(['auth:sanctum', 'verified'])->get('/program/{program_id}', function ($program_id) {
    return Inertia::render('program',[
        'program'=>Programs::findorFail($program_id)
    ]);
})->name('program');

Route::middleware(['auth:sanctum', 'verified'])->get('/cameras', function () {
    return Inertia::render('cameras',[
        'cameras'=>Room::join('cameras','rooms.id','=','cameras.room_id')->where('user_id',Auth::id())->get()//->where(['user_id', Auth::id()])
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
    return Programs::where(['program_id',$program_id])->get();
});

Route::middleware(['auth:sanctum', 'verified'])->post('update-program/save/{program_id}',function (Request $request,$program_id){
    Programs::where(['program_id',$program_id])->update(['name'=>$request->name,'active'=>1,'javascript_block'=>$request->javascript_block,'xml_block'=>$request->xml_block]);
    return 'ok';
});
/*End Programs*/

/*Cams*/
Route::middleware(['auth:sanctum', 'verified'])->post('add-camera-room/{room_id}',function (Request $request,$room_id){
    Cameras::create(['name'=>$request->camera_name,'url'=>$request->camera_url,'room_id'=>$room_id]);
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

Route::middleware(['auth:sanctum', 'verified'])->get('run/{room_id}',function ($room_id){
    $room=Room::findorFail($room_id)->get();
    $program=Programs::where([['room_id',$room_id],['active',1]])->get();
    
    $active_run = Run::where([["room_id",$room_id],["finish_time",NULL]])->get();
    if($active_run->isEmpty())
    {
        $active_run=Run::create(["room_id"=>$room_id,"program_id"=>$program->id,"team_id"=>1,"start_time"=>now(),"finish_time"=>null])->get();
    }

    return Inertia::render('run',[
        'room'=>$room,
        'program'=>$program,
        'run'=>$active_run
    ]);

})->name('run');

Route::middleware(['auth:sanctum', 'verified'])->get('run/{room_id}/stop',function ($room_id){
    $room=Room::findorFail($room_id)->get();
    $program=Programs::where([['room_id',$room_id],['active',1]])->get();
    
    $active_run = Run::where([["room_id",$room_id],["finish_time",NULL]])->update(["finish_time",now()]);
    return Inertia::render('run',[
        'room'=>$room,
        'program'=>$program,
        'run'=>$active_run
    ]);

})->name('run');