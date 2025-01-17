<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">

  <head>
    <meta charset="UTF-8">
    <meta
      name="viewport"
      content="width=device-width, initial-scale=1.0"
    >
    <title>Monkey Branches</title>

    @vite('resources/css/app.css')
  </head>

  <body class='px-8 py-12 text-center'>
    <h1>Welcome to the Monkey Branches</h1>

    <p>Click the button below to view the list of monkeys</p>
    <a
      class="btn mt-4 inline-block"
      href="/monkeys"
    >Find Monkeys</a>
  </body>

</html>
