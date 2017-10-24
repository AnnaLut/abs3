$(document).ready(function() {
    var confirmTabsDatasource = new kendo.data.DataSource({
        type: "aspnetmvc-ajax",
        pageSize: 20,
        serverPaging: true,
        serverFiltering: true,
        serverSorting: true,
        transport: {
            read: {
                type: "GET",
                dataType: "json",
                url: bars.config.urlContent("/admin/confirm/GetConfirmTabs"),
                success: function (elem) {

                },
                error: function (xhr, error) {
                    bars.ui.error({ text: "Сталася помилка при спробі завантажити дані.<br/>" + error });
                }
            }
        },
        schema: {
            data: "Data",
            total: "Total",
            model: {
                fields: {
                    ID: { type: "number" },
                    RESOURCE_CODE: { type: "string" },
                    RESOURCE_NAME: { type: "string" }
                }
            }
        }
    });

    $("#ConfirmWindow").kendoWindow({
        title: "Причина:",
        visible: false,
        width: "400px",
        //height: "300px",
        resizable: false,
        actions: ["Close"]
    });

    function confirmModel(tabId, approve, reject, comment) {
        return {
            id: tabId,
            approveList: approve,
            rejectList: reject,
            comment: comment
        }
    }

    function getCheckedItems(selector, tabId) {
        var grid = $(selector).data("kendoGrid"),
            checkedList = grid.tbody.find("input:checked"),
            i = 0,
            rejectList = [],
            approveList = [];
        if (checkedList.length > 0) {
            for (i; i < checkedList.length; i++) {
                if (checkedList[i].getAttribute("data-approveId") != null) {
                    approveList.push(checkedList[i].getAttribute("data-approveId"));
                } else if (checkedList[i].getAttribute("data-rejectId") != null) {
                    rejectList.push(checkedList[i].getAttribute("data-rejectId"));
                }
                var rej = rejectList.toString(),
                    app = approveList.toString();

                var window = $("#ConfirmWindow").data("kendoWindow");
                window.center();
                window.open();

                var box = $("#box"),
                    commTemplate = kendo.template($("#comment").html());
                box.html(commTemplate);

                $("#save").kendoButton({
                    click: function () {
                        alert("jhfgjhgjhgjh");
                        $("#ConfirmWindow").data("kendoWindow").close();
                        /*var model = confirmModel(tabId, app, rej, $('#comments').val());
                        $.ajax({
                            type: "GET",
                            url: bars.config.urlContent("/api/admin/confirm/"),
                            contentType: "application/json",
                            dataType: "json",
                            data: model, 
                            traditional: true
                        }).done(function (result) {
                            //bars.ui.alert({ text: result.message });
                            //$("#EditUserWindow").data("kendoWindow").close();
                            $("#ConfirmWindow").data("kendoWindow").close();
                            $(selector).data("kendoGrid").dataSource.read();
                        });*/
                    },
                    enable: true
                });

                $("#cencel").kendoButton({
                    click: function () {
                        $("#ConfirmWindow").data("kendoWindow").close();
                    },
                    enable: true
                });

            }
        } else {
            bars.ui.alert({ text: "Жодному, із наведених записів таблиці, не обрано статус доступу!" });
        }
        
    }

    $("#ConfirmTabstrip").kendoTabStrip({
        dataTextField: "RESOURCE_NAME",
        dataContentField: "RESOURCE_CODE",
        select: function (e) {
            var data = this.dataSource.at($(e.item).index()),
                div = $("#confirmResourcesTemplate").html(),
                template = kendo.template(div);

            $(e.contentElement).html(template(data));
            kendo.bind(e.contentElement, data);

            bars.tabs.initConfirmResourceGrid("#confirmResource" + data.RESOURCE_CODE + data.ID, data.ID);

            $("#SaveTab_" + data.ID).on("click", function () {
                getCheckedItems("#confirmResource" + data.RESOURCE_CODE + data.ID, data.ID);
            });
        },
        dataSource: confirmTabsDatasource
    });
});