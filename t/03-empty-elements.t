use v6.d;

use Test;
use Hyperscript :void-tags, :DEFAULT;
constant &h = &hyperscript;

plan 2;

subtest 'non-void elements', {
  subtest 'without attributes', {
    constant $expected = '<div></div>';
    my $result = h('div', {}, []);
    is $result, $expected, 'produces expected HTML';
  }

  subtest 'with attributes', {
    constant $expected = '<div id="123"></div>';
    my $result = h('div', {:123id}, []);
    is $result, $expected, 'produces expected HTML';
  }
}

subtest 'void elements', {
  subtest 'without attributes', {
    my $expects = $void-tags.keys.map: { "<$^tag/>" };
    my $results = $void-tags.keys.map: { h($^tag, {}, []) };
    is $results, $expects, 'produces expected HTML';
  }

  subtest 'with attributes', {
    constant $expected = '<img src="myimg.com/123.png"/>';
    my $result = h('img', { :src<myimg.com/123.png> }, []);
    is $result, $expected, 'produces expected HTML';
  }
}

done-testing;