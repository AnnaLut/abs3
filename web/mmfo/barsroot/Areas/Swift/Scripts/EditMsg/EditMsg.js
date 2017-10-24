var g_rowSelected = null;
var g_swopt = [];
var g_swopt_byMt = [];
var g_swref = null;
var g_mt = null;

var g_gridMainToolbar = [
    { template: '<a class="k-button" onclick="onClickBtn(this)" title="Зберегти" id="btnSave" ><i class="pf-icon pf-16 pf-save"></i></a>'    }
];

function preFormated(data) {
    if(data == null || data == "null"){
        return "";
    }
    var s = replaceAll(data, '\r', '');
    return replaceAll(s, '\n', '<br>');
}

function SetStrEmpty(s) {
    if(s == null || s == "null"){
        return "";
    }
    return s;
}

function onClickBtn(btn) {
    if("btnSave" == btn.id){
        var grid = $('#gridMain').data("kendoGrid");
        var ch = grid.dataSource.hasChanges();      // return Boolean
        if(ch){
            var forAction = [];
            var data = grid.dataSource.data();
            for (var idx = 0; idx < data.length; idx++) {
                var item = data[idx];
                if (item.dirty) {   // changed row
                    forAction.push({
                        num: item.num,
                        opt: SetStrEmpty(item.opt),
                        swref: item.swref,
                        value: SetStrEmpty(item.value)
                    });
                }
            }
            if(forAction.length > 0){
                Waiting(true);
                AJAX({ srcSettings: {
                    url: bars.config.urlContent("/api/swieditmsgsave"),
                    success: function (data) {
                        updateMainGrid();
                        bars.ui.alert({ text: "Операція успішно виконана." });
                    },
                    complete: function(jqXHR, textStatus){ Waiting(false); },
                    data: JSON.stringify({ mt: g_mt, swref: g_swref, data: forAction })
                } });
            }
            else{
                bars.ui.error({ title: 'Помилка', text: "Дані не модифіковано!" });
            }
        }
        else {
            bars.ui.error({ title: 'Помилка', text: "Дані не модифіковано!" });
        }
    }
}

function updateMainGrid() {
    var grid = $("#gridMain").data("kendoGrid");
    if (grid){grid.dataSource.fetch();}
}

function initMainGrid() {
    Waiting(true);
    fillKendoGrid("#gridMain", {
        type: "webapi",
        // sort: [ { field: "SWREF", dir: "desc" } ],
        transport: {
            read: {
                url: bars.config.urlContent("/api/swieditmsg"),
                data: function () { return { swref: g_swref }; }
            }
        }, pageSize: 100,serverPaging:false,
        schema: {
            model: {
                fields: {
                    num: { type: "number", editable: false },
                    seq: { type: "string", editable: false },
                    subseq: { type: "string", editable: false },
                    tag: { type: "string", editable: false },
                    opt: { type: "string" },
                    status: { type: "string" },
                    empty: { type: "string" },
                    seqstat: { type: "string" },
                    value: { type: "string" },
                    optmodel: { type: "string" },
                    editval: { type: "string" },
                    swref: { type: "number" }
                }
            }
        }
    }, {
        filterMenuInit: function (e) { e.container.addClass("widerMenu"); },        // resize filter menu
        change: function () {
            var grid = this;
            var row = grid.dataItem(grid.select());
            if(g_rowSelected != null && g_rowSelected.num != row.num){
                grid.closeCell();       // close cell focus
            }
            g_rowSelected = row;
        },
        pageable: false,
        editable: true,
        navigatable: true,
        scrollable: false,
        filterable:false,
        sortable:false,
        columns: [
            {
                attributes: { "class": "cellReadonly"},
                field: "num",
                title: "#",
                width: "5%"
            },
            {
                attributes: { "class": "cellReadonly"},
                field: "seq",
                title: "Блок",
                width: "10%"
            },
            {
                attributes: { "class": "cellReadonly"},
                field: "subseq",
                title: "Підблок",
                width: "13%"
            },
            {
                attributes: { "class": "cellReadonly"},
                field: "tag",
                title: "Поле",
                width: "10%"
            },
            {
                attributes: { "class": "cell"},
                field: "opt",
                title: "Опція",
                width: "12%"
                ,editor: optDropDownEditor
                ,template: "#= getOptNameById(opt) #"
            },
            {
                attributes: { "class": "cell"},
                editor: textareaEditor,
                field: "value",
                title: "Значення",
                width: "40%"
                , template:'#= preFormated(value) #'
            }
        ]
        }
        ,null               //toolbarTemplate
        ,null               //fetchFunc
        ,g_gridMainToolbar  //toolbar
    );
    //setGridNavigation("#gridMain");
}

function textareaEditor(container, options) {
    $('<textarea data-bind="value: ' + options.field + '" rows="6" cols="40" wrap = "hard" style = "color: #0a1015"></textarea>')
        .appendTo(container);
}

function getOptNameById(id) {
    return getNameById(id, g_swopt, 'ID', 'VALUE');
}

function optDropDownEditor(container, options) {
    var opts = [];
    var num = parseInt(options.model.num);
    for(var i = 0; i  < g_swopt_byMt.length; i++){
        if(g_swopt_byMt[i].num === num){
            opts.push({"ID": g_swopt_byMt[i].opt, "VALUE": g_swopt_byMt[i].opt});
        }
    }

    $('<input required name="' + options.field + '"/>')
        .appendTo(container)
        .kendoDropDownList({
            dataTextField: "VALUE",
            dataValueField: "ID",
            dataSource: {data: opts.length > 0 ? opts : g_swopt}
        });
}

function loadReceiverSenderInfo() {
    Waiting(true);
    AJAX({ srcSettings: {
        url: bars.config.urlContent("/api/swireceiversender"),
        success: function (data) {
            var _banks = {"receiver": "Отримувач: ", "sender": "Відправник:"};
            for(var k in _banks){
                g_gridMainToolbar.push(
                    { template: '<a class="k-button" title="' + data["Data"]["name_" + k] +
                        '" id="btn' + k + '" >' + _banks[k] + data["Data"][k] + '</a>'}
                );
            }

            initMainGrid();
            $(".k-grid-toolbar", "#gridMain").before("Референс повідомлення: " + "<span style='color: #1c84c6'>" + g_swref + "</span>");
        },
        complete: function(jqXHR, textStatus){ Waiting(false); },
        data: JSON.stringify( { MT: g_mt, SWREF: g_swref })
    } });
}

function loadSwOpt() {
    Waiting(true);
    AJAX({ srcSettings: {
        url: bars.config.urlContent("/api/swieditmsgswopt"),
        success: function (data) {
            for(var i = 0; i < data["DataOpt"].length; i++){
                g_swopt.push({"ID": data["DataOpt"][i], "VALUE": data["DataOpt"][i]});
            }
            g_swopt_byMt = data["DataOptByMt"];
            loadReceiverSenderInfo();
        },
        complete: function(jqXHR, textStatus){ Waiting(false); },
        data: JSON.stringify( { MT: g_mt, SWREF: g_swref })
    } });
}

$(document).ready(function () {
    g_swref = bars.extension.getParamFromUrl('swref');
    g_mt = bars.extension.getParamFromUrl('mt');

    loadSwOpt();
});