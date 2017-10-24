$(document).ready(function () {
    var switchOffInputBenef = function () {
        $("#benefFio").removeClass('disable');
        $("#benefCode").removeClass('disable');
        $("#benefCountry").removeClass('disable');
        $("#benefAddress").removeClass('disable');
        $("#benefIcod").removeClass('disable');
        $("#benefDoctype").removeClass('disable');
        $("#benefDocserial").removeClass('disable');
        $("#benefDocnumber").removeClass('disable');
        $("#benefDocorgb").removeClass('disable');
        $("#benefDocdate").removeClass('disable');
        $("#benefBirth").removeClass('disable');
        $("#benefSex").removeClass('disable');
        $("#benefPhone").removeClass('disable');
        $("#benefPercent").removeClass('disable');
        $("#eddridbenef").removeClass('disable');
    }
    
    var getActiveChildGrid = function () {
        var gridName = $("li.k-item.k-state-active").find("span.k-link").text();
        switch (gridName) {
            case 'Довіреності':
                return { state: 1, grName: "#powerOfAttorneyGrid" };
            case 'Заповіти':
                return { state: 0, grName: "#willsGrid" };
            case 'Вклади':
                return { state: 2, grName: "#clientProfileGrid" };
            case 'Заповідальне розпорядження':
                return { state: 3, grName: "#testamentaryDisposition" };//заповідальне розпорядження
        }
    };

    var validatorBenef = $("#benefProfile").kendoValidator({
        rules: {
            custom: function (input) {
                debugger;
                var doctype = $("#benefDoctype").data("kendoDropDownList").value();

                if (input.is("[name=benefFio]")) {
                    return /(([A-ZА-ЯІЇЄҐ]{1})([a-zа-яіїёєґ'_]+)-[A-ZА-ЯІЇЄҐ]{1}([a-zа-яіїёєґ'_]+$))|([A-ZА-ЯІЇЄҐ]{1})([a-zа-яіїёєґ'_]+$)/.test(input.val());
                }
                if (input.is("[name=benefIcod]")) {
                    return /^(\d{10})$/.test(input.val());
                }
                if (input.is("[name=benefPercent]")) {
                    return /^(\d{1,3})$/.test(input.val());
                }
                if (input.is("[name=eddridbenef]") && input.val() !== "") {
                        return /^([0-9]{8})-([0-9]{5})$/.test(input.val());
                }
                if (input.is("[name=benefDocdate]")) {
                    var date = kendo.parseDate(input.val());
                    if (date > new Date())
                        return false;
                    else
                        return /^\d{1,2}.\d{1,2}.\d{4}$/.test(input.val());
                }
                if (input.is("[name=benefDocserial]") && input.val() !== "") {
                    if (doctype === "1") //паспорт гр. України
                        return /^[А-ЯA-Z]{2}$/.test(input.val());
                    else if (doctype === "3") //свідоцтво про народження
                        return /^(\d{1}[VX]{1,4}-[А-ЯЇЄҐ]{2})$/.test(input.val());                   
                    else if (doctype === "13") //паспорт нерезидента
                        return /^([0-9A-ZА-ЯІЇЄҐ-]{1,7})$/.test(input.val());
                    else if (doctype === "11") //закордонний паспорт
                        return /^[A-Z]{2}$/.test(input.val());
                    else if (doctype === "15") //тимчасове посвідчення особи
                        return /^[А-ЯІЇЄҐ]{2,7}$/.test(input.val());
                    else if (doctype === "98") //свідоцтво про смерть
                        return /^(\d{1}[VX]{1,4}-[А-ЯЇЄҐ]{2})$/.test(input.val());
                    else if (doctype === "95") //свідоцтво про смерть (закордонний)
                        return /^([A-Z0-9]{2,6})$/.test(input.val());                   
                    else //свідоцтво про спадщину та заповіт
                        return /^([0-9A-ZА-ЯІЇЄҐ-]{2,6})$/.test(input.val());
                }
                if (input.is("[name=benefDocnumber]") && input.val() !== "") {
                    if (doctype === "7")//паспорт ID карта
                        return /^\d{9}$/.test(input.val());
                    else if (doctype === "13")//паспорт нерезидента
                        return /^\d{8}$/.test(input.val());
                    else if (doctype === "15")//тимчасове посвідчення особи
                        return /^\d{1,8}$/.test(input.val());
                    else
                        return /^\d{6}$/.test(input.val());
                }
                return true;
            }
        },
        messages: {
            "custom": "Некоректні дані!",
            "required": "Це поле є обов'язковим!"

        }
    }).data("kendoValidator");
    
    $("#addAttorney").click(function () {
        switchOffInputBenef(false);
        var toDateFormat = function (d) {
            return kendo.toString(kendo.parseDate(d, 'yyyy-MM-dd'), 'dd.MM.yyyy');
        };
        $("#addAttorneyWindow").data("kendoWindow").center().open();
        $("editBenef").show();

        var choseFrom = getActiveChildGrid();
        if (choseFrom.state !== 2) {
            var entityGrid = $(choseFrom.grName).data("kendoGrid");
            var selectedChildItem = entityGrid.dataItem(entityGrid.select());
            if (selectedChildItem) {
                $('#benefFio').val(selectedChildItem.FIOB);
                $('#benefAddress').val(selectedChildItem.FULLADDRESSB);
                $('#benefIcod').val(selectedChildItem.ICODB);
                $('#benefDocnumber').val(selectedChildItem.DOCNUMBERB);
                $('#benefDocorgb').val(selectedChildItem.DOCORGB);
                $('#benefDocdate').val(toDateFormat(selectedChildItem.DOCDATEB));
                $('#benefBirth').val(toDateFormat(selectedChildItem.CLIENTBDATEB));
                $('#benefPhone').val(selectedChildItem.CLIENTPHONEB);

                if (choseFrom.state === 1) {
                    $('#benefCode').data('kendoDropDownList').text("Довірена особа");
                } else if (choseFrom.state === 0) {
                    $('#benefCode').data('kendoDropDownList').text("Спадкоємець");
                } else if (choseFrom.state === 3) {
                    $('#benefCode').data('kendoDropDownList').text("Заповідальне розпорядження");
                }
                $('#benefSex').data('kendoDropDownList').text(selectedChildItem.SEX);
                $('#benefDoctype').data('kendoDropDownList').value(selectedChildItem.DOCTYPEB);

                if (selectedChildItem.DOCTYPEB === "7") {
                    $('#eddridbenef').val(selectedChildItem.EDDR_ID);
                    $("#benefDocserial").removeAttr("required");
                    $("#eddridbenef").attr("required")
                    $("#eddrBlock").show();
                    $("#serialBlock").hide();
                } else {
                    $('#benefDocserial').val(selectedChildItem.DOCSERIALB);
                    $("#benefDocserial").attr("required");
                    $("#eddridbenef").removeAttr("required")
                    $("#eddrBlock").hide();
                    $("#serialBlock").show();
                }

                $('#benefCountry').data('kendoDropDownList').text(selectedChildItem.NAME);
                $('#benefPercent').val(selectedChildItem.PERCENT * 100);
            } else {
                bars.ui.notify("Оберіть вклад або бенефіціара", "", "error");
            }
        }
       

    });

    $("#delAttorneyWills").click(function () {
        var choseFrom = getActiveChildGrid();
        var entityGrid = $(choseFrom.grName).data("kendoGrid");
        var selectedChildItem = entityGrid.dataItem(entityGrid.select());
        $.ajax({
            type: "GET",
            url: bars.config.urlContent("/api/crkr/depo/deletedepo"),
            data: { benefId: selectedChildItem.IDB, commpenId: selectedChildItem.ID },
            success: function () {
                $("#addAttorneyWindow").data("kendoWindow").close();
                var choseFrom = getActiveChildGrid().grName;
                $(choseFrom).data('kendoGrid').dataSource.read();
                $(choseFrom).data('kendoGrid').refresh();
            }
        });
    });

    var createBenefModel = function () {
        var fullName = $("#benefFio").val();
        var country = $("#benefCountry").val();
        var address = $("#benefAddress").val();
        var icod = $("#benefIcod").val();
        var doctype = $("#benefDoctype").val();
        var docSerial = $("#benefDocserial").val();
        var docNumber = $("#benefDocnumber").val();
        var eddrid = $("#eddridbenef").val();
        var docOrg = $("#benefDocorgb").val();
        var docdate = $("#benefDocdate").val();
        var birth = $("#benefBirth").val();
        var sex = $("#benefSex").val();
        var phone = $("#benefPhone").val();
        var benefCode = $("#benefCode").val();
        var benefPercent = $("#benefPercent").val();
        var item = {
            FullName: fullName,
            Country: parseInt(country),
            Address: address,
            Icod: icod,
            Doctype: parseInt(doctype),
            DocSerial: docSerial,
            DocNumber: docNumber,
            EddrId: eddrid,
            DocOrg: docOrg,
            Docdate: docdate,
            Birth: birth,
            Sex: sex,
            Phone: phone,
            Code: benefCode,
            Percent: parseInt(benefPercent) / 100,
            CompenId: null,
            Idb: null
        };
        var gridSelectfrom = getActiveChildGrid().grName;
        var entityGrid = $(gridSelectfrom).data("kendoGrid");
        var selectedChildItem = entityGrid.dataItem(entityGrid.select());
        item.Idb = parseInt(selectedChildItem.IDB);
        item.CompenId = parseInt(selectedChildItem.ID);
        return item;
    };

    $("#saveBenef").click(function () {
        if (validatorBenef.validate()) {
            var persent = parseInt($("#benefPercent").val());
            if (persent > 100) {
                bars.ui.notify("Некоректні дані", "Відсоткове значення не може бути більше 100", "error");
                return;
            }
            var model = createBenefModel();
            $.ajax({
                type: "POST",
                url: bars.config.urlContent("/api/crkr/saveclient/savebenef"),
                data: model,
                dataType: "json",
                success: function(data) {
                    var flag = false;
                    if (typeof (data) === "string")
                        flag = data.includes("ORA");
                    if (!flag) {
                        $(getActiveChildGrid().grName).data('kendoGrid').dataSource.read();
                        $(getActiveChildGrid().grName).data('kendoGrid').refresh();

                        $('#benefFio').val("");
                        $('#benefAddress').val("");
                        $('#benefIcod').val("");
                        $('#benefDocserial').val("");
                        $('#benefDocnumber').val("");
                        $('#benefDocorgb').val("");
                        $('#benefPhone').val("");
                        $("#addAttorneyWindow").data("kendoWindow").close();
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
    $("#eddrBlock").hide();

    $("#benefDoctype").change(function (e) {
        if (this.value === "7") {
            
            $("#benefDocserial").val("");
            $("#benefDocserial").removeAttr("required");
            $("#eddridbenef").attr("required")
            $("#eddrBlock").show();
            $("#serialBlock").hide();
        }
        else if (this.value !== "7") {
            $("#eddridbenef").val("");
            $("#benefDocserial").attr("required");
            $("#eddridbenef").removeAttr("required")
            $("#eddrBlock").hide();
            $("#serialBlock").show();
        }
    });

    $("#benefCode").change(function () {
        if (this.value === "N") {
            $("#strmodel").val("{empty: true}");
            $("#fname").submit();
        }
    });

    (function () {
        var addAttorney = $("#addAttorneyWindow");
        function onClose() {
            addAttorney.fadeIn();
        }
        addAttorney.kendoWindow({
            width: "500px",
            title: "Робота з бенефіціаром",
            resizable: false,
            visible: false,
            modal: true,
            actions: [
                "Close"
            ],
            close: onClose
        });
    })();
});