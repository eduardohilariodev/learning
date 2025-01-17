<x-layout>
  <h2>Currently Available Monkeys</h2>

  <ul>
    @foreach ($monkeys as $monkey)
      <li>
        <x-card
          href="/monkeys/{{ $monkey['id'] }}"
          :highlight="$monkey['skill'] > 70"
        >
          <h3>{{ $monkey['name'] }}</h3>
        </x-card>
      </li>
    @endforeach
  </ul>
</x-layout>
