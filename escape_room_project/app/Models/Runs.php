<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Runs extends Model
{
    use HasFactory;
    protected $fillable=['team_id','program_id','start_time'];
}