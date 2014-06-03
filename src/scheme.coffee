Tokenizer = require './tokenizer'
split = require 'split'
group = require './grouper'

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
    .through group
    .each(_.log)

# _(['(', 'add', '(', 'add', 3, 2, ')', 1, ')']).toArray group