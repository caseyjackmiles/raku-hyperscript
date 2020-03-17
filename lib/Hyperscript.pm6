#! /usr/bin/env false

use v6.d;

unit module Hyperscript;

sub attr-string ($pair) {
  qq[{.key}="{.value}"] with $pair;
}

class Node {
  has $.tag; has %.attrs; has @.children;

  method opening-tag {
    join ' ', $.tag, |%.attrs.pairs.map: &attr-string
  }

  method Str {
    "<{self.opening-tag}>{@.children.join('')}</$.tag>";
  }
}

sub hyperscript(Str $tag, %attrs, *@children) is export {
  Node.new(:$tag, :%attrs, :@children).Str
}

# vim: ft=perl6 et sw=2
