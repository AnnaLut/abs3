function addLoader2(elem) {
    var h = elem.height(); var w = elem.width();
    elem.append('<div class="divLoader" style="top:' + ((h / 2) - 20) + 'px;">\
                    <div class="overlay" style="top:-' + ((h / 2) - 20) + 'px;height:' + (h) + 'px;width:' + w + 'px"></div>\
                    <div class="loading">\
                        <div id="lbStatus">Завантаження...</div>\
                        <div id="lbImgLoading"></div>\
                    </div>\
                 </div>');
}

function addLoader(elem) {
    var h = elem.height(); var w = elem.width();
    elem.append('<div class="divLoader" style="height:'+h+'px;with:'+w+'px;">\
                    <div class="loading" style="margin-top:'+((h/2)-25)+'px;margin-left:'+((w/2)-25)+'px;"></div>\
                 </div>');
}
function removeLoader(elem) { elem.find('.divLoader').remove(); }

///функція для задання маски числу

function separateMoney(text) {
  /*var arr = new String(t).split('.');

  for (var p = arr[0].length; (p -= 3) >= 1;) {
      arr[0] = arr[0].substr(0, p) + ' ' + arr[0].substr(p);
  }
  var result;
  if (arr.length == 1) {
      result = arr[0] + '.00';
  }
  else if (arr[1].length < 2) {
      result = arr[0] + '.' + arr[1] + '0';
  }
  else {
      result = arr[0] + '.' + arr[1];
  }
  return result;*/
  var result;
  var arr = new String(text).replace(',', '.').split('.');
  if (arr[0].length < 1) {
    result = '0.';
  } else {
    if (arr[0].replace(/^(-)?0*/, '').length == 0) {
      result = arr[0].substring(0,1) =='-'? '-0.':'0.';
    } else {
      result = arr[0].substring(0,1) =='-'? '-' + arr[0].replace(/^(-)?0*/, '') + '.':arr[0].replace(/^(-)?0*/, '') + '.';
    }
    //result = arr[0].replace(/^0*/, '').length == 0 ? '0.' : arr[0].replace(/^0*/, '') + '.';
  }
  if (arr.length > 1) {
    result += (arr[1] + '00').substring(0, 2);
  } else {
    result += '00';
  }
  return result;
}

//вікно повідомлення
//text-текст повідомлення
//winName-текст який буде відображатися в шапкці вікна
//winType- тип повідомлення(error,warning)
function barsUiAlert(text, winName, winType) {
    $('#barsUiAlertDialog').remove();
    if (winName == undefined) winName = '';
    var alert = $('<div/>');
    alert.attr('id','barsUiAlertDialog').css('text-align','center');
    alert.dialog({
      bgiframe: true,
      dialogClass: '',
      buttons: [{ text: 'ok!', click: function () { alert.dialog('close'); } }],
      autoOpen: true,
      position: 'center',
      title: winName,
      modal: true,
      resizable: false,
      minWidth: '400',
      minHeight: '150',
      close: function () { alert.remove(); }
    });
    var img='';
    switch (winType) {
        case 'error':
            img='<img alt="" src="/Common/Images/default/24/error.png"/>';
            alert.parent().css({ 'border': '1px red solid' }).find('.ui-dialog-titlebar').css('color', 'red');
            break;
        case 'warning':
            img='<img alt="" src="/Common/Images/default/24/warning.png"/>';
            break;
        default: break;
    }
    alert.html('<table style="width:100%"><tr><td>' + img + '</td><td style="width:100%;text-align:center;">' + text + '</td></tr></table>');
}

//вікно повідомлення
//text-текст повідомлення
//winName-текст який буде відображатися в шапкці вікна
//winType- тип повідомлення(error,warning)
function barsUiConfirm(text, func) {
  var result = false;
  $('#barsUiConfirmDialog').remove();
  var confirm = $('<div/>');
  confirm.attr('id', 'barsUiConfirmDialog').css('text-align', 'center');
  confirm.dialog({
    bgiframe: true,
    dialogClass: '',
    buttons: [{ text: 'відмінити', click: function () {  confirm.dialog('close');} },
              { text: 'ok!', click: function () {if (func) { func.call(); } confirm.dialog('close'); result = true;} }],
    autoOpen: true,
    position: 'center',
    title: '',
    modal: true,
    resizable: false,
    minWidth: '400',
    minHeight: '150',
    close: function () { confirm.remove(); return result;}
  }).parent().find('.ui-dialog-buttonpane .ui-dialog-buttonset .ui-button span.ui-button-text:contains("відмінити")').parent().addClass('ui-button-link');
  confirm.html('<table style="width:100%"><tr><td></td><td style="width:100%;text-align:center;">' + text + '</td></tr></table>');
}

function addPopup(elem, text, textColor) {
    $('div.helppop[data-for="'+elem.attr('id')+'"]').remove();
    var popup = $('<div>/');
    popup.html(text);
    var marginLeft = parseInt($(elem).css('padding-left').replace('px', '')) + parseInt($(elem).css('padding-right').replace('px', '')) + parseInt(elem.width())+5;
    popup.css({'margin-left':marginLeft+'px'});
    popup.addClass('helppop');
    popup.attr('data-for', elem.attr('id'));
    if (textColor) {
        popup.css('color', textColor);
    }
    popup.insertBefore(elem);
}

//плагін зв"язує інпут і селект по батьківському елементу
(function ($) {
    function changeSelect(elem) {
        var selectedVal = $(elem).find('option:selected').val();
        $(elem).parent().find('input[type="text"]').val(selectedVal).removeClass('error').removeClass('error2').attr('title', '');
    }
    function changeInput(elem) {
        var selectedVal = $(elem).val();
        var selected = $(elem).parent().find('select option[value="' + selectedVal + '"]');
        if (selected.length != 0) {
            selected.attr('selected', 'selected');
            $(elem).parent().find('select').removeClass('error');
            $(elem).removeClass('error').removeClass('error2').attr('title', '');
        } else {
            $(elem).addClass('error2').attr('title', 'Недопустиме значення');
        }
    }

    function loadFromUrl(elem,url, tableName, func) {
      $.post(url,
        { id: elem.val(), tablename: tableName },
        function(data) {
          elem.parent().find('select').html('');
          if (data != 'err') {
            elem.parent().find('select').html(data).removeClass('error');
            elem.parent().find('select').find('option:first').attr('selected', 'selected');
            $(elem).removeClass('error').removeClass('error2').attr('title', '');
          } else {
            $(elem).addClass('error2').attr('title', 'Недопустиме значення');
          }
          if (func) {
            func.call();
          }
        });
    }

    var methods = {
        init: function (options) {
            options = $.extend({
                changeFunc: null
            }, options);
            var elem = this;

            var make = function () {
                elem.find('input[type="text"]').change(function () {
                    changeInput(this);
                    if (options.changeFunc) {
                        options.changeFunc.call();
                    }
                });
                elem.find('select').change(function () {
                    changeSelect(this);
                    if (options.changeFunc) {
                        options.changeFunc.call();
                    }
                });

                elem.find('input[type="text"]').bind('keypress', function (e) {
                    // нажал клавишу enter 
                    if (e.keyCode == 13) {
                        changeInput(this);
                        if (options.changeFunc) {
                            options.changeFunc.call();
                        }
                    }
                });
            };
            return elem.each(make);
        },
        fromUrl: function (options) {
            options = $.extend({
                url: '',
                tableName:'',
                changeFunc: null
            }, options);
            var elem = this;
          var make = function() {
            if (options.url != '') {
              elem.find('input[type="text"]').change(function() {
                loadFromUrl(elem.find('input[type="text"]'), options.url, options.tableName, options.changeFunc);
              });

              elem.find('input[type="text"]').bind('keypress', function(e) {
                // нажал клавишу enter 
                if (e.keyCode == 13) {
                  loadFromUrl(elem.find('input[type="text"]'), options.url, options.tableName, options.changeFunc);
                }
              });
            }
          };
          return elem.each(make);
        },

        hide: function () {
            // ПРАВИЛЬНЫЙ
        },
        update: function () {
            // !!!
        }
    };

  $.fn.packetInputSelect = function(method) {
    if (methods[method]) {
      return methods[method].apply(this, Array.prototype.slice.call(arguments, 1));
    } else if (typeof method === 'object' || !method) {
      return methods.init.apply(this, arguments);
    } else {
      $.error('Метод с именем ' + method + ' не существует');
    }
    return methods[method].apply(this, Array.prototype.slice.call(arguments, 1));
  };

})(jQuery);

//loader
(function ($) {
  var methods = {
    init: function(options) {
      options = $.extend({
        position: 'center'
      }, options);
      var elem = this;

      var make = function() {
        var h = elem.height(),
          w = elem.width(),
          t = elem.position().top,
          l = elem.position().left;
        //winWidth = $(window).width();
        elem.find('div.divLoader').remove();
        elem.append('<div class="divLoader" style="height:' + h + 'px;width:' + w + 'px;top:' + t + 'px;">\
                    <div class="loading" style="margin-top:' + ((h / 2) - 25) + 'px;margin-left:' + (((/*winWidth*/w - l) / 2) - 25) + 'px;"></div>\
                 </div>');

      };
      return elem.each(make);
    },
    remove: function(options) {
      options = $.extend({
        position: 'center'
      }, options);
      var elem = this;
      var make = function() {
        elem.find('div.divLoader').remove();
      };
      return elem.each(make);
    }
  };
  $.fn.loader = function(method) {
    if (methods[method]) {
      return methods[method].apply(this, Array.prototype.slice.call(arguments, 1));
    } else if (typeof method === 'object' || !method) {
      return methods.init.apply(this, arguments);
    } else {
      return $.error('Метод с именем ' + method + ' не существует');
    }
  };
})(jQuery);

(function ($) {
  var methods = {
    init: function(options) {
      options = $.extend({
        position: 'center'
      }, options);
      var elem = this;

      $(document).on('click', function(e) {
        if (e.target.id != $('.dropdown').attr('class') &&
          $(e.target).parent().attr('class') != 'ddm insert-dropdown' &&
          $(e.target).attr('class') != 'ddm insert-dropdown') {
          $('.dropdown-slider').slideUp();
          $('span.toggle').removeClass('active');
        }
      });

      var make = function() {
        elem.children('.button,button').click(function() {
          // hide any open menus (Yuneekguy)
          var $this = $(this);
          $('.dropdown-slider').not($this.next('.dropdown-slider')).slideUp();
          $('span.toggle').removeClass('active');
          // open selected dropown
          elem.children('.dropdown-slider').slideToggle('fast');
          $this.find('span.toggle').toggleClass('active');
          return false;
        });
        elem.find('.insert-dropdown').click(function() {
          var $this = $(this);
          $this.parent().find('.insert-dropdown-slider').slideToggle();
          return false;
        });
      };
      return elem.each(make);
    },
    remove: function(options) {
      options = $.extend({
        position: 'center'
      }, options);
      var elem = this;
      var make = function() {
        elem.find('div.divLoader').remove();
      };
      return elem.each(make);
    }
  };
  $.fn.dropdown = function(method) {
    if (methods[method]) {
      return methods[method].apply(this, Array.prototype.slice.call(arguments, 1));
    } else if (typeof method === 'object' || !method) {
      return methods.init.apply(this, arguments);
    } else {
      return $.error('Метод с именем ' + method + ' не существует');
    }
  };
})(jQuery);

/**
 *  jQuery quick Each
 *
 *  Example:
 *  a.quickEach(function() {
 *      this; // jQuery object
 *  });
 */
jQuery.fn.quickEach = (function () {
    var jq = jQuery([1]);
    return function (c) {
        var i = -1, el, len = this.length;
        try {
            while (++i < len && (el = jq[0] = this[i]) && c.call(jq, i, el) !== false);
        } catch (e) {
            delete jq[0];
            throw e;
        }
        delete jq[0];
        return this;
    };
}());