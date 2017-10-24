/// <reference path="../../../lib/jquery-1.2.6.js" />
/*
	Masked Input plugin for jQuery
	Copyright (c) 2007-2009 Josh Bush (digitalbush.com)
	Licensed under the MIT license (http://digitalbush.com/projects/masked-input-plugin/#license) 
	Version: 1.2.2 (03/09/2009 22:39:06)
*/
(function($) {
    var pasteEventName = ($.browser.msie ? 'paste' : 'input') + ".mask";
    //var pasteEventName = 'paste.mask';
	var iPhone = (window.orientation != undefined);

	$.mask = {
    		definitions: {'9': "[0-9]", 'a': "[A-Za-z]", '*': "[A-Za-z0-9]"}
	};

	$.fn.extend({
		//Helper Function for Caret positioning
		caret: function(begin, end) {
			if (this.length == 0) return;
			if (typeof begin == 'number') {
				end = (typeof end == 'number') ? end : begin;
				return this.each(function() {
					if (this.setSelectionRange) {
						this.focus();
						this.setSelectionRange(begin, end);
					} else if (this.createTextRange) {
						var range = this.createTextRange();
						range.collapse(true);
						range.moveEnd('character', end);
						range.moveStart('character', begin);
						range.select();
					}
				});
			} else {
				if (this[0].setSelectionRange) {
					begin = this[0].selectionStart;
					end = this[0].selectionEnd;
				} else if (document.selection && document.selection.createRange) {
					var range = document.selection.createRange();
					begin = 0 - range.duplicate().moveStart('character', -100000);
					end = begin + range.text.length;
				}
				return { begin: begin, end: end };
			}
		},
		unmask: function() { return this.trigger("unmask"); },
		mask: function(mask, settings) {
			if (!mask && this.length > 0) {
				var input = $(this[0]);
				var tests = input.data("tests");
				return $.map(input.data("buffer"), function(c, i) {
					return tests[i] ? c : null;
				}).join('');
			}
			settings = $.extend({
				placeholder: "_",
				completed: null,
				validate: null,
                checked: null
			}, settings);

			var defs = $.mask.definitions;
			var tests = [];
			var partialPosition = mask.length;
			var firstNonMaskPos = null;
			var len = mask.length;

			$.each(mask.split(""), function(i, c) {
				if (c == '?') {
					len--;
					partialPosition = i;
				} else if (defs[c]) {
					tests.push(new RegExp(defs[c]));
					if(firstNonMaskPos==null)
						firstNonMaskPos =  tests.length - 1;
				} else {
					tests.push(null);
				}
			});

			return this.each(function() {
				var input = $(this);
				var buffer = $.map(mask.split(""), function(c, i) { if (c != '?') return defs[c] ? settings.placeholder : c });
				var ignore = false;  			//Variable for ignoring control keys
				var focusText = input.val();

				input.data("buffer", buffer).data("tests", tests);

				function seekNext(pos) {
					while (++pos <= len && !tests[pos]);
					return pos;
				};

				function shiftL(pos) {
					while (!tests[pos] && --pos >= 0);
					for (var i = pos; i < len; i++) {
						if (tests[i]) {
							buffer[i] = settings.placeholder;
							var j = seekNext(i);
							if (j < len && tests[i].test(buffer[j])) {
								buffer[i] = buffer[j];
							} else
								break;
						}
					}
					writeBuffer();
					input.caret(Math.max(firstNonMaskPos, pos));
				};

				function shiftR(pos) {
					for (var i = pos, c = settings.placeholder; i < len; i++) {
						if (tests[i]) {
							var j = seekNext(i);
							var t = buffer[i];
							buffer[i] = c;
							if (j < len && tests[j].test(t))
								c = t;
							else
								break;
						}
					}
				};

				function keydownEvent(e) {
					var pos = $(this).caret();
					var k = e.keyCode;
					ignore = (k < 16 || (k > 16 && k < 32) || (k > 32 && k < 41));

					//delete selection before proceeding
					if ((pos.begin - pos.end) != 0 && (!ignore || k == 8 || k == 46))
						clearBuffer(pos.begin, pos.end);

					//backspace, delete, and escape get special treatment
					if (k == 8 || k == 46 || (iPhone && k == 127)) {//backspace/delete
						shiftL(pos.begin + (k == 46 ? 0 : -1));
						return false;
					} else if (k == 27) {//escape
						input.val(focusText);
						input.caret(0, checkVal());
						return false;
					}
				};

				function keypressEvent(e) {
					if (ignore) {
						ignore = false;
						//Fixes Mac FF bug on backspace
						return (e.keyCode == 8) ? false : null;
					}
					e = e || window.event;
					var k = e.charCode || e.keyCode || e.which;
					var pos = $(this).caret();

					if (e.ctrlKey || e.altKey || e.metaKey) {//Ignore
						return true;
					} else if ((k >= 32 && k <= 125) || k > 186) {//typeable characters
						var p = seekNext(pos.begin - 1);
						if (p < len) {
							var c = String.fromCharCode(k);
							if (tests[p].test(c)) {
								shiftR(p);
								buffer[p] = c;
								writeBuffer();
								var next = seekNext(p);
								$(this).caret(next);
								if (settings.completed && next == len)
									settings.completed.call(input);
							}
						}
					}
					return false;
				};

				function clearBuffer(start, end) {
					for (var i = start; i < end && i < len; i++) {
						if (tests[i])
							buffer[i] = settings.placeholder;
					}
				};

				function writeBuffer() { return input.val(buffer.join('')).val(); };

				function checkVal(allow) {
					//try to place characters where they belong
					var test = input.val();
					var lastMatch = -1;
					for (var i = 0, pos = 0; i < len; i++) {
						if (tests[i]) {
							buffer[i] = settings.placeholder;
							while (pos++ < test.length) {
								var c = test.charAt(pos - 1);
								if (tests[i].test(c)) {
									buffer[i] = c;
									lastMatch = i;
									break;
								}
							}
							if (pos > test.length)
								break;
						} else if (buffer[i] == test[pos] && i!=partialPosition) {
							pos++;
							lastMatch = i;
						} 
					}
					if (!allow && lastMatch + 1 < partialPosition) {
						//input.val("");
						clearBuffer(0, len);
					} else if (allow || lastMatch + 1 >= partialPosition) {
						writeBuffer();
						if (!allow) input.val(input.val().substring(0, lastMatch + 1));

					}
					if (settings.checked) settings.checked.call(input);
					return (partialPosition ? i : firstNonMaskPos);
				};

				if (!input.attr("readonly"))
					input.one("unmask", function() {
						input.unbind(".mask").removeData("buffer").removeData("tests");
					})
					.bind("focus.mask", function() {
						focusText = input.val();
						var pos = checkVal();
						writeBuffer();
						setTimeout(function() {
							if (pos == mask.length)
								input.caret(0, pos);
							else
								input.caret(pos);
						}, 0);
					})
					.bind("blur.mask", function() {
						checkVal();
						if (input.val() != focusText)
						    input.change();
					})
					.bind("keydown.mask", keydownEvent)
					.bind("keypress.mask", keypressEvent)
					.bind(pasteEventName, function() {
						setTimeout(function() { input.caret(checkVal(true)); }, 0);
					});

				checkVal(); //Perform initial check for existing values
			});
		}
	});
})(jQuery);

(function ($) {
    $.fn.numberMask = function (options) {
        var settings = { type: 'int', beforePoint: 10, afterPoint: 2, defaultValueInput: 0, decimalMark: '.', pattern: '' },
			onKeyPress = function (e) {
			    var k = e.which;

			    if (e.ctrlKey || e.altKey || e.metaKey || k < 32) {//Ignore
			        return true;
			    } else if (k) {
			        var c = String.fromCharCode(k);
			        var value = e.target.value;
			        var selectionParam = getSelection(e.target);
			        if (selectionParam.statusSelection) {
			            value = value.substring(0, selectionParam.start) + c + value.substring(selectionParam.end);
			        } else {
			            value += c;
			        }

			        if ((typeof settings.pattern == "object") && (settings.pattern instanceof RegExp)) {
			            var re = settings.pattern;
			        } else {
			            if (settings.type == 'int') {
			                var re = new RegExp("^\\d{1," + settings.beforePoint + "}$", "ig");
			            } else if (settings.type == 'float') {
			                var re = new RegExp("^\\d{1," + settings.beforePoint + "}$|^\\d{1," + settings.beforePoint + "}\\" + settings.decimalMark + "\\d{0," + settings.afterPoint + "}$", "ig");
			            }
			        }
			        return re.test(value);
			    }
			},
			onKeyUp = function (e) {
			    var input = $(e.target);
			    if (e.which == 13 || e.which == 86) {
			        input.val(formattedNumber(input));
			    }
			},
			getSelection = function (el) {
			    var start = 0, end = 0, normalizedValue, range,
                   textInputRange, len, endRange, statusSelection = false;

			    if (typeof el.selectionStart == "number" && typeof el.selectionEnd == "number") {
			        start = el.selectionStart;
			        end = el.selectionEnd;
			    } else {
			        range = document.selection.createRange();

			        if (range && range.parentElement() == el) {
			            len = el.value.length;
			            normalizedValue = el.value.replace(/\r\n/g, "\n");

			            // Create a working TextRange that lives only in the input
			            textInputRange = el.createTextRange();
			            textInputRange.moveToBookmark(range.getBookmark());

			            // Check if the start and end of the selection are at the very end
			            // of the input, since moveStart/moveEnd doesn't return what we want
			            // in those cases
			            endRange = el.createTextRange();
			            endRange.collapse(false);

			            if (textInputRange.compareEndPoints("StartToEnd", endRange) > -1) {
			                start = end = len;
			            } else {
			                start = -textInputRange.moveStart("character", -len);
			                start += normalizedValue.slice(0, start).split("\n").length - 1;

			                if (textInputRange.compareEndPoints("EndToEnd", endRange) > -1) {
			                    end = len;
			                } else {
			                    end = -textInputRange.moveEnd("character", -len);
			                    end += normalizedValue.slice(0, end).split("\n").length - 1;
			                }
			            }
			        }
			    }
			    if ((start - end) != 0) {
			        statusSelection = true;
			    }
			    return {
			        start: start,
			        end: end,
			        statusSelection: statusSelection
			    };
			},
			onBlur = function (e) {
			    var input = $(e.target);
			    if (input.val() != '') {
			        input.val(formattedNumber(input));
			    }
			},
			formattedNumber = function ($input) {
			    var val = $input.val();
			    if ((typeof settings.pattern == "object") && (settings.pattern instanceof RegExp)) {
			        var re = settings.pattern;
			        if (re.test(val)) {
			            return val;
			        } else {
			            return settings.defaultValueInput;
			        }
			    } else {
			        if (settings.type == 'int') {
			            var re = new RegExp("^\\d{1," + settings.beforePoint + "}$", "ig");
			            if (re.test(val)) {
			                return val;
			            } else {
			                return settings.defaultValueInput;
			            }
			        } else {
			            var re = new RegExp("^\\d{1," + settings.beforePoint + "}$|^\\d{1," + settings.beforePoint + "}\\" + settings.decimalMark + "\\d{1," + settings.afterPoint + "}$", "ig");
			            if (re.test(val)) {
			                return val;
			            } else {
			                return settings.defaultValueInput;
			            }
			        }
			    }
			}
        this.bind('keypress', onKeyPress).bind('keyup', onKeyUp).bind('blur', onBlur);
        if (options) {
            $.extend(settings, options);
        }
        return this;
    }
})(jQuery)