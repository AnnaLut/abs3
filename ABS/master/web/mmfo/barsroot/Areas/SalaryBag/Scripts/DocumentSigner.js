(function () {
    $.support.cors = true;

    _signer = {};
    var TOKEN_ID = "vega2";
    var MODULE_NAME = "vega2";
    //var _SIGNER_URL = 'http://local.barscryptor.net:31140/';
    var _SIGNER_URL = 'http://localhost:31140/';
    //var _SIGNER_URL = 'http://127.0.0.1:31140/';


    var _SIGNER_URLS = 'https://local.barscryptor.net:31139/';

    var SIGNER_URL = location.protocol.toLowerCase() == 'http:' ? _SIGNER_URL : _SIGNER_URLS;

    function Signer(url_) {
        var start_url = url_;

        this.GetKeys = function (obj, cbSuccess, cbError) {
            makeQuery(JSON.stringify(obj), 'keys', cbSuccess, cbError);
        };

        this.GetTokens = function (cbSuccess, cbError) {
            makeQuery('', 'tokens', cbSuccess, cbError);
        };

        this.Init = function (obj, cbSuccess, cbError) {
            makeQuery(JSON.stringify(obj), 'init', cbSuccess, cbError);
        };

        this.Sign = function (obj, cbSuccess, cbError) {
            makeQuery(JSON.stringify(obj), 'sign', cbSuccess, cbError);
        };

        this.Validate = function (obj, cbSuccess, cbError) {
            makeQuery(JSON.stringify(obj), 'validate', cbSuccess, cbError);
        };

        function makeQuery(json, url, cbSuccess, cbError) {
            $.ajax({
                type: 'POST',
                url: start_url + url,
                crossDomain: true,
                data: json,
                dataType: 'json',
                success: cbSuccess,
                error: cbError
            });
        };
    };

    _signer.g_signer = new Signer(SIGNER_URL);

    _signer.keys = {};
    _signer.currentKeyToUse = {};

    _signer.initSign = function (cbFunc) {
        _signer.g_signer.Init({ TokenId: TOKEN_ID, ModuleName: MODULE_NAME },
            function (response) {
                if (response.State == "OK") {
                    _signer.g_signer.GetKeys({ TokenId: TOKEN_ID, ModuleName: MODULE_NAME },
                        function (keyResponse) {
                            if (keyResponse.State == "OK" && keyResponse.Keys.length > 0) {
                                _signer.keys = keyResponse.Keys;

                                $.ajax({
                                    type: 'GET',
                                    url: bars.config.urlContent("/api/SalaryBag/SalaryBag/GetCurrentUserSubjectSN"),
                                    success: function (result) {
                                        for (var i = 0; i < _signer.keys.length; i++) {
                                            if (_signer.keys[i].SubjectSN.toLowerCase() == result.toLowerCase()) {
                                                _signer.currentKeyToUse = _signer.keys[i];
                                            }
                                        }

                                        if (_signer.currentKeyToUse.Id) {
                                            if (cbFunc) cbFunc();
                                        } else {
                                            showECPError("Ключ в базі даних не співпадає з ключем на носії, зверніться до адміністратора!");
                                        }
                                    },
                                    error: function () {
                                        showECPError("Відбулась помилка при запиті цлюча ЕЦП з бази даних!");
                                    }
                                });

                            } else {
                                showECPError("Не знайдено особистих ключів на носії!");
                            }
                        },
                        function () {
                            showECPError("Помилка зв'язку з ЕЦП клієнтом!");
                        });
                }
                else {
                    showECPError('Помилка ініціалізації програмного забезпечення для накладення ЕЦП.<br />Зверніться до адміністратора. ' + response.Error);
                }
            }, function (jqXHR, textStatus, errorThrown) {
                showECPError("Помилка зв'язку з ЕЦП клієнтом!");
            });
    };

    function func(_buffer, _idOper, _id, _subjectSN) {
        return new Promise(function (resolve, reject) {
            var query = { TokenId: TOKEN_ID, IdOper: _idOper, Encoding: 'UTF8', Buffer: _buffer };
            _signer.g_signer.Sign(query,
                function (res) {
                    res.id = _id;
                    res.SubjectSN = _subjectSN;
                    res.buffer = _buffer;
                    if (res.State == "OK") {
                        resolve(res);
                        $signerPopUp.incrementCount();
                    } else {
                        reject(res);
                    }
                },
                function (jqXHR, textStatus, errorThrown) {
                    jqXHR.id = _id;
                    reject(jqXHR);
                });
        });
    };

    var packetCount = 500;
    var totalRes = [];

    _signer.signArray = function (arrayToSign, cbFunction) {
        var tmpArr = arrayToSign;
        packetsArray = [];
        $signerPopUp.setTotalCount(arrayToSign.length);

        _signer.initSign(function () {
            promiseAll(arrayToSign, cbFunction);
        });
    };

    function promiseAll(arrayToSign, cbFunction) {
        var currentPacket;
        if (arrayToSign.length <= packetCount) {
            currentPacket = arrayToSign.splice(0, arrayToSign.length);
        } else {
            currentPacket = arrayToSign.splice(0, packetCount);
        }

        var promiseArr = [];

        for (var i = 0; i < currentPacket.length; i++) {
            promiseArr.push(func(currentPacket[i].buffer, _signer.currentKeyToUse.Id, currentPacket[i].id, _signer.currentKeyToUse.SubjectSN));
        }

        Promise.all(promiseArr).then(
            function (result) {
                totalRes.push.apply(totalRes, result);
                if (arrayToSign.length == 0) {
                    cbFunction(totalRes);
                    totalRes = [];
                } else {
                    promiseAll(arrayToSign, cbFunction);
                }
            },
            function (error) {
                $signerPopUp.PopUpShowResults(false, "Помилка при підписанні : " + error.message);
            }
        );
    };

    function showECPError(_text) {
        $signerPopUp.PopUpShowResults(false, "ЕЦП!<br />" + _text);
    };

    window.$signer = _signer;
})();

function signAllPayrollDocuments(_ids, isPayroll, cbFunc) {
    $signerPopUp.initPopup(isPayroll, _ids.length);
    $signerPopUp.PopUpShow();

    cbFunc = cbFunc || function () { };

    var promise = new Promise(
        function (resolve, reject) {
            $.ajax({
                type: "POST",
                url: bars.config.urlContent("/api/SalaryBag/SalaryBag/GetDocsToSign"),
                data: {
                    pIds: _ids,
                    isPayroll: isPayroll
                },
                success: function (data) {
                    $signerPopUp.infoUploadFinished();
                    resolve(data);
                }
            });
        });

    //var time = performance.now();

    promise.then(
        function (result) {
            $signer.signArray(result, function (res) {
                //var p = performance.now() - time;
                //console.log('signing time = ' + p);
                $signerPopUp.signsReady();
                cbFunc(res);
            });
        },
        function (error) {
            bars.ui.error({ text: error });
        }
    );
};

(function () {
    var _$signerPopUp = {};

    var popupSelectorAll = '.b-popup, .b-popup-content';
    var countDone = 0;
    var totalPayrollCount = 0;

    _$signerPopUp.incrementCount = function () {
        countDone++;
        $('.b-popup-content').find('#popup_allready_signed_count').text(countDone);
    };

    _$signerPopUp.infoUploadFinished = function () {
        $('.b-popup-content').find('#popupInfoUploading label:first').html('&#10004; Дані завантажено.');
        removeLoadingDots();
        popupPosition();
    };

    _$signerPopUp.setTotalCount = function (count) {
        $('.b-popup-content').find('#popupCounts, #_popupCounts').removeClass('invisible');
        $('.b-popup-content').find('#popup_total_count').text(count);
    };

    _$signerPopUp.signsReady = function () {
        $('.b-popup-content').find('#popupCounts, #_popupCounts').addClass('invisible');
        countDone = 0;
        $('.b-popup-content').find('#popupSignsOk, #_popupSignsOk').removeClass('invisible');

        var saveResLbl = $('.b-popup-content').find('#popupSaveResults');
        $('.b-popup-content').find('#_popupSaveResults').removeClass('invisible');

        saveResLbl.removeClass('invisible');
        addLoadingDots(saveResLbl);
        popupPosition();
    };

    _$signerPopUp.incrementPayrollsReadyCount = function () {
        countDone++;
        $('.b-popup-content').find('#payrollsReadyCount').text(countDone);
    };

    _$signerPopUp.initPopup = function (isPay, count) {
        totalPayrollCount = isPay ? count : 0;

        var headerText = isPay ? 'Зарахування відомостей' : 'Підтвердження відомості';
        var resultsText = isPay ? 'Зараховуємо відомості (готово <label id="payrollsReadyCount">0</label> з ' + count + ')' : 'Триває збереження';
        var signOkText = '&#10004; Підписи сформовано.';
        var countsText = 'підписів';

        $(popupSelectorAll).remove();

        $('body').append(
            '     <div class="b-popup"></div>'
            + '     <div class="b-popup-content">'
            + '        <h2 style="margin-bottom:20px;">' + headerText + '</h2>'
            + '        <div id="popupInfoUploading"><label>Завантаження інформації для підписання</label></div><hr id="_popupInfoUploading" class="popUpHr"/>'
            + '        <div id="popupCounts" class="invisible">Формування ' + countsText + ': <label id="popup_allready_signed_count">0</label> (Всього <label id="popup_total_count"></label>)</div><hr id="_popupCounts" class="popUpHr invisible"/>'
            + '        <div id="popupSignsOk" class="invisible"><label>' + signOkText + '</label></div><hr id="_popupSignsOk" style="margin:3px;" class="popUpHr invisible"/>'
            + '        <div id="popupSaveResults" class="invisible"><label>' + resultsText + '</label></div><hr id="_popupSaveResults" style="margin:3px;" class="popUpHr invisible"/>'
            + '        <button onclick="$signerPopUp.PopUpHide();" class="invisible"></button>'
            + '     </div>'
        );

        $(window).on('resize', popupPosition);
        popupPosition();
        countDone = 0;
        addLoadingDots($('.b-popup-content #popupInfoUploading'));
    };

    var loadingDotsInterval;
    function addLoadingDots(elem) {
        elem.append('<hr class="dotter" style="border-top: 0px;margin:1px;"/><label class="dotter"></label>');
        var dotsCount = 1;
        var lbl = $('.b-popup-content label.dotter');
        loadingDotsInterval = setInterval(function () {
            if (dotsCount != 15) dotsCount++;
            else dotsCount = 1;

            lbl.html(dots(dotsCount));
        }, 200);
    };
    function removeLoadingDots() {
        clearInterval(loadingDotsInterval);
        $('.dotter').remove();
    };
    var dot = '&#8226;';
    function dots(index) {
        if (index < 1 || index > 15) return dot;
        var res = '';
        for (var i = 1; i < 16; i++) {
            if (i <= index) res += dot;
            else res += ' ';
        }
        return res;
    };

    function popupPosition() {
        var sh = $(".b-popup-content").height();
        var sw = $(".b-popup-content").width();

        var dh = $('body').height();
        var dw = $('body').width();
        var marginTop = (dh - sh) / 2;
        var marginLeft = (dw - sw) / 2;

        $(".b-popup-content").css("margin-top", (marginTop * 0.9) + "px");
        $(".b-popup-content").css("margin-left", marginLeft + "px");
    };

    _$signerPopUp.destroyPopup = function () {
        $(popupSelectorAll).remove();
    };
    _$signerPopUp.PopUpShow = function () {
        $(popupSelectorAll).fadeIn('fast');
    };
    _$signerPopUp.PopUpHide = function () {
        $(popupSelectorAll).fadeOut('fast');
        $(window).off('resize', popupPosition);
        func();
    };

    var func;
    _$signerPopUp.PopUpShowResults = function (isOk, msg, cbFunction) {
        func = cbFunction || function () { };
        removeLoadingDots();

        if (isOk) {
            $('.b-popup-content #popupSaveResults label').html('&#10004; Виконано.');
        } else {
            $('.b-popup-content ').find('div:visible:last').html('&#10008; Помилка.');
        }

        $('.b-popup-content').append('<div id="popupTotalResults"><br />' + msg + '</div>');
        $('.b-popup-content button').removeClass('invisible').text(isOk ? 'OK ;)' : 'OK ;(');
        popupPosition();
    };

    window.$signerPopUp = _$signerPopUp;
})();