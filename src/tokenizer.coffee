_ = require 'highland'

Tokenizer = (stream) =>
  stream.consume (err, line, push, next) =>
    if err
      push err
      next()
    else if typeof line is 'string'
      tokens = line.replace('(', ' ( ')
        .replace(')', ' ) ')
        .split /\s+/

      (push(null, token) if token) for token in tokens
      next()
    else
      next()

module.exports = Tokenizer