<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Programs extends Model
{
    use HasFactory;
    protected $fillable = [
        'name',
        'active',
        'javascript_block',
        'xml_block',
        'room_id'
    ];
    protected $hidden=[
        
    ];
 
}
