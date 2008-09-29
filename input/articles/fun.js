
/*!
 * JavaScript Pattern Matching
 *
 * Licensed under the revised BSD License.
 * Copyright 2008, Bram Stein
 * All rights reserved.
 */
/*global fun, unification, match_parameter */
match_parameter = 0xABADBABE;

fun = function () {
    var unify         = unification.unify,
	    visit_pattern = unification.visit_pattern,
	    variable      = unification.variable,
    	slice         = Array.prototype.slice;

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
        var i, result, length, key,
		    result_arguments = [];

        for (i = 0; i < patterns.length; i += 1) {
            length = patterns[i].length;

			result = unify(patterns[i].slice(0, length - 1), value);
            if (result) {
                // iterate through the results and insert them in the correct
				// location in our result array
				for (key in result) {
					if (result.hasOwnProperty(key)) {
						result_arguments[key] = result[key];
					}
				}
				// call the closure using the result array 
                return patterns[i][length - 1].apply(null, result_arguments);
            }
        }
        throw {
			name: 'MatchError',
			message: 'Match is not exhaustive: (' + value + ')' + ' (' + patterns + ')'
		};
    }

    return function() {
		var patterns = slice.apply(arguments),
			i, l, c;

		for (i = 0; i < patterns.length; i += 1) {
			l = patterns[i].length;

			if (l >= 2 && typeof patterns[i][l - 1] === 'function') {
				c = patterns[i][l - 1];
				patterns[i] = [].concat(rewrite(patterns[i].slice(0, l - 1), 0));
				patterns[i].push(c);
			}
		}
        return function() {
            return fun_aux(patterns, slice.apply(arguments));
        };
    };
}();
