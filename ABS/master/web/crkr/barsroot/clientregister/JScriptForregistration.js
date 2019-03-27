var curTabCount = 0;
var oImg = null;
var flagEnhCheck = false;
var flagROCheck = false;
var segment = null;
var custAttrList = new Array();
var custRiskList = new Array();
var custReptList = new Array();
var custCatsList = new Array();

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
    return getParamFromUrl('gcif', parent.document.location.href) != '';
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
    var fioMask = /^[a-zA-Zа-яА-Яа-яА-ЯіІїЇєЄ]{0,1}[a-zA-Zа-яА-Яа-яА-ЯіІїЇєЄ\-\`\']{1,69}$/;
    var cyyrilycFioMask = /^[а-яА-Яа-яА-ЯіІїЇєЄ]{0,1}[а-яА-Яа-яА-ЯіІїЇєЄ\-\`\']{1,69}$/;
    var sameSymbolsMask = /^(.)\1+$/;

    if (obj_Parameters['CUSTTYPE'] === 'person' && !isCustomerSpd()) {
        var isFoRezident = gE(curTab, 'ddl_CODCAGENT').value === "1-5";
        var isDocPassport = gE(getFrame('Tab3'), 'ddl_PASSP').value === "1";
        if (tmpSel == '1') {
            var ln = gE(curTab, 'ed_FIO_LN').value;
            if (sameSymbolsMask.test(ln.toUpperCase()) || ln.length < 2 ) {
                alert('Прізвище має складатись не менш ніж із 2х неодинакових символів.');
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
            if (sameSymbolsMask.test(fn.toUpperCase()) || fn.length < 2) {
                alert("Ім'я має складатись не менш ніж із 2х неодинакових символів.");
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
            if (isDocPassport && (sameSymbolsMask.test(mn.toUpperCase()) || mn.length < 3)) {
                alert("По-батькові особи, що реєструється із паспортом має складатись не менш ніж із 3х неодинакових символів.");
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
                    valid = false;
                } else {
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
    if (mobTelElement) {
        obj_Parameters['DopRekv_MPNO'] = mobTelElement.value;
    }
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

function getCustAge(birthDate) {
    var nawYear = new Date().getFullYear();
    var custYear = birthDate.getFullYear();
    return nawYear - custYear;
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
        if (isDocPassport && (organ.length < 10 || !/^[а-яА-Яа-яА-ЯіІїЇєЄ]{0,1}[а-яА-Яа-яА-ЯіІїЇєЄ\-\`\'\.\s]{1,255}$/.test(organ.toUpperCase()))) {
            alert('Орган, що видав паспорт має містити не менше 10 символів кирилиці.');
            gE(curTab, 'ed_ORGAN').focus();
            return false;
        }
        if (!isIDPassport && isEmpty(gE(curTab, 'ed_PDATE'))) {
            isEmptyCheck(gE(curTab, 'ed_PDATE'));
            return false;
        }
        // ID картка проверки
        if (isIDPassport) {
            var receiveDateStr = gE(curTab, 'ed_ID_ReceiveDate').value;
            var receiveDate = new Date(receiveDateStr.substring(6, 10), parseInt(receiveDateStr.substring(3, 5)) - 1, receiveDateStr.substring(0, 2));
            var expireDateStr = gE(curTab, 'ed_ID_ExpireDate').value;
            var expireDate = new Date(expireDateStr.substring(6, 10), parseInt(expireDateStr.substring(3, 5)) - 1, expireDateStr.substring(0, 2));
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

        if (obj_Parameters['CUSTTYPE'] == 'person') {
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
                    var validationResult = ExecSync('ValidateMobilePhone', { rnk: (obj_Parameters['ID'] == '' ? 0 : obj_Parameters['ID']), phone: validPhone.Phone }).d;

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
    obj_Parameters['NOMPDV'] = gE(curTab, 'ed_NOMPDV').value;
    obj_Parameters['RNKP'] = gE(curTab, 'ed_RNKP').value;
    obj_Parameters['NOTESEC'] = gE(curTab, 'ed_NOTESEC').value;

    return true;
}
function Check_DopReqv() {
    var curTab = getFrame('Tab5');
    var curBut = getEl('bTab5');
    goPage(curBut);

    var checkReqv = gE(curTab, "chCheckReq").checked;
    if (!checkReqv) return true;

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
                msg = 'Перереєструвати клієнта' + ' rnk = ' + obj_Parameters['ID'] + ' ?';;//escape(LocalizedString('Mes07')/*'Перерегистрировать клиента'*/ + ' rnk = ' + obj_Parameters['ID'] + ' ?');
            bars.ui.confirm({
                text: msg, func: function () {
                    saveCustomerToBase();
                }
            });
        }
    }
}

function saveCustomerToBase() {
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
        custAttrCheck: custAttrCheck,
        custAttrList: getArray(custAttrList),
        custRiskList: getArray(custRiskList),
        custReptList: getArray(custReptList),
        custCatsList: getArray(custCatsList)
    }).d;
    bars.ui.loader('body', false);
    if (registerResult) {
        bars.ui.alert({
            text: registerResult.ResultText,
            close: function () {
                if (registerResult.Status === "OK" || registerResult.Status === "TOBECONFIRMED") {

                    if (obj_Parameters['CUSTTYPE'] === 'person' && $.trim(obj_Parameters['SED']) != '91'
                        && CacParams.UseCdmValidation) {

                        validateByCsb(registerResult.Rnk, obj_Parameters['EditType'] == 'Reg');
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

function validateByCsb(rnk, isNew) {
    var result = false;
    bars.ui.loader('body', true);
    var type = isNew ? 'POST' : 'PUT';
    $.ajax({
        type: type,
        url: bars.config.urlContent('/api/cdm/CsbValidate/') + '?id=' + rnk,
        async: true,
        complete: function () { bars.ui.loader('body', false); },
        //data: {id: rnk} /*getCustomerToCsbData()*/,
        error: function (response) {
            var message = 'Невдалося з\'єднатися з сервісом ЄБК для валідації даних клієнта.<br/>' +
                '<b>Продовжити процедуру збереження?</b><br/><br/>' +
                'Помилка:<br/>' + (response.Massage || response.responseJSON.ExceptionMessage);

            bars.ui.error({
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
                var rO = "";
                if (obj_Parameters['ReadOnlyMode'])
                    rO = "readonly=" + obj_Parameters['ReadOnlyMode'] + "&";
                location.replace('/barsroot/clientregister/registration.aspx?' + rO + 'rnk=' + rnk);
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

    var text = data.Message + '<br>Статус: ' + data.Data.status + '<br>';
    text += '<ul>';
    csbValidateCustonrData = data.Data.checks;
    for (var i = 0; i < data.Data.checks.length; i++) {
        var recomend = data.Data.checks[i];
        text += '<li>';
        text += 'Значення параметра <b>' + (recomend.NameDescription || recomend.Name) + ' : ' + recomend.Value + '</b> введено з помилкою <br/>';
        text += 'Рекомендоване значення: <b>' + recomend.RecommendValue + '</b>';
        text += '<button class="k-button" onclick="showRcomendDetail(' + i + ')"><i class="pf-icon pf-16 pf-info"></i></button>';
        text += '</li>';
    }
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
        bars.ui.error({
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
    var link = 'WebPrint.aspx?filename=' + result;

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
    if (result.error) {
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
        if (!hasntDom && domPhone.length < 13) {
            result.Status = 'error';
            result.Message = 'Невірно заповнено телефону. Недостатня кількість символів.';
            return result;
        }
        if (!hasntMob && checkRepeatSimbols(mobPhone.substring(6))) {
            result.Status = 'duplSimbMobPhone';
            result.Message = 'Невірно заповнено номер мобільного телефону.';
            result.Phone = mobPhone;
            return result;
        }
        if (hasntMob && hasntDom && custAge > 15) {
            result.Status = 'error';
            result.Message = 'Невірно заповнено номер телефону. Один з телефонів має бути заповнений';
            return result;
        }
        //перевіримо чи підтверджено телефон 
        if (!ignoreConfirmation && CacParams.CellPhoneConfirmation && !obj_Parameters['CellPhoneConfirmed']) {
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
function frameCustCapacity() {
    var rnd = Math.random();
    core$IframeBox({ url: "/barsroot/clientregister/registration.aspx", width: 850, height: 650, title: "Проднавантаження клієнта", callback: "ReloadPage();" });
}