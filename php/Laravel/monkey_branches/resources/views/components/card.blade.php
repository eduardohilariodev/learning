@props(['highlight' => false])

<div @class([
    'highlight' => $highlight,
    'card',
])>

  {{ $slot }}

  <a
    class="btn"
    {{ $attributes }}
  >
    View Details
  </a>

</div>
