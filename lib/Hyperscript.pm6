#! /usr/bin/env false

use v6.d;

unit module Hyperscript;

sub attr-string ($pair) {
  qq[{.key}="{.value}"] with $pair;
}

class Node {
  has $.tag; has %.attrs; has @.children; has $.inner;

  method opening-tag {
    if %.attrs {
      join ' ', $.tag, |%.attrs.pairs.map: &attr-string
    } else {
      $.tag
    }
  }

  method Str {
    "<{self.opening-tag}>{$.inner}</$.tag>";
  }
}

sub hyperscript($tag, %attrs, Str $inner) is export {
  Node.new(:$tag, :%attrs, :$inner).Str
}

# vim: ft=perl6 et sw=2
