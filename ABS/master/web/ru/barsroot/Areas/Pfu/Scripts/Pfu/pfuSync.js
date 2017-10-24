/**
 * Created by serhii.karchavets on 04.08.2016.
 */
// Constans
var KEY_CODE_ENTER = 13;
var INITIAL_SYNC_STATUS = 2;

var g_gridCounter = 0;
var g_filterGrid = null;
////////////

// население грида с реестрами
function initRegistersGrid(qv) {
    g_filterGrid = qv;

    fillKendoGrid("#gridFiles", {
        type: "webapi",
        //sort: [ { field: "KF", dir: "desc" } ],
        transport: {
            read: {
                url: bars.config.urlContent("/api/pfu/filesgrid/searchsync"),
                data: function () { return g_filterGrid; }
            }
        },
        schema: {
            model: {
                fields: {
                    KF: { type: "string" },
                    NAME: { type: "string" },
                    CURSTATE: { type: "number" },
                    LASTDATE: { type: "date" }
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
                width: "3%"
            },
            {
                title: "№ п/п",
                template: "#= ++g_gridCounter #",
                width: "3%"
            },
            {
                field: "KF",
                title: "Код МФО",
                width: "8%"
            },
            {
                field: "NAME",
                title: "Назва філії",
                width: "15%"
            },
            {
                field: "LASTDATE",
                title: "Дата останньої успішної<br>синхронізації",
                width: "7%",
                template: "<div style='text-align:center;'>#=(LASTDATE == null) ? ' ' : kendo.toString(LASTDATE,'dd.MM.yyyy')#</div>"
            },
            {
                field: "CURSTATE",
                title: "Статус поточної<br>синхронізації",
                width: "10%",
                template: "#= getStatusById(CURSTATE) #"
            }
        ],
        filterMenuInit: function (e) { e.container.addClass("widerMenu"); },
        dataBinding: function() { g_gridCounter = (this.dataSource.page() -1) * this.dataSource.pageSize(); }
    }, null);
}

function checkAll(ele) {
    var grid = $('#gridFiles').data('kendoGrid');
    var state = $(ele).is(':checked');
    $('.chkFormols').prop('checked', state == true);
}

function getSearchData(qv) {
    g_filterGrid = qv;
    var grid = $("#gridFiles").data("kendoGrid");
    if (grid)
        grid.dataSource.fetch();
}

function confirmSync() {
    confirmGridWindow({
        windowGridID: "#gridSync",
        windowID: "#dialogSync",
        srcGridID: "#gridFiles",
        srcSettings: {url: bars.config.urlContent("/api/pfu/filesgrid/sync")},
        grabData: [{key: "KF"}]
    });
    $('.chkFormolsAll').prop('checked', false);
}

function Sync() {
    openGridWindow({
        srcGridID: "#gridFiles",
        windowGridID: '#gridSync',
        windowID: '#dialogSync',
        srcDataSource: {schema: {
            model: {
                fields: {
                    KF: { type: "string" },
                    NAME: { type: "string"}
                }
            }
        }},
        srcSettings: {editable: false, columns: [
            {
                field: "NAME",
                title: "Назва філії",
                width: 220,
                attributes: {
                    style: "text-overflow: ellipsis; white-space: nowrap;"
                }
            }
        ]},
        grabData: [{key: 'KF', defaultValue: null}, {key: 'NAME', defaultValue: null}]
    });
}

function Search() {
    getSearchData({
        KF: NullOrValue($("#searchMFO").val()),
        CURSTATE: NullOrValue($("#searchStatus").val())
    });
}

function getStatusById(stateId) {
    var grid = $("#searchStatus").data("kendoDropDownList");
    var ds = grid.dataSource;
    return getNameById(stateId, ds._data, 'ID', 'NAME');
}

$(document).ready(function () {
    fillDropDownList("#searchStatus", {
        transport: {read: {url: bars.config.urlContent("/api/pfu/filesgrid/syncstatus")}},
        schema: {model: {fields: { ID: { type: "number" }, NAME: { type: "string" } }}}
    }, {
        value: INITIAL_SYNC_STATUS, dataTextField: "NAME", dataValueField: "ID"
    });

    InitGridWindow({windowID: "#dialogSync", srcSettings: {title: "Синхронізація ЄБП"}});
    initRegistersGrid({ KF: null, CURSTATE: null});

    $('#confirmBlock').click(confirmSync);
    $('#SyncBtn').click(Sync);
    $('#SearchBtn').click(Search);
    $(document.body).keydown(function (e) { if (e.keyCode == KEY_CODE_ENTER) {
        e.preventDefault(); // Stops IE from triggering the button to be clicked
        Search();
    } });
});

