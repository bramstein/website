---
template: content.html
title: Pattern Matching in JavaScript
collection: [writing, news]
classes: writing
date: 2012-02-13
---

# Pattern matching in JavaScript

Pattern matching is a form of conditional branching which allows you to concisely match on data structure patterns and bind variables at the same time (Wikipedia, [Conditional Statements, Pattern Matching](http://en.wikipedia.org/wiki/Conditional_statement#Pattern_matching).) Pattern matching is supported in some functional languages such as ML, Haskell, OCaml, and Erlang. The factorial function can be implemented in ML like so (note that is not an efficient way to calculate factorials, but it serves as a good introduction to pattern matching):

```
fun fact 0 = 1
  | fact n = n * fact(n - 1);
```

Pattern matching might seem like an esoteric functional programming feature, but anyone who has written an <abbr>XSLT</abbr> stylesheet has used pattern matching before, through the `<xsl:template match="mynode">` element. If you look hard enough however, you'll notice <abbr>XSLT</abbr> is basically a thinly disguised functional (declarative) programming language. Not a pretty one though.

When you call `fact(10)` the value `10` is first matched against the first pattern `0`. This match fails and the next pattern is evaluated. The `n` in the next pattern is an example of a variable. Matching an integer against a variable succeeds, so the system binds `10` to the variable `n`. The statements following the pattern are then executed. Since this is a recursive function it will match the second pattern until the argument to the function reaches zero and then terminates. Haskell, OCaml, and Erlang have similar syntax for pattern matching. In this article we will introduce pattern matching to the JavaScript language using the [JUnify unification library](../projects/junify/).

## Implementation

At its core, pattern matching is simply a conditional branch with pattern matching as the expressions. Below is a simple implementation of the factorial function in JavaScript, using the JUnify library.

```
var $ = unification.variable;
var unify = unification.unify;

var fact = function (n) {
  var r;

  if (unify(0, n)) {
    return 1;
  }
  else if (r = unify($('n'), n)) {
    return r.n * fact(r.n - 1);
  }
};

fact(10); // 3628800
```

We can improve the syntax a bit by creating a module that does the matching for us and executes a closure when the match is made. The match module returns a function that takes two parameters: an array of patterns and closures, and a value to match against. The array of patterns and closures is itself an array containing the pattern to match on and a closure to execute once the pattern is matched. If no match is made the module returns undefined. If however a match is made, the closure is executed and passed the result of the unification (the variable bindings, if any).

```
match = function () {
  var unify = unification.unify;

  function match_aux(patterns, value) {
    var i, result;

    for (i = 0; i < patterns.length; i += 1) {
      result = unify(patterns[i][0], value);
      if (result) {
        return patterns[i][1](result);
      }
    }
    return undefined;
  }

  return function(patterns, value) {
    return match_aux(patterns, value);
  };
}();

var fact = function (n) {
  return match([
    [0, function() { return 1; }],
    [$('n'), function(result) {
      return result.n * fact(result.n - 1);
     }]
  ], n);
};
```

The above code listing shows the factorial function using the `match` module. Notice however that we limit the number of arguments we can match on to one. This also means that functions using the match module are limited to only one argument. If they need more than one argument they would have to construct an object or array and pass that to the `match` method. We can make this a bit more flexible by allowing an arbitrary number of arguments and reserve the last item in the match array for the closure. We only need to change the `match_aux` function to accomplish this. Instead of passing the first value of the match array to `unify` we pass an array of `length - 1` to it.

We also modify the factorial function to pass its arguments array as the second argument (`value`) to the match module. The arguments pseudo-array is turned into a real array by the `Array.prototype.slice` method before being passed to the `match` module.

```
match = function () {
  var unify = unification.unify;

  function match_aux(patterns, value) {
    var i, result, length;

    for (i = 0; i < patterns.length; i += 1) {
      length = patterns[i].length;

      // we only try to match if the match array contains at
      // least two items and the last item is a function
      if (length >= 2 &&
        typeof patterns[i][length - 1] === 'function') {
        result = unify(patterns[i].slice(0, length - 1),
                 value);
        if (result) {
          return patterns[i][length - 1](result);
        }
      }
    }
    return undefined;
  }
  …
}();

var fact = function () {
  return match([
    [0, function() { return 1; }],
    [$('n'), function(result) {
      return result.n * fact(result.n - 1);
     }]
  ], Array.prototype.slice.apply(arguments));
};
```

The new factorial function is however longer than the previous version. We can improve it by removing the function literal and manually passing the arguments of the function. We do this by wrapping the returned closure in another closure and passing the inner closure's arguments to the `match` function.

```
match = function () {
  …
  return function(patterns) {
    return function () {
      return match_aux(patterns,
          Array.prototype.slice.apply(arguments));
    };
  };
}();
```

The `match` module can now be called with only one argument. This returns a closure (the function we're building) whose arguments, together with the patterns, are then passed to the `match_aux` function. Again, the arguments pseudo-array is turned into a real array. This small change simplifies our factorial function tremendously.

```
var fact = match([
  [0, function() { return 1; }],
  [$('n'), function(result) {
    return result.n * fact(result.n - 1);
   }]
]);
```

Notice that the array brackets around the match arrays are now redundant, since the arguments to a function are already an array (albeit a pseudo-array, but that can be fixed.) So let's get rid of those too. We modify the return statement to pass the arguments array of the outer closure as the first value of the inner closure. We have to introduce an extra variable here because the arguments variable is local to a function. By saving it as a variable we can access the arguments of the outer closure from inside the inner closure.

```
match = function () {
  var slice = Array.prototype.slice;
  …
  return function () {
    var args = slice.apply(arguments);
    return function () {
      return match_aux(args, slice.apply(arguments));
    };
  };
}();


var fact = match(
  [0, function() { return 1; }],
  [$('n'), function(r) { return r.n * fact(r.n - 1); }]
);
```

## Conclusion

This concludes our implementation of basic pattern matching in JavaScript. In the [next article](advanced-pattern-matching.html) we'll discuss more advanced pattern matching techniques and simplify the syntax even further. You can download the final [match.js](match.js) code for your convenience.

We can also use JUnify's support for types in our pattern matcher to --- for example --- implement <abbr>DOM</abbr> traversal. The following function traverses the <abbr>DOM</abbr> and returns the number of characters in the element given to it as a parameter.

```
var count_characters = match(
  [$('node', Text), function(result) {
    return result.node.length;
  }],
  [$('node'), function(result) {
    var count = 0;
    var n = result.node.firstChild;

    while (n) {
      count += count_characters(n);
      n = n.nextSibling;
    }
    return count;
  }]
);

// display the number of characters in the document body
alert(count_characters(document.body));
```
It does this by first matching on the `Text` type and returning the number of characters. The other match pattern matches any other type of node in the <abbr>DOM</abbr> (e.g. `Element`) and iterates through its children and calls the `count_characters` function recursively.
