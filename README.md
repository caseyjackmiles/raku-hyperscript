# hyperscript

Create hypertext with Raku.

## api

```raku
sub hyperscript(Str $tag, *%attrs, *@inner)
```

* `Str $tag`: 
  * The HTML tag to be created.
  * Supports class and id shortcuts, e.g.: `'p#id.class'`.
  * if `$tag` begins with a class or id shortcut, hyperscript uses a `div` element.
* `*%attrs`: HTML attributes on the element.
* `*@inner`: Inner contents for the element.

## example

```raku
use Hyperscript;
constant &h = &hyperscript;

say h('h1', 'hello, world!');
# OUTPUT: <h1>hello, world!</h1>
```

## slightly longer example

```raku
use Hyperscript;
constant &h = &hyperscript;

my $html =
h('div#page',
  h('div#header',
    h('h1.classy', style => { background-color => '#22f'}, 'h')),
  h('div#menu', style => { background-color => '#2f2' },
    h('ul',
      h('li', 'one'),
      h('li', 'two'),
      h('li', 'three'))),
  h('h2', style => { background-color => '#f22' }, 'content title'),
  h('p',
    "so it's just like a templating engine, ",
    "but easy to use inline with Raku"),
  h('p',
    "the intention is for this to be used to create ",
    "reusable, interactive html widgets."));
```

## helpers for common tags

`Hyperscript::Helpers` module provides simple helpers for common tags: div, p, img, ol, ul, li, a, nav.

```raku
use Hyperscript::Helpers;

my $nav =
div(:class<main text-center text-gray>,
  p(:class<text-large>, 'Main Menu'),
  nav(
    ul(
      li(a(:href</>, 'Home')),
      li(a(:href</blog>:active, 'News')),
      li(a(:href</contact>, 'Contact'))
    )
  )
);
```

## why?

* It produces HTML from Raku code, instead of a separate templating language.
* It's a way to learn Raku module development.

## prior art

* Hyperscript (JavaScript library): https://github.com/hyperhype/hyperscript

## testing

```sh
prove6 -l
```

## license

MIT
