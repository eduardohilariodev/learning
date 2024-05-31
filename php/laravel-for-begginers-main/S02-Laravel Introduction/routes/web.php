<?php

use App\Http\Controllers\FollowController;
use App\Http\Controllers\PostController;
use App\Http\Controllers\UserController;
use Illuminate\Support\Facades\Route;



Route::get('/admins-only', function () {
  return 'You\'re an admin!';
})->middleware('can:visitAdminPages');


/* --------------------------- User authentication -------------------------- */
Route::get('/', [UserController::class, "viewLoggedHomepage"])->name('login');
Route::post('/register', [UserController::class, 'register'])->middleware('guest');
Route::post('/login', [UserController::class, 'login'])->middleware('guest');
Route::post('/logout', [UserController::class, 'logout'])->middleware('mustBeLoggedIn');
Route::get('/manage-avatar', [UserController::class, 'viewManageAvatar'])->middleware('mustBeLoggedIn');
Route::post('/manage-avatar', [UserController::class, 'storeAvatar'])->middleware('mustBeLoggedIn');


/* --------------------------------- Follow --------------------------------- */
Route::post('/create-follow/{user:username}', [FollowController::class, 'createFollow'])->middleware('mustBeLoggedIn');
Route::post('/remove-follow/{user:username}', [FollowController::class, 'removeFollow'])->middleware('mustBeLoggedIn');


/* ------------------------------ Blog posting ------------------------------ */
Route::get('/create-post', [PostController::class, 'viewCreatePost'])->middleware('mustBeLoggedIn');
Route::post('/create-post', [PostController::class, 'storeNewPost'])->middleware('mustBeLoggedIn');

const POST_ID = '/post/{post}';

Route::get(POST_ID, [PostController::class, 'viewSinglePost']);
Route::get(POST_ID . '/edit', [PostController::class, 'viewUpdatePost'])->middleware('can:update,post');
Route::delete(POST_ID, [PostController::class, 'deletePost'])->middleware('can:delete,post');
Route::put(POST_ID, [PostController::class, 'updatePost'])->middleware('can:update,post');

/* --------------------------------- Profile -------------------------------- */
Route::get('/profile/{user:username}', [UserController::class, 'viewProfile']);
