# Description
#   A Hubot script that generate a random name like ke-i-o-n
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot keion <part-of-name> [<N>] - generate a random name like ke-i-o-n
#
# Author:
#   bouzuya <m@bouzuya.net>
#
module.exports = (robot) ->

  KANA_MIN = 3040
  KANA_MAX = 3096
  KANA = new RegExp "^[\\u#{KANA_MIN}-\\u#{KANA_MAX}]$"

  generateKana = ->
    min = KANA_MIN
    max = KANA_MAX
    r = Math.floor(Math.random() * (max - min)) + min
    JSON.parse '"\\u' + r + '"'

  generateName = (part) ->
    [0..(part.length - 1)].map (i) ->
      c = part[i]
      if KANA.test(c) then c else generateKana()
    .join ''

  robot.respond /keion\s+(\S+)(?:\s+(\d+))?$/i, (res) ->
    part = res.match[1]
    count = parseInt (res.match[2] ? '1'), 10
    names = [0..(count - 1)].map -> generateName(part)
    res.send names.join '\n'
