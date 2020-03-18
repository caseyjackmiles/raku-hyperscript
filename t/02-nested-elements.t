use v6.d;

use Test;
use Hyperscript;
constant &h = &hyperscript;

plan 3;

subtest 'single nested child', {
  constant $expected = '<p><em>emphasis</em></p>';
  my $result = h('p', {}, [
    h('em', {}, 'emphasis')
  ]);

  is $result, $expected, 'produces children';
}

subtest 'multiple nested children', {
  constant $expected = '<p>Get out of bed <em>now</em>!</p>';
  my $result = h('p', {}, [
    'Get out of bed ',
    h('em', {}, 'now'),
    '!'
  ]);

  is $result, $expected, 'produces multiple children';
}

subtest 'multiple levels of nesting', {
  constant $expected = q:to/END/.chomp;
    <p>Mass-energy equivalence formula: <var>E</var>=<var>m</var><var>c</var><sup>2</sup>.</p>
    END

  my $result = h('p', {}, [
    'Mass-energy equivalence formula: ',
    h('var', {}, 'E'),
    '=',
    h('var', {}, 'm'),
    h('var', {}, 'c'),
    h('sup', {}, '2'),
    '.'
  ]);

  is $result, $expected, 'produces nested children';
}

done-testing;
