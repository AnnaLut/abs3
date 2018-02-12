function requestsForm(updateMainGridFunc, winName) {
    updateMainGridFunc = updateMainGridFunc || function () { };
    var _canClose = true;
    function onClose(e) {
        if (!_canClose) {
            e.preventDefault();
            $(document).off('keyup', onEscKeyUp);
        }
    };
    var forms = {
        ruRequest: { title: "Запит даних в РУ", url: "/api/SWCompare/SWCompare/LoadRuData", formSize: "308px", id: "ru", lbl: "РУ: " },
        zsRequest: { title: "Запит даних в ЗС", url: "/api/SWCompare/SWCompare/LoadZsData", formSize: "329px", id: "zs_tc", lbl: "Код НБУ: " },
        ticketing: { title: "Квитування", url: "/api/SWCompare/SWCompare/LoadNBU", formSize: "329px", id: "zs_tc", lbl: "Код НБУ: " }
    };
    var ddlSettings = {
        ru: {
            dataValue: "KF",
            dataText: "BRANCH_NAME",
            template: '<span style="font-size:12px;">#:data.KF# | #:data.BRANCH_NAME#</span>',
            valueTemplate: '<span style="font-size:12px;">#:data.BRANCH_NAME#</span>',
            url: "/api/SWCompare/SWCompare/GetBranchNames"
        },
        zs_tc: {
            dataValue: "KOD_NBU",
            dataText: "NAME",
            template: kendo.template($("#ddlTemplate").html()),
            valueTemplate: '<span style="font-size:12px;">#:data.NAME#</span>',
            url: "/api/SWCompare/SWCompare/GetNBU"
        }
    };

    var kendoWindow = $("<div />").kendoWindow({
        action: ["Close"],
        title: forms[winName].title,
        resizable: false,
        modal: true,
        draggable: true,
        width: forms[winName].formSize,
        close: onClose,
        refresh: function () {
            this.center();
        },
        deactivate: function () {
            bars.ui.loader(kendoWindow, false);
            this.destroy();
        },
        activate: function () {
            kendoWindow.data("kendoWindow").refresh();
            if (winName == "ticketing")
                kendoWindow.find("#dropDownList").data("kendoDropDownList").element.focus();
            else
                kendoWindow.find("#datePicker").data("kendoDatePicker").element.focus();
        }
    });

    var windowTemplate = kendo.template($("#RequestFormTemplate").html());
    kendoWindow.data("kendoWindow").content(windowTemplate({}));

    if (winName == "ticketing")
        kendoWindow.find("#dpDiv").hide();
    else {
        kendoWindow.find("#datePicker").kendoDatePicker({
            format: "dd.MM.yyyy",
            value: '',
            dateInput: true,
            change: function () {
                var value = this.value();
                if (value === undefined || value === null || value === '')
                    this.value(today);
            }
        });
    }

    initDDL(ddlSettings[forms[winName].id]);

    kendoWindow.find("#ddlLbl").text(forms[winName].lbl);

    if (winName == "ruRequest") {
        kendoWindow.find("#ddlLbl").css({ 'margin-right': '17px' });
        kendoWindow.find("#dpLbl").css({ 'margin-right': '4px' });
    }
        
    function initDDL(settings) {
        kendoWindow.find("#dropDownList").kendoDropDownList({
            dataValueField: settings.dataValue,
            dataTextField: settings.dataText,
            template: settings.template,
            valueTemplate: settings.valueTemplate,
            dataSource: {
                type: "webapi",
                transport: {
                    read: {
                        url: bars.config.urlContent(settings.url),
                        dataType: "json"
                    }
                }
            }
        });
    }

    kendoWindow.find("#btnSave").click(function () {
        var postObj = {};
        var ddl = kendoWindow.find('#dropDownList').data('kendoDropDownList').value();

        if (winName != "ticketing") {
            var _date = kendoWindow.find('#datePicker').data('kendoDatePicker').value();
            if (_date == null) {
                bars.ui.alert({ text: 'Необхідно вказати дату!' });
                return;
            }
            var date = new Date(_date);
            date.setHours(0, 0, 0, 0);
            postObj.p_date = date;
        }

        if (winName == "ruRequest") {
            if (!ddl) {
                bars.ui.alert({ text: 'Необхідно вказати відділення!' });
                return;
            } 
            postObj.p_mfo = ddl;
        } else {
            if (!ddl)
                postObj.p_kod_nbu = null;
            else
                postObj.p_kod_nbu = ddl;
        }        

        $.ajax({
            type: "POST",
            contentType: "application/json",
            url: bars.config.urlContent(forms[winName].url),
            beforeSend: function () {
                bars.ui.loader(kendoWindow, true);
                _canClose = false;
            },
            data: JSON.stringify(postObj),
            success: function (data) {
                if (data.Result != "OK") {
                    bars.ui.error({ text: data.ErrorMsg });
                } else {
                    if (data.ResultObj)
                        bars.ui.alert({
                            text: data.ResultObj.Message +
                            (winName == "ticketing" ? "" : "<br/>" +
                                (winName == "ruRequest" ? "На цю дату за цим МФО існує: " : "На цю дату за цим кодом НБУ існує: ")
                                    + data.ResultObj.Rows + " документів.")
                        });
                    kendoWindow.data("kendoWindow").close();
                    updateMainGridFunc();
                }
            },
            complete: function () {
                bars.ui.loader(kendoWindow, false);
                _canClose = true;
            }
        });
    });

    kendoWindow.find("#btnCancel").click(function () {
        kendoWindow.data("kendoWindow").close();
    }).end();

    kendoWindow.data("kendoWindow").center().open();
};

