<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Device extends Model
{
    use HasFactory;
    protected $fillable = [
        'name',
        'mode',
        'status',
        'room_id'
    ];
    protected $hidden=[
        'ip_address',
        'password'
    ];
}
