# hyperscript

Create hypertext with Raku.

This project is still in development.

## example

```raku
use Hyperscript;
constant &h = &hyperscript;

say h('h1', {}, 'hello, world!');
# OUTPUT: <h1>hello, world!</h1>
```

## why?

* It produces HTML from Raku code, instead of a separate templating language.
* It's a way to learn Raku module development.

## prior art

* Hyperscript (JavaScript library): https://github.com/hyperhype/hyperscript

## testing

```sh
prove6 -l t/
```

## license

MIT
