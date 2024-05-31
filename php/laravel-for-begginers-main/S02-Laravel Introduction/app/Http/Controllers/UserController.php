<?php

namespace App\Http\Controllers;

use App\Models\Follow;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use Illuminate\Validation\Rule;
use Intervention\Image\Facades\Image;

class UserController extends Controller
{

    public function register(Request $request)
    {
        $registerFields = $request->validate([
            'username' => ['required', 'min:3', 'max:30', Rule::unique('users', 'username')],
            'email' => ['required', 'email', Rule::unique('users', 'email')],
            'password' => ['required', 'confirmed'],
        ]);
        // Password to hash
        $registerFields['password'] = bcrypt($registerFields['password']);

        // Save to database
        $authenticatedUsed = User::create($registerFields);

        // Login before redirecting
        auth()->login($authenticatedUsed);

        // Confirmation screen
        return redirect('/')->with('success', 'Thank you for registering!');
    }

    public function login(Request $request)
    {
        $loginFields = $request->validate([
            'loginUsername' => 'required',
            'loginPassword' => 'required',
        ]);

        if (auth()->attempt(['username' => $loginFields['loginUsername'], 'password' => $loginFields['loginPassword']])) {
            $request->session()->regenerate();

            return redirect('/')->with('success', 'You\'ve successfully logged in!');
        } else {
            return redirect('/')->with('failure', 'Invalid login :(');
        }
    }

    public function logout()
    {
        auth()->logout();
        return redirect('/')->with('primary', 'You\'ve successfully logged out!');
    }

    /* -------------------------------------------------------------------------- */
    /*                                    Views                                   */
    /* -------------------------------------------------------------------------- */

    public function viewLoggedHomepage()
    {
        if (auth()->check()) {
            return view('homepage-feed');
        } else {
            return view('homepage');
        }
    }

    public function viewProfile(User $user)
    {
        $currentlyFollowing = 0;

        if (auth()->check()) {
            $currentlyFollowing = Follow::where(
                [
                    ['user_id', '=', auth()->user()->id],
                    ['followed_user', '=', $user->id]
                ]
            )
                ->count();
        }

        return view('profile', [
            'avatar' => $user->avatar,
            'currentlyFollowing' => $currentlyFollowing,
            'username' => $user->username,
            'posts' => $user->posts()->latest()->get(),
            'postCount' => $user->posts()->count()
        ]);
    }

    public function viewManageAvatar()
    {
        return view('manage-avatar');
    }

    public function storeAvatar(Request $request)
    {
        $request->validate(['avatar' => 'required|image|max:3000']);

        $user = auth()->user();

        $filename = $user->id . '-' . uniqid() . '.jpg';

        $imgData = Image::make($request->file('avatar'))->fit(120)->encode('jpg');
        Storage::put('public/avatars/' . $filename, $imgData);

        $oldAvatar = $user->avatar;

        $user->avatar = $filename;
        $user->save();

        if ($oldAvatar != '/fallback-avatar.jpg') {
            Storage::delete(
                str_replace(
                    "/storage/",
                    "public/",
                    $oldAvatar
                )
            );
        }

        return back()->with('success', 'Profile picture uploaded!');
    }
}
