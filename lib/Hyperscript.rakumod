#! /usr/bin/env false

use v6.d;

unit module Hyperscript;

our $void-tags is export(:void-tags) = set qw[
  area base br col embed hr img input
  link meta param source track wbr
];

sub parse-tag($tag-combo) {
  my $tag = 'div'; my @classes; my $id;
  my @tokens = qw[# .];

  my @split = $tag-combo.split(@tokens, :v, :skip-empty);
  $tag = @split.shift unless @split.first eq any @tokens;

  for @split -> $token, $name {
    if $token eq '#' {
      $id = $name;
    } else {
      @classes.push: $name;
    }
  }

  {:$tag, :$id, :@classes}
}

sub style-attribute(%properties) {
  %properties.sort.map(-> $prop { "$prop.key(): $prop.value()" }).join('; ');
}

sub attr-string ($pair) {
  given $pair.key, $pair.value {
    when 'style', Hash { qq[style="{style-attribute($pair.value)}"] }
    when 'class', List { qq[class="{$pair.value.Set.keys.sort}"] }
    when 'class', Str  { qq[class="{$pair.value.words.Set.keys.sort}"] }
    when $, Bool       { qq[{$pair.key}="{$pair.key}"] if $pair.value }
    default            { qq[{$pair.key}="{$pair.value}"] }
  }
}

class Node {
  has $.tag; has %.attrs; has @.inner;

  submethod TWEAK() {
    my ($tag, $id, $classes) = parse-tag($!tag)<tag id classes>;
    $!tag = $tag;
    %!attrs<class> = $classes if $classes.elems > 0;
    %!attrs<id> = $id with $id;
  }

  method opening-tag {
    join ' ', $.tag, |%.attrs.sort.map: &attr-string
  }

  method Str {
    if $void-tags{$.tag} {
      "<{self.opening-tag}/>"
    } else {
      "<{self.opening-tag}>{@.inner.join('')}</$.tag>"
    }
  }
}

sub hyperscript(Str $tag, %attrs, *@inner) is export {
  Node.new(:$tag, :%attrs, :@inner).Str
}

# vim: ft=perl6 et sw=2
