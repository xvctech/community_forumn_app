<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\controllers\Authcontroller;
use App\Http\controllers\PostController;
use App\Http\controllers\CommentController;
use App\Http\controllers\LikeController;

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
//public routes
Route::post('/register',[Authcontroller::class, 'register']);
Route::post('/login',[Authcontroller::class, 'login']);

//protected routes
Route::group(['middleware' => ['auth:sanctum']], function() {
    //user
    Route::get('/user',[Authcontroller::class, 'user']);
    Route::put('/user',[Authcontroller::class, 'update']);
    Route::post('/logout',[Authcontroller::class, 'logout']);
    //post
    Route::get('/posts',[PostController::class, 'index']); //all post
    Route::post('/posts',[PostController::class, 'store']); //create post
    Route::get('/posts/{id}',[PostController::class, 'show']); //get single post
    Route::put('/posts/{id}',[PostController::class, 'update']); //update post
    Route::delete('/posts/{id}',[PostController::class, 'destroy']); //delete post
    //comment
    Route::get('/posts/{id}/comments',[CommentController::class, 'index']); //all comments
    Route::post('/posts/{id}/comments',[CommentController::class, 'store']); //create a comment
    Route::put('/comments/{id}',[CommentController::class, 'update']); //update a comment
    Route::delete('/comments/{id}/comments',[CommentController::class, 'destroy']);//delete a commment
    //like
    Route::post('/posts/{id}/likes',[LikeController::class, 'likeOrUnlike']); //like or dislike

});

