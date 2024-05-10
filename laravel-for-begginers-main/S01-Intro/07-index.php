<?php

// $catName = 'Fluffy';
// echo "I really love my cat $catName and that's why I am learning PHP!";

/* -------------------------------------------------------------------------- */

function doubleNumber($number)
{
  return $number * 2;
}


function tripleNumber($number)
{
  return $number * 3;

}

$threeHundred = tripleNumber(doubleNumber(50));

if ($threeHundred > 200) {
  echo 'Number is large indeed, tiger ;-)';
} else {
  echo 'Sorry big boy, try again';
}

echo 'Hello world';
/* -------------------------------------------------------------------------- */
