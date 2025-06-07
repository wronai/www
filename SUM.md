# Combined READMEs\n

## ./node_modules/accepts

# accepts

[![NPM Version][npm-version-image]][npm-url]
[![NPM Downloads][npm-downloads-image]][npm-url]
[![Node.js Version][node-version-image]][node-version-url]
[![Build Status][github-actions-ci-image]][github-actions-ci-url]
[![Test Coverage][coveralls-image]][coveralls-url]

Higher level content negotiation based on [negotiator](https://www.npmjs.com/package/negotiator).
Extracted from [koa](https://www.npmjs.com/package/koa) for general use.

In addition to negotiator, it allows:

- Allows types as an array or arguments list, ie `(['text/html', 'application/json'])`
  as well as `('text/html', 'application/json')`.
- Allows type shorthands such as `json`.
- Returns `false` when no types match
- Treats non-existent headers as `*`

## Installation

This is a [Node.js](https://nodejs.org/en/) module available through the
[npm registry](https://www.npmjs.com/). Installation is done using the
[`npm install` command](https://docs.npmjs.com/getting-started/installing-npm-packages-locally):

```sh
$ npm install accepts
```

## API

```js
var accepts = require('accepts')
```

### accepts(req)

Create a new `Accepts` object for the given `req`.

#### .charset(charsets)

Return the first accepted charset. If nothing in `charsets` is accepted,
then `false` is returned.

#### .charsets()

Return the charsets that the request accepts, in the order of the client's
preference (most preferred first).

#### .encoding(encodings)

Return the first accepted encoding. If nothing in `encodings` is accepted,
then `false` is returned.

#### .encodings()

Return the encodings that the request accepts, in the order of the client's
preference (most preferred first).

#### .language(languages)

Return the first accepted language. If nothing in `languages` is accepted,
then `false` is returned.

#### .languages()

Return the languages that the request accepts, in the order of the client's
preference (most preferred first).

#### .type(types)

Return the first accepted type (and it is returned as the same text as what
appears in the `types` array). If nothing in `types` is accepted, then `false`
is returned.

The `types` array can contain full MIME types or file extensions. Any value
that is not a full MIME types is passed to `require('mime-types').lookup`.

#### .types()

Return the types that the request accepts, in the order of the client's
preference (most preferred first).

## Examples

### Simple type negotiation

This simple example shows how to use `accepts` to return a different typed
respond body based on what the client wants to accept. The server lists it's
preferences in order and will get back the best match between the client and
server.

```js
var accepts = require('accepts')
var http = require('http')

function app (req, res) {
  var accept = accepts(req)

  // the order of this list is significant; should be server preferred order
  switch (accept.type(['json', 'html'])) {
    case 'json':
      res.setHeader('Content-Type', 'application/json')
      res.write('{"hello":"world!"}')
      break
    case 'html':
      res.setHeader('Content-Type', 'text/html')
      res.write('<b>hello, world!</b>')
      break
    default:
      // the fallback is text/plain, so no need to specify it above
      res.setHeader('Content-Type', 'text/plain')
      res.write('hello, world!')
      break
  }

  res.end()
}

http.createServer(app).listen(3000)
```

You can test this out with the cURL program:
```sh
curl -I -H'Accept: text/html' http://localhost:3000/
```

## License

[MIT](LICENSE)

[coveralls-image]: https://badgen.net/coveralls/c/github/jshttp/accepts/master
[coveralls-url]: https://coveralls.io/r/jshttp/accepts?branch=master
[github-actions-ci-image]: https://badgen.net/github/checks/jshttp/accepts/master?label=ci
[github-actions-ci-url]: https://github.com/jshttp/accepts/actions/workflows/ci.yml
[node-version-image]: https://badgen.net/npm/node/accepts
[node-version-url]: https://nodejs.org/en/download
[npm-downloads-image]: https://badgen.net/npm/dm/accepts
[npm-url]: https://npmjs.org/package/accepts
[npm-version-image]: https://badgen.net/npm/v/accepts

## ./node_modules/ajv

<img align="right" alt="Ajv logo" width="160" src="https://ajv.js.org/img/ajv.svg">

&nbsp;

# Ajv JSON schema validator

The fastest JSON validator for Node.js and browser.

Supports JSON Schema draft-04/06/07/2019-09/2020-12 ([draft-04 support](https://ajv.js.org/json-schema.html#draft-04) requires ajv-draft-04 package) and JSON Type Definition [RFC8927](https://datatracker.ietf.org/doc/rfc8927/).

[![build](https://github.com/ajv-validator/ajv/workflows/build/badge.svg)](https://github.com/ajv-validator/ajv/actions?query=workflow%3Abuild)
[![npm](https://img.shields.io/npm/v/ajv.svg)](https://www.npmjs.com/package/ajv)
[![npm downloads](https://img.shields.io/npm/dm/ajv.svg)](https://www.npmjs.com/package/ajv)
[![Coverage Status](https://coveralls.io/repos/github/ajv-validator/ajv/badge.svg?branch=master)](https://coveralls.io/github/ajv-validator/ajv?branch=master)
[![SimpleX](https://img.shields.io/badge/chat-on%20SimpleX-%2307b4b9)](https://simplex.chat/contact#/?v=1-2&smp=smp%3A%2F%2Fu2dS9sG8nMNURyZwqASV4yROM28Er0luVTx5X1CsMrU%3D%40smp4.simplex.im%2FV-6t4hoy_SsvKMi9KekdGX-VKQOhDeAe%23%2F%3Fv%3D1-2%26dh%3DMCowBQYDK2VuAyEAm98gjwvrAEiiz_YgBoaQB9dtKTl5Om1pborUyevQwzg%253D%26srv%3Do5vmywmrnaxalvz6wi3zicyftgio6psuvyniis6gco6bp6ekl4cqj4id.onion&data=%7B%22type%22%3A%22group%22%2C%22groupLinkId%22%3A%22wYrTFafovkymjUtc2vUjCQ%3D%3D%22%7D)
[![Gitter](https://img.shields.io/gitter/room/ajv-validator/ajv.svg)](https://gitter.im/ajv-validator/ajv)
[![GitHub Sponsors](https://img.shields.io/badge/$-sponsors-brightgreen)](https://github.com/sponsors/epoberezkin)

## Ajv sponsors

[<img src="https://ajv.js.org/img/mozilla.svg" width="45%" alt="Mozilla">](https://www.mozilla.org)<img src="https://ajv.js.org/img/gap.svg" width="9%">[<img src="https://ajv.js.org/img/reserved.svg" width="45%">](https://opencollective.com/ajv)

[<img src="https://ajv.js.org/img/microsoft.png" width="31%" alt="Microsoft">](https://opensource.microsoft.com)<img src="https://ajv.js.org/img/gap.svg" width="3%">[<img src="https://ajv.js.org/img/reserved.svg" width="31%">](https://opencollective.com/ajv)<img src="https://ajv.js.org/img/gap.svg" width="3%">[<img src="https://ajv.js.org/img/reserved.svg" width="31%">](https://opencollective.com/ajv)

[<img src="https://ajv.js.org/img/retool.svg" width="22.5%" alt="Retool">](https://retool.com/?utm_source=sponsor&utm_campaign=ajv)<img src="https://ajv.js.org/img/gap.svg" width="3%">[<img src="https://ajv.js.org/img/tidelift.svg" width="22.5%" alt="Tidelift">](https://tidelift.com/subscription/pkg/npm-ajv?utm_source=npm-ajv&utm_medium=referral&utm_campaign=enterprise)<img src="https://ajv.js.org/img/gap.svg" width="3%">[<img src="https://ajv.js.org/img/simplex.svg" width="22.5%" alt="SimpleX">](https://github.com/simplex-chat/simplex-chat)<img src="https://ajv.js.org/img/gap.svg" width="3%">[<img src="https://ajv.js.org/img/reserved.svg" width="22.5%">](https://opencollective.com/ajv)

## Contributing

More than 100 people contributed to Ajv, and we would love to have you join the development. We welcome implementing new features that will benefit many users and ideas to improve our documentation.

Please review [Contributing guidelines](./CONTRIBUTING.md) and [Code components](https://ajv.js.org/components.html).

## Documentation

All documentation is available on the [Ajv website](https://ajv.js.org).

Some useful site links:

- [Getting started](https://ajv.js.org/guide/getting-started.html)
- [JSON Schema vs JSON Type Definition](https://ajv.js.org/guide/schema-language.html)
- [API reference](https://ajv.js.org/api.html)
- [Strict mode](https://ajv.js.org/strict-mode.html)
- [Standalone validation code](https://ajv.js.org/standalone.html)
- [Security considerations](https://ajv.js.org/security.html)
- [Command line interface](https://ajv.js.org/packages/ajv-cli.html)
- [Frequently Asked Questions](https://ajv.js.org/faq.html)

## <a name="sponsors"></a>Please [sponsor Ajv development](https://github.com/sponsors/epoberezkin)

Since I asked to support Ajv development 40 people and 6 organizations contributed via GitHub and OpenCollective - this support helped receiving the MOSS grant!

Your continuing support is very important - the funds will be used to develop and maintain Ajv once the next major version is released.

Please sponsor Ajv via:

- [GitHub sponsors page](https://github.com/sponsors/epoberezkin) (GitHub will match it)
- [Ajv Open Collective](https://opencollective.com/ajv)

Thank you.

#### Open Collective sponsors

<a href="https://opencollective.com/ajv"><img src="https://opencollective.com/ajv/individuals.svg?width=890"></a>

<a href="https://opencollective.com/ajv/organization/0/website"><img src="https://opencollective.com/ajv/organization/0/avatar.svg"></a>
<a href="https://opencollective.com/ajv/organization/1/website"><img src="https://opencollective.com/ajv/organization/1/avatar.svg"></a>
<a href="https://opencollective.com/ajv/organization/2/website"><img src="https://opencollective.com/ajv/organization/2/avatar.svg"></a>
<a href="https://opencollective.com/ajv/organization/3/website"><img src="https://opencollective.com/ajv/organization/3/avatar.svg"></a>
<a href="https://opencollective.com/ajv/organization/4/website"><img src="https://opencollective.com/ajv/organization/4/avatar.svg"></a>
<a href="https://opencollective.com/ajv/organization/5/website"><img src="https://opencollective.com/ajv/organization/5/avatar.svg"></a>
<a href="https://opencollective.com/ajv/organization/6/website"><img src="https://opencollective.com/ajv/organization/6/avatar.svg"></a>
<a href="https://opencollective.com/ajv/organization/7/website"><img src="https://opencollective.com/ajv/organization/7/avatar.svg"></a>
<a href="https://opencollective.com/ajv/organization/8/website"><img src="https://opencollective.com/ajv/organization/8/avatar.svg"></a>
<a href="https://opencollective.com/ajv/organization/9/website"><img src="https://opencollective.com/ajv/organization/9/avatar.svg"></a>
<a href="https://opencollective.com/ajv/organization/10/website"><img src="https://opencollective.com/ajv/organization/10/avatar.svg"></a>
<a href="https://opencollective.com/ajv/organization/11/website"><img src="https://opencollective.com/ajv/organization/11/avatar.svg"></a>
<a href="https://opencollective.com/ajv/organization/12/website"><img src="https://opencollective.com/ajv/organization/12/avatar.svg"></a>
<a href="https://opencollective.com/ajv/organization/13/website"><img src="https://opencollective.com/ajv/organization/13/avatar.svg"></a>
<a href="https://opencollective.com/ajv/organization/14/website"><img src="https://opencollective.com/ajv/organization/14/avatar.svg"></a>
<a href="https://opencollective.com/ajv/organization/15/website"><img src="https://opencollective.com/ajv/organization/15/avatar.svg"></a>
<a href="https://opencollective.com/ajv/organization/16/website"><img src="https://opencollective.com/ajv/organization/16/avatar.svg"></a>
<a href="https://opencollective.com/ajv/organization/17/website"><img src="https://opencollective.com/ajv/organization/17/avatar.svg"></a>
<a href="https://opencollective.com/ajv/organization/18/website"><img src="https://opencollective.com/ajv/organization/18/avatar.svg"></a>
<a href="https://opencollective.com/ajv/organization/19/website"><img src="https://opencollective.com/ajv/organization/19/avatar.svg"></a>
<a href="https://opencollective.com/ajv/organization/20/website"><img src="https://opencollective.com/ajv/organization/20/avatar.svg"></a>
<a href="https://opencollective.com/ajv/organization/21/website"><img src="https://opencollective.com/ajv/organization/21/avatar.svg"></a>
<a href="https://opencollective.com/ajv/organization/22/website"><img src="https://opencollective.com/ajv/organization/22/avatar.svg"></a>
<a href="https://opencollective.com/ajv/organization/23/website"><img src="https://opencollective.com/ajv/organization/23/avatar.svg"></a>
<a href="https://opencollective.com/ajv/organization/24/website"><img src="https://opencollective.com/ajv/organization/24/avatar.svg"></a>

## Performance

Ajv generates code to turn JSON Schemas into super-fast validation functions that are efficient for v8 optimization.

Currently Ajv is the fastest and the most standard compliant validator according to these benchmarks:

- [json-schema-benchmark](https://github.com/ebdrup/json-schema-benchmark) - 50% faster than the second place
- [jsck benchmark](https://github.com/pandastrike/jsck#benchmarks) - 20-190% faster
- [z-schema benchmark](https://rawgit.com/zaggino/z-schema/master/benchmark/results.html)
- [themis benchmark](https://cdn.rawgit.com/playlyfe/themis/master/benchmark/results.html)

Performance of different validators by [json-schema-benchmark](https://github.com/ebdrup/json-schema-benchmark):

[![performance](https://chart.googleapis.com/chart?chxt=x,y&cht=bhs&chco=76A4FB&chls=2.0&chbh=62,4,1&chs=600x416&chxl=-1:|ajv|@exodus/schemasafe|is-my-json-valid|djv|@cfworker/json-schema|jsonschema/=t:100,69.2,51.5,13.1,5.1,1.2)](https://github.com/ebdrup/json-schema-benchmark/blob/master/README.md#performance)

## Features

- Ajv implements JSON Schema [draft-06/07/2019-09/2020-12](http://json-schema.org/) standards (draft-04 is supported in v6):
  - all validation keywords (see [JSON Schema validation keywords](https://ajv.js.org/json-schema.html))
  - [OpenAPI](https://github.com/OAI/OpenAPI-Specification/blob/master/versions/3.0.3.md) extensions:
    - NEW: keyword [discriminator](https://ajv.js.org/json-schema.html#discriminator).
    - keyword [nullable](https://ajv.js.org/json-schema.html#nullable).
  - full support of remote references (remote schemas have to be added with `addSchema` or compiled to be available)
  - support of recursive references between schemas
  - correct string lengths for strings with unicode pairs
  - JSON Schema [formats](https://ajv.js.org/guide/formats.html) (with [ajv-formats](https://github.com/ajv-validator/ajv-formats) plugin).
  - [validates schemas against meta-schema](https://ajv.js.org/api.html#api-validateschema)
- NEW: supports [JSON Type Definition](https://datatracker.ietf.org/doc/rfc8927/):
  - all keywords (see [JSON Type Definition schema forms](https://ajv.js.org/json-type-definition.html))
  - meta-schema for JTD schemas
  - "union" keyword and user-defined keywords (can be used inside "metadata" member of the schema)
- supports [browsers](https://ajv.js.org/guide/environments.html#browsers) and Node.js 10.x - current
- [asynchronous loading](https://ajv.js.org/guide/managing-schemas.html#asynchronous-schema-loading) of referenced schemas during compilation
- "All errors" validation mode with [option allErrors](https://ajv.js.org/options.html#allerrors)
- [error messages with parameters](https://ajv.js.org/api.html#validation-errors) describing error reasons to allow error message generation
- i18n error messages support with [ajv-i18n](https://github.com/ajv-validator/ajv-i18n) package
- [removing-additional-properties](https://ajv.js.org/guide/modifying-data.html#removing-additional-properties)
- [assigning defaults](https://ajv.js.org/guide/modifying-data.html#assigning-defaults) to missing properties and items
- [coercing data](https://ajv.js.org/guide/modifying-data.html#coercing-data-types) to the types specified in `type` keywords
- [user-defined keywords](https://ajv.js.org/guide/user-keywords.html)
- additional extension keywords with [ajv-keywords](https://github.com/ajv-validator/ajv-keywords) package
- [\$data reference](https://ajv.js.org/guide/combining-schemas.html#data-reference) to use values from the validated data as values for the schema keywords
- [asynchronous validation](https://ajv.js.org/guide/async-validation.html) of user-defined formats and keywords

## Install

To install version 8:

```
npm install ajv
```

## <a name="usage"></a>Getting started

Try it in the Node.js REPL: https://runkit.com/npm/ajv

In JavaScript:

```javascript
// or ESM/TypeScript import
import Ajv from "ajv"
// Node.js require:
const Ajv = require("ajv")

const ajv = new Ajv() // options can be passed, e.g. {allErrors: true}

const schema = {
  type: "object",
  properties: {
    foo: {type: "integer"},
    bar: {type: "string"},
  },
  required: ["foo"],
  additionalProperties: false,
}

const data = {
  foo: 1,
  bar: "abc",
}

const validate = ajv.compile(schema)
const valid = validate(data)
if (!valid) console.log(validate.errors)
```

Learn how to use Ajv and see more examples in the [Guide: getting started](https://ajv.js.org/guide/getting-started.html)

## Changes history

See [https://github.com/ajv-validator/ajv/releases](https://github.com/ajv-validator/ajv/releases)

**Please note**: [Changes in version 8.0.0](https://github.com/ajv-validator/ajv/releases/tag/v8.0.0)

[Version 7.0.0](https://github.com/ajv-validator/ajv/releases/tag/v7.0.0)

[Version 6.0.0](https://github.com/ajv-validator/ajv/releases/tag/v6.0.0).

## Code of conduct

Please review and follow the [Code of conduct](./CODE_OF_CONDUCT.md).

Please report any unacceptable behaviour to ajv.validator@gmail.com - it will be reviewed by the project team.

## Security contact

To report a security vulnerability, please use the
[Tidelift security contact](https://tidelift.com/security).
Tidelift will coordinate the fix and disclosure. Please do NOT report security vulnerabilities via GitHub issues.

## Open-source software support

Ajv is a part of [Tidelift subscription](https://tidelift.com/subscription/pkg/npm-ajv?utm_source=npm-ajv&utm_medium=referral&utm_campaign=readme) - it provides a centralised support to open-source software users, in addition to the support provided by software maintainers.

## License

[MIT](./LICENSE)

## ./node_modules/ansi-align/node_modules/emoji-regex

# emoji-regex [![Build status](https://travis-ci.org/mathiasbynens/emoji-regex.svg?branch=master)](https://travis-ci.org/mathiasbynens/emoji-regex)

_emoji-regex_ offers a regular expression to match all emoji symbols (including textual representations of emoji) as per the Unicode Standard.

This repository contains a script that generates this regular expression based on [the data from Unicode v12](https://github.com/mathiasbynens/unicode-12.0.0). Because of this, the regular expression can easily be updated whenever new emoji are added to the Unicode standard.

## Installation

Via [npm](https://www.npmjs.com/):

```bash
npm install emoji-regex
```

In [Node.js](https://nodejs.org/):

```js
const emojiRegex = require('emoji-regex');
// Note: because the regular expression has the global flag set, this module
// exports a function that returns the regex rather than exporting the regular
// expression itself, to make it impossible to (accidentally) mutate the
// original regular expression.

const text = `
\u{231A}: ⌚ default emoji presentation character (Emoji_Presentation)
\u{2194}\u{FE0F}: ↔️ default text presentation character rendered as emoji
\u{1F469}: 👩 emoji modifier base (Emoji_Modifier_Base)
\u{1F469}\u{1F3FF}: 👩🏿 emoji modifier base followed by a modifier
`;

const regex = emojiRegex();
let match;
while (match = regex.exec(text)) {
  const emoji = match[0];
  console.log(`Matched sequence ${ emoji } — code points: ${ [...emoji].length }`);
}
```

Console output:

```
Matched sequence ⌚ — code points: 1
Matched sequence ⌚ — code points: 1
Matched sequence ↔️ — code points: 2
Matched sequence ↔️ — code points: 2
Matched sequence 👩 — code points: 1
Matched sequence 👩 — code points: 1
Matched sequence 👩🏿 — code points: 2
Matched sequence 👩🏿 — code points: 2
```

To match emoji in their textual representation as well (i.e. emoji that are not `Emoji_Presentation` symbols and that aren’t forced to render as emoji by a variation selector), `require` the other regex:

```js
const emojiRegex = require('emoji-regex/text.js');
```

Additionally, in environments which support ES2015 Unicode escapes, you may `require` ES2015-style versions of the regexes:

```js
const emojiRegex = require('emoji-regex/es2015/index.js');
const emojiRegexText = require('emoji-regex/es2015/text.js');
```

## Author

| [![twitter/mathias](https://gravatar.com/avatar/24e08a9ea84deb17ae121074d0f17125?s=70)](https://twitter.com/mathias "Follow @mathias on Twitter") |
|---|
| [Mathias Bynens](https://mathiasbynens.be/) |

## License

_emoji-regex_ is available under the [MIT](https://mths.be/mit) license.

## ./node_modules/ansi-align

# ansi-align

> align-text with ANSI support for CLIs

[![Build Status](https://travis-ci.org/nexdrew/ansi-align.svg?branch=master)](https://travis-ci.org/nexdrew/ansi-align)
[![Coverage Status](https://coveralls.io/repos/github/nexdrew/ansi-align/badge.svg?branch=master)](https://coveralls.io/github/nexdrew/ansi-align?branch=master)
[![Standard Version](https://img.shields.io/badge/release-standard%20version-brightgreen.svg)](https://github.com/conventional-changelog/standard-version)
[![Greenkeeper badge](https://badges.greenkeeper.io/nexdrew/ansi-align.svg)](https://greenkeeper.io/)

Easily center- or right- align a block of text, carefully ignoring ANSI escape codes.

E.g. turn this:

<img width="281" alt="ansi text block no alignment :(" src="https://cloud.githubusercontent.com/assets/1929625/14937509/7c3076dc-0ed7-11e6-8c16-4f6a4ccc8346.png">

Into this:

<img width="278" alt="ansi text block center aligned!" src="https://cloud.githubusercontent.com/assets/1929625/14937510/7c3ca0b0-0ed7-11e6-8f0a-541ca39b6e0a.png">

## Install

```sh
npm install --save ansi-align
```

```js
var ansiAlign = require('ansi-align')
```

## API

### `ansiAlign(text, [opts])`

Align the given text per the line with the greatest [`string-width`](https://github.com/sindresorhus/string-width), returning a new string (or array).

#### Arguments

- `text`: required, string or array

    The text to align. If a string is given, it will be split using either the `opts.split` value or `'\n'` by default. If an array is given, a different array of modified strings will be returned.

- `opts`: optional, object

    Options to change behavior, see below.

#### Options

- `opts.align`: string, default `'center'`

   The alignment mode. Use `'center'` for center-alignment, `'right'` for right-alignment, or `'left'` for left-alignment. Note that the given `text` is assumed to be left-aligned already, so specifying `align: 'left'` just returns the `text` as is (no-op).

- `opts.split`: string or RegExp, default `'\n'`

    The separator to use when splitting the text. Only used if text is given as a string.

- `opts.pad`: string, default `' '`

    The value used to left-pad (prepend to) lines of lesser width. Will be repeated as necessary to adjust alignment to the line with the greatest width.

### `ansiAlign.center(text)`

Alias for `ansiAlign(text, { align: 'center' })`.

### `ansiAlign.right(text)`

Alias for `ansiAlign(text, { align: 'right' })`.

### `ansiAlign.left(text)`

Alias for `ansiAlign(text, { align: 'left' })`, which is a no-op.

## Similar Packages

- [`center-align`](https://github.com/jonschlinkert/center-align): Very close to this package, except it doesn't support ANSI codes.
- [`left-pad`](https://github.com/camwest/left-pad): Great for left-padding but does not support center alignment or ANSI codes.
- Pretty much anything by the [chalk](https://github.com/chalk) team

## License

ISC © Contributors

## ./node_modules/arch

# arch [![travis][travis-image]][travis-url] [![npm][npm-image]][npm-url] [![downloads][downloads-image]][downloads-url] [![javascript style guide][standard-image]][standard-url]

[travis-image]: https://img.shields.io/travis/feross/arch/master.svg
[travis-url]: https://travis-ci.org/feross/arch
[npm-image]: https://img.shields.io/npm/v/arch.svg
[npm-url]: https://npmjs.org/package/arch
[downloads-image]: https://img.shields.io/npm/dm/arch.svg
[downloads-url]: https://npmjs.org/package/arch
[standard-image]: https://img.shields.io/badge/code_style-standard-brightgreen.svg
[standard-url]: https://standardjs.com

### Better `os.arch()` for node and the browser -- detect OS architecture

[![Sauce Test Status](https://saucelabs.com/browser-matrix/arch2.svg)](https://saucelabs.com/u/arch2)

This module is used by [WebTorrent Desktop](http://webtorrent.io/desktop) to
determine if the user is on a 32-bit vs. 64-bit operating system to offer the
right app installer.

In Node.js, the `os.arch()` method (and `process.arch` property) returns a string
identifying the operating system CPU architecture **for which the Node.js binary
was compiled**.

This is not the same as the **operating system CPU architecture**. For example,
you can run Node.js 32-bit on a 64-bit OS. In that situation, `os.arch()` will
return a misleading 'x86' (32-bit) value, instead of 'x64' (64-bit).

Use this package to get the actual operating system CPU architecture.

**BONUS: This package works in the browser too.**

## install

```
npm install arch
```

## usage

```js
var arch = require('arch')
console.log(arch()) // always returns 'x64' or 'x86'
```

In the browser, there is no spec that defines where this information lives, so we
check all known locations including `navigator.userAgent`, `navigator.platform`,
and `navigator.cpuClass` to make a best guess.

If there is no *affirmative indication* that the architecture is 64-bit, then
32-bit will be assumed. This makes this package perfect for determining what
installer executable to offer to desktop app users. If there is ambiguity, then
the user will get the 32-bit installer, which will work fine even for a user with
a 64-bit OS.

For reference, `x64` means 64-bit and `x86` means 32-bit.

Here is some history behind these naming conventions:

- https://en.wikipedia.org/wiki/X86
- https://en.wikipedia.org/wiki/IA-32
- https://en.wikipedia.org/wiki/X86-64

## Node.js proposal - `os.sysarch()`

Note: There is
[a proposal](https://github.com/nodejs/node-v0.x-archive/issues/2862#issuecomment-103942051)
to add this functionality to Node.js as `os.sysarch()`.

## license

MIT. Copyright (c) [Feross Aboukhadijeh](http://feross.org).

## ./node_modules/arg

# Arg

`arg` is an unopinionated, no-frills CLI argument parser.

## Installation

```bash
npm install arg
```

## Usage

`arg()` takes either 1 or 2 arguments:

1. Command line specification object (see below)
2. Parse options (_Optional_, defaults to `{permissive: false, argv: process.argv.slice(2), stopAtPositional: false}`)

It returns an object with any values present on the command-line (missing options are thus
missing from the resulting object). Arg performs no validation/requirement checking - we
leave that up to the application.

All parameters that aren't consumed by options (commonly referred to as "extra" parameters)
are added to `result._`, which is _always_ an array (even if no extra parameters are passed,
in which case an empty array is returned).

```javascript
const arg = require('arg');

// `options` is an optional parameter
const args = arg(
	spec,
	(options = { permissive: false, argv: process.argv.slice(2) })
);
```

For example:

```console
$ node ./hello.js --verbose -vvv --port=1234 -n 'My name' foo bar --tag qux --tag=qix -- --foobar
```

```javascript
// hello.js
const arg = require('arg');

const args = arg({
	// Types
	'--help': Boolean,
	'--version': Boolean,
	'--verbose': arg.COUNT, // Counts the number of times --verbose is passed
	'--port': Number, // --port <number> or --port=<number>
	'--name': String, // --name <string> or --name=<string>
	'--tag': [String], // --tag <string> or --tag=<string>

	// Aliases
	'-v': '--verbose',
	'-n': '--name', // -n <string>; result is stored in --name
	'--label': '--name' // --label <string> or --label=<string>;
	//     result is stored in --name
});

console.log(args);
/*
{
	_: ["foo", "bar", "--foobar"],
	'--port': 1234,
	'--verbose': 4,
	'--name': "My name",
	'--tag': ["qux", "qix"]
}
*/
```

The values for each key=&gt;value pair is either a type (function or [function]) or a string (indicating an alias).

- In the case of a function, the string value of the argument's value is passed to it,
  and the return value is used as the ultimate value.

- In the case of an array, the only element _must_ be a type function. Array types indicate
  that the argument may be passed multiple times, and as such the resulting value in the returned
  object is an array with all of the values that were passed using the specified flag.

- In the case of a string, an alias is established. If a flag is passed that matches the _key_,
  then the _value_ is substituted in its place.

Type functions are passed three arguments:

1. The parameter value (always a string)
2. The parameter name (e.g. `--label`)
3. The previous value for the destination (useful for reduce-like operations or for supporting `-v` multiple times, etc.)

This means the built-in `String`, `Number`, and `Boolean` type constructors "just work" as type functions.

Note that `Boolean` and `[Boolean]` have special treatment - an option argument is _not_ consumed or passed, but instead `true` is
returned. These options are called "flags".

For custom handlers that wish to behave as flags, you may pass the function through `arg.flag()`:

```javascript
const arg = require('arg');

const argv = [
	'--foo',
	'bar',
	'-ff',
	'baz',
	'--foo',
	'--foo',
	'qux',
	'-fff',
	'qix'
];

function myHandler(value, argName, previousValue) {
	/* `value` is always `true` */
	return 'na ' + (previousValue || 'batman!');
}

const args = arg(
	{
		'--foo': arg.flag(myHandler),
		'-f': '--foo'
	},
	{
		argv
	}
);

console.log(args);
/*
{
	_: ['bar', 'baz', 'qux', 'qix'],
	'--foo': 'na na na na na na na na batman!'
}
*/
```

As well, `arg` supplies a helper argument handler called `arg.COUNT`, which equivalent to a `[Boolean]` argument's `.length`
property - effectively counting the number of times the boolean flag, denoted by the key, is passed on the command line..
For example, this is how you could implement `ssh`'s multiple levels of verbosity (`-vvvv` being the most verbose).

```javascript
const arg = require('arg');

const argv = ['-AAAA', '-BBBB'];

const args = arg(
	{
		'-A': arg.COUNT,
		'-B': [Boolean]
	},
	{
		argv
	}
);

console.log(args);
/*
{
	_: [],
	'-A': 4,
	'-B': [true, true, true, true]
}
*/
```

### Options

If a second parameter is specified and is an object, it specifies parsing options to modify the behavior of `arg()`.

#### `argv`

If you have already sliced or generated a number of raw arguments to be parsed (as opposed to letting `arg`
slice them from `process.argv`) you may specify them in the `argv` option.

For example:

```javascript
const args = arg(
	{
		'--foo': String
	},
	{
		argv: ['hello', '--foo', 'world']
	}
);
```

results in:

```javascript
const args = {
	_: ['hello'],
	'--foo': 'world'
};
```

#### `permissive`

When `permissive` set to `true`, `arg` will push any unknown arguments
onto the "extra" argument array (`result._`) instead of throwing an error about
an unknown flag.

For example:

```javascript
const arg = require('arg');

const argv = [
	'--foo',
	'hello',
	'--qux',
	'qix',
	'--bar',
	'12345',
	'hello again'
];

const args = arg(
	{
		'--foo': String,
		'--bar': Number
	},
	{
		argv,
		permissive: true
	}
);
```

results in:

```javascript
const args = {
	_: ['--qux', 'qix', 'hello again'],
	'--foo': 'hello',
	'--bar': 12345
};
```

#### `stopAtPositional`

When `stopAtPositional` is set to `true`, `arg` will halt parsing at the first
positional argument.

For example:

```javascript
const arg = require('arg');

const argv = ['--foo', 'hello', '--bar'];

const args = arg(
	{
		'--foo': Boolean,
		'--bar': Boolean
	},
	{
		argv,
		stopAtPositional: true
	}
);
```

results in:

```javascript
const args = {
	_: ['hello', '--bar'],
	'--foo': true
};
```

### Errors

Some errors that `arg` throws provide a `.code` property in order to aid in recovering from user error, or to
differentiate between user error and developer error (bug).

##### ARG_UNKNOWN_OPTION

If an unknown option (not defined in the spec object) is passed, an error with code `ARG_UNKNOWN_OPTION` will be thrown:

```js
// cli.js
try {
	require('arg')({ '--hi': String });
} catch (err) {
	if (err.code === 'ARG_UNKNOWN_OPTION') {
		console.log(err.message);
	} else {
		throw err;
	}
}
```

```shell
node cli.js --extraneous true
Unknown or unexpected option: --extraneous
```

# FAQ

A few questions and answers that have been asked before:

### How do I require an argument with `arg`?

Do the assertion yourself, such as:

```javascript
const args = arg({ '--name': String });

if (!args['--name']) throw new Error('missing required argument: --name');
```

# License

Released under the [MIT License](LICENSE.md).

## ./node_modules/balanced-match

# balanced-match

Match balanced string pairs, like `{` and `}` or `<b>` and `</b>`. Supports regular expressions as well!

[![build status](https://secure.travis-ci.org/juliangruber/balanced-match.svg)](http://travis-ci.org/juliangruber/balanced-match)
[![downloads](https://img.shields.io/npm/dm/balanced-match.svg)](https://www.npmjs.org/package/balanced-match)

[![testling badge](https://ci.testling.com/juliangruber/balanced-match.png)](https://ci.testling.com/juliangruber/balanced-match)

## Example

Get the first matching pair of braces:

```js
var balanced = require('balanced-match');

console.log(balanced('{', '}', 'pre{in{nested}}post'));
console.log(balanced('{', '}', 'pre{first}between{second}post'));
console.log(balanced(/\s+\{\s+/, /\s+\}\s+/, 'pre  {   in{nest}   }  post'));
```

The matches are:

```bash
$ node example.js
{ start: 3, end: 14, pre: 'pre', body: 'in{nested}', post: 'post' }
{ start: 3,
  end: 9,
  pre: 'pre',
  body: 'first',
  post: 'between{second}post' }
{ start: 3, end: 17, pre: 'pre', body: 'in{nest}', post: 'post' }
```

## API

### var m = balanced(a, b, str)

For the first non-nested matching pair of `a` and `b` in `str`, return an
object with those keys:

* **start** the index of the first match of `a`
* **end** the index of the matching `b`
* **pre** the preamble, `a` and `b` not included
* **body** the match, `a` and `b` not included
* **post** the postscript, `a` and `b` not included

If there's no match, `undefined` will be returned.

If the `str` contains more `a` than `b` / there are unmatched pairs, the first match that was closed will be used. For example, `{{a}` will match `['{', 'a', '']` and `{a}}` will match `['', 'a', '}']`.

### var r = balanced.range(a, b, str)

For the first non-nested matching pair of `a` and `b` in `str`, return an
array with indexes: `[ <a index>, <b index> ]`.

If there's no match, `undefined` will be returned.

If the `str` contains more `a` than `b` / there are unmatched pairs, the first match that was closed will be used. For example, `{{a}` will match `[ 1, 3 ]` and `{a}}` will match `[0, 2]`.

## Installation

With [npm](https://npmjs.org) do:

```bash
npm install balanced-match
```

## Security contact information

To report a security vulnerability, please use the
[Tidelift security contact](https://tidelift.com/security).
Tidelift will coordinate the fix and disclosure.

## License

(MIT)

Copyright (c) 2013 Julian Gruber &lt;julian@juliangruber.com&gt;

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

## ./node_modules/brace-expansion

# brace-expansion

[Brace expansion](https://www.gnu.org/software/bash/manual/html_node/Brace-Expansion.html), 
as known from sh/bash, in JavaScript.

[![build status](https://secure.travis-ci.org/juliangruber/brace-expansion.svg)](http://travis-ci.org/juliangruber/brace-expansion)
[![downloads](https://img.shields.io/npm/dm/brace-expansion.svg)](https://www.npmjs.org/package/brace-expansion)
[![Greenkeeper badge](https://badges.greenkeeper.io/juliangruber/brace-expansion.svg)](https://greenkeeper.io/)

[![testling badge](https://ci.testling.com/juliangruber/brace-expansion.png)](https://ci.testling.com/juliangruber/brace-expansion)

## Example

```js
var expand = require('brace-expansion');

expand('file-{a,b,c}.jpg')
// => ['file-a.jpg', 'file-b.jpg', 'file-c.jpg']

expand('-v{,,}')
// => ['-v', '-v', '-v']

expand('file{0..2}.jpg')
// => ['file0.jpg', 'file1.jpg', 'file2.jpg']

expand('file-{a..c}.jpg')
// => ['file-a.jpg', 'file-b.jpg', 'file-c.jpg']

expand('file{2..0}.jpg')
// => ['file2.jpg', 'file1.jpg', 'file0.jpg']

expand('file{0..4..2}.jpg')
// => ['file0.jpg', 'file2.jpg', 'file4.jpg']

expand('file-{a..e..2}.jpg')
// => ['file-a.jpg', 'file-c.jpg', 'file-e.jpg']

expand('file{00..10..5}.jpg')
// => ['file00.jpg', 'file05.jpg', 'file10.jpg']

expand('{{A..C},{a..c}}')
// => ['A', 'B', 'C', 'a', 'b', 'c']

expand('ppp{,config,oe{,conf}}')
// => ['ppp', 'pppconfig', 'pppoe', 'pppoeconf']
```

## API

```js
var expand = require('brace-expansion');
```

### var expanded = expand(str)

Return an array of all possible and valid expansions of `str`. If none are
found, `[str]` is returned.

Valid expansions are:

```js
/^(.*,)+(.+)?$/
// {a,b,...}
```

A comma separated list of options, like `{a,b}` or `{a,{b,c}}` or `{,a,}`.

```js
/^-?\d+\.\.-?\d+(\.\.-?\d+)?$/
// {x..y[..incr]}
```

A numeric sequence from `x` to `y` inclusive, with optional increment.
If `x` or `y` start with a leading `0`, all the numbers will be padded
to have equal length. Negative numbers and backwards iteration work too.

```js
/^-?\d+\.\.-?\d+(\.\.-?\d+)?$/
// {x..y[..incr]}
```

An alphabetic sequence from `x` to `y` inclusive, with optional increment.
`x` and `y` must be exactly one character, and if given, `incr` must be a
number.

For compatibility reasons, the string `${` is not eligible for brace expansion.

## Installation

With [npm](https://npmjs.org) do:

```bash
npm install brace-expansion
```

## Contributors

- [Julian Gruber](https://github.com/juliangruber)
- [Isaac Z. Schlueter](https://github.com/isaacs)

## Sponsors

This module is proudly supported by my [Sponsors](https://github.com/juliangruber/sponsors)!

Do you want to support modules like this to improve their quality, stability and weigh in on new features? Then please consider donating to my [Patreon](https://www.patreon.com/juliangruber). Not sure how much of my modules you're using? Try [feross/thanks](https://github.com/feross/thanks)!

## License

(MIT)

Copyright (c) 2013 Julian Gruber &lt;julian@juliangruber.com&gt;

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

## ./node_modules/color-convert

# color-convert

[![Build Status](https://travis-ci.org/Qix-/color-convert.svg?branch=master)](https://travis-ci.org/Qix-/color-convert)

Color-convert is a color conversion library for JavaScript and node.
It converts all ways between `rgb`, `hsl`, `hsv`, `hwb`, `cmyk`, `ansi`, `ansi16`, `hex` strings, and CSS `keyword`s (will round to closest):

```js
var convert = require('color-convert');

convert.rgb.hsl(140, 200, 100);             // [96, 48, 59]
convert.keyword.rgb('blue');                // [0, 0, 255]

var rgbChannels = convert.rgb.channels;     // 3
var cmykChannels = convert.cmyk.channels;   // 4
var ansiChannels = convert.ansi16.channels; // 1
```

# Install

```console
$ npm install color-convert
```

# API

Simply get the property of the _from_ and _to_ conversion that you're looking for.

All functions have a rounded and unrounded variant. By default, return values are rounded. To get the unrounded (raw) results, simply tack on `.raw` to the function.

All 'from' functions have a hidden property called `.channels` that indicates the number of channels the function expects (not including alpha).

```js
var convert = require('color-convert');

// Hex to LAB
convert.hex.lab('DEADBF');         // [ 76, 21, -2 ]
convert.hex.lab.raw('DEADBF');     // [ 75.56213190997677, 20.653827952644754, -2.290532499330533 ]

// RGB to CMYK
convert.rgb.cmyk(167, 255, 4);     // [ 35, 0, 98, 0 ]
convert.rgb.cmyk.raw(167, 255, 4); // [ 34.509803921568626, 0, 98.43137254901961, 0 ]
```

### Arrays
All functions that accept multiple arguments also support passing an array.

Note that this does **not** apply to functions that convert from a color that only requires one value (e.g. `keyword`, `ansi256`, `hex`, etc.)

```js
var convert = require('color-convert');

convert.rgb.hex(123, 45, 67);      // '7B2D43'
convert.rgb.hex([123, 45, 67]);    // '7B2D43'
```

## Routing

Conversions that don't have an _explicitly_ defined conversion (in [conversions.js](conversions.js)), but can be converted by means of sub-conversions (e.g. XYZ -> **RGB** -> CMYK), are automatically routed together. This allows just about any color model supported by `color-convert` to be converted to any other model, so long as a sub-conversion path exists. This is also true for conversions requiring more than one step in between (e.g. LCH -> **LAB** -> **XYZ** -> **RGB** -> Hex).

Keep in mind that extensive conversions _may_ result in a loss of precision, and exist only to be complete. For a list of "direct" (single-step) conversions, see [conversions.js](conversions.js).

# Contribute

If there is a new model you would like to support, or want to add a direct conversion between two existing models, please send us a pull request.

# License
Copyright &copy; 2011-2016, Heather Arthur and Josh Junon. Licensed under the [MIT License](LICENSE).

## ./node_modules/color-name

A JSON with color names and its values. Based on http://dev.w3.org/csswg/css-color/#named-colors.

[![NPM](https://nodei.co/npm/color-name.png?mini=true)](https://nodei.co/npm/color-name/)


```js
var colors = require('color-name');
colors.red //[255,0,0]
```

<a href="LICENSE"><img src="https://upload.wikimedia.org/wikipedia/commons/0/0c/MIT_logo.svg" width="120"/></a>

## ./node_modules/compressible

# compressible

[![NPM Version][npm-version-image]][npm-url]
[![NPM Downloads][npm-downloads-image]][npm-url]
[![Node.js Version][node-version-image]][node-version-url]
[![Build Status][travis-image]][travis-url]
[![Test Coverage][coveralls-image]][coveralls-url]

Compressible `Content-Type` / `mime` checking.

## Installation

```sh
$ npm install compressible
```

## API

<!-- eslint-disable no-unused-vars -->

```js
var compressible = require('compressible')
```

### compressible(type)

Checks if the given `Content-Type` is compressible. The `type` argument is expected
to be a value MIME type or `Content-Type` string, though no validation is performed.

The MIME is looked up in the [`mime-db`](https://www.npmjs.com/package/mime-db) and
if there is compressible information in the database entry, that is returned. Otherwise,
this module will fallback to `true` for the following types:

  * `text/*`
  * `*/*+json`
  * `*/*+text`
  * `*/*+xml`

If this module is not sure if a type is specifically compressible or specifically
uncompressible, `undefined` is returned.

<!-- eslint-disable no-undef -->

```js
compressible('text/html') // => true
compressible('image/png') // => false
```

## License

[MIT](LICENSE)

[coveralls-image]: https://badgen.net/coveralls/c/github/jshttp/compressible/master
[coveralls-url]: https://coveralls.io/r/jshttp/compressible?branch=master
[node-version-image]: https://badgen.net/npm/node/compressible
[node-version-url]: https://nodejs.org/en/download
[npm-downloads-image]: https://badgen.net/npm/dm/compressible
[npm-url]: https://npmjs.org/package/compressible
[npm-version-image]: https://badgen.net/npm/v/compressible
[travis-image]: https://badgen.net/travis/jshttp/compressible/master
[travis-url]: https://travis-ci.org/jshttp/compressible

## ./node_modules/compression

# compression

[![NPM Version][npm-image]][npm-url]
[![NPM Downloads][downloads-image]][downloads-url]
[![Build Status][travis-image]][travis-url]
[![Test Coverage][coveralls-image]][coveralls-url]

Node.js compression middleware.

The following compression codings are supported:

  - deflate
  - gzip

## Install

This is a [Node.js](https://nodejs.org/en/) module available through the
[npm registry](https://www.npmjs.com/). Installation is done using the
[`npm install` command](https://docs.npmjs.com/getting-started/installing-npm-packages-locally):

```bash
$ npm install compression
```

## API

<!-- eslint-disable no-unused-vars -->

```js
var compression = require('compression')
```

### compression([options])

Returns the compression middleware using the given `options`. The middleware
will attempt to compress response bodies for all request that traverse through
the middleware, based on the given `options`.

This middleware will never compress responses that include a `Cache-Control`
header with the [`no-transform` directive](https://tools.ietf.org/html/rfc7234#section-5.2.2.4),
as compressing will transform the body.

#### Options

`compression()` accepts these properties in the options object. In addition to
those listed below, [zlib](http://nodejs.org/api/zlib.html) options may be
passed in to the options object.

##### chunkSize

The default value is `zlib.Z_DEFAULT_CHUNK`, or `16384`.

See [Node.js documentation](http://nodejs.org/api/zlib.html#zlib_memory_usage_tuning)
regarding the usage.

##### filter

A function to decide if the response should be considered for compression.
This function is called as `filter(req, res)` and is expected to return
`true` to consider the response for compression, or `false` to not compress
the response.

The default filter function uses the [compressible](https://www.npmjs.com/package/compressible)
module to determine if `res.getHeader('Content-Type')` is compressible.

##### level

The level of zlib compression to apply to responses. A higher level will result
in better compression, but will take longer to complete. A lower level will
result in less compression, but will be much faster.

This is an integer in the range of `0` (no compression) to `9` (maximum
compression). The special value `-1` can be used to mean the "default
compression level", which is a default compromise between speed and
compression (currently equivalent to level 6).

  - `-1` Default compression level (also `zlib.Z_DEFAULT_COMPRESSION`).
  - `0` No compression (also `zlib.Z_NO_COMPRESSION`).
  - `1` Fastest compression (also `zlib.Z_BEST_SPEED`).
  - `2`
  - `3`
  - `4`
  - `5`
  - `6` (currently what `zlib.Z_DEFAULT_COMPRESSION` points to).
  - `7`
  - `8`
  - `9` Best compression (also `zlib.Z_BEST_COMPRESSION`).

The default value is `zlib.Z_DEFAULT_COMPRESSION`, or `-1`.

**Note** in the list above, `zlib` is from `zlib = require('zlib')`.

##### memLevel

This specifies how much memory should be allocated for the internal compression
state and is an integer in the range of `1` (minimum level) and `9` (maximum
level).

The default value is `zlib.Z_DEFAULT_MEMLEVEL`, or `8`.

See [Node.js documentation](http://nodejs.org/api/zlib.html#zlib_memory_usage_tuning)
regarding the usage.

##### strategy

This is used to tune the compression algorithm. This value only affects the
compression ratio, not the correctness of the compressed output, even if it
is not set appropriately.

  - `zlib.Z_DEFAULT_STRATEGY` Use for normal data.
  - `zlib.Z_FILTERED` Use for data produced by a filter (or predictor).
    Filtered data consists mostly of small values with a somewhat random
    distribution. In this case, the compression algorithm is tuned to
    compress them better. The effect is to force more Huffman coding and less
    string matching; it is somewhat intermediate between `zlib.Z_DEFAULT_STRATEGY`
    and `zlib.Z_HUFFMAN_ONLY`.
  - `zlib.Z_FIXED` Use to prevent the use of dynamic Huffman codes, allowing
    for a simpler decoder for special applications.
  - `zlib.Z_HUFFMAN_ONLY` Use to force Huffman encoding only (no string match).
  - `zlib.Z_RLE` Use to limit match distances to one (run-length encoding).
    This is designed to be almost as fast as `zlib.Z_HUFFMAN_ONLY`, but give
    better compression for PNG image data.

**Note** in the list above, `zlib` is from `zlib = require('zlib')`.

##### threshold

The byte threshold for the response body size before compression is considered
for the response, defaults to `1kb`. This is a number of bytes or any string
accepted by the [bytes](https://www.npmjs.com/package/bytes) module.

**Note** this is only an advisory setting; if the response size cannot be determined
at the time the response headers are written, then it is assumed the response is
_over_ the threshold. To guarantee the response size can be determined, be sure
set a `Content-Length` response header.

##### windowBits

The default value is `zlib.Z_DEFAULT_WINDOWBITS`, or `15`.

See [Node.js documentation](http://nodejs.org/api/zlib.html#zlib_memory_usage_tuning)
regarding the usage.

#### .filter

The default `filter` function. This is used to construct a custom filter
function that is an extension of the default function.

```js
var compression = require('compression')
var express = require('express')

var app = express()
app.use(compression({ filter: shouldCompress }))

function shouldCompress (req, res) {
  if (req.headers['x-no-compression']) {
    // don't compress responses with this request header
    return false
  }

  // fallback to standard filter function
  return compression.filter(req, res)
}
```

### res.flush

This module adds a `res.flush()` method to force the partially-compressed
response to be flushed to the client.

## Examples

### express/connect

When using this module with express or connect, simply `app.use` the module as
high as you like. Requests that pass through the middleware will be compressed.

```js
var compression = require('compression')
var express = require('express')

var app = express()

// compress all responses
app.use(compression())

// add all routes
```

### Server-Sent Events

Because of the nature of compression this module does not work out of the box
with server-sent events. To compress content, a window of the output needs to
be buffered up in order to get good compression. Typically when using server-sent
events, there are certain block of data that need to reach the client.

You can achieve this by calling `res.flush()` when you need the data written to
actually make it to the client.

```js
var compression = require('compression')
var express = require('express')

var app = express()

// compress responses
app.use(compression())

// server-sent event stream
app.get('/events', function (req, res) {
  res.setHeader('Content-Type', 'text/event-stream')
  res.setHeader('Cache-Control', 'no-cache')

  // send a ping approx every 2 seconds
  var timer = setInterval(function () {
    res.write('data: ping\n\n')

    // !!! this is the important part
    res.flush()
  }, 2000)

  res.on('close', function () {
    clearInterval(timer)
  })
})
```

## License

[MIT](LICENSE)

[npm-image]: https://img.shields.io/npm/v/compression.svg
[npm-url]: https://npmjs.org/package/compression
[travis-image]: https://img.shields.io/travis/expressjs/compression/master.svg
[travis-url]: https://travis-ci.org/expressjs/compression
[coveralls-image]: https://img.shields.io/coveralls/expressjs/compression/master.svg
[coveralls-url]: https://coveralls.io/r/expressjs/compression?branch=master
[downloads-image]: https://img.shields.io/npm/dm/compression.svg
[downloads-url]: https://npmjs.org/package/compression

## ./node_modules/content-disposition

# content-disposition

[![NPM Version][npm-image]][npm-url]
[![NPM Downloads][downloads-image]][downloads-url]
[![Node.js Version][node-version-image]][node-version-url]
[![Build Status][travis-image]][travis-url]
[![Test Coverage][coveralls-image]][coveralls-url]

Create and parse HTTP `Content-Disposition` header

## Installation

```sh
$ npm install content-disposition
```

## API

```js
var contentDisposition = require('content-disposition')
```

### contentDisposition(filename, options)

Create an attachment `Content-Disposition` header value using the given file name,
if supplied. The `filename` is optional and if no file name is desired, but you
want to specify `options`, set `filename` to `undefined`.

```js
res.setHeader('Content-Disposition', contentDisposition('∫ maths.pdf'))
```

**note** HTTP headers are of the ISO-8859-1 character set. If you are writing this
header through a means different from `setHeader` in Node.js, you'll want to specify
the `'binary'` encoding in Node.js.

#### Options

`contentDisposition` accepts these properties in the options object.

##### fallback

If the `filename` option is outside ISO-8859-1, then the file name is actually
stored in a supplemental field for clients that support Unicode file names and
a ISO-8859-1 version of the file name is automatically generated.

This specifies the ISO-8859-1 file name to override the automatic generation or
disables the generation all together, defaults to `true`.

  - A string will specify the ISO-8859-1 file name to use in place of automatic
    generation.
  - `false` will disable including a ISO-8859-1 file name and only include the
    Unicode version (unless the file name is already ISO-8859-1).
  - `true` will enable automatic generation if the file name is outside ISO-8859-1.

If the `filename` option is ISO-8859-1 and this option is specified and has a
different value, then the `filename` option is encoded in the extended field
and this set as the fallback field, even though they are both ISO-8859-1.

##### type

Specifies the disposition type, defaults to `"attachment"`. This can also be
`"inline"`, or any other value (all values except inline are treated like
`attachment`, but can convey additional information if both parties agree to
it). The type is normalized to lower-case.

### contentDisposition.parse(string)

```js
var disposition = contentDisposition.parse('attachment; filename="EURO rates.txt"; filename*=UTF-8\'\'%e2%82%ac%20rates.txt');
```

Parse a `Content-Disposition` header string. This automatically handles extended
("Unicode") parameters by decoding them and providing them under the standard
parameter name. This will return an object with the following properties (examples
are shown for the string `'attachment; filename="EURO rates.txt"; filename*=UTF-8\'\'%e2%82%ac%20rates.txt'`):

 - `type`: The disposition type (always lower case). Example: `'attachment'`

 - `parameters`: An object of the parameters in the disposition (name of parameter
   always lower case and extended versions replace non-extended versions). Example:
   `{filename: "€ rates.txt"}`

## Examples

### Send a file for download

```js
var contentDisposition = require('content-disposition')
var destroy = require('destroy')
var http = require('http')
var onFinished = require('on-finished')

var filePath = '/path/to/public/plans.pdf'

http.createServer(function onRequest(req, res) {
  // set headers
  res.setHeader('Content-Type', 'application/pdf')
  res.setHeader('Content-Disposition', contentDisposition(filePath))

  // send file
  var stream = fs.createReadStream(filePath)
  stream.pipe(res)
  onFinished(res, function (err) {
    destroy(stream)
  })
})
```

## Testing

```sh
$ npm test
```

## References

- [RFC 2616: Hypertext Transfer Protocol -- HTTP/1.1][rfc-2616]
- [RFC 5987: Character Set and Language Encoding for Hypertext Transfer Protocol (HTTP) Header Field Parameters][rfc-5987]
- [RFC 6266: Use of the Content-Disposition Header Field in the Hypertext Transfer Protocol (HTTP)][rfc-6266]
- [Test Cases for HTTP Content-Disposition header field (RFC 6266) and the Encodings defined in RFCs 2047, 2231 and 5987][tc-2231]

[rfc-2616]: https://tools.ietf.org/html/rfc2616
[rfc-5987]: https://tools.ietf.org/html/rfc5987
[rfc-6266]: https://tools.ietf.org/html/rfc6266
[tc-2231]: http://greenbytes.de/tech/tc2231/

## License

[MIT](LICENSE)

[npm-image]: https://img.shields.io/npm/v/content-disposition.svg?style=flat
[npm-url]: https://npmjs.org/package/content-disposition
[node-version-image]: https://img.shields.io/node/v/content-disposition.svg?style=flat
[node-version-url]: https://nodejs.org/en/download
[travis-image]: https://img.shields.io/travis/jshttp/content-disposition.svg?style=flat
[travis-url]: https://travis-ci.org/jshttp/content-disposition
[coveralls-image]: https://img.shields.io/coveralls/jshttp/content-disposition.svg?style=flat
[coveralls-url]: https://coveralls.io/r/jshttp/content-disposition?branch=master
[downloads-image]: https://img.shields.io/npm/dm/content-disposition.svg?style=flat
[downloads-url]: https://npmjs.org/package/content-disposition

## ./node_modules/cross-spawn

# cross-spawn

[![NPM version][npm-image]][npm-url] [![Downloads][downloads-image]][npm-url] [![Build Status][ci-image]][ci-url] [![Build status][appveyor-image]][appveyor-url]

[npm-url]:https://npmjs.org/package/cross-spawn
[downloads-image]:https://img.shields.io/npm/dm/cross-spawn.svg
[npm-image]:https://img.shields.io/npm/v/cross-spawn.svg
[ci-url]:https://github.com/moxystudio/node-cross-spawn/actions/workflows/ci.yaml
[ci-image]:https://github.com/moxystudio/node-cross-spawn/actions/workflows/ci.yaml/badge.svg
[appveyor-url]:https://ci.appveyor.com/project/satazor/node-cross-spawn
[appveyor-image]:https://img.shields.io/appveyor/ci/satazor/node-cross-spawn/master.svg

A cross platform solution to node's spawn and spawnSync.

## Installation

Node.js version 8 and up:
`$ npm install cross-spawn`

Node.js version 7 and under:
`$ npm install cross-spawn@6`

## Why

Node has issues when using spawn on Windows:

- It ignores [PATHEXT](https://github.com/joyent/node/issues/2318)
- It does not support [shebangs](https://en.wikipedia.org/wiki/Shebang_(Unix))
- Has problems running commands with [spaces](https://github.com/nodejs/node/issues/7367)
- Has problems running commands with posix relative paths (e.g.: `./my-folder/my-executable`)
- Has an [issue](https://github.com/moxystudio/node-cross-spawn/issues/82) with command shims (files in `node_modules/.bin/`), where arguments with quotes and parenthesis would result in [invalid syntax error](https://github.com/moxystudio/node-cross-spawn/blob/e77b8f22a416db46b6196767bcd35601d7e11d54/test/index.test.js#L149)
- No `options.shell` support on node `<v4.8`

All these issues are handled correctly by `cross-spawn`.
There are some known modules, such as [win-spawn](https://github.com/ForbesLindesay/win-spawn), that try to solve this but they are either broken or provide faulty escaping of shell arguments.


## Usage

Exactly the same way as node's [`spawn`](https://nodejs.org/api/child_process.html#child_process_child_process_spawn_command_args_options) or [`spawnSync`](https://nodejs.org/api/child_process.html#child_process_child_process_spawnsync_command_args_options), so it's a drop in replacement.


```js
const spawn = require('cross-spawn');

// Spawn NPM asynchronously
const child = spawn('npm', ['list', '-g', '-depth', '0'], { stdio: 'inherit' });

// Spawn NPM synchronously
const result = spawn.sync('npm', ['list', '-g', '-depth', '0'], { stdio: 'inherit' });
```


## Caveats

### Using `options.shell` as an alternative to `cross-spawn`

Starting from node `v4.8`, `spawn` has a `shell` option that allows you run commands from within a shell. This new option solves
the [PATHEXT](https://github.com/joyent/node/issues/2318) issue but:

- It's not supported in node `<v4.8`
- You must manually escape the command and arguments which is very error prone, specially when passing user input
- There are a lot of other unresolved issues from the [Why](#why) section that you must take into account

If you are using the `shell` option to spawn a command in a cross platform way, consider using `cross-spawn` instead. You have been warned.

### `options.shell` support

While `cross-spawn` adds support for `options.shell` in node `<v4.8`, all of its enhancements are disabled.

This mimics the Node.js behavior. More specifically, the command and its arguments will not be automatically escaped nor shebang support will be offered. This is by design because if you are using `options.shell` you are probably targeting a specific platform anyway and you don't want things to get into your way.

### Shebangs support

While `cross-spawn` handles shebangs on Windows, its support is limited. More specifically, it just supports `#!/usr/bin/env <program>` where `<program>` must not contain any arguments.   
If you would like to have the shebang support improved, feel free to contribute via a pull-request.

Remember to always test your code on Windows!


## Tests

`$ npm test`   
`$ npm test -- --watch` during development


## License

Released under the [MIT License](https://www.opensource.org/licenses/mit-license.php).

## ./node_modules/debug

# debug
[![Build Status](https://travis-ci.org/visionmedia/debug.svg?branch=master)](https://travis-ci.org/visionmedia/debug)  [![Coverage Status](https://coveralls.io/repos/github/visionmedia/debug/badge.svg?branch=master)](https://coveralls.io/github/visionmedia/debug?branch=master)  [![Slack](https://visionmedia-community-slackin.now.sh/badge.svg)](https://visionmedia-community-slackin.now.sh/) [![OpenCollective](https://opencollective.com/debug/backers/badge.svg)](#backers) 
[![OpenCollective](https://opencollective.com/debug/sponsors/badge.svg)](#sponsors)



A tiny node.js debugging utility modelled after node core's debugging technique.

**Discussion around the V3 API is under way [here](https://github.com/visionmedia/debug/issues/370)**

## Installation

```bash
$ npm install debug
```

## Usage

`debug` exposes a function; simply pass this function the name of your module, and it will return a decorated version of `console.error` for you to pass debug statements to. This will allow you to toggle the debug output for different parts of your module as well as the module as a whole.

Example _app.js_:

```js
var debug = require('debug')('http')
  , http = require('http')
  , name = 'My App';

// fake app

debug('booting %s', name);

http.createServer(function(req, res){
  debug(req.method + ' ' + req.url);
  res.end('hello\n');
}).listen(3000, function(){
  debug('listening');
});

// fake worker of some kind

require('./worker');
```

Example _worker.js_:

```js
var debug = require('debug')('worker');

setInterval(function(){
  debug('doing some work');
}, 1000);
```

 The __DEBUG__ environment variable is then used to enable these based on space or comma-delimited names. Here are some examples:

  ![debug http and worker](http://f.cl.ly/items/18471z1H402O24072r1J/Screenshot.png)

  ![debug worker](http://f.cl.ly/items/1X413v1a3M0d3C2c1E0i/Screenshot.png)

#### Windows note

 On Windows the environment variable is set using the `set` command.

 ```cmd
 set DEBUG=*,-not_this
 ```

 Note that PowerShell uses different syntax to set environment variables.

 ```cmd
 $env:DEBUG = "*,-not_this"
  ```

Then, run the program to be debugged as usual.

## Millisecond diff

  When actively developing an application it can be useful to see when the time spent between one `debug()` call and the next. Suppose for example you invoke `debug()` before requesting a resource, and after as well, the "+NNNms" will show you how much time was spent between calls.

  ![](http://f.cl.ly/items/2i3h1d3t121M2Z1A3Q0N/Screenshot.png)

  When stdout is not a TTY, `Date#toUTCString()` is used, making it more useful for logging the debug information as shown below:

  ![](http://f.cl.ly/items/112H3i0e0o0P0a2Q2r11/Screenshot.png)

## Conventions

  If you're using this in one or more of your libraries, you _should_ use the name of your library so that developers may toggle debugging as desired without guessing names. If you have more than one debuggers you _should_ prefix them with your library name and use ":" to separate features. For example "bodyParser" from Connect would then be "connect:bodyParser".

## Wildcards

  The `*` character may be used as a wildcard. Suppose for example your library has debuggers named "connect:bodyParser", "connect:compress", "connect:session", instead of listing all three with `DEBUG=connect:bodyParser,connect:compress,connect:session`, you may simply do `DEBUG=connect:*`, or to run everything using this module simply use `DEBUG=*`.

  You can also exclude specific debuggers by prefixing them with a "-" character.  For example, `DEBUG=*,-connect:*` would include all debuggers except those starting with "connect:".

## Environment Variables

  When running through Node.js, you can set a few environment variables that will
  change the behavior of the debug logging:

| Name      | Purpose                                         |
|-----------|-------------------------------------------------|
| `DEBUG`   | Enables/disables specific debugging namespaces. |
| `DEBUG_COLORS`| Whether or not to use colors in the debug output. |
| `DEBUG_DEPTH` | Object inspection depth. |
| `DEBUG_SHOW_HIDDEN` | Shows hidden properties on inspected objects. |


  __Note:__ The environment variables beginning with `DEBUG_` end up being
  converted into an Options object that gets used with `%o`/`%O` formatters.
  See the Node.js documentation for
  [`util.inspect()`](https://nodejs.org/api/util.html#util_util_inspect_object_options)
  for the complete list.

## Formatters


  Debug uses [printf-style](https://wikipedia.org/wiki/Printf_format_string) formatting. Below are the officially supported formatters:

| Formatter | Representation |
|-----------|----------------|
| `%O`      | Pretty-print an Object on multiple lines. |
| `%o`      | Pretty-print an Object all on a single line. |
| `%s`      | String. |
| `%d`      | Number (both integer and float). |
| `%j`      | JSON. Replaced with the string '[Circular]' if the argument contains circular references. |
| `%%`      | Single percent sign ('%'). This does not consume an argument. |

### Custom formatters

  You can add custom formatters by extending the `debug.formatters` object. For example, if you wanted to add support for rendering a Buffer as hex with `%h`, you could do something like:

```js
const createDebug = require('debug')
createDebug.formatters.h = (v) => {
  return v.toString('hex')
}

// …elsewhere
const debug = createDebug('foo')
debug('this is hex: %h', new Buffer('hello world'))
//   foo this is hex: 68656c6c6f20776f726c6421 +0ms
```

## Browser support
  You can build a browser-ready script using [browserify](https://github.com/substack/node-browserify),
  or just use the [browserify-as-a-service](https://wzrd.in/) [build](https://wzrd.in/standalone/debug@latest),
  if you don't want to build it yourself.

  Debug's enable state is currently persisted by `localStorage`.
  Consider the situation shown below where you have `worker:a` and `worker:b`,
  and wish to debug both. You can enable this using `localStorage.debug`:

```js
localStorage.debug = 'worker:*'
```

And then refresh the page.

```js
a = debug('worker:a');
b = debug('worker:b');

setInterval(function(){
  a('doing some work');
}, 1000);

setInterval(function(){
  b('doing some work');
}, 1200);
```

#### Web Inspector Colors

  Colors are also enabled on "Web Inspectors" that understand the `%c` formatting
  option. These are WebKit web inspectors, Firefox ([since version
  31](https://hacks.mozilla.org/2014/05/editable-box-model-multiple-selection-sublime-text-keys-much-more-firefox-developer-tools-episode-31/))
  and the Firebug plugin for Firefox (any version).

  Colored output looks something like:

  ![](https://cloud.githubusercontent.com/assets/71256/3139768/b98c5fd8-e8ef-11e3-862a-f7253b6f47c6.png)


## Output streams

  By default `debug` will log to stderr, however this can be configured per-namespace by overriding the `log` method:

Example _stdout.js_:

```js
var debug = require('debug');
var error = debug('app:error');

// by default stderr is used
error('goes to stderr!');

var log = debug('app:log');
// set this namespace to log via console.log
log.log = console.log.bind(console); // don't forget to bind to console!
log('goes to stdout');
error('still goes to stderr!');

// set all output to go via console.info
// overrides all per-namespace log settings
debug.log = console.info.bind(console);
error('now goes to stdout via console.info');
log('still goes to stdout, but via console.info now');
```


## Authors

 - TJ Holowaychuk
 - Nathan Rajlich
 - Andrew Rhyne
 
## Backers

Support us with a monthly donation and help us continue our activities. [[Become a backer](https://opencollective.com/debug#backer)]

<a href="https://opencollective.com/debug/backer/0/website" target="_blank"><img src="https://opencollective.com/debug/backer/0/avatar.svg"></a>
<a href="https://opencollective.com/debug/backer/1/website" target="_blank"><img src="https://opencollective.com/debug/backer/1/avatar.svg"></a>
<a href="https://opencollective.com/debug/backer/2/website" target="_blank"><img src="https://opencollective.com/debug/backer/2/avatar.svg"></a>
<a href="https://opencollective.com/debug/backer/3/website" target="_blank"><img src="https://opencollective.com/debug/backer/3/avatar.svg"></a>
<a href="https://opencollective.com/debug/backer/4/website" target="_blank"><img src="https://opencollective.com/debug/backer/4/avatar.svg"></a>
<a href="https://opencollective.com/debug/backer/5/website" target="_blank"><img src="https://opencollective.com/debug/backer/5/avatar.svg"></a>
<a href="https://opencollective.com/debug/backer/6/website" target="_blank"><img src="https://opencollective.com/debug/backer/6/avatar.svg"></a>
<a href="https://opencollective.com/debug/backer/7/website" target="_blank"><img src="https://opencollective.com/debug/backer/7/avatar.svg"></a>
<a href="https://opencollective.com/debug/backer/8/website" target="_blank"><img src="https://opencollective.com/debug/backer/8/avatar.svg"></a>
<a href="https://opencollective.com/debug/backer/9/website" target="_blank"><img src="https://opencollective.com/debug/backer/9/avatar.svg"></a>
<a href="https://opencollective.com/debug/backer/10/website" target="_blank"><img src="https://opencollective.com/debug/backer/10/avatar.svg"></a>
<a href="https://opencollective.com/debug/backer/11/website" target="_blank"><img src="https://opencollective.com/debug/backer/11/avatar.svg"></a>
<a href="https://opencollective.com/debug/backer/12/website" target="_blank"><img src="https://opencollective.com/debug/backer/12/avatar.svg"></a>
<a href="https://opencollective.com/debug/backer/13/website" target="_blank"><img src="https://opencollective.com/debug/backer/13/avatar.svg"></a>
<a href="https://opencollective.com/debug/backer/14/website" target="_blank"><img src="https://opencollective.com/debug/backer/14/avatar.svg"></a>
<a href="https://opencollective.com/debug/backer/15/website" target="_blank"><img src="https://opencollective.com/debug/backer/15/avatar.svg"></a>
<a href="https://opencollective.com/debug/backer/16/website" target="_blank"><img src="https://opencollective.com/debug/backer/16/avatar.svg"></a>
<a href="https://opencollective.com/debug/backer/17/website" target="_blank"><img src="https://opencollective.com/debug/backer/17/avatar.svg"></a>
<a href="https://opencollective.com/debug/backer/18/website" target="_blank"><img src="https://opencollective.com/debug/backer/18/avatar.svg"></a>
<a href="https://opencollective.com/debug/backer/19/website" target="_blank"><img src="https://opencollective.com/debug/backer/19/avatar.svg"></a>
<a href="https://opencollective.com/debug/backer/20/website" target="_blank"><img src="https://opencollective.com/debug/backer/20/avatar.svg"></a>
<a href="https://opencollective.com/debug/backer/21/website" target="_blank"><img src="https://opencollective.com/debug/backer/21/avatar.svg"></a>
<a href="https://opencollective.com/debug/backer/22/website" target="_blank"><img src="https://opencollective.com/debug/backer/22/avatar.svg"></a>
<a href="https://opencollective.com/debug/backer/23/website" target="_blank"><img src="https://opencollective.com/debug/backer/23/avatar.svg"></a>
<a href="https://opencollective.com/debug/backer/24/website" target="_blank"><img src="https://opencollective.com/debug/backer/24/avatar.svg"></a>
<a href="https://opencollective.com/debug/backer/25/website" target="_blank"><img src="https://opencollective.com/debug/backer/25/avatar.svg"></a>
<a href="https://opencollective.com/debug/backer/26/website" target="_blank"><img src="https://opencollective.com/debug/backer/26/avatar.svg"></a>
<a href="https://opencollective.com/debug/backer/27/website" target="_blank"><img src="https://opencollective.com/debug/backer/27/avatar.svg"></a>
<a href="https://opencollective.com/debug/backer/28/website" target="_blank"><img src="https://opencollective.com/debug/backer/28/avatar.svg"></a>
<a href="https://opencollective.com/debug/backer/29/website" target="_blank"><img src="https://opencollective.com/debug/backer/29/avatar.svg"></a>


## Sponsors

Become a sponsor and get your logo on our README on Github with a link to your site. [[Become a sponsor](https://opencollective.com/debug#sponsor)]

<a href="https://opencollective.com/debug/sponsor/0/website" target="_blank"><img src="https://opencollective.com/debug/sponsor/0/avatar.svg"></a>
<a href="https://opencollective.com/debug/sponsor/1/website" target="_blank"><img src="https://opencollective.com/debug/sponsor/1/avatar.svg"></a>
<a href="https://opencollective.com/debug/sponsor/2/website" target="_blank"><img src="https://opencollective.com/debug/sponsor/2/avatar.svg"></a>
<a href="https://opencollective.com/debug/sponsor/3/website" target="_blank"><img src="https://opencollective.com/debug/sponsor/3/avatar.svg"></a>
<a href="https://opencollective.com/debug/sponsor/4/website" target="_blank"><img src="https://opencollective.com/debug/sponsor/4/avatar.svg"></a>
<a href="https://opencollective.com/debug/sponsor/5/website" target="_blank"><img src="https://opencollective.com/debug/sponsor/5/avatar.svg"></a>
<a href="https://opencollective.com/debug/sponsor/6/website" target="_blank"><img src="https://opencollective.com/debug/sponsor/6/avatar.svg"></a>
<a href="https://opencollective.com/debug/sponsor/7/website" target="_blank"><img src="https://opencollective.com/debug/sponsor/7/avatar.svg"></a>
<a href="https://opencollective.com/debug/sponsor/8/website" target="_blank"><img src="https://opencollective.com/debug/sponsor/8/avatar.svg"></a>
<a href="https://opencollective.com/debug/sponsor/9/website" target="_blank"><img src="https://opencollective.com/debug/sponsor/9/avatar.svg"></a>
<a href="https://opencollective.com/debug/sponsor/10/website" target="_blank"><img src="https://opencollective.com/debug/sponsor/10/avatar.svg"></a>
<a href="https://opencollective.com/debug/sponsor/11/website" target="_blank"><img src="https://opencollective.com/debug/sponsor/11/avatar.svg"></a>
<a href="https://opencollective.com/debug/sponsor/12/website" target="_blank"><img src="https://opencollective.com/debug/sponsor/12/avatar.svg"></a>
<a href="https://opencollective.com/debug/sponsor/13/website" target="_blank"><img src="https://opencollective.com/debug/sponsor/13/avatar.svg"></a>
<a href="https://opencollective.com/debug/sponsor/14/website" target="_blank"><img src="https://opencollective.com/debug/sponsor/14/avatar.svg"></a>
<a href="https://opencollective.com/debug/sponsor/15/website" target="_blank"><img src="https://opencollective.com/debug/sponsor/15/avatar.svg"></a>
<a href="https://opencollective.com/debug/sponsor/16/website" target="_blank"><img src="https://opencollective.com/debug/sponsor/16/avatar.svg"></a>
<a href="https://opencollective.com/debug/sponsor/17/website" target="_blank"><img src="https://opencollective.com/debug/sponsor/17/avatar.svg"></a>
<a href="https://opencollective.com/debug/sponsor/18/website" target="_blank"><img src="https://opencollective.com/debug/sponsor/18/avatar.svg"></a>
<a href="https://opencollective.com/debug/sponsor/19/website" target="_blank"><img src="https://opencollective.com/debug/sponsor/19/avatar.svg"></a>
<a href="https://opencollective.com/debug/sponsor/20/website" target="_blank"><img src="https://opencollective.com/debug/sponsor/20/avatar.svg"></a>
<a href="https://opencollective.com/debug/sponsor/21/website" target="_blank"><img src="https://opencollective.com/debug/sponsor/21/avatar.svg"></a>
<a href="https://opencollective.com/debug/sponsor/22/website" target="_blank"><img src="https://opencollective.com/debug/sponsor/22/avatar.svg"></a>
<a href="https://opencollective.com/debug/sponsor/23/website" target="_blank"><img src="https://opencollective.com/debug/sponsor/23/avatar.svg"></a>
<a href="https://opencollective.com/debug/sponsor/24/website" target="_blank"><img src="https://opencollective.com/debug/sponsor/24/avatar.svg"></a>
<a href="https://opencollective.com/debug/sponsor/25/website" target="_blank"><img src="https://opencollective.com/debug/sponsor/25/avatar.svg"></a>
<a href="https://opencollective.com/debug/sponsor/26/website" target="_blank"><img src="https://opencollective.com/debug/sponsor/26/avatar.svg"></a>
<a href="https://opencollective.com/debug/sponsor/27/website" target="_blank"><img src="https://opencollective.com/debug/sponsor/27/avatar.svg"></a>
<a href="https://opencollective.com/debug/sponsor/28/website" target="_blank"><img src="https://opencollective.com/debug/sponsor/28/avatar.svg"></a>
<a href="https://opencollective.com/debug/sponsor/29/website" target="_blank"><img src="https://opencollective.com/debug/sponsor/29/avatar.svg"></a>

## License

(The MIT License)

Copyright (c) 2014-2016 TJ Holowaychuk &lt;tj@vision-media.ca&gt;

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

## ./node_modules/deep-extend

Deep Extend
===========

Recursive object extending.

[![Build Status](https://api.travis-ci.org/unclechu/node-deep-extend.svg?branch=master)](https://travis-ci.org/unclechu/node-deep-extend)

[![NPM](https://nodei.co/npm/deep-extend.png?downloads=true&downloadRank=true&stars=true)](https://nodei.co/npm/deep-extend/)

Install
-------

```bash
$ npm install deep-extend
```

Usage
-----

```javascript
var deepExtend = require('deep-extend');
var obj1 = {
  a: 1,
  b: 2,
  d: {
    a: 1,
    b: [],
    c: { test1: 123, test2: 321 }
  },
  f: 5,
  g: 123,
  i: 321,
  j: [1, 2]
};
var obj2 = {
  b: 3,
  c: 5,
  d: {
    b: { first: 'one', second: 'two' },
    c: { test2: 222 }
  },
  e: { one: 1, two: 2 },
  f: [],
  g: (void 0),
  h: /abc/g,
  i: null,
  j: [3, 4]
};

deepExtend(obj1, obj2);

console.log(obj1);
/*
{ a: 1,
  b: 3,
  d:
   { a: 1,
     b: { first: 'one', second: 'two' },
     c: { test1: 123, test2: 222 } },
  f: [],
  g: undefined,
  c: 5,
  e: { one: 1, two: 2 },
  h: /abc/g,
  i: null,
  j: [3, 4] }
*/
```

Unit testing
------------

```bash
$ npm test
```

Changelog
---------

[CHANGELOG.md](./CHANGELOG.md)

Any issues?
-----------

Please, report about issues
[here](https://github.com/unclechu/node-deep-extend/issues).

License
-------

[MIT](./LICENSE)

## ./node_modules/eastasianwidth

# East Asian Width

Get [East Asian Width](http://www.unicode.org/reports/tr11/) from a character.

'F'(Fullwidth), 'H'(Halfwidth), 'W'(Wide), 'Na'(Narrow), 'A'(Ambiguous) or 'N'(Natural).

Original Code is [東アジアの文字幅 (East Asian Width) の判定 - 中途](http://d.hatena.ne.jp/takenspc/20111126#1322252878).

## Install

    $ npm install eastasianwidth

## Usage

    var eaw = require('eastasianwidth');
    console.log(eaw.eastAsianWidth('￦')) // 'F'
    console.log(eaw.eastAsianWidth('｡')) // 'H'
    console.log(eaw.eastAsianWidth('뀀')) // 'W'
    console.log(eaw.eastAsianWidth('a')) // 'Na'
    console.log(eaw.eastAsianWidth('①')) // 'A'
    console.log(eaw.eastAsianWidth('ف')) // 'N'

    console.log(eaw.characterLength('￦')) // 2
    console.log(eaw.characterLength('｡')) // 1
    console.log(eaw.characterLength('뀀')) // 2
    console.log(eaw.characterLength('a')) // 1
    console.log(eaw.characterLength('①')) // 2
    console.log(eaw.characterLength('ف')) // 1

    console.log(eaw.length('あいうえお')) // 10
    console.log(eaw.length('abcdefg')) // 7
    console.log(eaw.length('￠￦｡ￜㄅ뀀¢⟭a⊙①بف')) // 19

## ./node_modules/emoji-regex

# emoji-regex [![Build status](https://travis-ci.org/mathiasbynens/emoji-regex.svg?branch=main)](https://travis-ci.org/mathiasbynens/emoji-regex)

_emoji-regex_ offers a regular expression to match all emoji symbols and sequences (including textual representations of emoji) as per the Unicode Standard.

This repository contains a script that generates this regular expression based on [Unicode data](https://github.com/node-unicode/node-unicode-data). Because of this, the regular expression can easily be updated whenever new emoji are added to the Unicode standard.

## Installation

Via [npm](https://www.npmjs.com/):

```bash
npm install emoji-regex
```

In [Node.js](https://nodejs.org/):

```js
const emojiRegex = require('emoji-regex/RGI_Emoji.js');
// Note: because the regular expression has the global flag set, this module
// exports a function that returns the regex rather than exporting the regular
// expression itself, to make it impossible to (accidentally) mutate the
// original regular expression.

const text = `
\u{231A}: ⌚ default emoji presentation character (Emoji_Presentation)
\u{2194}\u{FE0F}: ↔️ default text presentation character rendered as emoji
\u{1F469}: 👩 emoji modifier base (Emoji_Modifier_Base)
\u{1F469}\u{1F3FF}: 👩🏿 emoji modifier base followed by a modifier
`;

const regex = emojiRegex();
let match;
while (match = regex.exec(text)) {
  const emoji = match[0];
  console.log(`Matched sequence ${ emoji } — code points: ${ [...emoji].length }`);
}
```

Console output:

```
Matched sequence ⌚ — code points: 1
Matched sequence ⌚ — code points: 1
Matched sequence ↔️ — code points: 2
Matched sequence ↔️ — code points: 2
Matched sequence 👩 — code points: 1
Matched sequence 👩 — code points: 1
Matched sequence 👩🏿 — code points: 2
Matched sequence 👩🏿 — code points: 2
```

## Regular expression flavors

The package comes with three distinct regular expressions:

```js
// This is the recommended regular expression to use. It matches all
// emoji recommended for general interchange, as defined via the
// `RGI_Emoji` property in the Unicode Standard.
// https://unicode.org/reports/tr51/#def_rgi_set
// When in doubt, use this!
const emojiRegexRGI = require('emoji-regex/RGI_Emoji.js');

// This is the old regular expression, prior to `RGI_Emoji` being
// standardized. In addition to all `RGI_Emoji` sequences, it matches
// some emoji you probably don’t want to match (such as emoji component
// symbols that are not meant to be used separately).
const emojiRegex = require('emoji-regex/index.js');

// This regular expression matches even more emoji than the previous
// one, including emoji that render as text instead of icons (i.e.
// emoji that are not `Emoji_Presentation` symbols and that aren’t
// forced to render as emoji by a variation selector).
const emojiRegexText = require('emoji-regex/text.js');
```

Additionally, in environments which support ES2015 Unicode escapes, you may `require` ES2015-style versions of the regexes:

```js
const emojiRegexRGI = require('emoji-regex/es2015/RGI_Emoji.js');
const emojiRegex = require('emoji-regex/es2015/index.js');
const emojiRegexText = require('emoji-regex/es2015/text.js');
```

## For maintainers

### How to update emoji-regex after new Unicode Standard releases

1. Update the Unicode data dependency in `package.json` by running the following commands:

    ```sh
    # Example: updating from Unicode v12 to Unicode v13.
    npm uninstall @unicode/unicode-12.0.0
    npm install @unicode/unicode-13.0.0 --save-dev
    ````

1. Generate the new output:

    ```sh
    npm run build
    ```

1. Verify that tests still pass:

    ```sh
    npm test
    ```

1. Send a pull request with the changes, and get it reviewed & merged.

1. On the `main` branch, bump the emoji-regex version number in `package.json`:

    ```sh
    npm version patch -m 'Release v%s'
    ```

    Instead of `patch`, use `minor` or `major` [as needed](https://semver.org/).

    Note that this produces a Git commit + tag.

1. Push the release commit and tag:

    ```sh
    git push
    ```

    Our CI then automatically publishes the new release to npm.

## Author

| [![twitter/mathias](https://gravatar.com/avatar/24e08a9ea84deb17ae121074d0f17125?s=70)](https://twitter.com/mathias "Follow @mathias on Twitter") |
|---|
| [Mathias Bynens](https://mathiasbynens.be/) |

## License

_emoji-regex_ is available under the [MIT](https://mths.be/mit) license.

## ./node_modules/fast-deep-equal

# fast-deep-equal
The fastest deep equal with ES6 Map, Set and Typed arrays support.

[![Build Status](https://travis-ci.org/epoberezkin/fast-deep-equal.svg?branch=master)](https://travis-ci.org/epoberezkin/fast-deep-equal)
[![npm](https://img.shields.io/npm/v/fast-deep-equal.svg)](https://www.npmjs.com/package/fast-deep-equal)
[![Coverage Status](https://coveralls.io/repos/github/epoberezkin/fast-deep-equal/badge.svg?branch=master)](https://coveralls.io/github/epoberezkin/fast-deep-equal?branch=master)


## Install

```bash
npm install fast-deep-equal
```


## Features

- ES5 compatible
- works in node.js (8+) and browsers (IE9+)
- checks equality of Date and RegExp objects by value.

ES6 equal (`require('fast-deep-equal/es6')`) also supports:
- Maps
- Sets
- Typed arrays


## Usage

```javascript
var equal = require('fast-deep-equal');
console.log(equal({foo: 'bar'}, {foo: 'bar'})); // true
```

To support ES6 Maps, Sets and Typed arrays equality use:

```javascript
var equal = require('fast-deep-equal/es6');
console.log(equal(Int16Array([1, 2]), Int16Array([1, 2]))); // true
```

To use with React (avoiding the traversal of React elements' _owner
property that contains circular references and is not needed when
comparing the elements - borrowed from [react-fast-compare](https://github.com/FormidableLabs/react-fast-compare)):

```javascript
var equal = require('fast-deep-equal/react');
var equal = require('fast-deep-equal/es6/react');
```


## Performance benchmark

Node.js v12.6.0:

```
fast-deep-equal x 261,950 ops/sec ±0.52% (89 runs sampled)
fast-deep-equal/es6 x 212,991 ops/sec ±0.34% (92 runs sampled)
fast-equals x 230,957 ops/sec ±0.83% (85 runs sampled)
nano-equal x 187,995 ops/sec ±0.53% (88 runs sampled)
shallow-equal-fuzzy x 138,302 ops/sec ±0.49% (90 runs sampled)
underscore.isEqual x 74,423 ops/sec ±0.38% (89 runs sampled)
lodash.isEqual x 36,637 ops/sec ±0.72% (90 runs sampled)
deep-equal x 2,310 ops/sec ±0.37% (90 runs sampled)
deep-eql x 35,312 ops/sec ±0.67% (91 runs sampled)
ramda.equals x 12,054 ops/sec ±0.40% (91 runs sampled)
util.isDeepStrictEqual x 46,440 ops/sec ±0.43% (90 runs sampled)
assert.deepStrictEqual x 456 ops/sec ±0.71% (88 runs sampled)

The fastest is fast-deep-equal
```

To run benchmark (requires node.js 6+):

```bash
npm run benchmark
```

__Please note__: this benchmark runs against the available test cases. To choose the most performant library for your application, it is recommended to benchmark against your data and to NOT expect this benchmark to reflect the performance difference in your application.


## Enterprise support

fast-deep-equal package is a part of [Tidelift enterprise subscription](https://tidelift.com/subscription/pkg/npm-fast-deep-equal?utm_source=npm-fast-deep-equal&utm_medium=referral&utm_campaign=enterprise&utm_term=repo) - it provides a centralised commercial support to open-source software users, in addition to the support provided by software maintainers.


## Security contact

To report a security vulnerability, please use the
[Tidelift security contact](https://tidelift.com/security).
Tidelift will coordinate the fix and disclosure. Please do NOT report security vulnerability via GitHub issues.


## License

[MIT](https://github.com/epoberezkin/fast-deep-equal/blob/master/LICENSE)

## ./node_modules/fs-extra

Node.js: fs-extra
=================

`fs-extra` adds file system methods that aren't included in the native `fs` module and adds promise support to the `fs` methods. It also uses [`graceful-fs`](https://github.com/isaacs/node-graceful-fs) to prevent `EMFILE` errors. It should be a drop in replacement for `fs`.

[![npm Package](https://img.shields.io/npm/v/fs-extra.svg)](https://www.npmjs.org/package/fs-extra)
[![License](https://img.shields.io/npm/l/fs-extra.svg)](https://github.com/jprichardson/node-fs-extra/blob/master/LICENSE)
[![build status](https://img.shields.io/github/actions/workflow/status/jprichardson/node-fs-extra/ci.yml?branch=master)](https://github.com/jprichardson/node-fs-extra/actions/workflows/ci.yml?query=branch%3Amaster)
[![downloads per month](http://img.shields.io/npm/dm/fs-extra.svg)](https://www.npmjs.org/package/fs-extra)
[![JavaScript Style Guide](https://img.shields.io/badge/code_style-standard-brightgreen.svg)](https://standardjs.com)

Why?
----

I got tired of including `mkdirp`, `rimraf`, and `ncp` in most of my projects.




Installation
------------

    npm install fs-extra



Usage
-----

### CommonJS

`fs-extra` is a drop in replacement for native `fs`. All methods in `fs` are attached to `fs-extra`. All `fs` methods return promises if the callback isn't passed.

You don't ever need to include the original `fs` module again:

```js
const fs = require('fs') // this is no longer necessary
```

you can now do this:

```js
const fs = require('fs-extra')
```

or if you prefer to make it clear that you're using `fs-extra` and not `fs`, you may want
to name your `fs` variable `fse` like so:

```js
const fse = require('fs-extra')
```

you can also keep both, but it's redundant:

```js
const fs = require('fs')
const fse = require('fs-extra')
```

### ESM

There is also an `fs-extra/esm` import, that supports both default and named exports. However, note that `fs` methods are not included in `fs-extra/esm`; you still need to import `fs` and/or `fs/promises` seperately:

```js
import { readFileSync } from 'fs'
import { readFile } from 'fs/promises'
import { outputFile, outputFileSync } from 'fs-extra/esm'
```

Default exports are supported:

```js
import fs from 'fs'
import fse from 'fs-extra/esm'
// fse.readFileSync is not a function; must use fs.readFileSync
```

but you probably want to just use regular `fs-extra` instead of `fs-extra/esm` for default exports:

```js
import fs from 'fs-extra'
// both fs and fs-extra methods are defined
```

Sync vs Async vs Async/Await
-------------
Most methods are async by default. All async methods will return a promise if the callback isn't passed.

Sync methods on the other hand will throw if an error occurs.

Also Async/Await will throw an error if one occurs.

Example:

```js
const fs = require('fs-extra')

// Async with promises:
fs.copy('/tmp/myfile', '/tmp/mynewfile')
  .then(() => console.log('success!'))
  .catch(err => console.error(err))

// Async with callbacks:
fs.copy('/tmp/myfile', '/tmp/mynewfile', err => {
  if (err) return console.error(err)
  console.log('success!')
})

// Sync:
try {
  fs.copySync('/tmp/myfile', '/tmp/mynewfile')
  console.log('success!')
} catch (err) {
  console.error(err)
}

// Async/Await:
async function copyFiles () {
  try {
    await fs.copy('/tmp/myfile', '/tmp/mynewfile')
    console.log('success!')
  } catch (err) {
    console.error(err)
  }
}

copyFiles()
```


Methods
-------

### Async

- [copy](docs/copy.md)
- [emptyDir](docs/emptyDir.md)
- [ensureFile](docs/ensureFile.md)
- [ensureDir](docs/ensureDir.md)
- [ensureLink](docs/ensureLink.md)
- [ensureSymlink](docs/ensureSymlink.md)
- [mkdirp](docs/ensureDir.md)
- [mkdirs](docs/ensureDir.md)
- [move](docs/move.md)
- [outputFile](docs/outputFile.md)
- [outputJson](docs/outputJson.md)
- [pathExists](docs/pathExists.md)
- [readJson](docs/readJson.md)
- [remove](docs/remove.md)
- [writeJson](docs/writeJson.md)

### Sync

- [copySync](docs/copy-sync.md)
- [emptyDirSync](docs/emptyDir-sync.md)
- [ensureFileSync](docs/ensureFile-sync.md)
- [ensureDirSync](docs/ensureDir-sync.md)
- [ensureLinkSync](docs/ensureLink-sync.md)
- [ensureSymlinkSync](docs/ensureSymlink-sync.md)
- [mkdirpSync](docs/ensureDir-sync.md)
- [mkdirsSync](docs/ensureDir-sync.md)
- [moveSync](docs/move-sync.md)
- [outputFileSync](docs/outputFile-sync.md)
- [outputJsonSync](docs/outputJson-sync.md)
- [pathExistsSync](docs/pathExists-sync.md)
- [readJsonSync](docs/readJson-sync.md)
- [removeSync](docs/remove-sync.md)
- [writeJsonSync](docs/writeJson-sync.md)


**NOTE:** You can still use the native Node.js methods. They are promisified and copied over to `fs-extra`. See [notes on `fs.read()`, `fs.write()`, & `fs.writev()`](docs/fs-read-write-writev.md)

### What happened to `walk()` and `walkSync()`?

They were removed from `fs-extra` in v2.0.0. If you need the functionality, `walk` and `walkSync` are available as separate packages, [`klaw`](https://github.com/jprichardson/node-klaw) and [`klaw-sync`](https://github.com/manidlou/node-klaw-sync).


Third Party
-----------

### CLI

[fse-cli](https://www.npmjs.com/package/@atao60/fse-cli) allows you to run `fs-extra` from a console or from [npm](https://www.npmjs.com) scripts.

### TypeScript

If you like TypeScript, you can use `fs-extra` with it: https://github.com/DefinitelyTyped/DefinitelyTyped/tree/master/types/fs-extra


### File / Directory Watching

If you want to watch for changes to files or directories, then you should use [chokidar](https://github.com/paulmillr/chokidar).

### Obtain Filesystem (Devices, Partitions) Information

[fs-filesystem](https://github.com/arthurintelligence/node-fs-filesystem) allows you to read the state of the filesystem of the host on which it is run. It returns information about both the devices and the partitions (volumes) of the system.

### Misc.

- [fs-extra-debug](https://github.com/jdxcode/fs-extra-debug) - Send your fs-extra calls to [debug](https://npmjs.org/package/debug).
- [mfs](https://github.com/cadorn/mfs) - Monitor your fs-extra calls.



Hacking on fs-extra
-------------------

Wanna hack on `fs-extra`? Great! Your help is needed! [fs-extra is one of the most depended upon Node.js packages](http://nodei.co/npm/fs-extra.png?downloads=true&downloadRank=true&stars=true). This project
uses [JavaScript Standard Style](https://github.com/feross/standard) - if the name or style choices bother you,
you're gonna have to get over it :) If `standard` is good enough for `npm`, it's good enough for `fs-extra`.

[![js-standard-style](https://cdn.rawgit.com/feross/standard/master/badge.svg)](https://github.com/feross/standard)

What's needed?
- First, take a look at existing issues. Those are probably going to be where the priority lies.
- More tests for edge cases. Specifically on different platforms. There can never be enough tests.
- Improve test coverage.

Note: If you make any big changes, **you should definitely file an issue for discussion first.**

### Running the Test Suite

fs-extra contains hundreds of tests.

- `npm run lint`: runs the linter ([standard](http://standardjs.com/))
- `npm run unit`: runs the unit tests
- `npm run unit-esm`: runs tests for `fs-extra/esm` exports
- `npm test`: runs the linter and all tests

When running unit tests, set the environment variable `CROSS_DEVICE_PATH` to the absolute path of an empty directory on another device (like a thumb drive) to enable cross-device move tests.


### Windows

If you run the tests on the Windows and receive a lot of symbolic link `EPERM` permission errors, it's
because on Windows you need elevated privilege to create symbolic links. You can add this to your Windows's
account by following the instructions here: http://superuser.com/questions/104845/permission-to-make-symbolic-links-in-windows-7
However, I didn't have much luck doing this.

Since I develop on Mac OS X, I use VMWare Fusion for Windows testing. I create a shared folder that I map to a drive on Windows.
I open the `Node.js command prompt` and run as `Administrator`. I then map the network drive running the following command:

    net use z: "\\vmware-host\Shared Folders"

I can then navigate to my `fs-extra` directory and run the tests.


Naming
------

I put a lot of thought into the naming of these functions. Inspired by @coolaj86's request. So he deserves much of the credit for raising the issue. See discussion(s) here:

* https://github.com/jprichardson/node-fs-extra/issues/2
* https://github.com/flatiron/utile/issues/11
* https://github.com/ryanmcgrath/wrench-js/issues/29
* https://github.com/substack/node-mkdirp/issues/17

First, I believe that in as many cases as possible, the [Node.js naming schemes](http://nodejs.org/api/fs.html) should be chosen. However, there are problems with the Node.js own naming schemes.

For example, `fs.readFile()` and `fs.readdir()`: the **F** is capitalized in *File* and the **d** is not capitalized in *dir*. Perhaps a bit pedantic, but they should still be consistent. Also, Node.js has chosen a lot of POSIX naming schemes, which I believe is great. See: `fs.mkdir()`, `fs.rmdir()`, `fs.chown()`, etc.

We have a dilemma though. How do you consistently name methods that perform the following POSIX commands: `cp`, `cp -r`, `mkdir -p`, and `rm -rf`?

My perspective: when in doubt, err on the side of simplicity. A directory is just a hierarchical grouping of directories and files. Consider that for a moment. So when you want to copy it or remove it, in most cases you'll want to copy or remove all of its contents. When you want to create a directory, if the directory that it's suppose to be contained in does not exist, then in most cases you'll want to create that too.

So, if you want to remove a file or a directory regardless of whether it has contents, just call `fs.remove(path)`. If you want to copy a file or a directory whether it has contents, just call `fs.copy(source, destination)`. If you want to create a directory regardless of whether its parent directories exist, just call `fs.mkdirs(path)` or `fs.mkdirp(path)`.


Credit
------

`fs-extra` wouldn't be possible without using the modules from the following authors:

- [Isaac Shlueter](https://github.com/isaacs)
- [Charlie McConnel](https://github.com/avianflu)
- [James Halliday](https://github.com/substack)
- [Andrew Kelley](https://github.com/andrewrk)




License
-------

Licensed under MIT

Copyright (c) 2011-2024 [JP Richardson](https://github.com/jprichardson)

[1]: http://nodejs.org/docs/latest/api/fs.html


[jsonfile]: https://github.com/jprichardson/node-jsonfile

## ./node_modules/graceful-fs

# graceful-fs

graceful-fs functions as a drop-in replacement for the fs module,
making various improvements.

The improvements are meant to normalize behavior across different
platforms and environments, and to make filesystem access more
resilient to errors.

## Improvements over [fs module](https://nodejs.org/api/fs.html)

* Queues up `open` and `readdir` calls, and retries them once
  something closes if there is an EMFILE error from too many file
  descriptors.
* fixes `lchmod` for Node versions prior to 0.6.2.
* implements `fs.lutimes` if possible. Otherwise it becomes a noop.
* ignores `EINVAL` and `EPERM` errors in `chown`, `fchown` or
  `lchown` if the user isn't root.
* makes `lchmod` and `lchown` become noops, if not available.
* retries reading a file if `read` results in EAGAIN error.

On Windows, it retries renaming a file for up to one second if `EACCESS`
or `EPERM` error occurs, likely because antivirus software has locked
the directory.

## USAGE

```javascript
// use just like fs
var fs = require('graceful-fs')

// now go and do stuff with it...
fs.readFile('some-file-or-whatever', (err, data) => {
  // Do stuff here.
})
```

## Sync methods

This module cannot intercept or handle `EMFILE` or `ENFILE` errors from sync
methods.  If you use sync methods which open file descriptors then you are
responsible for dealing with any errors.

This is a known limitation, not a bug.

## Global Patching

If you want to patch the global fs module (or any other fs-like
module) you can do this:

```javascript
// Make sure to read the caveat below.
var realFs = require('fs')
var gracefulFs = require('graceful-fs')
gracefulFs.gracefulify(realFs)
```

This should only ever be done at the top-level application layer, in
order to delay on EMFILE errors from any fs-using dependencies.  You
should **not** do this in a library, because it can cause unexpected
delays in other parts of the program.

## Changes

This module is fairly stable at this point, and used by a lot of
things.  That being said, because it implements a subtle behavior
change in a core part of the node API, even modest changes can be
extremely breaking, and the versioning is thus biased towards
bumping the major when in doubt.

The main change between major versions has been switching between
providing a fully-patched `fs` module vs monkey-patching the node core
builtin, and the approach by which a non-monkey-patched `fs` was
created.

The goal is to trade `EMFILE` errors for slower fs operations.  So, if
you try to open a zillion files, rather than crashing, `open`
operations will be queued up and wait for something else to `close`.

There are advantages to each approach.  Monkey-patching the fs means
that no `EMFILE` errors can possibly occur anywhere in your
application, because everything is using the same core `fs` module,
which is patched.  However, it can also obviously cause undesirable
side-effects, especially if the module is loaded multiple times.

Implementing a separate-but-identical patched `fs` module is more
surgical (and doesn't run the risk of patching multiple times), but
also imposes the challenge of keeping in sync with the core module.

The current approach loads the `fs` module, and then creates a
lookalike object that has all the same methods, except a few that are
patched.  It is safe to use in all versions of Node from 0.8 through
7.0.

### v4

* Do not monkey-patch the fs module.  This module may now be used as a
  drop-in dep, and users can opt into monkey-patching the fs builtin
  if their app requires it.

### v3

* Monkey-patch fs, because the eval approach no longer works on recent
  node.
* fixed possible type-error throw if rename fails on windows
* verify that we *never* get EMFILE errors
* Ignore ENOSYS from chmod/chown
* clarify that graceful-fs must be used as a drop-in

### v2.1.0

* Use eval rather than monkey-patching fs.
* readdir: Always sort the results
* win32: requeue a file if error has an OK status

### v2.0

* A return to monkey patching
* wrap process.cwd

### v1.1

* wrap readFile
* Wrap fs.writeFile.
* readdir protection
* Don't clobber the fs builtin
* Handle fs.read EAGAIN errors by trying again
* Expose the curOpen counter
* No-op lchown/lchmod if not implemented
* fs.rename patch only for win32
* Patch fs.rename to handle AV software on Windows
* Close #4 Chown should not fail on einval or eperm if non-root
* Fix isaacs/fstream#1 Only wrap fs one time
* Fix #3 Start at 1024 max files, then back off on EMFILE
* lutimes that doens't blow up on Linux
* A full on-rewrite using a queue instead of just swallowing the EMFILE error
* Wrap Read/Write streams as well

### 1.0

* Update engines for node 0.6
* Be lstat-graceful on Windows
* first

## ./node_modules/human-signals

[![Codecov](https://img.shields.io/codecov/c/github/ehmicky/human-signals.svg?label=tested&logo=codecov)](https://codecov.io/gh/ehmicky/human-signals)
[![Travis](https://img.shields.io/badge/cross-platform-4cc61e.svg?logo=travis)](https://travis-ci.org/ehmicky/human-signals)
[![Node](https://img.shields.io/node/v/human-signals.svg?logo=node.js)](https://www.npmjs.com/package/human-signals)
[![Gitter](https://img.shields.io/gitter/room/ehmicky/human-signals.svg?logo=gitter)](https://gitter.im/ehmicky/human-signals)
[![Twitter](https://img.shields.io/badge/%E2%80%8B-twitter-4cc61e.svg?logo=twitter)](https://twitter.com/intent/follow?screen_name=ehmicky)
[![Medium](https://img.shields.io/badge/%E2%80%8B-medium-4cc61e.svg?logo=medium)](https://medium.com/@ehmicky)

Human-friendly process signals.

This is a map of known process signals with some information about each signal.

Unlike
[`os.constants.signals`](https://nodejs.org/api/os.html#os_signal_constants)
this includes:

- human-friendly [descriptions](#description)
- [default actions](#action), including whether they [can be prevented](#forced)
- whether the signal is [supported](#supported) by the current OS

# Example

```js
const { signalsByName, signalsByNumber } = require('human-signals')

console.log(signalsByName.SIGINT)
// {
//   name: 'SIGINT',
//   number: 2,
//   description: 'User interruption with CTRL-C',
//   supported: true,
//   action: 'terminate',
//   forced: false,
//   standard: 'ansi'
// }

console.log(signalsByNumber[8])
// {
//   name: 'SIGFPE',
//   number: 8,
//   description: 'Floating point arithmetic error',
//   supported: true,
//   action: 'core',
//   forced: false,
//   standard: 'ansi'
// }
```

# Install

```bash
npm install human-signals
```

# Usage

## signalsByName

_Type_: `object`

Object whose keys are signal [names](#name) and values are
[signal objects](#signal).

## signalsByNumber

_Type_: `object`

Object whose keys are signal [numbers](#number) and values are
[signal objects](#signal).

## signal

_Type_: `object`

Signal object with the following properties.

### name

_Type_: `string`

Standard name of the signal, for example `'SIGINT'`.

### number

_Type_: `number`

Code number of the signal, for example `2`. While most `number` are
cross-platform, some are different between different OS.

### description

_Type_: `string`

Human-friendly description for the signal, for example
`'User interruption with CTRL-C'`.

### supported

_Type_: `boolean`

Whether the current OS can handle this signal in Node.js using
[`process.on(name, handler)`](https://nodejs.org/api/process.html#process_signal_events).

The list of supported signals
[is OS-specific](https://github.com/ehmicky/cross-platform-node-guide/blob/master/docs/6_networking_ipc/signals.md#cross-platform-signals).

### action

_Type_: `string`\
_Enum_: `'terminate'`, `'core'`, `'ignore'`, `'pause'`, `'unpause'`

What is the default action for this signal when it is not handled.

### forced

_Type_: `boolean`

Whether the signal's default action cannot be prevented. This is `true` for
`SIGTERM`, `SIGKILL` and `SIGSTOP`.

### standard

_Type_: `string`\
_Enum_: `'ansi'`, `'posix'`, `'bsd'`, `'systemv'`, `'other'`

Which standard defined that signal.

# Support

If you found a bug or would like a new feature, _don't hesitate_ to
[submit an issue on GitHub](../../issues).

For other questions, feel free to
[chat with us on Gitter](https://gitter.im/ehmicky/human-signals).

Everyone is welcome regardless of personal background. We enforce a
[Code of conduct](CODE_OF_CONDUCT.md) in order to promote a positive and
inclusive environment.

# Contributing

This project was made with ❤️. The simplest way to give back is by starring and
sharing it online.

If the documentation is unclear or has a typo, please click on the page's `Edit`
button (pencil icon) and suggest a correction.

If you would like to help us fix a bug or add a new feature, please check our
[guidelines](CONTRIBUTING.md). Pull requests are welcome!

Thanks go to our wonderful contributors:

<!-- ALL-CONTRIBUTORS-LIST:START -->
<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->
<table>
  <tr>
    <td align="center"><a href="https://twitter.com/ehmicky"><img src="https://avatars2.githubusercontent.com/u/8136211?v=4" width="100px;" alt=""/><br /><sub><b>ehmicky</b></sub></a><br /><a href="https://github.com/ehmicky/human-signals/commits?author=ehmicky" title="Code">💻</a> <a href="#design-ehmicky" title="Design">🎨</a> <a href="#ideas-ehmicky" title="Ideas, Planning, & Feedback">🤔</a> <a href="https://github.com/ehmicky/human-signals/commits?author=ehmicky" title="Documentation">📖</a></td>
    <td align="center"><a href="http://www.electrovir.com"><img src="https://avatars0.githubusercontent.com/u/1205860?v=4" width="100px;" alt=""/><br /><sub><b>electrovir</b></sub></a><br /><a href="https://github.com/ehmicky/human-signals/commits?author=electrovir" title="Code">💻</a></td>
  </tr>
</table>

<!-- markdownlint-enable -->
<!-- prettier-ignore-end -->

<!-- ALL-CONTRIBUTORS-LIST:END -->

## ./node_modules/husky

# husky

> Modern native Git hooks made easy

Husky improves your commits and more 🐶 *woof!*

# Install

```
npm install husky --save-dev
```

# Usage

Edit `package.json > prepare` script and run it once:

```sh
npm pkg set scripts.prepare="husky install"
npm run prepare
```

Add a hook:

```sh
npx husky add .husky/pre-commit "npm test"
git add .husky/pre-commit
```

Make a commit:

```sh
git commit -m "Keep calm and commit"
# `npm test` will run
```

# Documentation

https://typicode.github.io/husky

## ./node_modules/ini

An ini format parser and serializer for node.

Sections are treated as nested objects.  Items before the first
heading are saved on the object directly.

## Usage

Consider an ini-file `config.ini` that looks like this:

    ; this comment is being ignored
    scope = global

    [database]
    user = dbuser
    password = dbpassword
    database = use_this_database

    [paths.default]
    datadir = /var/lib/data
    array[] = first value
    array[] = second value
    array[] = third value

You can read, manipulate and write the ini-file like so:

    var fs = require('fs')
      , ini = require('ini')

    var config = ini.parse(fs.readFileSync('./config.ini', 'utf-8'))

    config.scope = 'local'
    config.database.database = 'use_another_database'
    config.paths.default.tmpdir = '/tmp'
    delete config.paths.default.datadir
    config.paths.default.array.push('fourth value')

    fs.writeFileSync('./config_modified.ini', ini.stringify(config, { section: 'section' }))

This will result in a file called `config_modified.ini` being written
to the filesystem with the following content:

    [section]
    scope=local
    [section.database]
    user=dbuser
    password=dbpassword
    database=use_another_database
    [section.paths.default]
    tmpdir=/tmp
    array[]=first value
    array[]=second value
    array[]=third value
    array[]=fourth value


## API

### decode(inistring)

Decode the ini-style formatted `inistring` into a nested object.

### parse(inistring)

Alias for `decode(inistring)`

### encode(object, [options])

Encode the object `object` into an ini-style formatted string. If the
optional parameter `section` is given, then all top-level properties
of the object are put into this section and the `section`-string is
prepended to all sub-sections, see the usage example above.

The `options` object may contain the following:

* `section` A string which will be the first `section` in the encoded
  ini data.  Defaults to none.
* `whitespace` Boolean to specify whether to put whitespace around the
  `=` character.  By default, whitespace is omitted, to be friendly to
  some persnickety old parsers that don't tolerate it well.  But some
  find that it's more human-readable and pretty with the whitespace.

For backwards compatibility reasons, if a `string` options is passed
in, then it is assumed to be the `section` value.

### stringify(object, [options])

Alias for `encode(object, [options])`

### safe(val)

Escapes the string `val` such that it is safe to be used as a key or
value in an ini-file. Basically escapes quotes. For example

    ini.safe('"unsafe string"')

would result in

    "\"unsafe string\""

### unsafe(val)

Unescapes the string `val`

## ./node_modules/isexe

# isexe

Minimal module to check if a file is executable, and a normal file.

Uses `fs.stat` and tests against the `PATHEXT` environment variable on
Windows.

## USAGE

```javascript
var isexe = require('isexe')
isexe('some-file-name', function (err, isExe) {
  if (err) {
    console.error('probably file does not exist or something', err)
  } else if (isExe) {
    console.error('this thing can be run')
  } else {
    console.error('cannot be run')
  }
})

// same thing but synchronous, throws errors
var isExe = isexe.sync('some-file-name')

// treat errors as just "not executable"
isexe('maybe-missing-file', { ignoreErrors: true }, callback)
var isExe = isexe.sync('maybe-missing-file', { ignoreErrors: true })
```

## API

### `isexe(path, [options], [callback])`

Check if the path is executable.  If no callback provided, and a
global `Promise` object is available, then a Promise will be returned.

Will raise whatever errors may be raised by `fs.stat`, unless
`options.ignoreErrors` is set to true.

### `isexe.sync(path, [options])`

Same as `isexe` but returns the value and throws any errors raised.

### Options

* `ignoreErrors` Treat all errors as "no, this is not executable", but
  don't raise them.
* `uid` Number to use as the user id
* `gid` Number to use as the group id
* `pathExt` List of path extensions to use instead of `PATHEXT`
  environment variable on Windows.

## ./node_modules/jsonfile

Node.js - jsonfile
================

Easily read/write JSON files in Node.js. _Note: this module cannot be used in the browser._

[![npm Package](https://img.shields.io/npm/v/jsonfile.svg?style=flat-square)](https://www.npmjs.org/package/jsonfile)
[![build status](https://secure.travis-ci.org/jprichardson/node-jsonfile.svg)](http://travis-ci.org/jprichardson/node-jsonfile)
[![windows Build status](https://img.shields.io/appveyor/ci/jprichardson/node-jsonfile/master.svg?label=windows%20build)](https://ci.appveyor.com/project/jprichardson/node-jsonfile/branch/master)

<a href="https://github.com/feross/standard"><img src="https://cdn.rawgit.com/feross/standard/master/sticker.svg" alt="Standard JavaScript" width="100"></a>

Why?
----

Writing `JSON.stringify()` and then `fs.writeFile()` and `JSON.parse()` with `fs.readFile()` enclosed in `try/catch` blocks became annoying.



Installation
------------

    npm install --save jsonfile



API
---

* [`readFile(filename, [options], callback)`](#readfilefilename-options-callback)
* [`readFileSync(filename, [options])`](#readfilesyncfilename-options)
* [`writeFile(filename, obj, [options], callback)`](#writefilefilename-obj-options-callback)
* [`writeFileSync(filename, obj, [options])`](#writefilesyncfilename-obj-options)

----

### readFile(filename, [options], callback)

`options` (`object`, default `undefined`): Pass in any [`fs.readFile`](https://nodejs.org/api/fs.html#fs_fs_readfile_path_options_callback) options or set `reviver` for a [JSON reviver](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/JSON/parse).
  - `throws` (`boolean`, default: `true`). If `JSON.parse` throws an error, pass this error to the callback.
  If `false`, returns `null` for the object.


```js
const jsonfile = require('jsonfile')
const file = '/tmp/data.json'
jsonfile.readFile(file, function (err, obj) {
  if (err) console.error(err)
  console.dir(obj)
})
```

You can also use this method with promises. The `readFile` method will return a promise if you do not pass a callback function.

```js
const jsonfile = require('jsonfile')
const file = '/tmp/data.json'
jsonfile.readFile(file)
  .then(obj => console.dir(obj))
  .catch(error => console.error(error))
```

----

### readFileSync(filename, [options])

`options` (`object`, default `undefined`): Pass in any [`fs.readFileSync`](https://nodejs.org/api/fs.html#fs_fs_readfilesync_path_options) options or set `reviver` for a [JSON reviver](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/JSON/parse).
- `throws` (`boolean`, default: `true`). If an error is encountered reading or parsing the file, throw the error. If `false`, returns `null` for the object.

```js
const jsonfile = require('jsonfile')
const file = '/tmp/data.json'

console.dir(jsonfile.readFileSync(file))
```

----

### writeFile(filename, obj, [options], callback)

`options`: Pass in any [`fs.writeFile`](https://nodejs.org/api/fs.html#fs_fs_writefile_file_data_options_callback) options or set `replacer` for a [JSON replacer](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/JSON/stringify). Can also pass in `spaces`, or override `EOL` string or set `finalEOL` flag as `false` to not save the file with `EOL` at the end.


```js
const jsonfile = require('jsonfile')

const file = '/tmp/data.json'
const obj = { name: 'JP' }

jsonfile.writeFile(file, obj, function (err) {
  if (err) console.error(err)
})
```
Or use with promises as follows:

```js
const jsonfile = require('jsonfile')

const file = '/tmp/data.json'
const obj = { name: 'JP' }

jsonfile.writeFile(file, obj)
  .then(res => {
    console.log('Write complete')
  })
  .catch(error => console.error(error))
```


**formatting with spaces:**

```js
const jsonfile = require('jsonfile')

const file = '/tmp/data.json'
const obj = { name: 'JP' }

jsonfile.writeFile(file, obj, { spaces: 2 }, function (err) {
  if (err) console.error(err)
})
```

**overriding EOL:**

```js
const jsonfile = require('jsonfile')

const file = '/tmp/data.json'
const obj = { name: 'JP' }

jsonfile.writeFile(file, obj, { spaces: 2, EOL: '\r\n' }, function (err) {
  if (err) console.error(err)
})
```


**disabling the EOL at the end of file:**

```js
const jsonfile = require('jsonfile')

const file = '/tmp/data.json'
const obj = { name: 'JP' }

jsonfile.writeFile(file, obj, { spaces: 2, finalEOL: false }, function (err) {
  if (err) console.log(err)
})
```

**appending to an existing JSON file:**

You can use `fs.writeFile` option `{ flag: 'a' }` to achieve this.

```js
const jsonfile = require('jsonfile')

const file = '/tmp/mayAlreadyExistedData.json'
const obj = { name: 'JP' }

jsonfile.writeFile(file, obj, { flag: 'a' }, function (err) {
  if (err) console.error(err)
})
```

----

### writeFileSync(filename, obj, [options])

`options`: Pass in any [`fs.writeFileSync`](https://nodejs.org/api/fs.html#fs_fs_writefilesync_file_data_options) options or set `replacer` for a [JSON replacer](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/JSON/stringify). Can also pass in `spaces`, or override `EOL` string or set `finalEOL` flag as `false` to not save the file with `EOL` at the end.

```js
const jsonfile = require('jsonfile')

const file = '/tmp/data.json'
const obj = { name: 'JP' }

jsonfile.writeFileSync(file, obj)
```

**formatting with spaces:**

```js
const jsonfile = require('jsonfile')

const file = '/tmp/data.json'
const obj = { name: 'JP' }

jsonfile.writeFileSync(file, obj, { spaces: 2 })
```

**overriding EOL:**

```js
const jsonfile = require('jsonfile')

const file = '/tmp/data.json'
const obj = { name: 'JP' }

jsonfile.writeFileSync(file, obj, { spaces: 2, EOL: '\r\n' })
```

**disabling the EOL at the end of file:**

```js
const jsonfile = require('jsonfile')

const file = '/tmp/data.json'
const obj = { name: 'JP' }

jsonfile.writeFileSync(file, obj, { spaces: 2, finalEOL: false })
```

**appending to an existing JSON file:**

You can use `fs.writeFileSync` option `{ flag: 'a' }` to achieve this.

```js
const jsonfile = require('jsonfile')

const file = '/tmp/mayAlreadyExistedData.json'
const obj = { name: 'JP' }

jsonfile.writeFileSync(file, obj, { flag: 'a' })
```

License
-------

(MIT License)

Copyright 2012-2016, JP Richardson  <jprichardson@gmail.com>

## ./node_modules/json-schema-traverse

# json-schema-traverse
Traverse JSON Schema passing each schema object to callback

[![build](https://github.com/epoberezkin/json-schema-traverse/workflows/build/badge.svg)](https://github.com/epoberezkin/json-schema-traverse/actions?query=workflow%3Abuild)
[![npm](https://img.shields.io/npm/v/json-schema-traverse)](https://www.npmjs.com/package/json-schema-traverse)
[![coverage](https://coveralls.io/repos/github/epoberezkin/json-schema-traverse/badge.svg?branch=master)](https://coveralls.io/github/epoberezkin/json-schema-traverse?branch=master)


## Install

```
npm install json-schema-traverse
```


## Usage

```javascript
const traverse = require('json-schema-traverse');
const schema = {
  properties: {
    foo: {type: 'string'},
    bar: {type: 'integer'}
  }
};

traverse(schema, {cb});
// cb is called 3 times with:
// 1. root schema
// 2. {type: 'string'}
// 3. {type: 'integer'}

// Or:

traverse(schema, {cb: {pre, post}});
// pre is called 3 times with:
// 1. root schema
// 2. {type: 'string'}
// 3. {type: 'integer'}
//
// post is called 3 times with:
// 1. {type: 'string'}
// 2. {type: 'integer'}
// 3. root schema

```

Callback function `cb` is called for each schema object (not including draft-06 boolean schemas), including the root schema, in pre-order traversal. Schema references ($ref) are not resolved, they are passed as is.  Alternatively, you can pass a `{pre, post}` object as `cb`, and then `pre` will be called before traversing child elements, and `post` will be called after all child elements have been traversed.

Callback is passed these parameters:

- _schema_: the current schema object
- _JSON pointer_: from the root schema to the current schema object
- _root schema_: the schema passed to `traverse` object
- _parent JSON pointer_: from the root schema to the parent schema object (see below)
- _parent keyword_: the keyword inside which this schema appears (e.g. `properties`, `anyOf`, etc.)
- _parent schema_: not necessarily parent object/array; in the example above the parent schema for `{type: 'string'}` is the root schema
- _index/property_: index or property name in the array/object containing multiple schemas; in the example above for `{type: 'string'}` the property name is `'foo'`


## Traverse objects in all unknown keywords

```javascript
const traverse = require('json-schema-traverse');
const schema = {
  mySchema: {
    minimum: 1,
    maximum: 2
  }
};

traverse(schema, {allKeys: true, cb});
// cb is called 2 times with:
// 1. root schema
// 2. mySchema
```

Without option `allKeys: true` callback will be called only with root schema.


## Enterprise support

json-schema-traverse package is a part of [Tidelift enterprise subscription](https://tidelift.com/subscription/pkg/npm-json-schema-traverse?utm_source=npm-json-schema-traverse&utm_medium=referral&utm_campaign=enterprise&utm_term=repo) - it provides a centralised commercial support to open-source software users, in addition to the support provided by software maintainers.


## Security contact

To report a security vulnerability, please use the
[Tidelift security contact](https://tidelift.com/security).
Tidelift will coordinate the fix and disclosure. Please do NOT report security vulnerability via GitHub issues.


## License

[MIT](https://github.com/epoberezkin/json-schema-traverse/blob/master/LICENSE)

## ./node_modules/merge-stream

# merge-stream

Merge (interleave) a bunch of streams.

[![build status](https://secure.travis-ci.org/grncdr/merge-stream.svg?branch=master)](http://travis-ci.org/grncdr/merge-stream)

## Synopsis

```javascript
var stream1 = new Stream();
var stream2 = new Stream();

var merged = mergeStream(stream1, stream2);

var stream3 = new Stream();
merged.add(stream3);
merged.isEmpty();
//=> false
```

## Description

This is adapted from [event-stream](https://github.com/dominictarr/event-stream) separated into a new module, using Streams3.

## API

### `mergeStream`

Type: `function`

Merges an arbitrary number of streams. Returns a merged stream.

#### `merged.add`

A method to dynamically add more sources to the stream. The argument supplied to `add` can be either a source or an array of sources.

#### `merged.isEmpty`

A method that tells you if the merged stream is empty.

When a stream is "empty" (aka. no sources were added), it could not be returned to a gulp task.

So, we could do something like this:

```js
stream = require('merge-stream')();
// Something like a loop to add some streams to the merge stream
// stream.add(streamA);
// stream.add(streamB);
return stream.isEmpty() ? null : stream;
```

## Gulp example

An example use case for **merge-stream** is to combine parts of a task in a project's **gulpfile.js** like this:

```js
const gulp =          require('gulp');
const htmlValidator = require('gulp-w3c-html-validator');
const jsHint =        require('gulp-jshint');
const mergeStream =   require('merge-stream');

function lint() {
  return mergeStream(
    gulp.src('src/*.html')
      .pipe(htmlValidator())
      .pipe(htmlValidator.reporter()),
    gulp.src('src/*.js')
      .pipe(jsHint())
      .pipe(jsHint.reporter())
  );
}
gulp.task('lint', lint);
```

## License

MIT

## ./node_modules/mime-db

# mime-db

[![NPM Version][npm-version-image]][npm-url]
[![NPM Downloads][npm-downloads-image]][npm-url]
[![Node.js Version][node-image]][node-url]
[![Build Status][ci-image]][ci-url]
[![Coverage Status][coveralls-image]][coveralls-url]

This is a large database of mime types and information about them.
It consists of a single, public JSON file and does not include any logic,
allowing it to remain as un-opinionated as possible with an API.
It aggregates data from the following sources:

- https://www.iana.org/assignments/media-types/media-types.xhtml
- https://svn.apache.org/repos/asf/httpd/httpd/trunk/docs/conf/mime.types
- https://hg.nginx.org/nginx/raw-file/default/conf/mime.types

## Installation

```bash
npm install mime-db
```

### Database Download

If you intend to use this in a web browser, you can conveniently access the JSON file via [jsDelivr](https://www.jsdelivr.com/), a popular CDN (Content Delivery Network). To ensure stability and compatibility, it is advisable to specify [a release tag](https://github.com/jshttp/mime-db/tags) instead of using the 'master' branch. This is because the JSON file's format might change in future updates, and relying on a specific release tag will prevent potential issues arising from these changes.

```
https://cdn.jsdelivr.net/gh/jshttp/mime-db@master/db.json
```

## Usage

```js
var db = require('mime-db')

// grab data on .js files
var data = db['application/javascript']
```

## Data Structure

The JSON file is a map lookup for lowercased mime types.
Each mime type has the following properties:

- `.source` - where the mime type is defined.
    If not set, it's probably a custom media type.
    - `apache` - [Apache common media types](https://svn.apache.org/repos/asf/httpd/httpd/trunk/docs/conf/mime.types)
    - `iana` - [IANA-defined media types](https://www.iana.org/assignments/media-types/media-types.xhtml)
    - `nginx` - [nginx media types](https://hg.nginx.org/nginx/raw-file/default/conf/mime.types)
- `.extensions[]` - known extensions associated with this mime type.
- `.compressible` - whether a file of this type can be gzipped.
- `.charset` - the default charset associated with this type, if any.

If unknown, every property could be `undefined`.

## Note on MIME Type Data and Semver

This package considers the programmatic api as the semver compatibility. This means the MIME type resolution is *not* considered
in the semver bumps. This means that if you want to pin your `mime-db` data you will need to do it in your application. While
this expectation was not set in docs until now, it is how the pacakge operated, so we do not feel this is a breaking change.

## Contributing

The primary way to contribute to this database is by updating the data in
one of the upstream sources. The database is updated from the upstreams
periodically and will pull in any changes.

### Registering Media Types

The best way to get new media types included in this library is to register
them with the IANA. The community registration procedure is outlined in
[RFC 6838 section 5](https://tools.ietf.org/html/rfc6838#section-5). Types
registered with the IANA are automatically pulled into this library.

### Direct Inclusion

If that is not possible / feasible, they can be added directly here as a
"custom" type. To do this, it is required to have a primary source that
definitively lists the media type. If an extension is going to be listed as
associated with this media type, the source must definitively link the
media type and extension as well.

To edit the database, only make PRs against `src/custom-types.json` or
`src/custom-suffix.json`.

The `src/custom-types.json` file is a JSON object with the MIME type as the
keys and the values being an object with the following keys:

- `compressible` - leave out if you don't know, otherwise `true`/`false` to
  indicate whether the data represented by the type is typically compressible.
- `extensions` - include an array of file extensions that are associated with
  the type.
- `notes` - human-readable notes about the type, typically what the type is.
- `sources` - include an array of URLs of where the MIME type and the associated
  extensions are sourced from. This needs to be a [primary source](https://en.wikipedia.org/wiki/Primary_source);
  links to type aggregating sites and Wikipedia are _not acceptable_.

To update the build, run `npm run build`.

[ci-image]: https://badgen.net/github/checks/jshttp/mime-db/master?label=ci
[ci-url]: https://github.com/jshttp/mime-db/actions/workflows/ci.yml
[coveralls-image]: https://badgen.net/coveralls/c/github/jshttp/mime-db/master
[coveralls-url]: https://coveralls.io/r/jshttp/mime-db?branch=master
[node-image]: https://badgen.net/npm/node/mime-db
[node-url]: https://nodejs.org/en/download
[npm-downloads-image]: https://badgen.net/npm/dm/mime-db
[npm-url]: https://npmjs.org/package/mime-db
[npm-version-image]: https://badgen.net/npm/v/mime-db

## ./node_modules/mime-types/node_modules/mime-db

# mime-db

[![NPM Version][npm-version-image]][npm-url]
[![NPM Downloads][npm-downloads-image]][npm-url]
[![Node.js Version][node-image]][node-url]
[![Build Status][ci-image]][ci-url]
[![Coverage Status][coveralls-image]][coveralls-url]

This is a large database of mime types and information about them.
It consists of a single, public JSON file and does not include any logic,
allowing it to remain as un-opinionated as possible with an API.
It aggregates data from the following sources:

- http://www.iana.org/assignments/media-types/media-types.xhtml
- http://svn.apache.org/repos/asf/httpd/httpd/trunk/docs/conf/mime.types
- http://hg.nginx.org/nginx/raw-file/default/conf/mime.types

## Installation

```bash
npm install mime-db
```

### Database Download

If you're crazy enough to use this in the browser, you can just grab the
JSON file using [jsDelivr](https://www.jsdelivr.com/). It is recommended to
replace `master` with [a release tag](https://github.com/jshttp/mime-db/tags)
as the JSON format may change in the future.

```
https://cdn.jsdelivr.net/gh/jshttp/mime-db@master/db.json
```

## Usage

```js
var db = require('mime-db')

// grab data on .js files
var data = db['application/javascript']
```

## Data Structure

The JSON file is a map lookup for lowercased mime types.
Each mime type has the following properties:

- `.source` - where the mime type is defined.
    If not set, it's probably a custom media type.
    - `apache` - [Apache common media types](http://svn.apache.org/repos/asf/httpd/httpd/trunk/docs/conf/mime.types)
    - `iana` - [IANA-defined media types](http://www.iana.org/assignments/media-types/media-types.xhtml)
    - `nginx` - [nginx media types](http://hg.nginx.org/nginx/raw-file/default/conf/mime.types)
- `.extensions[]` - known extensions associated with this mime type.
- `.compressible` - whether a file of this type can be gzipped.
- `.charset` - the default charset associated with this type, if any.

If unknown, every property could be `undefined`.

## Contributing

To edit the database, only make PRs against `src/custom-types.json` or
`src/custom-suffix.json`.

The `src/custom-types.json` file is a JSON object with the MIME type as the
keys and the values being an object with the following keys:

- `compressible` - leave out if you don't know, otherwise `true`/`false` to
  indicate whether the data represented by the type is typically compressible.
- `extensions` - include an array of file extensions that are associated with
  the type.
- `notes` - human-readable notes about the type, typically what the type is.
- `sources` - include an array of URLs of where the MIME type and the associated
  extensions are sourced from. This needs to be a [primary source](https://en.wikipedia.org/wiki/Primary_source);
  links to type aggregating sites and Wikipedia are _not acceptable_.

To update the build, run `npm run build`.

### Adding Custom Media Types

The best way to get new media types included in this library is to register
them with the IANA. The community registration procedure is outlined in
[RFC 6838 section 5](http://tools.ietf.org/html/rfc6838#section-5). Types
registered with the IANA are automatically pulled into this library.

If that is not possible / feasible, they can be added directly here as a
"custom" type. To do this, it is required to have a primary source that
definitively lists the media type. If an extension is going to be listed as
associateed with this media type, the source must definitively link the
media type and extension as well.

[ci-image]: https://badgen.net/github/checks/jshttp/mime-db/master?label=ci
[ci-url]: https://github.com/jshttp/mime-db/actions?query=workflow%3Aci
[coveralls-image]: https://badgen.net/coveralls/c/github/jshttp/mime-db/master
[coveralls-url]: https://coveralls.io/r/jshttp/mime-db?branch=master
[node-image]: https://badgen.net/npm/node/mime-db
[node-url]: https://nodejs.org/en/download
[npm-downloads-image]: https://badgen.net/npm/dm/mime-db
[npm-url]: https://npmjs.org/package/mime-db
[npm-version-image]: https://badgen.net/npm/v/mime-db

## ./node_modules/mime-types

# mime-types

[![NPM Version][npm-version-image]][npm-url]
[![NPM Downloads][npm-downloads-image]][npm-url]
[![Node.js Version][node-version-image]][node-version-url]
[![Build Status][ci-image]][ci-url]
[![Test Coverage][coveralls-image]][coveralls-url]

The ultimate javascript content-type utility.

Similar to [the `mime@1.x` module](https://www.npmjs.com/package/mime), except:

- __No fallbacks.__ Instead of naively returning the first available type,
  `mime-types` simply returns `false`, so do
  `var type = mime.lookup('unrecognized') || 'application/octet-stream'`.
- No `new Mime()` business, so you could do `var lookup = require('mime-types').lookup`.
- No `.define()` functionality
- Bug fixes for `.lookup(path)`

Otherwise, the API is compatible with `mime` 1.x.

## Install

This is a [Node.js](https://nodejs.org/en/) module available through the
[npm registry](https://www.npmjs.com/). Installation is done using the
[`npm install` command](https://docs.npmjs.com/getting-started/installing-npm-packages-locally):

```sh
$ npm install mime-types
```

## Adding Types

All mime types are based on [mime-db](https://www.npmjs.com/package/mime-db),
so open a PR there if you'd like to add mime types.

## API

```js
var mime = require('mime-types')
```

All functions return `false` if input is invalid or not found.

### mime.lookup(path)

Lookup the content-type associated with a file.

```js
mime.lookup('json') // 'application/json'
mime.lookup('.md') // 'text/markdown'
mime.lookup('file.html') // 'text/html'
mime.lookup('folder/file.js') // 'application/javascript'
mime.lookup('folder/.htaccess') // false

mime.lookup('cats') // false
```

### mime.contentType(type)

Create a full content-type header given a content-type or extension.
When given an extension, `mime.lookup` is used to get the matching
content-type, otherwise the given content-type is used. Then if the
content-type does not already have a `charset` parameter, `mime.charset`
is used to get the default charset and add to the returned content-type.

```js
mime.contentType('markdown') // 'text/x-markdown; charset=utf-8'
mime.contentType('file.json') // 'application/json; charset=utf-8'
mime.contentType('text/html') // 'text/html; charset=utf-8'
mime.contentType('text/html; charset=iso-8859-1') // 'text/html; charset=iso-8859-1'

// from a full path
mime.contentType(path.extname('/path/to/file.json')) // 'application/json; charset=utf-8'
```

### mime.extension(type)

Get the default extension for a content-type.

```js
mime.extension('application/octet-stream') // 'bin'
```

### mime.charset(type)

Lookup the implied default charset of a content-type.

```js
mime.charset('text/markdown') // 'UTF-8'
```

### var type = mime.types[extension]

A map of content-types by extension.

### [extensions...] = mime.extensions[type]

A map of extensions by content-type.

## License

[MIT](LICENSE)

[ci-image]: https://badgen.net/github/checks/jshttp/mime-types/master?label=ci
[ci-url]: https://github.com/jshttp/mime-types/actions/workflows/ci.yml
[coveralls-image]: https://badgen.net/coveralls/c/github/jshttp/mime-types/master
[coveralls-url]: https://coveralls.io/r/jshttp/mime-types?branch=master
[node-version-image]: https://badgen.net/npm/node/mime-types
[node-version-url]: https://nodejs.org/en/download
[npm-downloads-image]: https://badgen.net/npm/dm/mime-types
[npm-url]: https://npmjs.org/package/mime-types
[npm-version-image]: https://badgen.net/npm/v/mime-types

## ./node_modules/minimatch

# minimatch

A minimal matching utility.

[![Build Status](https://travis-ci.org/isaacs/minimatch.svg?branch=master)](http://travis-ci.org/isaacs/minimatch)


This is the matching library used internally by npm.

It works by converting glob expressions into JavaScript `RegExp`
objects.

## Usage

```javascript
var minimatch = require("minimatch")

minimatch("bar.foo", "*.foo") // true!
minimatch("bar.foo", "*.bar") // false!
minimatch("bar.foo", "*.+(bar|foo)", { debug: true }) // true, and noisy!
```

## Features

Supports these glob features:

* Brace Expansion
* Extended glob matching
* "Globstar" `**` matching

See:

* `man sh`
* `man bash`
* `man 3 fnmatch`
* `man 5 gitignore`

## Minimatch Class

Create a minimatch object by instantiating the `minimatch.Minimatch` class.

```javascript
var Minimatch = require("minimatch").Minimatch
var mm = new Minimatch(pattern, options)
```

### Properties

* `pattern` The original pattern the minimatch object represents.
* `options` The options supplied to the constructor.
* `set` A 2-dimensional array of regexp or string expressions.
  Each row in the
  array corresponds to a brace-expanded pattern.  Each item in the row
  corresponds to a single path-part.  For example, the pattern
  `{a,b/c}/d` would expand to a set of patterns like:

        [ [ a, d ]
        , [ b, c, d ] ]

    If a portion of the pattern doesn't have any "magic" in it
    (that is, it's something like `"foo"` rather than `fo*o?`), then it
    will be left as a string rather than converted to a regular
    expression.

* `regexp` Created by the `makeRe` method.  A single regular expression
  expressing the entire pattern.  This is useful in cases where you wish
  to use the pattern somewhat like `fnmatch(3)` with `FNM_PATH` enabled.
* `negate` True if the pattern is negated.
* `comment` True if the pattern is a comment.
* `empty` True if the pattern is `""`.

### Methods

* `makeRe` Generate the `regexp` member if necessary, and return it.
  Will return `false` if the pattern is invalid.
* `match(fname)` Return true if the filename matches the pattern, or
  false otherwise.
* `matchOne(fileArray, patternArray, partial)` Take a `/`-split
  filename, and match it against a single row in the `regExpSet`.  This
  method is mainly for internal use, but is exposed so that it can be
  used by a glob-walker that needs to avoid excessive filesystem calls.

All other methods are internal, and will be called as necessary.

### minimatch(path, pattern, options)

Main export.  Tests a path against the pattern using the options.

```javascript
var isJS = minimatch(file, "*.js", { matchBase: true })
```

### minimatch.filter(pattern, options)

Returns a function that tests its
supplied argument, suitable for use with `Array.filter`.  Example:

```javascript
var javascripts = fileList.filter(minimatch.filter("*.js", {matchBase: true}))
```

### minimatch.match(list, pattern, options)

Match against the list of
files, in the style of fnmatch or glob.  If nothing is matched, and
options.nonull is set, then return a list containing the pattern itself.

```javascript
var javascripts = minimatch.match(fileList, "*.js", {matchBase: true}))
```

### minimatch.makeRe(pattern, options)

Make a regular expression object from the pattern.

## Options

All options are `false` by default.

### debug

Dump a ton of stuff to stderr.

### nobrace

Do not expand `{a,b}` and `{1..3}` brace sets.

### noglobstar

Disable `**` matching against multiple folder names.

### dot

Allow patterns to match filenames starting with a period, even if
the pattern does not explicitly have a period in that spot.

Note that by default, `a/**/b` will **not** match `a/.d/b`, unless `dot`
is set.

### noext

Disable "extglob" style patterns like `+(a|b)`.

### nocase

Perform a case-insensitive match.

### nonull

When a match is not found by `minimatch.match`, return a list containing
the pattern itself if this option is set.  When not set, an empty list
is returned if there are no matches.

### matchBase

If set, then patterns without slashes will be matched
against the basename of the path if it contains slashes.  For example,
`a?b` would match the path `/xyz/123/acb`, but not `/xyz/acb/123`.

### nocomment

Suppress the behavior of treating `#` at the start of a pattern as a
comment.

### nonegate

Suppress the behavior of treating a leading `!` character as negation.

### flipNegate

Returns from negate expressions the same as if they were not negated.
(Ie, true on a hit, false on a miss.)

### partial

Compare a partial path to a pattern.  As long as the parts of the path that
are present are not contradicted by the pattern, it will be treated as a
match.  This is useful in applications where you're walking through a
folder structure, and don't yet have the full path, but want to ensure that
you do not walk down paths that can never be a match.

For example,

```js
minimatch('/a/b', '/a/*/c/d', { partial: true })  // true, might be /a/b/c/d
minimatch('/a/b', '/**/d', { partial: true })     // true, might be /a/b/.../d
minimatch('/x/y/z', '/a/**/z', { partial: true }) // false, because x !== a
```

### allowWindowsEscape

Windows path separator `\` is by default converted to `/`, which
prohibits the usage of `\` as a escape character. This flag skips that
behavior and allows using the escape character.

## Comparisons to other fnmatch/glob implementations

While strict compliance with the existing standards is a worthwhile
goal, some discrepancies exist between minimatch and other
implementations, and are intentional.

If the pattern starts with a `!` character, then it is negated.  Set the
`nonegate` flag to suppress this behavior, and treat leading `!`
characters normally.  This is perhaps relevant if you wish to start the
pattern with a negative extglob pattern like `!(a|B)`.  Multiple `!`
characters at the start of a pattern will negate the pattern multiple
times.

If a pattern starts with `#`, then it is treated as a comment, and
will not match anything.  Use `\#` to match a literal `#` at the
start of a line, or set the `nocomment` flag to suppress this behavior.

The double-star character `**` is supported by default, unless the
`noglobstar` flag is set.  This is supported in the manner of bsdglob
and bash 4.1, where `**` only has special significance if it is the only
thing in a path part.  That is, `a/**/b` will match `a/x/y/b`, but
`a/**b` will not.

If an escaped pattern has no matches, and the `nonull` flag is set,
then minimatch.match returns the pattern as-provided, rather than
interpreting the character escapes.  For example,
`minimatch.match([], "\\*a\\?")` will return `"\\*a\\?"` rather than
`"*a?"`.  This is akin to setting the `nullglob` option in bash, except
that it does not resolve escaped pattern characters.

If brace expansion is not disabled, then it is performed before any
other interpretation of the glob pattern.  Thus, a pattern like
`+(a|{b),c)}`, which would not be valid in bash or zsh, is expanded
**first** into the set of `+(a|b)` and `+(a|c)`, and those patterns are
checked for validity.  Since those two are valid, matching proceeds.

## ./node_modules/minimist

# minimist <sup>[![Version Badge][npm-version-svg]][package-url]</sup>

[![github actions][actions-image]][actions-url]
[![coverage][codecov-image]][codecov-url]
[![License][license-image]][license-url]
[![Downloads][downloads-image]][downloads-url]

[![npm badge][npm-badge-png]][package-url]

parse argument options

This module is the guts of optimist's argument parser without all the
fanciful decoration.

# example

``` js
var argv = require('minimist')(process.argv.slice(2));
console.log(argv);
```

```
$ node example/parse.js -a beep -b boop
{ _: [], a: 'beep', b: 'boop' }
```

```
$ node example/parse.js -x 3 -y 4 -n5 -abc --beep=boop foo bar baz
{
	_: ['foo', 'bar', 'baz'],
	x: 3,
	y: 4,
	n: 5,
	a: true,
	b: true,
	c: true,
	beep: 'boop'
}
```

# security

Previous versions had a prototype pollution bug that could cause privilege
escalation in some circumstances when handling untrusted user input.

Please use version 1.2.6 or later:

* https://security.snyk.io/vuln/SNYK-JS-MINIMIST-2429795 (version <=1.2.5)
* https://snyk.io/vuln/SNYK-JS-MINIMIST-559764 (version <=1.2.3)

# methods

``` js
var parseArgs = require('minimist')
```

## var argv = parseArgs(args, opts={})

Return an argument object `argv` populated with the array arguments from `args`.

`argv._` contains all the arguments that didn't have an option associated with
them.

Numeric-looking arguments will be returned as numbers unless `opts.string` or
`opts.boolean` is set for that argument name.

Any arguments after `'--'` will not be parsed and will end up in `argv._`.

options can be:

* `opts.string` - a string or array of strings argument names to always treat as
strings
* `opts.boolean` - a boolean, string or array of strings to always treat as
booleans. if `true` will treat all double hyphenated arguments without equal signs
as boolean (e.g. affects `--foo`, not `-f` or `--foo=bar`)
* `opts.alias` - an object mapping string names to strings or arrays of string
argument names to use as aliases
* `opts.default` - an object mapping string argument names to default values
* `opts.stopEarly` - when true, populate `argv._` with everything after the
first non-option
* `opts['--']` - when true, populate `argv._` with everything before the `--`
and `argv['--']` with everything after the `--`. Here's an example:

  ```
  > require('./')('one two three -- four five --six'.split(' '), { '--': true })
  {
    _: ['one', 'two', 'three'],
    '--': ['four', 'five', '--six']
  }
  ```

  Note that with `opts['--']` set, parsing for arguments still stops after the
  `--`.

* `opts.unknown` - a function which is invoked with a command line parameter not
defined in the `opts` configuration object. If the function returns `false`, the
unknown option is not added to `argv`.

# install

With [npm](https://npmjs.org) do:

```
npm install minimist
```

# license

MIT

[package-url]: https://npmjs.org/package/minimist
[npm-version-svg]: https://versionbadg.es/minimistjs/minimist.svg
[npm-badge-png]: https://nodei.co/npm/minimist.png?downloads=true&stars=true
[license-image]: https://img.shields.io/npm/l/minimist.svg
[license-url]: LICENSE
[downloads-image]: https://img.shields.io/npm/dm/minimist.svg
[downloads-url]: https://npm-stat.com/charts.html?package=minimist
[codecov-image]: https://codecov.io/gh/minimistjs/minimist/branch/main/graphs/badge.svg
[codecov-url]: https://app.codecov.io/gh/minimistjs/minimist/
[actions-image]: https://img.shields.io/endpoint?url=https://github-actions-badge-u3jn4tfpocch.runkit.sh/minimistjs/minimist
[actions-url]: https://github.com/minimistjs/minimist/actions

## ./node_modules/negotiator

# negotiator

[![NPM Version][npm-image]][npm-url]
[![NPM Downloads][downloads-image]][downloads-url]
[![Node.js Version][node-version-image]][node-version-url]
[![Build Status][github-actions-ci-image]][github-actions-ci-url]
[![Test Coverage][coveralls-image]][coveralls-url]

An HTTP content negotiator for Node.js

## Installation

```sh
$ npm install negotiator
```

## API

```js
var Negotiator = require('negotiator')
```

### Accept Negotiation

```js
availableMediaTypes = ['text/html', 'text/plain', 'application/json']

// The negotiator constructor receives a request object
negotiator = new Negotiator(request)

// Let's say Accept header is 'text/html, application/*;q=0.2, image/jpeg;q=0.8'

negotiator.mediaTypes()
// -> ['text/html', 'image/jpeg', 'application/*']

negotiator.mediaTypes(availableMediaTypes)
// -> ['text/html', 'application/json']

negotiator.mediaType(availableMediaTypes)
// -> 'text/html'
```

You can check a working example at `examples/accept.js`.

#### Methods

##### mediaType()

Returns the most preferred media type from the client.

##### mediaType(availableMediaType)

Returns the most preferred media type from a list of available media types.

##### mediaTypes()

Returns an array of preferred media types ordered by the client preference.

##### mediaTypes(availableMediaTypes)

Returns an array of preferred media types ordered by priority from a list of
available media types.

### Accept-Language Negotiation

```js
negotiator = new Negotiator(request)

availableLanguages = ['en', 'es', 'fr']

// Let's say Accept-Language header is 'en;q=0.8, es, pt'

negotiator.languages()
// -> ['es', 'pt', 'en']

negotiator.languages(availableLanguages)
// -> ['es', 'en']

language = negotiator.language(availableLanguages)
// -> 'es'
```

You can check a working example at `examples/language.js`.

#### Methods

##### language()

Returns the most preferred language from the client.

##### language(availableLanguages)

Returns the most preferred language from a list of available languages.

##### languages()

Returns an array of preferred languages ordered by the client preference.

##### languages(availableLanguages)

Returns an array of preferred languages ordered by priority from a list of
available languages.

### Accept-Charset Negotiation

```js
availableCharsets = ['utf-8', 'iso-8859-1', 'iso-8859-5']

negotiator = new Negotiator(request)

// Let's say Accept-Charset header is 'utf-8, iso-8859-1;q=0.8, utf-7;q=0.2'

negotiator.charsets()
// -> ['utf-8', 'iso-8859-1', 'utf-7']

negotiator.charsets(availableCharsets)
// -> ['utf-8', 'iso-8859-1']

negotiator.charset(availableCharsets)
// -> 'utf-8'
```

You can check a working example at `examples/charset.js`.

#### Methods

##### charset()

Returns the most preferred charset from the client.

##### charset(availableCharsets)

Returns the most preferred charset from a list of available charsets.

##### charsets()

Returns an array of preferred charsets ordered by the client preference.

##### charsets(availableCharsets)

Returns an array of preferred charsets ordered by priority from a list of
available charsets.

### Accept-Encoding Negotiation

```js
availableEncodings = ['identity', 'gzip']

negotiator = new Negotiator(request)

// Let's say Accept-Encoding header is 'gzip, compress;q=0.2, identity;q=0.5'

negotiator.encodings()
// -> ['gzip', 'identity', 'compress']

negotiator.encodings(availableEncodings)
// -> ['gzip', 'identity']

negotiator.encoding(availableEncodings)
// -> 'gzip'
```

You can check a working example at `examples/encoding.js`.

#### Methods

##### encoding()

Returns the most preferred encoding from the client.

##### encoding(availableEncodings)

Returns the most preferred encoding from a list of available encodings.

##### encodings()

Returns an array of preferred encodings ordered by the client preference.

##### encodings(availableEncodings)

Returns an array of preferred encodings ordered by priority from a list of
available encodings.

## See Also

The [accepts](https://npmjs.org/package/accepts#readme) module builds on
this module and provides an alternative interface, mime type validation,
and more.

## License

[MIT](LICENSE)

[npm-image]: https://img.shields.io/npm/v/negotiator.svg
[npm-url]: https://npmjs.org/package/negotiator
[node-version-image]: https://img.shields.io/node/v/negotiator.svg
[node-version-url]: https://nodejs.org/en/download/
[coveralls-image]: https://img.shields.io/coveralls/jshttp/negotiator/master.svg
[coveralls-url]: https://coveralls.io/r/jshttp/negotiator?branch=master
[downloads-image]: https://img.shields.io/npm/dm/negotiator.svg
[downloads-url]: https://npmjs.org/package/negotiator
[github-actions-ci-image]: https://img.shields.io/github/workflow/status/jshttp/negotiator/ci/master?label=ci
[github-actions-ci-url]: https://github.com/jshttp/negotiator/actions/workflows/ci.yml

## ./node_modules/on-headers

# on-headers

[![NPM Version][npm-version-image]][npm-url]
[![NPM Downloads][npm-downloads-image]][npm-url]
[![Node.js Version][node-version-image]][node-version-url]
[![Build Status][travis-image]][travis-url]
[![Test Coverage][coveralls-image]][coveralls-url]

Execute a listener when a response is about to write headers.

## Installation

This is a [Node.js](https://nodejs.org/en/) module available through the
[npm registry](https://www.npmjs.com/). Installation is done using the
[`npm install` command](https://docs.npmjs.com/getting-started/installing-npm-packages-locally):

```sh
$ npm install on-headers
```

## API

<!-- eslint-disable no-unused-vars -->

```js
var onHeaders = require('on-headers')
```

### onHeaders(res, listener)

This will add the listener `listener` to fire when headers are emitted for `res`.
The listener is passed the `response` object as it's context (`this`). Headers are
considered to be emitted only once, right before they are sent to the client.

When this is called multiple times on the same `res`, the `listener`s are fired
in the reverse order they were added.

## Examples

```js
var http = require('http')
var onHeaders = require('on-headers')

http
  .createServer(onRequest)
  .listen(3000)

function addPoweredBy () {
  // set if not set by end of request
  if (!this.getHeader('X-Powered-By')) {
    this.setHeader('X-Powered-By', 'Node.js')
  }
}

function onRequest (req, res) {
  onHeaders(res, addPoweredBy)

  res.setHeader('Content-Type', 'text/plain')
  res.end('hello!')
}
```

## Testing

```sh
$ npm test
```

## License

[MIT](LICENSE)

[coveralls-image]: https://badgen.net/coveralls/c/github/jshttp/on-headers/master
[coveralls-url]: https://coveralls.io/r/jshttp/on-headers?branch=master
[node-version-image]: https://badgen.net/npm/node/on-headers
[node-version-url]: https://nodejs.org/en/download
[npm-downloads-image]: https://badgen.net/npm/dm/on-headers
[npm-url]: https://npmjs.org/package/on-headers
[npm-version-image]: https://badgen.net/npm/v/on-headers
[travis-image]: https://badgen.net/travis/jshttp/on-headers/master
[travis-url]: https://travis-ci.org/jshttp/on-headers

## ./node_modules/prettier

[![Prettier Banner](https://unpkg.com/prettier-logo@1.0.3/images/prettier-banner-light.svg)](https://prettier.io)

<h2 align="center">Opinionated Code Formatter</h2>

<p align="center">
  <em>
    JavaScript
    · TypeScript
    · Flow
    · JSX
    · JSON
  </em>
  <br />
  <em>
    CSS
    · SCSS
    · Less
  </em>
  <br />
  <em>
    HTML
    · Vue
    · Angular
  </em>
  <br />
  <em>
    GraphQL
    · Markdown
    · YAML
  </em>
  <br />
  <em>
    <a href="https://prettier.io/docs/plugins">
      Your favorite language?
    </a>
  </em>
</p>

<p align="center">
  <a href="https://github.com/prettier/prettier/actions?query=workflow%3AProd+branch%3Amain">
    <img alt="Github Actions Build Status" src="https://img.shields.io/github/actions/workflow/status/prettier/prettier/prod-test.yml?label=Prod&style=flat-square"></a>
  <a href="https://github.com/prettier/prettier/actions?query=workflow%3ADev+branch%3Amain">
    <img alt="Github Actions Build Status" src="https://img.shields.io/github/actions/workflow/status/prettier/prettier/dev-test.yml?label=Dev&style=flat-square"></a>
  <a href="https://github.com/prettier/prettier/actions?query=workflow%3ALint+branch%3Amain">
    <img alt="Github Actions Build Status" src="https://img.shields.io/github/actions/workflow/status/prettier/prettier/lint.yml?label=Lint&style=flat-square"></a>
  <a href="https://codecov.io/gh/prettier/prettier">
    <img alt="Codecov Coverage Status" src="https://img.shields.io/codecov/c/github/prettier/prettier.svg?style=flat-square"></a>
  <a href="https://twitter.com/acdlite/status/974390255393505280">
    <img alt="Blazing Fast" src="https://img.shields.io/badge/speed-blazing%20%F0%9F%94%A5-brightgreen.svg?style=flat-square"></a>
  <br/>
  <a href="https://www.npmjs.com/package/prettier">
    <img alt="npm version" src="https://img.shields.io/npm/v/prettier.svg?style=flat-square"></a>
  <a href="https://www.npmjs.com/package/prettier">
    <img alt="weekly downloads from npm" src="https://img.shields.io/npm/dw/prettier.svg?style=flat-square"></a>
  <a href="#badge">
    <img alt="code style: prettier" src="https://img.shields.io/badge/code_style-prettier-ff69b4.svg?style=flat-square"></a>
  <a href="https://twitter.com/PrettierCode">
    <img alt="Follow Prettier on Twitter" src="https://img.shields.io/badge/%40PrettierCode-9f9f9f?style=flat-square&logo=x&labelColor=555"></a>
</p>

## Intro

Prettier is an opinionated code formatter. It enforces a consistent style by parsing your code and re-printing it with its own rules that take the maximum line length into account, wrapping code when necessary.

### Input

<!-- prettier-ignore -->
```js
foo(reallyLongArg(), omgSoManyParameters(), IShouldRefactorThis(), isThereSeriouslyAnotherOne());
```

### Output

```js
foo(
  reallyLongArg(),
  omgSoManyParameters(),
  IShouldRefactorThis(),
  isThereSeriouslyAnotherOne(),
);
```

Prettier can be run [in your editor](https://prettier.io/docs/editors) on-save, in a [pre-commit hook](https://prettier.io/docs/precommit), or in [CI environments](https://prettier.io/docs/cli#list-different) to ensure your codebase has a consistent style without devs ever having to post a nit-picky comment on a code review ever again!

---

**[Documentation](https://prettier.io/docs/)**

[Install](https://prettier.io/docs/install) ·
[Options](https://prettier.io/docs/options) ·
[CLI](https://prettier.io/docs/cli) ·
[API](https://prettier.io/docs/api)

**[Playground](https://prettier.io/playground/)**

---

## Badge

Show the world you're using _Prettier_ → [![code style: prettier](https://img.shields.io/badge/code_style-prettier-ff69b4.svg?style=flat-square)](https://github.com/prettier/prettier)

```md
[![code style: prettier](https://img.shields.io/badge/code_style-prettier-ff69b4.svg?style=flat-square)](https://github.com/prettier/prettier)
```

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md).

## ./node_modules/punycode

# Punycode.js [![punycode on npm](https://img.shields.io/npm/v/punycode)](https://www.npmjs.com/package/punycode) [![](https://data.jsdelivr.com/v1/package/npm/punycode/badge)](https://www.jsdelivr.com/package/npm/punycode)

Punycode.js is a robust Punycode converter that fully complies to [RFC 3492](https://tools.ietf.org/html/rfc3492) and [RFC 5891](https://tools.ietf.org/html/rfc5891).

This JavaScript library is the result of comparing, optimizing and documenting different open-source implementations of the Punycode algorithm:

* [The C example code from RFC 3492](https://tools.ietf.org/html/rfc3492#appendix-C)
* [`punycode.c` by _Markus W. Scherer_ (IBM)](http://opensource.apple.com/source/ICU/ICU-400.42/icuSources/common/punycode.c)
* [`punycode.c` by _Ben Noordhuis_](https://github.com/bnoordhuis/punycode/blob/master/punycode.c)
* [JavaScript implementation by _some_](http://stackoverflow.com/questions/183485/can-anyone-recommend-a-good-free-javascript-for-punycode-to-unicode-conversion/301287#301287)
* [`punycode.js` by _Ben Noordhuis_](https://github.com/joyent/node/blob/426298c8c1c0d5b5224ac3658c41e7c2a3fe9377/lib/punycode.js) (note: [not fully compliant](https://github.com/joyent/node/issues/2072))

This project was [bundled](https://github.com/joyent/node/blob/master/lib/punycode.js) with Node.js from [v0.6.2+](https://github.com/joyent/node/compare/975f1930b1...61e796decc) until [v7](https://github.com/nodejs/node/pull/7941) (soft-deprecated).

This project provides a CommonJS module that uses ES2015+ features and JavaScript module, which work in modern Node.js versions and browsers. For the old Punycode.js version that offers the same functionality in a UMD build with support for older pre-ES2015 runtimes, including Rhino, Ringo, and Narwhal, see [v1.4.1](https://github.com/mathiasbynens/punycode.js/releases/tag/v1.4.1).

## Installation

Via [npm](https://www.npmjs.com/):

```bash
npm install punycode --save
```

In [Node.js](https://nodejs.org/):

> ⚠️ Note that userland modules don't hide core modules.
> For example, `require('punycode')` still imports the deprecated core module even if you executed `npm install punycode`.
> Use `require('punycode/')` to import userland modules rather than core modules.

```js
const punycode = require('punycode/');
```

## API

### `punycode.decode(string)`

Converts a Punycode string of ASCII symbols to a string of Unicode symbols.

```js
// decode domain name parts
punycode.decode('maana-pta'); // 'mañana'
punycode.decode('--dqo34k'); // '☃-⌘'
```

### `punycode.encode(string)`

Converts a string of Unicode symbols to a Punycode string of ASCII symbols.

```js
// encode domain name parts
punycode.encode('mañana'); // 'maana-pta'
punycode.encode('☃-⌘'); // '--dqo34k'
```

### `punycode.toUnicode(input)`

Converts a Punycode string representing a domain name or an email address to Unicode. Only the Punycoded parts of the input will be converted, i.e. it doesn’t matter if you call it on a string that has already been converted to Unicode.

```js
// decode domain names
punycode.toUnicode('xn--maana-pta.com');
// → 'mañana.com'
punycode.toUnicode('xn----dqo34k.com');
// → '☃-⌘.com'

// decode email addresses
punycode.toUnicode('джумла@xn--p-8sbkgc5ag7bhce.xn--ba-lmcq');
// → 'джумла@джpумлатест.bрфa'
```

### `punycode.toASCII(input)`

Converts a lowercased Unicode string representing a domain name or an email address to Punycode. Only the non-ASCII parts of the input will be converted, i.e. it doesn’t matter if you call it with a domain that’s already in ASCII.

```js
// encode domain names
punycode.toASCII('mañana.com');
// → 'xn--maana-pta.com'
punycode.toASCII('☃-⌘.com');
// → 'xn----dqo34k.com'

// encode email addresses
punycode.toASCII('джумла@джpумлатест.bрфa');
// → 'джумла@xn--p-8sbkgc5ag7bhce.xn--ba-lmcq'
```

### `punycode.ucs2`

#### `punycode.ucs2.decode(string)`

Creates an array containing the numeric code point values of each Unicode symbol in the string. While [JavaScript uses UCS-2 internally](https://mathiasbynens.be/notes/javascript-encoding), this function will convert a pair of surrogate halves (each of which UCS-2 exposes as separate characters) into a single code point, matching UTF-16.

```js
punycode.ucs2.decode('abc');
// → [0x61, 0x62, 0x63]
// surrogate pair for U+1D306 TETRAGRAM FOR CENTRE:
punycode.ucs2.decode('\uD834\uDF06');
// → [0x1D306]
```

#### `punycode.ucs2.encode(codePoints)`

Creates a string based on an array of numeric code point values.

```js
punycode.ucs2.encode([0x61, 0x62, 0x63]);
// → 'abc'
punycode.ucs2.encode([0x1D306]);
// → '\uD834\uDF06'
```

### `punycode.version`

A string representing the current Punycode.js version number.

## For maintainers

### How to publish a new release

1. On the `main` branch, bump the version number in `package.json`:

    ```sh
    npm version patch -m 'Release v%s'
    ```

    Instead of `patch`, use `minor` or `major` [as needed](https://semver.org/).

    Note that this produces a Git commit + tag.

1. Push the release commit and tag:

    ```sh
    git push && git push --tags
    ```

    Our CI then automatically publishes the new release to npm, under both the [`punycode`](https://www.npmjs.com/package/punycode) and [`punycode.js`](https://www.npmjs.com/package/punycode.js) names.

## Author

| [![twitter/mathias](https://gravatar.com/avatar/24e08a9ea84deb17ae121074d0f17125?s=70)](https://twitter.com/mathias "Follow @mathias on Twitter") |
|---|
| [Mathias Bynens](https://mathiasbynens.be/) |

## License

Punycode.js is available under the [MIT](https://mths.be/mit) license.

## ./node_modules/range-parser

# range-parser

[![NPM Version][npm-image]][npm-url]
[![NPM Downloads][downloads-image]][downloads-url]
[![Node.js Version][node-version-image]][node-version-url]
[![Build Status][travis-image]][travis-url]
[![Test Coverage][coveralls-image]][coveralls-url]

Range header field parser.

## Installation

```
$ npm install range-parser
```

## API

```js
var parseRange = require('range-parser')
```

### parseRange(size, header, options)

Parse the given `header` string where `size` is the maximum size of the resource.
An array of ranges will be returned or negative numbers indicating an error parsing.

  * `-2` signals a malformed header string
  * `-1` signals an unsatisfiable range

```js
// parse header from request
var range = parseRange(size, req.headers.range)

// the type of the range
if (range.type === 'bytes') {
  // the ranges
  range.forEach(function (r) {
    // do something with r.start and r.end
  })
}
```

#### Options

These properties are accepted in the options object.

##### combine

Specifies if overlapping & adjacent ranges should be combined, defaults to `false`.
When `true`, ranges will be combined and returned as if they were specified that
way in the header.

```js
parseRange(100, 'bytes=50-55,0-10,5-10,56-60', { combine: true })
// => [
//      { start: 0,  end: 10 },
//      { start: 50, end: 60 }
//    ]
```

## License

[MIT](LICENSE)

[npm-image]: https://img.shields.io/npm/v/range-parser.svg
[npm-url]: https://npmjs.org/package/range-parser
[node-version-image]: https://img.shields.io/node/v/range-parser.svg
[node-version-url]: https://nodejs.org/endownload
[travis-image]: https://img.shields.io/travis/jshttp/range-parser.svg
[travis-url]: https://travis-ci.org/jshttp/range-parser
[coveralls-image]: https://img.shields.io/coveralls/jshttp/range-parser.svg
[coveralls-url]: https://coveralls.io/r/jshttp/range-parser
[downloads-image]: https://img.shields.io/npm/dm/range-parser.svg
[downloads-url]: https://npmjs.org/package/range-parser

## ./node_modules/rc

# rc

The non-configurable configuration loader for lazy people.

## Usage

The only option is to pass rc the name of your app, and your default configuration.

```javascript
var conf = require('rc')(appname, {
  //defaults go here.
  port: 2468,

  //defaults which are objects will be merged, not replaced
  views: {
    engine: 'jade'
  }
});
```

`rc` will return your configuration options merged with the defaults you specify.
If you pass in a predefined defaults object, it will be mutated:

```javascript
var conf = {};
require('rc')(appname, conf);
```

If `rc` finds any config files for your app, the returned config object will have
a `configs` array containing their paths:

```javascript
var appCfg = require('rc')(appname, conf);
appCfg.configs[0] // /etc/appnamerc
appCfg.configs[1] // /home/dominictarr/.config/appname
appCfg.config // same as appCfg.configs[appCfg.configs.length - 1]
```

## Standards

Given your application name (`appname`), rc will look in all the obvious places for configuration.

  * command line arguments, parsed by minimist _(e.g. `--foo baz`, also nested: `--foo.bar=baz`)_
  * environment variables prefixed with `${appname}_`
    * or use "\_\_" to indicate nested properties <br/> _(e.g. `appname_foo__bar__baz` => `foo.bar.baz`)_
  * if you passed an option `--config file` then from that file
  * a local `.${appname}rc` or the first found looking in `./ ../ ../../ ../../../` etc.
  * `$HOME/.${appname}rc`
  * `$HOME/.${appname}/config`
  * `$HOME/.config/${appname}`
  * `$HOME/.config/${appname}/config`
  * `/etc/${appname}rc`
  * `/etc/${appname}/config`
  * the defaults object you passed in.

All configuration sources that were found will be flattened into one object,
so that sources **earlier** in this list override later ones.


## Configuration File Formats

Configuration files (e.g. `.appnamerc`) may be in either [json](http://json.org/example) or [ini](http://en.wikipedia.org/wiki/INI_file) format. **No** file extension (`.json` or `.ini`) should be used. The example configurations below are equivalent:


#### Formatted as `ini`

```
; You can include comments in `ini` format if you want.

dependsOn=0.10.0


; `rc` has built-in support for ini sections, see?

[commands]
  www     = ./commands/www
  console = ./commands/repl


; You can even do nested sections

[generators.options]
  engine  = ejs

[generators.modules]
  new     = generate-new
  engine  = generate-backend

```

#### Formatted as `json`

```javascript
{
  // You can even comment your JSON, if you want
  "dependsOn": "0.10.0",
  "commands": {
    "www": "./commands/www",
    "console": "./commands/repl"
  },
  "generators": {
    "options": {
      "engine": "ejs"
    },
    "modules": {
      "new": "generate-new",
      "backend": "generate-backend"
    }
  }
}
```

Comments are stripped from JSON config via [strip-json-comments](https://github.com/sindresorhus/strip-json-comments).

> Since ini, and env variables do not have a standard for types, your application needs be prepared for strings.

To ensure that string representations of booleans and numbers are always converted into their proper types (especially useful if you intend to do strict `===` comparisons), consider using a module such as [parse-strings-in-object](https://github.com/anselanza/parse-strings-in-object) to wrap the config object returned from rc.


## Simple example demonstrating precedence
Assume you have an application like this (notice the hard-coded defaults passed to rc):
```
const conf = require('rc')('myapp', {
    port: 12345,
    mode: 'test'
});

console.log(JSON.stringify(conf, null, 2));
```
You also have a file `config.json`, with these contents:
```
{
  "port": 9000,
  "foo": "from config json",
  "something": "else"
}
```
And a file `.myapprc` in the same folder, with these contents:
```
{
  "port": "3001",
  "foo": "bar"
}
```
Here is the expected output from various commands:

`node .`
```
{
  "port": "3001",
  "mode": "test",
  "foo": "bar",
  "_": [],
  "configs": [
    "/Users/stephen/repos/conftest/.myapprc"
  ],
  "config": "/Users/stephen/repos/conftest/.myapprc"
}
```
*Default `mode` from hard-coded object is retained, but port is overridden by `.myapprc` file (automatically found based on appname match), and `foo` is added.*


`node . --foo baz`
```
{
  "port": "3001",
  "mode": "test",
  "foo": "baz",
  "_": [],
  "configs": [
    "/Users/stephen/repos/conftest/.myapprc"
  ],
  "config": "/Users/stephen/repos/conftest/.myapprc"
}
```
*Same result as above but `foo` is overridden because command-line arguments take precedence over `.myapprc` file.*

`node . --foo barbar --config config.json`
```
{
  "port": 9000,
  "mode": "test",
  "foo": "barbar",
  "something": "else",
  "_": [],
  "config": "config.json",
  "configs": [
    "/Users/stephen/repos/conftest/.myapprc",
    "config.json"
  ]
}
```
*Now the `port` comes from the `config.json` file specified (overriding the value from `.myapprc`), and `foo` value is overriden by command-line despite also being specified in the `config.json` file.*
 


## Advanced Usage

#### Pass in your own `argv`

You may pass in your own `argv` as the third argument to `rc`.  This is in case you want to [use your own command-line opts parser](https://github.com/dominictarr/rc/pull/12).

```javascript
require('rc')(appname, defaults, customArgvParser);
```

## Pass in your own parser

If you have a special need to use a non-standard parser,
you can do so by passing in the parser as the 4th argument.
(leave the 3rd as null to get the default args parser)

```javascript
require('rc')(appname, defaults, null, parser);
```

This may also be used to force a more strict format,
such as strict, valid JSON only.

## Note on Performance

`rc` is running `fs.statSync`-- so make sure you don't use it in a hot code path (e.g. a request handler) 


## License

Multi-licensed under the two-clause BSD License, MIT License, or Apache License, version 2.0

## ./node_modules/registry-auth-token

# registry-auth-token

[![npm version](http://img.shields.io/npm/v/registry-auth-token.svg?style=flat-square)](http://browsenpm.org/package/registry-auth-token)[![Build Status](http://img.shields.io/travis/rexxars/registry-auth-token/master.svg?style=flat-square)](https://travis-ci.org/rexxars/registry-auth-token)

Get the auth token set for an npm registry from `.npmrc`. Also allows fetching the configured registry URL for a given npm scope.

## Installing

```
npm install --save registry-auth-token
```

## Usage

Returns an object containing `token` and `type`, or `undefined` if no token can be found. `type` can be either `Bearer` or `Basic`.

```js
var getAuthToken = require('registry-auth-token')
var getRegistryUrl = require('registry-auth-token/registry-url')

// Get auth token and type for default `registry` set in `.npmrc`
console.log(getAuthToken()) // {token: 'someToken', type: 'Bearer'}

// Get auth token for a specific registry URL
console.log(getAuthToken('//registry.foo.bar'))

// Find the registry auth token for a given URL (with deep path):
// If registry is at `//some.host/registry`
// URL passed is `//some.host/registry/deep/path`
// Will find token the closest matching path; `//some.host/registry`
console.log(getAuthToken('//some.host/registry/deep/path', {recursive: true}))

// Find the configured registry url for scope `@foobar`.
// Falls back to the global registry if not defined.
console.log(getRegistryUrl('@foobar'))

// Use the npm config that is passed in
console.log(getRegistryUrl('http://registry.foobar.eu/', {
  npmrc: {
    'registry': 'http://registry.foobar.eu/',
    '//registry.foobar.eu/:_authToken': 'qar'
  }
}))
```

## Return value

```js
// If auth info can be found:
{token: 'someToken', type: 'Bearer'}

// Or:
{token: 'someOtherToken', type: 'Basic'}

// Or, if nothing is found:
undefined
```

## Security

Please be careful when using this. Leaking your auth token is dangerous.

## License

MIT-licensed. See LICENSE.

## ./node_modules/safe-buffer

# safe-buffer [![travis][travis-image]][travis-url] [![npm][npm-image]][npm-url] [![downloads][downloads-image]][downloads-url] [![javascript style guide][standard-image]][standard-url]

[travis-image]: https://img.shields.io/travis/feross/safe-buffer/master.svg
[travis-url]: https://travis-ci.org/feross/safe-buffer
[npm-image]: https://img.shields.io/npm/v/safe-buffer.svg
[npm-url]: https://npmjs.org/package/safe-buffer
[downloads-image]: https://img.shields.io/npm/dm/safe-buffer.svg
[downloads-url]: https://npmjs.org/package/safe-buffer
[standard-image]: https://img.shields.io/badge/code_style-standard-brightgreen.svg
[standard-url]: https://standardjs.com

#### Safer Node.js Buffer API

**Use the new Node.js Buffer APIs (`Buffer.from`, `Buffer.alloc`,
`Buffer.allocUnsafe`, `Buffer.allocUnsafeSlow`) in all versions of Node.js.**

**Uses the built-in implementation when available.**

## install

```
npm install safe-buffer
```

## usage

The goal of this package is to provide a safe replacement for the node.js `Buffer`.

It's a drop-in replacement for `Buffer`. You can use it by adding one `require` line to
the top of your node.js modules:

```js
var Buffer = require('safe-buffer').Buffer

// Existing buffer code will continue to work without issues:

new Buffer('hey', 'utf8')
new Buffer([1, 2, 3], 'utf8')
new Buffer(obj)
new Buffer(16) // create an uninitialized buffer (potentially unsafe)

// But you can use these new explicit APIs to make clear what you want:

Buffer.from('hey', 'utf8') // convert from many types to a Buffer
Buffer.alloc(16) // create a zero-filled buffer (safe)
Buffer.allocUnsafe(16) // create an uninitialized buffer (potentially unsafe)
```

## api

### Class Method: Buffer.from(array)
<!-- YAML
added: v3.0.0
-->

* `array` {Array}

Allocates a new `Buffer` using an `array` of octets.

```js
const buf = Buffer.from([0x62,0x75,0x66,0x66,0x65,0x72]);
  // creates a new Buffer containing ASCII bytes
  // ['b','u','f','f','e','r']
```

A `TypeError` will be thrown if `array` is not an `Array`.

### Class Method: Buffer.from(arrayBuffer[, byteOffset[, length]])
<!-- YAML
added: v5.10.0
-->

* `arrayBuffer` {ArrayBuffer} The `.buffer` property of a `TypedArray` or
  a `new ArrayBuffer()`
* `byteOffset` {Number} Default: `0`
* `length` {Number} Default: `arrayBuffer.length - byteOffset`

When passed a reference to the `.buffer` property of a `TypedArray` instance,
the newly created `Buffer` will share the same allocated memory as the
TypedArray.

```js
const arr = new Uint16Array(2);
arr[0] = 5000;
arr[1] = 4000;

const buf = Buffer.from(arr.buffer); // shares the memory with arr;

console.log(buf);
  // Prints: <Buffer 88 13 a0 0f>

// changing the TypedArray changes the Buffer also
arr[1] = 6000;

console.log(buf);
  // Prints: <Buffer 88 13 70 17>
```

The optional `byteOffset` and `length` arguments specify a memory range within
the `arrayBuffer` that will be shared by the `Buffer`.

```js
const ab = new ArrayBuffer(10);
const buf = Buffer.from(ab, 0, 2);
console.log(buf.length);
  // Prints: 2
```

A `TypeError` will be thrown if `arrayBuffer` is not an `ArrayBuffer`.

### Class Method: Buffer.from(buffer)
<!-- YAML
added: v3.0.0
-->

* `buffer` {Buffer}

Copies the passed `buffer` data onto a new `Buffer` instance.

```js
const buf1 = Buffer.from('buffer');
const buf2 = Buffer.from(buf1);

buf1[0] = 0x61;
console.log(buf1.toString());
  // 'auffer'
console.log(buf2.toString());
  // 'buffer' (copy is not changed)
```

A `TypeError` will be thrown if `buffer` is not a `Buffer`.

### Class Method: Buffer.from(str[, encoding])
<!-- YAML
added: v5.10.0
-->

* `str` {String} String to encode.
* `encoding` {String} Encoding to use, Default: `'utf8'`

Creates a new `Buffer` containing the given JavaScript string `str`. If
provided, the `encoding` parameter identifies the character encoding.
If not provided, `encoding` defaults to `'utf8'`.

```js
const buf1 = Buffer.from('this is a tést');
console.log(buf1.toString());
  // prints: this is a tést
console.log(buf1.toString('ascii'));
  // prints: this is a tC)st

const buf2 = Buffer.from('7468697320697320612074c3a97374', 'hex');
console.log(buf2.toString());
  // prints: this is a tést
```

A `TypeError` will be thrown if `str` is not a string.

### Class Method: Buffer.alloc(size[, fill[, encoding]])
<!-- YAML
added: v5.10.0
-->

* `size` {Number}
* `fill` {Value} Default: `undefined`
* `encoding` {String} Default: `utf8`

Allocates a new `Buffer` of `size` bytes. If `fill` is `undefined`, the
`Buffer` will be *zero-filled*.

```js
const buf = Buffer.alloc(5);
console.log(buf);
  // <Buffer 00 00 00 00 00>
```

The `size` must be less than or equal to the value of
`require('buffer').kMaxLength` (on 64-bit architectures, `kMaxLength` is
`(2^31)-1`). Otherwise, a [`RangeError`][] is thrown. A zero-length Buffer will
be created if a `size` less than or equal to 0 is specified.

If `fill` is specified, the allocated `Buffer` will be initialized by calling
`buf.fill(fill)`. See [`buf.fill()`][] for more information.

```js
const buf = Buffer.alloc(5, 'a');
console.log(buf);
  // <Buffer 61 61 61 61 61>
```

If both `fill` and `encoding` are specified, the allocated `Buffer` will be
initialized by calling `buf.fill(fill, encoding)`. For example:

```js
const buf = Buffer.alloc(11, 'aGVsbG8gd29ybGQ=', 'base64');
console.log(buf);
  // <Buffer 68 65 6c 6c 6f 20 77 6f 72 6c 64>
```

Calling `Buffer.alloc(size)` can be significantly slower than the alternative
`Buffer.allocUnsafe(size)` but ensures that the newly created `Buffer` instance
contents will *never contain sensitive data*.

A `TypeError` will be thrown if `size` is not a number.

### Class Method: Buffer.allocUnsafe(size)
<!-- YAML
added: v5.10.0
-->

* `size` {Number}

Allocates a new *non-zero-filled* `Buffer` of `size` bytes.  The `size` must
be less than or equal to the value of `require('buffer').kMaxLength` (on 64-bit
architectures, `kMaxLength` is `(2^31)-1`). Otherwise, a [`RangeError`][] is
thrown. A zero-length Buffer will be created if a `size` less than or equal to
0 is specified.

The underlying memory for `Buffer` instances created in this way is *not
initialized*. The contents of the newly created `Buffer` are unknown and
*may contain sensitive data*. Use [`buf.fill(0)`][] to initialize such
`Buffer` instances to zeroes.

```js
const buf = Buffer.allocUnsafe(5);
console.log(buf);
  // <Buffer 78 e0 82 02 01>
  // (octets will be different, every time)
buf.fill(0);
console.log(buf);
  // <Buffer 00 00 00 00 00>
```

A `TypeError` will be thrown if `size` is not a number.

Note that the `Buffer` module pre-allocates an internal `Buffer` instance of
size `Buffer.poolSize` that is used as a pool for the fast allocation of new
`Buffer` instances created using `Buffer.allocUnsafe(size)` (and the deprecated
`new Buffer(size)` constructor) only when `size` is less than or equal to
`Buffer.poolSize >> 1` (floor of `Buffer.poolSize` divided by two). The default
value of `Buffer.poolSize` is `8192` but can be modified.

Use of this pre-allocated internal memory pool is a key difference between
calling `Buffer.alloc(size, fill)` vs. `Buffer.allocUnsafe(size).fill(fill)`.
Specifically, `Buffer.alloc(size, fill)` will *never* use the internal Buffer
pool, while `Buffer.allocUnsafe(size).fill(fill)` *will* use the internal
Buffer pool if `size` is less than or equal to half `Buffer.poolSize`. The
difference is subtle but can be important when an application requires the
additional performance that `Buffer.allocUnsafe(size)` provides.

### Class Method: Buffer.allocUnsafeSlow(size)
<!-- YAML
added: v5.10.0
-->

* `size` {Number}

Allocates a new *non-zero-filled* and non-pooled `Buffer` of `size` bytes.  The
`size` must be less than or equal to the value of
`require('buffer').kMaxLength` (on 64-bit architectures, `kMaxLength` is
`(2^31)-1`). Otherwise, a [`RangeError`][] is thrown. A zero-length Buffer will
be created if a `size` less than or equal to 0 is specified.

The underlying memory for `Buffer` instances created in this way is *not
initialized*. The contents of the newly created `Buffer` are unknown and
*may contain sensitive data*. Use [`buf.fill(0)`][] to initialize such
`Buffer` instances to zeroes.

When using `Buffer.allocUnsafe()` to allocate new `Buffer` instances,
allocations under 4KB are, by default, sliced from a single pre-allocated
`Buffer`. This allows applications to avoid the garbage collection overhead of
creating many individually allocated Buffers. This approach improves both
performance and memory usage by eliminating the need to track and cleanup as
many `Persistent` objects.

However, in the case where a developer may need to retain a small chunk of
memory from a pool for an indeterminate amount of time, it may be appropriate
to create an un-pooled Buffer instance using `Buffer.allocUnsafeSlow()` then
copy out the relevant bits.

```js
// need to keep around a few small chunks of memory
const store = [];

socket.on('readable', () => {
  const data = socket.read();
  // allocate for retained data
  const sb = Buffer.allocUnsafeSlow(10);
  // copy the data into the new allocation
  data.copy(sb, 0, 0, 10);
  store.push(sb);
});
```

Use of `Buffer.allocUnsafeSlow()` should be used only as a last resort *after*
a developer has observed undue memory retention in their applications.

A `TypeError` will be thrown if `size` is not a number.

### All the Rest

The rest of the `Buffer` API is exactly the same as in node.js.
[See the docs](https://nodejs.org/api/buffer.html).


## Related links

- [Node.js issue: Buffer(number) is unsafe](https://github.com/nodejs/node/issues/4660)
- [Node.js Enhancement Proposal: Buffer.from/Buffer.alloc/Buffer.zalloc/Buffer() soft-deprecate](https://github.com/nodejs/node-eps/pull/4)

## Why is `Buffer` unsafe?

Today, the node.js `Buffer` constructor is overloaded to handle many different argument
types like `String`, `Array`, `Object`, `TypedArrayView` (`Uint8Array`, etc.),
`ArrayBuffer`, and also `Number`.

The API is optimized for convenience: you can throw any type at it, and it will try to do
what you want.

Because the Buffer constructor is so powerful, you often see code like this:

```js
// Convert UTF-8 strings to hex
function toHex (str) {
  return new Buffer(str).toString('hex')
}
```

***But what happens if `toHex` is called with a `Number` argument?***

### Remote Memory Disclosure

If an attacker can make your program call the `Buffer` constructor with a `Number`
argument, then they can make it allocate uninitialized memory from the node.js process.
This could potentially disclose TLS private keys, user data, or database passwords.

When the `Buffer` constructor is passed a `Number` argument, it returns an
**UNINITIALIZED** block of memory of the specified `size`. When you create a `Buffer` like
this, you **MUST** overwrite the contents before returning it to the user.

From the [node.js docs](https://nodejs.org/api/buffer.html#buffer_new_buffer_size):

> `new Buffer(size)`
>
> - `size` Number
>
> The underlying memory for `Buffer` instances created in this way is not initialized.
> **The contents of a newly created `Buffer` are unknown and could contain sensitive
> data.** Use `buf.fill(0)` to initialize a Buffer to zeroes.

(Emphasis our own.)

Whenever the programmer intended to create an uninitialized `Buffer` you often see code
like this:

```js
var buf = new Buffer(16)

// Immediately overwrite the uninitialized buffer with data from another buffer
for (var i = 0; i < buf.length; i++) {
  buf[i] = otherBuf[i]
}
```


### Would this ever be a problem in real code?

Yes. It's surprisingly common to forget to check the type of your variables in a
dynamically-typed language like JavaScript.

Usually the consequences of assuming the wrong type is that your program crashes with an
uncaught exception. But the failure mode for forgetting to check the type of arguments to
the `Buffer` constructor is more catastrophic.

Here's an example of a vulnerable service that takes a JSON payload and converts it to
hex:

```js
// Take a JSON payload {str: "some string"} and convert it to hex
var server = http.createServer(function (req, res) {
  var data = ''
  req.setEncoding('utf8')
  req.on('data', function (chunk) {
    data += chunk
  })
  req.on('end', function () {
    var body = JSON.parse(data)
    res.end(new Buffer(body.str).toString('hex'))
  })
})

server.listen(8080)
```

In this example, an http client just has to send:

```json
{
  "str": 1000
}
```

and it will get back 1,000 bytes of uninitialized memory from the server.

This is a very serious bug. It's similar in severity to the
[the Heartbleed bug](http://heartbleed.com/) that allowed disclosure of OpenSSL process
memory by remote attackers.


### Which real-world packages were vulnerable?

#### [`bittorrent-dht`](https://www.npmjs.com/package/bittorrent-dht)

[Mathias Buus](https://github.com/mafintosh) and I
([Feross Aboukhadijeh](http://feross.org/)) found this issue in one of our own packages,
[`bittorrent-dht`](https://www.npmjs.com/package/bittorrent-dht). The bug would allow
anyone on the internet to send a series of messages to a user of `bittorrent-dht` and get
them to reveal 20 bytes at a time of uninitialized memory from the node.js process.

Here's
[the commit](https://github.com/feross/bittorrent-dht/commit/6c7da04025d5633699800a99ec3fbadf70ad35b8)
that fixed it. We released a new fixed version, created a
[Node Security Project disclosure](https://nodesecurity.io/advisories/68), and deprecated all
vulnerable versions on npm so users will get a warning to upgrade to a newer version.

#### [`ws`](https://www.npmjs.com/package/ws)

That got us wondering if there were other vulnerable packages. Sure enough, within a short
period of time, we found the same issue in [`ws`](https://www.npmjs.com/package/ws), the
most popular WebSocket implementation in node.js.

If certain APIs were called with `Number` parameters instead of `String` or `Buffer` as
expected, then uninitialized server memory would be disclosed to the remote peer.

These were the vulnerable methods:

```js
socket.send(number)
socket.ping(number)
socket.pong(number)
```

Here's a vulnerable socket server with some echo functionality:

```js
server.on('connection', function (socket) {
  socket.on('message', function (message) {
    message = JSON.parse(message)
    if (message.type === 'echo') {
      socket.send(message.data) // send back the user's message
    }
  })
})
```

`socket.send(number)` called on the server, will disclose server memory.

Here's [the release](https://github.com/websockets/ws/releases/tag/1.0.1) where the issue
was fixed, with a more detailed explanation. Props to
[Arnout Kazemier](https://github.com/3rd-Eden) for the quick fix. Here's the
[Node Security Project disclosure](https://nodesecurity.io/advisories/67).


### What's the solution?

It's important that node.js offers a fast way to get memory otherwise performance-critical
applications would needlessly get a lot slower.

But we need a better way to *signal our intent* as programmers. **When we want
uninitialized memory, we should request it explicitly.**

Sensitive functionality should not be packed into a developer-friendly API that loosely
accepts many different types. This type of API encourages the lazy practice of passing
variables in without checking the type very carefully.

#### A new API: `Buffer.allocUnsafe(number)`

The functionality of creating buffers with uninitialized memory should be part of another
API. We propose `Buffer.allocUnsafe(number)`. This way, it's not part of an API that
frequently gets user input of all sorts of different types passed into it.

```js
var buf = Buffer.allocUnsafe(16) // careful, uninitialized memory!

// Immediately overwrite the uninitialized buffer with data from another buffer
for (var i = 0; i < buf.length; i++) {
  buf[i] = otherBuf[i]
}
```


### How do we fix node.js core?

We sent [a PR to node.js core](https://github.com/nodejs/node/pull/4514) (merged as
`semver-major`) which defends against one case:

```js
var str = 16
new Buffer(str, 'utf8')
```

In this situation, it's implied that the programmer intended the first argument to be a
string, since they passed an encoding as a second argument. Today, node.js will allocate
uninitialized memory in the case of `new Buffer(number, encoding)`, which is probably not
what the programmer intended.

But this is only a partial solution, since if the programmer does `new Buffer(variable)`
(without an `encoding` parameter) there's no way to know what they intended. If `variable`
is sometimes a number, then uninitialized memory will sometimes be returned.

### What's the real long-term fix?

We could deprecate and remove `new Buffer(number)` and use `Buffer.allocUnsafe(number)` when
we need uninitialized memory. But that would break 1000s of packages.

~~We believe the best solution is to:~~

~~1. Change `new Buffer(number)` to return safe, zeroed-out memory~~

~~2. Create a new API for creating uninitialized Buffers. We propose: `Buffer.allocUnsafe(number)`~~

#### Update

We now support adding three new APIs:

- `Buffer.from(value)` - convert from any type to a buffer
- `Buffer.alloc(size)` - create a zero-filled buffer
- `Buffer.allocUnsafe(size)` - create an uninitialized buffer with given size

This solves the core problem that affected `ws` and `bittorrent-dht` which is
`Buffer(variable)` getting tricked into taking a number argument.

This way, existing code continues working and the impact on the npm ecosystem will be
minimal. Over time, npm maintainers can migrate performance-critical code to use
`Buffer.allocUnsafe(number)` instead of `new Buffer(number)`.


### Conclusion

We think there's a serious design issue with the `Buffer` API as it exists today. It
promotes insecure software by putting high-risk functionality into a convenient API
with friendly "developer ergonomics".

This wasn't merely a theoretical exercise because we found the issue in some of the
most popular npm packages.

Fortunately, there's an easy fix that can be applied today. Use `safe-buffer` in place of
`buffer`.

```js
var Buffer = require('safe-buffer').Buffer
```

Eventually, we hope that node.js core can switch to this new, safer behavior. We believe
the impact on the ecosystem would be minimal since it's not a breaking change.
Well-maintained, popular packages would be updated to use `Buffer.alloc` quickly, while
older, insecure packages would magically become safe from this attack vector.


## links

- [Node.js PR: buffer: throw if both length and enc are passed](https://github.com/nodejs/node/pull/4514)
- [Node Security Project disclosure for `ws`](https://nodesecurity.io/advisories/67)
- [Node Security Project disclosure for`bittorrent-dht`](https://nodesecurity.io/advisories/68)


## credit

The original issues in `bittorrent-dht`
([disclosure](https://nodesecurity.io/advisories/68)) and
`ws` ([disclosure](https://nodesecurity.io/advisories/67)) were discovered by
[Mathias Buus](https://github.com/mafintosh) and
[Feross Aboukhadijeh](http://feross.org/).

Thanks to [Adam Baldwin](https://github.com/evilpacket) for helping disclose these issues
and for his work running the [Node Security Project](https://nodesecurity.io/).

Thanks to [John Hiesey](https://github.com/jhiesey) for proofreading this README and
auditing the code.


## license

MIT. Copyright (C) [Feross Aboukhadijeh](http://feross.org)

## ./node_modules/serve-handler/node_modules/mime-db

# mime-db

[![NPM Version][npm-version-image]][npm-url]
[![NPM Downloads][npm-downloads-image]][npm-url]
[![Node.js Version][node-image]][node-url]
[![Build Status][travis-image]][travis-url]
[![Coverage Status][coveralls-image]][coveralls-url]

This is a database of all mime types.
It consists of a single, public JSON file and does not include any logic,
allowing it to remain as un-opinionated as possible with an API.
It aggregates data from the following sources:

- http://www.iana.org/assignments/media-types/media-types.xhtml
- http://svn.apache.org/repos/asf/httpd/httpd/trunk/docs/conf/mime.types
- http://hg.nginx.org/nginx/raw-file/default/conf/mime.types

## Installation

```bash
npm install mime-db
```

### Database Download

If you're crazy enough to use this in the browser, you can just grab the
JSON file using [RawGit](https://rawgit.com/). It is recommended to replace
`master` with [a release tag](https://github.com/jshttp/mime-db/tags) as the
JSON format may change in the future.

```
https://cdn.rawgit.com/jshttp/mime-db/master/db.json
```

## Usage

```js
var db = require('mime-db');

// grab data on .js files
var data = db['application/javascript'];
```

## Data Structure

The JSON file is a map lookup for lowercased mime types.
Each mime type has the following properties:

- `.source` - where the mime type is defined.
    If not set, it's probably a custom media type.
    - `apache` - [Apache common media types](http://svn.apache.org/repos/asf/httpd/httpd/trunk/docs/conf/mime.types)
    - `iana` - [IANA-defined media types](http://www.iana.org/assignments/media-types/media-types.xhtml)
    - `nginx` - [nginx media types](http://hg.nginx.org/nginx/raw-file/default/conf/mime.types)
- `.extensions[]` - known extensions associated with this mime type.
- `.compressible` - whether a file of this type can be gzipped.
- `.charset` - the default charset associated with this type, if any.

If unknown, every property could be `undefined`.

## Contributing

To edit the database, only make PRs against `src/custom.json` or
`src/custom-suffix.json`.

The `src/custom.json` file is a JSON object with the MIME type as the keys
and the values being an object with the following keys:

- `compressible` - leave out if you don't know, otherwise `true`/`false` for
  if the data represented by the time is typically compressible.
- `extensions` - include an array of file extensions that are associated with
  the type.
- `notes` - human-readable notes about the type, typically what the type is.
- `sources` - include an array of URLs of where the MIME type and the associated
  extensions are sourced from. This needs to be a [primary source](https://en.wikipedia.org/wiki/Primary_source);
  links to type aggregating sites and Wikipedia are _not acceptible_.

To update the build, run `npm run build`.

## Adding Custom Media Types

The best way to get new media types included in this library is to register
them with the IANA. The community registration procedure is outlined in
[RFC 6838 section 5](http://tools.ietf.org/html/rfc6838#section-5). Types
registered with the IANA are automatically pulled into this library.

[npm-version-image]: https://img.shields.io/npm/v/mime-db.svg
[npm-downloads-image]: https://img.shields.io/npm/dm/mime-db.svg
[npm-url]: https://npmjs.org/package/mime-db
[travis-image]: https://img.shields.io/travis/jshttp/mime-db/master.svg
[travis-url]: https://travis-ci.org/jshttp/mime-db
[coveralls-image]: https://img.shields.io/coveralls/jshttp/mime-db/master.svg
[coveralls-url]: https://coveralls.io/r/jshttp/mime-db?branch=master
[node-image]: https://img.shields.io/node/v/mime-db.svg
[node-url]: https://nodejs.org/en/download/

## ./node_modules/serve-handler/node_modules/mime-types

# mime-types

[![NPM Version][npm-image]][npm-url]
[![NPM Downloads][downloads-image]][downloads-url]
[![Node.js Version][node-version-image]][node-version-url]
[![Build Status][travis-image]][travis-url]
[![Test Coverage][coveralls-image]][coveralls-url]

The ultimate javascript content-type utility.

Similar to [the `mime@1.x` module](https://www.npmjs.com/package/mime), except:

- __No fallbacks.__ Instead of naively returning the first available type,
  `mime-types` simply returns `false`, so do
  `var type = mime.lookup('unrecognized') || 'application/octet-stream'`.
- No `new Mime()` business, so you could do `var lookup = require('mime-types').lookup`.
- No `.define()` functionality
- Bug fixes for `.lookup(path)`

Otherwise, the API is compatible with `mime` 1.x.

## Install

This is a [Node.js](https://nodejs.org/en/) module available through the
[npm registry](https://www.npmjs.com/). Installation is done using the
[`npm install` command](https://docs.npmjs.com/getting-started/installing-npm-packages-locally):

```sh
$ npm install mime-types
```

## Adding Types

All mime types are based on [mime-db](https://www.npmjs.com/package/mime-db),
so open a PR there if you'd like to add mime types.

## API

```js
var mime = require('mime-types')
```

All functions return `false` if input is invalid or not found.

### mime.lookup(path)

Lookup the content-type associated with a file.

```js
mime.lookup('json')             // 'application/json'
mime.lookup('.md')              // 'text/markdown'
mime.lookup('file.html')        // 'text/html'
mime.lookup('folder/file.js')   // 'application/javascript'
mime.lookup('folder/.htaccess') // false

mime.lookup('cats') // false
```

### mime.contentType(type)

Create a full content-type header given a content-type or extension.

```js
mime.contentType('markdown')  // 'text/x-markdown; charset=utf-8'
mime.contentType('file.json') // 'application/json; charset=utf-8'

// from a full path
mime.contentType(path.extname('/path/to/file.json')) // 'application/json; charset=utf-8'
```

### mime.extension(type)

Get the default extension for a content-type.

```js
mime.extension('application/octet-stream') // 'bin'
```

### mime.charset(type)

Lookup the implied default charset of a content-type.

```js
mime.charset('text/markdown') // 'UTF-8'
```

### var type = mime.types[extension]

A map of content-types by extension.

### [extensions...] = mime.extensions[type]

A map of extensions by content-type.

## License

[MIT](LICENSE)

[npm-image]: https://img.shields.io/npm/v/mime-types.svg
[npm-url]: https://npmjs.org/package/mime-types
[node-version-image]: https://img.shields.io/node/v/mime-types.svg
[node-version-url]: https://nodejs.org/en/download/
[travis-image]: https://img.shields.io/travis/jshttp/mime-types/master.svg
[travis-url]: https://travis-ci.org/jshttp/mime-types
[coveralls-image]: https://img.shields.io/coveralls/jshttp/mime-types/master.svg
[coveralls-url]: https://coveralls.io/r/jshttp/mime-types
[downloads-image]: https://img.shields.io/npm/dm/mime-types.svg
[downloads-url]: https://npmjs.org/package/mime-types

## ./node_modules/serve-handler

# serve-handler

[![Tests](https://github.com/vercel/serve-handler/actions/workflows/tests.yaml/badge.svg)](https://github.com/vercel/serve-handler/actions/workflows/tests.yaml)
[![codecov](https://codecov.io/gh/vercel/serve-handler/branch/main/graph/badge.svg)](https://codecov.io/gh/vercel/serve-handler)
[![install size](https://packagephobia.now.sh/badge?p=serve-handler)](https://packagephobia.now.sh/result?p=serve-handler)

This package represents the core of [serve](https://github.com/vercel/serve). It can be plugged into any HTTP server and is responsible for routing requests and handling responses.

In order to customize the default behaviour, you can also pass custom routing rules, provide your own methods for interacting with the file system and much more.

## Usage

Get started by installing the package using [yarn](https://yarnpkg.com/lang/en/):

```sh
yarn add serve-handler
```

You can also use [npm](https://www.npmjs.com/) instead, if you'd like:

```sh
npm install serve-handler
```

Next, add it to your HTTP server. Here's an example using [micro](https://github.com/vercel/micro):

```js
const handler = require('serve-handler');

module.exports = async (request, response) => {
  await handler(request, response);
};
```

That's it! :tada:

## Options

If you want to customize the package's default behaviour, you can use the third argument of the function call to pass any of the configuration options listed below. Here's an example:

```js
await handler(request, response, {
  cleanUrls: true
});
```

You can use any of the following options:

| Property                                             | Description                                                           |
|------------------------------------------------------|-----------------------------------------------------------------------|
| [`public`](#public-string)                           | Set a sub directory to be served                                      |
| [`cleanUrls`](#cleanurls-booleanarray)               | Have the `.html` extension stripped from paths                        |
| [`rewrites`](#rewrites-array)                        | Rewrite paths to different paths                                      |
| [`redirects`](#redirects-array)                      | Forward paths to different paths or external URLs                     |
| [`headers`](#headers-array)                          | Set custom headers for specific paths                                 |
| [`directoryListing`](#directorylisting-booleanarray) | Disable directory listing or restrict it to certain paths             |
| [`unlisted`](#unlisted-array)                        | Exclude paths from the directory listing                              |
| [`trailingSlash`](#trailingslash-boolean)            | Remove or add trailing slashes to all paths                           |
| [`renderSingle`](#rendersingle-boolean)              | If a directory only contains one file, render it                      |
| [`symlinks`](#symlinks-boolean)                      | Resolve symlinks instead of rendering a 404 error                     |
| [`etag`](#etag-boolean)                              | Calculate a strong `ETag` response header, instead of `Last-Modified` |

### public (String)

By default, the current working directory will be served. If you only want to serve a specific path, you can use this options to pass an absolute path or a custom directory to be served relative to the current working directory.

For example, if serving a [Jekyll](https://jekyllrb.com/) app, it would look like this:

```json
{
  "public": "_site"
}
```

Using absolute path:

```json
{
  "public": "/path/to/your/_site"
}
```

**NOTE:** The path cannot contain globs or regular expressions.

### cleanUrls (Boolean|Array)

By default, all `.html` files can be accessed without their extension.

If one of these extensions is used at the end of a filename, it will automatically perform a redirect with status code [301](https://en.wikipedia.org/wiki/HTTP_301) to the same path, but with the extension dropped.

You can disable the feature like follows:

```json
{
  "cleanUrls": false
}
```

However, you can also restrict it to certain paths:

```json
{
  "cleanUrls": [
    "/app/**",
    "/!components/**"
  ]
}
```

**NOTE:** The paths can only contain globs that are matched using [minimatch](https://github.com/isaacs/minimatch).

### rewrites (Array)

If you want your visitors to receive a response under a certain path, but actually serve a completely different one behind the curtains, this option is what you need.

It's perfect for [single page applications](https://en.wikipedia.org/wiki/Single-page_application) (SPAs), for example:

```json
{
  "rewrites": [
    { "source": "app/**", "destination": "/index.html" },
    { "source": "projects/*/edit", "destination": "/edit-project.html" }
  ]
}
```

You can also use so-called "routing segments" as follows:

```json
{
  "rewrites": [
    { "source": "/projects/:id/edit", "destination": "/edit-project-:id.html" },
  ]
}
```

Now, if a visitor accesses `/projects/123/edit`, it will respond with the file `/edit-project-123.html`.

**NOTE:** The paths can contain globs (matched using [minimatch](https://github.com/isaacs/minimatch)) or regular expressions (match using [path-to-regexp](https://github.com/pillarjs/path-to-regexp)).

### redirects (Array)

In order to redirect visits to a certain path to a different one (or even an external URL), you can use this option:

```json
{
  "redirects": [
    { "source": "/from", "destination": "/to" },
    { "source": "/old-pages/**", "destination": "/home" }
  ]
}
```

By default, all of them are performed with the status code [301](https://en.wikipedia.org/wiki/HTTP_301), but this behavior can be adjusted by setting the `type` property directly on the object (see below).

Just like with [rewrites](#rewrites-array), you can also use routing segments:

```json
{
  "redirects": [
    { "source": "/old-docs/:id", "destination": "/new-docs/:id" },
    { "source": "/old", "destination": "/new", "type": 302 }
  ]
}
```

In the example above, `/old-docs/12` would be forwarded to `/new-docs/12` with status code [301](https://en.wikipedia.org/wiki/HTTP_301). In addition `/old` would be forwarded to `/new` with status code [302](https://en.wikipedia.org/wiki/HTTP_302).

**NOTE:** The paths can contain globs (matched using [minimatch](https://github.com/isaacs/minimatch)) or regular expressions (match using [path-to-regexp](https://github.com/pillarjs/path-to-regexp)).

### headers (Array)

Allows you to set custom headers (and overwrite the default ones) for certain paths:

```json
{
  "headers": [
    {
      "source" : "**/*.@(jpg|jpeg|gif|png)",
      "headers" : [{
        "key" : "Cache-Control",
        "value" : "max-age=7200"
      }]
    }, {
      "source" : "404.html",
      "headers" : [{
        "key" : "Cache-Control",
        "value" : "max-age=300"
      }]
    }
  ]
}
```

If you define the `ETag` header for a path, the handler will automatically reply with status code `304` for that path if a request comes in with a matching `If-None-Match` header.

If you set a header `value` to `null` it removes any previous defined header with the same key.

**NOTE:** The paths can only contain globs that are matched using [minimatch](https://github.com/isaacs/minimatch).

### directoryListing (Boolean|Array)

For paths are not files, but directories, the package will automatically render a good-looking list of all the files and directories contained inside that directory.

If you'd like to disable this for all paths, set this option to `false`. Furthermore, you can also restrict it to certain directory paths if you want:

```json
{
  "directoryListing": [
    "/assets/**",
    "/!assets/private"
  ]
}
```

**NOTE:** The paths can only contain globs that are matched using [minimatch](https://github.com/isaacs/minimatch).

### unlisted (Array)

In certain cases, you might not want a file or directory to appear in the directory listing. In these situations, there are two ways of solving this problem.

Either you disable the directory listing entirely (like shown [here](#directorylisting-booleanarray)), or you exclude certain paths from those listings by adding them all to this config property.

```json
{
  "unlisted": [
    ".DS_Store",
    ".git"
  ]
}
```

The items shown above are excluded from the directory listing by default.

**NOTE:** The paths can only contain globs that are matched using [minimatch](https://github.com/isaacs/minimatch).

### trailingSlash (Boolean)

By default, the package will try to make assumptions for when to add trailing slashes to your URLs or not. If you want to remove them, set this property to `false` and `true` if you want to force them on all URLs:

```js
{
  "trailingSlash": true
}
```

With the above config, a request to `/test` would now result in a [301](https://en.wikipedia.org/wiki/HTTP_301) redirect to `/test/`.

### renderSingle (Boolean)

Sometimes you might want to have a directory path actually render a file, if the directory only contains one. This is only useful for any files that are not `.html` files (for those, [`cleanUrls`](#cleanurls-booleanarray) is faster).

This is disabled by default and can be enabled like this:

```js
{
  "renderSingle": true
}
```

After that, if you access your directory `/test` (for example), you will see an image being rendered if the directory contains a single image file.

### symlinks (Boolean)

For security purposes, symlinks are disabled by default. If `serve-handler` encounters a symlink, it will treat it as if it doesn't exist in the first place. In turn, a 404 error is rendered for that path.

However, this behavior can easily be adjusted:

```js
{
  "symlinks": true
}
```

Once this property is set as shown above, all symlinks will automatically be resolved to their targets.

### etag (Boolean)

HTTP response headers will contain a strong [`ETag`][etag] response header, instead of a [`Last-Modified`][last-modified] header. Opt-in because calculating the hash value may be computationally expensive for large files.

Sending an `ETag` header is disabled by default and can be enabled like this:

```js
{
  "etag": true
}
```

## Error templates

The handler will automatically determine the right error format if one occurs and then sends it to the client in that format.

Furthermore, this allows you to not just specifiy an error template for `404` errors, but also for all other errors that can occur (e.g. `400` or `500`).

Just add a `<status-code>.html` file to the root directory and you're good.

## Middleware

If you want to replace the methods the package is using for interacting with the file system and sending responses, you can pass them as the fourth argument to the function call.

These are the methods used by the package (they can all return a `Promise` or be asynchronous):

```js
await handler(request, response, undefined, {
  lstat(path) {},
  realpath(path) {},
  createReadStream(path, config) {}
  readdir(path) {},
  sendError(absolutePath, response, acceptsJSON, root, handlers, config, error) {}
});
```

**NOTE:** It's important that – for native methods like `createReadStream` – all arguments are passed on to the native call.

## Author

Leo Lamprecht ([@leo](https://x.com/leo)) - [Vercel](https://vercel.com)


[etag]: https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/ETag
[last-modified]: https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Last-Modified

## ./node_modules/signal-exit

# signal-exit

[![Build Status](https://travis-ci.org/tapjs/signal-exit.png)](https://travis-ci.org/tapjs/signal-exit)
[![Coverage](https://coveralls.io/repos/tapjs/signal-exit/badge.svg?branch=master)](https://coveralls.io/r/tapjs/signal-exit?branch=master)
[![NPM version](https://img.shields.io/npm/v/signal-exit.svg)](https://www.npmjs.com/package/signal-exit)
[![Standard Version](https://img.shields.io/badge/release-standard%20version-brightgreen.svg)](https://github.com/conventional-changelog/standard-version)

When you want to fire an event no matter how a process exits:

* reaching the end of execution.
* explicitly having `process.exit(code)` called.
* having `process.kill(pid, sig)` called.
* receiving a fatal signal from outside the process

Use `signal-exit`.

```js
var onExit = require('signal-exit')

onExit(function (code, signal) {
  console.log('process exited!')
})
```

## API

`var remove = onExit(function (code, signal) {}, options)`

The return value of the function is a function that will remove the
handler.

Note that the function *only* fires for signals if the signal would
cause the process to exit.  That is, there are no other listeners, and
it is a fatal signal.

## Options

* `alwaysLast`: Run this handler after any other signal or exit
  handlers.  This causes `process.emit` to be monkeypatched.

## ./node_modules/universalify

# universalify

![GitHub Workflow Status (branch)](https://img.shields.io/github/actions/workflow/status/RyanZim/universalify/ci.yml?branch=master)
![Coveralls github branch](https://img.shields.io/coveralls/github/RyanZim/universalify/master.svg)
![npm](https://img.shields.io/npm/dm/universalify.svg)
![npm](https://img.shields.io/npm/l/universalify.svg)

Make a callback- or promise-based function support both promises and callbacks.

Uses the native promise implementation.

## Installation

```bash
npm install universalify
```

## API

### `universalify.fromCallback(fn)`

Takes a callback-based function to universalify, and returns the universalified  function.

Function must take a callback as the last parameter that will be called with the signature `(error, result)`. `universalify` does not support calling the callback with three or more arguments, and does not ensure that the callback is only called once.

```js
function callbackFn (n, cb) {
  setTimeout(() => cb(null, n), 15)
}

const fn = universalify.fromCallback(callbackFn)

// Works with Promises:
fn('Hello World!')
.then(result => console.log(result)) // -> Hello World!
.catch(error => console.error(error))

// Works with Callbacks:
fn('Hi!', (error, result) => {
  if (error) return console.error(error)
  console.log(result)
  // -> Hi!
})
```

### `universalify.fromPromise(fn)`

Takes a promise-based function to universalify, and returns the universalified  function.

Function must return a valid JS promise. `universalify` does not ensure that a valid promise is returned.

```js
function promiseFn (n) {
  return new Promise(resolve => {
    setTimeout(() => resolve(n), 15)
  })
}

const fn = universalify.fromPromise(promiseFn)

// Works with Promises:
fn('Hello World!')
.then(result => console.log(result)) // -> Hello World!
.catch(error => console.error(error))

// Works with Callbacks:
fn('Hi!', (error, result) => {
  if (error) return console.error(error)
  console.log(result)
  // -> Hi!
})
```

## License

MIT

## ./node_modules/update-check

# update-check 

[![npm version](https://img.shields.io/npm/v/update-check.svg)](https://www.npmjs.com/package/update-check)
[![install size](https://packagephobia.now.sh/badge?p=update-check)](https://packagephobia.now.sh/result?p=update-check)

This is a very minimal approach to update checking for [globally installed](https://docs.npmjs.com/getting-started/installing-npm-packages-globally) packages.

Because it's so simple, the error surface is very tiny and your user's are guaranteed to receive the update message if there's a new version.

You can read more about the reasoning behind this project [here](https://twitter.com/notquiteleo/status/983193273224200192).

## Usage

Firstly, install the package with [yarn](https://yarnpkg.com/en/)...

```bash
yarn add update-check
```

...or [npm](https://www.npmjs.com/):

```bash
npm install update-check
```

Next, initialize it.

If there's a new update available, the package will return the content of latest version's `package.json` file:

```js
const pkg = require('./package');
const checkForUpdate = require('update-check');

let update = null;

try {
	update = await checkForUpdate(pkg);
} catch (err) {
	console.error(`Failed to check for updates: ${err}`);
}

if (update) {
	console.log(`The latest version is ${update.latest}. Please update!`);
}
```

That's it! You're done.

### Configuration

If you want, you can also pass options to customize the package's behavior:

```js
const pkg = require('./package');
const checkForUpdate = require('update-check');

let update = null;

try {
	update = await checkForUpdate(pkg, {
		interval: 3600000,  // For how long to cache latest version (default: 1 day)
		distTag: 'canary'   // A npm distribution tag for comparision (default: 'latest')
	});
} catch (err) {
	console.error(`Failed to check for updates: ${err}`);
}

if (update) {
	console.log(`The latest version is ${update.latest}. Please update!`);
}
```

## Contributing

1. [Fork](https://help.github.com/articles/fork-a-repo/) this repository to your own GitHub account and then [clone](https://help.github.com/articles/cloning-a-repository/) it to your local device
2. Link the package to the global module directory: `npm link`
3. Within the module you want to test your local development instance of the package, just link it: `npm link update-check`. Instead of the default one from npm, node will now use your clone.

## Author

Leo Lamprecht ([@notquiteleo](https://twitter.com/notquiteleo)) - [ZEIT](https://zeit.co)


## ./node_modules/uri-js

# URI.js

URI.js is an [RFC 3986](http://www.ietf.org/rfc/rfc3986.txt) compliant, scheme extendable URI parsing/validating/resolving library for all JavaScript environments (browsers, Node.js, etc).
It is also compliant with the IRI ([RFC 3987](http://www.ietf.org/rfc/rfc3987.txt)), IDNA ([RFC 5890](http://www.ietf.org/rfc/rfc5890.txt)), IPv6 Address ([RFC 5952](http://www.ietf.org/rfc/rfc5952.txt)), IPv6 Zone Identifier ([RFC 6874](http://www.ietf.org/rfc/rfc6874.txt)) specifications.

URI.js has an extensive test suite, and works in all (Node.js, web) environments. It weighs in at 6.4kb (gzipped, 17kb deflated).

## API

### Parsing

	URI.parse("uri://user:pass@example.com:123/one/two.three?q1=a1&q2=a2#body");
	//returns:
	//{
	//  scheme : "uri",
	//  userinfo : "user:pass",
	//  host : "example.com",
	//  port : 123,
	//  path : "/one/two.three",
	//  query : "q1=a1&q2=a2",
	//  fragment : "body"
	//}

### Serializing

	URI.serialize({scheme : "http", host : "example.com", fragment : "footer"}) === "http://example.com/#footer"

### Resolving

	URI.resolve("uri://a/b/c/d?q", "../../g") === "uri://a/g"

### Normalizing

	URI.normalize("HTTP://ABC.com:80/%7Esmith/home.html") === "http://abc.com/~smith/home.html"

### Comparison

	URI.equal("example://a/b/c/%7Bfoo%7D", "eXAMPLE://a/./b/../b/%63/%7bfoo%7d") === true

### IP Support

	//IPv4 normalization
	URI.normalize("//192.068.001.000") === "//192.68.1.0"

	//IPv6 normalization
	URI.normalize("//[2001:0:0DB8::0:0001]") === "//[2001:0:db8::1]"

	//IPv6 zone identifier support
	URI.parse("//[2001:db8::7%25en1]");
	//returns:
	//{
	//  host : "2001:db8::7%en1"
	//}

### IRI Support

	//convert IRI to URI
	URI.serialize(URI.parse("http://examplé.org/rosé")) === "http://xn--exampl-gva.org/ros%C3%A9"
	//convert URI to IRI
	URI.serialize(URI.parse("http://xn--exampl-gva.org/ros%C3%A9"), {iri:true}) === "http://examplé.org/rosé"

### Options

All of the above functions can accept an additional options argument that is an object that can contain one or more of the following properties:

*	`scheme` (string)

	Indicates the scheme that the URI should be treated as, overriding the URI's normal scheme parsing behavior.

*	`reference` (string)

	If set to `"suffix"`, it indicates that the URI is in the suffix format, and the validator will use the option's `scheme` property to determine the URI's scheme.

*	`tolerant` (boolean, false)

	If set to `true`, the parser will relax URI resolving rules.

*	`absolutePath` (boolean, false)

	If set to `true`, the serializer will not resolve a relative `path` component.

*	`iri` (boolean, false)

	If set to `true`, the serializer will unescape non-ASCII characters as per [RFC 3987](http://www.ietf.org/rfc/rfc3987.txt).

*	`unicodeSupport` (boolean, false)

	If set to `true`, the parser will unescape non-ASCII characters in the parsed output as per [RFC 3987](http://www.ietf.org/rfc/rfc3987.txt).

*	`domainHost` (boolean, false)

	If set to `true`, the library will treat the `host` component as a domain name, and convert IDNs (International Domain Names) as per [RFC 5891](http://www.ietf.org/rfc/rfc5891.txt).

## Scheme Extendable

URI.js supports inserting custom [scheme](http://en.wikipedia.org/wiki/URI_scheme) dependent processing rules. Currently, URI.js has built in support for the following schemes:

*	http \[[RFC 2616](http://www.ietf.org/rfc/rfc2616.txt)\]
*	https \[[RFC 2818](http://www.ietf.org/rfc/rfc2818.txt)\]
*	ws \[[RFC 6455](http://www.ietf.org/rfc/rfc6455.txt)\]
*	wss \[[RFC 6455](http://www.ietf.org/rfc/rfc6455.txt)\]
*	mailto \[[RFC 6068](http://www.ietf.org/rfc/rfc6068.txt)\]
*	urn \[[RFC 2141](http://www.ietf.org/rfc/rfc2141.txt)\]
*	urn:uuid \[[RFC 4122](http://www.ietf.org/rfc/rfc4122.txt)\]

### HTTP/HTTPS Support

	URI.equal("HTTP://ABC.COM:80", "http://abc.com/") === true
	URI.equal("https://abc.com", "HTTPS://ABC.COM:443/") === true

### WS/WSS Support

	URI.parse("wss://example.com/foo?bar=baz");
	//returns:
	//{
	//	scheme : "wss",
	//	host: "example.com",
	//	resourceName: "/foo?bar=baz",
	//	secure: true,
	//}

	URI.equal("WS://ABC.COM:80/chat#one", "ws://abc.com/chat") === true

### Mailto Support

	URI.parse("mailto:alpha@example.com,bravo@example.com?subject=SUBSCRIBE&body=Sign%20me%20up!");
	//returns:
	//{
	//	scheme : "mailto",
	//	to : ["alpha@example.com", "bravo@example.com"],
	//	subject : "SUBSCRIBE",
	//	body : "Sign me up!"
	//}

	URI.serialize({
		scheme : "mailto",
		to : ["alpha@example.com"],
		subject : "REMOVE",
		body : "Please remove me",
		headers : {
			cc : "charlie@example.com"
		}
	}) === "mailto:alpha@example.com?cc=charlie@example.com&subject=REMOVE&body=Please%20remove%20me"

### URN Support

	URI.parse("urn:example:foo");
	//returns:
	//{
	//	scheme : "urn",
	//	nid : "example",
	//	nss : "foo",
	//}

#### URN UUID Support

	URI.parse("urn:uuid:f81d4fae-7dec-11d0-a765-00a0c91e6bf6");
	//returns:
	//{
	//	scheme : "urn",
	//	nid : "uuid",
	//	uuid : "f81d4fae-7dec-11d0-a765-00a0c91e6bf6",
	//}

## Usage

To load in a browser, use the following tag:

	<script type="text/javascript" src="uri-js/dist/es5/uri.all.min.js"></script>

To load in a CommonJS/Module environment, first install with npm/yarn by running on the command line:

	npm install uri-js
	# OR
	yarn add uri-js

Then, in your code, load it using:

	const URI = require("uri-js");

If you are writing your code in ES6+ (ESNEXT) or TypeScript, you would load it using:

	import * as URI from "uri-js";

Or you can load just what you need using named exports:

	import { parse, serialize, resolve, resolveComponents, normalize, equal, removeDotSegments, pctEncChar, pctDecChars, escapeComponent, unescapeComponent } from "uri-js";

## Breaking changes

### Breaking changes from 3.x

URN parsing has been completely changed to better align with the specification. Scheme is now always `urn`, but has two new properties: `nid` which contains the Namspace Identifier, and `nss` which contains the Namespace Specific String. The `nss` property will be removed by higher order scheme handlers, such as the UUID URN scheme handler.

The UUID of a URN can now be found in the `uuid` property.

### Breaking changes from 2.x

URI validation has been removed as it was slow, exposed a vulnerabilty, and was generally not useful.

### Breaking changes from 1.x

The `errors` array on parsed components is now an `error` string.

## ./node_modules/vary

# vary

[![NPM Version][npm-image]][npm-url]
[![NPM Downloads][downloads-image]][downloads-url]
[![Node.js Version][node-version-image]][node-version-url]
[![Build Status][travis-image]][travis-url]
[![Test Coverage][coveralls-image]][coveralls-url]

Manipulate the HTTP Vary header

## Installation

This is a [Node.js](https://nodejs.org/en/) module available through the
[npm registry](https://www.npmjs.com/). Installation is done using the
[`npm install` command](https://docs.npmjs.com/getting-started/installing-npm-packages-locally): 

```sh
$ npm install vary
```

## API

<!-- eslint-disable no-unused-vars -->

```js
var vary = require('vary')
```

### vary(res, field)

Adds the given header `field` to the `Vary` response header of `res`.
This can be a string of a single field, a string of a valid `Vary`
header, or an array of multiple fields.

This will append the header if not already listed, otherwise leaves
it listed in the current location.

<!-- eslint-disable no-undef -->

```js
// Append "Origin" to the Vary header of the response
vary(res, 'Origin')
```

### vary.append(header, field)

Adds the given header `field` to the `Vary` response header string `header`.
This can be a string of a single field, a string of a valid `Vary` header,
or an array of multiple fields.

This will append the header if not already listed, otherwise leaves
it listed in the current location. The new header string is returned.

<!-- eslint-disable no-undef -->

```js
// Get header string appending "Origin" to "Accept, User-Agent"
vary.append('Accept, User-Agent', 'Origin')
```

## Examples

### Updating the Vary header when content is based on it

```js
var http = require('http')
var vary = require('vary')

http.createServer(function onRequest (req, res) {
  // about to user-agent sniff
  vary(res, 'User-Agent')

  var ua = req.headers['user-agent'] || ''
  var isMobile = /mobi|android|touch|mini/i.test(ua)

  // serve site, depending on isMobile
  res.setHeader('Content-Type', 'text/html')
  res.end('You are (probably) ' + (isMobile ? '' : 'not ') + 'a mobile user')
})
```

## Testing

```sh
$ npm test
```

## License

[MIT](LICENSE)

[npm-image]: https://img.shields.io/npm/v/vary.svg
[npm-url]: https://npmjs.org/package/vary
[node-version-image]: https://img.shields.io/node/v/vary.svg
[node-version-url]: https://nodejs.org/en/download
[travis-image]: https://img.shields.io/travis/jshttp/vary/master.svg
[travis-url]: https://travis-ci.org/jshttp/vary
[coveralls-image]: https://img.shields.io/coveralls/jshttp/vary/master.svg
[coveralls-url]: https://coveralls.io/r/jshttp/vary
[downloads-image]: https://img.shields.io/npm/dm/vary.svg
[downloads-url]: https://npmjs.org/package/vary

## ./node_modules/which

# which

Like the unix `which` utility.

Finds the first instance of a specified executable in the PATH
environment variable.  Does not cache the results, so `hash -r` is not
needed when the PATH changes.

## USAGE

```javascript
var which = require('which')

// async usage
which('node', function (er, resolvedPath) {
  // er is returned if no "node" is found on the PATH
  // if it is found, then the absolute path to the exec is returned
})

// or promise
which('node').then(resolvedPath => { ... }).catch(er => { ... not found ... })

// sync usage
// throws if not found
var resolved = which.sync('node')

// if nothrow option is used, returns null if not found
resolved = which.sync('node', {nothrow: true})

// Pass options to override the PATH and PATHEXT environment vars.
which('node', { path: someOtherPath }, function (er, resolved) {
  if (er)
    throw er
  console.log('found at %j', resolved)
})
```

## CLI USAGE

Same as the BSD `which(1)` binary.

```
usage: which [-as] program ...
```

## OPTIONS

You may pass an options object as the second argument.

- `path`: Use instead of the `PATH` environment variable.
- `pathExt`: Use instead of the `PATHEXT` environment variable.
- `all`: Return all matches, instead of just the first one.  Note that
  this means the function returns an array of strings instead of a
  single string.

## ./node_modules/@zeit/schemas

# Vercel Schemas

Schemas used across many Vercel packages to validating config files, requests to APIs, and more.

## Why?

- Keep schemas used across Vercel projects in sync
- We use `.js` instead of `.json` because parsing JSON takes longer

## Usage

To get started, pick one of the schemas in this repository and load it:

```js
const schema = require('@zeit/schemas/deployment/config');
```

Next, set up [AJV](https://github.com/epoberezkin/ajv) (the validator) and run the schema through it:

```js
const AJV = require('ajv');

const ajv = new AJV({ allErrors: true });
const isValid = ajv.validate(schema, <object-to-validate>);

if (!isValid) {
	console.error(`The following entries are wrong: ${JSON.stringify(ajv.errors)}`);
}
```

That is all! :tada:

## Contributing

We are currently not accepting external contributions for this repository.

## .

# WronAI Projects Dashboard

A static dashboard to showcase WronAI's open source projects with automatic repository analysis and deployment to GitHub Pages.

## Features

- Automatic repository analysis (via GitHub Actions)
- Package manager detection (pip, npm, yarn, poetry)
- PyPI package verification
- Docker support detection
- GitHub Actions workflow detection
- Responsive design with dark mode support
- Deployed as a static site on GitHub Pages
- Local development and testing support
- Automated workflows for analysis and deployment
- Concurrent deployment protection
- Branch-specific deployments

## Local Development

### Prerequisites

- Node.js 20+ (LTS recommended)
- npm
- Python 3.10+ (for repository analysis)
- Docker (for local GitHub Actions testing)

### Getting Started

1. **Clone the repository**:
   ```bash
   git clone https://github.com/wronai/www.git
   cd www
   ```

2. **Install dependencies**:
   ```bash
   npm install
   ```

3. **Run the development server**:
   ```bash
   make dev
   ```
   This will start a local server at http://localhost:3000

## GitHub Actions Workflows

The project uses GitHub Actions for CI/CD with the following workflows:

### 1. Analyze Repositories (`analyze.yml`)
- Runs daily at 4 AM UTC or on push to `repo-analyzer/**`
- Analyzes all repositories in the organization
- Updates `repos.json` with the latest information
- Automatically commits and pushes changes

### 2. Deploy to GitHub Pages (`deploy.yml`)
- Triggers on push to `main` branch or after successful analysis
- Builds the production site
- Deploys to GitHub Pages
- Includes branch-specific concurrency control

### 3. Static Site Deployment (`static-deploy.yml`)
- Alternative deployment workflow
- Includes additional validation steps
- Handles SPA routing with custom 404 page

## Local Development

### Prerequisites
- Node.js 20+
- npm
- Python 3.10+
- Docker (for local testing)

### Setup

1. **Clone the repository**:
   ```bash
   git clone https://github.com/wronai/www.git
   cd www
   ```

2. **Install dependencies**:
   ```bash
   npm install
   ```

3. **Start development server**:
   ```bash
   make dev
   ```
   This starts a local server at http://localhost:3000

4. **Update repository data**:
   ```bash
   make update-repos
   ```
   This updates the `repos.json` with the latest repository information.

## Available Make Commands

Run `make help` to see all available commands:

```
make help           Show this help
make install        Install dependencies
make dev            Start development server
make build          Build for production
make preview        Preview production build
make clean          Clean build artifacts
make update-repos   Update repository data
make setup-dev      Set up development tools
make test-gh-actions Test GitHub Actions locally
make setup-test-env  Set up test environment
```

### Command Details

- `make install` - Install all project dependencies
- `make dev` - Start the development server at http://localhost:3000
- `make build` - Build the production version of the site
- `make preview` - Preview the production build locally
- `make clean` - Remove build artifacts and temporary files
- `make update-repos` - Update repository data using `update_repos.py`
- `make setup-test-env` - Set up the test environment with necessary files

## Repository Analysis

The system automatically analyzes repositories to extract:

- Package information (name, version)
- Dependencies
- Docker support
- CI/CD configuration
- Last update time
- Language detection

### Manual Analysis

To manually update repository data:

```bash
make update-repos
```

This will:
1. Fetch the latest repository information
2. Update `repos.json`
3. Create a backup of the previous data

## Repository Analysis

The system automatically analyzes repositories to extract:

- Package information (name, version)
- Dependencies
- Docker support
- CI/CD configuration

To manually trigger repository analysis:

```bash
make analyze
```

This will:
1. Clone and analyze all repositories
2. Update `repos.json` with the latest information
3. Create a backup of the previous data

## Development

### Project Structure

```
www/
├── src/                  # Source files
│   ├── css/              # Stylesheets
│   ├── js/               # JavaScript files
│   └── index.html        # Main HTML file
├── .github/workflows/    # GitHub Actions workflows
├── repo-analyzer/        # Repository analysis tools
├── scripts/              # Utility scripts
└── update_repos.py       # Main repository update script

### Adding a New Repository

1. The system automatically detects new repositories in the organization
2. Run `make update-repos` to update the data
3. The changes will be included in the next deployment

### Customizing the Dashboard

- Edit `src/index.html` for the main structure
- Modify `src/css/styles.css` for styling
- Update `src/js/main.js` for interactivity
- Update repository cards in `src/js/main.js`

## Deployment

The site is automatically deployed to GitHub Pages through GitHub Actions. The deployment process:

1. **Analysis Workflow**:
   - Runs daily or on push to `repo-analyzer/**`
   - Updates repository metadata
   - Commits changes to `repos.json`

2. **Deployment Workflow**:
   - Triggers on push to `main` or after analysis
   - Installs dependencies
   - Builds the production site
   - Deploys to GitHub Pages

### Manual Deployment

1. Make your changes
2. Commit and push to `main`
3. The deployment will start automatically

## Troubleshooting

### Common Issues

1. **Build fails**
   - Run `npm install` to ensure all dependencies are installed
   - Check for errors in the GitHub Actions logs

2. **Repository data not updating**
   - Run `make update-repos` manually
   - Check the `analyze` workflow logs

3. **Deployment fails**
   - Verify all required files exist
   - Check for syntax errors in the workflow files
   - Ensure GitHub Pages is properly configured in the repository settings

## License

Apache 2.0

## License

Apache
