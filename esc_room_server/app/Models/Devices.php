<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Devices extends Model
{
    use HasFactory;
    protected $fillable = [
        'name',
        'mode',
        'status',
        'room_id',
        'ip_address',
        'password'
    ];
    protected $hidden=[
        
    ];
}
