
$(document).ready(function () {

    $("#Toolbar").kendoToolBar({
        items: [
            {
                template: "<button id='pbGoBack' type='button' class='k-button' onclick='goBack()' title='Повернутись до переліку файлів'><i class='pf-icon pf-16 pf-arrow_left'></i> Назад</button>"
            }
        ]
    });

   
    loadPercentFormTemplate();
    var gridBalance = objectBox.gridBalanceRef;

    $("#btnFilter").kendoButton();

    function onCloseFilterAccounts(gridBalance) {
        gridBalance.dataSource.read();
    };

    $("#wFilterAccounts").kendoWindow({
        title: "Рахунки, доступні користувачу на перегляд",
        visible: false,
        width: "800px",
        resizable: false,
        close: onCloseFilterAccounts(gridBalance),
        actions: ["Close"]
    });

    // Percent calculation module ===================================================================================================================================================================
    

    


    // ===============================================================================================================================================================================================

});