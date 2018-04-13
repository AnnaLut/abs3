if (!('bars' in window)) window['bars'] = {};
bars.utils = bars.utils || {};

//фцнкция проверки контрольного разряда ЕДРПОУ
bars.utils.checkEdrpouCtrlDigit = function (edrpou) {
	//функция расчета контрольной суммы
	function calcCheckSum() {
	    var sum = 0;
		for (var k = 0; k < 7; k++) {
			sum = sum + weightCoeficient[k] * code[k];
		}
	    return sum;
	}
	//функция расчета контролного разряда
	function controlDigit() {
		var cd = calcCheckSum() % 11;
	    if (cd == 10) {
	        return 0;
	    } else {
	        return cd;
	    }
	}
	//проверим код на недопустимые символы
	var result = new RegExp('^\\d+$').test(edrpou);
	if (!result) {
	    return result;
	}
    var code = edrpou.split('');
	var weightCoeficient1 = '1234567'.split('');
	var weightCoeficient2 = '7123456'.split('');
	var weightCoeficient = weightCoeficient2;
	if (edrpou && edrpou.length == 8) {
		if (code < 30000000 || code > 60000000) {
			weightCoeficient = weightCoeficient1;
		}
	    var checkDigit = controlDigit();
		if (checkDigit > 10) {
			//умножаем коєфициенты на 2
		    for (var i = 0; i < 7; i++) {
		        weightCoeficient[i] = weightCoeficient[i] + 2;
		    }
			//считаем еще раз контрольный разряд
		    checkDigit = controlDigit();
		}
	    result = code[7] == checkDigit;
	}
	return result;
}

//классическая функция приведения контрольного разраяда номера счета  в соответствие МФО
bars.utils.vkrz = function (mfo,nls0)
{ 
    var nls=nls0.substring(0,4)+'0'+nls0.substring(5, nls0.length );
    var m1 = '137130'         ;
    var m2 = '37137137137137' ;
    var j = 0;
    var i = 0;
    for ( i = 0; i < mfo.length; i++ )
    { j =j +  parseInt(mfo.substring(i,i+1)) * parseInt(m1.substring(i,i+1)); }

    for ( i = 0; i < nls.length; i++ )
    { j =j +  parseInt(nls.substring(i,i+1)) * parseInt(m2.substring(i,i+1)); }
         
    return nls.substring(0,4) +
           (((j + nls.length ) * 7) % 10 ) +
           nls.substring(5, nls.length );
}

//проверка валидности контрольного разряда
bars.utils.checkNlsCtrlDigit = function (mfo, nls) {
    var validNls = this.vkrz(mfo, nls);
    return nls.substring(4, 5) == validNls.substring(4, 5);
}



