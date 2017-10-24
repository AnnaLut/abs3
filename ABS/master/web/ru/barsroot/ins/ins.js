// константы
var DialogOptions = 'dialogHeight:400px; dialogWidth:800px; resizable:yes';

var TariffsUrl = '/barsroot/ins/tariffs.aspx';
var FeesUrl = '/barsroot/ins/fees.aspx';
var LimitsUrl = '/barsroot/ins/limits.aspx';
var ScansUrl = '/barsroot/ins/scans.aspx';
var AttrsUrl = '/barsroot/ins/attrs.aspx';
var BranchRnkUrl = '/barsroot/ins/branch_rnk.aspx?partner_id={0}';

// отображение диалогов
function ShowTariffs(Tariff_Ctrl) {
    var SelectedTariff = Tariff_Ctrl.selecteValue;
    var result = window.showModalDialog(TariffsUrl, null, DialogOptions);
    return (result ? result : false);
}
function ShowFees(Fee_Ctrl) {
    var SelectedFee = Fee_Ctrl.selecteValue;
    var result = window.showModalDialog(FeesUrl, null, DialogOptions);
    return (result ? result : false);
}
function ShowLimits(Limit_Ctrl) {
    var SelectedLimit = Limit_Ctrl.selecteValue;
    var result = window.showModalDialog(LimitsUrl, null, DialogOptions);
    return (result ? result : false);
}
function ShowScans(Scan_Ctrl) {
    var SelectedScan = Scan_Ctrl.selecteValue;
    var result = window.showModalDialog(ScansUrl, null, DialogOptions);
    return (result ? result : false);
}
function ShowAttrs(Attr_Ctrl) {
    var SelectedAttr = Attr_Ctrl.selecteValue;
    var result = window.showModalDialog(AttrsUrl, null, DialogOptions);
    return (result ? result : false);
}
function ShowBranchRnk(p_partner_id) {
    var result = window.showModalDialog(BranchRnkUrl.replace('{0}', p_partner_id), null, DialogOptions);
    return false;
}