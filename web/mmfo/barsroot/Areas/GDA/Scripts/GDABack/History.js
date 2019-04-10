var firstLoad = true;

$(document).ready(function () {
    $("#dateFrom").kendoDatePicker({
        format: "dd.MM.yyyy",
    });

    $("#dateTo").kendoDatePicker({
        format: "dd.MM.yyyy",
    });
});

function DataBound() {
    if (firstLoad) {
        filterDate();
        firstLoad = false;
    };
}

function formatDateOperationTemplate(item) {
    if (!item.SYS_TIME)
        return "";

    if (item.SYS_TIME.getFullYear() < 1900)
        return "";

    var month = item.SYS_TIME.getMonth() + 1;
    month = month.toString().length > 1 ? month : '0' + month;

    var day = item.SYS_TIME.getDate().toString();
    day = day.length > 1 ? day : '0' + day;

    var hours = item.SYS_TIME.getHours().toString();
    hours = hours.length > 1 ? hours : '0' + hours;

    var minutes = item.SYS_TIME.getMinutes().toString();
    minutes = minutes.length > 1 ? minutes : '0' + minutes;

    return day + "." + month + "." + item.SYS_TIME.getFullYear() + " " + hours + ":" + minutes;
}

function filterDate() {
    var dateFromStr = $("#dateFrom").val();
    var dateToStr = $("#dateTo").val();

    var dateFrom = dateFromStr.substring(3, 5) + '/' + dateFromStr.substring(0, 2) + '/' + dateFromStr.substring(6, 10);
    var dateTo = dateToStr.substring(3, 5) + '/' + dateToStr.substring(0, 2) + '/' + dateToStr.substring(6, 10);
    dateTo += " 23:59"; 

    var filter = {
        logic: "and",
        filters: [
            { field: "SYS_TIME", operator: "gte", value: dateFrom },
            { field: "SYS_TIME", operator: "lte", value: dateTo }
        ]
    };

    var grid = $('#grid').data().kendoGrid;
    grid.dataSource.filter(filter);

}