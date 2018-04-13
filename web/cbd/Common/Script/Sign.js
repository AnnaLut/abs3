/* ----------------------------------------------------
* Блок вспомогательных функций
* ----------------------------------------------------*/
/*
* padl(s,n) - выполняет выравнивание пробелами слева
*/
function padl(s, n) { while (s.length <= n) s = " " + s; return s.substring(s.length - n, s.length); }
/*
* padr(s,n) - выполняет выравнивание пробелами справа
*/
function padr(s, n) { while (s.length <= n) s = s + " "; return s.substring(0, n); }
/*
* GetBinFromHex(strHex) - преобразование строки Hex To Bin
*/
function GetBinFromHex(strHex) {
    var strBin = '';
    for (i = 0; i < strHex.length / 2; i++) {
        var hexLtr = strHex.substr(i * 2, 2);
        var intLtr = parseInt(hexLtr, 16);
        var strLtr = String.fromCharCode(intLtr);

        if (intLtr > 130) {
            var a = 5;
        }

        strBin += strLtr;
    }

    return strBin;
}
/*
* GetHexFromBin(strBin) - преобразование строки Bin To Hex
*/
function GetHexFromBin(strBin) {
    var strHex = '';
    for (i = 0; i < strBin.length; i++) {
        var hexLtr = strBin.charCodeAt(i);

        strHex += hexLtr.toString();
    }

    return strHex;
}
/*
* Удаляет все пробелы и их Hex представление (20) из строки
*/
function ReplaceAllWS(sText) {
    var sOldText = sText;
    var sNewText = sText.replace('20', '').replace(' ', '');
    var bHasChg = (sOldText != sNewText);

    while (bHasChg) {
        sOldText = sNewText;
        sNewText = sOldText.replace('20', '').replace(' ', '');
        bHasChg = (sOldText != sNewText);
    }

    return sNewText;
}
/*
* Показать окно для загрузки компонент
*/
/* ----------------------------------------------------
* Блок основных функций
* ----------------------------------------------------*/

function obj_Sign() {
    // -------------- объекты --------------------
    this.gActiveXName = "BARSAX.RSAC";  // имя для ActiveX
    this.aSigner; 						// объект для наложения ЭЦП
    this.xmlErrorData = new ActiveXObject('MSXML2.DOMDocument'); // объект для записи ошибок подписи

    // ------ глобальные параметры подписи --------
    // -- не зависят от документа
    this.num_INTSIGN = -1; 				// INTSIGN - флаг внутренней ЭЦП
    this.num_VISASIGN = -1; 				// VISASIGN - флаг ЭЦП на визах
    this.num_SEPNUM = -1; 				// SEPNUM - номер версии СЭП (1/2)
    this.SIGNTYPE = ''; 					// SIGNTYPE - тип подписи
    this.num_SIGNLNG = -1; 				// SIGNLNG - длина подписи
    this.DOCKEY = ''; 					// DOCKEY - ключ операциониста
    this.REGNCODE = ''; 					// REG_CODE - код региона нужен для VEGA
    this.BDATE = ''; 					// BDATE - банковская дата

    // ------ Инициализация объекта --------
    this.initObject = function (paramsObj) {
        if (paramsObj['INTSIGN'] != null) this.num_INTSIGN = parseInt(paramsObj['INTSIGN']);
        if (paramsObj['VISASIGN'] != null) this.num_VISASIGN = parseInt(paramsObj['VISASIGN']);
        if (paramsObj['SEPNUM'] != null) this.num_SEPNUM = parseInt(paramsObj['SEPNUM']);
        if (paramsObj['SIGNTYPE'] != null) this.SIGNTYPE = paramsObj['SIGNTYPE'];
        if (paramsObj['SIGNLNG'] != null) this.num_SIGNLNG = parseInt(paramsObj['SIGNLNG']);
        if (paramsObj['DOCKEY'] != null) this.DOCKEY = paramsObj['DOCKEY'];
        if (paramsObj['REGNCODE'] != null) this.REGNCODE = paramsObj['REGNCODE'];
        if (paramsObj['BDATE'] != null) this.BDATE = paramsObj['BDATE'];

        // инициализация ХМЛ ошибок
        var strXmlText = '<?xml version="1.0" ?>';
        strXmlText += '<ROOT>';
        strXmlText += '<ISERR>0</ISERR>';
        strXmlText += '</ROOT>';
        this.xmlErrorData.loadXML(strXmlText);

        // смотрим не VEGA ли это
        if (this.SIGNTYPE == 'VEG' && this.DOCKEY.length == 6)
            this.DOCKEY = this.REGNCODE + this.DOCKEY;

        return 1;
    }

    // ------ системные параметры подписи --------
    this.num_FLI = ''; 					// FLI - флаг типа документа: 0-внутр., 1-СЭП НБУ, 2-SWIFT, 3-Процессинг СЭП
    this.num_SIGN_FLAG = ''; 			// SIGN_FLAG - флаг ЭЦП (0-нет,1-внутр,2-внешн,3-внутр+внешн)
    this.num_CHECK_FLAG = 3; 			// CHECK_FLAG - флаг нужнали проверка внутр подписи (0-нет,1-внутр,2-внешн,3-внутр+внешн), по дефолту проверяем обе

    // - инициализация системных параметров подписи --
    this.initSystemParams = function (paramsObj) {
        if (paramsObj['FLI'] != null) this.num_FLI = parseInt(paramsObj['FLI']);
        if (paramsObj['SIGN_FLAG'] != null) this.num_SIGN_FLAG = parseInt(paramsObj['SIGN_FLAG']);
        if (paramsObj['CHECK_FLAG'] != null) this.num_CHECK_FLAG = parseInt(paramsObj['CHECK_FLAG']);
    }

    // --------- параметры документа -------------
    this.DOCSIGN = '';    					// подпись на документе
    this.DOCSIGN_INT = ''; 				// внутреняя подпись на документе
    this.BUFFER = ''; 					// буффер документа
    this.BUFFER_INT = ''; 				// буффер документа для внутреней ЭЦП

    this.num_VOB = 0; 					// VOB - вид документа
    this.num_VOB2SEP = 0; 				// VOB2SEP - вид документа (СЕП)
    this.DocN = ''; 						// DocN - номер документа
    this.DOCREF = ''; 					// DOCREF - референс документа

    // - инициализация параметров документа --
    this.initDocParams = function (paramsObj) {
        if (paramsObj['DOCREF'] != null) this.DOCREF = paramsObj['DOCREF'];
        if (paramsObj['VOB2SEP'] != null) this.num_VOB2SEP = parseInt(paramsObj['VOB2SEP']);
        if (paramsObj['BUFFER'] != null) this.BUFFER = paramsObj['BUFFER'];
        if (paramsObj['BUFFER_INT'] != null) this.BUFFER_INT = paramsObj['BUFFER_INT'];

        if (paramsObj['DocN'] == null || paramsObj['DocN'] == '') this.DocN = this.DOCREF;
        else this.DocN = paramsObj['DocN'];

        this.DOCSIGN = '';
        this.DOCSIGN_INT = '';

        // разбираемся с видом документа
        if (paramsObj['VOB'] != null) {
            this.num_VOB = parseInt(paramsObj['VOB']);
            if (1 != this.num_VOB && 2 != this.num_VOB && 6 != this.num_VOB && 33 != this.num_VOB && 81 != this.num_VOB)
                this.num_VOB = this.num_VOB2SEP;
        }
    }

    // ------- параметры подписи CapiCom --------
    this.CERTNAME = '' 						//CERTNAME - имя сертификата

    // - инициализация параметров документа --
    this.initCapiComParams = function (paramsObj) {
        if (paramsObj['CERTNAME'] != null) this.CERTNAME = paramsObj['CERTNAME'];
    }

    // ------- вспомогательные функ класса ------
    /*
    * InitSigner() - выполняет инициализацию объекта для наложения ЭЦП
    */
    this.initSigner = function () {
        try {
            if (this.SIGNTYPE == "SL2")
                this.gActiveXName = "Bars.SL2Plugin";
            var parentDocum = window.top; 
			if (parent.frames.length != 0 && parent.frames["header"] )
			    parentDocum = parent.frames["header"];
			else if (parent.parent.frames.length != 0 && parent.parent.frames["header"] )
			    parentDocum = parent.parent.frames["header"];
			
			if (parentDocum.oSigner) {
		        this.aSigner = parentDocum.oSigner;
		    } else {
		        this.aSigner = new ActiveXObject(this.gActiveXName);
		        parentDocum.oSigner = this.aSigner;       
		    }
			
            /*if (parent.frames.length != 0 && parent.frames["header"] && parent.frames["header"].oSigner != null)
                this.aSigner = parent.frames["header"].oSigner;
            else if (parent.parent.frames.length != 0 && parent.parent.frames["header"] && parent.parent.frames["header"].oSigner != null)
                this.aSigner = parent.parent.frames["header"].oSigner;

            if (!this.aSigner) this.aSigner = new ActiveXObject(this.gActiveXName);

            if (parent.frames.length != 0 && parent.frames["header"])
                parent.frames["header"].oSigner = this.aSigner;
            else if (parent.parent.frames.length != 0 && parent.parent.frames["header"])
                parent.parent.frames["header"].oSigner = this.aSigner;*/
        }
        catch (e) {
            alert('Не обнаружено необходимых для цифровой подписи компонентов.\nОбратитесь к администратору.');
            return 0;
        }
        if (!this.aSigner.IsInitialized) this.aSigner.Init(this.SIGNTYPE);
        if (!this.aSigner.IsInitialized) {
            alert("Система безопасности НЕ инициализирована.\nВозможно не установлены все необходимые компоненты.\nОбратитесь к администратору.");
            return 0;
        }
        return 1;
    }
    /*
    * Проверяет нужно ли на текущем документе\визе ЭЦП
    */
    this.needToBeSign = function () {
        //требуется внешняя подпись
        if ((1 == this.num_INTSIGN && 0 == this.num_FLI)// включена внешняя ЭЦП на внутренних документах
		|| (1 == this.num_FLI && (0 == this.num_INTSIGN || 1 == this.num_INTSIGN)) // документ Межбанковский СЭП-НБУ
        // или включена ЭЦП 2-го вида и требуется внешняя ЭЦП на документ
		|| 2 == this.num_INTSIGN && (2 == this.num_SIGN_FLAG || 3 == this.num_SIGN_FLAG))
            return true;

        //требуется внутренняя ЭЦП на документ
        if (this.num_VISASIGN != 0)
            if (2 == this.num_INTSIGN && (1 == this.num_SIGN_FLAG || 3 == this.num_SIGN_FLAG))
                return true;

        return false;
    }

    /*  -----------------------------------------
    *	Процедуры подулучения подписаного буффера
    *  ---------------------------------------*/

    /* ------- получение подписи CapiCom ----
    * getCapiComSign()
    * Перед выполнением функции: 
    * 1. проинициализировать класс obj_Sign,
    * 2. выполнить инициализацию параметров документа initDocParams
    * 3. выполнить инициализацию параметров подписи CapiCom initCapiComParams
    * В случае неудачи функция возвращает 0 и выдает alert()
    * В случае успешного выполнения функция возвращает 1 и сохраняет в переменную подписаный буффер
    * для получения необходимо обратиться к переменной класса this.DOCSIGN
    */
    this.getCapiComSign = function () {
        try {
            var sign = GetSignForDocument(this.BUFFER, this.CERTNAME);

            if (null == sign || 0 == sign.length) {
                this.writeErrorMsg(this.DOCREF, 'Подписанный буффер пустой!');

                this.DOCSIGN = '';

                return 0;
            }
            else this.DOCSIGN = sign;
        }
        catch (e) {
            this.DOCSIGN = ''

            var err_txt = "Ошибки при наложении ЭЦП CapiCom.\n\n"
            err_txt += "Описание : " + e.description;

            this.writeErrorMsg(this.DOCREF, err_txt);

            return 0;
        }

        return 1;
    }

    /* ------- получение подписи ----
    * getSign()
    * Перед выполнением функции: 
    * 1. проинициализировать класс obj_Sign,
    * 2. выполнить инициализацию параметров документа initDocParams
    * В случае неудачи функция возвращает 0 и выдает alert()
    * В случае успешного выполнения функция возвращает 1 и сохраняет в переменную подписаный буффер
    * для получения необходимо обратиться к переменной класса this.DOCSIGN(и this.DOCSIGN_INT)
    */
    this.getSign = function () {
        this.DOCSIGN = "";
        this.DOCSIGN_INT = "";

        // нужна ли подпись
        if (this.needToBeSign()) {
            // необходимо подписать по принципу СЭП
            if (!this.initSigner(this.SIGNTYPE))
                return 0;

            // ключ операциониста
            this.aSigner.IdOper = this.DOCKEY;
            // обратное присвоение на случай если ключ прописан локально в реестре
            this.DOCKEY = this.aSigner.IdOper;

            // устанавливаем банковскую дату
            if (this.aSigner.BankDate == null || this.aSigner.BankDate == '') this.aSigner.BankDate = this.BDATE;
            else this.BDATE = this.aSigner.BankDate;

            // обработка версии СЭП (1/2)
            if (1 == this.num_SEPNUM)
                this.aSigner.BufferEncoding = "DOS";
            else
                this.aSigner.BufferEncoding = "WIN";
            
            // пишем в протокол REF документа
            if (this.aSigner.GetMajorVersion == 1 && this.aSigner.GetMinorVersion > 22)
                this.aSigner.ProtData = this.DOCREF;
        }

        // включена внешняя ЭЦП на внутренних документах
        if ((1 == this.num_INTSIGN && 0 == this.num_FLI)
        // документ Межбанковский СЭП-НБУ
		  || (1 == this.num_FLI && (0 == this.num_INTSIGN || 1 == this.num_INTSIGN))
        // или включена ЭЦП 2-го вида и требуется внешняя ЭЦП на документ
		  || 2 == this.num_INTSIGN && (2 == this.num_SIGN_FLAG || 3 == this.num_SIGN_FLAG)) {
            var aSignBuf = this.aSigner.SignBufferHex(this.BUFFER);
            if (0 == aSignBuf.length) {
                this.writeErrorMsg(this.DOCREF, 'Ошибки при наложении ЭЦП');

                return 0;
            }
            else {
                this.DOCSIGN = aSignBuf;
            }
        }

        // включена ЭЦП 2-го вида и требуется внутренняя ЭЦП на документ
        if (this.num_VISASIGN != 0)
            if (2 == this.num_INTSIGN && (1 == this.num_SIGN_FLAG || 3 == this.num_SIGN_FLAG)) {
                this.aSigner.BufferEncoding = "WIN";
                // наложение самой ЭЦП
                var aSignBuf = this.aSigner.SignBufferHex(this.BUFFER_INT);
                if (0 == aSignBuf.length) {
                    this.writeErrorMsg(this.DOCREF, 'Ошибки при наложении ЭЦП');

                    return 0;
                }
                else {
                    this.DOCSIGN_INT = aSignBuf;
                }
            }

        return 1;
    }

    /* ------- получение ключа операциониста ----
    * getIdOper()
    * Перед выполнением функции: 
    * 1. проинициализировать класс obj_Sign,
    * 2. выполнить инициализацию параметров документа initDocParams
    * Фунция возвращает реальны ключ (берет с реестра если он задан)
    */
    this.getIdOper = function () {
        // нужна ли подпись
        if (this.needToBeSign()) {
            // необходимо подписать по принципу СЭП
            if (!this.initSigner(this.SIGNTYPE))
                return '';

            // ключ операциониста
            this.aSigner.IdOper = this.DOCKEY;
            // обратное присвоение на случай если ключ прописан локально в реестре
            this.DOCKEY = this.aSigner.IdOper;
        }

        return this.DOCKEY;
    }
    /* ------- пороверка подписи ----
    * VerifySignature()
    * Перед выполнением функции: 
    * 1. проинициализировать класс obj_Sign,
    * 2. выполнить инициализацию параметров документа initDocParams
    * В случае неудачи функция возвращает 0 и выдает alert()
    * В случае успешного выполнения функция возвращает 1 и сохраняет в переменную подписаный буффер
    */
    this.VerifySignature = function () {
        // -- нужна проверка --
        if (this.needToBeSign()) {
            // необходимо подписать по принципу СЭП
            if (!this.initSigner(this.SIGNTYPE))
                return 0;

            // ключ операциониста
            this.aSigner.IdOper = this.DOCKEY;
            // обратное присвоение на случай если ключ прописан локально в реестре
            this.DOCKEY = this.aSigner.IdOper;

            // устанавливаем банковскую дату
            if (this.aSigner.BankDate != null && this.aSigner.BankDate != '') this.BDATE = this.aSigner.BankDate;
            else this.aSigner.BankDate = this.BDATE;

            // обработка версии СЭП (1/2)
            if (1 == this.num_SEPNUM)
                this.aSigner.BufferEncoding = "DOS";
            else
                this.aSigner.BufferEncoding = "WIN";
            
            // пишем в протокол REF документа
            if (this.aSigner.GetMajorVersion == 1 && this.aSigner.GetMinorVersion > 22)
                this.aSigner.ProtData = this.DOCREF;
        }

        // результат проверки
        var res = '';

        // проверка внутреней подписи
        if ((1 == this.num_SIGN_FLAG || 3 == this.num_SIGN_FLAG) && this.num_VISASIGN != 0 && (this.num_CHECK_FLAG == 1 || this.num_CHECK_FLAG == 3)) {
            var buff_lng = this.BUFFER_INT.length;
            var keyLng = 6 * 2;
            var signLng = this.num_SIGNLNG * 2;
            var buff = this.BUFFER_INT.substring(0, buff_lng - (keyLng + signLng));
            var sign = this.BUFFER_INT.substr(buff_lng - signLng, buff_lng);
            var key = this.BUFFER_INT.substr(buff_lng - (keyLng + signLng), keyLng);
            key = GetBinFromHex(key);

            var errText = '';
            // проверяем подпись если она есть
            if (ReplaceAllWS(sign) != '')
                res = this.aSigner.SilentVerifySignatureHex(buff, sign, key, errText);
        }

        // проверка внешней подписи
        if (res == '' && (2 == this.num_SIGN_FLAG || 3 == this.num_SIGN_FLAG) && (this.num_CHECK_FLAG == 2 || this.num_CHECK_FLAG == 3)) {
            var buff_lng = this.BUFFER.length;
            var keyLng = 6;
            var signLng = this.num_SIGNLNG * 2;
            var buff = this.BUFFER.substring(0, buff_lng - (keyLng + signLng));
            var sign = this.BUFFER.substr(buff_lng - signLng, buff_lng);
            var key = this.BUFFER.substr(buff_lng - (keyLng + signLng), keyLng);

            var errText = '';
            // проверяем подпись если она есть
            if (ReplaceAllWS(sign) != '') {
                res = this.aSigner.SilentVerifySignatureHex(buff, sign, key, errText);
            }
        }

        if (res == '') return 1;
        else {
            this.writeErrorMsg(this.DOCREF, res);

            return 0;
        }
    }
    /* ------- процедура формирования файла ошибок визирования ----
    * writeErrorMsg(ref, msg)
    * ref - референс документа на котором произошла ошибка (если для всех, то ref="all")
    * msg - текст сообщения
    */
    this.writeErrorMsg = function (ref, msg) {
        var doc = this.xmlErrorData.documentElement;

        var isErr = doc.getElementsByTagName('ISERR')[0];
        isErr.text = 1;

        var err = this.xmlErrorData.createElement('ERR');
        doc.appendChild(err);

        var errRef = this.xmlErrorData.createElement('REF');
        errRef.text = (ref == '') ? ('all') : (ref);
        var errMsg = this.xmlErrorData.createElement('MSG');
        errMsg.text = msg;

        err.appendChild(errRef);
        err.appendChild(errMsg);
    }
    /* ------- процедура формирования диалога ошибок визирования ----
    * showErrorsDialog()
    * возвращает 0(1) если ошибок нет(есть)
    */
    this.showErrorsDialog = function () {
        var doc = this.xmlErrorData.documentElement;
        var isErr = (doc.getElementsByTagName('ISERR')[0]).text;

        if (isErr == '1') {
            var errors = doc.getElementsByTagName('ERR');
            var msgText = 'Ошибки ЭЦП';

            for (i1 = 0; i1 < errors.length; i1++) {
                var error = errors[i1];

                var errRef = error.getElementsByTagName('REF')[0].text;
                var errMsg = error.getElementsByTagName('MSG')[0].text;

                if (errRef == 'all') {
                    msgText += '<BR>' + errMsg;
                }
                else {
                    msgText += '<BR>№' + errRef + ' : ' + errMsg;
                }
            }

            var msgTextEsc = escape(msgText);
            if (msgTextEsc.length > 2000) {
                msgTextEsc = msgTextEsc.substring(0, 2000) + escape('<BR>...');
            }

            window.showModalDialog("dialog.aspx?type=1&message=" + msgTextEsc, 'dialogHeight:300px; dialogWidth:400px');

            return 1;
        }
        else return 0;
    }
}