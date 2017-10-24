///*** GLOBALS
var PAGE_INITIAL_COUNT = 10;
var PAGEABLE = {
    refresh: true,
    messages: {
        empty: "Дані відсутні",
        allPages: "Всі"
    },
    pageSizes: [PAGE_INITIAL_COUNT, 50, 200, 1000, "All"],
    buttonCount: 5
};

var g_gridMainToolbar = [
    { template: '<a class="k-button" onclick="onClickBtn(this)" title="Вигрузити в Excel" id="btnExcel" ><i class="pf-icon pf-16 pf-exel"></i></a>'    },
    { template: '<a class="k-button" onclick="onClickBtn(this)" title="Реєстрація нової картки" id="btnNew" ><i class="pf-icon pf-16 pf-add"></i></a>' },
    { template: '<a class="k-button" onclick="onClickBtn(this)" title="Перегляд картки клієнта" id="btnClientCard" ><i class="pf-icon pf-16 pf-user_group"></i></a>'    },
    { template: '<a class="k-button" onclick="onClickBtn(this)" title="Перегляд картки рахунку" id="btnAccCard" ><i class="pf-icon pf-16 pf-table"></i></a>'    },
    { template: '<a class="k-button" onclick="onClickBtn(this)" title="Рахунки угоди" id="btnAccOrder" ><i class="pf-icon pf-16 pf-business_report"></i></a>'    },
    { template: '<a class="k-button" onclick="onClickBtn(this)" title="Друк договорів" id="btnPrintOrders" ><i class="pf-icon pf-16 pf-print"></i></a>'    },
    { template: '<a class="k-button" onclick="onClickBtn(this)" title="Сформувати запит" id="btnRunSelect" ><i class="pf-icon pf-16 pf-mail-arrow_right"></i></a>'    },
    { template: '<a class="k-button" onclick="onClickBtn(this)" title="Додаткова картка по КК" id="btnAddCard" ><i class="pf-icon pf-16 pf-man_1-update"></i></a>'    },
    { template: '<a class="k-button" onclick="onClickBtn(this)" title="Додаткова картка школяра" id="btnSchoolboy" ><i class="pf-icon pf-16 pf-user"></i></a>'    },
    { template: '<a class="k-button" onclick="onClickBtn(this)" title="Довгострокове доручення" id="btnLongTermAssignments" ><i class="pf-icon pf-16 pf-list-ok"></i></a>'    },
    { template: '<a class="k-button" onclick="onClickBtn(this)" title="Приєднати до ДКБО" id="btnConnDkbo" ><i class="pf-icon pf-16 pf-database-arrow_right"></i></a>'    }
];

var g_gridMainToolbarRoot = [
    { template: '<a class="k-button" onclick="onClickBtn(this)" title="Договір забезпечення" id="btnCreditUi" ><i class="pf-icon pf-16 pf-money"></i></a>'    },
    { template: '<a class="k-button" onclick="onClickBtn(this)" title="Змінити тип картки" id="btnСngСard" ><i class="pf-icon pf-16 pf-calendar-update"></i></a>'    },
    { template: '<a class="k-button" onclick="onClickBtn(this)" title="Інформація про передачу до бек-офісу" id="btnGo2BackOffice" ><i class="pf-icon pf-16 pf-tool_pencil"></i></a>'    },
    { template: '<a class="k-button" onclick="onClickBtn(this)" title="Друк договорів страхування" id="btnPrintOrders2" ><i class="pf-icon pf-16 pf-report_open-import"></i></a>'    }
];

var g_mainGridNeedSelectFirstRow = true;

var PASS_STATES = {
    1: "Передано",
    2: "Перевірено",
    3: "Повернуто на доопрацювання"
};

var g_statesDataSource = [];
for (var k in PASS_STATES){ g_statesDataSource.push({ name: PASS_STATES[k], id: k }); }

///***
var g_data = { ndNumber: "", accNls: "", custName: "", okpo: "", passState: "", passDateStr: "" };
var g_opertype = null;

function updateMainGrid() {
    Waiting(true);
    var grid = $("#gridMain").data("kendoGrid");
    if (grid){grid.dataSource.fetch();}
} 

function initMainGrid() {
    Waiting(true);

    fillKendoGrid("#gridMain", {
        type: "webapi",
        //sort: [ { field: "ID", dir: "desc" } ],
        transport: { read: {
        	url: bars.config.urlContent("/api/Way4Bpk/Way4Bpk/SearchMain"),
			data: function () { return g_data; }
        } },
		pageSize: PAGE_INITIAL_COUNT,
        schema: {
			model: {
				fields: {
					ND: { type: 'number' },
					BRANCH: { type: 'string' },
					CARD_CODE: { type: 'string' },
					PRODUCT_CODE: { type: 'string' },
					ACC_ACC: { type: 'number' },
					ACC_NLS: { type: 'string' },
					ACC_KV: { type: 'number' },
					ACC_LCV: { type: 'string' },
					ACC_OB22: { type: 'string' },
					ACC_TIP: { type: 'string' },
					ACC_TIPNAME: { type: 'string' },
					ACC_OST: { type: 'number' },
					ACC_DAOS: { type: 'date' },
					ACC_DAZS: { type: 'date' },
					CUST_RNK: { type: 'number' },
					CUST_NAME: { type: 'string' },
					CUST_OKPO: { type: 'string' },
					CUST_TYPE: { type: 'number' },
					CARD_IDAT: { type: 'date' },
					CARD_IDAT2: { type: 'date' },
					CARD_IDAT_BANKDATE: { type: 'date' },
					DOC_ID: { type: 'string' },
					BARCOD: { type: 'string' },
					COBRANDID: { type: 'string' },
					ISDKBO: { type: 'number' },
					DKBO_ID: { type: 'number' },
					DKBO_NUMBER: { type: 'string' },
					DKBO_DATE_FROM: { type: 'date' },
					DKBO_DATE_TO: { type: 'date' },
					DEAL_TYPE_ID: { type: 'number' },
					DEAL_STATE_ID: { type: 'number' },
					CARD_DATE_FROM: { type: 'date' },
					CARD_DATE_TO: { type: 'date' },
					SED: { type: 'string' },
					IS_ACC_CLOSE: { type: 'number' },
                    PASS_DATE: { type: 'date' },
                    PASS_STATE: { type: 'number' }
				}
			}
		}
    }, {
        pageable: PAGEABLE,
		filterMenuInit: function (e) { e.container.addClass("widerMenu"); },        // resize filter menu
        reorderable: true,
        excel: {
            allPages: true,
            fileName: "way4bpk.xlsx",
            proxyURL: bars.config.urlContent('/Way4Bpk/Way4Bpk/ConvertBase64ToFile/')
        },
        excelExport: function (e) {
           var sheet = e.workbook.sheets[0];
           var header = sheet.rows[0];
           for (var headerCellIndex = 0; headerCellIndex < header.cells.length; headerCellIndex++) {
               var headerColl = header.cells[headerCellIndex];
               headerColl.value = headerColl.value.replace(/<br>/g, ' ');
           }
        },
        dataBound: function (e) {
            var grid = this;
            Waiting(false);
            if(g_mainGridNeedSelectFirstRow){
                g_mainGridNeedSelectFirstRow = false;
                if(grid.dataSource.total() > 0){
                    setTimeout(function () {
                        grid.select(e.sender.tbody.find("tr:first"));
                    }, 50)
                }
            }

            grid.tbody.find("tr").dblclick(function (e) {
                e.preventDefault();
                onClickBtn({id: "btnGo2BackOffice"});
            });
        },
        columns: [
			{
				field: "ND",
				title: "Номер<br>договору",
				width: 100
			},
			{
				field: "BRANCH",
				title: "Відділення",
				width: 100
			},
            {
                field: "ACC_NLS",
                title: "Картковий<br>рахунок",
                width: 100
            },
            {
                field: "ACC_LCV",
                title: "Вал.",
                width: 60
            },
            {
                field: "ACC_OB22",
                title: "ОБ22",
                width: 60
            },
            {
                field: "ACC_TIPNAME",
                title: "Субпродукт",
                width: 300
            },
			{
				field: "CARD_CODE",
				title: "Тип картки",
				width: 200
			},
            {
                template: "<div style='text-align:center;'>#=(CARD_IDAT == null) ? ' ' : kendo.toString(CARD_IDAT,'dd.MM.yyyy')#</div>",
                field: "CARD_IDAT",
                title: "Дата видачі<br>карти",
                width: 100
            },
            {
                field: "ACC_OST",
                title: "Залишок",
                width: 100
            },
            {
                field: "CUST_RNK",
                title: "РНК",
                width: 100
            },
            {
                field: "CUST_NAME",
                title: "ПІБ (назва) клієнта",
                width: 240
            },
            {
                field: "CUST_OKPO",
                title: "ІПН",
                width: 100
            },
            {
                template: "<div style='text-align:center;'>#=(ACC_DAOS == null) ? ' ' : kendo.toString(ACC_DAOS,'dd.MM.yyyy')#</div>",
                field: "ACC_DAOS",
                title: "Дата<br>відкриття",
                width: 100
            },
            {
                template: "<div style='text-align:center;'>#=(ACC_DAZS == null) ? ' ' : kendo.toString(ACC_DAZS,'dd.MM.yyyy')#</div>",
                field: "ACC_DAZS",
                title: "Дата<br>закриття",
                width: 100
            },
            {
                field: "BARCOD",
                title: "Штрих–код",
                width: 100
            },
            {
                field: "COBRANDID",
                title: "Ід<br>ко-бренду",
                width: 100
            },
            {
                field: "ISDKBO",
                title: "Рахунок приєднано<br>до ДКБО",
                width: 100
                ,template: "#= getIsDkboById(ISDKBO) #"
            },
            {
                template: "<div style='text-align:center;'>#=(PASS_DATE == null) ? ' ' : kendo.toString(PASS_DATE,'dd.MM.yyyy')#</div>",
                field: "PASS_DATE",
                title: "Дата передачі<br>справи",
                width: 130
            },
            {
                field: "PASS_STATE",
                template: "#= getStatusById(PASS_STATE) #",
                title: "Стан передачі<br>справ",
                width: 130
            }
		]
    }, null, null, g_gridMainToolbar);
}

function getStatusById(PASS_STATE) {
    if(isEmpty(PASS_STATE)){ return ""; }

    var state = PASS_STATES[PASS_STATE];
    return state !== undefined ? state : "";
}

function getIsDkboById(ISDKBO) {
    return parseInt(ISDKBO) === 1 ? "Так" : "Ні";
}

function Search() {
    var passState = $("#passState").data("kendoDropDownList").value();
    var passDateStr = replaceAll($("#passDateSelect").val(), '/', '.');

    var ndNumber = $("#ndNumber").val();
    var accNls = $("#accNls").val();
    var custName = $("#custName").val();
    var okpo = $("#okpo").val();
    if(isEmpty(ndNumber) && isEmpty(accNls) && isEmpty(custName) &&
        isEmpty(okpo) && isEmpty(passState)){
        bars.ui.error({ title: 'Помилка', text: "Задайте умови пошуку!" });
        return;
    }
    g_data = { ndNumber: ndNumber, accNls: accNls, custName: custName, okpo: okpo,
        passState: passState, passDateStr: passDateStr
    };
    updateMainGrid();
}

function confirmCngCard() {
    var gridSubProd = $('#gridCngCard').data("kendoGrid");
    var rowSubProd = gridSubProd.dataItem(gridSubProd.select());
    if(!rowSubProd){
        bars.ui.error({ title: 'Помилка', text: "Дані не вибрано!" });
        return;
    }

    var grid = $('#gridMain').data("kendoGrid");
    var row = grid.dataItem(grid.select());

    WaitingForID(true, "#search-cng-card");

    AJAX({ srcSettings: {
        url: bars.config.urlContent("/api/Way4Bpk/Way4Bpk/CngCard"),
        success: function (data) {
            $("#dialogCngCard").data('kendoWindow').close();
            updateMainGrid();
            bars.ui.notify("До відома", "Дані оброблено успішно", 'info', {autoHideAfter: 5*1000});
        },
        complete: function(jqXHR, textStatus){ WaitingForID(false, "#search-cng-card"); },
        data: JSON.stringify({ND: row.ND, CODE: rowSubProd.CODE})
    } });
}

function onClickBtn(btn) {
    var grid = $('#gridMain').data("kendoGrid");
    var row = grid.dataItem(grid.select());
    if(!row && btn.id !== "btnNew" && btn.id !== "btnExcel" && btn.id !== "btnPrintOrders2"){
        bars.ui.error({ title: 'Помилка', text: "Дані не обрано!" });
        return;
    }

    switch (btn.id){
        case "btnExcel":
            grid.saveAsExcel();
            break;

        case "btnClientCard":
            var url = "/barsroot/clientregister/registration.aspx?rnk=" + row.CUST_RNK + "&readonly=0";
            window.showModalDialog(encodeURI(url), null, "dialogWidth:1024px; dialogHeight:800px; center:yes; status:no");
            break;

        case "btnAccCard":
            window.location = "/barsroot/viewaccounts/accountform.aspx?accessmode=1&type=0&rnk=" + row.CUST_RNK + "&acc=" + row.ACC_ACC;
            break;

        case "btnSchoolboy":
        case "btnAddCard":
            var p = btn.id === "btnSchoolboy" ? "card_kiev=1sch" : "card_kiev=1";
            Waiting(true);
            AJAX({ srcSettings: {
                url: bars.config.urlContent("/Way4Bpk/Way4Bpk/SetSession"),
                success: function (data) {
                    window.location = "/barsroot/cardkiev/cardkievparams.aspx?" + p;
                },
                complete: function(jqXHR, textStatus){ Waiting(false); },
                data: JSON.stringify( [
                    { Key: "docNumberKK", Value: row.ND },
                    { Key: "currentRnk", Value: row.CUST_RNK },
                    { Key: "product", Value: row.PRODUCT_CODE }
                    ])
            } });
            break;

        case "btnGo2BackOffice":
            $("#dialogGo2BackOffice").data('kendoWindow').center().open();

            if(!isEmpty(row.PASS_STATE)){
                ddListSelect("#passStateDdl", row.PASS_STATE, g_statesDataSource);
            }
            if(!isEmpty(row.PASS_DATE)){
                var datepicker = $("#passDate").data("kendoMaskedDatePicker");
                var d = new Date(row.PASS_DATE.getFullYear(), row.PASS_DATE.getMonth(), row.PASS_DATE.getDate());
                datepicker.value(d);
            }
            break;

        case "btnLongTermAssignments":
            window.location = "/barsroot/w4/AddRegularPayment.aspx?NLS=" +
                row.ACC_NLS + "&RNK=" + row.CUST_RNK + "&NMK=" + row.CUST_NAME +
                "&KV=" + row.ACC_KV + "&OB22=" + row.ACC_OB22 + "&OKPO=" + row.CUST_OKPO +
                "&BRANCH=" + row.BRANCH;
            break;

        case "btnConnDkbo":
            window.location = "/barsroot/bpkw4/checkdkbo/index?RNK=" + row.CUST_RNK +
                "&ACC_ACC=" + row.ACC_ACC + "&ISDKBO=" + row.ISDKBO +
                "&IS_ACC_CLOSE=" + row.IS_ACC_CLOSE;
            break;

        case "btnCreditUi":
            window.location = "/barsroot/CreditUi/Provide/Index/?id=" + row.ND + "&tip=3";
            break;

        case "btnAccOrder":
            window.location = "/barsroot/customerlist/custacc.aspx?type=5&mod=ro&bpkw4nd=" + row.ND;
            break;

        case "btnRunSelect":
            $("#dialogProcessing").data('kendoWindow').center().open();
            break;

        case "btnNew":
            $("#dialogNewCard").data('kendoWindow').center().open().maximize();
            break;

        case "btnСngСard":
            $("#dialogCngCard").data('kendoWindow').center().open();
            WaitingForID(true, "#search-cng-card");
            fillKendoGrid("#gridCngCard", {
                transport: { read: {
                    url: bars.config.urlContent("/api/Way4Bpk/Way4Bpk/SearchSubproduct"),
                    data: function () { return {code: row.CARD_CODE}; }
                }
                },
                schema: {
                    model: {
                        fields: {
                            SUBPRODUCT_CODE: { type: "string" },
                            NAME: { type: "string" },
                            CODE: { type: "string" }
                        }
                    }
                }
            }, {
                dataBound: function () { WaitingForID(false, "#search-cng-card"); },
                columns: [
                    {
                        field: "SUBPRODUCT_CODE",
                        title: "Код субпродукта"
                    },
                    {
                        field: "NAME",
                        title: "Назва субпродукта"
                    },
                    {
                        field: "CODE",
                        title: "Тип карти"
                    }
                ],
                filterMenuInit: function (e) { e.container.addClass("widerMenu"); }
            }, null, null);
            break;

        case "btnPrintOrders":
            Waiting(true);
            AJAX({ srcSettings: {
                url: bars.config.urlContent("/Way4Bpk/Way4Bpk/SetSession"),
                success: function (data) {
                    window.location = "/barsroot/printcontract/index?multiSelection=true";
                },
                complete: function(jqXHR, textStatus){ Waiting(false); },
                data: JSON.stringify( [
                    { Key: "multiprint_id", Value: row.ACC_ACC },
                    { Key: "multiprint_filter", Value: row.DOC_ID }])
            } });
            break;

        case "btnPrintOrders2":
            var _nd = row ? row.ND : "";
            window.location = "/barsroot/InsUi/cardinsurance?bpkw4nd=" + _nd;
            break;
    }
}

function ddListSelect(id, v, dataSource) {
    if(v){
        var dropdownlist = $(id).data("kendoDropDownList");
        for(i = 0; i < dataSource.length; i++){
            if(parseInt(dataSource[i].id) === parseInt(v)){
                dropdownlist.select(i);
                dropdownlist.trigger("change");
                break;
            }
        }
    }
}

function showReferOper() {
    bars.ui.handBook("v_cm_opertype", function (data) {
            $("#edtOperValue").text(data[0].NAME);
            g_opertype = data[0].ID;
        },
        {
            multiSelect: false,
            clause: "",
            columns: "ID,NAME"
        });
}

function FireConfirm() {
    if(g_opertype === null){
        bars.ui.error({ title: 'Помилка', text: "Операцію не визначено" });
        return;
    }

    var grid = $('#gridMain').data("kendoGrid");
    var row = grid.dataItem(grid.select());
    if(!row){
        bars.ui.error({ title: 'Помилка', text: "Дані не обрано!" });
        return;
    }

    Waiting(true);
    AJAX({ srcSettings: {
        url: bars.config.urlContent("/api/Way4Bpk/Way4Bpk/AddDealToCmque"),
        success: function (data) {
            $("#dialogProcessing").data('kendoWindow').close();
            updateMainGrid();
            bars.ui.notify("До відома", "Запит сформовано", 'info', {autoHideAfter: 5*1000});
        },
        complete: function(jqXHR, textStatus){ Waiting(false); }
        ,data: JSON.stringify({ ND: row.ND, OperType: g_opertype })
    } });
}

function Go2BackOfficeConfirmBtn() {
    var grid = $('#gridMain').data("kendoGrid");
    var row = grid.dataItem(grid.select());

    var passState = $("#passStateDdl").data("kendoDropDownList").value();
    var passDateStr = replaceAll($("#passDate").val(), '/', '.');

    WaitingForID(true, ".search-Go2BackOffice");
    AJAX({ srcSettings: {
        url: bars.config.urlContent("/api/Way4Bpk/Way4Bpk/SetPassDate"),
        success: function (data) {
            $("#dialogGo2BackOffice").data('kendoWindow').close();
            updateMainGrid();
            bars.ui.notify("До відома", "Дані успішно змінено", 'info', {autoHideAfter: 5*1000});
        },
        complete: function(jqXHR, textStatus){ WaitingForID(false, ".search-Go2BackOffice"); }
        ,data: JSON.stringify({ nD: row.ND, passState: passState, passDateStr: passDateStr })
    } });
}

$(document).ready(function () {

    // input params:
    // custtype - 1,2,3
    // nd - number

	$("#title").html("Way4. Портфель БПК");

    $('#SearchBtn').click(Search);
    $('#confirmCngCard').click(confirmCngCard);

    var nd = bars.extension.getParamFromUrl('nd');
    var ndNum = !isEmpty(nd) && !isNaN(nd) ? parseInt(nd) : null;
    $("#ndNumber").kendoNumericTextBox({ format: "#", decimals: 0, spinners : false, value: ndNum });
    $("#accNls").kendoNumericTextBox({ format: "#", decimals: 0, spinners : false });
    $("#okpo").kendoNumericTextBox({ format: "#", decimals: 0, spinners : false });
    g_data['ndNumber'] = $("#ndNumber").val();

    InitGridWindow({windowID: "#dialogProcessing", srcSettings: {title: "Вибер операції"}});
    InitGridWindow({windowID: "#dialogCngCard", srcSettings: {title: "Зміна типу картки", width: "900px"}});
    InitGridWindow({windowID: "#dialogNewCard", srcSettings: {title: "Вибір нової картки", width: "900px", open: prepareNewCard}});
    InitGridWindow({windowID: "#dialogGo2BackOffice", srcSettings: {title: "Зміна інформації про передачу до бек-офісу", open: function () {
        $("#passDateErrorMsg").hide();
    }}});

    $('#FireConfirmBtn').click(FireConfirm);
    $('#selectNewCardBtn').click(selectNewCardBtn);
    $('#Go2BackOfficeConfirmBtn').click(Go2BackOfficeConfirmBtn);

    var now = new Date(Date.now());
    var d = new Date(now.getFullYear(), now.getMonth(), now.getDate());
    $("#passDate").kendoMaskedDatePicker({
        format: "dd/MM/yyyy",
        value: d,
        change: function() {
            $("#passDateErrorMsg").hide();
            var value = this.value();
            if(value > now){
                $("#passDateErrorMsg").show();
                setTimeout(function () { $("#passDateErrorMsg").hide(); }, 3000);
                var grid = $('#gridMain').data("kendoGrid");
                var row = grid.dataItem(grid.select());
                if(!isEmpty(row.PASS_DATE)){
                    this.value(new Date(row.PASS_DATE.getFullYear(), row.PASS_DATE.getMonth(), row.PASS_DATE.getDate()));
                }
                else{
                    this.value(d);
                }
            }
        }
    });

    $("#passStateDdl").kendoDropDownList({
        dataTextField: "name",
        dataValueField: "id",
        dataSource: g_statesDataSource
    });

    $("#passState").kendoDropDownList({
        dataTextField: "name",
        dataValueField: "id",
        optionLabel: "----",
        dataSource: g_statesDataSource
    });
    $("#passDateSelect").kendoMaskedDatePicker({ format: "dd/MM/yyyy" });

    // AJAX({ srcSettings: {
    //     url: bars.config.urlContent("/api/Way4Bpk/Way4Bpk/UserBranch"),
    //     success: function (data) {
    //         var userBranch = data['userBranch'];
    //         if(userBranch === null || userBranch.length === 8){   //  /300465/
    //             g_gridMainToolbar = g_gridMainToolbar.concat(g_gridMainToolbarRoot);
    //         }
    //         initMainGrid();
    //     },
    //     error: function () { bars.ui.error({ title: 'Помилка', text: "Не вдалось зчитати контекст - спробуйте перезайти в систему!" }); }
    // } });

    $("#newCardRnk").kendoNumericTextBox({ format: "#", decimals: 0, spinners : false });
    $("#newCardIpn").kendoNumericTextBox({ format: "#", decimals: 0, spinners : false });


    visibilityErrorNewCard();

    g_gridMainToolbar = g_gridMainToolbar.concat(g_gridMainToolbarRoot);
    initMainGrid();
});
