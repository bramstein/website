
/*!
 * JavaScript Pattern Matching
 *
 * Licensed under the revised BSD License.
 * Copyright 2008, Bram Stein
 * All rights reserved.
 */
/*global match, unification */
match = function () {
    var unify = unification.unify,
        slice = Array.prototype.slice;

    function match_aux(patterns, value) {
        var i, result, length;

        for (i = 0; i < patterns.length; i += 1) {
            length = patterns[i].length;
   
            // we only try to match if the match array contains at
			// least two items and the last item is a function (closure)
            if (length >= 2 && typeof patterns[i][length - 1] === 'function') {
                result = unify(patterns[i].slice(0, length - 1), value);
                if (result) {
                    return patterns[i][length - 1](result);
                }
            }
        }
        return undefined;
    }

    return function() {
		var args = slice.apply(arguments);
        return function() {
            return match_aux(args, slice.apply(arguments));
        };
    };
}();
