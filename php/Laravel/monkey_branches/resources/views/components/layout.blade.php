<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">

  <head>
    <meta charset="UTF-8">
    <meta
      name="viewport"
      content="width=device-width, initial-scale=1.0"
    >
    <title>Monkey Branches</title>
  </head>

  <body>

    <header>
      <nav>
        <h1>Monkey Branches</h1>
        <a href="/monkeys">All Monkeys</a>
        <a href="/monkeys/create">Create New Monkey</a>
      </nav>
    </header>

    <main class="container">

      {{ $slot }}

    </main>

  </body>

</html>
