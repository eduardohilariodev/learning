<?php

declare(strict_types=1);

use Illuminate\Support\Facades\Route;
use Illuminate\Contracts\View\View;

Route::get('/', function (): View {
    return view('welcome');
});


Route::get("/monkeys", function (): View {
    $monkeys = [
        [
            'id' => "1",
            'name' => 'George',
            'skill' => 95
        ],
        [
            'id' => "2",
            'name' => 'Bubbles',
            'skill' => 88
        ],
        [
            'id' => "3",
            'name' => 'Winston',
            'skill' => 92
        ]
    ];
    return view(
        'monkeys.index',
        [
            "greeting" => "hello",
            "monkeys" => $monkeys
        ]
    );
});


Route::get('/monkeys/create', function (): View {
    return view('monkeys.create');
});

// Wildcard route `{id}`
Route::get("/monkeys/{id}", function (string $id): View {
    return view('monkeys.show', ["id" => $id]);
});
