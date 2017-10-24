/**
 * Created by serhii.karchavets on 13.02.2017.
 */

var g_gridMainToolbar = [
    { template: '<a class="k-button" onclick="onClickBtn(this)" title="Виигрузити в Excel" id="btnExcel" ><i class="pf-icon pf-16 pf-exel"></i></a>'    }
];

function onClickBtn(btn) {
    var grid = $('#gridMain').data("kendoGrid");

    if(btn.id == "btnExcel"){
        grid.saveAsExcel();
    }
}

function updateMainGrid() {
    var grid = $("#gridMain").data("kendoGrid");
    if (grid){grid.dataSource.fetch();}
}

function checkAll(ele) {
    var state = $(ele).is(':checked');
    $('.chkFormols').prop('checked', state == true);
}

function linkToREF(REF) {
    return '<a href="#" onclick="OpenREF(\''+REF+'\')" style="color: blue">' + REF + '</a>';
}

function OpenREF(REF) {
    if(REF != null && REF !== "null"){
        var url = "/barsroot/clientregister/registration.aspx?rnk=" + REF + "&readonly=1";
        // OpenBarsDialog();
        window.showModalDialog(encodeURI(url), null, "dialogWidth:1024px; dialogHeight:800px; center:yes; status:no");
    }
    else{ bars.ui.error({ title: 'Помилка', text: "Неправильний REF!" }); }
}

function Fire() {
    var startDate = replaceAll($("#startDate").val(), '/', '.');
    var endDate = replaceAll($("#endDate").val(), '/', '.');

    if(startDate == null || startDate == "" || endDate == null || endDate == ""){
        bars.ui.error({ title: 'Помилка', text: "Дату не вибрано!" });
        return;
    }

    var grid = $("#gridMain").data("kendoGrid");
    var forAction = [];
    var dataSource = grid.dataSource;
    grid.tbody.find("input:checked").closest("tr").each(function (index) {
        var uid = $(this).attr('data-uid');
        var item = dataSource.getByUid(uid);
        forAction.push({
            bic: item.bic,
            rnk: item.rnk,
            stmt: item.stmt,
            dat1: startDate,
            dat2: endDate
        });
    });
    if(forAction.length > 0){
        bars.ui.confirm({text: "Формувати виписки?"}, function () {
            $('.chkFormolsAll').prop('checked', false);
            var count = forAction.length;
            for(var i = 0; i < forAction.length; i++){
                Waiting(true);
                AJAX({ srcSettings: {
                    url: bars.config.urlContent("/api/stmt950createcustomerstatementmessage"),
                    success: function (data) {
                        count--;
                        if(count == 0){
                            updateMainGrid();
                            bars.ui.alert({ text: "Операція успішно виконана." });
                        }
                    },
                    complete: function(jqXHR, textStatus){ Waiting(false); },
                    data: JSON.stringify( forAction[i])
                } });
            }
        });
    }
    else{
        bars.ui.error({ title: 'Помилка', text: "Документи не відмічені!" });
    }
}

function initMainGrid() {
    fillKendoGrid("#gridMain", {
            type: "webapi",
            // sort: [ { field: "SWREF", dir: "desc" } ],
            transport: { read: { url: bars.config.urlContent("/api/stmt950search") } },
            pageSize: 20,
            schema: {
                model: {
                    fields: {
                        bic: { type: "string" },
                        rnk: { type: "number" },
                        nmk: { type: "string" },
                        name: { type: "string" },
                        stmt: { type: "number" }
                    }
                }
            }
        }, {
            reorderable: true,
            excel: {
                allPages: true,
                fileName: "stmt.xlsx",
                proxyURL: bars.config.urlContent('/Swift/Stmt950/ConvertBase64ToFile/')
            },
            dataBound: function(e) {
                Waiting(false);
                var grid = this;
                var doc_h = $(document).height();
                var h = 50*doc_h/100;
                $('#gridMain .k-grid-content').height(h);
            },
            filterMenuInit: function (e) { e.container.addClass("widerMenu"); },        // resize filter menu
            pageable: {
                messages: {
                    allPages: "Всі"
                },
                refresh: true,
                pageSizes: [10, 50, 200, 1000, "All"],
                buttonCount: 5
            },
            columns: [
                {
                    field: "block",
                    title: "",
                    filterable: false,
                    sortable: false,
                    template: "<input type='checkbox' class='chkFormols' style='margin-left: 26%;' />",
                    headerTemplate: "<input type='checkbox' class='chkFormolsAll' id='check-all' title='Всі' onclick='checkAll(this)'/>",
                    width: "3%"
                },
                {
                    field: "rnk",
                    template:'#= linkToREF(rnk) #',
                    title: "РНК",
                    width: "15%"
                },
                {
                    field: "nmk",
                    title: "Назва",
                    width: "30%"
                },
                {
                    field: "bic",
                    title: "BIC-код",
                    width: "10%"
                },
                {
                    field: "stmt",
                    title: "Код виписки",
                    width: "10%"
                },
                {
                    field: "name",
                    title: "Назва виписки",
                    width: "15%"
                }
            ]
        }
        ,null               //toolbarTemplate
        ,null               //fetchFunc
        ,g_gridMainToolbar  //toolbar
    );
    setGridNavigationChbx("#gridMain");
}

$(document).ready(function (){
    $("#title").html("Формування виписок MT950");

    $("#startDate").kendoMaskedDatePicker({ format: "dd/MM/yyyy" });
    $("#endDate").kendoMaskedDatePicker({ format: "dd/MM/yyyy" });

    $('#FireBtn').click(Fire);

    initMainGrid();
});