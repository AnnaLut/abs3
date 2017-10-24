function returnServiceCode() {
    var sel = $(".selectedRow");
    if (!sel) return;
    window.returnVal = sel.find("td").html();
    parent.core$IframeBoxClose();
}
