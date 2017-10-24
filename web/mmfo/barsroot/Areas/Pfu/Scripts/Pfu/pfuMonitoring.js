$(document).ready(function () {
     
    $('#SendReq').prop("disabled", true);
    FillKFDropDoen();
    initEnquiryGrid();
    initEpplineGrid();
    initCmEppGrid();
    $("#KFselect").change(function () {
        $("#gridEnquiry").data("kendoGrid").dataSource.read();
        $("#gridCmEpp").data('kendoGrid').dataSource.data([]);
        $("#gridEppline").data('kendoGrid').dataSource.data([]);
    });
    $('body').on('click', '#SendReq', SendRequest);

})
function FillKFDropDoen() {
    fillDropDownList("#KFselect", {
        transport: { read: { url: bars.config.urlContent("/api/pfu/monitoring/GetBranchСode") } },
        schema: { model: { fields: { KF: { type: "string" } } } }
    }, {
        dataTextField: "KF", dataValueField: "KF",
        optionLabel: "Оберіть код"
    });
    debugger;
}

PrintRestData = function (value) {
    if (value === null)
        return "";
    else
        return kendo.toString(kendo.parseDate(value, 'yyyy-MM-dd HH:mm:ss'), 'dd/MM/yyyy  HH:mm:ss')

};
PrintData = function (value) {
    if (value === null)
        return "";
    else
        return kendo.toString(kendo.parseDate(value, 'yyyy-MM-dd HH:mm:ss'), 'dd/MM/yyyy')
};

function SendRequest() {
     
    var grid = $("#gridEnquiry").data("kendoGrid");
    var selectedItem = grid._data[0].KF
    if (selectedItem) {
        $.ajax({
            type: "POST",
            contentType: "application/json",
            async: true,
            dataType: "json",
            url: bars.config.urlContent("/api/pfu/monitoring/SendRequest") + "?kf=" + selectedItem,
            complete: function () {
                $("#gridEnquiry").data("kendoGrid").dataSource.read();
            }
        });
    }
}


function initEnquiryGrid() {
    $("#gridEnquiry").kendoGrid({
        dataSource: {
            type: "webapi",
            serverPaging: true,
            serverFiltering: true,
            serverSorting: true,
            pageSize: 6,
            transport: {
                read: {
                    url: bars.config.urlContent("/api/pfu/monitoring/GetEnquiries"),
                    data: function () {

                        kf = $('#KFselect').data("kendoDropDownList").value();
                        return { kf: kf };
                    }
                }
            },
            schema: {
                data: "Data",
                total: "Total",
                model: {
                    fields: {
                        KF: { type: "string" },
                        NAME: { type: "string" },
                        ID: { type: "number" },
                        UPD_DATE: { type: "date" }
                    }
                }
            }
        },
        selectable: true,
        pageable: true,
        filterable: true,
        dataBound: function (e) {
            var grid = this;
            var selectedItem = grid.dataItem(grid.select());
            var currentTime = new Date();
             
            //var day = currentDate.getDate()
            //var month = currentDate.getMonth() + 1
            //var year = currentDate.getFullYear()
            //var cur = day + "." + month + "." + year
            if (grid._data.length > 0) {
                var sys_time = grid._data[0].UPD_DATE;
                if (sys_time) {
                    var diff = (currentTime - sys_time) / 1000;
                    if (diff < 10800)
                        $('#SendReq').prop("disabled", true);
                    else
                        $('#SendReq').prop("disabled", false);
                    $("#gridCmEpp").data("kendoGrid").dataSource.read();
                }
                else {
                    $('#SendReq').prop("disabled", false);
                }
            }
        },
        change: function () {
            $("#gridCmEpp").data("kendoGrid").dataSource.read();
        },

        columns: [
            {
                field: "KF",
                title: "Код філії"
            },
            {
                field: "NAME",
                title: "Назва філії"
            },
            {
                field: "UPD_DATE",
                title: "Дата запиту",
                template: "#: PrintRestData(UPD_DATE) #",
            },
            {
                field: "ID",
                title: "Код запиту"
            }
        ]
    });
}

function initCmEppGrid() {
    $("#gridCmEpp").kendoGrid({
        dataSource: {
            type: "webapi",
            serverPaging: true,
            serverFiltering: true,
            serverSorting: true,
            pageSize: 6,
            transport: {
                read: {
                    url: bars.config.urlContent("/api/pfu/monitoring/GetCmEpp"),
                    data: function () {
                        var grid = $("#gridEnquiry").data("kendoGrid");
                        debugger;
                        if (grid._data) {
                            var selectedItem = grid.dataItem(grid.select()); //grid._data[0].ID;
                            debugger;
                            if (selectedItem != null) {
                                KF = selectedItem.ID;
                            }
                            
                        }else
                                KF = "";
                            return { id: KF };
                    
                    }
                }
            },
            schema: {
                data: "Data",
                total: "Total",
                model: {
                    fields: {
                        ID: { type: "number" },
                        DATEMODE: { type: "date" },
                        OPER_TYPE: { type: "number" },
                        OPER_STATUS: { type: "number" },
                        RESP_TXT: { type: "string" },
                        BRANCH: { type: "string" },
                        OPENDATE: { type: "date" },
                        CLIENTTYPE: { type: "number" },
                        TAXPAYERIDENT: { type: "string" },
                        FIRSTNAME: { type: "string" },
                        LASTNAME: { type: "string" },
                        MIDDLENAME: { type: "string" },
                        ENGFIRSTNAME: { type: "string" },
                        ENGLASTNAME: { type: "string" },
                        COUNTRY: { type: "string" },
                        WORK: { type: "string" },
                        OFFICE: { type: "string" },
                        BIRTHDATE: { type: "date" },
                        BIRTHPLACE: { type: "string" },
                        GENDER: { type: "string" },
                        TYPEDOC: { type: "number" },
                        PASPNUM: { type: "string" },
                        PASPSERIES: { type: "string" },
                        PASPDATE: { type: "date" },
                        PASPISSUER: { type: "string" },
                        CONTRACTNUMBEMBER: { type: "string" },
                        PRODUCTCODE: { type: "string" },
                        CARD_TYPE: { type: "string" },
                        REGNUMBERCLIE: { type: "string" },
                        REGNUMBEROWNE: { type: "string" },
                        CARD_BR_ISS: { type: "string" }
                    }
                }
            }
        },
        selectable: true,
        pageable: true,
        filterable: true,
        change: function () {
             
            $("#gridEppline").data("kendoGrid").dataSource.read();
        },
        scrollable: true,
        columns: [
           {
               field: "ID",
               title: "<p>Унікальний ідентифікатор <br/>заявки<p>",
               width: "200px"
           },
           {
               field: "DATEMOD",
               title: "Дата модификації  <br/>заявки",
              
               width: "150px"
           },
           {
               field: "OPER_TYPE",
               title: "Тип операції",
               width: "150px"
           },
           {
               field: "OPER_STATUS",
               title: "Статус операції",
                
               width: "150px"
           },
           {
               field: "RESP_TXT",
               title: "Опис помилки",
                
               width: "150px"
           },
           {
               field: "BRANCH",
               title: "Код установи банку",
                
               width: "200px"
           },
           {
               field: "OPENDATE",
               title: "Дата відкриття  <br/>клієнта",
               template: "#: PrintData(OPENDATE) #",
               width: "150px"

           },
           {
               field: "CLIENTTYPE",
               title: "Тип клієнта",
                
               width: "150px"
           },
           {
               field: "TAXPAYERIDENTIFIER",
               title: "Ідентифікаційний код <br/> клиента",
                
               width: "200px"
           },
           {
               field: "FIRSTNAME",
               title: "Ім’я",
                
               width: "150px"
           },
           {
               field: "LASTNAME",
               title: "Прізвище",
                
               width: "150px"
           },
           {
               field: "MIDDLENAME",
               title: "По-батькові",
                
               width: "150px"
           },
           {
               field: "ENGFIRSTNAME",
               title: "Ім’я, що ембосується <br/> (на англійський )",
                
               width: "200px"
           },
           {
               field: "ENGLASTNAME",
               title: "Прізвище, що ембосується  <br/>(на англійський)",
                
               width: "200px"
           },
           {
               field: "COUNTRY",
               title: "Громадянство",
                
               width: "150px"
           },
           {
               field: "WORK",
               title: "Місце роботи",
                
               width: "150px"
           },
           {
               field: "OFFICE",
               title: "Посада",
                
               width: "100px"
           },
           {
               field: "BIRTHDATE",
               title: "Дата народження",
               template: "#: PrintData(BIRTHDATE) #",
               width: "150px"
           },
           {
               field: "BIRTHPLACE",
               title: "Місце народження",
                
               width: "150px"
           },
           {
               field: "GENDER",
               title: "Стать",
                
               width: "100px"
           }, {
               field: "TYPEDOC",
               title: "Тип документа",
               width: "150px"
           },
           {
               field: "PASPNUM",
               title: "Номер документу, що <br/>засвідчує особу",
                
               width: "200px"
           },
           {
               field: "PASPSERIES",
               title: "Серія документу, що  <br/>засвідчує особу",
                
               width: "200px"
           },
           {
               field: "PASPDATE",
               title: "Дата видачі документу, що  <br/>засвідчує особу",
               template: "#: PrintData(PASPDATE) #",
               width: "200px"
           },
           {
               field: "PASPISSUER",
               title: "Ким виданий документ, що <br/> засвідчує особу",
               width: "200px"
           },
           {
               field: "CONTRACTNUMBER",
               title: "Номер аналітичного  <br/>рахунку 2625 (2605)",
               width: "200px"
           },
           {
               field: "PRODUCTCODE",
               title: "Код продукту",
               width: "150px"
           },
           {
               field: "CARD_TYPE",
               title: "Код Картковий субпродукт",
               width: "250px"
           },
           {
               field: "REGNUMBERCLIENT",
               title: "Унікальний код клієнта, <br/> власника рахунку в АБС",
               width: "240px"
           },
           {
               field: "REGNUMBEROWNER",
               title: "Унікальний код клієнта,  <br/>держателя карти в АБС",
               width: "240px"
           },
           {
               field: "CARD_BR_ISS",
               title: "Номер ЕПП",
               width: "150px"
           }
        ]

    });
}

function initEpplineGrid() {
    $("#gridEppline").kendoGrid({
        dataSource: {
            type: "webapi",
            serverPaging: true,
            serverFiltering: true,
            serverSorting: true,
            pageSize: 6,
            transport: {
                read: {
                    url: bars.config.urlContent("/api/pfu/monitoring/GetVEppLine"),
                    data: function () {
                         
                        var grid = $("#gridCmEpp").data("kendoGrid");
                        if (grid) {
                            var selectedItem = grid.dataItem(grid.select());
                            if (selectedItem != null) {
                                CARD_BR_ISS = selectedItem.CARD_BR_ISS;
                            }
                        }
                        else
                            CARD_BR_ISS = "";
                        return { id: CARD_BR_ISS };
                    }
                }
            },
            schema: {
                data: "Data",
                total: "Total",
                model: {
                    fields: {
                        EPP_NUMBER: { type: "string" },
                        TAX_REGISTRATION_NUMBER: { type: "string" },
                        RNK: { type: "number" },
                        PHONE_NUMBERS: { type: "string" },
                        LAST_NAME: { type: "string" },
                        FIRST_NAME: { type: "string" },
                        MIDDLE_NAME: { type: "string" },
                        DOCUMENT_ID: { type: "string" },
                        ACCOUNT_NUMBER: { type: "string" },
                        PENS_TYPE: { type: "string" },
                        BRANCH: { type: "string" },
                        STATE_ID: { type: "number" }
                    }
                }
            }
        },
        selectable: true,
        pageable: true,
        filterable: true,
        dataBound: function () {
            var grid = this;
            var gridData = grid.dataSource.view();
            if (gridData.length > 0) {
                for (var i = 0; i < gridData.length; i++) {
                    if (gridData[i].STATE_ID == 1 || gridData[i].STATE_ID == 2 || gridData[i].STATE_ID == 10) {
                        grid.table.find("tr[data-uid='" + gridData[i].uid + "']").addClass("one-row");
                    }
                }
            }
        },
        columns: [
            {
                field: "EPP_NUMBER",
                title: "Код ЕПП",
                width: "6%"
            },
            {
                field: "TAX_REGISTRATION_NUMBER",
                title: "ІПН"
            },
            {
                field: "RNK",
                title: "РНК"
            },
            {
                field: "LAST_NAME",
                title: "Призвіще"
            },
            {
                field: "FIRST_NAME",
                title: "Ім'я"
            },
            {
                field: "MIDDLE_NAME",
                title: "По-батькові"
            },
            {
                field: "PHONE_NUMBERS",
                title: "Номер телефону"
            },
            {
                field: "DOCUMENT_ID",
                title: "Серія та номер документа"
            },
            {
                field: "ACCOUNT_NUMBER",
                title: "Номер рахунка"
            },
            {
                field: "PENS_TYPE",
                title: "Ознака пенсійних <br/>виплат"
            },
            {
                field: "BRANCH",
                title: "Номер філії/відділення  <br/>банку отримання картки",
                width: "200px"
            },
            {
                field: "STATE_ID",
                title: "Статус"
            }
        ]
    });
}