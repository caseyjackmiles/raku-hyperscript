#! /usr/bin/env false

use v6.d;

unit module Hyperscript;

class Node {
  has $.tag; has %.attrs; has @.children; has $.inner;
  method Str {
    "<$.tag>{$.inner}</$.tag>";
  }
}

sub hyperscript($tag, %attrs, Str $inner) is export {
  Node.new(:$tag, :%attrs, :$inner).Str
}

# vim: ft=perl6 et sw=2
