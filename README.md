# Stream Scheme

This is an interpreter and compiler (to javascript) for the Scheme language, 
which I must admit I know very little about. The plan is to create a number of
components which operate on [highland streams](http://highlandjs.org/), and can
be composed together create a compiler or interpreter that works in both the
browser and on a server with node.js. See the following diagram:

````
  +---------+                              +-------------+
  | Browser |>-+                       +-->| Interpreter |
  +---------+   \                     /    +-------------+
                 \   +-----------+   /
                  +->| Tokenizer |>-+
                 /   +-----------+   \
   +--------+   /                     \    +----------+
   | Server |>-+                       +-->| Compiler |>--> Compiled Javascript
   +--------+                              +----------+

````

For the server, a file stream created with `fs.createReadStream()` forms the
input stream. In the browser, a component will generate a readable stream from
a given text input or whatever. For both the server and the browser, there will
also be a REPL.


The input stream is piped through the tokenizer and then into either the
interpreter, which executes the Scheme program as it streams through, or into 
the compiler, which generates a stream of javascript to write to a compiled
file.
