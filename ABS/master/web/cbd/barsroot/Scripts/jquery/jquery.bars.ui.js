if (!('bars' in window)) window['bars'] = {};

bars.config = bars.config || {};
bars.config.cookie_expiry = 604800; //1 week duration for saved settings
bars.config.storage_method = 1;//2 means use cookies, 1 means localStorage, 0 means localStorage if available otherwise cookies
bars.config.appName = '/barsroot'; //имя апликейшина в котором запущено приложение

//тестуємо браузер
bars.test = new Object();
bars.test.hasIE = window.eval && eval("/*@cc_on 1;@*/") && (/msie (\d+)/i.exec(navigator.userAgent) || [, true])[1];
bars.test.hasOpera = !!window.opera && window.opera.version && window.opera.version();
bars.test.hasChrome = !!window.chrome && (/chrome\/([\d\.]+)/i.exec(navigator.userAgent)[1] || true);
bars.test.hasFireFox = !!window.sidebar && (/firefox\/([\d\.]+)/i.exec(navigator.userAgent)[1] || true);
bars.test.hasSafari = !window.external && !hasOpera && (/safari\/([\d\.]+)/i.exec(navigator.userAgent)[1] || true);

bars.data_storage = function (method, undefined) {
  var prefix = 'bars.';

  var storage = null;
  var sessionStorage = null;
  var type = 0;

  if ((method == 1 || method === undefined) && 'localStorage' in window && window['localStorage'] !== null) {
    storage = bars.storage;
    sessionStorage = bars.sessionStorage;    
    type = 1;
  } else if (storage == null && (method == 2 || method === undefined) && 'cookie' in document && document['cookie'] !== null) {
    storage = bars.cookie;
    sessionStorage = bars.cookie;
    type = 2;
  }

  //var data = {}
  this.set = function (namespace, key, value, option) {
    /// <summary>Записати в сторедж</summary>
    /// <param name="namespace" type="String">неймспейс</param>
    /// <param name="key" type="String">ключ</param>  
    /// <param name="value" type="String">значення</param>
    /// <param name="option" type="String">опція метод зберігання - постійно чи в сесії.
    /// по замовчуванню постійно (local/session)</param>    
    /// <returns type="String"></returns>
    if (!storage) return;
    var storageCurent = option == 'session' ? sessionStorage : storage;
    if (value === undefined) { //no namespace here?
      value = key;
      key = namespace;

      if (value == null) storageCurent.remove(prefix + key);
      else {
        if (type == 1)
          storageCurent.set(prefix + key, value);
        else if (type == 2)
          storageCurent.set(prefix + key, value, bars.config.cookie_expiry);
      }
    } else {
      if (type == 1) { //localStorage
        if (value == null) storageCurent.remove(prefix + namespace + '.' + key);
        else storageCurent.set(prefix + namespace + '.' + key, value);
      } else if (type == 2) { //cookie
        var val = storageCurent.get(prefix + namespace);
        var tmp = val ? JSON.parse(val) : {};

        if (value == null) {
          delete tmp[key]; //remove
          if (bars.sizeof(tmp) == 0) { //no other elements in this cookie, so delete it
            storageCurent.remove(prefix + namespace);
            return;
          }
        } else {
          tmp[key] = value;
        }
        var cookieExp = bars.config.cookie_expiry;
        if (option == 'session') {
          cookieExp = '';
        }
        storageCurent.set(prefix + namespace, JSON.stringify(tmp), cookieExp);
      }
    }
  };

  this.get = function (namespace, key, option) {
    if (!storage) return null;
    var storageCurent = option == 'session' ? sessionStorage : storage;
    if (key === undefined) { //no namespace here?
      key = namespace;
      return storageCurent.get(prefix + key);
    } else {
      if (type == 1) { //localStorage
        return storageCurent.get(prefix + namespace + '.' + key);
      } else if (type == 2) { //cookie
        var val = storageCurent.get(prefix + namespace);
        var tmp = val ? JSON.parse(val) : {};
        return key in tmp ? tmp[key] : null;
      }
    }
  };


  this.remove = function (namespace, key, option) {
    if (!storage) return;
    if (key === undefined) {
      key = namespace;
      this.set(key, null,undefine,option);
    } else {
      this.set(namespace, key, null,option);
    }
  };
};

//local storage
bars.storage = {
  get: function (key) {
    return window['localStorage'].getItem(key);
  },
  set: function (key, value) {
    window['localStorage'].setItem(key, value);
  },
  remove: function (key) {
    window['localStorage'].removeItem(key);
  }
};
//session storage
bars.sessionStorage = {
  get: function (key) {
    return window['sessionStorage'].getItem(key);
  },
  set: function (key, value) {
    window['sessionStorage'].setItem(key, value);
  },
  remove: function (key) {
    window['sessionStorage'].removeItem(key);
  }
};
//cookie storage
bars.cookie = {
  // The following functions are from Cookie.js class in TinyMCE, Moxiecode, used under LGPL.
  /** Get a cookie.*/
  get: function (name) {
    var cookie = document.cookie, e, p = name + "=", b;
    if (!cookie)
      return;
    b = cookie.indexOf("; " + p);
    if (b == -1) {
      b = cookie.indexOf(p);
      if (b != 0)
        return null;
    } else {
      b += 2;
    }
    e = cookie.indexOf(";", b);
    if (e == -1)
      e = cookie.length;
    return decodeURIComponent(cookie.substring(b + p.length, e));
  },

  /*** Set a cookie.*
   * The 'expires' arg can be either a JS Date() object set to the expiration date (back-compat)
   * or the number of seconds until expiration */
  set: function (name, value, expires, path, domain, secure) {
    var d = new Date();
    if (typeof (expires) == 'object' && expires.toGMTString) {
      expires = expires.toGMTString();
    } else if (parseInt(expires, 10)) {
      d.setTime(d.getTime() + (parseInt(expires, 10) * 1000)); // time must be in miliseconds
      expires = d.toGMTString();
    } else {
      expires = '';
    }
    document.cookie = name + "=" + encodeURIComponent(value) +
        ((expires) ? "; expires=" + expires : "") +
        ((path) ? "; path=" + path : "") +
        ((domain) ? "; domain=" + domain : "") +
        ((secure) ? "; secure" : "");
  },

  /*** Remove a cookie.
   * This is done by setting it to an empty value and setting the expiration time in the past. */
  remove: function (name, path) {
    this.set(name, '', -1000, path);
  }
};
bars.sizeof = function (obj) {
  var size = 0;
  for (var key in obj) if (obj.hasOwnProperty(key)) size++;
  return size;
};

bars.data = new bars.data_storage(bars.config.storage_method);


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
function barsUiError(options) {
  //для сумісності з старою версією
  if (typeof (options) !== 'object') {
    options = { text: options };
    if (arguments[1]) { options.title = arguments[1]; }
    if (arguments[2]) { options.winType = arguments[2]; }
    if (arguments[3]) { options.func = arguments[3]; }
  }
  options = $.extend({ text: "", func: null, title: "Помилка", winType: "error", width: '450', height: '150' }, options);
  barsUiAlert(options);
}

//вікно повідомлення
//text-текст повідомлення
//winName-текст який буде відображатися в шапкці вікна
//winType- тип повідомлення(error,warning)
//func - функція яка виконається по закриттю вікна
function barsUiAlert(options) {
  //для сумісності з старою версією
  if (typeof(options) !== 'object') {
    options = { text: options };
    if (arguments[1]) {options.title = arguments[1];}
    if (arguments[2]) {options.winType = arguments[2];}
    if(arguments[3]) {options.func = arguments[3];}
  }

  options = $.extend({ text: "", func: null, title: "", winType: "", width: '400', height: '150' }, options);
    $('#barsUiAlertDialog').remove();
    var alert = $('<div/>', { 'id': 'barsUiAlertDialog' });
    //alert/*.attr('id','barsUiAlertDialog')*/.css('text-align','center');
    alert.dialog({
      bgiframe: true,
      dialogClass: '',
      buttons: [{ text: 'ok', click: function () { alert.dialog('close'); } }],
      autoOpen: true,
      position: { at: 'center' },
      title: options.title,
      title_html: true,
      modal: true,
      resizable: true,
      minWidth: options.width,
      minHeight: options.height,
      close: function () {
        alert.remove();
        if (options.func) {
          options.func.call();
        }
      }
    });
    var img = '<img alt="" src="/barsroot/content/themes/modernui/css/images/24/info.png" style="float:left;margin:0 5px 0 0;"/>';
    switch (options.winType) {
        case 'error':
          img = '<img alt="" src="/barsroot/content/themes/modernui/css/images/24/error.png" style="float:left;margin:0 5px 0 0;"/>';
          //alert.parent().css({ 'border': '1px red solid' }).find('.ui-dialog-titlebar').css('color', 'red');
            break;
        case 'warning':
          img = '<img alt="" src="/barsroot/content/themes/modernui/css/images/24/warning-yellow.png" style="float:left;margin:0 5px 0 0;"/>';
            break;
        default: break;
    }
    alert.html('<table><tr><td valign=top >' + img + '</td><td>' + options.text + '</td></tr></table>');
//    alert.html('<table style="width:100%"><tr><td>' + img + '</td><td style="width:100%;text-align:center;">' + text + '</td></tr></table>');
}

//вікно повідомлення
//text-текст повідомлення
//winName-текст який буде відображатися в шапкці вікна
//winType- тип повідомлення(error,warning)

function barsUiConfirm(options) {
  //для сумісності з старою версією
  if (typeof (options) !== 'object') {
    options = { text: options };
    if (arguments[1]) { options.func = arguments[1]; }    
    if (arguments[2]) { options.title = arguments[2]; }
    if (arguments[3]) { options.winType = arguments[3]; } 
  }
  options = $.extend({ text: '', func: null, title: null}, options);
  var result = false;
  var img = '<img alt="" src="/barsroot/content/themes/modernui/css/images/24/question.png" style="float:left;margin:0 5px 0 0;"/>';
  $('#barsUiConfirmDialog').remove();
  var confirm = $('<div/>', { 'id': 'barsUiConfirmDialog' });
  //confirm.attr('id', 'barsUiConfirmDialog').css('text-align', 'center');
  confirm.dialog({
    bgiframe: true,
    dialogClass: '',
    buttons: [{ text: 'відмінити', 'class': 'ui-button-link', click: function () { confirm.dialog('close'); } },
      {
        text: 'ok',
        click: function () {
          if (options.func) {
            options.func.call();
          }
          confirm.dialog('close');
          result = true;
        }
      }],
    autoOpen: true,
    position: { at: 'center' },
    title: options.title,
    modal: true,
    resizable: true,
    minWidth: '400',
    minHeight: '150',
    close: function() {
      confirm.remove();
      return result;
    }
  });
  confirm.html('<table><tr><td valign=top >' + img + '</td><td>' + options.text + '</td></tr></table>');
}

//вікно повідомлення
//text-текст повідомлення
//winName-текст який буде відображатися в шапкці вікна
//winType- тип повідомлення(error,warning)
function barsUiMess(text, winName, winType, func) {
  var messBox = $('<div />', { 'class': 'bars-ui-mess' });
  var head = $('<div/>').css({ 'font-size': '1.5em' });
  head.html(winName); 
  var textBox = $('<div/>',{'class':'bars-ui-mess-text'});
  textBox.html(text);

  messBox.append(head);
  messBox.append(textBox);
  $('.bars-ui-mess').remove();
  $('body').append(messBox);
  messBox.animate({ right: '0' }, 300);
  messBox.bind('click', function () {
    messBox.remove();
    $('body').loader('remove');
    if (func) {
      func.call();
    }
  });
  if (winType==1) {
    $('body').loader({type:'block'});
  }
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
  var _timer = null;
  var methods = {
    init: function(options) {
      options = $.extend({
        position: 'center',
        type: null,
        delay:200
      }, options);
      var elem = this;
      var make = function () {
          elem.data('isloader', true);
          _timer = setTimeout(function () {
              if (elem.data('isloader')) {
                  var h = elem.outerHeight(),
                    w = elem.width(),
                    t = elem.position().top,
                    l = elem.position().left,
                    top = elem.css('padding-top').replace('px', ''),
                    position = elem.css('position').toLowerCase(),
                    tagName = elem.get(0).tagName.toUpperCase();
                  if (position != 'absolute' && position != 'relative') {
                      top = parseInt(top) + parseInt(t);
                  }
                  if (tagName == 'TABLE') {
                      elem = elem.parent();
                  }
                  if (tagName == 'THEAD' || tagName == 'TBODY' || tagName == 'TFOOT' || tagName == 'TR') {
                      elem = elem.parentsUntil('table').parent();
                  }
                  elem.find('div.divLoader').remove();
                  var width = w + 'px';
                  var height = h + 'px';
                  if (tagName == 'BODY') {
                      width = '100%';
                      height = '100%';
                  }
                  var loader = '<div class="divLoader" style="height:' + height + ';width:' + width + ';top:' + top + 'px;">';
                  if (options.type != 'block') {
                      loader += '<div class="loading" style="margin-top:' + ((h / 2) - 25) + 'px;margin-left:' + (((/*winWidth*/w) / 2) - 25) + 'px;"></div>';
                  }
                  loader += '</div>';
                  elem.append(loader);
              };
          }, options.delay)
      }
      return elem.each(make);      
    },
    remove: function(options) {
      options = $.extend({
        position: 'center'
      }, options);
      var elem = this;
      var make = function () {
        if (_timer) {
            clearTimeout(_timer);
        }
        elem.data('isloader', null);
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
//повернення відмічених чекбоксів в вигляді об"єкта
(function ($) {
  var methods = {
    init: function () {
      var elem = this;
      var checkDoc = elem;//.find(':checkbox:checked');
      var result = new Object();
      result.length = 0;
      result.arr = new Object();
      checkDoc.quickEach(function () {
        result.arr[result.length++] = this.val();
      });
      return result;
    }
  };
  $.fn.checkedToObj = function (method) {
    if (methods[method]) {
      return methods[method].apply(this, Array.prototype.slice.call(arguments, 1));
    } else if (typeof method === 'object' || !method) {
      return methods.init.apply(this, arguments);
    } else {
      return $.error('Метод с именем ' + method + ' не существует');
    }
  };
})(jQuery);


//popupBox окно
(function ($) {
  var methods = {
    init: function(options) {
      options = $.extend({
        selector:this.selector,
        position: 'top',
        rightMargin:0,
        open: '.open',
        box: '.box',
        arrow: '.arrow',
        arrow_border: '.arrow-border',
        close: '.close',
        onClose: null,
        onOpen: null
      }, options);
      var elem = this;

      var make = function() {
        methods.close();
        //box.find(settings['arrow']).css({ 'left': box.width() / 2 - 10 });
        //box.find(settings['arrow_border']).css({ 'left': box.width() / 2 - 10 });

        var boxWidth = elem.width();
        var divPopup = $('<div class="popupBox" />');


        var arrow = $('<div class="arrow"/>').css({ 'left': boxWidth - (Math.floor($(options.selector).width() / 2)) - options.rightMargin + 10 + 1 });
        var arrowBorder = $('<div class="arrow-border"/>').css({ 'left': boxWidth - (Math.floor($(options.selector).width() / 2)) - options.rightMargin + 10 });
        var box = $('<div class="box" />');
        box.append(elem/*.clone()*/.show());
        divPopup.css({
          top: $(options.selector).offset().top + $(options.selector).height() + 8 + 'px',
          right: '10px',
          width: boxWidth + 10 + 'px'
        }).append(arrow)
          .append(arrowBorder)
          .append(box);
        /*.on('click',function () { /*return false;* /});*/
        $('body').append(divPopup);
        var $document = $(document);
        $document.bind('click.popupBox', function (event) {
          if ($(event.target).closest(options.selector).length == 0 && $(event.target).closest('.popupBox').length == 0) {
            methods.close({ popupBox: divPopup, onClose: options.onClose });
          }
        });
        $('iframe').contents().bind('click.popupBox', function (event) {
          methods.close({ popupBox: divPopup, onClose: options.onClose });
        });
        $document.bind('keyup.popupBox', function (event) {
          if (event.keyCode == 27) {
            methods.close({popupBox:divPopup,onClose:options.onClose});
          }
        });
        
        if (options.onOpen) {
          options.onOpen.call();
        }
      };
      return elem.each(make);
    },
    /*open: function(options) {
      options = $.extend({
        position: 'center'
      }, options);
      var elem = this;
      var make = function() {
        event.preventDefault();

        var pop = $(this);
        var box = $(this).parent().find(settings['box']);

        box.find(settings['arrow']).css({ 'left': box.width() / 2 - 10 });
        box.find(settings['arrow_border']).css({ 'left': box.width() / 2 - 10 });

        if (box.css('display') == 'block') {
          methods.close();
        } else {
          box.css({ 'display': 'block', 'top': 10, 'left': ((pop.parent().width() / 2) - box.width() / 2) });
        }
      };
      return elem.each(make);

    },*/

    close: function (options) {    
      options = $.extend({
        popupBox :null,
        onClose: null
      }, options);
      var elem = this;
      var make = function () {
        var box;
        var $document = $(document);
        if (!options.popupBox) {
          box = $('.popupBox');
        } else {
          box = options.popupBox;          
        }
        box.find('.arrow').remove();
        box.find('.arrow-border').remove();
        box.find('.box').children().unwrap().unwrap().hide();

        if (options.onClose) {
          options.onClose.call();
        }
        $document.unbind('click.popupBox');
        $('iframe').contents().unbind('click.popupBox');
        $document.unbind('keyup.popupBox');
      };
      return make.call();
    }
  };
  
  $.fn.popupBox = function (method) {
    if (methods[method]) {
      return methods[method].apply(this, Array.prototype.slice.call(arguments, 1));
    } else if (typeof method === 'object' || !method) {
      return methods.init.apply(this, arguments);
    } else {
      return $.error('Метод с именем ' + method + ' не существует');
    }
  };

})(jQuery);

//повноекранний діалог з кнопкою "повернутися на крок назад"

/*<div id="childDocument" hidden="hidden" style="display:none;" class="child-document">
    <div id="btChildDocumentHidden" class="ico-navigate-left" style="float:left;margin:10px 10px 0 0;position:absolute;"
     onclick="$('#childDocumentContent').find('*').unbind();$('#childDocument').hide();$('#mainDocument').show();$('#childDocumentContent').children().remove();">
</div>
<div id="childDocumentContent" style="padding-left:40px;"></div>
</div>*/

(function ($) {
  var methods = {
    init: function(options) {
      options = $.extend({
        selector: '#body'
      }, options);
      var elem = this;
      var body = $(options.selector);
      if (body.length == 0) {
          body = $('body');
      }
      //var main = $('<div/>', { style: 'display:none;' });
      var children = body.children();
      var make = function() {
        var bodyChild = $('<div />',{id:'bodyChild',
          'class':'child-document'});
        var btnBeck = $('<div />', {'class':'ico-navigate-left',
          style:'float:left;margin:10px 10px 0 0;position:absolute;'})
          .bind('click',function() {
            bodyChild.find('*').unbind();
            bodyChild.remove();
            //children.unwrap();
            children.show();
          });
        var content = $('<div/>',{style:'padding-left:40px;'});
        content.append(elem);
        bodyChild.append(btnBeck).append(content);
        //children.wrap(main);
        children.hide();
        body.append(bodyChild);
      };
      return elem.each(make);
    },
    close:function(options) {
      options = $.extend({
        selector:null
      }, options);
      var elem = this;
      var dialog = elem.parentsUntil('#bodyChild').parent();
      var make = function() {
        dialog.find('*').unbind();
        dialog.remove();
      };
      return elem.each(make);
    }
  };
  $.fn.fullDialog = function (method) {
    if (methods[method]) {
      return methods[method].apply(this, Array.prototype.slice.call(arguments, 1));
    } else if (typeof method === 'object' || !method) {
      return methods.init.apply(this, arguments);
    } else {
      return $.error('Метод с именем ' + method + ' не существует');
    }
  };
})(jQuery);

//drag
(function ($) {
  $.fn.drag = function(o) {
    var o = $.extend({
      start: function() {
      },   // при начале перетаскивания
      stop: function() {
      } // при завершении перетаскивания
    }, o);
    return $(this).each(function() {
      var d = $(this); // получаем текущий элемент
      d.mousedown(function(e) { // при удерживании мыши
        d.css('position', 'relative');
        $(document).unbind('mouseup'); // очищаем событие при отпускании мыши
        o.start(d); // выполнение пользовательской функции

        var f = d.offset(), // находим позицию курсора относительно элемента
          x = $(document).scrollLeft() + e.pageX, // + f.left,  // слева
          y = $(document).scrollTop() - e.pageY; // + f.top;  // и сверху
        if (statusedit != 0) {
          $(document).mousemove(function(a) { // при перемещении мыши
            d.css({ 'top': a.pageY + y + 'px', 'left': a.pageX - x + 'px' }); // двигаем блок
          });
        } else {
          //$(document).mousemove(function (a) { // при перемещении мыши
          //  d.css({ 'top': a.pageY  + 'px', 'left': a.pageX  + 'px' }); // двигаем блок
          //});
        }
        $(document).mouseup(function() { // когда мышь отпущена

          $(document).unbind('mousemove'); // убираем событие при перемещении мыши
          o.stop(d); // выполнение пользовательской функции

        });
        return false;
      });
    });
  };
})(jQuery);

/**
 * jquery.resizestop (and resizestart)
 * by: Fatih Kadir Akın
 *
 * License is CC0, published to the public domain.
 */
(function ($) {
  // Slice shortcut
  var slice = Array.prototype.slice;

  // Special event definition
  $.extend($.event.special, {
    // resize stop special event.
    resizestop: {
      add: function (handle) {
        // shortcut to the event handler.
        var handler = handle.handler;

        // event modifying
        $(this).resize(function (e) {
          // every resize event clears handler's timer.
          // and every handler must have a timer.
          clearTimeout(handler._timer);
          // change event type text.
          e.type = 'resizestop';
          // push the "resize" event to the handler.
          var _proxy = $.proxy(handler, this, e);
          // if no resize event fired for a time that we decide, 
          // then it means its stopped.
          handler._timer = setTimeout(_proxy, handle.data || 200);
        });
      }
    },
    // resize start special event
    resizestart: {
      add: function (handle) {
        // shortcut to the event handler.
        var handler = handle.handler;

        // event modifying
        $(this).on('resize', function (e) {
          // every resize event clears handler's timer.
          // and every handler must have a timer.
          clearTimeout(handler._timer);
          // we suddenly fire the event, then we can put 
          // a flag with name _started knows if it's already fired.
          if (!handler._started) {
            e.type = 'resizestart';
            handler.apply(this, arguments);
            // after firing the handler, put the flag with the value "true"
            handler._started = true;
          }
          handler._timer = setTimeout($.proxy(function () {
            // after a while, it will make the flag false.
            handler._started = false;
          }, this), handle.data || 300);
        });
      }
    }
  });
  // binding and currying the shortcuts.
  $.extend($.fn, {
    // $(window).resizestop instead of $(window).on('resizestop')
    resizestop: function () {
      // will push the "resizestop" argument at the beginning of arguments
      $(this).on.apply(this, ["resizestop"].concat(slice.call(arguments)));
    },
    // $(window).resizestart instead of $(window).on('resizestart')
    resizestart: function () {
      // will push the "resizestart" argument at the beginning of arguments
      $(this).on.apply(this, ["resizestart"].concat(slice.call(arguments)));
    }
  });
})(jQuery);


//override dialog's title function to allow for HTML titles
if ($ && $.widget) {
  $.ui.dialog.prototype._createOverlayOld =$.ui.dialog.prototype._createOverlay;
  $.widget("ui.dialog", $.extend($.ui.dialog.prototype, {
    _title: function (title) {
      var $title = this.options.title;
      if ($title == 'none') {
        this.uiDialogTitlebar.css(
          {
            'z-index': '1',
            'position': 'absolute',
            'width': '100%',
            'padding': '0',
            'left':'-3px'
          }
        );
        title.html('&#160;');
      }
      else if (("title_html" in this.options) && this.options.title_html == true) {
        title.html($title || '&#160;');
      } else if (!$title) {
        title.html('&#160;');
      } else {
        title.text($title);
      }
    },
    //bug: баг при відкритті одночасно окількох діалогів фон не міняв Z-INDEX
    _createOverlay: function() {
      this._createOverlayOld();
      if (this.overlay) {
        this.overlay.css('z-index', parseInt(this.overlay.css('z-index')) + this.document.data("ui-dialog-overlays") * 2 + 1);
      }
    }
  }));
}

//override tebs's _isLocal property 
if ($ && $.widget) {
  $.widget("ui.tabs", $.extend($.ui.tabs.prototype, {
      _isLocal: (function () {
          var rhash = /#.*$/;

          return function (anchor) {
              var anchorUrl, locationUrl;

              // support: IE7
              // IE7 doesn't normalize the href property when set via script (#9317)
              anchor = anchor.cloneNode(false);

              anchorUrl = anchor.href.replace(rhash, "");
              locationUrl = location.href.replace(rhash, "");

              // decoding may throw an error if the URL isn't UTF-8 (#9518)
              try {
                  anchorUrl = decodeURIComponent(anchorUrl);
              } catch (error) { }
              try {
                  locationUrl = decodeURIComponent(locationUrl);
              } catch (error) { }

              //return anchor.hash.length > 1 && anchorUrl === locationUrl;
              return this.options.isLocal || true;
          };
      })()
  }));
}


//розширення діалогу JQUERY-UI
//добавить кнопку розширити на весь екран
/*
function (options) { 
  options = $.extend({
    pageNum:null
  }, options);

  var elem = this;
  var checkDoc = elem.find('tbody input:checkbox:checked');
  var result = new Object();
  result.length = 0;
  result.arr = new Object();
  checkDoc.quickEach(function () {
    result.arr[result.length++] = this.val();
  });
  return result;*/

/*(function () {
  var old = $.ui.dialog.prototype._create;
  $.ui.dialog.prototype._create = function (d) {
    old.call(this, d);
    var self = this,
      options = self.options,
      oldHeight = options.height,
      oldWidth = options.width,
      uiDialogTitlebarFull = $('<a href="#"></a>')
        .addClass(
          'ui-dialog-titlebar-full ' +
            'ui-corner-all'
        )
        .attr('role', 'button')
        .hover(
          function() {
            uiDialogTitlebarFull.addClass('ui-state-hover');
          },
          function() {
            uiDialogTitlebarFull.removeClass('ui-state-hover');
          }
        )
        .toggle(
          function() {
            self._setOptions({
              height: window.innerHeight - 10,
              width: window.innerWidth - 30
            });
            self._position('center');
            return false;
          },
          function() {
            self._setOptions({
              height: oldHeight,
              width: oldWidth
            });
            self._position('center');
            return false;
          }
        )
        .focus(function() {
          uiDialogTitlebarFull.addClass('ui-state-focus');
        })
        .blur(function() {
          uiDialogTitlebarFull.removeClass('ui-state-focus');
        })
        .appendTo(self.uiDialogTitlebar),
      uiDialogTitlebarFullText = $('<span></span>')
        .addClass(
          'ui-icon ' +
            'ui-icon-newwin'
        )
        .text(options.fullText)
        .appendTo(uiDialogTitlebarFull);

  };
})();*/

function initAjaxNavigation(options) {
  options = $.extend({
    loadContainer: '#bodyPageContent',
    selector: 'a[data-ajax-navigation="true"]',
    selectorContainer: '#bodyPageContent',
    func: function () { },
    afretLoadFunc: function () { },
    isStateSelectorContainer: false
  }, options);
  if (options.isStateSelectorContainer) {
    $(options.selectorContainer).on('click', options.selector, function () {
      var $this = $(this);
      var state = {
        title: $this.prop('title'),
        url: $this.prop('href'),
        moduleId: $this.data('parent-module-id'),
        funcId: $this.data('func-id')
      };
      // заносим ссылку в историю
      history.pushState(state, state.title, state.url);
      siteAjaxNavigation(
        this.getAttribute('href'),
        options.loadContainer,
        function () {
          options.afretLoadFunc.call($this);
          //initAjaxNavigation(options);
        });
      options.func.call($this);
      return false;
    });
  } else {
    $(options.selectorContainer).find(options.selector).on('click', function () {
      var $this = $(this);
      var state = {
        title: $this.prop('title'),
        url: $this.prop('href'),
        moduleId: $this.data('parent-module-id'),
        funcId: $this.data('func-id')
      };
      // заносим ссылку в историю
      history.pushState(state, state.title, state.url);
      siteAjaxNavigation(
        this.getAttribute('href'),
        options.loadContainer,
        function () {
          initAjaxNavigation({
            loadContainer: '#bodyPageContent',
            selector: 'a[data-ajax-navigation="true"]',
            selectorContainer: '#bodyPageContent'
          });
        });
      options.func.call($this);
      return false;
    });
  }
}

function siteAjaxNavigation(url, container, func) {
  url.split('?').length == 1 ? url += '?' : url += '&';
  url += 'partial=true';
  var bodyPageContent = $(container);
  if (bodyPageContent.length > 0) {
    if (!bodyPageContent.data('isloading')) {
      bodyPageContent.data('isloading', 'false');
    }
    if (bodyPageContent.data('isloading') == 'false') {
      bodyPageContent.data('isloading', 'true');
      bodyPageContent.load(url, function () {
        bodyPageContent.data('isloading', 'false');
        if (func) {
          func.call();
        }
      });
    } else {
      var gritter = $.gritter.add({
        title: 'Триває завантаження',
        text: 'Триває завантаження вибраної раніше функції. Дочекайтеся її завантаження',
        class_name: 'gritter-warning gritter-center gritter-light top-0',
        time: 3000,
        position: 'bottom-left'
      });
      $('#gritter-item-' + gritter).css('top', '10px');
    }

  } else {
    document.location.href = url;
  }
}
function togleSidebarActive(moduleId, funcId) {
  var sidebarList = $('#sidebarList');
  sidebarList.find('li.active').removeClass('active');

  sidebarList.find('[data-module-id="' + moduleId + '"]')
    .addClass('active')
    .find('[data-func-id="' + funcId + '"]')
    .parent()
    .addClass('active');
}
//пошук на по DOM об"єкту
//domObject - дом обєкт в якому буде проводитись пошук
//item - корневий об"єктт який залишиться після пошуку
//selector - об"єкт в середині item, в якому буде безпосереднє проводитись пошук тексту
(function ($) {
    var methods = {
        init: function (options) {
            options = $.extend({ domObject: '', item: '', selector: '' }, options);
            var elem = this;
            var $domObject = $(options.domObject);
            var endSeach = function (items) {
                elem.val('');
                items.find('.seach-dom-text').quickEach(function () {
                    this.replaceWith(this.html());
                });
                items.show();

            };
            var seach = function (obj, itemName, selectorName) {
                var items = obj.find(itemName);
                var btCancel = elem.parent().parent().find('i.icon-remove');
                if (btCancel.length == 0) {
                    btCancel = $('<i style="cursor:pointer;" class="icon-remove red"></i>');
                    btCancel.on('click', function () {
                        btCancel.remove();
                        endSeach(items);
                    });
                }

                items.find('.seach-dom-text').quickEach(function () {
                    this.replaceWith(this.html());
                });

                var text = elem.val();
                if (text.trim() == '') {
                    btCancel.remove();
                    endSeach(items);
                } else {
                    elem.parent().before(btCancel);
                    items.quickEach(function () {
                        var $this = this;
                        var thisSelector = $this.find(selectorName);
                        var oldText = thisSelector.html();
                        var indexStart = oldText.toUpperCase().indexOf(text.toUpperCase());
                        if (indexStart > -1) {
                            $this.show();

                            var newText = oldText.substring(0, indexStart);
                            newText += '<span class="seach-dom-text" style="background-color:#fefe00;color:#000;">' + oldText.substring(indexStart, indexStart + text.length) + '</span>';
                            newText += oldText.substring(indexStart + text.length, oldText.length);
                            thisSelector.html(newText).show();
                        } else {
                            $this.hide();
                        }


                    });
                }
            };

            var make = function () {
                elem.on('keypress', function (e) {
                    if (e.keyCode == 13) {
                        seach($domObject, options.item, options.selector);
                        return false;
                    }
                });
                var btSeasch = elem.parent().find('.icon-search');
                if (btSeasch.length == 0) {
                    btSeasch = $('<i class="icon-search nav-search-icon"></i>');
                    elem.after(btSeasch);
                }
                btSeasch.on('click', function () {
                    seach($domObject, options.item, options.selector);
                }).css('cursor', 'pointer');
            };
            return elem.each(make);
        }
    };
    $.fn.searchOnDom = function (method) {
        if (methods[method]) {
            return methods[method].apply(this, Array.prototype.slice.call(arguments, 1));
        } else if (typeof method === 'object' || !method) {
            return methods.init.apply(this, arguments);
        } else {
            return $.error('Метод с именем ' + method + ' не существует');
        }
    };
})(jQuery);
//прочитати параметр з кукісів
function getCookie(par) {
  var result = null;
  var pageCookie = document.cookie;
  var pos = pageCookie.indexOf(par + '=');
  if (pos != -1) {
    var start = pos + par.length + 1;
    var end = pageCookie.indexOf(';', start);
    if (end == -1) end = pageCookie.length;
    result = pageCookie.substring(start, end);
    result = unescape(result);
  }
  return result;
}

/*function setCookie(name, value, options) {
  options = options || {};

  var expires = options.expires;

  if (typeof expires == "number" && expires) {
    var d = new Date();
    d.setTime(d.getTime() + expires * 1000);
    expires = options.expires = d;
  }
  if (expires && expires.toUTCString) {
    options.expires = expires.toUTCString();
  }

  value = encodeURIComponent(value);

  var updatedCookie = name + "=" + value;

  for (var propName in options) {
    updatedCookie += "; " + propName;
    var propValue = options[propName];
    if (propValue !== true) {
      updatedCookie += "=" + propValue;
    }
  }

  document.cookie = updatedCookie;
}*/

function setCookie(key, value, end, path, domain, secure) {
  if (arguments.length === 1) {
    return decodeURIComponent(document.cookie.replace(new RegExp("(?:(?:^|.*;)\\s*" + encodeURIComponent(key).replace(/[\-\.\+\*]/g, "\\$&") + "\\s*\\=\\s*([^;]*).*$)|^.*$"), "$1")) || null;
  }

  if (!key || /^(?:expires|max\-age|path|domain|secure)$/i.test(key)) { return false; }
  var expires = "";
  if (end) {
    switch (end.constructor) {
      case Number:
        expires = end === Infinity ? "; expires=Fri, 31 Dec 9999 23:59:59 GMT" : "; max-age=" + end;
        break;
      case String:
        expires = "; expires=" + end;
        break;
      case Date:
        expires = "; expires=" + end.toUTCString();
        break;
    }
  }
  document.cookie = encodeURIComponent(key) + "=" + encodeURIComponent(value) + expires + (domain ? "; domain=" + domain : "") + (path ? "; path=" + path : "") + (secure ? "; secure" : "");
  return true;
}

//Аналоги jQuery 
//функція додавання класу до елемента аналог JQuery.addClass()
function addClass(o, c) {
  var re = new RegExp("(^|\\s)" + c + "(\\s|$)", "g");
  if (re.test(o.className)) return;
  o.className = (o.className + " " + c).replace(/\s+/g, " ").replace(/(^ | $)/g, "");
}
//функція віднімання класу від елемента аналог JQuery.removeClass()
function removeClass(o, c) {
  var re = new RegExp("(^|\\s)" + c + "(\\s|$)", "g");
  o.className = o.className.replace(re, "$1").replace(/\s+/g, " ").replace(/(^ | $)/g, "");
}
//функція перевірки класу в елементі аналог JQuery.hashClass()
function hashClass(o, c) {
  var re = new RegExp("(^|\\s)" + c + "(\\s|$)", "g");
  if (re.test(o.className)) {
    return true;
  } else {
    return false;
  }
}
//достать параметер з URL
function getParamFromUrl(param, url) {
  /// <summary>достать параметер з URL.</summary>
  /// <param name="param" type="String">параметр який шукаємо.</param>
  /// <param name="url" type="String">url</param>  
  /// <returns type="String">значенна параметра або пусто якщо його не знайдено.</returns>
  url = url.substring(url.indexOf('?') + 1);
  for (var i = 0; i < url.split("&").length; i++)
    if (url.split("&")[i].split("=")[0] == param) return url.split("&")[i].split("=")[1];
  return "";
}

//fix ie < 9
if (!document.getElementsByClassName && bars.test.hasIE > 7) {
  HTMLDocument.prototype.getElementsByClassName = Element.prototype.getElementsByClassName = function (classList) {
    var node = this;
    var list = node.getElementsByTagName('*');
    var length = list.length;
    var classArray = classList.split(/\s+/);
    var classes = classArray.length;
    var result = [];
    var j;
    var i;
    for (i = 0; i < length; i++) {
      for (j = 0; j < classes; j++) {
        if (list[i].className.search('\\b' + classArray[j] + '\\b') != -1) {
          result.push(list[i]);
          break;
        }
      }
    }
    return result;
  };
}

function addEvent(element, event, fn) {
  if (element.addEventListener) element.addEventListener(event, fn, false);
  else if (element.attachEvent) element.attachEvent('on' + event, fn);
  else { element['on' + event] = fn; }
}
String.format = function () {
    // The string containing the format items (e.g. "{0}")
    // will and always has to be the first argument.
    var theString = arguments[0];

    // start with the second argument (i = 1)
    for (var i = 1; i < arguments.length; i++) {
        // "gm" = RegEx options for Global search (more than one instance)
        // and for Multiline search
        var regEx = new RegExp("\\{" + (i - 1) + "\\}", "gm");
        theString = theString.replace(regEx, arguments[i]);
    }
    return theString;
}

if (!Array.prototype.indexOf) {
    Array.prototype.indexOf = function (elt /*, from*/) {
        var len = this.length >>> 0;

        var from = Number(arguments[1]) || 0;
        from = (from < 0)
             ? Math.ceil(from)
             : Math.floor(from);
        if (from < 0)
            from += len;

        for (; from < len; from++) {
            if (from in this &&
                this[from] === elt)
                return from;
        }
        return -1;
    };
}
/*
//fix ie < 8
if (!window.Element || !window.Element.prototype || !window.Element.prototype.hasAttribute) {
  $(function() {
    (function() {

      function hasAttribute(attrName) {
        return typeof this[attrName] !== 'undefined'; // You may also be able to check getAttribute() against null, though it is possible this could cause problems for any older browsers (if any) which followed the old DOM3 way of returning the empty string for an empty string (yet did not possess hasAttribute as per our checks above). See https://developer.mozilla.org/en-US/docs/Web/API/Element.getAttribute
      }

      var inputs = document.getElementsByTagName('*');
      for (var i = 0; i < inputs.length; i++) {
        inputs[i].hasAttribute = hasAttribute;
      }
    }());
  });
}*/
