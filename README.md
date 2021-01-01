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

## 'pretty' output

By default, hyperscript outputs a condensed string of HTML. Sometimes it may be useful to have
a string representation that more closely reflects the nesting structure of your HTML. 'Pretty' output
can be enabled when needed by setting the `$*hyperscript-style` dynamic variable.

Running this Raku code:
```raku
use Hyperscript;
my &h = &hyperscript;

my @items = do for 1..3 {
  h('li.condensed', h('a.condensed', :href("page$_.html"), h('b.condensed', "Page $_")))
}

my $site-nav = do {
  my $*hyperscript-style = Hyperscript::Style::Pretty; # Enable pretty output
  h('nav.pretty', h('ul.pretty', @items))
}

say $site-nav;
```
Will provide the following HTML:

```html
<nav class="pretty">
  <ul class="pretty">
    <li class="condensed"><a class="condensed" href="page1.html"><b class="condensed">Page 1</b></a></li>
    <li class="condensed"><a class="condensed" href="page2.html"><b class="condensed">Page 2</b></a></li>
    <li class="condensed"><a class="condensed" href="page3.html"><b class="condensed">Page 3</b></a></li>
  </ul>
</nav>
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
