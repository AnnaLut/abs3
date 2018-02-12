function checkAll(ele) {
    var grid = $('#gridMain').data('kendoGrid');
    var state = $(ele).is(':checked');
    $('.chkFormols').prop('checked', state == true);
}

function initMainGrid() {
    Waiting(true);

    fillKendoGrid("#gridMain", {
        type: "webapi",
        // sort: [ { field: "SWREF", dir: "desc" } ],
        transport: { read: { url: bars.config.urlContent("/api/BpkW4/ActivationReservedAccountsApi/activationreservedaccounts") } },
        schema: {
            model: {
                fields: {
                    ACC: { type: "number" },
                    RNK: { type: "number" },
                    NMK: { type: "string" },
                    OKPO: { type: "string" },
                    NLS: { type: "string" },
                    CARD_CODE: { type: "string" }
                }
            }
        }
    }, {
        columns: [
            {
                field: "block",
                title: "",
                filterable: false,
                sortable: false,
                template: "<input type='checkbox' class='chkFormols' style='margin-left: 26%;' />",
                headerTemplate: "<input type='checkbox' class='chkFormolsAll' id='check-all' onclick='checkAll(this)'/><br><label for='check-all'>Вибрати всі</label>",
                width: "5%"
            },
            {
                template:'#= linkToKK(RNK) #',
                field: "RNK",
                title: "РНК",
                width: "10%"
            },
            {
                field: "NMK",
                title: "ПІБ клієнта",
                width: "15%"
            },
            {
                field: "OKPO",
                title: "OKПO",
                width: "10%"
            },
            {
                template:'#= linkToNls(NLS, ACC) #',
                field: "NLS",
                title: "Рахунок клієнта",
                width: "10%"
            },
            {
                field: "CARD_CODE",
                title: "Код карткового продукту",
                width: "10%"
            }
        ]
    }, null, null);
}

function linkToNls(NLS, ACC) {
    return '<a href="#" onclick="OpenACC(\''+ACC+'\')" style="color: blue">' + NLS + '</a>';
}

function linkToKK(RNK) {
    return '<a href="#" onclick="OpenNMK(\''+RNK+'\')" style="color: blue">' + RNK + '</a>';
}

function OpenNMK(NMK) {
    if(NMK != null && NMK !== "null"){
        window.open(encodeURI("/barsroot/clientregister/registration.aspx?readonly=0&rnk=" + NMK),null,
            "height=800,width=1024,menubar=no,toolbar=no,location=no,titlebar=no,scrollbars=yes,resizable=yes");
    }
    else{ bars.ui.error({ title: 'Помилка', text: "Неправильний ПІБ клієнта!" }); }
}

function OpenACC(NLS) {
    if(NLS != null && NLS !== "null"){
        window.open(encodeURI("/barsroot/viewaccounts/accountform.aspx?type=0&acc=" + NLS + "&rnk=&accessmode=1"),null,
            "height=600,width=600,menubar=no,toolbar=no,location=no,titlebar=no,scrollbars=yes,resizable=yes");
    }
    else{ bars.ui.error({ title: 'Помилка', text: "Неправильний рахунок клієнта!" }); }
}

function ApplyActivation() { isBackoficceCkeck(Activation, 1); }
function CanselActivation() { isBackoficceCkeck(Activation, 0); }

function isBackoficceCkeck(func, param) {
	$.ajax({
		type: "GET",
		url: bars.config.urlContent("/api/custacc/start/"),
		success: function (result) {
			if (result > 0) {
				func(param);
			} else {
				bars.ui.alert({ text: "Поточний користувач не нележить \"Підрозділу бек-офісу\"" });
			}
		}
	});
}

// confirm<number> [0, 1]
function Activation(confirm) {
    var grid = $('#gridMain').data("kendoGrid");
    var forActive = [];
    var dataSource = grid.dataSource;
    grid.tbody.find("input:checked").closest("tr").each(function (index) {
        var uid = $(this).attr('data-uid');
        var item = dataSource.getByUid(uid);
        forActive.push(item.ACC);
    });
    if(forActive.length > 0){
        bars.ui.confirm({text: (confirm ? "Підтвердити" : "Відхилити") + " активацію вибраних записів?"}, function () {
            ActivationRequest(forActive, confirm);
        });
    }
    else{bars.ui.error({ title: 'Помилка', text: "Документи не відмічені!" });}
}

//  Array<number>
function ActivationRequest(data, confirm) {
    AJAX({ srcSettings: {
        url: bars.config.urlContent("/api/BpkW4/ActivationReservedAccountsApi/active"),
        success: function (data) {
            var text = "Активацію рахунку успішно " + (confirm == 1 ? "підтверджено" : "відхилено");
            bars.ui.notify("Активація", text, 'success');
            updateMainGrid();
        },
        error: function(jqXHR, textStatus, errorThrown){},
        data: JSON.stringify({Data: data, Confirm: confirm})
    } });
}

function updateMainGrid() {
    var grid = $("#gridMain").data("kendoGrid");
    if (grid){grid.dataSource.fetch();}
}

$(document).ready(function () {
   initMainGrid();

    $('#ApplyActivationBtn').click(ApplyActivation);
    $('#CanselActivationBtn').click(CanselActivation);
});