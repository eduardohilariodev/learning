<?php

require __DIR__ . '/vendor/autoload.php';
use Cocur\Slugify\Slugify;

$slugify = new Slugify();

echo $slugify->slugify("The cat is really fluffy.");
