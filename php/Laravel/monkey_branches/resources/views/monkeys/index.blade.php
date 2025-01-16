<html lang="en">

  <head>
    <meta charset="UTF-8">
    <meta
      name="viewport"
      content="width=device-width, initial-scale=1.0"
    >
    <title>Monkey Branches | Home</title>
  </head>

  <body>
    <h2>Currently Available Monkeys</h2>

    <p>{{ $greeting }}</p>

    <ul>
      <li>
        <a href="/monkeys/{{ $monkeys[0]["id"] }}">
          {{ $monkeys[0]["name"] }}
        </a>
      </li>
      <li>
        <a href="/monkeys/{{ $monkeys[1]["id"] }}">
          {{ $monkeys[1]["name"] }}
        </a>
      </li>
    </ul>
  </body>

</html>
