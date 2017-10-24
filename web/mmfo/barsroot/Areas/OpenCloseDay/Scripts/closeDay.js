$(document).ready(function () {
    var closeWindow = $("#windowClose"),
        undoClose = $("#undo");

    undoClose.click(function () {
        closeWindow.data("kendoWindow").open();
        undoClose.fadeOut();
    });

    function onClose() {
        undo.fadeIn();
    }
    closeWindow.kendoWindow({
        width: "300px",
        height: "200px",
        title: "Закриття банківського дня",
        visible: false,
        resizable: false,
        actions: [
            "Close"
        ],
        close: onClose
    }).data("kendoWindow").center().open();

   
});