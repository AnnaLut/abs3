Sys.Application.add_load(function () {
    $('input[name$="tbFinishDate"]').live('change', function () { setInfo(); });
    setInfo();
});

function setInfo() {
    var bankdate = $('input[name$="tbFinishDate"]').val();
    $('#dvInfo').html('Друк на  <span style="color: green">' + bankdate + '</span> (кінцева дата інтервалу)');
}

function PrintReport(type) {
    var cb = $('input[name$="cbLikeBranch"]').prop("checked");
    var rb = $('input[name$="rblJTypes"]:checked').val();
    var branch = $('select[name$="ddJBranch"]').val();
    var bankdate = $('input[name$="tbFinishDate"]').val();
    if (cb) branch += "%";
    //alert(bankdate + "----" + branch ) ;
    PageMethods.PrintReport(bankdate, branch, rb, type, onPrintReport, CIM.onPMFailed);
}

function onPrintReport(res) {
    $("#ifDownload").remove();
    var iframe = $("<iframe id='ifDownload' src='/barsroot/cim/handler.ashx?action=download&file=" + res + "'></iframe>");
    iframe.hide();
    $('body').append(iframe);
}

function deleteRecord(docKind, docType, boundId, level) {
    if (level == "-1") {
    } else {
        docKind = 2;
        docType = 0;
        boundId = level;
    }
    PageMethods.DeleteJournalRecord(docKind, docType, boundId, CIM.reloadPage, CIM.onPMFailed);
}

function confirmAction(result, callFunc) {
    if (result) eval(callFunc);
}

function enumJournal() {
    core$ConfirmBox("Ви дійсно хочете перенумерувати усі журнали? Переміщення записів між типами журналів після цього буде неможливе.", "Перенумерація журналів", function (result) { confirmAction(result, "enumJournalCall()"); });
}

function enumJournalCall() {
    PageMethods.EnumJournal(CIM.reloadPage, CIM.onPMFailed);
}

function updateComment(ctrl, docKind, docType, boundId, level, docid) {
    var comment = ctrl.siblings('textarea').val();
    PageMethods.UpdateComment(comment, docKind, docType, boundId, level, CIM.reloadPage, CIM.onPMFailed);
}


