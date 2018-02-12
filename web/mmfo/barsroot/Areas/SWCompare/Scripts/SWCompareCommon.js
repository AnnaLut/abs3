function onEscKeyUp(e) {
    if (e.keyCode == 27) {
        var visibleWindow = $(".k-window:visible > .k-window-content:last");
        if (visibleWindow.length)
            visibleWindow.data("kendoWindow").close();
    }
};

function onEnterKeyUp(e) {
    if (e.keyCode == 13) {
        var visibleWindow = $(".k-window:visible > .k-window-content:last");
        if (visibleWindow.length)
            visibleWindow.find("#btnSave").click();
    }
};

function isEmpty(value) {
    return (value === undefined || value === null || value === '');
};

$(document).on('keyup', onEscKeyUp);
$(document).on('keyup', onEnterKeyUp);

$(document).ready(function () {
    $("#title").html("Протокол розбіжностей електронних переказів");
    initDatePicker();
    gridStart();
    //initMainGrid();
    //registerButtonsEvents();    
});