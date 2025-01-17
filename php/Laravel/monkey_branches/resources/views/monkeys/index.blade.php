<x-layout>

  <h2>Currently Available Monkeys</h2>

  <p>{{ $greeting }}</p>

  @if ($greeting == "hello")
    <p>Hi from if</p>
  @endif

  <ul>
    @foreach ($monkeys as $monkey)
      <li>
        <p>{{ $monkey["name"] }}</p>
        <a href="/monkeys/{{ $monkey["id"] }}">
          View Details
        </a>
      </li>
    @endforeach
  </ul>
</x-layout>
