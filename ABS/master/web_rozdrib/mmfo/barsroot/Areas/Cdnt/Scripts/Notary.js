$(document).ready(function (mainGrid, toolBar, isCaMode, notaryEditDialog) {
    var accreditationGrid = "#accr_grid";
    var accreditationTools = "#accr_toolbar";
    var accreditationDlg = "#editAccreditationDlg";

    //биндинг 
    var bodyModel = new kendo.data.ObservableObject({
        currNotaryId: null,
        currNotaryName: "",
        currAccrId: null
    });

    //функция обновления тулбара
    var toolbarRefresh = function () {
        var grid = $(mainGrid).data("kendoGrid");
        var currentRowData = null;

        if (grid.select().length > 0) {
            currentRowData = grid.dataItem(grid.select());
            bodyModel.set("currNotaryId", currentRowData.ID);
            bodyModel.set("currNotaryName", currentRowData.LAST_NAME + " " + currentRowData.FIRST_NAME);
        }

        var editNotaryBtn = $("#editNotaryBtn").data("kendoButton");
        if (editNotaryBtn) {
            editNotaryBtn.enable(currentRowData);
        }

        var tabs = $("#tabstrip").data("kendoTabStrip");
        tabs.enable(tabs.tabGroup.children().eq(1), currentRowData != null);

        var accGrid = $(accreditationGrid).data("kendoGrid");
        var accCurrentRowData = null;

        if (accGrid && accGrid.select().length > 0) {
            accCurrentRowData = accGrid.dataItem(accGrid.select());
            bodyModel.set("currAccrId", accCurrentRowData.ID);
        }
        tabs.enable(tabs.tabGroup.children().eq(2), currentRowData != null && accCurrentRowData != null);
        var editAccrBtn = $("#editAccrBtn").data("kendoButton");
        if (editAccrBtn) {
            editAccrBtn.enable(accCurrentRowData);
        }
        var closeAccrBtn = $("#closeAccrBtn").data("kendoButton");
        if (closeAccrBtn) {
            closeAccrBtn.enable(accCurrentRowData && !accCurrentRowData.get("CLOSE_DATE"));
        }
    }

    $.fn.serializeObject = function (needUpperNames) {
        var o = {};
        var a = this.serializeArray();
        $.each(a, function () {
            var propName = this.name;
            if (needUpperNames) {
                propName = propName.toUpperCase();
            }
            if (o[propName] !== undefined) {
                if (!o[propName].push) {
                    o[propName] = [o[propName]];
                }
                o[propName].push(this.value || "");
            } else {
                o[propName] = this.value || "";
            }
        });
        return o;
    };

    //источники данных 
    //для основного грида
    var mainGridDs = new kendo.data.DataSource({
        schema: {
            data: "Data",
            total: "Total",
            errors: "Errors",
            model: {
                fields: {
                    ID: { type: "number" },
                    DATE_OF_BIRTH: { type: "date" },
                    PASSPORT_ISSUED: { type: "date" },
                    NOTARY_TYPE: { type: "number" },
                    CERTIFICATE_ISSUE_DATE: { type: "date" },
                    CERTIFICATE_CANCELATION_DATE: { type: "date" }
                }
            }
        },
        pageSize: 20,
        serverPaging: true,
        serverSorting: true,
        type: "aspnetmvc-ajax",
        transport: {
            read: {
                url: bars.config.urlContent("/Cdnt/Notary/IndexData"),
                complete: toolbarRefresh,
                data: function () {
                    var onlyNeedAcceptBtn = $('#btnNeedAccept.k-state-active');
                    var result = {
                        onlyNeedAccept: onlyNeedAcceptBtn && onlyNeedAcceptBtn.length > 0
                    };
                    return result;
                }
            }
        }
    });
    

    //акредитации
    var accrGridDs = new kendo.data.DataSource({
        schema: {
            data: "Data",
            total: "Total",
            errors: "Errors",
            model: {
                fields: {
                    ID: { type: "number" },
                    NOTARY_ID: { type: "number" },
                    EXPIRY_DATE: { type: "date" },
                    CLOSE_DATE: { type: "date" },
                    START_DATE: { type: "date" }
                }
            }
        },
        pageSize: 20,
        serverPaging: true,
        serverSorting: true,
        type: "aspnetmvc-ajax",
        transport: {
            read: {
                url: bars.config.urlContent("/Cdnt/Notary/AccreditationData"),
                complete: toolbarRefresh,
                data: function () {
                    var grid = $(mainGrid).data("kendoGrid");
                    var currentRowData;
                    if (grid.select().length > 0) {
                        currentRowData = grid.dataItem(grid.select());
                        return { notaryId: currentRowData.ID }
                    }
                    return { notaryId: null }
                }
            }
        }
    });

    //транзакции
    var transactionsDs = new kendo.data.DataSource({
        schema: {
            data: "Data",
            total: "Total",
            errors: "Errors",
            model: {
                fields: {
                    ID: { type: "number" },
                    INCOME_AMOUNT: { type: "number" },
                    TRANSACTION_DATE: { type: "date" },
                    ACCREDITATION_ID: { type: "number" }
                }
            }
        },
        type: "aspnetmvc-ajax",
        transport: {
            read: {
                url: bars.config.urlContent("/Cdnt/Notary/TransactionData"),
                data: function () { return { accreditationId: bodyModel.get("currAccrId") } }
            }
        }
    });

    //типы акредитаций
    var accrTypesDs = new kendo.data.DataSource({
        type: "aspnetmvc-ajax",
        transport: {
            read: {
                url: bars.config.urlContent("/Cdnt/Notary/AccreditationTypes")
            }
        }
    });

    //состояния акредитаций
    var accrStatesDs = new kendo.data.DataSource({
        type: "aspnetmvc-ajax",
        transport: {
            read: {
                url: bars.config.urlContent("/Cdnt/Notary/AccreditationStates")
            }
        }
    });

    //типы транзакций
    var tranTypesDs = new kendo.data.DataSource({
        type: "aspnetmvc-ajax",
        transport: {
            read: {
                url: bars.config.urlContent("/Cdnt/Notary/TransactionTypes")
            }
        }
    });

    //типы Нотариусов
    var notaryTypesDs = new kendo.data.DataSource({
        type: "aspnetmvc-ajax",
        transport: {
            read: {
                url: bars.config.urlContent("/Cdnt/Notary/GetNotaryTypes")
            }
        }
    });

    //список мфо
    var mfoListDs = new kendo.data.DataSource({
        type: "aspnetmvc-ajax",
        transport: {
            read: {
                url: bars.config.urlContent("/Cdnt/Notary/GetMfoList")
            }
        }
    });

    //бизнесы
    var businessDs = new kendo.data.DataSource({
        type: "aspnetmvc-ajax",
        transport: {
            read: {
                url: bars.config.urlContent("/Cdnt/Notary/GetListOfBusiness")
            }
        }
    });

    var clearValidationMarks = function () {
        $("input").removeClass("k-invalid");
        $(".k-invalid-msg").hide();
    }

    var isStateNotary = function() {
        return $("input[name=\"notary_type\"]").data("kendoDropDownList").value() === "1";
    }
    //валидаторы форм
    var notaryValidator = $(notaryEditDialog).kendoValidator({
        messages: {
            required: "Обов'язкове поле!",
            invalid_date_format: "Невірний формат дати!"
        },
        rules: {
            passpseriescheck: function (input) {
                if (isStateNotary()) {
                    return true;
                }
                if (input.is("[name=passport_series]")) {
                    var val = input.val();
                    return val && /^[а-яА-Я]{2}$/.test(val);
                }
                return true;
            },
            tincheck: function (input) {
                if (isStateNotary()) {
                    return true;
                }
                if (input.is("[name=tin]")) {
                    var val = input.val();
                    return (/^[0-9]{10}$/.test(val));
                }
                return true;
            },
            mobphonecheck: function (input) {
                if (isStateNotary()) {
                    return true;
                }
                if (input.is("[name=mobile_phone_number]")) {
                    var number = input.val();
                    return number.substring(0, 4) === "+380" && number.length > 11;
                }
                return true;
            },
            passnumcheck: function(input) {
                if (isStateNotary()) {
                    return true;
                }
                if (input.is("[name=passport_number]")) {
                    var val = input.val();
                    return (/^[0-9]{6}$/.test(val));
                }
                return true;
            },
            invalid_date_format: function (input) {
                if ((input.is("[name=date_of_birth]") || input.is("[name=passport_issued]")) && input.val()) {
                    return kendo.parseDate(input.val()) instanceof Date;
                }
                return true;
            }
        }
    }).data("kendoValidator");

    var accreditationValidator = $('#editAccreditationDlg').kendoValidator({
        messages: {
            required: "Обов'язкове поле!"
        },
        rules: {}
    }).data("kendoValidator");


    var prepareAccrDialog = function (mode) {
        var dialog = $(accreditationDlg).data("kendoWindow");

        var validForm = function () {
            return accreditationValidator.validate();
        }

        clearValidationMarks();
        if (mode === "add") {
            dialog.title("Акредитація [Додавання нової]");
            $("input[name=\"id\"]").val(null);
            $("input[name=\"notary_id\"]").val(bodyModel.currNotaryId); //привяжем до поточного нотаріуса
            $("input[name=\"accreditation_type_id\"]").data("kendoDropDownList").value(1); //постійна акредитація
            $("input[name=\"start_date\"]").data("kendoDatePicker").value(null);
            $("input[name=\"close_date\"]").data("kendoDatePicker").value(null);
            $("input[name=\"account_number\"]").val(null);
            $("input[name=\"account_mfo\"]").val(null);
            $("input[name=\"state_id\"]").data("kendoDropDownList").value(1); //діюча акредитація
            $("select[name=\"branches\"]").data("kendoMultiSelect").value([]);
            $("select[name=\"businesses\"]").data("kendoMultiSelect").value([]);
            $("#saveAccreditation")
                .unbind("click")
                .on("click", function () {
                    if (validForm()) {
                        var newAccreditation = $('#accreditation').serializeObject(true);
                        $.ajax({
                            type: "POST",
                            url: bars.config.urlContent("/Cdnt/Notary/CreateAccreditation"),
                            data: JSON.stringify(newAccreditation),
                            dataType: "json",
                            contentType: "application/json; charset=utf-8",
                            success: function (data) {
                                if (data.status === "ok") {
                                    newAccreditation.ID = data.data;
                                    newAccreditation.CLOSE_DATE = null;
                                    for (var i = 0; accrTypesDs.data().length; i++) {
                                        if (newAccreditation.ACCREDITATION_TYPE_ID == accrTypesDs.data()[i].LIST_ITEM_ID) {
                                            newAccreditation.TYPE_ACCR = accrTypesDs.data()[i].LIST_ITEM_NAME;
                                            break;
                                        }
                                    }
                                    for (i = 0; accrStatesDs.data().length; i++) {
                                        if (newAccreditation.STATE_ID == accrStatesDs.data()[i].LIST_ITEM_ID) {
                                            newAccreditation.STATE_ACCR = accrStatesDs.data()[i].LIST_ITEM_NAME;
                                            break;
                                        }
                                    }
                                    accrGridDs.add(newAccreditation);
                                    dialog.close();
                                } else {
                                    bars.ui.error({ text: data.message });
                                }
                            }
                        });
                    }
                });
        } else {
            var grid = $(accreditationGrid).data("kendoGrid");
            var currentRowData = null;
            if (grid.select().length > 0) {
                currentRowData = grid.dataItem(grid.select());
                dialog.title("Акредитація [редагування]");
                $("input[name=\"id\"]").val(currentRowData.ID);
                $("input[name=\"notary_id\"]").val(currentRowData.NOTARY_ID);
                $("input[name=\"accreditation_type_id\"]").data("kendoDropDownList").value(currentRowData.ACCREDITATION_TYPE_ID);
                $("input[name=\"start_date\"]").data("kendoDatePicker").value(currentRowData.START_DATE);
                $("input[name=\"close_date\"]").data("kendoDatePicker").value(currentRowData.CLOSE_DATE);
                $("input[name=\"account_number\"]").val(currentRowData.ACCOUNT_NUMBER);
                $("input[name=\"account_mfo\"]").val(currentRowData.ACCOUNT_MFO);
                $("input[name=\"state_id\"]").data("kendoDropDownList").value(currentRowData.STATE_ID);
                $("#saveAccreditation")
                .unbind("click")
                .on("click", function () {
                    if (validForm()) {
                        var newAccreditation = $('#accreditation').serializeObject(true);
                        $.ajax({
                            type: "POST",
                            url: bars.config.urlContent("/Cdnt/Notary/EditAccreditation"),
                            data: JSON.stringify(newAccreditation),
                            dataType: "json",
                            contentType: "application/json; charset=utf-8",
                            success: function (data) {
                                if (data.status === "ok") {
                                    //найти акредитацию и заменить новой
                                    var accr = accrGridDs.data();
                                    for (var i = 0; i < accr.length; i++) {
                                        if (accr[i].ID == newAccreditation.ID) {
                                            $.each(newAccreditation, function (key, value) {
                                                accr[i].set(key, value);
                                            });
                                            break;
                                        }
                                    }
                                    dialog.close();
                                } else {
                                    bars.ui.error({ text: data.message });
                                }
                            }
                        });
                    }
                });

                //заполнение бранчей и бизнесов
                var fillBranches = function () {
                    return $.get(bars.config.urlContent("/Cdnt/Notary/GetAccBranches"), { accrId: currentRowData.ID }, function (data) {
                        $("select[name=\"branches\"]").data("kendoMultiSelect").value(data);
                    });
                };

                var fillBuisenesses = function () {
                    return $.get(bars.config.urlContent("/Cdnt/Notary/GetAccBusinesses"), { accrId: currentRowData.ID }, function (data) {
                        $("select[name=\"businesses\"]").data("kendoMultiSelect").value(data);
                    });
                };

                return $.when(fillBranches(), fillBuisenesses());
            }
        }
        return false;
    }

    var prepareNotaryDialog = function (mode) {
        var dialog = $(notaryEditDialog).data("kendoWindow");
        clearValidationMarks();

        var validForm = function () {
            return notaryValidator.validate();
        }

        var phonePrefix = "+380";

        if (mode === "add") {
            dialog.title("Нотаріус [Додавання нового]");
            //очистка формы
            $("input[name=\"notary_type\"]").data("kendoDropDownList").value(2);//приватний нотаріус
            $("input[name=\"tin\"]").val(null);
            $("input[name=\"last_name\"]").val(null);
            $("input[name=\"first_name\"]").val(null);
            $("input[name=\"middle_name\"]").val(null);
            $("input[name=\"date_of_birth\"]").data("kendoDatePicker").value(null);
            $("input[name=\"passport_series\"]").val(null);
            $("input[name=\"passport_number\"]").val(null);
            $("input[name=\"passport_issued\"]").data("kendoDatePicker").value(null);
            $("input[name=\"passport_issuer\"]").val(null);
            $("input[name=\"address\"]").val(null);
            $("input[name=\"phone_number\"]").val(phonePrefix);
            $("input[name=\"mobile_phone_number\"]").val(phonePrefix);
            $("input[name=\"email\"]").val(null);
            $("input[name=\"certificate_number\"]").val(null);
            $("#saveNotary")
                .unbind("click")
                .on("click", function () {
                    if (validForm()) {
                        var newNotarius = $("#notary").serializeObject(true);
                        $.post(bars.config.urlContent("/Cdnt/Notary/CreateNotary"), newNotarius, function (data) {
                            if (data.status === "ok") {
                                newNotarius.ID = data.data;
                                newNotarius.CNT_ACCR = 0;
                                mainGridDs.add(newNotarius);
                                dialog.close();
                            } else {
                                bars.ui.error({ text: data.message });
                            }
                        });
                    }
                });
        } else {
            var grid = $(mainGrid).data("kendoGrid");
            var currentRowData = null;
            if (grid.select().length > 0) {
                currentRowData = grid.dataItem(grid.select());
                dialog.title("Нотаріус - редагування [ID=<strong>" + currentRowData.ID + "</strong>]");
                //заполнение формы
                $("input[name=\"notary_type\"]").data("kendoDropDownList").value(currentRowData.NOTARY_TYPE);
                $("input[name=\"id\"]").val(currentRowData.ID);
                $("input[name=\"tin\"]").val(currentRowData.TIN);
                $("input[name=\"last_name\"]").val(currentRowData.LAST_NAME);
                $("input[name=\"first_name\"]").val(currentRowData.FIRST_NAME);
                $("input[name=\"middle_name\"]").val(currentRowData.MIDDLE_NAME);
                $("input[name=\"date_of_birth\"]").data("kendoDatePicker").value(currentRowData.DATE_OF_BIRTH);
                $("input[name=\"passport_series\"]").val(currentRowData.PASSPORT_SERIES);
                $("input[name=\"passport_number\"]").val(currentRowData.PASSPORT_NUMBER);
                $("input[name=\"passport_issued\"]").data("kendoDatePicker").value(currentRowData.PASSPORT_ISSUED);
                $("input[name=\"passport_issuer\"]").val(currentRowData.PASSPORT_ISSUER);
                $("input[name=\"address\"]").val(currentRowData.ADDRESS);
                $("input[name=\"phone_number\"]").val(currentRowData.PHONE_NUMBER);
                $("input[name=\"mobile_phone_number\"]").val(currentRowData.MOBILE_PHONE_NUMBER);
                $("input[name=\"email\"]").val(currentRowData.EMAIL);
                $("input[name=\"certificate_number\"]").val(currentRowData.CERTIFICATE_NUMBER);
                $("#saveNotary")
                    .unbind("click")
                    .on("click", function () {
                        if (validForm()) {
                            var newNotarius = $("#notary").serializeObject(true);
                            $.post(bars.config.urlContent("/Cdnt/Notary/EditNotary"), newNotarius, function (data) {
                                if (data.status === "ok") {
                                    //ищем запись в гриде и обновляем ее
                                    var notary = mainGridDs.data();
                                    for (var i = 0; i < notary.length; i++) {
                                        if (notary[i].ID == newNotarius.ID) {
                                            $.each(newNotarius, function (key, value) {
                                                notary[i].set(key, value);
                                            });
                                            break;
                                        }
                                    }
                                    dialog.close();
                                } else {
                                    bars.ui.error({ text: data.message });
                                }
                            });
                        }
                    });
            } else {
                bars.ui.error({ text: "Не обрано жодного нотаріуса!" });
            }
        }
    }

    //инициализация вкладок
    $("#tabstrip").kendoTabStrip({
        select: function (e) {
            var selectedTabId = e.item.id;
            if (selectedTabId === "accreditationsTab") {
                accrGridDs.read();
            } else if (selectedTabId === "transactionsTab") {
                transactionsDs.read();
            }
        }
    });

    $("#tabstrip").data("kendoTabStrip").activateTab("#notaryTab");

    //инициализация гридов
    $(mainGrid).kendoGrid({
        resizable: true,
        columns: [
            {
                field: "ID",
                title: "Ідентифі&shy;катор",
                width: 80,
                headerAttributes: {
                    style: "white-space: normal;"
                },
                template: "<div style='text-align:right;'>#=ID#</div>"
            },
            {
                field: "NOTARY_TYPE_NAME",
                title: "Тип",
                width: 80
            },
            {
                field: "TIN",
                title: "ІПН",
                width: 100
            },
            {
                field: "LAST_NAME",
                title: "Прізвище",
                width: 100
            },
            {
                field: "FIRST_NAME",
                title: "Ім'я",
                width: 100
            },
            {
                field: "MIDDLE_NAME",
                title: "По-батькові",
                width: 100
            },
            {
                field: "DATE_OF_BIRTH",
                title: "Дата народження",
                headerAttributes: {
                    style: "white-space: normal;"
                },
                template: "<div style='text-align:right;'>#=DATE_OF_BIRTH == null ? '' :kendo.toString(DATE_OF_BIRTH,'dd/MM/yyyy')#</div>",
                width: 110
            },
            {
                field: "PASSPORT_SERIES",
                title: "Паспорт",
                template: "#=PASSPORT_SERIES == null ? '' : PASSPORT_SERIES + ' '##= PASSPORT_NUMBER == null ? '' : PASSPORT_NUMBER#",
                headerAttributes: {
                    style: "white-space: normal;"
                },
                width: 100
            },
            {
                field: "PASSPORT_ISSUED",
                title: "Дата видачі паспорту",
                headerAttributes: {
                    style: "white-space: normal;"
                },
                template: "<div style='text-align:right;'>#=PASSPORT_ISSUED == null ? '' :kendo.toString(PASSPORT_ISSUED,'dd/MM/yyyy')#</div>",
                width: 140
            },
            {
                field: "PASSPORT_ISSUER",
                title: "Орган, що видав паспорт",
                headerAttributes: {
                    style: "white-space: normal;"
                },
                width: 160
            },
            {
                field: "ADDRESS",
                title: "Адреса офісного приміщення",
                headerAttributes: {
                    style: "white-space: normal;"
                },
                width: 250
            },
            {
                field: "PHONE_NUMBER",
                headerAttributes: {
                    style: "white-space: normal;"
                },
                title: "Номер телефону/факс",
                width: 180
            },
            {
                field: "MOBILE_PHONE_NUMBER",
                title: "Номер мобільного",
                headerAttributes: {
                    style: "white-space: normal;"
                },
                width: 120
            },
            {
                field: "EMAIL",
                title: "Адреса електронної пошти",
                width: 150,
                template: "<span title='#=(EMAIL != null) ? EMAIL : \"\" #'>#=(EMAIL != null) ? EMAIL : \"\" #</span>",
                headerAttributes: {
                    style: "white-space: normal;"
                }
            },
            {
                field: "CNT_ACCR",
                title: "Акреди&shy;товано",
                width: 90,
                template: "#=(CNT_ACCR > 0) ? '<div style=\"text-align:center;\"><span class=\"pf-icon pf-16 pf-ok\"></span></div>' : '&nbsp;' #",
                headerAttributes: {
                    style: "white-space: normal;"
                }
            },
            {
                title: "№ Свідоцтва нотаріуса",
                field: "CERTIFICATE_NUMBER",
                width: 150,
                headerAttributes: {
                    style: "white-space: normal;"
                }

            }
        ],
        sortable: true,
        filterable: true,
        pageable: {
            pageSize: 20
        },
        selectable: "single",
        dataSource: mainGridDs,
        change: toolbarRefresh,
        dataBound: toolbarRefresh
    });


    $(accreditationGrid).kendoGrid({
        resizable: true,
        autoBind: false,
        columns: [
            {
                field: "TYPE_ACCR",
                title: "Тип акредитації",
                width: 110
            },
            {
                field: "START_DATE",
                title: "Початок дії",
                headerAttributes: {
                    style: "white-space: normal;"
                },
                template: "<div style='text-align:right;'>#=START_DATE == null ? '' :kendo.toString(START_DATE,'dd/MM/yyyy')#</div>",
                width: 110
            },
            {
                field: "CLOSE_DATE",
                title: "Дата припинення дії",
                headerAttributes: {
                    style: "white-space: normal;"
                },
                template: "<div style='text-align:right;'>#=CLOSE_DATE == null ? '' :kendo.toString(CLOSE_DATE,'dd/MM/yyyy')#</div>",
                width: 110
            },
            {
                field: "ACCOUNT_NUMBER",
                title: "Рахунок",
                width: 100
            },
            {
                field: "ACCOUNT_MFO",
                title: "Заявник",
                headerAttributes: {
                    style: "white-space: normal;"
                },
                width: 80
            },
            {
                field: "STATE_ACCR",
                title: "Стан",
                width: 150
            }
        ],
        sortable: true,
        pageable: {
            pageSize: 20
        },
        selectable: "single",
        dataSource: accrGridDs,
        change: toolbarRefresh,
        dataBound: toolbarRefresh
    });


    $('#tran_grid').kendoGrid({
        resizable: true,
        autoBind: false,
        columns: [
            {
                field: "ID",
                title: "ID",
                width: 100
            },
            {
                field: "TYPE_TRAN",
                title: "Тип транзакції",
                width: 120
            },
            {
                field: "TRANSACTION_DETAILS",
                title: "Номер договору застави або номер документа, що посвідчував нотаріус, або інша інформація, що надасть додаткові відомості про операцію, що здійснив нотаріус",
                headerAttributes: {
                    style: "white-space: normal;"
                },
                width: 300
            },
            {
                field: "TRANSACTION_DATE",
                title: "Дата транзакції",
                template: "<div style='text-align:right;'>#=TRANSACTION_DATE == null ? '' :kendo.toString(TRANSACTION_DATE,'dd/MM/yyyy')#</div>",
                width: 100
            },
            {
                field: "INCOME_AMOUNT",
                title: "Сума надходжень",
                template: "<div style='text-align:right;'>#=INCOME_AMOUNT == null ? '' :INCOME_AMOUNT#</div>",
                headerAttributes: {
                    style: "white-space: normal;"
                },
                width: 120
            },
            {
                field: "BRANCH_ID",
                title: "BRANCH",
                width: 120
            }
        ],
        sortable: true,
        pageable: {
            pageSize: 20
        },
        selectable: "single",
        dataSource: transactionsDs
    });

    //инициализация диалогов
    $(notaryEditDialog).kendoWindow({
        title: "Нотаріус",
        width: "680px"
    });

    $(accreditationDlg).kendoWindow({
        title: "Акредитація",
        width: "680px"
    });


    //инициализация тулбара
    var toolButtons;
    if (isCaMode) {
        toolButtons = [
            { template: "<button id='addNotaryBtn' type='button' class='k-button' title='Додати нотаріуса'><i class='pf-icon pf-16 pf-add_button'></i></button>" },
            { template: "<button id='editNotaryBtn' type='button' class='k-button' title='Редагувати нотаріуса'><i class='pf-icon pf-16 pf-tool_pencil'></i></button>" },
            { type: "separator" },
            {
                type: "button",
                text: "Потребують підтвердження",
                togglable: true,
                id: "btnNeedAccept",
                selected: false,
                toggle: function () {
                    mainGridDs.read();
                }
            }
        ];
    } else {
        toolButtons = [];
    }

    var accrToolButtons;
    if (isCaMode) {
        accrToolButtons = [
            { template: "<button id='addAccrBtn' type='button' class='k-button' title='Додати акредитацію'><i class='pf-icon pf-16 pf-add_button'></i></button>" },
            { template: "<button id='editAccrBtn' type='button' class='k-button' title='Редагувати акредитацію'><i class='pf-icon pf-16 pf-tool_pencil'></i></button>" },
            { template: "<button id='closeAccrBtn' type='button' class='k-button' title='Закрити акредитацію'><i class='pf-icon pf-16 pf-table_row-delete2'></i></button>" },
            { template: "<h4> Нотаріус: <strong data-bind='text: currNotaryName'></strong> ID: <strong data-bind='text: currNotaryId'></strong></h4>" }
        ];
    } else {
        accrToolButtons = [];
    }

    $(toolBar).kendoToolBar({
        resizable: true,
        items: toolButtons
    });

    $(accreditationTools).kendoToolBar({
        resizable: true,
        items: accrToolButtons
    });

    //привязка кнопок
    $("#cancelNotary").on("click", function () { $(notaryEditDialog).data("kendoWindow").close() });
    $("#cancelAccreditation").on("click", function () { $(accreditationDlg).data("kendoWindow").close() });

    $("#addNotaryBtn").kendoButton({
        click: function () {
            prepareNotaryDialog("add");
            $(notaryEditDialog).data("kendoWindow").center().open();
        }
    });
    $("#editNotaryBtn").kendoButton({
        click: function () {
            prepareNotaryDialog("edit");
            $(notaryEditDialog).data("kendoWindow").center().open();
        }
    });

    $("#addAccrBtn").kendoButton({
        click: function () {
            prepareAccrDialog("add");
            $(accreditationDlg).data("kendoWindow").center().open();
        }
    });
    $("#editAccrBtn").kendoButton({
        click: function () {
            prepareAccrDialog("edit").done(function () {
                $(accreditationDlg).data("kendoWindow").center().open();
            });
        }
    });

    $("#closeAccrBtn").kendoButton({
        click: function () {
            bars.ui.confirm({ title: "Увага", text: 'Закрити обрану акредитацію?' },
                function () {
                    $.ajax({
                        type: "POST",
                        url: bars.config.urlContent("/Cdnt/Notary/CloseAccreditation"),
                        data: { accrId: bodyModel.get("currAccrId") },
                        success: function (data) {
                            if (data.status === "ok") {
                                //найти акредитацию и обновить данные о закрытиии
                                var accr = accrGridDs.data();
                                for (var i = 0; i < accr.length; i++) {
                                    if (accr[i].ID == data.data.ID) {
                                        accr[i].set("CLOSE_DATE", data.data.CLOSE_DATE);
                                        accr[i].set("STATE_ACCR", data.data.STATE_ACCR);
                                        break;
                                    }
                                }
                            } else {
                                bars.ui.error({ text: data.message });
                            }
                        }
                    });
                });
        }
    });

    $("input[name=\"date_of_birth\"]").kendoDatePicker({
        culture: "uk-UA"
    });

    $("input[name=\"start_date\"]").kendoDatePicker({
        culture: "uk-UA"
    });

    $("input[name=\"close_date\"]").kendoDatePicker({
        culture: "uk-UA"
    });

    $("input[name=\"passport_issued\"]").kendoDatePicker({
        culture: "uk-UA"
    });

    $("input[name=\"close_date\"]").data("kendoDatePicker").enable(false);

    $("input[name=\"accreditation_type_id\"]").kendoDropDownList({
        dataSource: accrTypesDs,
        dataTextField: "LIST_ITEM_NAME",
        dataValueField: "LIST_ITEM_ID"
    });

    $("input[name=\"state_id\"]").kendoDropDownList({
        dataSource: accrStatesDs,
        dataTextField: "LIST_ITEM_NAME",
        dataValueField: "LIST_ITEM_ID"
    });

    if (isCaMode) {
    $("input[name=\"notary_type\"]").kendoDropDownList({
        dataSource: notaryTypesDs,
        dataTextField: "LIST_ITEM_NAME",
        dataValueField: "LIST_ITEM_ID",
        change: function() {
            var value = this.value();
            if (value === "1") { //для государственного нотариуса отключаем обязательность большинства полей
                $("input[name=\"tin\"]").removeAttr('required');
                $("input[name=\"date_of_birth\"]").removeAttr('required');
                $("input[name=\"passport_series\"]").removeAttr('required');
                $("input[name=\"passport_number\"]").removeAttr('required');
                $("input[name=\"passport_issued\"]").removeAttr('required');
                $("input[name=\"passport_issuer\"]").removeAttr('required');
                $("input[name=\"address\"]").removeAttr('required');
            } else {
                $("input[name=\"tin\"]").prop('required', true);
                $("input[name=\"date_of_birth\"]").prop('required', true);
                $("input[name=\"passport_series\"]").prop('required', true);
                $("input[name=\"passport_number\"]").prop('required', true);
                $("input[name=\"passport_issued\"]").prop('required', true);
                $("input[name=\"passport_issuer\"]").prop('required', true);
                $("input[name=\"address\"]").prop('required', true);
            }
        }
    });

    
        $("select[name=\"branches\"]").kendoMultiSelect({
            dataSource: mfoListDs
        });
    }

    $("select[name=\"businesses\"]").kendoMultiSelect({
        dataSource: businessDs,
        dataTextField: "LIST_ITEM_NAME",
        dataValueField: "LIST_ITEM_ID"
    });

    kendo.bind(document.body, bodyModel);

}("#grid", "#toolbar", isCaMode, "#editNotaryDlg"));
