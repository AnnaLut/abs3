var aSigner; // объект для наложения ЭЦП
var gDocBufferInt = null;
var gDocBufferExt = null;
var gActiveXName = "BARSAX.RSAC";
/**
* padl(s,n) - выполняет выравнивание пробелами слева
*/
function padl(s, n) {
    while (s.length <= n) s = " " + s;
    return s.substring(s.length - n, s.length);
}

/**
* padr(s,n) - выполняет выравнивание пробелами справа
*/
function padr(s, n) {
    while (s.length <= n) s = s + " ";
    return s.substring(0, n);
}

window.attachEvent("onload", InitActiveX);

function InitActiveX() {
    if (document.getElementById('__SIGNTYPE') && document.getElementById('__SIGNTYPE').value == 'SL2')
        gActiveXName = "Bars.SL2Plugin";
    if (!needToBeSign()) return;
    try {
        var avialibleAx = new ActiveXObject(gActiveXName);
    }
    catch (e) {
        alert(LocalizedString('Message20'));
        return;
    }
}

/**
* InitSigner() - выполняет инициализацию объекта для наложения ЭЦП
*/
function InitSigner(strSignType) {
  var parentDocum = window.top; 
  try {
    if (parentDocum.oSigner) {
      aSigner = parentDocum.oSigner;
    } else {
      aSigner = new ActiveXObject(gActiveXName);
      parentDocum.oSigner = aSigner;       
    }
  }
  catch (e) {
      alert(LocalizedString('Message20'));
      return;
  }
  if (!aSigner.IsInitialized) aSigner.Init(strSignType);
  if (!aSigner.IsInitialized) {
      alert(LocalizedString('Message21'));
      return false;
  }
  return true;
}

// проверка подписи по переданим значением перед оплатой (SWI)
function preCheckSign() {
    var signElem = document.getElementById("swiSign");
    if (signElem && signElem.value) {
        document.body.style.visibility = "hidden";
        var sign = signElem.value;
        var key = document.getElementById("swiSignKey").value;
        var buff = decodeURI(document.getElementById("swiSignBuf").value);

        if (!InitSigner(document.getElementById("__SIGNTYPE").value))
        {
            alert("Помилка ініціалізації підпису, оплата документа заблокована.");
            location.replace("/barsroot/barsweb/welcome.aspx");
        }
        //Для VEG-подписи добавляем 2 символа из REGNCODE
        if ("VEG" == document.getElementById('__SIGNTYPE').value && document.getElementById('__DOCKEY').value.length == 6)
            aSigner.IdOper = document.getElementById('__REGNCODE').value + document.getElementById('__DOCKEY').value;
        else
            aSigner.IdOper = document.getElementById('__DOCKEY').value;
        aSigner.BankDate = document.getElementById('__BDATEF').value;;
        aSigner.BufferEncoding = "WIN";
        var errText = '';
        res = aSigner.SilentVerifySignature(buff, sign, key, errText);
        if(res || res != '')
        {
            alert("Помилка перевірки підпису, оплата документа заблокована.\nІдентифікатор ключа перевірки підпису - " + key + "\nОпис помилки: " + res);
            location.replace("/barsroot/barsweb/welcome.aspx");
        }
        else
            document.body.style.visibility = "visible";
    }
}


/**
* проверяет нужно ли на текущем документе ЭЦП
*/
function needToBeSign() {
    var form = document.forms["DocInputForm"];
    // флаг внутренней ЭЦП
    var num_INTSIGN = parseInt(form.__INTSIGN.value);
    // флаг типа документа: 0-внутр., 1-СЭП НБУ, 2-SWIFT, 3-Процессинг СЭП
    var num_FLI = parseInt(form.__FLAGS.value.substring(64, 65));
    // номер версии СЭП (1/2)
    var num_SEPNUM = parseInt(form.__SEPNUM.value);
    // флаг ЭЦП при вводе (0-нет,1-внутр,2-внешн,3-внутр+внешн)
    var num_INPUT_SIGN_FLAG = parseInt(form.__FLAGS.value.substring(1, 2));

    //требуется внешняя подпись
    if ((1 == num_INTSIGN && 0 == num_FLI)								// включена внешняя ЭЦП на внутренних документах
	|| (1 == num_FLI && (0 == num_INTSIGN || 1 == num_INTSIGN))		// документ Межбанковский СЭП-НБУ
    // или включена ЭЦП 2-го вида и требуется внешняя ЭЦП на документ
	|| 2 == num_INTSIGN && (2 == num_INPUT_SIGN_FLAG || 3 == num_INPUT_SIGN_FLAG)
	) return true;

    //требуется внутренняя ЭЦП на документ
    if (2 == num_INTSIGN
	&& (1 == num_INPUT_SIGN_FLAG || 3 == num_INPUT_SIGN_FLAG)
	) return true;

    return false;
}

/**
* signDoc() - выполняет наложение ЭЦП на документ
*/
function signDoc(form) {
    // Получаем ref только если еще не был получен
    if (form.__DOCREF.value == "")
        cDocHand(3, form);

    // флаг внутренней ЭЦП
    var num_INTSIGN = parseInt(form.__INTSIGN.value);
    // флаг типа документа: 0-внутр., 1-СЭП НБУ, 2-SWIFT, 3-Процессинг СЭП
    var num_FLI = parseInt(form.__FLAGS.value.substring(64, 65));
    // номер версии СЭП (1/2)
    var num_SEPNUM = parseInt(form.__SEPNUM.value);
    // флаг ЭЦП при вводе (0-нет,1-внутр,2-внешн,3-внутр+внешн)
    var num_INPUT_SIGN_FLAG = parseInt(form.__FLAGS.value.substring(1, 2));

    if (form.DocN.value == "") form.DocN.value = form.__DOCREF.value;
    form.__DOCSIGN.value = "";
    form.__DOCSIGN_INT.value = "";

    // разбираемся с видом документа
    var num_VOB = parseInt(form.VobList.value);
    if (form.__VOB2SEP2.value.length > 0) {
        var str = "," + form.__VOB2SEP2.value + ",";
        if (str.indexOf("," + num_VOB.toString() + ",") < 0)
            num_VOB = parseInt(form.__VOB2SEP.value);
    }
    else if (1 != num_VOB && 2 != num_VOB && 6 != num_VOB && 33 != num_VOB && 81 != num_VOB)
        num_VOB = parseInt(form.__VOB2SEP.value);
    //Подпись документа с помощью CapiCom
    if (1 == form.__SIGNCC.value) {
        var certName = form.__CERTNAME.value;
        // формирование буфера для наложения ЭЦП
        var str_buf = padl(form.Mfo_A.value, 9) + padl(form.Nls_A.value, 14) +
				padl(form.Mfo_B.value, 9) + padl(form.Nls_B.value, 14) +
				form.__DK.value +
				padl(Math.round(GetValue("SumC") * 100).toString(10), 16) +
				padl(num_VOB.toString(), 2) +
				padr(form.DocN.value, 10) + padl(form.Kv_A.value, 3) +
				form.DocD_TextBox.value.substring(8, 10) + form.DocD_TextBox.value.substring(3, 5) + form.DocD_TextBox.value.substring(0, 2) +
				form.__BDATE.value +
				padr(form.Nam_A.value, 38) + padr(form.Nam_B.value, 38) + padr(form.Nazn.value, 160) +
				padr(' ', 60) + padr(' ', 3) + '10' + padl(form.Id_A.value, 14) + padl(form.Id_B.value, 14) +
				padl(form.__DOCREF.value, 9) + padr(form.__DOCKEY.value, 6) + ' 0' + padl(' ', 8);
        try {
            var sign = GetSignForDocument(str_buf, certName);
            if (null == sign || 0 == sign.length) return false;
            form.__DOCSIGN.value = sign;
        }
        catch (e) {
            alert(LocalizedString('Message22')); //alert("Ошибки при наложении ЭЦП");
        }
        return true;
    }

    if ((1 == num_INTSIGN && 0 == num_FLI)								// включена внешняя ЭЦП на внутренних документах
	|| (1 == num_FLI && (0 == num_INTSIGN || 1 == num_INTSIGN))		// документ Межбанковский СЭП-НБУ
    // или включена ЭЦП 2-го вида и требуется внешняя ЭЦП на документ
	|| 2 == num_INTSIGN && (2 == num_INPUT_SIGN_FLAG || 3 == num_INPUT_SIGN_FLAG)
	) { // необходимо подписать по принципу СЭП
        if (!InitSigner(form.__SIGNTYPE.value)) return false;
        // банковская дата    
        aSigner.BankDate = document.getElementById('__BDATEF').value;
        // пишем в протокол REF документа
        if (aSigner.GetMajorVersion == 1 && aSigner.GetMinorVersion > 22)
            aSigner.ProtData = form.__DOCREF.value;
        // обработка версии СЭП (1/2)
        if (1 == num_SEPNUM)
            aSigner.BufferEncoding = "DOS";
        else
            aSigner.BufferEncoding = "WIN";
        //Для VEG-подписи добавляем 2 символа из REGNCODE
        if ("VEG" == form.__SIGNTYPE.value && form.__DOCKEY.value.length == 6)
            aSigner.IdOper = form.__REGNCODE.value + form.__DOCKEY.value;
        else
            aSigner.IdOper = form.__DOCKEY.value;
        // обратное присвоение на случай если ключ прописан локально в реестре
        form.__DOCKEY.value = aSigner.IdOper;
        if (form.__DOCKEY.value.length == 8)
            form.__REGNCODE.value = form.__DOCKEY.value.substring(0, 2);
        if (form.__DOCKEY.value.length > 6)
            form.__DOCKEY.value = form.__DOCKEY.value.substring(form.__DOCKEY.value.length - 6);

        var DatP = ("1" == form.__IS_QDOC.value ? form.__QDOC_DATP.value : form.__DATP.value);
        var TrueVOB = ("1" == form.__IS_QDOC.value ? getParamFromUrl("vob", location.search) : num_VOB);

        // формирование буфера для наложения ЭЦП
        var str_buf = padl(form.Mfo_A.value, 9) + padl(form.Nls_A.value, 14) +
				padl(form.Mfo_B.value, 9) + padl(form.Nls_B.value, 14) +
				form.__DK.value +
				padl(Math.round(GetValue("SumC") * 100).toString(10), 16) +
				padl(TrueVOB.toString(), 2) +
				padr(form.DocN.value, 10) + padl(form.Kv_A.value, 3) +
				form.DocD_TextBox.value.substring(8, 10) + form.DocD_TextBox.value.substring(3, 5) + form.DocD_TextBox.value.substring(0, 2) +
				DatP +
				padr(form.Nam_A.value, 38) + padr(form.Nam_B.value, 38) + padr(form.Nazn.value, 160) +
				padr(form.Drec.value, 60) + padr(form.NaznK.value, 3) + padr(form.NaznS.value, 2) + padl(form.Id_A.value, 14) + padl(form.Id_B.value, 14) +
				padl(form.__DOCREF.value, 9) + padr(form.__DOCKEY.value, 6) + padl(form.Bis.value, 2) + padl(' ', 8);
        // наложение самой ЭЦП
        gDocBufferExt = str_buf;
        var aSignBuf = aSigner.SignBuffer(str_buf);
        if (0 == aSignBuf.length) {
            alert(LocalizedString('Message22')); //alert("Ошибки при наложении ЭЦП"); 
            return false;
        } else {
            form.__DOCSIGN.value = aSignBuf;
        }
    }
    // включена ЭЦП 2-го вида и требуется внутренняя ЭЦП на документ
    if (2 == num_INTSIGN
	&& (1 == num_INPUT_SIGN_FLAG || 3 == num_INPUT_SIGN_FLAG)
	) {
        if (!InitSigner(form.__SIGNTYPE.value)) return false;
        aSigner.BufferEncoding = "WIN";
        // банковская дата    
        aSigner.BankDate = document.getElementById('__BDATEF').value;
        // пишем в протокол REF документа
        if (aSigner.GetMajorVersion == 1 && aSigner.GetMinorVersion > 22)
            aSigner.ProtData = form.__DOCREF.value;
        //Для VEG-подписи добавляем 2 символа из REGNCODE
        if ("VEG" == form.__SIGNTYPE.value && form.__DOCKEY.value.length == 6)
            aSigner.IdOper = form.__REGNCODE.value + form.__DOCKEY.value;
        else
            aSigner.IdOper = form.__DOCKEY.value;
        // обратное присвоение на случай если ключ прописан локально в реестре
        form.__DOCKEY.value = aSigner.IdOper;
        if (form.__DOCKEY.value.length == 8)
            form.__REGNCODE.value = form.__DOCKEY.value.substring(0, 2);
        if (form.__DOCKEY.value.length > 6)
            form.__DOCKEY.value = form.__DOCKEY.value.substring(form.__DOCKEY.value.length - 6);
        // формирование буфера для наложения ЭЦП
        var sumA;
        var sumB;
        if (form.SumA.style.visibility == "hidden")
            sumA = GetValue("SumC");
        else
            sumA = GetValue("SumA");
        if (form.SumB.style.visibility == "hidden")
            sumB = GetValue("SumC");
        else
            sumB = GetValue("SumB");
        var typeBank = "";
        if (form.__OURMFO.value == "300001")
            typeBank = "NBU";
        else if (form.__OURMFO.value == "300465")
            typeBank = "OSC";
        else if (form.__OURMFO.value == "300205")
            typeBank = "UPB";
        var intBuf = new MakeIntDocBuf(typeBank);
        intBuf.ND = form.DocN.value;
        intBuf.DOCD = form.DocD_TextBox.value;
        if (isQdoc())
            intBuf.VOB = getParamFromUrl("vob", location.search);
        else
            intBuf.VOB = form.VobList.value;
        intBuf.DK = form.__DK.value;
        intBuf.MFOA = form.Mfo_A.value;
        intBuf.NLSA = form.Nls_A.value;
        intBuf.KVA = form.Kv_A.value;
        intBuf.NAMA = form.Nam_A.value;
        intBuf.IDA = form.Id_A.value;
        intBuf.SUMA = Math.round(sumA * 100);
        intBuf.MFOB = form.Mfo_B.value;
        intBuf.NLSB = form.Nls_B.value;
        intBuf.KVB = form.Kv_B.value;
        intBuf.NAMB = form.Nam_B.value;
        intBuf.IDB = form.Id_B.value;
        intBuf.SUMB = Math.round(sumB * 100);
        intBuf.NAZN = form.Nazn.value;
        str_buf = intBuf.getIntBuf();
        gDocBufferInt = str_buf;
        var aSignBuf = aSigner.SignBuffer(str_buf);
        if (0 == aSignBuf.length) {
            alert(LocalizedString('Message22')); //alert("Ошибки при наложении ЭЦП"); 
            return false;
        } else {
            form.__DOCSIGN_INT.value = aSignBuf;
        }
    }

    return true;
} // end of signDoc()


function CheckIntallerVersion() {
    try {
        var shell = new ActiveXObject('WScript.Shell');
        shell.run('msiexec.exe');
    }
    catch (e) {
        alert(LocalizedString('Message23')); //alert("Невозможно создать елемент ActiveX для определения версии Windows Installer.")
    }
}