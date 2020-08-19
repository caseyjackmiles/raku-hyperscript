#! /usr/bin/env false

use v6.d;
use Hyperscript;

unit module Hyperscript::Helpers;

constant @helper-tags = <div p img ol ul li a nav>;

my package EXPORT::DEFAULT {
  for @helper-tags -> $tag {
    OUR::{'&' ~ $tag} = &hyperscript.assuming($tag);
  }
}

# vim: ft=perl6 et sw=2
