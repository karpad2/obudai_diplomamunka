<?php

use Illuminate\Http\Request;
use App\Models\Devices;
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
Route::get('/',function (Request $request){
    return 'test ok';
});
Route::get('device/add-device',function (Request $request){
         $id=Devices::create(['name'=>'Default','ip_address'=>$request->getClientIp(),'mode'=>'relay','status'=>'0','last_online'=>now(),'room_id'=>1,'password'=>''])->id;
         Devices::findOrFail($id)->update(['password'=>(string)md5('salt'.$id.'salt')]) ;
         return Devices::findOrFail($id);
 });
Route::get('device/status/{device_password}',function ($device_password){
        return Devices::findOrFail($device_password);
 });
Route::get('device/store',function (Request $request){
        return Devices::latest()->orderBy('created_at','desc')->get();
});   

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});
