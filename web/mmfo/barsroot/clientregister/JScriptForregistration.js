var curTabCount = 0;
var oImg = null;
var flagEnhCheck = false;
var flagROCheck = false;
var segment = null;
var custAttrList = new Array();
var custRiskList = new Array();
var custReptList = new Array();
var custCatsList = new Array();
var isOkpoExclusion = '0';
var valOKPO = '';
var g_PhotoType = "";

// photo directions
var PHOTO_DIRECTION_ALL = 0;
var PHOTO_DIRECTION_WEB_CAMERA = 1;
var PHOTO_DIRECTION_HARD_DISK = 2;
var PHOTO_DIRECTION_SCANER = 3;

var isCustomerSpd = function () {
    var url = '';
    var fr = getFrame('Tab0');
    if (fr.location) {
        url = fr.location.href;
    } else {
        url = fr.src;
    }
    return getParamFromUrl('spd', url) === '1';
}
var isRegisterByScb = function () {
    return getParamFromUrl('gcif', parent.document.location.href) != null;
}

// служебные функция JavaScript
var ServiceUrl = '/barsroot/clientregister/defaultWebService.asmx';
function ExecSync(method, args) {
    var executor = new Sys.Net.XMLHttpSyncExecutor();
    var request = new Sys.Net.WebRequest();

    request.set_url(ServiceUrl + '/' + method);
    request.set_httpVerb('POST');
    request.get_headers()['Content-Type'] = 'application/json; charset=utf-8';
    request.set_executor(executor);
    request.set_body(JSON.stringify(args, function (key, value) { return value === "" ? "" : value; }));
    request.invoke();

    if (executor.get_responseAvailable()) {
        return (executor.get_object());
    }

    return (false);
}

function validate() {
    if (Check_MainRekv() && Check_RekvNalogoplat() && Check_EkonomNorm() && Check_DopReqv()) {
        return true;
    } else {
        return false;
    }
}

var dptModule = {
    docId: null,
    init: function () {
        if (getParamFromUrl('module') === 'DPT' && obj_Parameters['EditType'] === 'ReReg') {
            $('#dptChangeRekv').show();
        }
    },
    saveCustChange: function () {
        if (validate()) {
            bars.ui.loader('body', true);
            var saveRes = ExecSync('SaveCustChangeForPrint', {
                rnk: obj_Parameters['ID'],
                custTags: {
                    NAME_FULL: obj_Parameters['NMK'],
                    BIRTH_DATE: obj_Parameters['BDAY'],
                    DATE_PHOTO: obj_Parameters['DATE_PHOTO'],
                    CUST_CODE: obj_Parameters['OKPO'],
                    COUNTRY: obj_Parameters['COUNTRY'],
                    DOC_TYPE: obj_Parameters['PASSP'],
                    DOC_SERIAL: obj_Parameters['SER'],
                    DOC_NUMBER: obj_Parameters['NUMDOC'],
                    DOC_ORGAN: obj_Parameters['ORGAN'],
                    DOC_DATE: obj_Parameters['PDATE'],
                    PHOTO_DATE: '',
                    ADDRESS_F: obj_Parameters['fullADR'].type2.address,
                    ADDRESS_U: obj_Parameters['fullADR'].type1.address,
                    HOME_PHONE: obj_Parameters['TELD'],
                    WORK_PHONE: obj_Parameters['TELW'],
                    CELL_PHONE: obj_Parameters['DopRekv_MPNO']
                }
            }).d;
            bars.ui.loader('body', false);
            if (saveRes.Status === "OK") {
                $('#ch_save_change_rekv').removeProp('checked').removeProp('disabled');
                this.docId = saveRes.Message;
                document.location.href = '/barsroot/home/GetTmpFile/?filepatch=' + saveRes.Text + '&filename=Zayava_na_zminu_rekvizitiv_RNK-' + obj_Parameters['ID'] + '.pdf';
            } else {
                bars.ui.error({
                    text: saveRes.Message
                });
            }
        }
    },
    seveCust: function () {
        var id = this.docId;
        var saveRes = ExecSync('SetSignedDoc', {
            docId: id
        }).d;
        saveCustomerToBase();
    }
};

function InitObjects() {
    ready();

    if (obj_Parameters.DopRekvFromEbk) {
        var rekv = obj_Parameters.DopRekvFromEbk;
        for (var i = 0; i < rekv.length; i++) {

            custAttrList[rekv[i].Tag] = {
                Tag: rekv[i].Tag,
                Value: rekv[i].Value,
                Isp: rekv[i].Isp
            };
        }
    }

    //сервис готов
    //locked  = false;
    flagEnhCheck = (ModuleSettings && ModuleSettings.Customers && ModuleSettings.Customers.EnhanceCheck == true);
    flagROCheck = location.href.indexOf('readonly=3') > 0;
    if (obj_Parameters['EditType'] == "View") getEl('bt_reg').disabled = true;

    dptModule.init();

    ShowProgress();
}
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

//функции проверки правильности введенных данных
function Check_MainRekv() {
    // если пришли с readonly=3, то уходим без проверки
    if (flagROCheck) return true;

    var curTab = getFrame('Tab0');
    var curBut = getEl('bTab0');
    goPage(curBut);

    //перевірка заповнення полів ФІО для резедент/нерезезент
    var valid = true;
    var curElement = '';
    var selCodAg = gE(curTab, 'ddl_CODCAGENT');
    var tmpSel = selCodAg.item(selCodAg.selectedIndex).value.substr(0, 1);
    var fioMask = /^[a-zA-Zа-яА-Яа-яА-ЯіІїЇєЄґҐ]{0,1}[a-zA-Zа-яА-Яа-яА-ЯіІїЇєЄґҐ\ \-\`\']{1,69}$/;
    var cyyrilycFioMask = /^[а-яА-Яа-яА-ЯіІїЇєЄґҐ]{0,1}[а-яА-Яа-яА-ЯіІїЇєЄґҐ\ \-\`\']{1,69}$/;
    var sameSymbolsMask = /^(.)\1+$/;

    if (obj_Parameters['CUSTTYPE'] === 'person' && !isCustomerSpd()) {
        var isFoRezident = gE(curTab, 'ddl_CODCAGENT').value === "1-5";
        var isDocPassport = gE(getFrame('Tab3'), 'ddl_PASSP').value === "1";
        if (tmpSel == '1') {
            var ln = gE(curTab, 'ed_FIO_LN').value;

            if (sameSymbolsMask.test(ln.toUpperCase()) && ln.length >= 2) {
                alert('Прізвище має складатись з неоднакових символів.');
                if (curElement == '') curElement = 'ed_FIO_LN';
                valid = false;
            }
            if (ln.length <= 1 && ln.indexOf('-') != -1) {
                alert('Прізвище має складатись не менш ніж із 1 літери.');
                if (curElement == '') curElement = 'ed_FIO_LN';
                valid = false;
            }
            if (isFoRezident && !cyyrilycFioMask.test(ln)) {
                alert('Прізвище резидента ФО може складатись тільки із кирилиці.');
                if (curElement == '') curElement = 'ed_FIO_LN';
                valid = false;
            }
            if (isEmpty(gE(curTab, 'ed_FIO_LN'))) {
                addClass(gE(curTab, 'ed_FIO_LN'), 'err');
                addClass(gE(curTab, 'ed_NMK'), 'err');
                if (curElement == '') curElement = 'ed_FIO_LN';
                valid = false;
            }
            else if (!fioMask.test(gE(curTab, 'ed_FIO_LN').value)) {
                addClass(gE(curTab, 'ed_FIO_LN'), 'err');
                addClass(gE(curTab, 'ed_NMK'), 'err');
                if (curElement == '') curElement = 'ed_FIO_LN';
                valid = false;
            }
            var fn = gE(curTab, 'ed_FIO_FN').value;
            if (sameSymbolsMask.test(fn.toUpperCase()) && fn.length >= 2) {
                alert("Ім'я має складатись із неодинакових символів.");
                if (curElement == '') curElement = 'ed_FIO_FN';
                valid = false;
            }
            if (fn.length <= 1 && fn.indexOf('-') != -1) {
                alert("Ім'я має складатись не менш ніж із 1 літери.");
                if (curElement == '') curElement = 'ed_FIO_FN';
                valid = false;
            }
            if (isFoRezident && !cyyrilycFioMask.test(fn)) {
                alert("Ім'я резидента ФО може складатись тільки із кирилиці.");
                if (curElement == '') curElement = 'ed_FIO_LN';
                valid = false;
            }
            if (isEmpty(gE(curTab, 'ed_FIO_FN'))) {
                addClass(gE(curTab, 'ed_FIO_FN'), 'err');
                addClass(gE(curTab, 'ed_NMK'), 'err');
                if (curElement == '') curElement = 'ed_FIO_FN';
                valid = false;
            }
            else if (!fioMask.test(gE(curTab, 'ed_FIO_FN').value)) {
                addClass(gE(curTab, 'ed_FIO_FN'), 'err');
                addClass(gE(curTab, 'ed_NMK'), 'err');
                if (curElement == '') curElement = 'ed_FIO_FN';
                valid = false;
            }
            var mn = gE(curTab, 'ed_FIO_MN').value;
            if (isDocPassport && sameSymbolsMask.test(mn.toUpperCase()) && mn.length > 0) {
                alert("По-батькові особи, що реєструється із паспортом, має складатись з різних символів.");
                if (curElement == '') curElement = 'ed_FIO_MN';
                valid = false;
            }            
        } else {
            if (isEmpty(gE(curTab, 'ed_FIO_LN_NR'))) {
                addClass(gE(curTab, 'ed_FIO_LN_NR'), 'err');
                addClass(gE(curTab, 'ed_NMK'), 'err');
                if (curElement == '') curElement = 'ed_FIO_LN_NR';
                valid = false;
            }
            else if (!fioMask.test(gE(curTab, 'ed_FIO_LN_NR').value)) {
                addClass(gE(curTab, 'ed_FIO_LN_NR'), 'err');
                addClass(gE(curTab, 'ed_NMK'), 'err');
                if (curElement == '') curElement = 'ed_FIO_LN_NR';
                valid = false;
            }
        }
    }
    if (flagEnhCheck) {
        if (isEmpty(gE(curTab, 'ed_NMKK'))) {
            addClass(gE(curTab, 'ed_NMKK'), 'err');
            if (curElement == '') curElement = 'ed_NMKK';
            valid = false;
        }
    }

    if (isEmpty(gE(curTab, 'ed_NMK'))) {
        addClass(gE(curTab, 'ed_NMK'), 'err');
        if (curElement == '') curElement = 'ed_NMK';
        valid = false;
    }
    if (isEmpty(gE(curTab, 'ed_NMKV'))) {
        addClass(gE(curTab, 'ed_NMKV'), 'err');
        if (curElement == '') curElement = 'ed_NMKV';
        valid = false;
    }

    var curWin = curTab.contentWindow || curTab;
    if (isEmpty(gE(curTab, 'ed_OKPO'))) {
        addClass(gE(curTab, 'ed_OKPO'), 'err');
        if (curElement == '') curElement = 'ed_OKPO';
        valid = false;
    }
    else if (gE(getFrame('Tab0'), 'ddl_TGR').value == '3') { // COBUMMFO-8414 -> 9 цифр при виборі Тимчасового реєстру без перевірки КР
        var newOkpo = prompt('Введіть реєстраційний (обліковий) номер платника податків з Тимчасового реєстру ДПАУ для підтвердження', '');
        var oldOkpo = gE(getFrame('Tab0'), 'ed_OKPO').value;
        if (newOkpo) {
            if (newOkpo != oldOkpo) {
                alert('Підтвердження ТРДПАУ не співпадає з введеним раніше\r\n (' + newOkpo + ' <> ' + oldOkpo + ').');
                valid = false;
            } else {
                valid = true;
            }
        } else {
            valid = false;
        }
    }
    else if (!curWin.checkOKPO(gE(curTab, 'ed_OKPO'))) {
        addClass(gE(curTab, 'ed_OKPO'), 'err');
        if (curElement == '') curElement = 'ed_OKPO';
        valid = false;
        if (obj_Parameters['CUSTTYPE'] == 'person') { //   person/corp
            var ddlSex = getFrame('Tab3').document.getElementById('ddl_SEX');
            var sex = ddlSex.options[ddlSex.selectedIndex].text;
            var dateBir = getFrame('Tab3').document.getElementById('ed_BDAY').value;

            var text = 'Код ЗКПО не відповідає даті народження або статі клієнта.\r\nДата народження: ' +
              dateBir + '. Стать: ' + sex + '. Підтвердіть ЗКПО:';
            var newOkpo = prompt(text, '');
            var oldOkpo = gE(getFrame('Tab0'), 'ed_OKPO').value;
            if (newOkpo) {
                if (newOkpo != oldOkpo) {
                    alert('Підтвердження ЗКПО не співпадає з введеним раніше\r\n (' + newOkpo + ' <> ' + oldOkpo + ').');
                    isOkpoExclusion = '0';
                    valid = false;
                } else {
                    isOkpoExclusion = '1';
                    valid = true;
                }
            } else {
                valid = false;
            }
        }
    }
    if (isEmpty(gE(curTab, 'ed_ADR'))) {
        addClass(gE(curTab, 'ed_ADR'), 'err');
        if (curElement == '') curElement = 'ed_ADR';
        valid = false;
    }

    if (curElement != '') isEmptyCheck(gE(curTab, curElement));
    if (!valid) return false;

    if (!obj_Parameters['fullADR'].type1.filled) {
        alert(LocalizedString('Mes02')/*'Введите полный адрес клиента!'*/);
        return false;
    }

    obj_Parameters['CODCAGENT'] = gE(curTab, 'ddl_CODCAGENT').item(gE(curTab, 'ddl_CODCAGENT').selectedIndex).value.slice(2);
    obj_Parameters['COUNTRY'] = gE(curTab, 'ddl_COUNTRY').item(gE(curTab, 'ddl_COUNTRY').selectedIndex).value;
    obj_Parameters['PRINSIDER'] = gE(curTab, 'ddl_PRINSIDER').item(gE(curTab, 'ddl_PRINSIDER').selectedIndex).value;
    obj_Parameters['TGR'] = gE(curTab, 'ddl_TGR').item(gE(curTab, 'ddl_TGR').selectedIndex).value;
    obj_Parameters['STMT'] = gE(curTab, 'ddl_STMT').item(gE(curTab, 'ddl_STMT').selectedIndex).value;
    //значения едитов
    obj_Parameters['DATE_OFF'] = gE(curTab, 'ed_DATE_OFF').value;
    obj_Parameters['ID'] = gE(curTab, 'ed_ID').value;
    obj_Parameters['ND'] = gE(curTab, 'ed_ND').value;
    obj_Parameters['NMK'] = gE(curTab, 'ed_NMK').value;
    obj_Parameters['NMKV'] = gE(curTab, 'ed_NMKV').value;
    obj_Parameters['NMKK'] = gE(curTab, 'ed_NMKK').value;
    obj_Parameters['ADR'] = gE(curTab, 'ed_ADR').value;
    obj_Parameters['OKPO'] = gE(curTab, 'ed_OKPO').value;
    obj_Parameters['NRezidCode'] = gE(curTab, 'edNRezidCode').value;
    obj_Parameters['SAB'] = gE(curTab, 'ed_SAB').value;
    obj_Parameters['TOBO'] = gE(curTab, 'ed_TOBOCd').value;
    obj_Parameters['BC'] = ((gE(curTab, 'ckb_BC').checked) ? ('1') : ('0'));

    var mobTelElement = gE(getFrame('Tab3'), 'ed_TELM');

    //if mob. tel is contains *** - it is masked and its value was not changed
	//else = write new value
	if (obj_Parameters['CUSTTYPE'] != 'person') {
		if (mobTelElement && mobTelElement.value.indexOf("*****") == -1) {
		   obj_Parameters['DopRekv_MPNO'] = mobTelElement.value;	
		}
	}
	//if (mobTelElement) {
	//	obj_Parameters['DopRekv_MPNO'] = mobTelElement.value;
	//}

    return true;
}

function Check_RekvNalogoplat() {
    // если пришли с readonly=3, то уходим без проверки
    if (flagROCheck) return true;

    var curTab = getFrame('Tab1');
    var curBut = getEl('bTab1');
    goPage(curBut);
    var doCheck = true;

    if (gE(curTab, 'ckb_main').checked) {

        if (flagEnhCheck) {
            segment = ModuleSettings.Customers.Segm;
            if (custAttrList["SEGM "] != null)
                segment = custAttrList["SEGM "].Value;
            if (segment && segment.charAt(0) == '3') doCheck = false;
            if (isEmpty(gE(curTab, 'ed_RGTAX')) && doCheck) {
                isEmptyCheck(gE(curTab, 'ed_RGTAX'));
                return false;
            }
            if (isEmpty(gE(curTab, 'ed_ADM')) && doCheck) {
                isEmptyCheck(gE(curTab, 'ed_ADM'));
                return false;
            }
            if (isEmpty(gE(curTab, 'ddl_C_DST')) && doCheck) {
                alert("Не заповнений код ПІ.");
                gE(curTab, 'ddl_C_DST').focus();
                return false;
            }
        }

        if (obj_Parameters['CUSTTYPE'] != 'person' && obj_Parameters['TGR'] != '3' && isEmpty(gE(curTab, 'ed_DATET')) && doCheck) {
            isEmptyCheck(gE(curTab, 'ed_DATET'));
            return false;
        }
        if (obj_Parameters['CUSTTYPE'] != 'person' && obj_Parameters['TGR'] != '3' && isEmpty(gE(curTab, 'ed_DATEA')) && doCheck) {
            isEmptyCheck(gE(curTab, 'ed_DATEA'));
            return false;
        }
        else {
            obj_Parameters['C_REG'] = gE(curTab, 'ddl_C_REG').item(gE(curTab, 'ddl_C_REG').selectedIndex).value;
            if (gE(curTab, 'ddl_C_DST').selectedIndex == -1) obj_Parameters['C_DST'] = '';
            else obj_Parameters['C_DST'] = gE(curTab, 'ddl_C_DST').item(gE(curTab, 'ddl_C_DST').selectedIndex).value;
            obj_Parameters['ADM'] = gE(curTab, 'ed_ADM').value;
            obj_Parameters['TAXF'] = gE(curTab, 'ed_TAXF').value;
            obj_Parameters['RGADM'] = gE(curTab, 'ed_RGADM').value;
            obj_Parameters['RGTAX'] = gE(curTab, 'ed_RGTAX').value;
            obj_Parameters['DATET'] = gE(curTab, 'ed_DATET').value;
            obj_Parameters['DATEA'] = gE(curTab, 'ed_DATEA').value;

            return true;
        }
    }
    else {
        obj_Parameters['C_REG'] = '-1';
        obj_Parameters['C_DST'] = '-1';
        obj_Parameters['ADM'] = '';
        obj_Parameters['TAXF'] = '';
        obj_Parameters['RGADM'] = '';
        obj_Parameters['RGTAX'] = '';
        obj_Parameters['DATET'] = '';
        obj_Parameters['DATEA'] = '';

        return true;
    }
}

function Check_EkonomNorm() {
    // если пришли с readonly=3, то уходим без проверки
    if (flagROCheck) return true;

    var curTab = getFrame('Tab2');
    var curBut = getEl('bTab2');
    goPage(curBut);


    if (gE(curTab, 'ckb_main').checked) {

        var curWin = curTab.contentWindow || curTab;
        if (isEmpty(gE(curTab, 'ed_ISE'))) {
            isEmptyCheck(gE(curTab, 'ed_ISE'));
            return false;
        }
        else if (curWin.isFS && isEmpty(gE(curTab, 'ed_FS'))) {
            isEmptyCheck(gE(curTab, 'ed_FS'));
            return false;
        } else if (isEmpty(gE(curTab, 'ed_VED'))) {
            isEmptyCheck(gE(curTab, 'ed_VED'));
            return false;
        } else if (isEmpty(gE(curTab, 'ed_OE'))) {
            isEmptyCheck(gE(curTab, 'ed_OE'));
            return false;
        } else if (isEmpty(gE(curTab, 'ed_K050'))) {
            isEmptyCheck(gE(curTab, 'ed_K050'));
            return false;
        } else if (isEmpty(gE(curTab, 'ed_SED'))) {
            isEmptyCheck(gE(curTab, 'ed_SED'));
            return false;
        } else {
            obj_Parameters['ISE'] = gE(curTab, 'ed_ISE').value;
            if (curWin.isFS) {
                obj_Parameters['FS'] = gE(curTab, 'ed_FS').value;
            }
            obj_Parameters['VED'] = gE(curTab, 'ed_VED').value;
            obj_Parameters['OE'] = gE(curTab, 'ed_OE').value;
            obj_Parameters['K050'] = gE(curTab, 'ed_K050').value;
            obj_Parameters['SED'] = gE(curTab, 'ed_SED').value;

            return true;
        }
    }
    else return true;

}

function getCustAge(birthday) {

    var date = {
        year: birthday.getUTCFullYear(),
        month: birthday.getUTCMonth() + 1,
        day: birthday.getUTCDate()
    };

    var curDate = new Date(),
      now = {
          year: curDate.getUTCFullYear(),
          // UTC month value is zero-based
          month: curDate.getUTCMonth() + 1,
          day: curDate.getUTCDate()
      },
      result = now.year % date.year;

    // Do not update the date unless it is time
    if (now.month < date.month ||
        now.month === date.month && now.day < date.day) {
        result -= 1;
    }

    return result;
}

function toDateConverter(dateStr) {
    var parts = dateStr.split(".");
    return new Date(parts[2], parts[1] - 1, parts[0]);
}

//Підрахунок віку для перевірки вклеювання фото
function calculateAge(birthMonth, birthDay, birthYear) {
    var currentDate = new Date();
    var currentYear = currentDate.getFullYear();
    var currentMonth = currentDate.getMonth();
    var currentDay = currentDate.getDate();
    var calculatedAge = currentYear - birthYear;

    if (currentMonth < birthMonth - 1) {
        calculatedAge--;
    }
    if (birthMonth - 1 == currentMonth && currentDay < birthDay) {
        calculatedAge--;
    }
    return calculatedAge;
}
function Check_ClientRekvPerson() {
    // если пришли с readonly=3, то уходим без проверки
    if (flagROCheck) return true;

    var curTab = getFrame('Tab3');
    var curBut = getEl('bTab3');
    goPage(curBut);
    
    if (gE(curTab, 'ckb_main').checked) {
        var isDocPassport = gE(curTab, 'ddl_PASSP').value === "1";
        var isIDPassport = gE(curTab, 'ddl_PASSP').value === "7";
		var isBirthCertificate = gE(curTab, 'ddl_PASSP').value === "3";

		var isTempDoc = gE(curTab, 'ddl_PASSP').value === "5";

		var toDay = new Date();
        var tmp1 = gE(curTab, 'ed_PDATE').value;
        var PDate = new Date(tmp1.substring(6, 10), parseInt(tmp1.substring(3, 5)) - 1, tmp1.substring(0, 2));

        var tmp2 = gE(curTab, 'ed_BDAY').value;
        var BDay = new Date(tmp2.substring(6, 10), parseInt(tmp2.substring(3, 5)) - 1, tmp2.substring(0, 2));
        var ddlPassp = gE(curTab, 'ddl_PASSP');
        if (ddlPassp.selectedIndex == 0) {
            alert('Необхідно вказати вид документу');
            gE(curTab, 'ddl_PASSP').focus();

            return false;
        }
        if (!isIDPassport && isEmpty(gE(curTab, 'ed_SER'))) {
            isEmptyCheck(gE(curTab, 'ed_SER'));
            return false;
        }
        if (!isIDPassport && isEmpty(gE(curTab, 'ed_NUMDOC'))) {
            isEmptyCheck(gE(curTab, 'ed_NUMDOC'));
            return false;
        }
		if (isIDPassport && isEmpty(gE(curTab, 'ed_ID_Number'))) {
			isEmptyCheck(gE(curTab, 'ed_ID_Number'));
            return false;
		}
		if (isIDPassport && gE(curTab, 'ed_ID_Number').value.length != 9) {
			alert('Довжина номеру паспорта-ID-картки повинна бути строго 9');
			gE(curTab, 'ed_ID_Number').focus();
		}
        if (isIDPassport && isEmpty(gE(curTab, 'ed_ID_RecordNum'))) {
            isEmptyCheck(gE(curTab, 'ed_ID_RecordNum'));
            return false;
        }
        if (isIDPassport && isEmpty(gE(curTab, 'ed_ID_ORGAN'))) {
            isEmptyCheck(gE(curTab, 'ed_ID_ORGAN'));
            return false;
        }
        if (isIDPassport && isEmpty(gE(curTab, 'ed_ID_ReceiveDate'))) {
            isEmptyCheck(gE(curTab, 'ed_ID_ReceiveDate'));
            return false;
        }
        if (isIDPassport && isEmpty(gE(curTab, 'ed_ID_ExpireDate'))) {
            isEmptyCheck(gE(curTab, 'ed_ID_ExpireDate'));
            return false;
        }
        //перевірка довжини номера паспорта
        if (ddlPassp.options[ddlPassp.selectedIndex].value == 1 &&
            (gE(curTab, 'ed_SER').value.length != 2 || gE(curTab, 'ed_NUMDOC').value.length != 6)) {
            alert('Невірно заповнено паспортні дані');
            return false;
        }
        if (!isIDPassport && isEmpty(gE(curTab, 'ed_ORGAN'))) {
            isEmptyCheck(gE(curTab, 'ed_ORGAN'));
            return false;
        }
        var organ = gE(curTab, 'ed_ORGAN').value;
        if (isDocPassport && (organ.length < 10 || !/^[0-9а-яА-Яа-яА-ЯіІїЇєЄ]{0,1}[0-9а-яА-Яа-яА-ЯіІїЇєЄ\-\`\'\.\s]{1,255}$/.test(organ.toUpperCase()))) {
            alert('Орган, що видав паспорт має містити не менше 10 символів кирилиці.');
            gE(curTab, 'ed_ORGAN').focus();
            return false;
        }
        if (!isIDPassport && isEmpty(gE(curTab, 'ed_PDATE'))) {
            isEmptyCheck(gE(curTab, 'ed_PDATE'));
            return false;
        }
		// свидетельство о рождении
		if(isBirthCertificate){
			if (CheckSeriaBirthCertificate(curTab) != true) {
	            alert('Невірний формат серії свідоцтва про народження.\nКоректні приклади: I-КГ, XIV-РН, MCI-АА');
	            gE(curTab, 'ed_SER').focus();
	            return false;
	        }
	        else if (CheckNumberBirthCertificate(curTab) != true) {
	            alert('Номер свідоцтва про народження не повинен перевищувати 6 цифр');
	            gE(curTab, 'ed_NUMDOC').focus();
	            return false;
	        }
		}
        // ID картка проверки
        if (isIDPassport) {
            var receiveDateStr = gE(curTab, 'ed_ID_ReceiveDate').value;
            var receiveDate = new Date(receiveDateStr.substring(6, 10), parseInt(receiveDateStr.substring(3, 5)) - 1, receiveDateStr.substring(0, 2));
            var expireDateStr = gE(curTab, 'ed_ID_ExpireDate').value;
            var expireDate = new Date(expireDateStr.substring(6, 10), parseInt(expireDateStr.substring(3, 5)) - 1, expireDateStr.substring(0, 2));
            var birthDateStr = gE(curTab, 'ed_BDAY').value;
            var birthDate = new Date(birthDateStr.substring(6, 10), parseInt(birthDateStr.substring(3, 5)) - 1, birthDateStr.substring(0, 2));
            var strRecNum = gE(curTab, 'ed_ID_RecordNum').value;

            birthDate.setMinutes(birthDate.getMinutes() + 1200);
            if (receiveDate > toDay) {
                alert(LocalizedString('Mes03') /*"Дата привышает допустимую"*/);
                gE(curTab, 'ed_ID_ReceiveDate').focus();
                return false;
            }
            if (receiveDate > expireDate) {
                alert("Дата [Дійсний до] не повинна бути менша дати видачі");
                gE(curTab, 'ed_ID_ExpireDate').focus();
                return false;
            }
            var diff = Math.ceil((expireDate - toDay) / (1000 * 60 * 60 * 24));
            if (diff < 0) {
                alert("Дата [Дійсний до] не може бути менша поточної дати");
                gE(curTab, 'ed_ID_ExpireDate').focus();
                return false;
            }
            if (expireDate >= receiveDate.setMonth(receiveDate.getMonth() + 121)) {
                alert("Дата [Дійсний до] не повинна бути більша 121 місяця від дати видачі");
                gE(curTab, 'ed_ID_ExpireDate').focus();
                return false;
            }
            if (gE(curTab, 'ed_ID_ORGAN').value.length < 4) {
                alert("Поле [Орган, що видав] має містити 4 символи");
                gE(curTab, 'ed_ID_ORGAN').focus();
                return false;
            }
            if (getCustAge(birthDate) < 14) {
                alert("Паспорт ID-картка видається з 14 років");
                gE(curTab, 'ed_BDAY').focus();
                return false;
            }

            // Перевірка Номера запису в ЄДДР для Паспорта ID-картки
            // Аналогічна перевірка продубльована в JScriptFortab_client_rekv_person.js -> ValidateIDRecordNum()

            if (!strRecNum) {
                alert('«Унік.номер запису в ЄДДР» необхідно заповнити');
                gE(curTab, 'ed_ID_RecordNum').focus();
                return false;
            }
            if (strRecNum.length != 14 && strRecNum) {
                alert('«Унік.номер запису в ЄДДР» має бути довжиною в 14 символів');
                gE(curTab, 'ed_ID_RecordNum').focus();
                return false;
            }
            var bIsRecNumValid = true;
            var iSerNum = parseInt(strRecNum.substr(9, 4), 10);
            var strSEX = gE(curTab, 'ddl_SEX').selectedIndex;
            if ((strSEX == '2' && iSerNum % 2 != 0) ||
                (strSEX == '1' && iSerNum % 2 == 0) ||
                (iSerNum == 0)) {
                bIsRecNumValid = false;
            }
            if (strRecNum.substr(0, 4) != birthDateStr.substr(6, 4) ||
                     strRecNum.substr(4, 2) != birthDateStr.substr(3, 2) ||
                     strRecNum.substr(6, 2) != birthDateStr.substr(0, 2)) {
                bIsRecNumValid = false;
            }
            if (!bIsRecNumValid) {
                var ddlSex = gE(curTab, 'ddl_SEX');
                var sex = ddlSex.options[ddlSex.selectedIndex].text;
                var newRecNum = prompt('«Унік. номер запису в ЄДДР» не відповідає даті народження (' + birthDateStr + ') або статі (' + sex + ') клієнта. Підтвердіть «Унік. номер запису в ЄДДР»:', '');
                if (newRecNum) {
                    if (newRecNum != strRecNum) {
                        alert('«Унік. номер запису в ЄДДР» не співпадає з введеним раніше \n<' + newRecNum + '>\n<' + strRecNum + '>');
                    } else {
                        bIsRecNumValid = true;
                    }
                }
                if (!bIsRecNumValid) {
                    gE(curTab, 'ed_ID_RecordNum').focus();
                    return bIsRecNumValid;
                }
            }
		}

        if (isDocPassport && isEmpty(gE(curTab, 'ed_DATE_PHOTO'))) {
			alert('"Дата вклеювання фото" не заповнена');
			//isEmptyCheck(gE(curTab, 'ed_DATE_PHOTO'));
			gE(curTab, 'ed_DATE_PHOTO').focus();
			return false;
		}
		
		var birthDateStr = gE(curTab, 'ed_BDAY').value;
		var photoPutDate = gE(curTab, 'ed_DATE_PHOTO').value;
		var getPassDate = gE(curTab, 'ed_PDATE').value;

		var t = birthDateStr.split(".");
		var birthDateYearsSpend = calculateAge(t[0], t[1], t[2]);
		var bDate = new Date(t[2], t[1] - 1, t[0]);
		var t = photoPutDate.split(".");
		var photoDateYearsSpend = calculateAge(t[0], t[1], t[2]);
		var pDate = new Date(t[2], t[1] - 1, t[0]);
		var t = getPassDate.split(".");
		var gDate = new Date(t[2], t[1] - 1, t[0]);

		if (!isIDPassport && !isTempDoc && gDate > pDate) {
			alert("Дата Видачі не може бути більше чим вклеювання");
			return false;
		}

		var currDate = new Date();
		if (!isIDPassport && !isTempDoc && pDate > currDate) {
			alert("Дата Вклеювання не може бути більшою ніж поточна дата");
			return false;
		}


		if (!isIDPassport && !isTempDoc && getCustAge(bDate) > 24) {
			bDate.setFullYear(bDate.getFullYear() + 25);
			if (bDate < currDate)
				if (bDate > pDate) {
					alert('Клієнт потребує вклеювання нового фото. Дата вклеювання застаріла (Виповнилось 25 років)');
					return false;
				} else {
					bDate.setFullYear(bDate.getFullYear() + 20);
					if (bDate < currDate)
						if (bDate > pDate) {
							alert('Клієнт потребує вклеювання нового фото. Дата вклеювання застаріла (Виповнилось 45 років)');
							return false;
						}
				}
		}


        if (gE(getFrame('Tab4'), 'ed_ISP').value.length < 1) {
            alert('Поле "Менеджер клієнту (код)" не заповнене');
            return false;
        }

        if (PDate > toDay) {
            alert(LocalizedString('Mes03')/*"Дата привышает допустимую"*/);
            gE(curTab, 'ed_PDATE').focus();
            return false;
        }
        if (isEmpty(gE(curTab, 'ed_BDAY'))) {
            isEmptyCheck(gE(curTab, 'ed_BDAY'));
            return false;
        }
        if (BDay > toDay) {
            alert(LocalizedString('Mes03')/*"Дата привышает допустимую"*/);
            gE(curTab, 'ed_BDAY').focus();
            return false;
        }
        if (gE(curTab, 'ddl_SEX').selectedIndex < 0) {
            alert('Необхідно вказати стать');
            gE(curTab, 'ddl_SEX').focus();
            return false;
        }
        if (obj_Parameters['CUSTTYPE'] == 'person' && !gE(curTab, 'notUseTelm').checked) {
            if (!Check_ClientRekvPhone(false))
                return false;
        }

        obj_Parameters['PASSP'] = gE(curTab, 'ddl_PASSP').item(gE(curTab, 'ddl_PASSP').selectedIndex).value;
        if (isIDPassport) {
            obj_Parameters['NUMDOC'] = gE(curTab, 'ed_ID_Number').value;
            obj_Parameters['EDDR_ID'] = gE(curTab, 'ed_ID_RecordNum').value;
            obj_Parameters['ORGAN'] = gE(curTab, 'ed_ID_ORGAN').value;
            obj_Parameters['PDATE'] = gE(curTab, 'ed_ID_ReceiveDate').value;
            obj_Parameters['ACTUAL_DATE'] = gE(curTab, 'ed_ID_ExpireDate').value;
        } else {
            obj_Parameters['SER'] = gE(curTab, 'ed_SER').value;
            obj_Parameters['NUMDOC'] = gE(curTab, 'ed_NUMDOC').value;
            obj_Parameters['ORGAN'] = gE(curTab, 'ed_ORGAN').value;
            obj_Parameters['PDATE'] = gE(curTab, 'ed_PDATE').value;
        }
        obj_Parameters['BDAY'] = gE(curTab, 'ed_BDAY').value;
        obj_Parameters['DATE_PHOTO'] = gE(curTab, 'ed_DATE_PHOTO').value;
        obj_Parameters['BPLACE'] = gE(curTab, 'ed_BPLACE').value;
        obj_Parameters['SEX'] = gE(curTab, 'ddl_SEX').item(gE(curTab, 'ddl_SEX').selectedIndex).value;
        var curWin = curTab.contentWindow || curTab;
        if (curWin.fullDomPhone) {
            obj_Parameters['TELD'] = '+380' + gE(curTab, 'ed_TELD_CODE').value + gE(curTab, 'ed_TELD').value;
            if (obj_Parameters['TELD'] === '+380') {
                obj_Parameters['TELD'] = '';
            }
        } else {
            obj_Parameters['TELD'] = gE(curTab, 'ed_TELD').value;
        }
        obj_Parameters['TELW'] = gE(curTab, 'ed_TELW').value;
        return true;
    }
    else return true;
}

function Check_ClientRekvPhone(ignoreConfirmation) {
    var validPhone = validatePhone(ignoreConfirmation);
    if (validPhone.Status != 'ok') {
        if (validPhone.Status == 'duplSimbMobPhone') {
            var text = 'Я, ' + userFio + ', підтверджую наявність номеру мобільного телефону у клієнта, ' +
                        'що складається з однакових цифр. ' +
                        'Не заперечую проти перевірки Банком достовірності наданої мною інформації.' +
                        'Мені відомо, що подання недостовірної інформації тягне за собою ' +
                        'відповідальність (дисциплінарні стягнення та інше) згідно з чинним законодавством України';
            var status = confirm(text);
            if (!status) {
                return false;
            } else {
                //для фіз осіб не спд виконуємо валідацію мобільного телефону
                if (obj_Parameters['CUSTTYPE'] === 'person' && !isCustomerSpd()) {
                    var validationResult = ExecSync('ValidateMobilePhone', { rnk: (obj_Parameters['ID'] == '' ? 0 : obj_Parameters['ID']), phoneOkpo: validPhone.Phone + "&" + obj_Parameters["OKPO"] }).d;

                    if (!validationResult) {
                        alert('Необроблена помилка перевірки № тел. в ValidateMobilePhone');
                        return false;
                    }
                    if (validationResult.Code != 'OK') {
                        alert(validationResult.Text);
                        return false;
                    }
                }
            }
        } else {
            alert(validPhone.Message);
            return false;
        }
    }
    return true;
}

function Check_ClientRekvCorp() {    
    var curTab = getFrame('Tab3');
    var curBut = getEl('bTab3');
    goPage(curBut);

    if (flagEnhCheck) {
        if (isEmpty(gE(curTab, 'ed_RUK'))) {
            isEmptyCheck(gE(curTab, 'ed_RUK'));
            return false;
        }

        if (!Check_RekvLinkCusts())
            return false;
    }

    obj_Parameters['NMKU'] = gE(curTab, 'ed_NMKU').value;
    obj_Parameters['E_MAIL'] = gE(curTab, 'ed_E_MAIL').value;
    obj_Parameters['TEL_FAX'] = gE(curTab, 'ed_TEL_FAX').value;
    obj_Parameters['SEAL_ID'] = gE(curTab, 'ed_SEAL_ID').value;
    obj_Parameters['RUK'] = gE(curTab, 'ed_RUK').value;
    obj_Parameters['BUH'] = gE(curTab, 'ed_BUH').value;
    obj_Parameters['TELR'] = gE(curTab, 'ed_TELR').value;
    obj_Parameters['TELB'] = gE(curTab, 'ed_TELB').value;

    var fullACCS = "";
    var curWin = curTab.contentWindow || curTab;
    var MyGrd = curWin.igtbl_getGridById('grdACCS');
    var MyRows = MyGrd.Rows;
    var ColsCount = MyGrd.Bands[0].Columns.length;

    for (i = 0; i < MyRows.length; i++) {
        fullACCS += ((fullACCS != "") ? (";") : (""));
        var MyRow = MyRows.getRow(i);
        var RowText = '';

        for (j = 0; j < ColsCount; j++) {
            var tmp = MyRows.getRow(i).getCell(j).getValue();
            RowText += ((RowText != "") ? (",") : ("")) + ((tmp == null) ? (' ') : (tmp.toString().replace(';', '!1').replace(',', '!2')));
        }

        fullACCS += RowText;
    }
    obj_Parameters['fullACCS'] = fullACCS;

    return true;
}

function Check_ClientRekvBank() {
    var curTab = getFrame('Tab3');
    var curBut = getEl('bTab3');
    goPage(curBut);

    var tmp = gE(curTab, 'lb_title_bank').innerText;
    var etalon = LocalizedString('Mes04'); //"Наименование банка не найдено!!!";
    var rezid;
    var MainRekvTab = getFrame('Tab0');

    if (MainRekvTab != null)
        if (gE(MainRekvTab, 'ddl_CODCAGENT').selectedIndex != -1)
            rezid = gE(MainRekvTab, 'ddl_CODCAGENT').item(gE(MainRekvTab, 'ddl_CODCAGENT').selectedIndex).value.substr(0, 1);

    var dis = (rezid == '2');

    if ((tmp == etalon || tmp == '') && !dis) {
        alert(LocalizedString('Mes05')/*"Неправильно заполнено поле 'Код банка - МФО'"*/);
        gE(curTab, 'ed_MFO').focus();
        return false;
    }
    else {
        obj_Parameters['RATING'] = gE(curTab, 'ed_RATING').value;
        obj_Parameters['MFO'] = gE(curTab, 'ed_MFO').value;
        obj_Parameters['ALT_BIC'] = gE(curTab, 'ed_ALT_BIC').value;
        obj_Parameters['BIC'] = gE(curTab, 'ed_BIC').value;
        obj_Parameters['KOD_B'] = gE(curTab, 'ed_KOD_B').value;
        obj_Parameters['RUK'] = gE(curTab, 'ed_RUK').value;
        obj_Parameters['BUH'] = gE(curTab, 'ed_BUH').value;
        obj_Parameters['TELR'] = gE(curTab, 'ed_TELR').value;
        obj_Parameters['TELB'] = gE(curTab, 'ed_TELB').value;

        return true;
    }
}

function Check_DopInf() {
    var curTab = getFrame('Tab4');
    var curBut = getEl('bTab4');
    goPage(curBut);

    obj_Parameters['ISP'] = gE(curTab, 'ed_ISP').value;
    obj_Parameters['NOTES'] = gE(curTab, 'ed_NOTES').value;
    obj_Parameters['CRISK'] = gE(curTab, 'ddl_CRISK').item(gE(curTab, 'ddl_CRISK').selectedIndex).value;
    obj_Parameters['MB'] = gE(curTab, 'ddl_MB').item(gE(curTab, 'ddl_MB').selectedIndex).value;
    obj_Parameters['ADR_ALT'] = gE(curTab, 'ed_ADR_ALT').value;
    obj_Parameters['NOM_DOG'] = gE(curTab, 'ed_NOM_DOG').value;
    obj_Parameters['LIM_KASS'] = gE(curTab, 'ed_LIM_KASS').value;
    obj_Parameters['LIM'] = gE(curTab, 'ed_LIM').value;
    obj_Parameters['RNKP'] = gE(curTab, 'ed_RNKP').value;
    obj_Parameters['NOTESEC'] = gE(curTab, 'ed_NOTESEC').value;
    obj_Parameters['NOMPDV'] = gE(curTab, 'ed_NOMPDV').value;
    // перевірки для ІПН (COBUMMFO-7835)
    if (obj_Parameters['NOMPDV'].trim() != '') {
        if (obj_Parameters['CUSTTYPE'] === 'person') {
            if (obj_Parameters['NOMPDV'] !== valOKPO) {
                alert('Ідн. податковий номер має співпадати з ідентифікаційним кодом. Введіть ІПН повторно.');
                return false;
            }
        }
        else {
            if (obj_Parameters['NOMPDV'].slice(0, 7) !== valOKPO.slice(0, 7)) {
                alert('Ідн. податковий номер має відповідати ідентифікаційному коду. Введіть ІПН повторно.');
                return false;
            }
            if (obj_Parameters['NOMPDV'].length != 12) {
                alert('Довжина Ідн. податкового номера для ЮО має бути 12 символів. Введіть ІПН повторно.');
                return false;
            }
        }
    }
    return true;
}
function Check_DopReqv() {
    var curTab = getFrame('Tab5');
    var curBut = getEl('bTab5');
    goPage(curBut);

    var checkReqv = gE(curTab, "chCheckReq").checked;
    if (!checkReqv) return true;

    function _isNotEmpty(val) { return !(val == null || val == ' ' || val == 'null' || val == '' || val == '&nbsp' || val == '&nbsp;' || val == '01/01/0001'); }

    var prefix = "gvMain_ctl";
    var i = 2;
    var name = prefix + "0" + i + "_edEdVal";
    while (d = gE(curTab, name)) {
        if (d.getAttribute("OPT") == "1" && d.value == "") {
            alert("Не заповнений обов`язковий реквізит!");
            d.focus();
            return false;
        } else if ($(d).attr("tag") === "SN_GC") {
            //дополнительная проверка "ПІБ клієнта в родовому відмінку"
            if (d.value && d.value.trim() !== "") {
                if (/^(.)\1+$/.test(d.value.toUpperCase()) || d.value.length < 3) {
                    alert("Довжина ПІБ клієнта в родовому відмінку повинен бути не менше 3-х неоднакових символів.");
                    d.focus();
                    return false;
                }
                var characteristics = gE(getFrame('Tab0'), 'ddl_CODCAGENT').value;
                if (characteristics) {
                    if (!/^[а-яА-Яа-яА-ЯіІїЇєЄ]{0,1}[а-яА-Яа-яА-ЯіІїЇєЄ\-\`\'\s]{1,69}$/.test(d.value)) {
                        alert("ПІБ клієнта в родовому відмінку повинен складатись тільки із символів кирилиці.");
                        d.focus();
                        return false;
                    }
                }
            }
        }
        else if($(d).attr("tag") === "DTDIE"){
            var DEATH_ = $("#Tab5").contents().find("input[tag='DEATH']").val();
            if(!_isNotEmpty(d.value) && _isNotEmpty(DEATH_)){
                bars.ui.error({ title: 'Попередження', text: 'Не заповнено: <strong>Дата настання смерті клієнта</strong>'});
                d.focus();
                return false;
            }
        }
        else if($(d).attr("tag") === "DEATH"){
            var DTDIE_ = $("#Tab5").contents().find("input[tag='DTDIE']").val();
            if(!_isNotEmpty(d.value) && _isNotEmpty(DTDIE_)){
                bars.ui.error({ title: 'Попередження', text: 'Не заповнено: <strong>Настання смерті клієнта</strong>'});
                d.focus();
                return false;
            }
        }
        i++;
        name = prefix;
        if (i <= 9)
            name += "0";
        name += i + "_edEdVal";
    }

    //проверка емайла 
    var email = $("#Tab5").contents().find("input[tag='EMAIL']").val();
    if (email && !/^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i.test(email)) {
        alert("Адресу електронної пошти введено невірно.");
        return false;
    }

    if (flagEnhCheck && obj_Parameters['EditType'] == 'Reg') {
        var fm = gE(curTab, "hCheckFM").value;
        if (fm && fm <= 0 && getArray(custRiskList).length <= 0) {
            //return confirm("Попередження:\nНе заповнено критерії ризику. Продовжити збереження ?");
            alert('Попередження:\nНе заповнено критерії ризику. ');
            return false;
        }
    }
    return true;
}

function Check_RekvLinkCusts() {
    if (obj_Parameters['CUSTTYPE'] == 'corp' && obj_Parameters['EditType'] == 'ReReg') {
        var curTab = getFrame('Tab6');
        var curBut = getEl('bTab6');
        var grid = gE(curTab, "ctl00_body_gvCustRelations");
        var ch = gE(curTab, "cbCheckLink");
        var div = gE(curTab, "dvCheckLink");
        if (div) { div.style.position = "static"; div.style.visibility = "visible"; }
        var flag = (ch && ch.checked);
        if (!grid && flag) {
            alert("Для юридичної особи потрібно вказати довірену особу.");
            goPage(curBut);
            return false;
        }
    }
    return true;
}

function Check_DopReqvValue(tag, tabname, value) {
    var input = new Object;
    input.tag = tag;
    input.tabname = tabname;
    input.value = value;
    var res = ExecSync('CheckSPValue', { tag: tag, tabname: tabname, value: value }).d; // GetWebServiceData("CheckSPValue", input, 0);
    if (res) {
        return true;
    }
    else
        return false;
}

// валидация данных клиента и регистрация
function ValidateClient() {
    var curTab = getFrame('Tab0');

    var client = {};
    client.NMK = gE(curTab, 'ed_NMK').value;
    client.NMKV = gE(curTab, 'ed_NMKV').value;
    client.NMKK = gE(curTab, 'ed_NMKK').value;

    var ValidationResult = ExecSync('ValidateClient', { cl: client }).d;

    switch (ValidationResult.Code) {
        case 'OK':
            return true;
            break;
        case 'ALERT':
            return confirm(ValidationResult.Text);
            return true;
            break;
        case 'ERROR':
            return false;
            break;
    }
}

function getArray(associativeArray) {
    var array = new Array();
    for (key in associativeArray) {
        if (!associativeArray.hasOwnProperty(key)) continue;
        array.push(associativeArray[key]);
    }
    return array;
}

function Register() {
    locked = false;

	
    if (validate()) {
        var ClientRekv;
        if (obj_Parameters['CUSTTYPE'] == 'person') ClientRekv = Check_ClientRekvPerson();
        else if (obj_Parameters['CUSTTYPE'] == 'corp') ClientRekv = Check_ClientRekvCorp();
		else if (obj_Parameters['CUSTTYPE'] == 'bank') ClientRekv = Check_ClientRekvBank();

        if (ClientRekv && Check_DopInf() && ValidateClient()) {
            var msg = '';
            if (obj_Parameters['EditType'] == 'Reg') {
                msg = 'Зареєструвати клієнта?'; //escape(LocalizedString('Mes06')/*'Зарегистрировать клиента?'*/);
                var PublicFlagMessage;
                if (obj_Parameters['CUSTTYPE'] == 'person') {
                    PublicFlagMessage = GetPublicFlag(obj_Parameters['NMK']);
                    if (PublicFlagMessage != '') {
                        alert(PublicFlagMessage);
                    }
                }
            } else if (obj_Parameters['EditType'] == 'ReReg')
                msg = 'Перереєструвати клієнта' + ' rnk = ' + obj_Parameters['ID'] + ' ?'; //escape(LocalizedString('Mes07')/*'Перерегистрировать клиента'*/ + ' rnk = ' + obj_Parameters['ID'] + ' ?');
            else
                msg = 'Перереєструвати клієнта' + ' rnk = ' + obj_Parameters['ID'] + ' ?'; //escape(LocalizedString('Mes07')/*'Перерегистрировать клиента'*/ + ' rnk = ' + obj_Parameters['ID'] + ' ?');
            bars.ui.confirm({
                text: msg, func: function () {
                    saveCustomerToBase();
                }
            });
        }
    }
}

function saveCustomerToBase() {

    if (!custAttrList['MPNO']) {
        var clientRekvTab = getFrame('Tab3');
        var mobPhone = gE(clientRekvTab, 'ed_TELM') != undefined ? gE(clientRekvTab, 'ed_TELM').value : undefined;

        //if mobile phone is masked - it was not changed and obj_Parameters['DopRekv_MPNO'] contains initial value
        //custtype 1 and 2 doenst have mob phone...
		if (obj_Parameters['CUSTTYPE'] === 'person') {
			if (mobPhone.indexOf("*****") !== -1) {
				mobPhone = obj_Parameters['DopRekv_MPNO'];
			}
		}

        if (mobPhone) {
            custAttrList['MPNO'] = {
                Isp: "0",
                Tag: "MPNO",
                Value: mobPhone
            }
        }
    }
    var custAttrCheck = gE(getFrame('Tab5'), "chCheckReq").checked;
    bars.ui.loader('body', true);
    var registerResult = ExecSync('Register', {
        EditType: obj_Parameters['EditType'],
        ReadOnly: obj_Parameters['ReadOnly'],
        BANKDATE: obj_Parameters['BANKDATE'],
        Par_EN: obj_Parameters['Par_EN'],
        CUSTTYPE: obj_Parameters['CUSTTYPE'],
        DATE_ON: obj_Parameters['DATE_ON'],
        DATE_OFF: obj_Parameters['DATE_OFF'],
        ID: obj_Parameters['ID'],
        ND: obj_Parameters['ND'],
        NMK: obj_Parameters['NMK'],
        NMKV: obj_Parameters['NMKV'],
        NMKK: obj_Parameters['NMKK'],
        ADR: obj_Parameters['ADR'],
        fullADR: JSON.stringify(obj_Parameters['fullADR']),
        fullADRMORE: obj_Parameters['fullADRMORE'],
        CODCAGENT: obj_Parameters['CODCAGENT'],
        COUNTRY: obj_Parameters['COUNTRY'],
        PRINSIDER: obj_Parameters['PRINSIDER'],
        TGR: obj_Parameters['TGR'],
        STMT: obj_Parameters['STMT'],
        OKPO: obj_Parameters['OKPO'],
        SAB: obj_Parameters['SAB'],
        BC: obj_Parameters['BC'],
        TOBO: obj_Parameters['TOBO'],
        PINCODE: obj_Parameters['PINCODE'],
        RNlPres: obj_Parameters['RNlPres'],
        C_REG: obj_Parameters['C_REG'],
        C_DST: obj_Parameters['C_DST'],
        ADM: obj_Parameters['ADM'],
        TAXF: obj_Parameters['TAXF'],
        RGADM: obj_Parameters['RGADM'],
        RGTAX: obj_Parameters['RGTAX'],
        DATET: obj_Parameters['DATET'],
        DATEA: obj_Parameters['DATEA'],
        NEkPres: obj_Parameters['NEkPres'],
        ISE: obj_Parameters['ISE'],
        FS: obj_Parameters['FS'],
        VED: obj_Parameters['VED'],
        OE: obj_Parameters['OE'],
        K050: obj_Parameters['K050'],
        SED: obj_Parameters['SED'],
        MFO: obj_Parameters['MFO'],
        ALT_BIC: obj_Parameters['ALT_BIC'],
        BIC: obj_Parameters['BIC'],
        RATING: obj_Parameters['RATING'],
        KOD_B: obj_Parameters['KOD_B'],
        DAT_ND: obj_Parameters['DAT_ND'],
        NUM_ND: obj_Parameters['NUM_ND'],
        RUK: obj_Parameters['RUK'],
        BUH: obj_Parameters['BUH'],
        TELR: obj_Parameters['TELR'],
        TELB: obj_Parameters['TELB'],
        NMKU: obj_Parameters['NMKU'],
        fullACCS: obj_Parameters['fullACCS'],
        E_MAIL: obj_Parameters['E_MAIL'],
        TEL_FAX: obj_Parameters['TEL_FAX'],
        SEAL_ID: obj_Parameters['SEAL_ID'],
        RCFlPres: obj_Parameters['RCFlPres'],
        PASSP: obj_Parameters['PASSP'],
        SER: obj_Parameters['SER'],
        NUMDOC: obj_Parameters['NUMDOC'],
        ORGAN: obj_Parameters['ORGAN'],
        PDATE: obj_Parameters['PDATE'],
        BDAY: obj_Parameters['BDAY'],
        DATE_PHOTO: obj_Parameters['DATE_PHOTO'],
        BPLACE: obj_Parameters['BPLACE'],
        SEX: obj_Parameters['SEX'],
        TELD: obj_Parameters['TELD'],
        TELW: obj_Parameters['TELW'],
        ACTUAL_DATE: obj_Parameters['ACTUAL_DATE'],
        EDDR_ID: obj_Parameters['EDDR_ID'],
        ISP: obj_Parameters['ISP'],
        NOTES: obj_Parameters['NOTES'],
        CRISK: obj_Parameters['CRISK'],
        MB: obj_Parameters['MB'],
        ADR_ALT: obj_Parameters['ADR_ALT'],
        NOM_DOG: obj_Parameters['NOM_DOG'],
        LIM_KASS: obj_Parameters['LIM_KASS'],
        LIM: obj_Parameters['LIM'],
        NOMPDV: obj_Parameters['NOMPDV'],
        RNKP: obj_Parameters['RNKP'],
        NOTESEC: obj_Parameters['NOTESEC'],
        TrustEE: obj_Parameters['TrustEE'],
        nRezidCode: obj_Parameters['NRezidCode'],
        DopRekv: obj_Parameters['DopRekv'],
        Kf: obj_Parameters['Kf'],
        custAttrCheck: custAttrCheck,
        isOkpoExclusion: isOkpoExclusion,
        custAttrList: getArray(custAttrList),
        custRiskList: getArray(custRiskList),
        custReptList: getArray(custReptList),
        custCatsList: getArray(custCatsList),
        photoType: g_PhotoType
    }).d;
    bars.ui.loader('body', false);
    if (registerResult) {
        bars.ui.alert({
            text: registerResult.ResultText,
            close: function () {
                if (registerResult.Status === "OK" || registerResult.Status === "TOBECONFIRMED") {

                    LoadPhoto(PHOTO_DIRECTION_ALL);        // load photo from DB

                    if (CacParams.UseCdmValidation && obj_Parameters['CUSTTYPE'] !== 'bank') {
                        var person = null;
                        if (obj_Parameters['CUSTTYPE'] === 'person') {
                            person = ($.trim(obj_Parameters['SED']) != '91') ? ('Individual') : ('PrivateEn');
                        }
                        else if (obj_Parameters['CUSTTYPE'] === 'corp')
                            person = 'Legal';
                        validateByCsb(registerResult.Rnk, person);
                    } else {
                        var rO = "";
                        if (obj_Parameters['ReadOnlyMode']) {
                            rO = "readonly=" + obj_Parameters['ReadOnlyMode'] + "&";
                        }
                        location.replace('/barsroot/clientregister/registration.aspx?' + rO + 'rnk=' + registerResult.Rnk);
                    }
                }
            }
        });
    }
}

function validateByCsb(rnk, person) {
    var result = false;
    bars.ui.loader('body', true);
    $.ajax({
        type: 'PUT',
        url: bars.config.urlContent('/api/cdm/CsbValidate' + person + '/') + '?id=' + rnk,
        async: true,
        complete: function () {
            bars.ui.loader('body', false);
            location.reload(true);
        },
        //data: {id: rnk} /*getCustomerToCsbData()*/,
        error: function (response) {
            var message = response.responseJSON.ExceptionMessage  + '<br> <b>Дані будуть відправлені до ЄБК у режимі offline.</b><br/>';
            bars.ui.alert({
                text: message,
                close: function () {
                    var rO = "";
                    if (obj_Parameters['ReadOnlyMode'])
                        rO = "readonly=" + obj_Parameters['ReadOnlyMode'] + "&";
                    location.replace('/barsroot/clientregister/registration.aspx?' + rO + 'rnk=' + rnk);
                }
            });
        },
        success: function (response) {
            if (response.Status === 'Error') {
                if (response.Data && (response.Data.checks && response.Data.checks.length > 0 || response.Data.dupes && response.Data.dupes.Duplicate && response.Data.dupes.Duplicate.length > 0)) {
                    showCsbValidationStatus(rnk, response);
                } else {
                    bars.ui.alert({
                        text: response.Message,
                        close: function () {
                            var rO = "";
                            if (obj_Parameters['ReadOnlyMode'])
                                rO = "readonly=" + obj_Parameters['ReadOnlyMode'] + "&";
                            location.replace('/barsroot/clientregister/registration.aspx?' + rO + 'rnk=' + rnk);
                        }
                    });
                }
            } else {
                bars.ui.alert({
                    text: response.Message,
                    close: function () {
                        var rO = "";
                        if (obj_Parameters['ReadOnlyMode'])
                            rO = "readonly=" + obj_Parameters['ReadOnlyMode'] + "&";
                        location.replace('/barsroot/clientregister/registration.aspx?' + rO + 'rnk=' + rnk);
                    }
                });
            }

        }
    });
    return result;
}

var csbValidateCustonrData;
function showCsbValidationStatus(rnk, data) {
    var closeFunction = function () {
        var rO = "";
        if (obj_Parameters['ReadOnlyMode'])
            rO = "readonly=" + obj_Parameters['ReadOnlyMode'] + "&";
        location.replace('/barsroot/clientregister/registration.aspx?' + rO + 'rnk=' + rnk);
    }

    var text = '<b>Не вдалося відправити дані в режимі онлайн</b><br><br>' + data.Message + '<br><br>Статус: ' + data.Data.status + '<br>';
    text += '<ul>';
    csbValidateCustonrData = data.Data.checks;
    for (var i = 0; i < data.Data.checks.length; i++) {
        var recomend = data.Data.checks[i];
        var errorValue = recomend.Value ? ' : ' + recomend.Value : ' ';
        var recomendValue = recomend.RecommendValue ? recomend.RecommendValue : ' ';
        text += '<li>';
        text += 'Значення параметра <b>' + (recomend.NameDescription || recomend.Name) + errorValue + '</b> введено з помилкою <br/>';
        text += 'Рекомендоване значення: <b>' + recomendValue + '</b> ';
        text += '<button class="k-button" onclick="showRcomendDetail(' + i + ')"><i class="pf-icon pf-16 pf-info"></i></button>';
        text += '</li>';
    }
    text += '<br><b>Дані будуть відправлені до ЄБК у режимі offline.<b>';
    text += '</ul>';
    var dupes = data.Data.dupes;
    if (dupes && dupes.Duplicate && dupes.Duplicate.length > 0) {
        text += 'Знайдено дублікатів ' + dupes.Duplicate.length;
        text += '<ul id="duplicates">';
        for (i = 0; i < dupes.Duplicate.length; i++) {
            text += '<li>';
            text += 'МФО: ' + dupes.Duplicate[i].Kf + ',  ' + 'РНК: ' + dupes.Duplicate[i].Rnk;
            text += '</li>';
        }
    }
    text += '</ul>';

    if (data.Data.status === "CONFIRMED") {
        bars.ui.success({
            text: text,
            close: closeFunction,
            width: 500,
            height: 350
        });
    } else {
        bars.ui.alert({
            text: text,
            close: closeFunction,
            width: 500,
            height: 350
        });
    }
}

function showRcomendDetail(item) {
    bars.ui.alert({ text: csbValidateCustonrData[item].Descr });
}

function getDopRekvParam(name) {
    var dopRekv = custAttrList[name];
    if (dopRekv) {
        return custAttrList[name].Value;
    }
    return null;
}
function getUrAdr() {
    if (obj_Parameters['fullADR'] && obj_Parameters['fullADR'].type1) {
        return obj_Parameters['fullADR'].type1;
    }
    return {};
}

function getCustomerToCsbData() {
    var urAdr = getUrAdr();
    var result = {
        Kf: obj_Parameters['TOBO'].split('/')[1],
        Rnk: obj_Parameters['ID'],
        DateOn: obj_Parameters['DATE_ON'],
        DateOff: obj_Parameters['DATE_OFF'],
        Nmk: obj_Parameters['NMK'],
        //Прізвище клієнта
        SnLn: getDopRekvParam('SN_LN'),
        //Ім'я
        SnFn: getDopRekvParam('SN_FN'),
        //По-батькові
        SnMn: getDopRekvParam('SN_MN'),
        //Найменування кліента (міжнародне)
        Nmkv: obj_Parameters['NMKV'],
        //Найменування кліента в родовому відмінку
        SnGc: '',
        //K101
        Codcagent: obj_Parameters['CODCAGENT'],
        K013: '',
        Country: obj_Parameters['COUNTRY'],
        //k060
        Prinsider: obj_Parameters['PRINSIDER'],
        //тип держ реєстру
        Tgr: obj_Parameters['TGR'],
        Okpo: obj_Parameters['OKPO'],
        Passp: obj_Parameters['PASSP'],
        Ser: obj_Parameters['SER'],
        Numdoc: obj_Parameters['NUMDOC'],
        Organ: obj_Parameters['ORGAN'],
        //Дата видачі документу
        Pdate: obj_Parameters['PDATE'],
        DatePhoto: '',
        //Дата народження 
        Bday: obj_Parameters['BDAY'],
        //місце народження
        Bplace: obj_Parameters['BPLACE'],

        Sex: obj_Parameters['SEX'],
        Branch: obj_Parameters['TOBO'],

        Adr: obj_Parameters['ADR'],
        UrZip: urAdr.zip,
        UrDomain: urAdr.domain,
        UrRegion: urAdr.region,
        UrLocality: urAdr.locality,
        UrAddress: urAdr.address,
        UrTerritoryId: urAdr.territory_id,
        UrLocalityType: urAdr.locality_type,
        UrStreetType: urAdr.street_type,
        UrStreet: urAdr.street,
        UrHomeType: urAdr.home_type,
        UrHome: urAdr.home,
        UrHomepartType: urAdr.homepart_type,
        UrHomepart: urAdr.homepart,
        UrRoomType: urAdr.room_type,
        UrRoom: urAdr.room,

        //Адр:вулиця,буд.,кв.
        Fgadr: urAdr.address,
        //Адреса: район
        Fgdst: urAdr.region,
        //Адреса: область
        Fgobl: urAdr.domain,
        //Адреса: населений пункт
        Fgtwn: urAdr.locality,


        //Мобільний телефон
        Mpno: getDopRekvParam('MPNO'),
        //мобіьний тел.
        Cellphone: getDopRekvParam('MPNO'),
        //домашній тел.
        Teld: obj_Parameters['TELD'],
        //робочий тел.
        Telw: obj_Parameters['TELW'],
        //Адреса електронної пошти
        Email: '',
        //інст.сектор.економіки (К070)
        Ise: obj_Parameters['ISE'],
        //форма власності (К080)
        Fs: obj_Parameters['FS'],
        //вид ек. діяльності (К110)
        Ved: obj_Parameters['VED'],
        //форма господарювання (К050)
        K050: obj_Parameters['K050'],

        //БПК. Закордонний паспорт. Номер
        PcZ2: '',
        //БПК. Закордонний паспорт. Серія
        PcZ1: '',
        //БПК. Закордонний паспорт. Коли виданий
        PcZ5: '',
        //БПК. Закордонний паспорт. Ким виданий
        PcZ3: '',
        //БПК. Закордонний паспорт. Дійсний до
        PcZ4: '',
        //Місце роботи, посада
        WorkPlace: '',
        //Належнiсть до публiчних дiячiв
        Publp: '',
        //Статус зайнятості особи
        Cigpo: '',
        //Вiдмiтка про самозайнятiсть фiзособи
        Samz: '',
        //Категорiя громадян, якi постраждали внаслiдок Чорноб.катастрофи
        Chorn: '',
        //Код "Особливої Вiдмiтки" нестандартного клієнта ФО
        Spmrk: '',
        //Ознака VIP-клієнта
        VipK: '',
        //Приналежнiсть до працiвникiв банку
        Workb: '',
        Gcif: bars.ext.getParamFromUrl('gcif'),

        CodcagentDesc: '',

        K013Desc: '',
        CountryDesc: '',
        PrinsiderDesc: '',
        TgrDesc: '',
        SexDesc: '',
        IseDesc: '',
        FsDesc: '',
        VedDesc: '',
        K050Desc: '',
        OkpoExclusion: '',
        SamzDesc: '',
        SpmrkDesc: '',
        WorkbDesc: '',
        PasspDesc: '',
        Credit: '',
        Deposit: '',
        BankCard: '',
        CurrentAccount: '',
        Other: '',
        LastChangeDt: '',
        Maker: '',
        MakerDtStamp: ''
    };
    return result;
}

// переходим на счета клиента
function accounts() {
    var rnk = obj_Parameters['ID'];

    if (rnk == null || trim(rnk) == "") {
        alert(LocalizedString('Mes08')/*"Клиент не зарегистрирован"*/);
    }
    else {
        var urlViewAcc = "/barsroot/customerlist/custacc.aspx?type=0&rnk=" + rnk;
        if (obj_Parameters['ReadOnly'] == "true")
            urlViewAcc += "&mod=ro";
        document.location.href = urlViewAcc;
    }
}

// печать отчета по контрагенту
function btPrintClick() {
    var rnk = obj_Parameters['ID'];

    if (rnk == null || trim(rnk) == "") {
        bars.ui.alert({ text: LocalizedString('Mes08') } /*"Клиент не зарегистрирован"*/);
    }
    else {
        var needDate = (document.all.__CUSTPRNT && document.all.__CUSTPRNT.value == "1") ? (true) : (false);
        var tempalte_id = "";
        var date = null;
        if (needDate) {
            var bankdate = document.all.__SYSDATE.value;
            bars.ui.alert({
                text: 'Вкажіть дату:<br><input type="text" id="printDate" value="' + bankdate + '" />',
                open: function () {
                    $('#printDate').kendoMaskedDatePicker({
                        format: '{0:dd/MM/yyyy}',
                        mask: '00/00/0000',
                        change: function () {
                            bankdate = this.element.val();
                        }
                    });
                },
                close: function () {
                    bars.ui.handBook('DOC_SCHEME', function (data) {
                        if (data) {
                            bars.ui.loader('body', true);
                            var res = ExecSync('GetFileForPrint', {
                                rnk: rnk,
                                templateID: data[0].ID,
                                adds: bankdate.replace("/", "").replace("/", "")
                            }).d;
                            bars.ui.loader('body', false);
                            onGetFileForPrint(res);
                        }
                    },{
                        multiSelect: false,
                        clause: "id like 'CUST%'",
                        columns: "ID,NAME"
                    });
                }
            });
        }
        
    }
}
function onGetFileForPrint(result) {
    if (!getError(result)) return;
    var link = 'WebPrint.aspx?filename=' + result.Text + "&frxConvertedTxt=true";

    if (window.viewPrintDoc) {
        window.viewPrintDoc.close();
        window.viewPrintDoc = null;
    }

    var left = (screen.width / 2) - (900 / 2);
    var top = (screen.height / 2) - (800 / 2);
    window.viewPrintDoc = window.open(link, 'viewPrintDoc', 'width=900,height=800, top=' + top + ', left=' + left);
}

// обработка ошибки
function getError(result) {
    if (result.Status == "error") {
        if (window.dialogArguments) {
            window.showModalDialog("dialog.aspx?type=err", "", "dialogWidth:800px;center:yes;edge:sunken;help:no;status:no;");
        }
        else
            location.replace("dialog.aspx?type=err");
        return false;
    }
    return true;
}
function getParamFromUrl(param, url) {
    url = url || document.location.href;
    url = url.substring(url.indexOf('?') + 1);
    var paramsArray = url.split("&");
    for (var i = 0; i < paramsArray.length; i++) {
        if (paramsArray[i].split("=")[0].toUpperCase() === param.toUpperCase()) {
            return paramsArray[i].split("=")[1];
        }
    }
    return "";
}

function validatePhone(ignoreConfirmation) {
    var result = { Status: 'ok', Message: '' }
    var curTab = getFrame('Tab3');
    if (gE(curTab, 'ckb_main').checked) {
        var mobPhone = '';
        if (custAttrList['MPNO'] != undefined) {
            mobPhone = custAttrList['MPNO'].Value;
        } else if (obj_Parameters['DopRekv_MPNO'] != undefined) {
            mobPhone = obj_Parameters['DopRekv_MPNO'];
        }
        var domPhone;
        var curWin = curTab.contentWindow || curTab;
        if (curWin.fullDomPhone) {
            domPhone = '+380' + gE(curTab, 'ed_TELD_CODE').value + gE(curTab, 'ed_TELD').value;
        } else {
            domPhone = gE(curTab, 'ed_TELD').value;
        }

        var hasntMob = (mobPhone === '' || mobPhone === '+380');
        var hasntDom = (domPhone === '' || domPhone === '+380');

        //для ощадика валідуємо вік клієнта
        var dateArray = gE(curTab, 'ed_BDAY').value.split('.');
        var dateByrth = new Date(dateArray[2], parseInt( dateArray[1],10) - 1, dateArray[0]);

        var custAge = getCustAge(dateByrth);

        if (hasntMob && !gE(curTab, 'notUseTelm').checked) {
            result.Status = 'errorMobPhone';
            result.Message = 'Невірно заповнено номер мобільного телефону.';
            result.Phone = mobPhone;
            return result;
        }
        if (!hasntMob && mobPhone.length < 13) {
            result.Status = 'error';
            result.Message = 'Недостатня кількість символів у мобільному номері.';
            return result;
        }
        if (obj_Parameters['CUSTTYPE'] === 'person' && !isCustomerSpd()) {
            //проверяем только ФО COBUSUPABS-5200
            if (!hasntDom && domPhone.length < 13) {
                result.Status = 'error';
                result.Message = 'Невірно заповнено телефону. Недостатня кількість символів.';
                return result;
            }
        }
        if (!hasntMob && checkRepeatSimbols(mobPhone.substring(6))) {
            result.Status = 'duplSimbMobPhone';
            result.Message = 'Невірно заповнено номер мобільного телефону.';
            result.Phone = mobPhone;
            return result;
        }
        if (obj_Parameters['CUSTTYPE'] === 'person' && !isCustomerSpd()) {
            //так как у фоп-спд телефон дом не обязателен а моб телефон можно отключить, убираем проверку на наличие хоть одного телефона
            if (hasntMob && hasntDom && custAge > 15) {
                result.Status = 'error';
                result.Message = 'Невірно заповнено номер телефону. Один з телефонів має бути заповнений';
                return result;
            }
        }
        //перевіримо чи підтверджено телефон 
        if (!ignoreConfirmation && CacParams.CellPhoneConfirmation && !obj_Parameters['CellPhoneConfirmed'] && !gE(curTab, 'notUseTelm').checked) {
            result.Status = 'error';
            result.Message = 'Не підтверджено номер мобільного телефону.';
            return result;
        }
    }
    return result;
}

function checkRepeatSimbols(str) {
    var status = true;
    for (var i = 0; i < str.length; i++) {
        if (str.substr(0, 1) != str.substr(i, 1)) {
            status = false;
        }
    }
    return status;
}

// публичная особа
function GetPublicFlag(nmk) {
    return ExecSync('GetPublicFlag', { nmk: nmk }).d;
}

//Валидация свидетельства рождения
function CheckSeriaBirthCertificate(curTab) {
    var series = gE(curTab, 'ed_SER').value;
	var re = new RegExp("^M{0,3}(D?C{0,3}|C[DM])(L?X{0,3}|X[LC])(V?I{0,3}|I[VX])-[АБВГҐДЕЄЖЗИІЇЙКЛМНОПРСТУФХЦЧШЩЬЮЯ]{2}", "g");
	var valid = re.test(series);
    if (series.length > 6 || !valid) {
        return false;
    }
    else {
        return true;
    }
}

function CheckNumberBirthCertificate(curTab) {

    var seriesNumber = gE(curTab, 'ed_NUMDOC').value;

    if (seriesNumber.length > 6) {
        return false;
    }
    else {
        return true;
    }
}


function frameCustCapacity() {
    var rnd = Math.random();
    core$IframeBox({ url: "/barsroot/clientregister/registration.aspx", width: 850, height: 650, title: "Проднавантаження клієнта", callback: "ReloadPage();" });
}

function GenerateGUID() {
    return (((1 + Math.random()) * 0x10000) | 0).toString(16).substring(1);
}

function showDialogScanPhoto() {
    guid = (GenerateGUID() + GenerateGUID() + "-" + GenerateGUID() + "-4" + GenerateGUID().substr(0, 3) + "-" + GenerateGUID() + "-" + GenerateGUID() + GenerateGUID() + GenerateGUID()).toLowerCase();
    //var result = window.open('/barsroot/credit/usercontrols/dialogs/textboxscanner_scan.aspx?sid=IMAGE_DATA_' + guid + '&rnd=' + Math.random(), "DialogClientCard", 'height=800px,width=900px');
    var DialogOptions = 'dialogHeight:800px; dialogWidth:900px; scroll: no';
    var DialogObject = {windowName: "DialogClientCard"};

    var rnk = obj_Parameters['ID'];     // client RNK
    var result = window.showModalDialog('/barsroot/credit/usercontrols/dialogs/textboxscanner_scan.aspx?sid=IMAGE_DATA_' + rnk + "_"
        + guid + '&rnd=' + Math.random(), DialogObject, DialogOptions);

    if(result != null){
        if(result['SaveBtnEnabled'] == true){
            bars.ui.notify("Інформація", "Фотографію завантажено, натисніть 'Зберегти'.", 'success', {position:{
                pinned: true, top: 30, right: 300 }, autoHideAfter: 5*1000});
            getEl('bt_reg').disabled = false;

            var selectedDevice = result['SelectedDevice'];
            if(selectedDevice != null){
                g_PhotoType = selectedDevice.indexOf("Video") != -1 ? "PHOTO_WEB" : "PHOTO_JPG";
                //console.log("g_PhotoType="+g_PhotoType+" selectedDevice="+selectedDevice);
            }

            LoadPhoto(g_PhotoType == "PHOTO_WEB" ? PHOTO_DIRECTION_WEB_CAMERA : PHOTO_DIRECTION_SCANER);        // load photo from DB
        }
    }
}

function PreviewPhoto() {
    //todo: IE >= 10
    var inputElement = document.getElementById("image_file");
    inputElement.addEventListener("change", handleFiles, false);
    function handleFiles() {
        var fileList = this.files; /* теперь вы можете работь со списком файлов */
        var file = fileList[0];
        var img = document.getElementById("kkPhoto");
        img.file = file;

        var reader = new FileReader();
        reader.onload = (function(aImg) { return function(e) { aImg.src = e.target.result; }; })(img);
        reader.readAsDataURL(file);
    }
}

function btSavePhoto() {
    //console.log("btSavePhoto");

    AJAX({ srcSettings: {
        url: bars.config.urlContent("/api/Upload/UploadApi/PhotoSave"),
        // url: bars.config.urlContent("/api/BpkW4/InstantCardApi/PhotoSave"),
        success: function (data) {
            if(data && data['isSaved'] == true){
                bars.ui.notify("Редагування", "Фотографію для клієнта "+obj_Parameters['ID']+" успішно збережено.", 'success', {autoHideAfter: 5*1000});
            }
            else{
                bars.ui.notify("Редагування", "Невдала спроба зберегти фотографію для клієнта "+obj_Parameters['ID'], 'error', {autoHideAfter: 5*1000});
            }
            $("#btnSavePhoto").hide();
        },
        error: function (jqXHR, textStatus, errorThrown) {
            //bars.ui.error({ title: 'Помилка', text: "Невдала спроба сформувати миттєву картку." });
        },
        data: JSON.stringify({rnk: obj_Parameters['ID'], imgType: "PHOTO_JPG"})
    } });

}

function showDialogOpenPhoto() {
    getEl("image_file").click();
}

function LoadPhoto(PHOTO_DIRECTION) {
    var PHOTO = ExecSync('GetClientPhoto', {
        fromCache: false,       // always from DB
        rnk: (obj_Parameters['ID'] == '' ? 0 : obj_Parameters['ID']),
        photo_types: ["PHOTO"]
    });
    if(PHOTO['d']){
        $("#kkPhoto_PHOTO").attr('src', PHOTO['d']);
        $("#kkPhoto_PHOTO_Date").text(ExecSync('GetClientPhotoDateTime', {
            rnk: (obj_Parameters['ID'] == '' ? 0 : obj_Parameters['ID']),
            photo_type: "PHOTO"
        })['d']);
    }

    var PHOTO_WEB = ExecSync('GetClientPhoto', {
        fromCache: PHOTO_DIRECTION == PHOTO_DIRECTION_WEB_CAMERA,
        rnk: (obj_Parameters['ID'] == '' ? 0 : obj_Parameters['ID']),
        photo_types: ["PHOTO_WEB"]
    });
    if(PHOTO_WEB['d']){
        $("#kkPhoto_WEB").attr('src', PHOTO_WEB['d']);
        $("#kkPhoto_WEB_Date").text(ExecSync('GetClientPhotoDateTime', {
            rnk: (obj_Parameters['ID'] == '' ? 0 : obj_Parameters['ID']),
            photo_type: "PHOTO_WEB"
        })['d']);
    }

    var PHOTO_JPG = ExecSync('GetClientPhoto', {
        fromCache: PHOTO_DIRECTION == PHOTO_DIRECTION_HARD_DISK || PHOTO_DIRECTION == PHOTO_DIRECTION_SCANER,
        rnk: (obj_Parameters['ID'] == '' ? 0 : obj_Parameters['ID']),
        photo_types: ["PHOTO_JPG"]
    });
    if(PHOTO_JPG['d']){
        $("#kkPhoto_JPG").attr('src', PHOTO_JPG['d']);
        $("#kkPhoto_JPG_Date").text(ExecSync('GetClientPhotoDateTime', {
            rnk: (obj_Parameters['ID'] == '' ? 0 : obj_Parameters['ID']),
            photo_type: "PHOTO_JPG"
        })['d']);
    }

    /// **************************************************************************************
    /// fill main photo
    var hasPhoto = false;
    $("#kkPhotoText").css("color", "");
    if(PHOTO_WEB['d']){
        $("#kkPhoto").attr('src', PHOTO_WEB['d']);
        $("#kkPhotoText").text("Веб");
        $("#kkPhotoText").css("color", "green");
        hasPhoto = true;
    }

    if(PHOTO_JPG['d'] && (!hasPhoto || PHOTO_DIRECTION == PHOTO_DIRECTION_HARD_DISK || PHOTO_DIRECTION == PHOTO_DIRECTION_SCANER)){
        $("#kkPhoto").attr('src', PHOTO_JPG['d']);
        $("#kkPhotoText").text("Скан");
        hasPhoto = true;
    }

    if(PHOTO['d'] && !hasPhoto){
        $("#kkPhoto").attr('src', PHOTO['d']);
        $("#kkPhotoText").text("Фото");
        hasPhoto = true;
    }

    if(!hasPhoto){
        $("#kkPhotoText").text("Відсутнє");
        $("#kkPhotoText").css("color", "red");
    }
}

function openRealPhoto() {
    var src = $("#kkPhoto").attr('src');
    if(src.indexOf("empty_image.png") != -1){
        bars.ui.error({ title: 'Перегляд фотографії', text: 'Фоторгафія відсутня!' });
        return;
    }

    // $('#realPhotoWin').append('<img id="realPhotoIm" src="" alt="" />');
    // $("#realPhotoIm").attr('src', src);
    $("#realPhotoWin").data('kendoWindow').center().open();
}

function showDialogSelectPhoto() {
    $("#selectPhotoWin").data('kendoWindow').center().open();
}

function ready() {
    // clear old images from session
    //var delCount = ExecSync('ClearKeysInSession', { keysForDel: ["IMAGE_DATA_", "BYTES_IMAGE_DATA_"] });

    var pos = {
        pinned: true,
        top: 30,
        right: 300
    };

    LoadPhoto(PHOTO_DIRECTION_ALL);

    InitGridWindow({windowID: "#realPhotoWin", srcSettings: {
        title: "Перегляд фотографії",
        close: function (e) {
            $('#realPhotoIm').remove();
        },
        width: null
    }});

    InitGridWindow({windowID: "#selectPhotoWin", srcSettings: {
        title: "Вибір фотографії",
        close: function (e) {

        },
        width: "640px"
    }});

    $("#image_file").kendoUpload({
        localization: {
            select: "Виберіть фотографію",
            headerStatusUploading: "",
            headerStatusUploaded: ""

        },
        async: {
            autoUpload: true,
            saveUrl: bars.config.urlContent("/api/Upload/UploadApi/PhotoUpload")
        },

        upload: function (e) {
            e.data = {rnk: obj_Parameters['ID']};
        },

        showFileList: true,
        multiple: false,
        error: function (e) {
            var error = e.XMLHttpRequest.responseText;
            if("Error trying to get server response: [object Error]" === error){
                error = "Невдала спроба завантажити файл. Перевірте розмір (<150кб); висоту та ширину(640х480); тип файлу";
            }
            bars.ui.notify("Редагування фото", error, 'error', {position:pos, autoHideAfter: 5*1000});
        },
        success: function (e) {
            LoadPhoto(PHOTO_DIRECTION_HARD_DISK);

            bars.ui.notify("Редагування фото", "Фотографію завантажено, натисніть 'Зберегти фото'.", 'success', {position:pos, autoHideAfter: 5*1000});

            $("#selectPhotoWin").data('kendoWindow').close();

            // todo: hack - hide 'kendo' upload status
            //$(".k-upload-status").hide();

            if(obj_Parameters['ID'] !== ''){
                $("#btnSavePhoto").show();
            }
        }
    });

    // todo: hack - clear fucking 'kendo' classes
    // $(".k-widget.k-upload.k-header").removeClass("k-header");
    // $(".k-widget.k-upload").removeClass("k-upload");
    // $(".k-widget").removeClass("k-widget");
    //
    // $(".k-button.k-upload-button").removeClass("k-upload-button");
    // $(".k-button").removeClass("k-button");


    // kendo button "select file for upload"
    // $(".k-upload-button").hide();
    // $(".k-dropzone").hide();
    // $(".k-upload-status").hide();
}
