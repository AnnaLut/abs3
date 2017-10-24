var calculatorObject = {
  defaultValue: '0',
  stringResult: '',
  operators: ['+', '-', '*', '/'],
  sequence: [],
  oper: null,
  summ: 0.00,
  cycleFinished: false,
  urlCalculate: '/mod/calculate.php',
  isNumber: function (value) {
    return typeof value !== 'undefined' && !isNaN(parseFloat(value)) && isFinite(value);
  },
  calculate: function (num1,num2,oper) {
    var result = 0.00;
    switch(oper) {
      case '=':
        calculatorObject.calculate(num1,num2, calculatorObject.oper);
        break;
      case '+':
        result = parseFloat(num1) + parseFloat(num2);
        break;
      case '-':
        result = parseFloat(num1) - parseFloat(num2);
        break;
      case '*':
        result = parseFloat(num1) * parseFloat(num2);
        break;
      case '/':
        result = parseFloat(num1) / parseFloat(num2);
        break;
      case '%':
        result = parseFloat(num1) * parseFloat(num2) / 100;
        break;
      default:
        break;
    }
    calculatorObject.summ = result;
    return result;
  },
  trigger: function (obj) {
    if (obj.length > 0) {
      obj.find('ul li').bind('click', function () {

        $(this).siblings('li').removeClass('active');
        $(this).addClass('active');

        var thisItem = $(this).attr('data-value');

        var thisValue = $('#calculatorResult').text();
        
        var res;
        switch (thisItem) {

          case '=':
            if (calculatorObject.oper != null) {
              res = calculatorObject.calculate(calculatorObject.summ, thisValue, calculatorObject.oper);
              $('#calculatorCurentOper').text('');
              $('#calculatorResult').html(res);
              calculatorObject.oper = null;
              calculatorObject.summ = 0.00;
              calculatorObject.cycleFinished = true;
            }
            break;

          case 'c':
            $('#calculatorResult').html(calculatorObject.defaultValue);
            break;
          case 'ce':
            calculatorObject.summ = 0.00;
            calculatorObject.oper = null;
            $('#calculatorCurentOper').text('');
            $('#calculatorResult').html(calculatorObject.defaultValue);
            calculatorObject.cycleFinished = true;
            break;            
          case '%':
            res = calculatorObject.calculate(calculatorObject.summ, thisValue, thisItem);
            $('#calculatorCurentOper').text('');
            $('#calculatorResult').html(res);
            calculatorObject.oper = null;
            calculatorObject.cycleFinished = true;
            break;
          case calculatorObject.operators[0]:
          case calculatorObject.operators[1]:
          case calculatorObject.operators[2]:
          case calculatorObject.operators[3]:

            if (calculatorObject.oper != null) {
              res = calculatorObject.calculate(calculatorObject.summ, thisValue, thisItem);
            } else {
              res = thisValue;
            }
            
            $('#calculatorCurentOper').text(res + ' ' + thisItem);
            $('#calculatorResult').html(calculatorObject.defaultValue);
            calculatorObject.summ = res;
            calculatorObject.oper = thisItem;

            break;
          case '+/-':
            var calcRes = $('#calculatorResult');
            calcRes.html(parseFloat(calcRes.html()) * -1);
            
            break;
          default:
            // if current value is not an operator
            if (jQuery.inArray(thisValue, calculatorObject.operators) === -1) {
              if (thisValue !== calculatorObject.defaultValue) {
                if (calculatorObject.cycleFinished) {
                  calculatorObject.cycleFinished = false;
                  $('#calculatorResult').html(thisItem);
                } else {
                  $('#calculatorResult').html(thisValue + thisItem);
                }
              } else {
                $('#calculatorResult').html(thisItem);
              }
              // otherwise - if it is
            } else {
              $('#calculatorResult').html(thisItem);
            }

        }


      });
    }
  }
};
$(function () {

  calculatorObject.trigger($('#calculator'));

});