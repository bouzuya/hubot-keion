{Robot, User, TextMessage} = require 'hubot'
assert = require 'power-assert'
path = require 'path'
sinon = require 'sinon'

describe 'keion', ->
  beforeEach (done) ->
    @sinon = sinon.sandbox.create()
    # for warning: possible EventEmitter memory leak detected.
    # process.on 'uncaughtException'
    @sinon.stub process, 'on', -> null
    @robot = new Robot(path.resolve(__dirname, '..'), 'shell', false, 'hubot')
    @robot.adapter.on 'connected', =>
      @robot.load path.resolve(__dirname, '../../src/scripts')
      done()
    @robot.run()

  afterEach (done) ->
    @robot.brain.on 'close', =>
      @sinon.restore()
      done()
    @robot.shutdown()

  describe 'listeners[0].regex', ->
    beforeEach ->
      @sender = new User 'bouzuya', room: 'hitoridokusho'
      @callback = @sinon.spy()
      @robot.listeners[0].callback = @callback

    describe 'receive "@hubot keion *い*ん"', ->
      beforeEach ->
        message = '@hubot keion *い*ん'
        @robot.adapter.receive new TextMessage(@sender, message)

      it 'calls with "@hubot keion *い*ん"', ->
        assert @callback.callCount is 1
        match = @callback.firstCall.args[0].match
        assert match.length is 3
        assert match[0] is '@hubot keion *い*ん'
        assert match[1] is '*い*ん'
        assert match[2] is undefined

    describe 'receive "@hubot keion *い*ん 12"', ->
      beforeEach ->
        message = '@hubot keion *い*ん* 12'
        @robot.adapter.receive new TextMessage(@sender, message)

      it 'calls with "@hubot keion *い*ん* 12"', ->
        assert @callback.callCount is 1
        match = @callback.firstCall.args[0].match
        assert match.length is 3
        assert match[0] is '@hubot keion *い*ん* 12'
        assert match[1] is '*い*ん*'
        assert match[2] is '12'

  describe 'listeners[0].callback', ->
    beforeEach ->
      @hello = @robot.listeners[0].callback

    describe 'receive "@hubot keion ****"', ->
      beforeEach ->
        @send = @sinon.spy()
        @hello
          match: ['@hubot keion ****', '****', undefined]
          send: @send

      it 'send "****"', ->
        assert @send.callCount is 1
        result = @send.firstCall.args[0].split(/\n/)
        assert result.length is 1
        assert result.every (s) -> s.length is '****'.length

    describe 'receive "@hubot keion **** 12"', ->
      beforeEach ->
        @send = @sinon.spy()
        @hello
          match: ['@hubot keion **** 12', '****', '12']
          send: @send

      it 'send "****" * 12', ->
        assert @send.callCount is 1
        result = @send.firstCall.args[0].split(/\n/)
        assert result.length is 12
        assert result.every (s) -> s.length is '****'.length

    describe 'receive "@hubot keion *い** 3"', ->
      beforeEach ->
        @send = @sinon.spy()
        @hello
          match: ['@hubot keion *い** 3', '*い**', '3']
          send: @send

      it 'send "*い**" * 3', ->
        assert @send.callCount is 1
        result = @send.firstCall.args[0].split(/\n/)
        assert result.length is 3
        assert result.every (s) -> (s.length is '****'.length) and s[1] is 'い'
