
/*!
 * JavaScript Field Extraction
 *
 * Licensed under the revised BSD License.
 * Copyright 2008, Bram Stein
 * All rights reserved.
 */
/*global extract, unification */
extract = function () {
    var unify = unification.unify;
	var variable = unification.variable;
	var visit_pattern = unification.visit_pattern;
	var _ = unification._;

	var visitor = { 
		'object' : function(key, value) {
			if (value === _) {
				return variable(key);
			}
			else if (value && typeof value === 'function') {
				return variable(key, value);
			}
			else {
				return value;
			}
		}
	};

	return function (pattern, value) {
		return unify(visit_pattern(pattern, visitor), value);
	};
}();
