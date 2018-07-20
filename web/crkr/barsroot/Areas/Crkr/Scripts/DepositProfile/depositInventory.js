function changeRadio() {
    if ($('[name="heir"]:checked').val() == 0) {
        $("#heirPerson").attr('checked', true);
        $("#court").hide();
        $("#namePerson").hide();
        $("#edrpo").hide();
        $("#serial").show();
    }
    else {
        $("#heirCompany").attr('checked', true);
        $("#court").show();
        $("#namePerson").show();
        $("#edrpo").show();
        $("#serial").hide();     
    }
}

var dropdown = dropdown || {};
var CrvHistory = CrvHistory || {};
var DepoInfo = DepoInfo || {};
$(document).ready(function () {
    dropdown.dropDownLists();
    dropdown.picker();
    var id = bars.extension.getParamFromUrl("depoId", window.location.toString());
    var flag = bars.extension.getParamFromUrl("flag", window.location.toString());
    var burial = bars.extension.getParamFromUrl('burial', window.location.toString());
    var funeral = bars.extension.getParamFromUrl('funeral', window.location.toString());
    var control = bars.extension.getParamFromUrl('control', window.location.toString());
    var back = bars.extension.getParamFromUrl('back', window.location.toString());
    if (!isNaN(id)) {
        $("#rnk").val(id);
    }
    var depoDbCode = null;
    // ReSharper disable once NativeTypePrototypeExtending
    String.prototype.splice = function (idx, rem, str) {
        return this.slice(0, idx) + str + this.slice(idx + Math.abs(rem));
    };

    //store and save rnk_bur in variable
    var rnkBur = (function () {
        var state; //private variable, save current rnk
        var pub = {}; //public object for access prop
        pub.setRnk = function (newRnkBur) {
            if (newRnkBur === "0" || newRnkBur === "" || newRnkBur === undefined || newRnkBur === 0) {
                state = undefined;
            } else {
                state = newRnkBur;
            }
        };
        pub.getRnk = function () {
            return state;
        }
        return pub;
    }());
    
    //store and save rnk_bur in variable
    var rnkDepo = (function () {
        var state; //private variable, save current rnk
        var pub = {}; //public object for access prop
        pub.setRnk = function (newRnkDepo) {
            if (newRnkDepo === "0" || newRnkDepo === "" || newRnkDepo === undefined || newRnkDepo === 0) {
                state = undefined;
            } else {
                state = newRnkDepo;
            }
        };
        pub.getRnk = function () {
            return state;
        }
        return pub;
    }());

    var showError = function (data) {
        var startPos = data.indexOf(':') + 1;
        var endPos = data.indexOf('ORA', 2);
        var textRes = data.substring(startPos, endPos);
        bars.ui.notify("Сталася помилка!", textRes, "error");
    }

    function onSelect(e) {
        var index = $(e.item).index();
        if (index === 0) {//історія операцій
            DepoInfo.initDepoGrids(id);
        } else if (index === 1) {//довірені особи
            DepoInfo.wills(id);
        } else if (index === 2) {//заповідальне розпорядження
            DepoInfo.powerOfAttorney(id);            
        } else if (index === 3) {//історія клієнтів црв
            CrvHistory.clientCrvHistory(depoDbCode);
        } else if (index === 4) {//історія вкладів црв
            CrvHistory.depoCrvHistory(depoDbCode);
        } else if (index === 5) {//історія платежів црв
            CrvHistory.payCrvHistory(depoDbCode);
        }
    }

    var getNonSightPasp = function (compenId) {
        $.ajax({
            url: bars.config.urlContent("/api/crkr/depo/nonsightpasp"),
            type: "GET",
            data: { id: compenId },
            dataType: "json",
            success: function (result) {
                $("#docTypeDropList").data('kendoDropDownList').value(parseInt(result[0].DOCTYPE)); //Тип документа
                $("#docserial").val(result[0].DOCSERIAL);
                $("#docnumber").val(result[0].DOCNUMBER); 
                $("#docdate").val(kendo.toString(kendo.parseDate(result[0].DOCDATE), 'dd.MM.yyyy')); //Коли видано
                $("#docorg").val(result[0].DOCORG); //Ким видано
                $("#docNameCompany").val(result[0].NAME_PERSON); //Назва юр.особи
                $("#docCodCompany").val(result[0].EDRPO_PERSON); //ЕДРПОУ
              
                if (result[0].TYPE_PERSON == 0)
                    $("#heirPerson").attr('checked', true);
                else
                    $("#heirCompany").attr('checked', true);

                changeRadio();

                $("#newDocTypeDropList").text(result[0].NEW_DOCTYPE === null ? '' : result[0].NEW_DOCTYPE);
                $("#newdocserial").text(result[0].NEW_DOCSERIAL === null ? '' : result[0].NEW_DOCSERIAL);
                $("#newdocnumber").text(result[0].NEW_DOCNUMBER === null ? '' : result[0].NEW_DOCNUMBER);
                result[0].NEW_DOCDATE === null ? '' : $("#newdocdate").text(kendo.toString(kendo.parseDate(result[0].NEW_DOCDATE), 'dd.MM.yyyy'));
                result[0].NEW_DOCORG === null ? '' : $("#newdocorg").text(result[0].NEW_DOCORG);
            },
            error: function (result) {
                bars.ui.error("Сталася помилка " + result.text);
            }
        });
    }
      

    var tabstrip = $("#tabstrip").kendoTabStrip({ select: onSelect }).data("kendoTabStrip");
    tabstrip.select(0);

    function onChange(e) {
        if ($(e.item).find("> .k-link").text() === "Документ")
            getNonSightPasp(id);
    }

    var tabstripMain = $("#tabstripMain").kendoTabStrip({select: onChange}).data("kendoTabStrip");
    tabstripMain.select(0);
    $("#ob22, #depoOb22").kendoDropDownList({
        optionLabel: " ",
        dataTextField: "TEXT",
        dataValueField: "OB22",
        dataSource: {
            transport: {
                read: {
                    dataType: "json",
                    url: bars.config.urlContent("/api/crkr/dropdown/ob22")
                }
            }
        }
    });

    $("#mfo").kendoDropDownList({
        optionLabel: " ",
        dataTextField: "NAME",
        dataValueField: "MFO",
        dataSource: {
            transport: {
                read: {
                    dataType: "json",
                    url: bars.config.urlContent("/api/crkr/dropdown/mfo")
                }
            }
        }
    });

    $("#toolbarDepo").kendoToolBar({
        items: [
            {
                template: "<button type='button' class='k-button right-pos' id='clientProfile'><span class='k-sprite pf-icon pf-16 pf-user' style='margin-bottom: 0px;margin-top: 0px'></span> Анкета Клієнта</button>"//0
            }, {
                template: "<button type='button' class='k-button right-pos' id='blockHerBtn'><span class='k-sprite pf-icon pf-16 pf-piece' style='margin-bottom: 0px;margin-top: 0px'></span> Спадщина</button>"//1
            }, {
                type: "separator"
            }, {
                template: "<label type='text' class='control-label'>Отримувач на поховання:</label>"//2
            }, {
                template: "<input type='text' class='k-textbox' id='recipName' readonly/>"//3
            }, {
                template: "<button type='button' class='k-button' id='recipPic' title='Анкета одержувача'><span id='spanBtn' class='k-sprite pf-icon pf-16'></span></button>"//4
            }, {
                template: "<button type='button' class='k-button' id='blockDepoBtn' title='Блокувати'><span id='spanBtn' class='k-sprite pf-icon pf-16 pf-delete'></span></button>"//5
            }, {
                template: "<button type='button' class='k-button' id='unblockDepoBtn' title='Розблокувати'><span id='spanBtnUnblock' class='k-sprite pf-icon pf-16 pf-reload_rotate'></span></button>"//6
            }
        ]
    });

    //допоміжна функція
    var contains = function (needle) {
        var findNaN = needle !== needle;
        var indexOf;

        if (!findNaN && typeof Array.prototype.indexOf === "function") {
            indexOf = Array.prototype.indexOf;
        } else {
            indexOf = function (needle) {
                var i = -1, index = -1;
                for (i = 0; i < this.length; i++) {
                    var item = this[i];

                    if ((findNaN && item !== item) || item === needle) {
                        index = i;
                        break;
                    }
                }
                return index;
            }
        }
        return indexOf.call(this, needle) > -1;
    }

    var buttonsShow = function (buttons) {
        if (contains.call(buttons, 0)) {
            $("#clientProfile").show();
        }
        if (contains.call(buttons, 1)) {
            $("#blockHerBtn").show();
        }
        if (contains.call(buttons, 2)) {
            $("#toolbarDepo > div >  label").show();
        }
        if (contains.call(buttons, 3)) {
            $("#recipName").show();
        }
        if (contains.call(buttons, 4)) {
            $("#recipPic").show();
        }
        if (contains.call(buttons, 5)) {
            $("#blockDepoBtn").show();
        }
        if (contains.call(buttons, 6)) {
            $("#unblockDepoBtn").show();
        }
    }

    var buttonsHide = function (buttons) {
        if (contains.call(buttons, 0)) {
            $("#clientProfile").hide();
        }
        if (contains.call(buttons, 1)) {
            $("#blockHerBtn").hide();
        }
        if (contains.call(buttons, 2)) {
            $("#toolbarDepo > div >  label").hide();
        }
        if (contains.call(buttons, 3)) {
            $("#recipName").hide();
        }
        if (contains.call(buttons, 4)) {
            $("#recipPic").hide();
        }
        if (contains.call(buttons, 5)) {
            $("#blockDepoBtn").hide();
        }
        if (contains.call(buttons, 6)) {
            $("#unblockDepoBtn").hide();
        }
    }

    var documentPart = function () {
        if (control === "1") {
            $("#toolbarDepo").hide();
            buttonsHide([5, 6]);
        }
        if ((burial === null && funeral === null) || (burial === "false" && funeral === "false")) {
            buttonsHide([1, 2, 3, 4, 5, 6]);
        }
        if (burial === "true") {
            buttonsHide([0, 2, 3, 4, 5, 6]);
        }
        if (funeral === "true") {
            buttonsHide([1, 2, 3, 4, 5, 6]);

        } else if (back === "true") {
            buttonsShow([5, 6]);
        }
    };

    var documentTab = function (bool) {
        $('#docTypeDropList').data("kendoDropDownList").enable(!bool);
        $("#docserial").prop('readonly', bool);
        $("#docnumber").prop('readonly', bool);
        $("#docdate").prop('readonly', bool);
        $("#docorg").prop('readonly', bool);
        $("#saveDoc").prop('readonly', bool);
        if (bool) {
            $("#saveDoc").hide();
        } else {
            $("#saveDoc").show();
        }
    };

    var editDateValue = function () {
        $.each($("input"), function (key, value) {
            if (value.value.indexOf("0:00:00")) {
                this.value = value.value.replace("0:00:00", "");
            }
        });
    };

    //read deposit info
    var getDepo = function (compenId) {
        $.ajax({
            url: bars.config.urlContent("/api/crkr/depo/getdepo"),
            type: "GET",
            data: { id: compenId },
            dataType: "json",
            success: function (result) {
                bars.ui.loader("#tabstripMain", true);
                rnkDepo.setRnk(result.RNK);
                if (rnkDepo.getRnk() === undefined && (burial || funeral)) {
                    buttonsHide([0]);
                }
                else {
                    buttonsShow([0]);
                }
                $('#FIO').val(result.FIO);
                $('#KKNAME').val(result.KKNAME);
                $('#NSC').val(result.NSC);
                var ost = result.OST;
                if (ost !== "0") {
                    ost = ost.splice(ost.length - 2, 0, ".") + " " + result.KV_SHORT;
                    $('#ost').val(ost);
                } else {
                    $('#ost').val(ost);
                }
                $('#dato').val(result.DATO);
                $('#registrydate').val(result.REGISTRYDATE);
                $('#datl').val(result.DATL);
                $('#percent').val(result.PERCENT);
                $('#branch').val(result.BRANCH);
                $("#reasonDepo").val(result.REASON_CHANGE_STATUS);
                $("#docTypeDropList").data('kendoDropDownList').value(parseInt(result.DOCTYPE));
                if (result.STATE_ID === 91 || result.RNK_BUR > 0) {
                    buttonsShow([2, 3, 4]);

                    $("#recipName").val(result.FIO_RECEIVER);
                    rnkBur.setRnk(result.RNK_BUR);

                }
                if (result.STATE_ID === 99) {
                    $("#unblockDepoBtn").removeAttr("disabled");
                    $("#blockDepoBtn").attr("disabled", "disabled");
                } else {
                    $("#blockDepoBtn").removeAttr("disabled");
                    $("#unblockDepoBtn").attr("disabled", "disabled");
                }


                $("#docserial").val(result.DOCSERIAL);
                $("#docnumber").val(result.DOCNUMBER);
                getDBcode($('#docTypeDropList').val(), $('#docserial').val(), $('#docnumber').val());
              
                var docdate = kendo.toString(kendo.parseDate(result.DOCDATE, 'dd.MM.yyyy'), 'dd.MM.yyyy')
                if (docdate === "01.01.0001")
                    $("#docdate").val("");
                else
                    $("#docdate").val(kendo.toString(kendo.parseDate(result.DOCDATE, 'dd.MM.yyyy'), 'dd.MM.yyyy'));



                $("#docorg").val(result.DOCORG);
                if (result.RNK_BUR > 0 && burial !== "true") {
                    $("#spanBtn").addClass("pf-user");
                    $("#recipName").val(result.FIO_RECEIVER);
                    rnkBur.setRnk(result.RNK_BUR);
                } else {
                    $("#spanBtn").addClass("pf-add");
                }
                $("#depobdate").val(result.CLIENTBDATE);

                editDateValue();
                $('#ob22').data('kendoDropDownList').value(result.OB22);
                $('#mfo').data('kendoDropDownList').value(result.BRANCH.substring(1, 7));
                bars.ui.loader("#tabstripMain", false);
            },
            error: function (result) {
                bars.ui.error("Сталася помилка " + result.text);
            }
        });
    };

        $("#eddr").hide();
    $("#passplist").change(function () {
        if ($("#passplist").val() === "7") {
            $("#eddr").show();
            $("#serial").hide();
            $("#ser").val("");
        }
        else {
            $("#eddr").hide();
            $("#serial").show();
            $("#eddr_id").val("");
        }
    });

    //---------------------додавання одержувача-----------------------------------------
    var actualusersGrid = function () {
        $("#actualusers").kendoGrid({
            autobind: false,
            selectable: "row",
            sortable: true,
            scrollable: true,
            filterable: true,
            pageable: {
                refresh: true,
                buttonCount: 5
            },
            columns: [
                { field: "ID", hidden: true },
                 {
                     field: "RNK",
                     title: "РНК",
                     width: "7em",
                     filterable: {
                         cell: {
                             operator: "contains"
                         }
                     }
                 },
                {
                    field: "NAME",
                    title: "ФІО",
                    width: "7em",
                    filterable: {
                        cell: {
                            operator: "contains"
                        }
                    }
                },
                {
                    field: "INN",
                    title: "ІНН",
                    width: "10em",
                    filterable: {
                        cell: {
                            operator: "contains"
                        }
                    }
                },
                {
                    field: "SEX",
                    title: "Стать",
                    width: "10em",
                    filterable: {
                        cell: {
                            operator: "contains"
                        }
                    }
                },
                {
                    field: "BIRTH_DATE",
                    title: "Дата народження",
                    template: "<div>#= kendo.toString(kendo.parseDate(BIRTH_DATE),'dd.MM.yyyy') == null ? '' : kendo.toString(kendo.parseDate(BIRTH_DATE),'dd.MM.yyyy')#</div>",
                    width: "7em",
                    filterable: {
                        cell: {
                            operator: "contains"
                        }
                    }
                },
                {
                    field: "SER",
                    title: "Серія",
                    width: "7em",
                    filterable: {
                        cell: {
                            operator: "contains"
                        }
                    }
                },
                {
                    field: "NUMDOC",
                    title: "Номер",
                    width: "7em",
                    filterable: {
                        cell: {
                            operator: "contains"
                        }
                    }
                },
                {
                    field: "BRANCH",
                    title: "Відділення",
                    width: "7em",
                    filterable: {
                        cell: {
                            operator: "contains"
                        }
                    }
                }
            ],
            dataSource: {
                pageSize: 5,
                schema: {
                    data: "Data",
                    total: "Total",
                    model: {
                        fields: {
                            RNK: { type: "string" },
                            NAME: { type: "string" },
                            INN: { type: "string" },
                            SEX: { type: "string" },
                            BIRTH_DATE: { type: "string" },
                            SER: { type: "string" },
                            NUMDOC: { type: "string" },
                            BRANCH: { type: "string" }
                        }
                    }
                }
            }
        });
    }

    $(function () {
        var reason = $("#recipWindow");

        function onClose() {
            reason.fadeIn();
        }

        reason.kendoWindow({
            width: "900px",
            title: "Оберіть, або зареєструйте одержувача",
            resizable: false,
            visible: false,
            modal: true,
            actions: [
                "Close"
            ],
            close: onClose
        });
    });

    $("#searchUser").click(function (event) {
        event.preventDefault();
        var values = {};
        $.each($("#usersForm").serializeArray(), function (i, field) {
            values[field.name] = field.value;
        });
        var point = false;
        for (var prop in values) {
            if (values[prop] !== "")
                point = true;
        }
        if (point === true && ($("#name").val() !== "" || $("#inn").val() !== "" || $("#ser").val() !== "" || $("#numdoc").val() !== "")) {
            $.ajax({
                url: bars.config.urlContent("/api/crkr/actual/getusers"),
                type: "POST",
                dataType: "JSON",
                data: values,
                success: function (model) {
                    if (model.hasOwnProperty("Total") && model.Total !== 0) {
                        actualusersGrid();
                        $("#actualusers").show();
                        $("#actualusers").data("kendoGrid").dataSource.data(model.Data);
                    } else {
                        $("#actualusers").hide();
                        bars.ui.notify('Увага!', 'Користувач(і) не знайдено. Змініть фільтр.', 'error');
                    }
                },
                error: function () {
                    bars.ui.notify('Увага!', 'Користувач(і) не знайдено. Змініть фільтр.', 'error');
                }
            });
        } else {
            bars.ui.notify('Увага!', 'Введіть хоча б одне значення!', 'error');
        }
    });

    var addUserToRecipe = function () {
        var grid = $('#actualusers').data('kendoGrid');
        var row = grid.dataItem(grid.select());
        var model = {
            userid: row.RNK,
            compenid: id,
            opercode: "ACT_BUR"
        }
        $.ajax({
            url: bars.config.urlContent("/api/crkr/depo/actualcompen"),
            type: "POST",
            data: model,
            success: function (result) {
                var flag = result.includes("ORA");
                if (flag) {
                    showError(result);
                } else {
                    getDepo(id);
                    $("#recipWindow").data("kendoWindow").close();
                    $('#clientHistoryGrid').data('kendoGrid').dataSource.read();
                    $('#clientHistoryGrid').data('kendoGrid').refresh();
                    bars.ui.notify('Увага!', 'Одержувача додано', 'success');
                }
            }
        });
    };
    $("#actualusers").on("dblclick", "tbody > tr", addUserToRecipe);

    $("#newUser").click(function () {
        //TODO рефакторинг
        var model = {
            fio: $("#FIO").val(),
            depobdate: $("#depobdate").val(),
            doctype: $("#docTypeDropList").val(),
            docser: $("#docserial").val(),
            docnumb: $("#docnumber").val(),
            docdate: $("#docdate").val(),
            organ: $("#docorg").val()
        };
        model.flag = "funeral";
        localStorage.setItem("depoquestionnaire", JSON.stringify(model));
        window.location = "/barsroot/Crkr/ClientProfile/Index?rnk=" + "&depoId=" + id + "&funeral=true";
    });
    //----------------------------------------------------------------------------------

    $("#recipPic").click(function () {
        if ($("#spanBtn").hasClass("pf-user")) {
            window.location = "/barsroot/Crkr/ClientProfile/Index?rnk=" + rnkBur.getRnk() + "&depoId=" + id + "&funeral=true";
        } else if ($("#spanBtn").hasClass("pf-add")) {
            $("#recipWindow").data("kendoWindow").center().open();

        }
    });

    var getDBcode = function (doctype, ser, numdoc) {
        $.ajax({
            url: bars.config.urlContent("/api/crkr/getinfo/getdbcode"),
            type: "GET",
            data: { doctype: doctype, ser: ser, numdoc: numdoc },
            dataType: "json",
            success: function (dbcode) {
                depoDbCode = dbcode;
            },
            error: function (result) {
                bars.ui.error("Сталася помилка " + result.text);
            }
        });
    };

    var switchInput = function (bool) {
        $("#FIO").prop('readonly', bool);
        $("#KKNAME").prop('readonly', bool);
        $("#NSC").prop('readonly', bool);
        $("#ost").prop('readonly', bool);
        $("#KV_SHORT").prop('readonly', bool);
        $("#status").prop('readonly', bool);
        $("#dato").prop('readonly', bool);
        $("#registrydate").prop('readonly', bool);
        $("#datl").prop('readonly', bool);
        $("#percent").prop('readonly', bool);
        $("#branch").prop('readonly', bool);
        $("#mfo").prop('readonly', bool);
        $("#reasonDepo").prop('readonly', bool);
        $("#datval").prop('readonly', bool);
        $("#datpay").prop('readonly', bool);
        $("#attorney").prop('readonly', bool);

        documentTab(bool);
    }

    function checkId(compenId) {
        if (flag === "1") {
            switchInput(true);
            getDepo(compenId);
            $('#ob22').data("kendoDropDownList").enable(false);
            $('#mfo').data("kendoDropDownList").enable(false);
        } else if (flag === "2") {
            switchInput(true);
            $("input:not(#ob22, #KKNAME)").addClass('disable');
            $("#KKNAME").prop('readonly', false);
            $("#ob22").prop('readonly', false);
            $("#tabstrip").addClass("hiden-block");
        }
        if (funeral || burial)
            documentTab(false);
        documentPart();

    };

    checkId(id);

    $("#clientProfile").click(function () {

        var rnk = rnkDepo.getRnk();
        var model = {
            fio: $("#FIO").val(),
            doctype: $("#docTypeDropList").val(),
            docser: $("#docserial").val(),
            docnumb: $("#docnumber").val(),
            docdate: $("#docdate").val(),
            organ: $("#docorg").val()


        };
        if (rnk !== undefined) {
            if (bars.extension.getParamFromUrl('burial', window.location.toString()) === "true") {
                window.location = bars.config.urlContent("/crkr/clientprofile/index?rnk=" + rnk + "&burial=true");
            }
            else if (bars.extension.getParamFromUrl('funeral', window.location.toString()) === "true") {
                window.location = bars.config.urlContent("/crkr/clientprofile/index?rnk=" + rnk + "&funeral=true");
            }
            else {
                window.location = bars.config.urlContent("/crkr/clientprofile/index?rnk=" + rnk + "&button=" + (back === "true" ? "true" : "false"));
            }
        } else {
            localStorage.setItem("depomodel", JSON.stringify(model));
            window.location = bars.config.urlContent("/crkr/clientprofile/index?rnk=" + "&actid=" + id);
        }
    });

    $("#blockHerBtn").click(function () {
        var model = {
            CompenId: id,
            StatusId: 92,
            Reason: 'Оформлення спадщини'
        }
        bars.ui.confirm({ text: "Виконати блокування вкладів та продовжити оформлення спадщини?" }, function () {
            $.ajax({
                type: "POST",
                url: bars.config.urlContent("/api/crkr/depo/blockdepo"),
                data: model,
                success: function (data) {
                    var flag = data.includes("ORA");
                    if (!flag) {
                        var burialModel = {
                            fio: $("#FIO").val(),
                            depobdate: $("#depobdate").val(),
                            doctype: $("#docTypeDropList").val(),
                            docser: $("#docserial").val(),
                            docnumb: $("#docnumber").val(),
                            docdate: $("#docdate").val(),
                            organ: $("#docorg").val()
                        };
                        burialModel.flag = "burial";
                        localStorage.setItem("depoquestionnaire", JSON.stringify(burialModel));
                        window.location = bars.config.urlContent("/crkr/clientprofile/clientbag?burial=true&herid=" + id);
                    } else {
                        showError(data);
                    }
                }
            });
        });
    });

    var validator = $("#document").kendoValidator({
        rules: {
            custom: function (input) {
                var doctype = $("#docTypeDropList").data("kendoDropDownList").value();

                if (input.is("[name=docserial]") && $('[name="heir"]:checked').val() == 0) {
                    if (doctype === "1") //паспорт гр. України
                        return /^[А-ЯA-Z]{2}$/.test(input.val());
                    else if (doctype === "3") //свідоцтво про народження
                        return /^(\d{1}[VX]{1,4}-[А-ЯЇЄҐ]{2})$/.test(input.val());
                    else if (doctype === "11") //закордонний паспорт
                        return /^[A-Z]{2}$/.test(input.val());
                    else if (doctype === "15") //тимчасове посвідчення особи
                        return /^[А-ЯІЇЄҐ]{2,7}$/.test(input.val());
                    else if (doctype === "98") //свідоцтво про смерть
                        return /^(\d{1}[VX]{0,4}-[А-ЯЇЄҐ]{2})$/.test(input.val());
                    else if (doctype === "95") //свідоцтво про смерть (закордонний)
                        return /^([0-9A-ZА-ЯІЇЄҐ-]{1,10})$/.test(input.val());
                    else if (doctype !== "13") //13 - це паспорт нерезидента, а щось інше - це свідоцтво про спадщину та заповіт
                        return /^([0-9A-ZА-ЯІЇЄҐ-]{2,6})$/.test(input.val());
                }
                if (input.is("[name=docnumber]") && $('[name="heir"]:checked').val() == 0) {
                    if (doctype === "15")//тимчасове посвідчення особи
                        return /^\d{8}$/.test(input.val());
                    if (doctype === "95")//тимчасове посвідчення особи
                        return /^([0-9A-ZА-ЯІЇЄҐ-]{1,7})$/.test(input.val());
                    else if (doctype !== "13") //паспорт нерезидента перевіряється у custom2
                        return /^\d{6}$/.test(input.val());
                }
                if (input.is("[name=docdate]")) {
                    var date = kendo.parseDate(input.val());
                    if (date > new Date())
                        return false;
                    else
                        return /^\d{1,2}.\d{1,2}.\d{4}$/.test(input.val());
                }

                if ($('[name="heir"]:checked').val() == 1) {
                    $('#docCodCompany').attr('required', 'true');
                    $('#docNameCompany').attr('required', 'true');

                    if (input.is("[name=edrpo_person]"))
                        return /^\d{8}\d?\d?$/.test(input.val());
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

    //save changes in deposit document
    $("#saveDoc").click(function (e) {
        e.preventDefault();
        if (validator.validate()) {
            var values = {};
            $.each($("#document").serializeArray(), function (i, field) {
                values[field.name] = field.value;
            });

            values["id"] = id;

            values["type_person"] = $('[name="heir"]:checked').val();

            $.ajax({
                type: "POST",
                url: bars.config.urlContent("/api/crkr/depo/changedoc"),
                data: values,
                success: function (data) {
                    var flag = data.includes("ORA");
                    if (!flag) {
                        bars.ui.notify("Документ змінено!", "Зміни збережено", "success");
                    } else {
                        showError(data);
                    }
                    getDepo(id);
                    getNonSightPasp(id);
                    $('#clientHistoryGrid').data('kendoGrid').dataSource.read();
                    $('#clientHistoryGrid').data('kendoGrid').refresh();
                }
            });
        }
    });


    //------------------------Блокування вкладу через бек офіс----------------------------------------
    $(function () {
        var reason = $("#askReasonWindow");

        function onClose() {
            reason.fadeIn();
        }

        reason.kendoWindow({
            width: "500px",
            title: "Вкажіть причину блокування вкладу",
            resizable: false,
            visible: false,
            modal: true,
            actions: [
                "Close"
            ],
            close: onClose
        });
    });

    $("#blockDepo").click(function () {
        var model = {
            CompenId: id,
            StatusId: 99,
            Reason: $("#reason").val()
        }
        $.ajax({
            type: "POST",
            url: bars.config.urlContent("/api/crkr/depo/blockdepo"),
            data: model,
            success: function () {
                getDepo(id);
                $("#askReasonWindow").data("kendoWindow").close();
                bars.ui.notify('Вклад блоковано', 'Операцію успішно виконано!', 'success');
            }
        });
    });

    $("#blockDepoBtn").click(function () {
        $("#askReasonWindow").data("kendoWindow").center().open();
    });

    $("#unblockDepoBtn").click(function () {
        bars.ui.confirm({
            text: 'Розблокувати вклад?'
        }, function () {
            $.ajax({
                type: "POST",
                url: bars.config.urlContent("/api/crkr/depo/unblockdepo?id=" + id),
                //data: { id: id },
                success: function (data) {
                    var flag = data.includes("ORA");
                    if (!flag) {
                        bars.ui.notify('Вклад розблоковано', 'Операцію успішно виконано!', 'success');
                    } else {
                        showError(data);
                    }

                    getDepo(id);
                }
            });
        });
    });

    //------------------------------------------------------------------------------------------------

    //bocouse ie8
    if (!String.prototype.includes) {
        // ReSharper disable once NativeTypePrototypeExtending
        String.prototype.includes = function () {
            'use strict';
            return String.prototype.indexOf.apply(this, arguments) !== -1;
        };
    } 

});