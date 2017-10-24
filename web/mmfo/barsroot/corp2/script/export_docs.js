// Загрузка страницы
function pageLoad() {
    // инициализация окна процесса загрузки
    //$.ajaxCallHelper.init();

    $("input:submit, input:button, button").button();

    $(".ctrl-date").datepicker({
        changeMonth: true,
        changeYear: true,
        buttonImageOnly: true,
        buttonImage: "/Common/Images/default/16/calendar.png ",
        showButtonPanel: true,
        showOn: "button"
    });
}
