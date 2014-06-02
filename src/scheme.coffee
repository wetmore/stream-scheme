Tokenizer = require './tokenizer'
split = require 'split'

program = require 'commander'
fs = require 'fs'
_ = require 'highland'

program
  .version('0.0.0')
  .parse(process.argv)

if program.args[0]
  source = fs.createReadStream(program.args[0])
    .pipe split()

  _(source)
    .through Tokenizer
    .each _.log
