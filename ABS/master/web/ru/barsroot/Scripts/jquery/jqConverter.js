(function ($) {
  function bindClickOnButton(elem) {
    elem.on('mousedown', function () {
      var $this = $(this);
      $this.addClass($this.data('click-class'));
    }).on('mouseup mouseout', function () {
      var $this = $(this);
      $this.removeClass($this.data('click-class'));
    });
  };

  function convert(data, serviceUrl, elem) {
    elem.find('#converterErrorMessage').html('');
    $.post(serviceUrl, data, function(result) {
      if (result.status == 'ok') {
        elem.find('#f-amount-to').val(result.message);
      }else if (result.status == 'error') {
        elem.find('#converterErrorMessage').html(result.message);
      }
    },'json');
  }

  function collectData(elem) {
    var result = {};
    result.summFrom = elem.find('#f-amount-from').val();
    result.valFrom = elem.find('#s-currency-from').data('value');
    result.summTo = elem.find('#f-amount-to').val();
    result.valTo = elem.find('#s-currency-to').data('value');
    result.sourse = elem.find('#s-source').data('value');
    result.date = elem.find('#s-date').data('value');
    return result;
  }

  function reverseVal(currencyFrom, currencyTo) {
    var curentFrom = currencyFrom.data('value');
    var curentTo = currencyTo.data('value');
    bindSelectedCurrency(currencyFrom, curentTo);
    bindSelectedCurrency(currencyTo, curentFrom); 
  }

  function bindSelectedCurrency(currencyDd, value) {
    var prefix = currencyDd.attr('id') == 's-currency-to' ? 'to' : 'from';
    var $thisDd = currencyDd.find('.cc-input-currency-dd');
    $thisDd.find('li.selected').removeClass('selected');
    var thisCurr = $thisDd.find('li[data-value="'+value+'"]');
    thisCurr.addClass('selected');
    currencyDd.data('value', thisCurr.data('value'));
    currencyDd.find('.cc-input-currency-' + prefix + '-label').text(thisCurr.data('lcv'));
    $thisDd.css('display', 'none');
  }

  var methods = {
    init: function (options) {
      options = $.extend({
        language: 'ua',
        serviceUrl:''
      }, options);
      var elem = this;
      var source = elem.find('#s-source');
      var currencyFrom = elem.find('#s-currency-from');
      var currencyTo = elem.find('#s-currency-to');
      var btEquality = elem.find('.cc-button-equality');
      var btReverse = elem.find('.cc-button-reverse');
      var s1 = elem.find('.f-amount-s1');
      
      var make = function () {
        elem.data('converter', 'converter');
        elem.find('.cc-input').hover(function() {
          var $this = $(this);
          $this.addClass($this.data('hover-class'));
        }, function() {
          var $this = $(this);
          $this.removeClass($this.data('hover-class'));
        });

        s1.focus(function() { this.select(); })
          .change(function() { this.value = separateMoney(this.value); })
          .numberMask({ beforePoint: 10, pattern: /^(-)?([\d])*(\.|\,)?([0-9])*$/ });

        bindClickOnButton(btEquality);
        bindClickOnButton(btReverse);

        btEquality.on('click', function () {
          convert(collectData(elem),options.serviceUrl, elem);
        });
        btReverse.on('click', function () {
          reverseVal(currencyFrom, currencyTo);
          convert(collectData(elem),options.serviceUrl, elem);
        });

        currencyFrom.find('.cc-input-currency-from').on('click', function () {
          source.find('.cc-input-source-dd').css('display', 'none').unbind('click.sourcelabel').unbind('click.sourceli');
          var $thisDD = currencyFrom.find('.cc-input-currency-dd');
          $thisDD.css('display', 'block').bind('click.selvallabel', '.c-input-currency-dd-label', function () {
            $thisDD.css('display', 'none').unbind('click.selvallabel').unbind('click.selvalli');
          }).on('click.selvalli', 'li', function () {
            bindSelectedCurrency(currencyFrom, $(this).data('value'));
            /*$thisDD.find('li.selected').removeClass('selected');
            var thisCurr = $(this);
            thisCurr.addClass('selected');
            var valuta = thisCurr.data('value');
            currencyFrom.data('value',valuta);
            currencyFrom.find('.cc-input-currency-from-label').text(valuta);
            $thisDD.css('display', 'none');//.find('.cc-input-currency-from-label').text(valuta);*/
          });
        });
        currencyTo.find('.cc-input-currency-to').on('click', function () {
          source.find('.cc-input-source-dd').css('display', 'none').unbind('click.sourcelabel').unbind('click.sourceli');
          var $thisDD = currencyTo.find('.cc-input-currency-dd');
          $thisDD.css('display', 'block').bind('click.selvallabel', '.c-input-currency-dd-label', function () {
            $thisDD.css('display', 'none').unbind('click.selvallabel').unbind('click.selvalli');
          }).on('click.selvalli', 'li', function () {
            bindSelectedCurrency(currencyTo, $(this).data('value'));
            /*$thisDD.find('li.selected').removeClass('selected');
            var thisCurr = $(this);
            thisCurr.addClass('selected');
            var valuta = thisCurr.data('value');
            currencyTo.data('value',valuta);
            currencyTo.find('.cc-input-currency-to-label').text(valuta);
            $thisDD.css('display', 'none'); //.find('.cc-input-currency-to-label').text(valuta);*/
          });
        });        
        source.find('.cc-input-source').on('click', function () {
          currencyFrom.find('.cc-input-currency-dd').css('display', 'none').unbind('click.selvallabel').unbind('click.selvalli');          
          currencyTo.find('.cc-input-currency-dd').css('display', 'none').unbind('click.selvallabel').unbind('click.selvalli');
          
          var $thisDD = source.find('.cc-input-source-dd');
          $thisDD.css('display', 'block').bind('click.sourcelabel', '.c-input-source-dd-label', function () {
            $thisDD.css('display', 'none').unbind('click.sourcelabel').unbind('click.sourceli');
          }).on('click.sourceli', 'li', function () {
            $thisDD.find('li.selected').removeClass('selected');
            var thisSource = $(this);
            thisSource.addClass('selected');
            var selSourceName = thisSource.data('short-name');
            source.data('value', thisSource.data('value'));
            source.find('.cc-input-source-label').text(selSourceName);
            $thisDD.css('display', 'none').find('.cc-input-source-label').text(selSourceName);
          });
        });

        btEquality.on('');


        /* elem.children('.button,button').click(function () {
          // hide any open menus (Yuneekguy)
          var $this = $(this);
          $('.dropdown-slider').not($this.next('.dropdown-slider')).slideUp();
          $('span.toggle').removeClass('active');
          // open selected dropown
          elem.children('.dropdown-slider').slideToggle('fast');
          $this.find('span.toggle').toggleClass('active');
          return false;
        });
        elem.find('.insert-dropdown').click(function () {
          var $this = $(this);
          $this.parent().find('.insert-dropdown-slider').slideToggle();
          return false;
        });*/
      };
      return elem.each(make);
    },
    remove: function (options) {
      options = $.extend({
        position: 'center'
      }, options);
      var elem = this;
      var make = function () {
        elem.find('div.divLoader').remove();
      };
      return elem.each(make);
    }
  };
  $.fn.converter = function (method) {
    if (methods[method]) {
      return methods[method].apply(this, Array.prototype.slice.call(arguments, 1));
    } else if (typeof method === 'object' || !method) {
      return methods.init.apply(this, arguments);
    } else {
      return $.error('Метод с именем ' + method + ' не существует');
    }
  };
})(jQuery);