###
The grouper converts the tokens into streams of streams of streams of...
###

_ = require 'highland'

# array version (unused)
readFrom = (tokens) =>
  if tokens.length is 0
    console.error 'Unexpected EOF'
    return
  token = tokens.shift()
  if token is '('
    L = []
    until tokens[0] is ')'
      L.push readFrom(tokens)
    tokens.shift()
    return L
  else if token is ')'
    console.error 'Unexpected )'
    return
  else
    return token

topOf = (array) =>
  return array[array.length - 1]

readFromStream = (tokenStream) =>
  stack = []

  sender = _.curry (push, payload) =>
    if stack.length > 0
      topOf(stack).write payload
    else
      push(null, payload)

  return tokenStream.consume (err, token, push, next) =>
    send = sender push
    if token is '('
      stack.push _()
      next()
    else if token is ')'
      nestedStream = stack.pop()
      nestedStream.end()
      send nestedStream
      next()
    else
      send token
      next()

module.exports = readFromStream