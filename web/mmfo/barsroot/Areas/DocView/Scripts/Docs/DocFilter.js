$(document).ready(function () {
    $("#currentDate").text("Поточна дата: " + kendo.toString(kendo.parseDate(new Date()), 'dd.MM.yyyy'));

    function formatDotDate(date) {
        return date.getDate() + '.' + date.getMonth() + '.' + date.getFullYear();
    };

    function addDays(dateObj, numDays) {
        dateObj.setDate(dateObj.getDate() + numDays);
        return dateObj;
    }

    $("#dateNewBegin").kendoDatePicker({
        format: "dd.MM.yyyy",
        value: kendo.toString(kendo.parseDate(addDays(new Date(), -7)), 'dd.MM.yyyy')
    });
    $("#dateNewEnd").kendoDatePicker({
        format: "dd.MM.yyyy",
        value: kendo.toString(kendo.parseDate(new Date()), 'dd.MM.yyyy')
    });


    switch(parseInt($("#docType").text())){
        case 0:
            $("#docTypeName").text("Документи відділення");
            break;
        case 1:
            $("#docTypeName").text("Документи користувача");
            break;
        case 2:
            $("#docTypeName").text("Документи за доступними рахунками");
            break;
        case 3:
            $("#docTypeName").text("Документи відділення");
            break;
        default: alert("Невірні параметри");
    }


    function incrMonth(string_date) {
        var strArr = string_date.split(".");
        strArr[1] = String(parseInt(strArr[1]) + 1);
        return strArr.join(".");
    };
    $("#docsBtnDateAll").click(function () {
        var type = $("#docType").text();
        var redir_href = window.location.href.split("/")[0]+"//"
            + $(location).attr('href').split("/").slice(2, 4).join("/")
            + "/documentsview/documents.aspx?type=" + String(type) + "&par=11";
        window.location.replace(redir_href);
    });
    $("#docsBtnDateGet").click(function () {
        var type = $("#docType").text();
        var redir_href = window.location.href.split("/")[0]+"//"
            + $(location).attr('href').split("/").slice(2, 4).join("/")
            + "/documentsview/documents.aspx?type=" + String(type) + "&par=12";
        window.location.replace(redir_href);
    });


    $("#docsBtnFiltDateAll").click(function () {
        Link2DocList("lnk_showAllalldat");
    });
    $("#docsBtnFiltDateGet").click(function () {
        Link2DocListCurr("lnk_showAllResalldat");
    });

    function Link2DocList(lnk) {
        var type = $("#docType").text();
        var dateFr = incrMonth(formatDotDate($("#dateNewBegin").data("kendoDatePicker").value()));
        var dateTo = incrMonth(formatDotDate($("#dateNewEnd").data("kendoDatePicker").value()));
        var redir_href = window.location.href.split("/")[0]+"//"
            + $(location).attr('href').split("/").slice(2, 4).join("/")
            + "/documentsview/documents.aspx?type=" + String(type) + "&par=21"
            // + "documents.aspx?type=1&par=22"
            + "&dateb=" + dateFr
            + "&datef=" + dateTo;
        window.location.replace(redir_href);
    };

    function Link2DocListCurr(lnk) {
        var type = $("#docType").text();
        var dateFr = incrMonth(formatDotDate($("#dateNewBegin").data("kendoDatePicker").value()));
        var dateTo = incrMonth(formatDotDate($("#dateNewEnd").data("kendoDatePicker").value()));
        var redir_href = window.location.href.split("/")[0]+"//"
            + $(location).attr('href').split("/").slice(2, 4).join("/")
            + "/documentsview/documents.aspx?type=" + String(type) + "&par=22"
            + "&dateb=" + dateFr
            + "&datef=" + dateTo;
        window.location.replace(redir_href);
    };
});
