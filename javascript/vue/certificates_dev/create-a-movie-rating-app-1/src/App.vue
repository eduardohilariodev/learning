<script setup>
import { items } from "./movies.json";
/*
 This is an Icon that you can use to represent the stars if you like
 otherwise you could just use a simple ⭐️ emoji, or * character.
*/
import { StarIcon } from "@heroicons/vue/24/solid";
</script>

<template>
  <div class="flex items-center h-screen w-screen gap-5 px-24">
    <li
      v-for="item in items"
      :key="item.id"
      class="flex gap-3 max-h-[60%]"
    >
      <ul class="bg-white rounded-md grid grid-rows-2">
        <img
          class="size-full object-cover"
          :src="item.image"
          :alt="item.description"
        />
        <article class="p-5 flex flex-col">
          <p class="text-3xl font-semibold">{{ item.name }}</p>
          <div class="flex gap-1">
            <div
              v-for="genre in item.genres"
              class="rounded-full px-2 py-0.5 font-semibold text-sm text-white w-min bg-indigo-500"
            >
              {{ genre }}
            </div>
          </div>
          <p class="grow">{{ item.description }}</p>
          <p class="flex items-center">
            <span class="mr-3">Rating: ({{ item.rating }}/5)</span>
            <StarIcon
              class="text-yellow-500 h-5"
              v-for="star in item.rating"
            />
          </p>
        </article>
      </ul>
    </li>
  </div>
</template>
