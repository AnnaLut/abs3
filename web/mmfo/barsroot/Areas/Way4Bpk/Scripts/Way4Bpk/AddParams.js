/**
 * Created by serhii.karchavets on 19-Sep-17.
 */


var g_params = ["BUS_MOD", "IFRS", "SPPI", "FLAGINSURANCE", "TYPEW", "NAMEW", "EDUCA", "EDRPO", "MEMB", 'FLAGINSURANCE', 'TYPEW', 'STAT', 'NREMO', 'REMO'];
//var ddls = ['FLAGINSURANCE', 'TYPEW', 'EDUCATION', 'STATUS'];
var ddls = [];
var numerics = [];
//var numerics = [
//    { name: 'NOREAL6MONTH', decimals: 4 },
//    { name: 'REAL6MONTH', decimals: 4 },
//    { name: 'MEMBERS', decimals: 0 }
//];
var gParamsExtended = {
    BUS_MOD: {
        id: 'BUS_MOD_ID',
        name: 'BUS_MOD_NAME'
    },
    IFRS: {
        id: 'IFRS_ID',
        name: 'IFRS_NAME'
    },
    SPPI: {
        id: 'SPPI_ID',
        name: 'SPPI_NAME'
    },
    EDUCATION: {
        id: 'KOD',
        name: 'TXT',
        handBookName: 'CIG_D07'
    }
};
var g_addParams = {};
var g_addParamsNew = {};

function check() {
    var changed = false;
    for (var k in g_addParamsNew) {
        $("#" + k + "_Tag").css('color', 'black');
        $("#" + k + "_Value").css('color', 'black');
        if (g_addParams[k] != g_addParamsNew[k]) {
            $("#" + k + "_Tag").css('color', 'red');
            $("#" + k + "_Value").css('color', 'red');
            changed = true;
        }
    }
    $("#AddParamsConfirmBtn").prop('disabled', !changed);
    if (changed) {
        $("#AddParamsMsg").show();
    }
    else {
        $("#AddParamsMsg").hide();
    }
}

function inputChange(that, regExp) {
    var val = that.value;
    if (regExp) {
        val = val.replace(regExp, '');
        that.value = val;
    }
    if (val == undefined || val == '')
        delete g_addParamsNew[that.id];
    else
        g_addParamsNew[that.id] = val;
    $("#" + that.id + "_Tag").text(val);

    check();
};

function showReferAddParams(id, clause) {
    var a = gParamsExtended[id], hbName = id;
    if (a.handBookName) {
        hbName = a.handBookName;
    }

    bars.ui.handBook(hbName, function (data) {
        g_addParamsNew[id] = data[0][a.name];
        $("#" + id + "_Tag").text(data[0][a.id]);
        $("#" + id + "_Value").text(data[0][a.name]);
        check();
    },
        {
            multiSelect: false,
            columns: a.id + ',' + a.name,
            clause: clause || ''
        });
}

function AddParamsConfirmBtn() {
    var grid = $('#gridMain').data("kendoGrid");
    var row = grid.dataItem(grid.select());
    var addParameters = { ND: row.ND, Params: [] };

    for (var k in g_addParamsNew) {
        if (g_addParams[k] != g_addParamsNew[k]) {
            addParameters.Params.push({ Tag: k, Value: g_addParamsNew[k] });
        }
    }
    WaitingForID(true, ".search-AddParams");
    AJAX({
        srcSettings: {
            url: bars.config.urlContent("/api/Way4Bpk/Way4Bpk/SetAddParameter"),
            success: function (data) {
                if (data['Params'].length > 0) {
                    //
                    for (var j = 0; j < data['Params'].length; j++) {
                        var err = "Не вдалось змінити дані для:" + data['Params'][j].Tag + " " + data['Params'][j].Value;
                        bars.ui.error({ title: 'Помилка', text: err });
                    }
                }
                else {
                    bars.ui.notify("До відома", "Дані успішно змінено", 'info', { autoHideAfter: 5 * 1000 });
                }
            },
            complete: function (jqXHR, textStatus) {
                WaitingForID(false, ".search-AddParams");
                openDialogAddParams();
                //$("#dialogAddParams").data('kendoWindow').close();
            }
            , data: JSON.stringify(addParameters)
        }
    });
}

function clear() {
    for (var i = 0; i < g_params.length; i++) {
        $("#" + g_params[i] + "_Tag").text("");
        $("#" + g_params[i] + "_Value").text("");
    }
    g_addParams = {};
    g_addParamsNew = {};
}

function openDialogAddParams() {
    $("#AddParamsConfirmBtn").prop('disabled', true);
    $("#AddParamsMsg").hide();
    clear();

    WaitingForID(true, ".search-AddParams");
    var grid = $('#gridMain').data("kendoGrid");
    var row = grid.dataItem(grid.select());
    AJAX({
        srcSettings: {
            url: bars.config.urlContent("/api/Way4Bpk/Way4Bpk/GetAddParams"),
            success: function (data) {
                if (!data || data.length === 0) {
                    return;
                }

                for (var i = 0; i < data.length; i++) {
                    var cur = data[i];
                    var comm = cur.Comm || '';

                    g_addParams[cur.Tag] = cur.Value;
                    g_addParamsNew[cur.Tag] = cur.Value;

                    $("#" + cur.Tag + "_Tag").text(cur.Value + ' ' + comm);
                }
                check();
            },
            complete: function (jqXHR, textStatus) { WaitingForID(false, ".search-AddParams"); }
            , data: JSON.stringify({ ND: row.ND })
        }
    });
}