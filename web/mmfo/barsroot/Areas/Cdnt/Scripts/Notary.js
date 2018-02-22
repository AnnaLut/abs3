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

    function NotaryForm() {
        if (NotaryForm.instance) return NotaryForm.instance;//singleton

        this.id = $("input[name=\"notary_id\"]");

        // При додаванні поля в цей масив починайте назву з 'kendo_' для кендо-полів (типу kendoDropDownList, kendoDatePicker).
        var defaultProps = { 
            kendo_notary_type: 2, tin: null, last_name: null, first_name: null, middle_name: null, kendo_date_of_birth: null, kendo_document_type: 1,
            idcard_document_number: null, idcard_notation_number: null, passport_series: null, passport_number: null, kendo_passport_issued: null,
            kendo_passport_expiry: null, passport_issuer: null, address: null, phone_number: '+380', mobile_phone_number: '+380', email: null, certificate_number: null
        };

        var processRequiredInputs = function (inputs, isRequired) {
            if (isRequired == null) return;
            for (var i = 0; i < inputs.length; i++) {
                if (isRequired === true) {
                    inputs[i].prop('required', isRequired);
                }
                else {
                    inputs[i].removeAttr('required');
                }
                var star = inputs[i].siblings('.k-required')[0];
                if (!star) star = $(inputs[i].data('for'))[0];
                star.style.display = !isRequired ? 'none' : 'inline';
            }
        }

        this.processInputs = function (inputsTypeString, isRequired, isHide) {
            var inputs;
            switch (inputsTypeString) {
                case 'all': inputs = [
                    $("input[name=\"tin\"]"),
                    $("input[name=\"date_of_birth\"]"),
                    $("input[name=\"idcard_document_number\"]"),
                    $("input[name=\"idcard_notation_number\"]"),
                    $("input[name=\"passport_series\"]"),
                    $("input[name=\"passport_number\"]"),
                    $("input[name=\"passport_issued\"]"),
                    $("input[name=\"passport_expiry\"]"),
                    $("input[name=\"passport_issuer\"]"),
                    $("input[name=\"address\"]"),
                    $("input[name=\"mobile_phone_number\"]")
                ]; break;
                case 'passport': inputs = [
                    $("input[name=\"passport_series\"]"),
                    $("input[name=\"passport_number\"]")
                ]; break;
                case 'idcard': inputs = [
                    $("input[name=\"idcard_document_number\"]"),
                    $("input[name=\"idcard_notation_number\"]"),
                    $("input[name=\"passport_expiry\"]")
                ]; break;
                default: return;
            }

            processRequiredInputs(inputs, isRequired);

            if (isHide != null) {
                for (var i = 0; i < inputs.length; i++) {
                    inputs[i].closest('label')[0].style.display = isHide ? 'none' : 'block';
                }
            }
        }

        this.reset = function () {
            this.id.val(null);

            $.each(defaultProps, function (key, val) {
                if (key.indexOf('kendo') == 0) {
                    var input = $("input[name=\"" + key.substring(6) + "\"]");
                    var inp = input.data("kendoDropDownList");
                    if (!inp) inp = input.data("kendoDatePicker");
                    if (inp) inp.value(val);
                }
                else {
                    var input = $("input[name=\"" + key + "\"]");
                    if (input) input.val(val);
                }
            });

            this.processInputs('all', true);
            this.processInputs('idcard', false, true);
            this.processInputs('passport', null, false);
        }
        this.initInputs = function () {
            var grid = $(mainGrid).data("kendoGrid");
            var currentRowData = null;
            if (grid.select().length > 0) {
                currentRowData = grid.dataItem(grid.select());

                this.id.val(currentRowData.ID);

                $.each(defaultProps, function (key) {
                    if (key.indexOf('kendo') == 0) {
                        key = key.substring(6);
                        var input = $("input[name=\"" + key + "\"]");
                        var inp = input.data("kendoDropDownList");
                        if (!inp) inp = input.data("kendoDatePicker");
                        if (inp) inp.value(currentRowData[key.toUpperCase()]);
                    }
                    else {
                        var input = $("input[name=\"" + key + "\"]");
                        if (input) input.val(currentRowData[key.toUpperCase()]);
                    }
                });
            }

            this.processInputs('all', true); // Спочатку необхідно скинути в true, бо можливі помилки

            if (this.isIDCard()) {//ID-картка
                this.processInputs('idcard', null, false);
                this.processInputs('passport', false, true);
            }
            else {
                this.processInputs('passport', null, false);
                this.processInputs('idcard', false, true);
            }
            if (this.isStateNotary()) { //для государственного нотариуса отключаем обязательность большинства полей
                this.processInputs('all', false);
            }
        }
        this.enable = function (isEnable) {
            if (isEnable == null) isEnable = true;

            $.each(defaultProps, function (key, val) {
                if (key.indexOf('kendo') == 0) {
                    var input = $("input[name=\"" + key.substring(6) + "\"]");
                    var inp = input.data("kendoDropDownList");
                    if (!inp) inp = input.data("kendoDatePicker");
                    if (inp) inp.enable(isEnable);
                }
                else {
                    var input = $("input[name=\"" + key + "\"]");
                    if (input) input.prop("disabled", !isEnable);
                }
            });
        }
        this.isStateNotary = function () {
            return $("input[name=\"notary_type\"]").data("kendoDropDownList").value() === "1";
        }
        this.isIDCard = function () {
            return $("input[name=\"document_type\"]").data("kendoDropDownList").value() === "7";
        }
        NotaryForm.instance = this;
    }

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

        var deleteNotaryBtn = $("#deleteNotaryBtn").data("kendoButton");
        if (deleteNotaryBtn) {
            deleteNotaryBtn.enable(currentRowData);
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
                id: 'ID',
                fields: {
                    ID: { type: "number" },
                    DATE_OF_BIRTH: { type: "date" },
                    PASSPORT_ISSUED: { type: "date" },
                    PASSPORT_EXPIRY: { type: "date" },
                    NOTARY_TYPE: { type: "number" },
                    CERTIFICATE_ISSUE_DATE: { type: "date" },
                    CERTIFICATE_CANCELATION_DATE: { type: "date" }
                }
            }
        },
        pageSize: 20,
        serverPaging: true,
        serverSorting: true,
        serverFiltering: true,
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
    //Типи паспортів
    var documentTypeDs = new kendo.data.DataSource({
        type: "aspnetmvc-ajax",
        transport: {
            read: {
                url: bars.config.urlContent("/Cdnt/Notary/GetDocumentTypes")
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

    //валидаторы форм
    var notaryValidator = $(notaryEditDialog).kendoValidator({
        messages: {
            required: "Обов'язкове поле!",
            invalid_date_format: "Невірний формат дати!"
        },
        rules: {
            issuercheck: function (input) {
                if (input.is("[name=passport_issuer]") && new NotaryForm().isIDCard()) {
                    var val = input.val();
                    if (input[0].required) return /^\d+$/.test(val);
                    else return /^\d+$/.test(val) || !val;
                }
                return true;
            },
            passpseriescheck: function (input) {
                if (input.is("[name=passport_series]")) {
                    if (new NotaryForm().isIDCard()) return true;
                    var val = input.val();
                    if (input[0].required) return /^[a-zA-Zа-яА-ЯіІїЇєЄґҐ]{2}$/.test(val);
                    else return /^[a-zA-Zа-яА-ЯіІїЇєЄґҐ]{2}$/.test(val) || !val;
                }
                return true;
            },
            tincheck: function (input) {
                if (input.is("[name=tin]")) {
                    var val = input.val();
                    if (input[0].required) return /^[0-9]{10}$/.test(val);
                    else return /^[0-9]{10}$/.test(val) || !val;
                }
                return true;
            },
            mobphonecheck: function (input) {
                if (input.is("[name=mobile_phone_number]")) {
                    var number = input.val();
                    if (input[0].required) return /^[+0-9]{13}$/.test(number);
                    else return /^([+0-9]{13})|(\+380)$/.test(number) || !number;
                }
                return true;
            },
            passnumcheck: function (input) {
                if (input.is("[name=passport_number]")) {
                    if (new NotaryForm().isIDCard()) return true;
                    var val = input.val();
                    if (input[0].required) return /^[0-9]{6}$/.test(val);
                    else return /^[0-9]{6}$/.test(val) || !val;
                }
                return true;
            },
            idcardnumcheck: function (input) {
                if (input.is("[name=idcard_document_number]")) {
                    if (!new NotaryForm().isIDCard()) return true;
                    var val = input.val();
                    if (input[0].required) return /^[0-9]{9}$/.test(val);
                    else return /^[0-9]{9}$/.test(val) || !val;
                }
                return true;
            },
            idcardnotationnumcheck: function (input) {
                if (input.is("[name=idcard_notation_number]")) {
                    if (!new NotaryForm().isIDCard()) return true;
                    var val = input.val();
                    if (input[0].required) return /^[0-9]{8}-[0-9]{5}$/.test(val);
                    else return /^[0-9]{8}-[0-9]{5}$/.test(val) || !val;
                }
                return true;
            },
            invalid_date_format: function (input) {
                if ((input.is("[name=date_of_birth]") || input.is("[name=passport_issued]") || input.is("[name=passport_expiry]")) && input.val()) {
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
            $("input[name=\"accreditation_id\"]").val(null);
            $("input[name=\"accreditation_notary_id\"]").val(bodyModel.currNotaryId); //привяжем до поточного нотаріуса
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
                        newAccreditation.NOTARY_ID = newAccreditation.ACCREDITATION_NOTARY_ID;
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
                $("input[name=\"accreditation_id\"]").val(currentRowData.ID);
                $("input[name=\"accreditation_notary_id\"]").val(currentRowData.NOTARY_ID);
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
                            newAccreditation.ID = newAccreditation.ACCREDITATION_ID;
                            newAccreditation.NOTARY_ID = newAccreditation.ACCREDITATION_NOTARY_ID;
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

        var validForm = function () {
            return notaryValidator.validate();
        }

        clearValidationMarks();
        var notaryForm = new NotaryForm();
        if (mode === "add") {
            dialog.title("Нотаріус [Додавання нового]");
            //очистка формы
            notaryForm.reset();
            notaryForm.enable(true);

            $("#saveNotary").text('Зберегти');
            $("#saveNotary")
                .unbind("click")
                .on("click", function () {
                    if (validForm()) {
                        var newNotarius = $("#notary").serializeObject(true);
                        $.post(bars.config.urlContent("/Cdnt/Notary/CreateNotary"), newNotarius, function (data) {
                            if (data.status === "ok") {
                                newNotarius.ID = data.data;
                                newNotarius.CNT_ACCR = 0;
                                newNotarius.CNT_REQACCR = 0;
                                newNotarius.NOTARY_TYPE_NAME = newNotarius.NOTARY_TYPE == 1 ? 'державний' : 'приватний';
                                mainGridDs.read();
                                //mainGridDs.add(newNotarius);
                                dialog.close();
                            } else {
                                bars.ui.error({ text: data.message });
                            }
                        });
                    }
                });
        }
        else if (mode === "edit") {
            notaryForm.initInputs();
            notaryForm.enable(true);
            var grid = $(mainGrid).data("kendoGrid");

            dialog.title("Нотаріус - редагування [ID=<strong>" + notaryForm.id.val() + "</strong>]");

            $("#saveNotary").text('Оновити');
            $("#saveNotary")
                .unbind("click")
                .on("click", function () {
                    if (validForm()) {
                        var newNotarius = $("#notary").serializeObject(true);
                        newNotarius.ID = newNotarius.NOTARY_ID;

                        $.post(bars.config.urlContent("/Cdnt/Notary/EditNotary"), newNotarius, function (data) {
                            if (data.status === "ok") {
                                //ищем запись в гриде и обновляем ее
                                var notary = mainGridDs.data();
                                for (var i = 0; i < notary.length; i++) {
                                    if (notary[i].ID == newNotarius.ID) {
                                        $.each(newNotarius, function (key, value) {
                                            notary[i].set(key, value);
                                        });
                                        notary[i].set('NOTARY_TYPE_NAME', newNotarius.NOTARY_TYPE == 1 ? 'державний' : 'приватний');
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
        }
        else if (mode == "delete") {
            notaryForm.initInputs();
            notaryForm.enable(false);
            var notaryId = notaryForm.id.val();
            dialog.title("Нотаріус - Вилучення [ID=<strong>" + notaryId + "</strong>]");

            $("#saveNotary").text('Видалити');
            $("#saveNotary")
                .unbind("click")
                .on("click", function () {
                    $.post(bars.config.urlContent("/Cdnt/Notary/DeleteNotary"), { ID: notaryId }, function (data) {
                        if (data.status === "ok") {
                            var dataRow = mainGridDs.get(parseInt(notaryId));
                            mainGridDs.remove(dataRow);
                            dialog.close();
                        } else {
                            bars.ui.error({ text: data.message });
                        }
                    });
                });
        }
        else {
            bars.ui.error({ text: "Не визначений тип дії!" });
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
        toolbar: ["excel"],
        excel: {
            allPages: true,
            fileName: "nota.xlsx",
            proxyURL: bars.config.urlContent("/Notary/ExportToExcel")
        },
        resizable: true,
        columns: [
            {
                field: "ID",
                title: "Іден</br>тифі</br>катор",
                width: 67,
                headerAttributes: {
                    style: "white-space: normal;"
                },
                template: "<div style='text-align:right;'>#=ID#</div>"
            },
            {
                field: "ACCR_BRANCHES",
                title: "Номер</br>заявника",
                width: 90,
                template: "#=ACCR_BRANCHES == null ? '' : ACCR_BRANCHES.replace(/;/g, '; ')#",
                headerAttributes: {
                    style: "white-space: normal;"
                }
            },
            {
                field: "ACCR_BRANCHNAMES",
                title: "Назва</br>заявника",
                width: 150,
                headerAttributes: {
                    style: "white-space: normal;"
                }
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
                title: "По-бать</br>кові",
                width: 105
            },
            {
                field: "DATE_OF_BIRTH",
                title: "Дата</br>народ</br>ження",
                headerAttributes: {
                    style: "white-space: normal;"
                },
                template: "<div style='text-align:right;'>#=DATE_OF_BIRTH == null ? '' :kendo.toString(DATE_OF_BIRTH,'dd/MM/yyyy')#</div>",
                width: 90
            },
            {
                field: "PASSPORT",
                title: "Паспорт /</br>ID-картка",
                template: "#=DOCUMENT_TYPE == 1 ? PASSPORT_SERIES + ' ' + PASSPORT_NUMBER : IDCARD_DOCUMENT_NUMBER + ' </br> ' + IDCARD_NOTATION_NUMBER#",
                //temlate: function (data) {
                //    var html = '<div>';
                //    if (data.DOCUMENT_TYPE == 1) {
                //        html += data.PASSPORT_SERIES + ' ' + data.PASSPORT_NUMBER;
                //    }
                //    else {
                //        html += data.IDCARD_DOCUMENT_NUMBER + ' </br> ' + data.IDCARD_NOTATION_NUMBER;
                //    }
                //    html =+ '</div>';
                //    return html;
                //},
                headerAttributes: {
                    style: "white-space: normal;"
                },
                width: 120
            },
            {
                field: "PASSPORT_ISSUED",
                title: "Дата видачі паспорту / ID-картки",
                headerAttributes: {
                    style: "white-space: normal;"
                },
                template: "<div style='text-align:right;'>#=PASSPORT_ISSUED == null ? '' :kendo.toString(PASSPORT_ISSUED,'dd/MM/yyyy')#</div>",
                width: 100
            },
            {
                field: "PASSPORT_EXPIRY",
                title: "Дійсний до</br>(для ID-картки)",
                headerAttributes: {
                    style: "white-space: normal;"
                },
                template: "<div style='text-align:right;'>#=PASSPORT_EXPIRY == null ? '' :kendo.toString(PASSPORT_EXPIRY,'dd/MM/yyyy')#</div>",
                width: 90
            },
            {
                field: "PASSPORT_ISSUER",
                title: "Орган, що видав паспорт /</br>ID-картку",
                headerAttributes: {
                    style: "white-space: normal;"
                },
                width: 200
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
                title: "Номер телефону / факсу",
                width: 110
            },
            {
                field: "MOBILE_PHONE_NUMBER",
                title: "Номер мобільного",
                headerAttributes: {
                    style: "white-space: normal;"
                },
                width: 110
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
                field: "IS_APPROVED",
                title: "Акре</br>дито</br>вано",
                width: 70,
                template: "#=((CNT_ACCR ? CNT_ACCR : 0) - (CNT_REQACCR ? CNT_REQACCR : 0) > 0) ? '<div style=\"text-align:center;\"><span class=\"pf-icon pf-16 pf-ok\"></span></div>' : '&nbsp;' #",
                headerAttributes: {
                    style: "white-space: normal;"
                }
            },
            {
                field: "ACCREDITATION_TYPE",
                title: "Тип</br>акредита-</br>ції</br>нотаріуса",
                width: 95,
                headerAttributes: {
                    style: "white-space: normal;"
                }
            },
            {
                field: "ACCR_SEG_OF_BUSINESS",
                title: "Акредитовані</br>бізнеси",
                width: 150,
                template: "#=ACCR_SEG_OF_BUSINESS == null ? '' : ACCR_SEG_OF_BUSINESS.replace(/;/g, '; ')#",
                headerAttributes: {
                    style: "white-space: normal;"
                }
            },
            {
                title: "№ Свідоцтва нотаріуса",
                field: "CERTIFICATE_NUMBER",
                width: 95,
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
            { template: "<button id='deleteNotaryBtn' type='button' class='k-button' title='Вилучити нотаріуса'><i class='pf-icon pf-16 pf-delete'></i></button>" },
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

    $("#deleteNotaryBtn").kendoButton({
        click: function () {
            prepareNotaryDialog("delete");
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
    $("input[name=\"passport_expiry\"]").kendoDatePicker({
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
            change: function () {
                var value = this.value();
                var notaryForm = new NotaryForm();
                clearValidationMarks();
                if (value === "1") { //для государственного нотариуса отключаем обязательность большинства полей
                    notaryForm.processInputs('all', false);
                } else {
                    notaryForm.processInputs('all', true);
                    
                    if (notaryForm.isIDCard()) {
                        notaryForm.processInputs('passport', false);
                    }
                    else {
                        notaryForm.processInputs('idcard', false);
                    }
                }
            }
        });

        $("input[name=\"document_type\"]").kendoDropDownList({
            dataSource: documentTypeDs,
            dataTextField: "LIST_ITEM_NAME",
            dataValueField: "LIST_ITEM_ID",
            change: function () {
                var value = this.value();
                var notaryForm = new NotaryForm();
                clearValidationMarks();
                if (value === "1") { //паспорт
                    notaryForm.processInputs('idcard', false, true);
                    var isRequired = notaryForm.isStateNotary() ? null : true;
                    notaryForm.processInputs('passport', isRequired, false);
                } else {
                    notaryForm.processInputs('passport', false, true);
                    var isRequired = notaryForm.isStateNotary() ? null : true;
                    notaryForm.processInputs('idcard', isRequired, false);
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
