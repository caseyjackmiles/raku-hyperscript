#! /usr/bin/env false

use v6.d;

unit module Hyperscript;

class Node {
  has $.tag; has %.attrs; has @.inner;

  submethod TWEAK() {
    my ($t, $i, $c) = decompose($!tag)<tag id classes>;
    $!tag = $t;
    %!attrs<class> = $c if $c.elems > 0;
    %!attrs<id> = $i with $i;
  }

  method Str {
    walk(self, output-style);
  }
}

sub hyperscript(Str $tag, *%attrs, *@inner) is export {
  Node.new(:$tag, :%attrs, :@inner).Str
}

our $void-tags is export(:void-tags) = set qw[
  area base br col embed hr img input
  link meta param source track wbr
];

subset VoidNode of Node where { $void-tags{$_.tag} };

enum Style <Condensed Pretty>;

sub output-style(--> Style) {
  $*hyperscript-style // Condensed;
}

sub decompose($shorthand) {
  my $tag = 'div', my $classes = []; my $id;
  my @tokens = qw[# .];

  my @parts = $shorthand.split(@tokens, :v:skip-empty);
  $tag = @parts.shift unless @parts.first eq any @tokens;

  for @parts -> $token, $name {
    $token eq '#' ?? ($id = $name) !! $classes.push($name);
  }

  { :$tag, :$classes, :$id }
}

multi sub walk(Node $node, Pretty, $indent = 0) {
  my $opening = ' ' x $indent ~ "<{opening-tag($node)}>";
  my $closing = ' ' x $indent ~ "</$node.tag()>";
  my @children = $node.inner.map: -> $child { walk($child, Pretty, $indent + 2) };

  join "\n", $opening, @children, $closing
}

multi sub walk(VoidNode $node, Pretty, $indent = 0) {
  ' ' x $indent ~ "<{opening-tag($node)} />"
}

multi sub walk(Str $node, Pretty, $indent = 0) {
  join "\n", $node.lines.map({ ' ' x $indent ~ $^line })
}

multi sub walk($node, Pretty, $indent = 0) {
  ' ' x $indent ~ $node
}

multi sub walk(Node $node, Condensed) {
  "<{opening-tag($node)}>{$node.inner.join('')}</$node.tag()>"
}

multi sub walk(VoidNode $node, Condensed) { "<{opening-tag($node)} />" }

multi sub walk($node, Condensed) { $node.Str }

sub opening-tag(Node $node) {
  join ' ', $node.tag, $node.attrs.sort.map: &attr-string
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

sub style-attribute(%properties) {
  join '; ', %properties.sort.map(-> $prop { "$prop.key(): $prop.value()" });
}

# vim: ft=perl6 et sw=2
