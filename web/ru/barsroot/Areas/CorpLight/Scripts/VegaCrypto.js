/// криптомодуль ВЕГА
/// Параметри:
///  pIssuerName - string: рядок, що допомогає фільтрувати пошук списку сертифікатів в сховищі за приналежністю до ЦСК;
///  pUseCrl - boolean: використовувати чи ні перевірку сертифікатів по CRL;
///  pUseOcsp - boolean: використовувати чи ні перевірку сертифікатів по OCSP;
///  pOperatorId - string: ідентифікатор ролі оператора АРМ
var VegaCrypto = function (pIssuerName, pUseCrl, pUseOcsp, pOperatorId) {

    var vegaCertificate = null;
    var vegaEnroll = null;
    var vegaConstants = null;
    var vegaRequest = null;
    var ready = false;

    //   var startUpOid = pStartupOid;
    var useOcsp = pUseOcsp;
    var useCrl = pUseCrl;
    var vegaIssuerName = pIssuerName;
    var vegaOperatorId = pOperatorId;

    //=========================================================================
    //--------- чистка строк -------------------------------------------------
    //String.prototype.ltrim = function () {
    //    return this.replace(/^\s+/g, "");
    //};
    //String.prototype.rtrim = function () {
    //    return this.replace(/\s+$/g, "");
    //};
    //String.prototype.trim = function () {
    //    return this.replace(/^\s+|\s+$/g, "");
    //};

    var isNullOrEmpty = function (value) {
        return ((value == null) || (typeof value === "undefined") || (value === ""));
    };

    function CreateObject(objname) {

        if (window.ActiveXObject || "ActiveXObject" in window)
            var obj = new ActiveXObject(objname);
        if (obj == null)
            alert(alertMessage(0xA0000001) + ". Object=" + objname);
        return obj;
    };

    function getNowLocalTime() {
        var d = new Date();
        return d.toLocaleString();
    };
    var createObject = function (objname) {

        if (window.ActiveXObject || "ActiveXObject" in window)
            var obj = new ActiveXObject(objname);
        if (obj == null)
            alert(alertMessage(0xA0000001) + ". Object=" + objname);
        return obj;
    };

    var localDictionary = (function () {
        var keys = new Array();

        function add() {
            for (var c = 0; c < add.arguments.length; c += 2) {
                // Add the property
                keys[add.arguments[c]] = add.arguments[c + 1];
                // And add it to the keys array
                keys[keys.length] = add.arguments[c];
            };
        };

        function lookup(key) {
            var msg = keys[key];
            return (msg == undefined) ? "Нерозпізнана помилка" : msg;
        };

        return {
            add: add,
            lookup: lookup
        };
    }
)
();

    localDictionary.add(
    "20000000", "Готово",
    "A0000001", "Поточна версія підтримує лише браузер Internet Explorer 6+",
    "E0000002", "Не встановлено модуль генерування ключів",
    "80020009", "Крипто-токен. Невідомий криптографічний пристрій",
    "8002802B", "Об'єкт не знайдено",
    "80004001", "Не реалізовано",
    "80090003", "Відсутній ключ",
    "80070003", "Недопустиме ім'я файлу",
    "8007000D", "Недопустимі дані",
    "80070103", "Вибраний хеш алгоритм не може використовуватись для підпису",
    "8007007B", "Не задано ім'я файлу",
    "80070015", "Вказаний пристрій не готовий",
    "8007007F", "Помилка архівування ключа",
    "800704C7", "Операція відмінена", //-2147023673
    "80090008", "Криптопровайдер не підтримує заданий алгоритм",
    "80090009", "Криптопровайдер не підтримує вибраних параметрів",
    "8009000A", "Вказано невірний тип об'єкта",
    "8009000F", "Заданий контейнер ключа вже існує",
    "80090016", "Невідомий контейнер ключа",
    "80090019", "Набір ключів не визначений",
    "8009001D", "Помилка ініціалізації криптопровайдера",
    "8009001E", "Не задано серійний номер криптографічного пристрою",
    "80090020", "Внутрішня помилка",
    "80091002", "Невідомий (несумісний) алгоритм",
    "80092002", "Помилка кодування ASN.1",
    "80092004", "Відсутній таємний ключ",
    "80092022", "IA5. Неправильний символ",
    "80092023", "X500. Неправильний символ",
    "80093101", "ASN.1. Ошибка кодирования структури",
    "800A0005", "Неправильний аргумент процедури",
    "800A01B6", "Об'єкт не підтримує цю властивість або метод",
    "800A01BD", "Об'єкт не підтримує цю дію",
    "800A1391", "Помилка javascript. Модуль (об'єкт) не ініційовано",
    "80100006", "Крипто-токен. Недостатньо пам'яті для виконання команди",
    "80100007", "Крипто-токен. Тайм-аут виконання операції",
    "80100008", "Крипто-токен. Буфер даних дуже малий.",
    "80100009", "Крипто-токен. Невідомий криптографічний пристрій",
    "8010000C", "Крипто-токен. Відсутній носій ключа",
    "8010000D", "Крипто-токен. Невідомий носій ключа",
    "80100010", "Крипто-токен. Носій ключа не готовий",
    "80100013", "Крипто-токен. Помилка зв'язку з носієм ключа",
    "8010001D", "Крипто-токен. Відсутній процес управління носієм ключа",
    "8010001E", "Крипто-токен. Процес управління носієм ключа зупинено",
    "8010002E", "Крипто-токен. Відсутній пристрій читання носія ключа",
    "8010001F", "Крипто-токен. Носій заповнений",
    "8010002F", "Крипто-токен. Втрачено дані підчас обміну з носієм ключа",
    "80100030", "Крипто-токен. Не знайдено контейнер ключа на носії",
    "80100067", "Крипто-токен. Помилка носія ключа",
    "80100069", "Крипто-токен. Носій видалено з пристрою",
    "8010006B", "Крипто-токен. Невірний PIN-код",
    "8010006C", "Крипто-токен. Носій заблоковано через перевищення спроб вводу невірного PIN-коду",
    "8010006D", "Крипто-токен. Помилка файлової структури носія ключа",
    "8010006E", "Крипто-токен. Операція перервана користувачем", //-2146434962
    "8010006F", "Крипто-токен. Носій ключа не автентифікований. Введіть PIN-код",
    "8009000D", "Відсутній приватний ключ",
    "80090014", "Невірний тип крипто-провайдера",
    "8009001B", "Тип провайдера не відповідає встановленому",
    "80090023", "Крипто-токен. Не вистачає доступного місця",
    "80090024", "Профіль користувача є тимчасовим профілем",
    "FFFFFFFF", "Відсутнє ім'я файлу",
    // проверка сертификатов
    "800B010A", "Неможливо побудувати ланцюжок до кореневого ЦСК",
    "800B0109", "Відсутня довіра до кореневого ЦСК",
    "80092010", "Сертифікат відкликано",
    "80092012", "Неможливо перевірити статус сертифіката",
    "80092013", "Неможливо перевірити статус сертифіката. Сервер недоступний",
    "80092014", "Цей сертифікат відсутній в базі данных сервера відклику сертифікатів",
    "80096019", "Сертифікат не дійсний через обмеження, що накладені його розширенням",
    "80096004", "Підпис сертифіката не вірний",
    "800B0101", "Термін дії сертифіката вичерпано",
    "800B0102", "Період дії сертифіката повинен бути в межах періоду сертифіката ЦСК",
    "800B010A", "Один чи більше сертифікатів підлеглих ЦСК в ланцюжку відсутні",
    "800B0110", "Неправильне використання сертифіката",
    "800B0113", "Сертифікат не відповідіє вказаній політиці",
    "800B0114", "Сертифікат не дійсний через обмеження розширення імені",
    "8000FFFF", "Несподівана помилка",
    "00000046", "Відсутні повноваження для запису файлу",
    "800710DF", "Пристрій не готовий",

    // сообщения браузера
    "800A01AD", "Помилка завантаження ActiveX VegaCOM.\n\nМожливо не встановлено VegaCryptoPack\nабо необхідно налаштувати систему безпеки браузера.\n\nМожливо включено меню 'Сервіс -> Фільтрація ActiveX'",
    "A0001000", "Сертифікат відсутній",
    "20001001", "Сертифікат встановлено",
    "E0001002", "Помилка встановлення сертифіката.\n\nВідсутній відповідний таємний ключ.\n\nМожливо відсутній ключовий файл або не встановлено крипто-токен",
    "E0001003", "Помилка встановлення сертифіката.",
    "E0001004", "Помилка перегляду сертифіката.",
    "60001005", "Сертифікати для підпису операцій",
    "60001006", "Виберіть сертифікат, який буде використано для підпису операцій",
    "E0001007", "Помилка перевірки підпису",
    "A0001008", "Сертифікат не відповідає політиці застосування. Змінити ?",
    "A0001009", "Сертифікат не встановлено. Встановити ?",
    "E0001010", "Помилка вибору сертифіката для підпису",
    "60001011", "Інформація про сертифікат для підпису збережена",
    "A0001012", "Відсутні сертифікати з політикою",
    "60001013", "Вибір сертифіката",
    "60001014", "Виберіть сертифікат для перевірки",
    "E0001015", "Невідомий постачальник сертифіката",
    "A0001016", "Відсутні сертифікати з шаблоном",
    "A0001017", "Відсутні сертифікати від постачальника",
    "A0001018", "Сертифікат підпису не дійсний",
    "A0001019", "Відсутній підпис PKCS7",
    "A0001020", "Відсутні сертифікати користувача",
    "A0001021", "Статус сертифіката не визначено",
    "A0001022", "Перевірити з використанням CRL ?",
    "A0001023", "Сертифікат не призначений для автентифікації в ",
    "A0001024", "Відсутні чинні сертифікати на поточний момент часу",
    "A0001025", "Стартовий сертифікат не може бути призначений робочим",
    "A0001026", "Не встановлено криптопровайдер VegaCSP",
    "A0001027", "Помилка накладання підпису.\n\nПідпис не поставлено.\n\nПеревірте налаштування безпеки браузера",
    "A0001028", "Термін чинності сертифіката ще не настав",
    "A0001029", "Термін чинності сертифіката вже закінчився",
    "A0001030", "Відсутні стартові сертифікати користувача",
    "A0001031", "Помилка перевірки підпису PKCS10",
    "A0001032", "Недопустимий символ ",
    "A0001033", "Запит не сформовано",
    "A0001034", "Відсутній апаратний носій з необхідним серійним номером",
    "A0001035", "Для формування запиту сертифіката необхідна присутність лище одного пристрою.\nВстановіть пристрій з одним з перелічених серійних номерів:\n",
    "A0001036", "Дозволені серійні номери криптографічних пристроїв",
    "A0001037", "Встановіть пристрій з визначеним серійним номером",
    "A0001038", "Відсутній серійний номер криптографічного пристрою",
    "A0001039", "Підключено",
    "A0001040", "Встановіть пристрій для реєстрації серійного номера"
);
    function toHex(number) {
        var sRight = (number & 0x0FFFFFFF).toString(16).toUpperCase();
        sRight = "0000000".substring(0, 7 - sRight.length) + sRight;
        return ((number >> 28) & 0x0000000F).toString(16).toUpperCase() + sRight;
    };

    function alertMessage(result) {
        var hex = "";
        var h = toHex(result);
        var code = (result & 0x80000000);
        if (toHex(code) === "80000000")
            hex = "0x" + h + ": ";
        return hex + localDictionary.lookup(h);
    }
    function lookupText(result) {
        return localDictionary.lookup(toHex(result));
    };

    var init = function () {
        var result = true;
        if (ready)
            return result;
        var objName = "";
        try {
            objName = "VegaCOM.Certificate";
            if (vegaCertificate == null)
                vegaCertificate = createObject("VegaCOM.Certificate");
            objName = "VegaEnroll.Enroll";
            if (vegaEnroll == null)
                vegaEnroll = createObject("VegaEnroll.Enroll");
            objName = "VegaEnroll.Request";
            if (vegaRequest == null)
                vegaRequest = createObject("VegaEnroll.Request");
            objName = "VegaCOM.Constants";
            if (vegaConstants == null)
                vegaConstants = createObject("VegaCOM.Constants");

            vegaEnroll.Reset();
            ready = true;
        } catch (e) {
            result = false;
            alert(alertMessage(e.number) + "\n\nObject=" + objName);
        }
        return result;
    };

    var close = function () {
        var result = true;
        try {

            vegaCertificate = null;

            vegaEnroll.Reset();
            vegaEnroll = null;

            vegaRequest = null;

            vegaConstants = null;

        } catch (e) {
            result = false;
            alert(alertMessage(e.number));
        }
        return result;
    };

    var cryptoKi = (function () {
        var objCryptoKi;
        var test = function (modelsn, snList) {
            var result = false;
            for (var ix = 0; ix < snList.length; ix++) {
                if (modelsn === snList[ix])
                    result = true;
            }
            return result;
        };

        var init = function (pkcs) {
            if (pkcs === "" || pkcs == null)
                return false;
            if (typeof objCryptoKi === "undefined" || objCryptoKi == null) {
                objCryptoKi = CreateObject("VegaCryptoki.Cryptoki");
                objCryptoKi.SetProvider(pkcs);
            }
            return true;
        };

        var checkToken = function (snList) {
            var info =
        {
            result: false,
            model: "",
            sn: ""
        };
            var hint = "\n";
            for (var ix = 0; ix < snList.length; ix++) {
                hint += "\n";
                hint += snList[ix];
            }
            var counter = ""; // LookupText(0xA0001039) + "\n";
            var title = lookupText(0xA0001036) + ":\n" + hint + "\n\n";
            var message = "";
            while (confirm(title + counter + message + lookupText(0xA0001037))) {
                var isinitialized = false;
                try {
                    message = "";
                    try {
                        objCryptoKi.Initialize();
                    } catch (e) {
                        isinitialized = true;
                        if (e.number !== -2147352567)
                            throw (e);
                    }
                    var slots = objCryptoKi.GetSlots(true);
                    var myslot = 0;
                    var sn = "unknown";
                    var model = "unknown";
                    for (var idx = 1; idx <= slots.Count; idx++) {
                        var slot = slots.Item(idx);
                        if (slot.HasToken) {

                            var ti = null;
                            try {
                                ti = slot.Token.Info;
                                info.sn = ti.SerialNumber;
                                info.model = ti.Model;
                                sn = info.sn;
                                model = info.model;
                            } catch (e) {
                                sn = "unknown";
                                model = "unknown";
                                continue;
                            }
                            myslot++;

                            if (myslot > 0) {
                                try {

                                    message += "Slot " + idx + ", Model = " + model + ", SerialNumber = " + sn + "\n";
                                } catch (e) {
                                    message += "Slot " +
                                    idx +
                                    ", " +
                                    ((e.number === 0x800200E1) ? lookupText(0x80100009) : alertMessage(e.number)) +
                                    "\n";
                                }
                            }

                            if (message !== "")
                                message += "\n";
                        }
                    }
                    if (myslot === 1) {
                        if (test(info.model + "#" + info.sn, snList)) {
                            info.result = true;
                            //     info.model = model;
                            //     info.sn = sn; 
                            break;
                        }
                    }

                } finally {
                    if (!isinitialized)
                        objCryptoKi.Finalize();
                }
            }
            return info;
        };

        var getToken = function () {
            var result = null;
            var repeat = true;
            var message = "";
            var isinitialize = false;
            while (repeat) {
                try {

                    try {
                        objCryptoKi.Initialize();
                    } catch (e) {
                        isinitialize = true;
                        if (e.number !== -2147352567)
                            throw (e);
                    }

                    var slots = objCryptoKi.GetSlots(true);
                    message = "";
                    var myslot = 0;
                    var sn = "unknown";
                    var model = "unknown";
                    var vsn = "unknown";
                    var vmodel = "unknown";
                    var idx = 0;
                    for (idx = 1; idx <= slots.Count; idx++) {
                        var slot = slots.Item(idx);
                        if (slot.HasToken) {

                            var ti = null;
                            try {
                                ti = slot.Token.Info;
                                vsn = ti.SerialNumber;
                                vmodel = ti.Model;
                                sn = vsn;
                                model = vmodel;
                            } catch (e) {
                                sn = "unknown";
                                model = "unknown";
                                continue;
                            }
                            myslot++;

                            if (myslot > 0) {
                                try {
                                    message += "Slot " + idx + ", Model = " + model + ", SerialNumber = " + sn + "\n";
                                } catch (e) {
                                    message += "Slot " +
                                    idx +
                                    ", " +
                                    ((e.number === 0x800200E1) ? lookupText(0x80100009) : alertMessage(e.number)) +
                                    "\n";
                                }
                            }
                            if (message !== "")
                                message += "\n";
                        }
                    }

                    if (myslot === 1) {
                        try {

                            result = { model: vmodel, sn: vsn };
                            repeat = false;

                        } catch (e) {
                            message += "Slot " +
                            idx +
                            ", " +
                            ((e.number === 0x000000E1) ? lookupText(0x80100009) : alertMessage(e.number)) +
                            "\n";
                            break;
                        }
                    }
                } finally {
                    if (!isinitialize)
                        objCryptoKi.Finalize();
                }
                if (result !== null)
                    break;
                var counter = "";
                if (message !== "") {
                    message += "\n";
                    counter = lookupText(0xA0001039) + "\n";
                }
                repeat = confirm(counter + message + lookupText(0xA0001040));
            }
            return result;
        };

        var infoToken = function () {
            var result = null;
            var isinitialize = false;
            try {
                try {
                    objCryptoKi.Initialize();
                } catch (e) {
                    isinitialize = true;
                    if (e.number !== -2147352567)
                        throw (e);
                }
                var slots = objCryptoKi.GetSlots(true);
                var myslot = 0;
                var sn = "unknown";
                var model = "unknown";
                for (var idx = 1; idx <= slots.Count; idx++) {
                    var slot = slots.Item(idx);
                    if (slot.HasToken) {
                        try {
                            var ti = slot.Token.Info;
                            sn = ti.SerialNumber;
                            model = ti.Model;
                        } catch (e) {
                            continue;
                        }
                        myslot++;
                    }
                }

                if (myslot === 1) {
                    result = { model: model, sn: sn };
                }

            } finally {
                if (!isinitialize)
                    objCryptoKi.Finalize();
            }
            return result;
        };

        var close = function () {
            objCryptoKi = null;
        };

        return {
            init: init,
            close: close,
            infoToken: infoToken,
            getToken: getToken,
            checkToken: checkToken
        };

    }
    )
();

    var vegaSign = (function () {
        var ready = false;

        var vegaSigner = null;
        var vegaStore = null;
        var vegaSignedData = null;
        var vegaUtility = null;
        var vegaConverter = null;
        var vegaOcspClient = null;

        var vegacomEncodeBase64 = 1;
        var vegacomEncodeRAW = 0;
        var vegacomStoreCurrentUser = 2;
        var vegacomStoreOpenReadOnly = 0;
        var vegacomCertificateFindSha1Hash = 0;
        var vegacomCertificateFindSubjectName = 1;
        var vegacomCertificateFindIssuerName = 2;
        var vegacomCertificateFindCertificatePolicy = 8;

        var vegacomCertificateFindTemplateName = 4;

        var vegacomEncodingBase64 = 1;
        var vegacomEncodingUtf8 = 14;


        var checkStartup = function (certificate) {
            var status = certificate.IsValid();
            var policies = status.CertificatePolicies();
            if (policies.Count !== 0) {
                for (var k = 0; k < policies.Count; k++)
                    if (policies.Item(k + 1).Value === startUpOid)
                        return true;
            }
            return false;
        };
        var standardCheck = function (certificate) {
            var result = -1;
            if (useCrl === true) {
                try {
                    var state = certificate.IsValid();
                    state.CheckFlag = 495;
                    result = state.Result;
                } catch (e) {
                    result = -1;
                    alert("CRL. \n\n" + localDictionary.Lookup("80092012") + "\n\n" + alertMessage(e.number));
                }
            } else
                result = true;

            return result;
        };

        var isGood = function (certificate) {
            var result = false;
            try {
                if (checkStartup(certificate))
                    return true;
                if (useOcsp === true) {
                    var status = vegaOcspClient.ProcessWith(certificate);
                    if (status != null)
                        if (status === 0)
                            result = true;
                        else if (status !== 1)
                            throw new { number: 0xA0001021 };
                } else
                    result = standardCheck(certificate);
            } catch (e) {
                result = standardCheck(certificate);
            }
            if (result === false)
                alert(alertMessage(0xA0001018));

            return result;

        };

        var initSign = function () {
            var result = true;
            if (ready)
                return result;
            var objName = "";
            try {
                objName = "VegaCOM.Signer";
                if (vegaSigner == null)
                    vegaSigner = CreateObject(objName);
                objName = "VegaCOM.SignedData";
                if (vegaSignedData == null)
                    vegaSignedData = CreateObject(objName);
                objName = "VegaCOM.Utilities";
                if (vegaUtility == null)
                    vegaUtility = CreateObject(objName);
                objName = "VegaCOM.Converter";
                if (vegaConverter == null)
                    vegaConverter = CreateObject(objName);
                objName = "VegaCOM.Store";
                if (vegaStore == null)
                    vegaStore = CreateObject(objName);
                if (isNullOrEmpty(useOcsp)) {
                    objName = "VegaOCSPCli.Handler";
                    if (vegaOcspClient == null)
                        vegaOcspClient = CreateObject(objName);
                }
                objName = "";
                ready = true;
            } catch (e) {
                result = false;
                alert(alertMessage(e.number) + "\n\nObject=" + objName);
            }
            return result;
        };
        var closeSign = function () {
            var result = true;
            try {
                if (vegaSignedData != null)
                    vegaSignedData = null;
                if (vegaUtility != null)
                    vegaUtility = null;
                if (vegaSigner != null)
                    vegaSigner = null;
                if (vegaOcspClient != null)
                    vegaOcspClient = null;
                if (vegaStore != null) {
                    vegaStore.Close();
                    vegaStore = null;
                }
            } catch (e) {
                alert(alertMessage(e.number));
            }
            ready = false;
            return result;
        };
        var setSignerObject = function (thumbprint, policyOid) {
            var checkIssuer = !isNullOrEmpty(vegaIssuerName);
            var byUser = !isNullOrEmpty(vegaOperatorId);
            var userFouded = false;
            var result = false;
            var msg = "";
            var ourCertificates = null;
            var userPolicy = new String(policyOid);
            userPolicy = userPolicy.split(",");
            for (var n = 0; n < userPolicy.length; n++)
                msg += userPolicy[n] + "\n";

            vegaStore.Open(vegacomStoreCurrentUser, "My", vegacomStoreOpenReadOnly);
            if (vegaStore.Certificates.Count === 0) {
                alert(alertMessage(0xA0001017) + " (1)");
                return "canceled";
                //    throw { number: 0xA0001024 };
            }
            var certificates = null;
            if (!isNullOrEmpty(thumbprint)) {
                certificates = vegaStore.Certificates.Find(vegacomCertificateFindSha1Hash, thumbprint, false);
                if ((certificates != null) && (certificates.Count > 0)) {
                    vegaSigner.Certificate = certificates.Item(1);
                    result = true;
                }
            } else {
                if (byUser)
                    certificates = vegaStore.Certificates.Find(vegacomCertificateFindSubjectName, vegaOperatorId, false);
                else if (checkIssuer)
                    certificates = vegaStore.Certificates.Find(vegacomCertificateFindIssuerName, vegaIssuerName, false);
                else
                    certificates = vegaStore.Certificates;
            }
            if (!result)
                if ((certificates != null) && (certificates.Count > 0))
                    userFouded = true;
            var good;
            if (userFouded) {
                if (byUser)
                    if (checkIssuer)
                        ourCertificates = certificates.Find(vegacomCertificateFindIssuerName, vegaIssuerName, false);
                    else
                        ourCertificates = certificates;
                else
                    ourCertificates = certificates;

                if (ourCertificates.Count === 0) {
                    alert(alertMessage(0xA0001017) + " (2)" + "\n\n" + vegaIssuerName);
                    return result;
                }
                if ((ourCertificates != null) && (ourCertificates.Count > 0)) {
                    if (!isNullOrEmpty(policyOid))
                        ourCertificates = ourCertificates.Find(vegacomCertificateFindCertificatePolicy, policyOid, false);
                    if ((ourCertificates != null) && (ourCertificates.Count > 0)) {
                        while (ourCertificates.Count > 0) {
                            var ocertificates = ourCertificates
                                .Select(alertMessage(0x60001005), alertMessage(0x60001006), false);
                            if ((ocertificates != null) && (ocertificates.Count > 0)) {
                                result = false;
                                var crt = ocertificates.Item(1);

                                if (crt.HasPrivateKey() === true)
                                    result = true;
                                else
                                    alert(alertMessage(0x8009000D));

                                if (result === true) {
                                    good = isGood(crt);
                                    if (good === -1)
                                        result = false;
                                    else if (good === false)
                                        result = false;
                                    if (result) {
                                        vegaSigner.Certificate = crt;
                                        return result;
                                    }
                                }
                            } else
                                return "canceled";
                        }
                    } else {
                        alert(alertMessage(0xA0001012) + "\n\n" + msg);
                        return false;
                    }
                } else if (isNullOrEmpty(vegaOperatorId)) {
                    if (checkIssuer)
                        alert(alertMessage(0xA0001023) + "\n\n" + vegaIssuerName);
                    return false;
                }
            }

            if (!result) {
                if (!isNullOrEmpty(policyOid)) {
                    if ((thumbprint == null) && (isNullOrEmpty(vegaOperatorId)))
                        ourCertificates = vegaStore.Certificates
                            .Find(vegacomCertificateFindTemplateName, policyOid, false);
                    else
                        ourCertificates = vegaStore.Certificates
                            .Find(vegacomCertificateFindCertificatePolicy, policyOid, false);
                }
                if (ourCertificates != null) {
                    var certs = ourCertificates;
                    if (checkIssuer)
                        certs = ourCertificates.Find(vegacomCertificateFindIssuerName, vegaIssuerName, false);
                    if (!((certs != null) && (certs.Count > 0))) {
                        if (checkIssuer)
                            alert(alertMessage(0xA0001017) + " (3)" + "\n\n" + vegaIssuerName);
                        return result;
                    }
                    if (!isNullOrEmpty(vegaOperatorId))
                        certs = certs.Find(vegacomCertificateFindSubjectName, vegaOperatorId, false);
                    if ((certs != null) && (certs.Count > 0))
                        certs = certs.Select(alertMessage(0x60001005), alertMessage(0x60001006), false);
                    else if (thumbprint != null)
                        alert(alertMessage(0xA0001012) + "\n\n" + msg);
                    else
                        alert(alertMessage(0xA0001017) + "(4)" + "\n\n" + msg);
                    while ((certs != null) && (certs.Count > 0)) {
                        result = true;
                        good = isGood(certs.Item(1));
                        if (good === -1)
                            result = false;
                        else if (good === false)
                            result = false;
                        if (result) {
                            vegaSigner.Certificate = certs.Item(1);
                            return result;
                        } else
                            alert(alertMessage(0xA0001018));
                        certs = certs.Select(alertMessage(0x60001005), alertMessage(0x60001006), false);
                    }
                }
            }
            if (result)
                if (vegaSigner.Certificate != null) {
                    var okgood = isGood(vegaSigner.Certificate);
                    if (okgood === -1)
                        result = false;
                    else if (okgood === false)
                        result = false;
                }
            return result;
        };

        var checkThumbprint = function (policyOid) {
            var checkIssuer = isNullOrEmpty(vegaIssuerName);
            var result = "";
            if (initSign()) {
                try {
                    var policyOk = false;
                    vegaStore.Open(vegacomStoreCurrentUser, "My", vegacomStoreOpenReadOnly);
                    var ourCertificates = vegaStore.Certificates;
                    if (checkIssuer)
                        ourCertificates = vegaStore.Certificates
                            .Find(vegacomCertificateFindIssuerName, vegaIssuerName, false);
                    if ((ourCertificates != null) && (ourCertificates.Count > 0)) {
                        if (!isNullOrEmpty(vegaOperatorId))
                            ourCertificates = ourCertificates
                                .Find(vegacomCertificateFindSubjectName, vegaOperatorId, false);
                        if ((ourCertificates != null) && (ourCertificates.Count > 0)) {
                            var status = isGood(ourCertificates.Item(1));
                            if (status !== -1) {
                                if (status === true) {
                                    var policies = status.CertificatePolicies();
                                    if (policies.Count !== 0) {
                                        var userPolicy = new String(policyOid);
                                        userPolicy = userPolicy.split(",");
                                        for (var k = 0; k < policies.Count; k++) {
                                            for (var n = 0; n < userPolicy.length; n++)
                                                if (userPolicy[n] === policies.Item(k + 1).Value) {
                                                    policyOk = true;
                                                    break;
                                                }
                                            if (policyOk === true)
                                                break;
                                        }
                                    }
                                    if (policyOk)
                                        result = ourCertificates.Item(1).Export(vegacomEncodingBase64);
                                    else
                                        alert(alertMessage(0xA0001008));
                                }
                            }
                        } else
                            alert(alertMessage(0xA0001020));
                    } else if (checkIssuer)
                        alert(alertMessage(0xA0001017) + " (6)" + "\n\n" + vegaIssuerName);
                } catch (e) {
                    alert(alertMessage(0xE0001010));
                } finally {
                    closeSign();
                }
            }
            return result;
        };

        var checkCertificates = function (templateOid, serialNumber, startup, policyOid) {
            var checkIssuer = isNullOrEmpty(vegaIssuerName);
            var result = null;
            var oCertificates = null;
            var certs = null;
            try {
                if (initSign()) {
                    vegaStore.Open(vegacomStoreCurrentUser, "My", vegacomStoreOpenReadOnly);

                    if (startup)
                        oCertificates = vegaStore.Certificates;
                    else if (checkIssuer)
                        oCertificates = vegaStore.Certificates
                            .Find(vegacomCertificateFindIssuerName, vegaIssuerName, false);
                    else
                        oCertificates = vegaStore.Certificates;

                    if (oCertificates != null && oCertificates.Count > 0) {
                        if (serialNumber !== "")
                            certs = oCertificates.Find(vegacomCertificateFindSubjectName, serialNumber, false);
                        else
                            certs = oCertificates;
                    } else {
                        alert(alertMessage(0xA0001017) + " (5)" + "\n\n" + vegaIssuerName);
                        return "null";
                    }
                    if ((certs != null) && (certs.Count > 0)) {
                        var filter = startup
                            ? vegacomCertificateFindCertificatePolicy
                            : (policyOid == null
                                ? vegacomCertificateFindTemplateName
                                : vegacomCertificateFindCertificatePolicy);
                        if (startup)
                            certs = certs.Find(filter, policyOid, false);
                        else if (policyOid == null) {
                            if (templateOid !== "")
                                certs = certs.Find(filter, templateOid, false);
                        } else
                            certs = certs.Find(filter, policyOid, false);
                    }
                    if (certs != null)
                        while (certs.Count > 0) {
                            oCertificates = certs.Select(alertMessage(0x60001005), alertMessage(0x60001006), false);
                            if (oCertificates.Count > 0) {
                                if (startup) {
                                    result = oCertificates.Item(1);
                                    break;
                                } else {
                                    var status = isGood(oCertificates.Item(1));
                                    if (status === true) {
                                        result = oCertificates.Item(1);
                                        break;
                                    } else
                                        continue;
                                }
                            } else {
                                result = "canceled";
                                break;
                            }
                        }
                }
            } finally {
                closeSign();
            }
            return result;
        };
        var signOwnedData = function (data, certificate, detached) {
            var result = "canceled";
            try {
                if (initSign()) {
                    if (vegaSignedData != null) {
                        if (certificate != null)
                            vegaSigner.Certificate = certificate;
                        //      vegaSigner.Certificate.RefreshProvInfo();
                        vegaSignedData.Content = vegaConverter.StringToBytes(data, vegacomEncodingUtf8);

                        for (var k = 0; k < 3; k++) {
                            try {
                                result = vegaSignedData.Sign(vegaSigner, detached, vegacomEncodeBase64);
                                //   result = vegaUtility.Base64UrlEncode(bytes);
                            } catch (e) {
                                if ((e.number === -2146434965) ||
                                    (e.number === -2146434969) ||
                                    (e.number === -2146823279)) {
                                    alert(alertMessage(e.number));
                                    continue;
                                } else if (e.number === -2146434962)
                                    result = "canceled";
                                else
                                    throw e;
                            }
                            break;
                        }
                    }
                }
            } finally {
                closeSign();
            }
            vegaSignedData = null;
            return result;
        };
        var signData = function (certHash, policyOid, datab64, detached) {
            var result = "canceled";
            try {
                if (initSign()) {
                    if (setSignerObject(certHash, policyOid) === true) {
                        if (vegaSignedData != null) {
                            vegaSignedData.Content = vegaUtility.Base64Decode(datab64);
                            for (var k = 0; k < 3; k++) {
                                try {
                                    var mode = true;
                                    if (detached === false)
                                        mode = false;
                                    result = vegaSignedData.Sign(vegaSigner, mode, vegacomEncodeBase64);
                                    // result = vegaUtility.Base64UrlEncode(bytes);
                                    if (result === "")
                                        throw { number: 0xA0001019 };

                                } catch (e) {
                                    if ((e.number === -2146434965) ||
                                        (e.number === -2146434969) ||
                                        (e.number === -2146823279)) {
                                        alert(alertMessage(e.number));
                                        continue;
                                    }
                                    if (e.number === -2146434962)
                                        result = "canceled";
                                    else if (e.number === -2146435060) {
                                        result = false;
                                    } else
                                        throw e;
                                }
                                break;
                            }
                        }
                    }
                }
            } catch (e) {
                result = "";
                alert(alertMessage(e.number));
            } finally {
                closeSign();
            }
            vegaSignedData = null;

            return result;
        };
        var coSignData = function (certHash, policyOid, pkcs7, datab64, detached) {
            var result = "";
            try {
                if (pkcs7 === "")
                    throw new { number: 0xA0001019 };
                else if (initSign()) {
                    if (detached === true)
                        vegaSignedData.Content = vegaUtility.Base64Decode(datab64);
                    else if (!vegaSignedData.Verify(pkcs7, vegacomEncodeBase64, detached, 0))
                        throw new { number: 0xE0001007 };

                    if (setSignerObject(certHash, policyOid) === true)
                        for (var k = 0; k < 3; k++) {
                            try {
                                result = vegaSignedData.CoSign(vegaSigner, vegacomEncodeBase64);
                                //  result = vegaUtility.Base64UrlEncode(bytes);
                            } catch (e) {
                                if ((e.number === -2146434965) ||
                                            (e.number === -2146434969) ||
                                            (e.number === -2146823279)) {
                                    alert(alertMessage(e.number));
                                    continue;
                                }
                                if (e.number === -2146434962)
                                    result = "canceled";
                                else if (e.number === -2146435060)
                                    result = false;
                                else
                                    throw e;
                            }
                            break;
                        }
                }
            } finally {
                closeSign();
            }
            return result;
        };

        var base64Encode = function (data) {
            var result = "";
            if (initSign()) {
                result = vegaUtility.Base64Encode(vegaConverter.StringToBytes(data, vegacomEncodingUtf8));
            }
            return result;
        };
        var base64Decode = function (dataB64) {
            var result = "";
            if (initSign()) {
                result = vegaConverter.BytesToString(vegaUtility.Base64Decode(dataB64), vegacomEncodingUtf8);
            }
            return result;
        };
        return {
            //public functions
            //  init: init, // ()
            //  close: close, // ()
            signData: signData, // (certHash, policyOid, datab64, detached)
            coSignData: coSignData, // (certHash, policyOid, pkcs7, datab64, detached)
            signOwnedData: signOwnedData, // (data, certificate,detached)
            checkCertificates: checkCertificates, //(templateOid, serialNumber, startup, policyOid)
            checkThumbprint: checkThumbprint, // (policyOid)
            base64Encode: base64Encode,
            base64Decode: base64Decode
        };

    }
    )
();

    var enrollRequest = function (info, pUseToken, pLogToken) {
        var fs = "\f";
        var ts = "\t";
        var request = {
            pkcs10: "",
            model: "",
            sn: "",
            time: getNowLocalTime(),
            pkcs7: ""
        };
        var tokenInfo = {
            result: true,
            model: "",
            sn: ""
        };
        var errorEnroll = 0;
        var data = new String(info).split(fs);

        if (pUseToken) {
            if (data[34] !== "") {
                if (data[35] === "")
                    throw {
                        number: 0xA0001038,
                        description: ""
                    };
                cryptoKi.init(String(data[34]));
                tokenInfo = cryptoKi.checkToken(String(data[35]).split(ts));
            }
        }
        try {
            if (tokenInfo.result) {
                if (init()) {
                    if (!isNullOrEmpty(info)) {
                        var subject = vegaEnroll.Subject;
                        vegaEnroll.cspProvName = data[30];
                        vegaEnroll.cspProvType = parseInt(data[1]);
                        vegaEnroll.cspKeySpec = data[2];
                        if (data[27] === "1") {
                            if (data[20] !== "") {
                                var y = String(data[20]).split(ts);
                                if (y.length > 1) {
                                    var dke = parseInt(y[1], 10);
                                    if (dke > 0)
                                        vegaEnroll.cspGenParams = dke;
                                }
                            }
                        }

                        if (data[31] !== "")
                            vegaEnroll.cspContainerName = data[31];
                        if (data[3] !== "")
                            subject.CommonName = data[3];
                        if (data[4] !== "")
                            subject.Surname = data[4];
                        if (data[5] !== "")
                            subject.GivenName = data[5];

                        if (data[7] !== "")
                            subject.Title = data[7];
                        var altName = "0.9.2342.19200300.100.1.1";
                        if (data[16] !== "")
                            subject.AddValue(altName, data[16]);
                        var desc = "2.5.4.13";
                        if (data[24] !== "")
                            subject.AddValue(desc, data[24]);
                        var pseudonim = "2.5.4.65";
                        var vid = "1.2.804.2.1.1.1.11.23742909.2.4.1";
                        if (data[23] !== "")
                            subject.AddValue(vid, data[23]);
                        if (data[17] != null)
                            if (data[17] !== "")
                                subject.AddValue(pseudonim, data[17]);
                        var ou = new String(data[8]).split(ts);
                        if (ou.length > 0 && ou[0] !== "") {
                            subject.Organization = ou[0];
                            for (var j = 1; j < ou.length > 0; j++)
                                if (ou[j] !== "")
                                    subject.addOrgUnit(ou[j]);
                        } else {
                            if (data[6] !== "")
                                subject.Organization = data[6];
                        }
                        if (data[21] !== "")
                            subject.SerialNumber = data[21];
                        else if (data[9] !== "")
                            subject.SerialNumber = data[9];
                        var addrress = new String(data[10]).split(ts);
                        if (addrress.length > 0) {
                            subject.Country = addrress[0];
                            subject.State = addrress[1];
                            subject.Locality = addrress[2];
                        }
                        var certExtensions = vegaEnroll.CertExtensions;
                        if (data[11] !== "")
                            certExtensions.certTemplateName = data[11];
                        if (data[12] !== "")
                            certExtensions.certTemplateOID = data[12];
                        if (data[32] !== "")
                            vegaEnroll.certFriendlyName = data[32];
                        vegaEnroll.certStoreType = vegaConstants.WIN_SYSTEM_STORE_CURRENT_USER;
                        var hash = parseInt(data[15], 10);
                        if (hash === 0)
                            switch (data[1]) {
                            case "1":
                                hash = 8;
                                break;
                            case "2":
                                hash = 1;
                                break;
                            case "3":
                                hash = 0;
                                break;
                        }

                        vegaEnroll.cspHashAlg = hash;
                        if (data[18] === "1")
                            vegaEnroll.cspGenFlags = vegaConstants.WIN_CRYPT_EXPORTABLE;
                        if (data[33] !== "")
                            vegaEnroll.cspKeyBits = parseInt(data[33], 10);
                        if (data[28] !== "") {
                            var mails = data[28].split(",");
                            for (var k = 0; k < mails.length; k++) {
                                if (mails[k] !== "")
                                    certExtensions.addSubjAltName(2, mails[k]);
                            }
                        }
                        var ownCert = null;

                        if (data[13] === "1") {
                            ownCert = null;
                            if (data[29] === "1")
                                if (data[26] === "1")
                                    ownCert = vegaSign.checkCertificates(data[12], data[25], false, (data[22] === "" ? null : data[22]));
                                else
                                    ownCert = vegaSign.checkCertificates("", data[25], false, null);
                            else if (data[29] === "2")
                                ownCert = vegaSign.checkCertificates(data[0], data[25], true, data[0]);
                            if (ownCert == null) {
                                errorEnroll = 0xE0001010;
                                throw { number: -536866800 };
                            }
                        } else
                            ownCert = "";
                        if (ownCert == null)
                            if (data[29] === "2")
                                alert(alertMessage(0xA0001030));
                            else
                                alert(alertMessage(0xA0001016) + "\n\nTemplate: " + data[11] + "\n\nOid: " + data[12]);
                        else {
                            if ((typeof ownCert === "string") && (ownCert === "null")) {
                            } else if ((typeof ownCert === "string") && (ownCert === "canceled"))
                                throw { number: 0x800704C7 };
                            else
                                for (var m = 0; m < 3; m++) {
                                    errorEnroll = 0;
                                    try {
                                        var etype = 1;
                                        request.pkcs10 = vegaEnroll.GenCertRequest(etype);
                                        vegaRequest.Import(request.pkcs10);
                                        request.pkcs10 = new String(request.pkcs10);
                                        request.time = getNowLocalTime();
                                        if (pLogToken) {
                                            if (data[34] !== "") {
                                                cryptoKi.init(String(data[34]));
                                                var ti = cryptoKi.infoToken();
                                                request.model = ti.model;
                                                request.sn = ti.sn;
                                                request.time = getNowLocalTime();
                                            }
                                        }
                                        if (data[13] === "1") {
                                            if ((data[29] === "1") || (data[29] === "2")) {
                                                if ((typeof ownCert == "string") && (ownCert === "")) {
                                                    request.pkcs10 = "";
                                                    throw { number: 2684358656 };
                                                }
                                                var sign = "";
                                                sign = vegaSign.signOwnedData(request.pkcs10, ownCert);
                                                if (sign === 'invalid') {
                                                    request.pkcs10 = "";
                                                    throw { number: 2684358680 };
                                                } else if (sign !== 'canceled')
                                                    request.pkcs7 = sign;
                                                else {
                                                    request.pkcs10 = "";
                                                    throw { number: 0x800704C7 };
                                                }
                                            }
                                        }
                                    } catch (e) {
                                        errorEnroll = e.number;
                                        if ((errorEnroll === -2146434965) ||
                                            (errorEnroll === -2146434969) ||
                                            (errorEnroll === -2146823279)) //"8010006F"
                                        {
                                            alert(alertMessage(errorEnroll));
                                            continue;
                                        } else if (errorEnroll !== -2146434962)
                                            throw (e);
                                    }
                                    break;
                                }
                        }
                    }
                } else
                    alert(alertMessage(-2146827859));
            } else {
                throw {
                    number: 0x800704C7,
                    description: ""
                };

            }
        }
        finally {
            if (!(typeof cryptoKi == "undefined" || cryptoKi == null))
                cryptoKi.close();
        }
        return request;


    };


    var setCertificate = function (value) {
        var result = false;
        if (init()) {
            try {
                vegaEnroll.InstallCertificate(value);
                result = true;
                alert(alertMessage(0x20001001));
            } catch (e) {
                var er = vegaEnroll.lastError;
                //   var sysErr = e.number;
                if ((e.number === -2147024637) || (e.number === -2146885628))
                    alert(alertMessage(0xE0001002));
                else
                    alert(alertMessage(0xE0001003) +
                        "\n\nAppError: " +
                        toHex(er) +
                        "(" +
                        er +
                        ") - " +
                        alertMessage(er) +
                        "\n\nWinError: " +
                        toHex(e.number) +
                        " - " +
                        alertMessage(e.number));
            }
        }
        return result;
    };
    var installCertificate = function (value) {
        var result = false;
        if (!isNullOrEmpty(value)) {
            result = setCertificate(value);
        } else
            alert(alertMessage(0xA0001000));
        return result;
    };
    var getCertificateThumbprint = function (value) {
        var result = "";
        if (init()) {
            vegaCertificate.Import(value);
            result = vegaCertificate.Thumbprint;
        }
        else throw {
            number: 0x800A01AD,
            description: 'Помилка ініціювання криптографічних засобів'
        }
        return result;
    };
    var displayCertificate = function (value) {
        try {
            if (init()) {
                vegaCertificate.Import(value);
                vegaCertificate.Display();
            }
        } catch (e) {
            alert(alertMessage(0xE0001004) + "\n\n" + alertMessage(e.number) + "\n" + e.description);
        }
    };

    return {
        getCertificateThumbprint: getCertificateThumbprint,
        displayCertificate: displayCertificate,
        installCertificate: installCertificate,
        enrollRequest: enrollRequest,
        signData: vegaSign.signData,
        coSingData: vegaSign.coSignData,
        base64Encode: vegaSign.base64Encode,
        base64Decode: vegaSign.base64Decode,
        alertMessage: alertMessage
    }
}