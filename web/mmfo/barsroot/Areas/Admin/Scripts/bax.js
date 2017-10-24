$(document).ready(function () {
    $("#baxGrid").kendoGrid({
        columns: [
            {
                field: "USER_ID",
                title: "Код",
                width: 80
            },
            {
                field: "USER_TABNUM",
                title: "Табельний №",
                width: 90
            },
            {
                field: "USER_LOGNAME",
                title: "Логін",
                width: 120
            },
            {
                field: "USER_FIO",
                title: "ПІБ",
                width: 180
            },
            {
                field: "USER_CHECKIN",
                title: "Присутній",
                template: "#=(USER_CHECKIN > 0) ? '<div style=\"text-align:center;\"><span class=\"pf-icon pf-16 pf-ok\"></span></div>' : '<div style=\"text-align:center;\"><button class=\"k-button pass\">Пропустити</button></div>' #",
                width: 80
            },
            {
                field: "USER_CHECKDATE",
                title: "Прийшов/пішов",
                template: "<div style='text-align:right;'>#=USER_CHECKDATE == null ? '' : kendo.toString(USER_CHECKDATE,'dd/MM/yyyy HH:mm')#</div>",
                width: 80
            }
        ],
        sortable: true,
        resizable: true,
        filterable: true,
        selectable: "single",
        pageable: {
            refresh: true,
            pageSizes: true,
            buttonCount: 5
        },
        dataSource: {
            type: "webapi",
            transport: {
                read: {
                    url: bars.config.urlContent('/admin/bax/GetAllUsers')
                }
            },
            schema: {
                data: "Data",
                total: "Total",
                model: {
                    fields: {
                        USER_CHECKDATE: { type: "date" },
                        USER_CHECKIN: { type: "number" },
                        USER_ID: { type: "number" }
                    }
                }
            },
            serverPaging: true,
            serverSorting: true,
            serverFiltering: true,
            pageSize: 10
        }
    });

    $('#baxGrid').on('click', function (e) {
        if ($(e.target).hasClass('pass')) {
            var button = e.target;
            bars.ui.confirm({
                text: 'Ви дійсно бажаєте пропустити цього користувача?'
            }, function () {
                var row = $(button).parents('tr');
                var userId = row.children('td:first').text();

                $.post(bars.config.urlContent('/admin/bax/PostUserIncome'), { userid: userId }, function (data) {
                    if (data.result === "ok") {
                        $("#baxGrid").data("kendoGrid").dataSource.read();
                    } else {
                        bars.ui.error({ text: 'Помилка пропуску через прохідну! </br>' + data.message });
                    }
                });
            });
        }
    });


})
