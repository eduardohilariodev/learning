<x-layout>
    <div class="container py-md-5 container--narrow">
        <h2>
            <img class="avatar-small" src="{{ $avatar }}" alt />

            {{ $username }}

            @auth
                @if (!$currentlyFollowing and auth()->user()->id != $username)
                    <form class="ml-2 d-inline" action="/create-follow/{{ $username }}" method="POST">
                        @csrf
                        <button class="btn btn-primary btn-sm">Follow <i class="fas fa-user-plus"></i></button>
                    </form>
                @endif

                @if ($currentlyFollowing)
                    <form class="ml-2 d-inline" action="/remove-follow/{{ $username }}" method="POST">
                        @csrf
                        <button class="btn btn-danger btn-sm">Stop Following <i class="fas fa-user-times"></i></button>
                    </form>
                @endif

                @if (auth()->user()->username == $username)
                    <a href="/manage-avatar" class="btn btn-secondary btn-sm">Manage avatar</a>
                @endif
            @endauth
        </h2>

        <div class="profile-nav nav nav-tabs pt-2 mb-4">
            <a href="#" class="profile-nav-link nav-item nav-link active">Posts: {{ $postCount }}</a>
            <a href="#" class="profile-nav-link nav-item nav-link">Followers: 3</a>
            <a href="#" class="profile-nav-link nav-item nav-link">Following: 2</a>
        </div>

        <div class="list-group">
            @foreach ($posts as $post)
                <a href="/post/{{ $post->id }}" class="list-group-item list-group-item-action">
                    <img class="avatar-tiny" src="https://gravatar.com/avatar/b9408a09298632b5151200f3449434ef?s=128" />
                    <strong>{{ $post->title }}</strong> on {{ $post->created_at->format('d/m/y') }}
                </a>
            @endforeach
        </div>
    </div>
</x-layout>
