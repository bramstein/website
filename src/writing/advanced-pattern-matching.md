---
layout: content.html
title: Advanced Pattern Matching in JavaScript
classes: writing
---

# Advanced Pattern Matching in JavaScript

We'll start with the pattern matcher we built in [the previous article](pattern-matching.html) . If you haven't read that yet, I would suggest you do so because it will be the foundation for this one. Recall the final factorial function:

```
var fact = match(
  [0, function() { return 1; }],
  [$('n'), function(result) {
    return result.n * fact(result.n - 1);
   }]
);
```

It would be nice if we could address each variable by its name in both the pattern and closure. Unfortunately, there is no way in JavaScript to figure out the name of a variable, so we can not write something like this:

```
var fact = match(
  [0, function()  { return 1; }],
  [n, function(n) { return n * fact(n - 1); }]
);
```

We can however approach a similar syntax if we give up named variables and go for the order in which they are specified. This is similar to how [prepared <abbr>SQL</abrr> statements](http://java.sun.com/docs/books/tutorial/jdbc/basics/prepared.html) work in most programming languages. Instead of calling them variables we'll call them parameters from now on. For simplicity's sake we use a magic number as our parameter.

Before passing the pattern expression to the unify method we rewrite it using the `visit_pattern` method also in the [JUnify library](../projects/junify/). On each rewrite we create increasingly numbered variables when we encounter a parameter. The rewriting step is located in the outer closure so it is only done once per pattern. When the `unify` method returns we iterate through the result object and create an array, which we pass to the closure function.

In the code below, the match function is renamed to the more functional name `fun`, since we're not really matching anymore but definining new functions. The module is also changed so that it throws an exception if none of the patterns match instead of returning undefined.

```
match_parameter = 0xABADBABE;

fun = function () {
  var unify     = unification.unify,
    visit_pattern = unification.visit_pattern,
    variable    = unification.variable,
    slice     = Array.prototype.slice;

  function rewrite(pattern, i) {
    var v = {
      'atom' : function (value) {
        var result;
        if (value === match_parameter) {
          result = variable(i);
          i += 1;
          return result;
        }
        else {
          return value;
        }
      },
      'func' : function (f) {
        var result = variable(i, f);
        i += 1;
        return result;
      }
    };
    return visit_pattern(pattern, v);
  }

  function fun_aux(patterns, value) {
    var i, result, length, key;
    var result_arguments = [];

    for (i = 0; i < patterns.length; i += 1) {
      length = patterns[i].length;

      result = unify(patterns[i].slice(0, length - 1), value);
      if (result) {
        // iterate through the results and insert them in
        // the correct location in our result array
        for (key in result) {
          if (result.hasOwnProperty(key)) {
            result_arguments[key] = result[key];
          }
        }
        // call the closure using the result array
        return patterns[i][length - 1].apply(
          null, result_arguments
        );
      }
    }
    throw {
      name: 'MatchError',
      message: 'Match is not exhaustive: (' + value + ')' +
           ' (' + patterns + ')'
    };
  }

  return function() {
    var patterns = slice.apply(arguments),
      i, l, c;

    for (i = 0; i < patterns.length; i += 1) {
      l = patterns[i].length;

      if (l >= 2 &&
        typeof patterns[i][l - 1] === 'function') {
        c = patterns[i][l - 1];
        patterns[i] = [].concat(
          rewrite(patterns[i].slice(0, l - 1), 0)
        );
        patterns[i].push(c);
      }
    }
    return function() {
      return fun_aux(patterns, slice.apply(arguments));
    };
  };
}();
```

If we rewrite the factorial function using the new syntax the end result should look like this:

```
var $ = match_parameter;

var fact = fun(
  [0, function()  { return 1; } ],
  [$, function(n) { return n * fact(n - 1); } ]
);
```

The syntax could be improved further by using JavaScript 1.8 which allows a short-hand closure syntax. Unfortunately at the time of writing JavaScript 1.8 is only supported by Firefox 3. This example shows what pattern matching could look like in JavaScript 1.8.

```
var $ = match_parameter;

var fact = fun(
  [0, function()  1],
  [$, function(n) n * fact(n - 1)]
);
```

## Algebraic data types

Pattern matching can also be used with [Sjoerd Visscher's Algebraic data type library](http://w3future.com/weblog/stories/2008/06/16/adtinjs.xml). You can read more about [algebraic data types on Wikipedia](http://en.wikipedia.org/wiki/Algebraic_data_type) if you're not familiar with them. In the following example we define a simple binary tree data type. The tree can contain either `Void` or a `Bt` tuple. The tuple consists of a value, and two branches called left and right. In the ML programming language we would define a polymorphic binary tree like this:

```
datatype 'a binarytree = Void | Bt of 'a * 'a binarytree * 'a binarytree
```

In JavaScript --- using the <abbr>ADT</abbr> library --- it looks like this (note that this binary tree is not polymorphic, its values are Numbers.) All the code examples from now are written in JavaScript 1.8 because the <abbr>ADT</abbr> library uses that as well. However, apart from the slightly more verbose syntax, there's nothing that wouldn't work in other JavaScript versions.

```
var BinaryTree = Data(function(binarytree) ({
  Void : {},
  Bt: {
    v: Number, L: binarytree, R: binarytree
  }
}));
```

We can then create a simple binary tree instance using this definition. A visual representation of this binary tree is shown below. The code below also defines two short hand variables for the match parameter and the wildcard constant.

![A binary tree](/assets/images/btree.svg)

```
var bt = Bt(4,
       Bt(2, Bt(1,Void,Void),
           Bt(3,Void,Void)),
       Bt(8, Bt(6, Bt(5,Void,Void),
             Bt(7,Void,Void)),
           Bt(9,Void,Void)));

var $ = match_parameter;
var _ = unification._; // wildcard
```

We can now define various functions, for example to calculate the number of leafs (nodes without children) in the tree, or a function to test whether a value is a member of the binary tree. It is possible to use the data types in patterns, for example the `numLeafs` method first matches on an empty node, then a leaf node and finally on any other kind of node. The `isMember` method shows that the matching is not limited to one function parameter; the value to search for is taken as the first parameter and the binary tree as the second parameter.

```
var numLeafs = fun(
  [Void, function() 0],        // empty node
  [Bt(_, Void, Void), function() 1], // leaf node
  [Bt(_, $, $), function(L, R) numLeafs(L) + numLeafs(R)]
);

var isMember = fun(
  [_, Void, function() false],
  [$, Bt($, $, $), function(x, v, L, R) x === v || (isMember(x, L) || isMember(x, R))]
);

numLeafs(bt);   // 5
isMember(10, bt); // false
isMember(3, bt);  // true
```

The following two functions return a list of all the elements using [in order and pre order traversals](http://en.wikipedia.org/wiki/Tree_traversal#Traversal_methods) of the binary tree.

```
var inorder = fun(
  [Void, function() []],
  [Bt($, $, $), function(v, L, R) inorder(L).concat([v], inorder(R))]
);

var preorder = fun(
   [Void, function() []],
   [Bt($, $, $), function(v, L, R) [v].concat(preorder(L), preorder(R))]
);

inorder(bt);    // [1,2,3,4,5,6,7,8,9]
preorder(bt);   // [4,2,1,3,8,6,5,7,9]
```

A real implementation of a binary tree would of course not use the data types and functions defined in this article for performance reasons, but a binary tree serves as a good introduction to both pattern matching and algebraic data types. You can [download the source for this article](fun.js), it should run on any browser that supports JavaScript 1.5 and up (though the examples and the algebraic data type library require version 1.8.)
