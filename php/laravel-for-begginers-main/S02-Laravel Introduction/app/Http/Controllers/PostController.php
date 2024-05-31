<?php

namespace App\Http\Controllers;

use App\Models\Post;
use Illuminate\Http\Request;
use Illuminate\Support\Str;

class PostController extends Controller
{
    /* -------------------------------------------------------------------------- */
    /*                                   Actions                                  */
    /* -------------------------------------------------------------------------- */

    public function updatePost(Post $post, Request $request)
    {
        $incomingFields = $request->validate(['title' => 'required', 'body' => 'required']);
        $incomingFields['title'] = strip_tags($incomingFields['title']);
        $incomingFields['body'] = strip_tags($incomingFields['body']);

        $post->update($incomingFields);

        return back()->with('primary', 'Post succesfully updated!');
    }


    public function storeNewPost(Request $request)
    {
        $incomingFields = $request->validate([
            'title' => 'required',
            'body' => 'required',
        ]);

        $incomingFields['title'] = strip_tags($incomingFields['title']);
        $incomingFields['body'] = strip_tags($incomingFields['body']);
        $incomingFields['user_id'] = auth()->id();

        $newPost = Post::create($incomingFields);

        return redirect("/post/{$newPost->id}")->with('success', 'New post succesfully created!');
    }

    public function deletePost(Post $post)
    {
        $post->delete();
        return redirect('/profile/' . auth()->user()->username)->with('success', 'Post deleted!');
    }

    /* -------------------------------------------------------------------------- */
    /*                                 View files                                 */
    /* -------------------------------------------------------------------------- */

    public function viewCreatePost()
    {
        return view('create-post');
    }
    public function viewSinglePost(Post $post)
    {
        $post['body'] = Str::markdown($post->body);
        return view('single-post', ['post' => $post]);
    }

    public function viewUpdatePost(Post $post)
    {
        return view('update-post', ['post' => $post]);
    }


}
