//УВАГА!!!!
//Це основний робочий файл для роботи з анкетою клієнта,
//також багато функцій розташовані у наступних файлах: 
//helperFunctions, dropDownList, panelAnimations, benefProfile та clientGrids js files

//namespaces
var dropdown = dropdown || {};
var panel = panel || {};
var clientGrids = clientGrids || {};
var help = help || {};
$(document).ready(function () {

    //call from dropDownLists.js file
    dropdown.dropDownLists();
    dropdown.picker();

    //call from panelAnimation.js file
    panel.initPanel();

    //store and save rnk in variable
    var rnk = (function () {
        var state; //private variable, save current rnk

        var pub = {}; //public object for access prop

        pub.setRnk = function (newRnk) {
            if (newRnk === "0" || newRnk === "" || newRnk === "undefined") {
                state = undefined;
            } else {
                state = newRnk;
            }
            localStorage.setItem('id', state);
        };
        pub.getRnk = function () {
            return state;
        }
        return pub;
    }());

    //зчитування URL параметрів
    rnk.setRnk(bars.extension.getParamFromUrl('rnk', window.location.toString()));
    var burial = bars.extension.getParamFromUrl('burial', window.location.toString());
    var herid = bars.extension.getParamFromUrl('herid', window.location.toString());//id вкладу з якого будуть списані кошти при оформленні спадщини
    var funeral = bars.extension.getParamFromUrl('funeral', window.location.toString());
    var back = bars.extension.getParamFromUrl('button', window.location.toString()); //при вході через функція бекофісу
    var deposiptId = bars.extension.getParamFromUrl('depoId', window.location.toString()); //при натиснені кнопки "Одержувач" на анкеті вклада для сворення клієнта з подальною прив'язкою вкладу
    var control = bars.extension.getParamFromUrl('control', window.location.toString()); //для ящко через АРМ контролера то сховує меню
    var actid = bars.extension.getParamFromUrl('actid', window.location.toString());//при переході із неактуалізованих вкладів для створення ного клієнта даний вклад відразу прив'язується до клієнта

    $("#toolbar").kendoToolBar({
        items: [
            { template: "<button type='button' id='btnEdit' class='k-button right-pos tool-btn'><span class='k-sprite pf-icon pf-16 pf-tool_pencil'></span> Редагувати</button>" },//0
            { template: "<button type='submit' id='saveBtn' class='k-button right-pos tool-btn'><span class='k-sprite pf-icon pf-16 pf-save'></span> Зберегти</button>" },//1
            { template: "<button type='button' id='addMoney' class='k-button right-pos tool-btn'><span class='k-sprite pf-icon pf-16 pf-money' ></span>  Частка спадщини</button>" },//2
            { template: "<button type='button' id='addAttorney' class='k-button right-pos tool-btn'><span class='k-sprite pf-icon pf-16 pf-user'></span> Бенефіціари</button>" },//3
            { template: "<button type='button' id='history' class='k-button left-pos tool-btn'><span class='k-sprite pf-icon pf-16 pf-list-arrow_right'></span> Історія змін</button>" },//4
            { template: "<button type='button' id='unLinkDeposit' class='k-button right-pos tool-btn'><span class='k-sprite pf-icon pf-16 pf-delete'></span> Відміна актуалізації</button>" },//5
            { template: "<button type='button' id='linkDeposit' class='k-button right-pos tool-btn'><span class='k-sprite pf-icon pf-16 pf-ok'></span> Актуалізація вкладу</button>" },//6
            { template: "<button type='button' id='backToDepo' class='k-button right-pos tool-btn'><span class='k-sprite pf-icon pf-16 pf-list-arrow_right'></span> Анкета вкладу</button>" },//7
            { template: "<button type='button' id='reqUnLink' class='k-button right-pos tool-btn'><span class='k-sprite pf-icon pf-16 pf-arrow_left'></span> Запит на відміну актуалізації</button>" },//8
            { template: "<button type='button' id='print' class='k-button right-pos tool-btn'><span class='k-sprite pf-icon pf-16 pf-print'></span> Друк</button>" }//9
        ]
    });


    //функції для відображення та сховування кнопок меню анкети клієнта
    //Example: buttons = [2, 3, 5, 6];
    var buttonsHide = function (buttons) {
        if (help.contains.call(buttons, 0)) {
            $("#btnEdit").hide();
        }
        if (help.contains.call(buttons, 1)) {
            $("#saveBtn").hide();
        }
        if (help.contains.call(buttons, 2)) {
            $("#addMoney").hide();
        }
        if (help.contains.call(buttons, 3)) {
            $("#addAttorney").hide();
        }
        if (help.contains.call(buttons, 4)) {
            $("#history").hide();
        }
        if (help.contains.call(buttons, 5)) {
            $("#unLinkDeposit").hide();
        }
        if (help.contains.call(buttons, 6)) {
            $("#linkDeposit").hide();
        }
        if (help.contains.call(buttons, 7)) {
            $("#backToDepo").hide();
        }
        if (help.contains.call(buttons, 8)) {
            $("#reqUnLink").hide();
        }
        if (help.contains.call(buttons, 9)) {
            $("#print").hide();
        }
    }

    var buttonsShow = function (buttons) {
        if (help.contains.call(buttons, 0)) {
            $("#btnEdit").show();
        }
        if (help.contains.call(buttons, 1)) {
            $("#saveBtn").show();
        }
        if (help.contains.call(buttons, 2)) {
            $("#addMoney").show();
        }
        if (help.contains.call(buttons, 3)) {
            $("#addAttorney").show();
        }
        if (help.contains.call(buttons, 4)) {
            $("#history").show();
        }
        if (help.contains.call(buttons, 5)) {
            $("#unLinkDeposit").show();
        }
        if (help.contains.call(buttons, 6)) {
            $("#linkDeposit").show();
        }
        if (help.contains.call(buttons, 7)) {
            $("#backToDepo").show();
        }
        if (help.contains.call(buttons, 8)) {
            $("#reqUnLink").show();
        }
        if (help.contains.call(buttons, 9)) {
            $("#print").show();
        }
    }

    var globalFilter = function () {
        buttonsHide([1, 2, 7, 8, 9]);
        if ($('#docTypeDropList').val() === "7") {
            $(".passp-id").show();
            $(".non-passp-id").hide();
        } else {
            $(".passp-id").hide();
            $(".non-passp-id").show();
        }
        //анкета клієнта для перегляду (контролер)
        if (control === "1") {
            $("#toolbar").hide();
            $(".container-fluid").css("margin-top", 0);
        } else if (deposiptId !== null) {
            buttonsHide([0, 1, 2, 3, 4, 5, 6]);
            buttonsShow([7]);
            $(".only-for-funeral").show();
        }
        if (burial || funeral) {
            //$("#pnPayAttr").hide();
            buttonsHide([5, 6, 9]);
            $(".only-for-funeral").show();
            $("#mfo").removeAttr("required");
            $("#nls").removeAttr("required");
        }

        if (burial === "true") {
            buttonsShow([2]);
        }

        if (rnk.getRnk() === undefined) {
            buttonsShow([9]);
            buttonsHide([3]);
        } else {
            if (back === "true") {
                buttonsHide([0]);
            } else {
                buttonsShow([8]);
            }
        }
    };

    var actualDepo = function (depositId) {
        var opercode = (burial === "true" ? "ACT_HER" : funeral === "true" ? "ACT_BUR" : "ACT_DEP");

        var grid = $("#deposit").data("kendoGrid");
        var row = grid.dataItem(grid.select());
        var model = {
            userid: rnk.getRnk(),
            compenid: typeof depositId !== "string" ? row.ID : depositId,
            opercode: opercode
        }
        $.ajax({
            url: bars.config.urlContent("/api/crkr/depo/actualcompen"),
            type: "POST",
            data: model,
            success: function (result) {
                var flag = result.includes("ORA");
                if (flag) {
                    help.showError(result);
                } else {
                    $("#actual").data("kendoWindow").close();
                    help.getLimit(rnk.getRnk());
                    bars.ui.notify('Увага!', 'Вклад відправлено на візування', 'success');
                }
            }
        });
    };

    var switchButton = function (bool) {
        if (bool === true) {
            buttonsHide([2, 3, 4, 6]);
        } else {
            buttonsShow([2, 3, 4, 6]);
        }
        $("#addMoney").prop("disabled", bool);
        //відключення кнопок для операціоніста
        if (back === "false" || back === null) {
            buttonsHide([0, 5]);
        } else {
            buttonsShow([5]);
            buttonsHide([0, 6, 8]);
        }
    };

    //read client from database
    var getData = function (rnk) {
        $.ajax({
            url: bars.config.urlContent("/api/Crkr/GetProfile/GetData"),
            type: "GET",
            data: { rnk: rnk },
            success: function (result) {
                if (result.FullName != null)
                {
                    var fullnameArray = result.FullName.split(/[\s]+/);
                    $('#lastname').val(fullnameArray[0]);
                    $('#firstname').val(fullnameArray[1]);
                    $('#middlename').val(fullnameArray[2]);
                }
                $('#inn').val(result.INN);
                $("#organ").val(result.Organ);
                $('#phone').val(result.PhoneNumber);
                $('#mobileNumber').val(result.MobileNumber);
                $('#sourceDownload').val(result.SourceDownload);
                $('#postIndex').val(result.Postindex);
                $('#region').val(result.Region);
                $('#area').val(result.Area);
                $('#city').val(result.City);
                $('#address').val(result.Address);
                $('#sexDropList').data('kendoDropDownList').value(parseInt(result.ID_SEX));
                $('#resDropList').data('kendoDropDownList').value(parseInt(result.ID_REZID));
                $('#docTypeDropList').data('kendoDropDownList').value(parseInt(result.ID_DOC_TYPE));

                if (result.ID_DOC_TYPE === "7") {
                    $(".passp-id").show();
                    $(".non-passp-id").hide();
                    $("#eddrid").val(result.EddrId);
                    $("#docid").val(result.NumDoc);
                    $("#actualdate").val(kendo.toString(kendo.parseDate(result.ActualDateTime), 'dd.MM.yyyy'));
                    $("#bplace").val(result.Bplace);
                    help.requiredDocForId();
                } else {
                    $(".passp-id").hide();
                    $(".non-passp-id").show();
                    $('#serial').val(result.Ser);
                    $('#number').val(result.NumDoc);
                    help.requiredDocForNonId();
                }

                $('#country').data('kendoDropDownList').value(parseInt(result.CountryId));
                $('#codeDep').val(result.DepartmentCode);
                $('#mfo').data('kendoDropDownList').value(result.Mfo);

                $("#birthday").val(kendo.toString(kendo.parseDate(result.Birthday), 'dd.MM.yyyy'));
                $("#issueDate").val(kendo.toString(kendo.parseDate(result.IssueDate), 'dd.MM.yyyy'));
                $("#dateRegister").val(kendo.toString(kendo.parseDate(result.DateVal), "dd.MM.yyyy"));
                $("#clientPanelHead > h3").text("Анкета клієнта - " + result.FullName + " (" + rnk + ")");
                
                if ($("#middlename").val() === "") {
                    $("#middlenamecheck").prop("checked", true);
                    $("#middlename").prop("disabled", true).addClass("disable").css("border-color", "rgb(204, 204, 204)");
                }
                if ($("#inn").val() === "") {
                    $("#inncheck").prop("checked", true);
                }
                if ($("#serial").val() === "") {
                    $("#serialcheck").prop("checked", true);
                }

                if (result.Secondary === "1") {
                    $('#nlsedrpou').val(result.Nls).prop("readonly", true);;
                    $('#mfoedrpou').val(result.Mfo).prop("readonly", true);
                    $("#edrpoucheck").prop("checked", "checked");
                    $("#edrpou").val(result.Okpo);
                    $(".only-for-funeral").show();
                    $("#ml").hide();
                    $("#me").show();
                    $("#nl").hide();
                    $("#ne").show();
                    $("#nls").removeAttr("required");
                    $("#mfo").removeAttr("required");
                } else {
                    $("#nls").data("kendoDropDownList").dataSource.add({ "NMS": result.Nls, "NLS": result.Nls });
                    $("#nls").data("kendoDropDownList").select(1);
                    $("#mfo").prop("required", true);
                    //$('#nls').val(result.Nls);
                    $("#me").hide();
                    $("#ml").show();
                    $("#ne").hide();
                    $("#nl").show();
                }
                if (result.IsEdit > 0 || back === "true") {
                    buttonsHide([0, 1]);
                }
                else if (result == null) {
                    buttonsHide([0]);
                }
                else {
                    buttonsShow([0]);
                }
            },
            error: function (result) {
                bars.ui.error({ title: "Помилка!", text: "Сталася помилка " + result });
            }
        });
    };

    //завантажує дані на гріди при переході на вкладку
    function onSelect(e) {
        var index = $(e.item).index();
        if (rnk.getRnk() !== undefined) {
            if (index === 0) {//вклади
                clientGrids.clientDepo(rnk.getRnk());
            } else if (index === 1) {//вклади по похованю
                clientGrids.depoOnFuneral(rnk.getRnk());
            } else if (index === 2) {//довіреності
                clientGrids.attorney(rnk.getRnk());
            } else if (index === 3) {//Заповідальне розпорядження
                clientGrids.testamentary(rnk.getRnk());
            }
        }
    }

    var tabstrip = $("#tabstrip").kendoTabStrip({
        change: function () {
            var selectedIndex = tabstrip.select().index();
            if (selectedIndex === 1) {
                $("#addAttorney").prop("disabled", true);
                $("#clientProfileGrid").data("kendoGrid").refresh();
            }
        },
        select: onSelect
    }).data("kendoTabStrip");
    tabstrip.select(0);

    //налаштовує відображення сторінки в залежності від наявності РНК клієнта
    var checkRnk = function (rnk, regnow) {
        $("#addAttorney").prop("disabled", true);
        $("#editBenef").prop("disabled", true);
        $("#editAttorneyWills").prop("disabled", true);
        $("#delAttorneyWills").prop("disabled", true);
        if (rnk !== undefined) {
            if (regnow !== true) {
                getData(rnk);
            }
            else {
                clientGrids.clientDepo(rnk);
            }
            help.getLimit(rnk);
            help.switchInput(true);
            help.switchListAndPicker(false);
            switchButton(false);
            help.checkBox(true);
            $("#operation").removeClass("hiden-block");
            $("#tabstrip").removeClass("hiden-block");
            $("input").addClass('disable');
            $("#depoName").removeClass('disable');
        } else {
            var depomodel = JSON.parse(localStorage.getItem("depomodel"));
            if (depomodel !== undefined && depomodel !== null) {
                var fullnameArray = depomodel.fio.split(/[\s]+/);
                $("#lastname").val(fullnameArray[0]);
                $("#firstname").val(fullnameArray[1]);
                $("#middlename").val(fullnameArray[2]);
                $("#serial").val(depomodel.docser);
                $("#number").val(depomodel.docnumb);
                $("#organ").val(depomodel.organ);
                $("#docTypeDropList").data("kendoDropDownList").value(parseInt(depomodel.doctype));
                $("#issueDate").val(kendo.toString(depomodel.docdate, "dd.MM.yyyy"));
                localStorage.clear();
            }
            help.valDate();
            switchButton(true);
            help.checkBox(false);
            help.userBranch();
            $("#operation").addClass("hiden-block");
            $("#tabstrip").addClass("hiden-block");
        }
        globalFilter();
    };
    checkRnk(rnk.getRnk());



    //Прив'язує вклад у випадку якщо був переданий deposiptId (актуал. на поховання)
    var clientRecip = function (userid, depositId) {
        bars.ui.loader("body", true);
        $.ajax({
            type: "POST",
            url: bars.config.urlContent("/api/crkr/depo/actualcompen"),
            data: { userid: userid, compenid: depositId, opercode: "ACT_BUR" },
            success: function (result) {
                if (typeof (result) === "string" && result.includes("ORA")){                    
                    help.showError(result);
                }
                bars.ui.loader("body", false);
            }
        });
    };

    var validator = $("#clientProfile").kendoValidator({
        rules: {
            custom: function (input) {
            
                var doctype = $("#docTypeDropList").data("kendoDropDownList").value();

                if (input.is("[name=firstname], [name=lastname], [name=middlename]")) {
                    return /(([A-ZА-ЯІЇЄҐ]{1})([a-zа-яіїёєґ'_]+)-[A-ZА-ЯІЇЄҐ]{1}([a-zа-яіїёєґ'_]+$))|([A-ZА-ЯІЇЄҐ]{1})([a-zа-яіїёєґ'_]+$)/.test(input.val());
                }
                if (input.is("[name=inn]")) {
                    return /^(\d{10})$/.test(input.val());
                }
                if (input.is("[name=birthday], [name=dateRegister], [name=issueDate]")) {
                    var date = kendo.parseDate(input.val());
                    if (date > new Date())
                        return false;
                    else
                        return /^\d{1,2}.\d{1,2}.\d{4}$/.test(input.val());
                }
                if (input.is("[name=phone]")) {
                    if (input.val() !== "")
                        return /^\d{5,15}$/.test(input.val());
                }

                if ($("#edrpoucheck").is(":checked")) {
                    if (input.is("[name=edrpou]")) {
                        return /^([0-9]{8,15})$/.test(input.val());
                    }
                    if (input.is("[name=mfoedrpou]")) {
                        return /^([0-9]{6})$/.test(input.val());
                    }
                    if (input.is("[name=nlsedrpou]")) {
                        return /^([0-9]{8,15})$/.test(input.val());
                    }
                }
                else {
                    if (input.is("[name=mfo]")) {
                        return /^([0-9]{6})$/.test(input.val());
                    }
                    if (input.is("[name=nls]")) {
                        return /^([0-9]{8,15})$/.test(input.val());
                    }
                }
                //паспорт ID картка
                if (doctype === "7") {
                    if (input.is("[name=eddrid]")) {
                        if (input.val() !== "")
                            return /^([0-9]{8})-([0-9]{5})$/.test(input.val());
                    }
                    if (input.is("[name=docid]")) {
                        return /^([0-9]{9})$/.test(input.val());
                    }
                } else {
                    if (input.is("[name=serial]") && input.val() !== "") {
                        if (doctype === "1") //паспорт гр. України
                            return /^[А-ЯA-Z]{2}$/.test(input.val());
                        else if (doctype === "3") //свідоцтво про народження
                            return /^(\d{1}[VX]{1,4}-[А-ЯЇЄҐ]{2})$/.test(input.val());
                        else if (doctype === "11") //закордонний паспорт
                            return /^[A-Z]{2}$/.test(input.val());
                        else if (doctype === "15") //тимчасове посвідчення особи
                            return /^[А-ЯІЇЄҐ]{2,7}$/.test(input.val());
                        else if (doctype === "98") //свідоцтво про смерть
                            return /^(\d{1}[VX]{1,4}-[А-ЯЇЄҐ]{2})$/.test(input.val());
                        else if (doctype === "95") //свідоцтво про смерть (закордонний)
                            return /^([A-Z0-9]{2,6})$/.test(input.val());
                        else if (doctype !== "13") //паспорт нерезидента перевіряється у custom2
                            return /^([0-9A-ZА-ЯІЇЄҐ-]{2,6})$/.test(input.val());
                    }
                    if (input.is("[name=number]") && input.val() !== "") {
                        if (doctype === "13")//паспорт нерезидента
                           return /^\d*$/.test(input.val());
                        else
                        if (doctype === "15")//тимчасове посвідчення особи
                            return /^\d{1,8}$/.test(input.val());
                        else
                            return /^\d{6}$/.test(input.val());
                    }
                }          
                return true;
            },
            custom2: function (input) {
                var doctype = $("#docTypeDropList").data("kendoDropDownList").value();

                if (input.is("[name=docserial]") && $('[name="heir"]:checked').val() == 0) {
                    if (doctype === "13") //паспорт нерезидента
                        return /^\s*\S+.*/.test(input.val());
                }
                if (input.is("[name=docnumber]") && $('[name="heir"]:checked').val() == 0) {
                    if (doctype === "13")//паспорт нерезидента
                        return /^\s*\S+.*/.test(input.val());
                }

                return true;
            }
        },
        messages: {
            "custom": "Некоректні дані!",
            "custom2": "Це поле є обов'язковим!",
            "required": "Це поле є обов'язковим!"

        }
    }).data("kendoValidator");

    var megaModel = function (inn) {
        var lastname = $('#lastname').val();
        var firstname = $('#firstname').val();
        var middlename = $('#middlename').val();
        var fullName = lastname + " " + firstname + " " + middlename;
        var mfoVal = "";
        var nlsVal, okpo = "";
        if ($("#edrpoucheck").is(":checked")) {
            nlsVal = $("#nlsedrpou").val();
            mfoVal = $("#mfoedrpou").val();
            okpo = $("#edrpou").val();
        } else {
            nlsVal = $("#nls").val();
            mfoVal = $("#mfo").val();
            okpo = null;
        }
        return {
            RNK: rnk.getRnk(),
            FullName: fullName,
            INN: inn,
            Sex: $("#sexDropList").val(),
            StrBirthday: $("#birthday").val(),
            SignResidency: $("#resDropList").val(),
            DocumentType: $("#docTypeDropList").val(),
            Ser: $("#serial").val(),
            NumDoc: $("#docTypeDropList").val() === "7" ? $("#docid").val() : $("#number").val(),
            StrIssueDate: $("#issueDate").val(),
            Organ: $("#organ").val(),
            EddrId: $("#eddrid").val(),
            ActualDate: $("#actualdate").val(),
            CountryId: $("#country").val(),
            Bplace: $("#bplace").val(),
            PhoneNumber: $("#phone").val(),
            MobileNumber: $("#mobileNumber").val(),
            DepartmentCode: $("#codeDep").val(),
            SourceDownload: null,
            StrRegisterDate: $("#dateRegister").val(),
            Postindex: $("#postIndex").val(),
            Area: $("#region").val(),
            Region: $("#area").val(),
            City: $("#city").val(),
            Mfo: mfoVal,
            Nls: nlsVal,
            Secondary: $("#edrpoucheck").is(":checked") ? 1 : 0,
            Okpo: okpo,
            Address: $("#address").val()
        }
    }

    //збереження клієнта
    $("#saveBtn").click(function () {
        if (validator.validate()) {
            bars.ui.confirm({ text: "Ви дійсно бажаєте зберегти даного користувача?" }, function () {
                var giveD = kendo.toString(kendo.parseDate($("#issueDate").val()), 'dd.MM.yyyy');
                var dateParts = giveD.split(".");
                var date1 = new Date(dateParts[2], (dateParts[1] - 1), dateParts[0]);
                var birthdayD = kendo.toString(kendo.parseDate($("#birthday").val()), 'dd.MM.yyyy');
                dateParts = birthdayD.split(".");
                var date2 = new Date(dateParts[2], (dateParts[1] - 1), dateParts[0]);

                var okpo = $("#inn").val();
                if (okpo === "") {
                    okpo = "0000000000";
                }
                if (date2 > date1) {
                    bars.ui.alert({ title: "Помилка!", text: "Дата видачі не може бути меншою дати народження!" });
                } else {
                    bars.ui.loader("body", true);
                    $.ajax({
                        type: "POST",
                        url: bars.config.urlContent("/api/crkr/saveclient/createclient"),
                        data: megaModel(okpo),
                        success: function (data) {
                            bars.ui.loader("body", false);
                            buttonsHide([1]);
                            var flag = false;
                            if (typeof (data) === "string")
                                flag = data.includes("ORA");
                            if (!flag) {
                                bars.ui.notify("Клієнта збережено", "ID = " + data, "success");
                                if (deposiptId !== null) {
                                    clientRecip(data, deposiptId);
                                } else {
                                    rnk.setRnk(data);
                                    checkRnk(rnk.getRnk());
                                }
                            } else {
                                buttonsShow([9]);
                                //$("#print").prop("disabled", false);
                                checkRnk(rnk.getRnk());
                                var startPos = data.indexOf(':') + 1;
                                var endPos = data.indexOf('ORA', 2);
                                var textRes = data.substring(startPos, endPos);
                                bars.ui.error({ title: "Помилка!", text: textRes });
                            }
                        }
                    });

                }
            });
        } else {
            bars.ui.notify("Увага!", "Не виконано усі умови валідації", "error");
        }
    });

    $("#print").click(function () {
        if (validator.validate()) {
            bars.ui.confirm({ text: "Ви дійсно бажаєте здійснити друк анкети клієнта?" }, function () {
                var giveD = kendo.toString(kendo.parseDate($("#issueDate").val()), 'dd.MM.yyyy');
                var dateParts = giveD.split(".");
                var date1 = new Date(dateParts[2], (dateParts[1] - 1), dateParts[0]);
                var birthdayD = kendo.toString(kendo.parseDate($("#birthday").val()), 'dd.MM.yyyy');
                dateParts = birthdayD.split(".");
                var date2 = new Date(dateParts[2], (dateParts[1] - 1), dateParts[0]);

                var okpo = $("#inn").val();
                if (okpo === "") {
                    okpo = "0000000000";
                }
                if (date2 > date1) {
                    bars.ui.alert({ title: "Помилка!", text: "Дата видачі не може бути меншою дати народження!" });
                } else {
                    bars.ui.loader("body", true);
                    var megamodel = megaModel(okpo);
                    $.ajax({
                        type: "POST",
                        url: bars.config.urlContent("/api/crkr/saveclient/createclient"),
                        data: megamodel,
                        success: function (data) {
                            bars.ui.loader("body", false);
                            var flag = false;
                            if (typeof (data) === "string")
                                flag = data.includes("ORA");
                            if (!flag) {
                                bars.ui.notify("Клієнта збережено", "ID = " + data, "success");

                                var modelStr = JSON.stringify(megaModel(okpo));
                                var depomodel = localStorage.getItem("depoquestionnaire");
                                var resultModel = modelStr;
                                if (depomodel != null) {
                                    resultModel = resultModel + depomodel;
                                    $("#strmodel").val(resultModel.replace("}{", ","));
                                    $("#fname").submit();
                                }
                                else {
                                    if (burial === "true")
                                        resultModel = resultModel.replace("}", ",\"flag\":\"burial\"}");

                                    if (funeral === "true")
                                        resultModel = resultModel.replace("}", ",\"flag\":\"funeral\"}");

                                    $("#strmodel").val(resultModel);
                                    $("#fname").submit();
                                }
                
                                rnk.setRnk(data);
                                if (actid !== null) {
                                    actualDepo(actid);
                                    checkRnk(rnk.getRnk(), true);
                                }
                                else if (deposiptId !== null) {
                                    clientRecip(data, deposiptId);
                                    checkRnk(rnk.getRnk(), true);
                                } else {
                                    checkRnk(rnk.getRnk(), true);
                                }
                            } else {
                                var startPos = data.indexOf(':') + 1;
                                var endPos = data.indexOf('ORA', 2);
                                var textRes = data.substring(startPos, endPos);
                                bars.ui.error({ title: "Помилка!", text: textRes });
                            }
                        }
                    });
                }
            });
        } else {
            bars.ui.notify("Увага!", "Не виконано усі умови валідації", "error");
        }
    });

    $("#docTypeDropList").change(function (e) {
        if (this.value === "7") {
            help.requiredDocForId();

            $(".passp-id").show();
            $(".non-passp-id").hide();
        }
        else if (this.value !== "7") {
            help.requiredDocForNonId();

            $(".passp-id").hide();
            $(".non-passp-id").show();
        }

        if (this.value === "1") {

            $("#checkForSerial").show();
            $("#emptyblock").hide();
        } else {
            $("#checkForSerial").hide();
            $("#emptyblock").show();
        }
    });

    //Get cliect accounts
    var createModelForAccounts = function () {
        return {
            doctype: $("#docTypeDropList").val(),
            mfo: $("#mfo").val(),
            icod: $("#inn").val(),
            ser: $("#serial").val(),
            numdoc: $("#docTypeDropList").val() === "7" ? $("#docid").val() : $("#number").val(),
            eddr_id: $("#eddrid").val()
        }
    }

    var getAccounts = function () {
        $.ajax({
            type: "POST",
            url: bars.config.urlContent("/api/crkr/saveclient/getclientaccount"),
            data: createModelForAccounts(),
            success: function (data) {
                bars.ui.loader("body", false);
                var json = JSON.parse(data);
                if (json.length !== 0) {
                    $("#print").prop("disabled", false);
                    buttonsShow([9]);
                    $("#nls").kendoDropDownList({
                        optionLabel: " ",
                        dataTextField: "NMS",
                        dataValueField: "NLS",
                        dataSource: json
                    });
                } else {

                    bars.ui.alert({ title: "Увага!", text: "У данного користувача не знайдено рахунків в АБС БАРС.\nДля реєстрації клієнта в ЦРКР потрібно створити рахунок в АБС БАРС." });
                }
            }
        });
    }

    $("#btnEdit").click(function () {
        help.switchListAndPicker(true);
        help.switchInput(false);
        help.checkBox(false);
        $("input").removeClass('disable');
        buttonsShow([9]);
        if (!$("#edrpoucheck").is(":checked")) {
            getAccounts();
        }
    });

    $("#mfo, #serial, #number, #inn, #eddrid, #docid").change(function () {
        var inn = $("#inn").val();
        var isnum = true;
        var numberPass = $("#number").val();
        var mfo = $("#mfo").val();
        if (inn !== "")
            isnum = /^\d+$/.test(inn);


        if ($("#docTypeDropList").val() === "7") {
            if (mfo !== "" && isnum && $("#docid").val() !== "" && $("#eddrid").val() !== "") {
                bars.ui.loader("body", true);
                getAccounts();
            }
        } else {
            if (mfo !== "" && isnum && $("#serial").val() !== "" && $("#number").val() !== "") {
                bars.ui.loader("body", true);
                getAccounts();
            }
        }
    });

    $("#history").on("click", function (e) {
        e.preventDefault();
        window.location = bars.config.urlContent("/crkr_forms/crkr_customer_history.aspx?rnk=" + rnk.getRnk());
    });

    $("#backToDepo").click(function () {
        window.history.back();
    });

    var createModelForDeactual = function (btnId) {
        var selectedIndex = tabstrip.select().index();
        var gridName, opercode;
        if (selectedIndex === 0) {
            gridName = "#clientProfileGrid";
            if (btnId === "canceled")
                opercode = "REQ_DEACT_DEP";
            else
                opercode = "ACT_DEP";
        }
        //змінити в залежності від нажатої кнопки
        if (selectedIndex === 1) {
            gridName = "#depoOnFuneral";
            if (btnId === "canceled")
                opercode = "REQ_DEACT_BUR";
            else
                opercode = "ACT_BUR";
        }

        var idsToSend = [];
        var grid = $(gridName).data("kendoGrid");
        var ds = grid.dataSource.view();

        for (var i = 0; i < ds.length; i++) {
            var row = grid.table.find("tr[data-uid='" + ds[i].uid + "']");
            var checkbox = $(row).find(".checkbox");

            if (checkbox.is(":checked")) {
                idsToSend.push(ds[i].ID);
            }
        }
        return { rnk: parseInt(rnk.getRnk()), id: idsToSend, opercode: opercode, reason: $("#reason").val() };
    }

    $("#unLinkDeposit").click(function (e) {
        var model = createModelForDeactual(this.id);
        if (model.id.length === 0) {
            bars.ui.alert({ title: "Увага!", text: "Відмітьте вклад(и) для деактуалізації" });
        } else {
            e.preventDefault();
            bars.ui.confirm({ text: "Здійснити відміну актуалізації вкладу?" }, function () {
                $.ajax({
                    url: bars.config.urlContent("/api/crkr/depo/undep"),
                    type: "POST",
                    contentType: "application/json",
                    data: JSON.stringify(model),
                    success: function (result) {
                        var flag = result.includes("ORA");
                        if (flag) {
                            help.showError(result);
                        } else {
                            help.refreshGridAfterDeactual();
                        }
                    },
                    error: function () {
                        bars.ui.error({ text: "Сталася помилка" });
                    }
                });
            });
        }
    });

    //-----------------вікно для вказання причини для запиту на деактуалізацію--------------- ---------------
    $("#canceled").click(function (e) {
        var model = createModelForDeactual(this.id);
        if (model.id.length === 0) {
            bars.ui.alert({ title: "Увага!", text: "Відмітьте вклад(и) для запиту на відміну актуалізації" });
        } else {
            e.preventDefault();
            bars.ui.confirm({ text: "Здійснити запит на відміну актуалізації вкладу?" }, function () {
                $.ajax({
                    url: bars.config.urlContent("/api/crkr/depo/requndep"),
                    type: "POST",
                    contentType: "application/json",
                    data: JSON.stringify(model),
                    success: function (result) {
                        var flag = result.includes("ORA");
                        if (flag) {
                            help.showError(result);
                        } else {
                            bars.ui.notify("Увага!", "Запит відправлено!", "success");
                            $("#reasonWindow").data("kendoWindow").close();
                            help.refreshGridAfterDeactual();
                        }
                    }
                });
            });
        }

    });

    $(function () {
        function onClose() {
            $("#reasonWindow").fadeIn();
        }

        $("#reasonWindow").kendoWindow({
            width: "500px",
            title: "Вкажіть причину відміни для виділених операцій",
            resizable: false,
            visible: false,
            modal: true,
            actions: [
                "Close"
            ],
            close: onClose
        });
    });

    $("#reqUnLink").click(function () {
        $("#reasonWindow").data("kendoWindow").center().open();
    });
    //-----------------------------------------------------------------------------------------------------


    //---------------------Актуалізація вкладу-----------------------------------------

    var getDepos = function () {
        bars.ui.loader("#actual", true);
        $.ajax({
            url: bars.config.urlContent("/api/crkr/depo/GetDepoForActual"),
            type: "GET",
            dataType: "JSON",
            data: { rnk: rnk.getRnk() },
            success: function (model) {
                bars.ui.loader("#actual", false);
                $("#deposit").data("kendoGrid").dataSource.data(model);
            },
            error: function () {
                bars.ui.notify('Увага!', 'Користувач(і) не знайдено. Змініть фільтр.', 'error');
            }
        });
    };
    $("#linkDeposit").click(function () {
        $("#actual").data("kendoWindow").center().open();
        getDepos();
    });

    $("#deposit").on("dblclick", "tbody > tr", actualDepo);

    $("#alldepo").click(function () {
        window.location = "/barsroot/crkr/clientprofile/crkrbag?rnk=" + rnk.getRnk();
    });
    //----------------------------------------------------------------------------------

    //bocouse ie8
    if (!String.prototype.includes) {
        // ReSharper disable once NativeTypePrototypeExtending
        String.prototype.includes = function () {
            'use strict';
            return String.prototype.indexOf.apply(this, arguments) !== -1;
        };
    }

    $("#addMoney").click(function () {
        var lastname = $('#lastname').val();
        var firstname = $('#firstname').val();
        var middlename = $('#middlename').val();
        var fullName = lastname + " " + firstname + " " + middlename;
        localStorage.setItem("fullname", fullName);
        window.location = bars.config.urlContent("/Crkr/DepositProfile/ReplenishmentDepo?rnk=" + rnk.getRnk() + "&herid=" + herid);
    });
});