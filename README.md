# hubot-keion

A Hubot script that generate a random name like ke-i-o-n.

## Installation

    $ npm install git://github.com/bouzuya/hubot-keion.git

or

    $ # TAG is the package version you need.
    $ npm install 'git://github.com/bouzuya/hubot-keion.git#TAG'

## Sample Interaction

    bouzuya> hubot help keion
    hubot> hubot keion <part-of-name> [<N>] - generate a random name like ke-i-o-n

    bouzuya> hubot keion *い**
    hubot> あいかつ

See [`src/scripts/keion.coffee`](src/scripts/keion.coffee) for full documentation.

## License

MIT

## Development

### Run test

    $ npm test

### Run robot

    $ npm run robot


## Badges

[![Build Status][travis-badge]][travis]
[![Dependencies status][david-dm-badge]][david-dm]

[travis]: https://travis-ci.org/bouzuya/hubot-keion
[travis-badge]: https://travis-ci.org/bouzuya/hubot-keion.svg?branch=master
[david-dm]: https://david-dm.org/bouzuya/hubot-keion
[david-dm-badge]: https://david-dm.org/bouzuya/hubot-keion.png
