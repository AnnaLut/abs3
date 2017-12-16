/**
 * Created by serhii.karchavets on 19-Sep-17.
 */


var g_params = ["BUS_MOD", "IFRS", "SPPI"];
var g_addParams = {};
var g_addParamsNew = {};

function check() {
    var changed = false;
    for(var k in g_addParamsNew){
        $("#"+k+"_Tag").css('color', 'black');
        $("#"+k+"_Value").css('color', 'black');
        if(g_addParams[k] != g_addParamsNew[k]){
            $("#"+k+"_Tag").css('color', 'red');
            $("#"+k+"_Value").css('color', 'red');
            changed = true;
        }
    }
    $("#AddParamsConfirmBtn").prop('disabled', !changed);
    if(changed){
        $("#AddParamsMsg").show();
    }
    else{
        $("#AddParamsMsg").hide();
    }
}

function showReferAddParams(id) {
    bars.ui.handBook(id, function (data) {
            g_addParamsNew[id] = data[0][id+"_ID"];
            $("#"+id+"_Tag").text(data[0][id+"_ID"]);
            $("#"+id+"_Value").text(data[0][id+"_NAME"]);
            check();
        },
        {
            multiSelect: false,
            columns: id + "_ID," + id + "_NAME"
        });
}

function AddParamsConfirmBtn() {
    var grid = $('#gridMain').data("kendoGrid");
    var row = grid.dataItem(grid.select());
    var addParameters = {ND: row.ND, Params: []};

    for(var k in g_addParamsNew){
        if(g_addParams[k] != g_addParamsNew[k]){
            addParameters.Params.push({ Tag: k, Value: g_addParamsNew[k] });
        }
    }
    WaitingForID(true, ".search-AddParams");
    AJAX({ srcSettings: {
        url: bars.config.urlContent("/api/Way4Bpk/Way4Bpk/SetAddParameter"),
        success: function (data) {
            if(data['Params'].length > 0){
                //
                for(var j = 0; j < data['Params'].length; j++){
                    var err = "Не вдалось змінити дані для:" + data['Params'][j].Tag + " " + data['Params'][j].Value;
                    bars.ui.error({ title: 'Помилка', text: err });
                }
            }
            else{
                bars.ui.notify("До відома", "Дані успішно змінено", 'info', {autoHideAfter: 5*1000});
            }
        },
        complete: function(jqXHR, textStatus){
            WaitingForID(false, ".search-AddParams");
            openDialogAddParams();
            //$("#dialogAddParams").data('kendoWindow').close();
        }
        ,data: JSON.stringify(addParameters)
    } });
}

function clear() {
    for(var i = 0; i < g_params.length; i++){
        $("#"+g_params[i]+"_Tag").text("");
        $("#"+g_params[i]+"_Value").text("");
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
    AJAX({ srcSettings: {
        url: bars.config.urlContent("/api/Way4Bpk/Way4Bpk/GetAddParams"),
        success: function (data) {
            if(!data || data.length === 0){
                return;
            }

            WaitingForID(true, ".search-AddParams");
            AJAX({ srcSettings: {
                url: bars.config.urlContent("/api/Way4Bpk/Way4Bpk/GetAddParamValue"),
                success: function (req) {
                    for(var i = 0; i < req.length; i++){
                        g_addParams[req[i].Tag] = req[i].ID;
                        g_addParamsNew[req[i].Tag] = req[i].ID;
                        $("#"+req[i].Tag+"_Tag").text(req[i].ID);
                        $("#"+req[i].Tag+"_Value").text(req[i].NAME);
                    }
                    check();
                },
                complete: function(jqXHR, textStatus){WaitingForID(false, ".search-AddParams"); }
                ,data: JSON.stringify(data)
            } });

        },
        complete: function(jqXHR, textStatus){ WaitingForID(false, ".search-AddParams"); }
        ,data: JSON.stringify({ ND: row.ND })
    } });
}