// вызов окна для сканирования!
function showScannDialog(saveUrl, onResultFunc, buildObj) {
    var width = +$(window).width() - 30;
    var height = +$(window).height() - 30;
    var DialogOptions = 'dialogHeight:' + height + 'px; dialogWidth:' + width + 'px; scroll: yes';
    var DialogObject = { windowName: "DialogBills" };
    buildObj.ShowOverlay();
    var result = window.showModalDialog('/barsroot/bills/scan_docs.aspx?exp_id=0', DialogObject, DialogOptions);
    buildObj.HideOverlay();
    if (result != null) {
        if (result['SaveBtnEnabled'] == true)
            buildObj.SendPostRequest(saveUrl, null, onResultFunc);
    }
}