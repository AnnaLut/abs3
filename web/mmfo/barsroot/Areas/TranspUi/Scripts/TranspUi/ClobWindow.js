function clobWindow(data) {
    var windowOptions = {
        activate: onWindowActivate,
        title: "",
        overflow: "hidden",
        width: "50%",
        height: "50%",
        content: {
            template: kendo.template($("#clobWindowTemplate").html())
        }
    };

    function onWindowActivate() {
        window.find('#clob').val(data).end();           
    }

    var window = $("<div />").kendoWindow(WindowSettings(windowOptions));

    window.data("kendoWindow").center().open();
}