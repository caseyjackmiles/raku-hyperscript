use v6.d;

use Test;
use Hyperscript;
constant &h = &hyperscript;

plan 6;

subtest 'adds classes', {
  constant $expected = '<p class="abc featured"></p>';
  my $result = h('p.abc.featured', {}, []);
  is $result, $expected, 'adds classes';
}

subtest 'adds id', {
  constant $expected = '<div id="global-error"></div>';
  my $result = h('div#global-error', {}, []);
  is $result, $expected, 'adds id';
}

subtest 'classes and id', {
  constant $expected = '<a class="external" id="doc-link"></a>';
  my $result = h('a.external#doc-link', {}, []);
  is $result, $expected, 'adds classes and ids';
}

subtest 'takes last id given', {
  constant $expected = '<p id="d"></p>';
  my $result = h('p#a#b#c#d', {}, []);
  is $result, $expected, 'last id provided overwrites previous';
}

subtest 'defaults tag to div', {
  constant $expected = '<div class="default"></div>';
  my $result = h('.default', {}, []);
  is $result, $expected, 'defaults tag to div';
}

subtest 'just a tag', {
  constant $expected = '<div></div>';
  my $result = h('div', {}, []);
  is $result, $expected, 'does not add class/id if not present';
}

done-testing;