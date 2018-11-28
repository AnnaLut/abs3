// выбор клиента по рнк!
function choose(rnk)
{
    window.parent.$('#createCustomersWindow').closest(".k-window-content").data("kendoWindow").close();
    window.parent.fillClientFields(rnk);
}
// отображение кнопок подтверждения клиента
function confirmButton(rnk) {
    return "<div style='text-align:center;'><a class='k-button k-primary' onclick='choose(" + rnk + ")'>Вибрати</a></div>";
}

// скрытие затемнения
function loaded() {
    if ($('.k-overlay').length)
        $('.k-overlay').remove();
}

// наложение затемнения
function started() {
    if (!$('.k-overlay').length)
    $("<div class='k-overlay'></div>").appendTo($(document.body));
}