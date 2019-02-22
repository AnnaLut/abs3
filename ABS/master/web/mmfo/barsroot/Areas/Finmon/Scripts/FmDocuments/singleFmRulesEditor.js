function singleFmRulesEditor() {
    var kendoWindow, bulk;
    var dict = new dictForm();
    var _cbFunction = function () { };

    this.open = function (ref, isBulk, cbFunc) {
        if (!Array.isArray(ref)) throw 'wrong data type in parameter "ref", expected Array but got ' + typeof ref;

        if (cbFunc && typeof cbFunc === 'function') _cbFunction = cbFunc;
        bulk = isBulk;
        intWindow(ref);
    };
    this.close = function () {
        kendoWindow.data('kendoWindow').close();
    };

    function intWindow(ref) {
        bars.ui.loader('body', true);
        $.ajax({
            url: bars.config.urlContent('/api/Finmon/FmDocumentsApi/GetDocumentFmRules'),
            data: {
                refs: ref,
                bulk: bulk
            },
            contentType: "application/json; charset=utf-8",
            success: function (res) {
                res.ClientA = checkClients(res.ClientA);
                res.ClientB = checkClients(res.ClientB);
                res.bulk = bulk;
                res.refs = ref;
                res.Bulk = bulk;

                fillWindow(res, ref);
                kendoWindow.data('kendoWindow').center().open();
                fullWind = $(kendoWindow).closest('.k-widget.k-window');
            },
            complete: function () {
                bars.ui.loader('body', false);
            }
        });
    }
    function fillWindow(data) {
        var _title = bulk ? 'Параметри фінансового моніторингу (Пакетне встановлення)' : 'Параметри фінансового моніторингу, реф <b>' + data.refs[0] + '</b>';
        kendoWindow = $('<div id="rndWindow"/>').kendoWindow({
            actions: ['Close'],
            title: _title,
            resizable: false,
            modal: true,
            draggable: true,
            refresh: function () {
                this.center();
            },
            animation: getAnimationForKWindow({ animationType: { open: 'up', close: 'down' } }),
            deactivate: function () {
                bars.ui.loader('body', false);
                this.destroy();
            },
            activate: function () {
                this.refresh();
            }
        });

        var totalTemplate = loadKendoTemplate(bars.config.urlContent('/Areas/Finmon/Scripts/FmDocuments/tpl/FmRulesEdit.tpl.html'));
        var template = kendo.template(totalTemplate);

        kendoWindow.data('kendoWindow').content(template(data));

        kendoWindow.find('#kdfm02, #kdfm03, #kdfm02add, #kdfm03add').on('click', function () {
            var $this = $(this)[0];
            var number = +$this.id.match(/\d+/g)[0];
            var add = !!~$this.id.indexOf('add');

            dict.open({
                dictName: 'k_dfm0' + number,
                title: number === 2 ? 'Обов\'язковий моніторинг' : 'Внутрішній моніторинг',
                func: function (val) {
                    if (!add) {
                        setParameter(val, $this, number);
                    } else {
                        setAddParameter(val, $this, number);
                    }
                }
            });

            //// ВИНЕСТИ В ГЛОБАЛЬНУ ФУНКУ І НЕЮ СЕТИТИ ЦІ ПАРАМЕТРИ ВСЮДИ !!!!!!!!!!!!!!!!!!!!

            function setAddParameter(val) {
                var tr = $($this).closest('tr');
                var inp = $(tr.find('#Fv' + number + 'Agg')[0]);
                var _val = inp.val();
                inp.val(_val + ' ' + val.Code);

                inp.trigger('blur');
            }
        });
        kendoWindow.find('#btnClientB, #btnClientA').on('click', function () {
            var $this = $(this)[0];
            var side = $this.id.substr(-1);

            CustomerForm(function (val) {
                kendoWindow.find('#Okpo' + side).val(val.Okpo);
                kendoWindow.find('#Rnk' + side).val(val.Rnk);
                kendoWindow.find('#Name' + side).val(val.Name);
            });
        });

        kendoWindow.find('#Fv2Agg, #Fv3Agg').on('keydown', function (e) {
            validateNumber(e, [32]);
        });
        kendoWindow.find('#Fv2Agg, #Fv3Agg').on('blur', function (e) {
            var _val = $(this).val();

            var valArr = _val.split(' ');
            var len = +$(this).data('length');
            var newVal = $.map(valArr, function (v) {
                v = v.trim();
                var _tmpV = v;

                if (v.length < len) _tmpV = '';
                else if (v.length > len) _tmpV = v.substr(0, len);
                if (_tmpV.length === len) return _tmpV;
            });

            newVal = GetUnique(newVal);

            $(this).val(newVal.join(' '));
        });

        function GetUnique(inputArray) {
            var outputArray = [];
            for (var i = 0; i < inputArray.length; i++) {
                if (($.inArray(inputArray[i], outputArray)) == -1) {
                    outputArray.push(inputArray[i]);
                }
            }
            return outputArray;
        }

        kendoWindow.find('#OprVid3, #OprVid2').on('keydown', function (e) {
            validateNumber(e);
        }).on('blur', function (e) {
            var $this = $(this)[0];
            var number = +$this.id.match(/\d+/g)[0];

            var _val = $(this).val();
            if (_val === undefined || _val === null || _val === '') {
                var a = $(this).attr('maxlength');
                _val = new Array(+a + 1).join('0');
            }

            $.ajax({
                url: bars.config.urlContent('/api/Finmon/FmDocumentsApi/GetDict'),
                data: {
                    Code: _val,
                    request: null,
                    dictName: 'k_dfm0' + number
                },
                success: function (res) {
                    if (res && res.Data && res.Data.length) {
                        setParameter(res.Data[0], $this, number);
                    } else {
                        setParameter({ Name: '', Code: '' }, $this, number);
                    }
                }
            });
        });

        kendoWindow.find('#K2Name, #K3Name').kendoTooltip(tooltipOptions());

        kendoWindow.find('input[name="clientsMonitoringSide"]').on('change', function () {
            $('a[id^="btnClient"]').attr('disabled', 'disabled');
            $('#btnClient' + this.value).removeAttr('disabled');

            var finOperCode = $('#finOperCode').val();
            if (finOperCode) {
                var radioVal = $('[name="clientsMonitoringSide"]:checked').val();
                var last = radioVal === 'A' ? '9' : '8';

                finOperCode = finOperCode.substr(0, 14) + last;
                $('#finOperCode').val(finOperCode);
            }
        });

        var sideSelected = '';
        if (data.Md === 'BOTH') {
            if (data.MonitorMode === 1) sideSelected = 'A';
            else if (data.MonitorMode === 2) sideSelected = 'B';
        } else if (data.Md === 'A' || data.Md === 'B') {
            sideSelected = data.Md;
        }
        if (!sideSelected) kendoWindow.find('input[type="radio"]').removeAttr('disabled');
        else {
            kendoWindow.find('input[value="' + sideSelected + '"]').prop('checked', true);
            kendoWindow.find('input[value="' + sideSelected + '"]').trigger('change');
        }

        kendoWindow.find('#singleEditFmRulesBtnCancel').on('click', function () {
            kendoWindow.data('kendoWindow').close();
        });
        kendoWindow.find('#singleEditFmRulesBtnSave').on('click', function () {
            var Fv2Agg = $('#Fv2Agg').val().split(' ');
            var Fv3Agg = $('#Fv3Agg').val().split(' ');
            var _data = [
                {
                    Codes: Fv2Agg,
                    DictName: 'k_dfm02'
                },
                {
                    Codes: Fv3Agg,
                    DictName: 'k_dfm03'
                }
            ];
            var loaderTarget = $('#rndWindow').closest('.k-widget.k-window');

            bars.ui.loader(loaderTarget, true);
            $.ajax({
                url: bars.config.urlContent('/api/Finmon/FmDocumentsApi/CheckFmCodes'),
                data: {
                    data: _data
                },
                contentType: "application/json; charset=utf-8",
                success: function (res) {
                    if (res.length > 0) {
                        var errStr = $.map(res, function (v) { return '<b>' + v + '</b>'; }).join(', ');
                        var str = 'Деякі з введених кодів не існують або не використовуються : <br/>' + errStr;
                        bars.ui.loader(loaderTarget, false);
                        bars.ui.error({ text: str });
                    } else {
                        data.Md = $('[name="clientsMonitoringSide"]:checked').val() === 'A' ? 1 : 2;
                        data.OprVid1 = $('#finOperCode').val();

                        var isMM = $('#mandatoryMonitoring').prop('checked');
                        data.CommVid2 = isMM ? $('#CommVid2').val() : '';
                        data.OprVid2 = isMM ? $('#OprVid2').val() : '';

                        var isIM = $('#internalMonitoring').prop('checked');
                        data.CommVid3 = isIM ? $('#CommVid3').val() : '';
                        data.OprVid3 = isIM ? $('#OprVid3').val() : '';

                        if (+data.OprVid3 === 900 && !data.CommVid3) {
                            bars.ui.error({ text: 'Увага! Для коду 900 внутрішнього моніторингу має бути заповнене поле коментар' });
                            bars.ui.loader(loaderTarget, false);
                            return;
                        }
                        var _md = $('[name="clientsMonitoringSide"]:checked');
                        if (!_md.length) {
                            bars.ui.error({ text: 'Увага! Не вибрано <b>Режим моніторінгу клієнтів</>.' });
                            bars.ui.loader(loaderTarget, false);
                            return;
                        }

                        data.StatusName = 'Повідомлено';

                        data.ClientA.Rnk = $('#RnkA').val();
                        data.ClientB.Rnk = $('#RnkB').val();

                        var newData = {
                            Data: data,
                            Refs: data.refs,
                            Vids2: $('#Fv2Agg').val(),
                            Vids3: $('#Fv3Agg').val(),
                            Bulk: bulk
                        };

                        $.ajax({
                            type: 'POST',
                            url: bars.config.urlContent('/api/Finmon/FmDocumentsApi/SaveFmRules'),
                            data: JSON.stringify(newData),
                            contentType: "application/json; charset=utf-8",
                            success: function () {
                                if (bulk) formCfg.reloadGrid();

                                _cbFunction(newData);

                                bars.ui.alert({ text: 'Зміни успішно збережено' });
                                kendoWindow.data('kendoWindow').close();
                            },
                            complete: function () {
                                bars.ui.loader(loaderTarget, false);
                            }
                        });
                    }
                },
                error: function () {
                    bars.ui.loader(loaderTarget, false);
                }
            });
        });

        kendoWindow.find('#internalMonitoring').prop('checked', false);

        kendoWindow.find('#finOperCode')
            .on('keydown', function (e) { validateNumber(e); })
            .on('blur', finOperCodeChange)
            .on('change', finOperCodeChange);

        function finOperCodeChange(e) {
            if ($(this).val().length !== 15) $('#finOperCodeErr').css('display', 'block');
            else $('#finOperCodeErr').css('display', 'none');
        }

        kendoWindow.find('#finOperCodeDict').on('click', function () {
            var codeInput = kendoWindow.find('#finOperCode');
            finOperCodeTypeEditor(codeInput.val(), function (val) {
                codeInput.val(val);
            });
        });

        if (data.Status === 'D' || data.Status === 'B')
            disableAll(kendoWindow);

        kendoWindow.find('#finOperCodeDict').on('click', function () {
            // here goes opening some window
        });
    }
}

function disableAll(el) {
    var c = el.children();
    $.each(c, function () {
        var a = $(this);
        if (a.is('#singleEditFmRulesBtnCancel')) return;

        if (a.children().length)
            disableAll(a);

        if (a.is('a, input'))
            a.attr('disabled', 'disabled');
    });
}

function monitoringTypesChange(that) {
    var a = $(that).closest('table').find('input:not([type="checkbox"]):not([id*="Name"]), a');
    $.each(a, function (i, e) {
        enableElem(e, that.checked);
    });
}

function checkClients(c) {
    if (!c)
        c = {
            Name: '',
            Rnk: '',
            Okpo: ''
        };
    return c;
}

function setParameter(val, $this, number) {
    var tr = $($this).closest('tr');

    tr.find('#K' + number + 'Name').val(val.Name);
    tr.find('#OprVid' + number).val(val.Code);

    if (+val.Code === 0) {
        $('#Fv' + number + 'Agg').val('');
        $('#Fv' + number + 'Agg').attr('disabled', 'disabled');
        $('#kdfm0' + number + 'add').attr('disabled', 'disabled');
    } else {
        $('#Fv' + number + 'Agg').removeAttr('disabled');
        $('#kdfm0' + number + 'add').removeAttr('disabled');
    }
    tr.find('#K' + number + 'Name').data('kendoTooltip').refresh();
}

//////////////////////////////////////////////////////////////////

function finOperCodeTypeEditor(code, closeCb) {
    var kendoWindow;
    var dict = new dictForm();


    bars.ui.loader('body', true);
    $.ajax({
        url: bars.config.urlContent('/api/Finmon/FmDocumentsApi/GetFmCodeTypeData?code=' + code),
        contentType: "application/json; charset=utf-8",
        success: function (res) {
            res.code = code;
            init(res);
        },
        complete: function () {
            bars.ui.loader('body', false);
        }
    });

    function init(data) {
        kendoWindow = $('<div id="finOperCodeWindow"/>').kendoWindow({
            actions: ['Close'],
            title: 'Код виду фінансової операції',
            resizable: false,
            modal: true,
            draggable: true,
            refresh: function () {
                this.center();
            },
            animation: getAnimationForKWindow({ animationType: { open: 'right', close: 'up' } }),
            deactivate: function () {
                bars.ui.loader('body', false);
                this.destroy();
            },
            activate: function () {
                this.refresh();
            }
        });

        var totalTemplate = loadKendoTemplate(bars.config.urlContent('/Areas/Finmon/Scripts/FmDocuments/tpl/FinOperCodeType.tpl.html'));
        var template = kendo.template(totalTemplate);

        kendoWindow.data('kendoWindow').content(template(data));

        kendoWindow.find('#codeTypeBtnCancel').on('click', function () {
            kendoWindow.data('kendoWindow').close();
        });
        kendoWindow.find('#codeTypeBtnSave').on('click', function () {
            var resCode = $('#totalValue').val();
            if (resCode.length !== 15) {
                bars.ui.error({ text: 'Невірний код операції.' });
                return;
            }
            closeCb($('#totalValue').val());
            kendoWindow.data('kendoWindow').close();
        });

        kendoWindow.find('input[id$="Code"]')
            .on('keydown', function (e) {
                validateNumber(e);
            })
            .on('blur', function () {
                var that = this;
                var _val = $(that).val();
                if (_val === undefined || _val === null || _val === '') {
                    setCodeTypeVal(that, {});
                    return;
                }

                var symbol = $(that).closest('tr').find('a[data-dict]').data('dict');

                $.ajax({
                    url: bars.config.urlContent('/api/Finmon/FmDocumentsApi/GetDict'),
                    data: {
                        Code: _val,
                        request: null,
                        dictName: 'k_dfm01' + symbol
                    },
                    success: function (res) {
                        if (res && res.Data && res.Data.length)
                            setCodeTypeVal(that, res.Data[0]);
                        else
                            setCodeTypeVal(that, {});
                    }
                });
            });

        kendoWindow.find('a[data-dict]').on('click', function () {
            var that = this;
            var a = $(this).data('dict');
            var title = $($(this).closest('.container').find('label')[0]).text();

            dict.open({
                dictName: 'k_dfm01' + a,
                title: title,
                func: function (val) {
                    setCodeTypeVal(that, val);
                },
                width: 700
            });
        });

        function setCodeTypeVal(that, val) {
            $(that).closest('tr').find('[id$="Code"]').val(val.Code);
            $(that).closest('tr').find('[id$="Name"]').val(val.Name);
            $(that).closest('tr').find('[id$="Name"]').data('kendoTooltip').refresh();

            updateTotalCode();
        }

        function updateTotalCode() {
            var res = '';
            res += $('#calculationProvidedCode').val();
            res += $('#calculationReceivedCode').val();

            res += $('#assetProvidedCode').val();
            res += $('#assetReceivedCode').val();

            res += $('#locationProvidedCode').val();
            res += $('#locationReceivedCode').val();

            res += $('#objectProvidedCode').val();
            res += $('#objectReceivedCode').val();

            res += $('#openCloseAccProvidedCode').val();

            $('#totalValue').val(res);
        }
        kendoWindow.find('[id$="Name"]').kendoTooltip(tooltipOptions());

        kendoWindow.data('kendoWindow').center().open();
    }
}

function tooltipOptions() {
    return {
        position: 'top',
        width: 'auto',
        content: function (e) {
            e.sender.popup.element.css("visibility", "hidden");
            var val = $(e.target).val();
            if (val && getWidth(val) > $(e.sender.element).width())
                e.sender.popup.element.css("visibility", "visible");

            return val;
        }
    };
}

function getWidth(text) {
    document.getElementById("text").innerText = text;
    var width = document.getElementById("text").clientWidth;
    return width;
}


///////////////////////////////////////////////////////////////////

function ShowHistoryForm(_id, ref) {
    var gridSelector = '#historyWindowGrid';
    var kendoWindow;

    kendoWindow = $('<div id="historyWindow"/>').kendoWindow({
        actions: ['Close'],
        title: 'Історія змін по документу реф. <b>' + ref + '</b>',
        resizable: false,
        modal: true,
        draggable: true,
        width: '70%',
        refresh: function () {
            this.center();
        },
        animation: getAnimationForKWindow({ animationType: { open: 'down', close: 'up' } }),
        deactivate: function () {
            bars.ui.loader('body', false);
            this.destroy();
        },
        activate: function () {
            this.refresh();
        }
    });

    var totalTemplate = getTemplate();
    var template = kendo.template(totalTemplate);

    kendoWindow.data('kendoWindow').content(template({}));

    var pageInitalCount = 10;

    var dataSourceObj = {
        type: 'webapi',
        transport: {
            read: {
                url: bars.config.urlContent('/api/Finmon/FmDocumentsApi/GetDocumentHistory'),
                dataType: 'json',
                data: {
                    id: _id
                }
            }
        },
        pageSize: pageInitalCount,
        serverPaging: false,
        serverFiltering: false,
        serverSorting: false,
        requestStart: function (e) {
        },
        requestEnd: function (e) {
            bars.ui.loader(kendoWindow, false);
        },
        schema: {
            data: 'Data',
            total: 'Total',
            model: {
                fields: {
                    ModDate: { type: 'date' },
                    ModType: { type: 'string' },
                    Name: { type: 'string' },
                    UserId: { type: 'number' },
                    UserName: { type: 'string' },
                    OldValue: { type: 'string' }
                }
            }
        }
    };

    var gridDataSource = new kendo.data.DataSource(dataSourceObj);

    var gridOptions = {
        dataSource: gridDataSource,
        pageable: {
            refresh: false,
            messages: {
                empty: 'Дані відсутні',
                allPages: 'Всі'
            },
            buttonCount: 5,
            numeric: true
        },
        reorderable: false,
        columns: [
            {
                field: 'ModDate', title: 'Дата модифікації',
                template: '#= ModDate ? ModDate.format() : "" #',
                width: 140
            },
            {
                field: 'Name', title: 'Назва', width: 200
            },
            {
                field: 'UserId', title: 'ID користувача', width: 120
            },
            {
                field: 'UserName', title: 'ПІБ користувача', width: 160
            },
            {
                field: 'OldValue', title: 'Старе значення', width: 350
            }
        ],
        editable: false,
        scrollable: true,
        selectable: 'row',
        noRecords: {
            template: '<hr class="modal-hr"/><b>На жаль, нічого не знайдено ;(</b><hr class="modal-hr"/>'
        },
        dataBound: function () {
            bars.ui.loader($('#historyWindowGrid').parent('.k-widget.k-window'), false);
        }
    };

    bars.ui.loader($('#historyWindowGrid').parent('.k-widget.k-window'), true);
    kendoWindow.find(gridSelector).kendoGrid(gridOptions);

    kendoWindow.find('#historyBtnCancel').click(function () {
        kendoWindow.data('kendoWindow').close();
    }).end();

    kendoWindow.data('kendoWindow').center().open();
    function getTemplate() {
        var template = '<div id="historyWindowGrid"></div><br/>';
        return template + templateButtons();
    }
    function templateButtons() {
        return '<div class="row" style="margin:5px 5px 5px 5px;">'
            + '     <div class="k-edit-buttons k-state-default">'
            + '         <a id="historyBtnCancel" class="k-button k-button-icontext k-grid-cancel modal-buttons" tabindex="3"><span class="k-icon k-cancel"></span> Закрити</a>'
            + '     </div>'
            + ' </div>';
    }
}

if (!Array.isArray) {
    Array.isArray = function (arg) {
        return Object.prototype.toString.call(arg) === '[object Array]';
    };
}