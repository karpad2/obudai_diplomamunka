<?php

use Illuminate\Http\Request;
use App\Models\Devices;
use App\Models\Room;
use Illuminate\Support\Facades\Route;
use Illuminate\Support\Facades\Auth;

Route::get('/',function (Request $request){
    return Room::join('cameras','rooms.id','=','cameras.room_id');
});
Route::get('device/add-device',function (Request $request){
         $id=Devices::create(['name'=>'Default','ip_address'=>$request->getClientIp(),'mode'=>'relay','status'=>'0','last_online'=>now(),'room_id'=>1,'password'=>'asdfghjkl'])->id;
         Devices::findOrFail($id)->update(['password'=>md5('salt'.$id.'salt')]);
         return Devices::findOrFail($id);
 });
Route::get('device/status/{device_password}',function ($device_password){
        $device=Devices::where('password',$device_password)->get();
        Devices::findOrFail($device[0]->id)->update(['last_online'=>now()]);
        return $device[0];
 });
 Route::get('device/input/{device_password}/{status}',function ($device_password,$status){
    $device=Devices::where('password',$device_password)->update(['status'=>$status]);
    Devices::findOrFail($device[0]->id)->update(['last_online'=>now()]);
    return $device[0];
});

Route::get('device/rfid/{device_password}/{code}',function ($device_password,$code){
    $device=Devices::where('password',$device_password)->update(['status'=>1]);
    Devices::findOrFail($device[0]->id)->update(['last_online'=>now()]);
    return $device[0];
});

 Route::get('device/store/dev-api/{device_password}/{status}',function ($device_password,$status){
    $device= Devices::where('password',$device_password)->get();
    Devices::findOrFail($device[0]->id)->update(['status'=>'1']);
    return 'ok';
});  

Route::get('device/store/js-api/{id}/{mode}/{status}',function ($id,$mode,$status){
        $device= Devices::findOrFail($id)->get();
        Devices::findOrFail($device[0]->id)->update(['mode'=>$mode,'status'=>$status]);
        return 'ok';
});   


Route::get('device/all',function ($id,$mode,$status){
    return Devices::all();
}); 
 
Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});
