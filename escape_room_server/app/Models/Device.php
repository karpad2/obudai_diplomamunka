<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Device extends Model
{

    const CREATED_AT = 'creation_date';
    const UPDATED_AT = 'updated_date';
    protected $fillable = [
        'device_id',
        'device_password',
        'device_name'
    ];
    use HasFactory;
}
