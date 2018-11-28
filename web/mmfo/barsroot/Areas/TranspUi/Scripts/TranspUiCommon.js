﻿function isIE() {
    var myNav = navigator.userAgent.toLowerCase();
    return (myNav.indexOf('msie') != -1) ? parseInt(myNav.split('msie')[1]) : false;
}

function clearSelection() {
    try {
        if (window.getSelection) {
            if (window.getSelection().empty) {
                window.getSelection().empty();
            } else if (window.getSelection().removeAllRanges) {
                window.getSelection().removeAllRanges();
            }
        } else if (document.selection) {
            document.selection.empty();
        }
    } catch (e) {}
};

function getSelectedValue(grid, field) {

    if (!grid) {
        bars.ui.notify("Повідомлення", "Необхідно обрати один запис", 'error', { autoHideAfter: 5 * 1000 });
        return null;
    }

    var selected = grid.select();

    if (!selected || selected.length !== 1) {
        bars.ui.notify("Повідомлення", "Необхідно обрати один запис", 'info', { autoHideAfter: 5 * 1000 });
        return null;
    }

    var row = grid.dataItem(selected);
    return row !== null ? row[field] : null;
};

function changeGridMaxHeight() {
    var a1 = $(".k-grid-content").height();
    var a2 = $(".k-grid-content").offset();
    var a3 = $(document).height();
    var a4 = a3 - a2.top;

    $(".k-grid-content").css("max-height", a4 * 0.9);
};

function GridSettings(options) {
    if (options === undefined || options == null) options = {};

    options = $.extend(true,
        {
            dataSource: {},
            scrollable: true,
            reorderable: false,
            navigatable: true,
            sortable: {
                mode: "single",
                allowUnsort: true
            },
            selectable: "row",
            resizable: true,
            filterable: true,
            editable: false,
            noRecords: {
                template: '<hr class="modal-hr"/><b>Дані відсутні</b><hr class="modal-hr"/>'
            },
            pageable: {
                refresh: true,
                messages: {
                    empty: "Дані відсутні",
                    allPages: "Всі"
                },
                pageSizes: [20, 30, 50, 100, "All"],
                buttonCount: 5
            }
        }, options);

    return options;
};

function DataSourceSettings(options) {
    if (options === undefined || options == null) options = {};

    options = $.extend(true,
        {
            type: "webapi",
            transport: {
                read: {
                    type: "GET",
                    dataType: "json"
                }
            },
            schema: {
                data: "Data",
                total: "Total"
            },
            pageSize: 20,
            serverFiltering: true,
            serverPaging: true,
            serverSorting: true
        }, options);

    return options;
};

function WindowSettings(options) {
    if (options === undefined || options == null) options = {};

    options = $.extend(true,
        {
            actions: ["Maximize", "Close"],
            title: "",
            resizable: false,
            modal: true,
            draggable: true,
            width: "90%",
            height: "90%",
            refresh: function () {
                this.center();
            },
            deactivate: function () {
                bars.ui.loader(this, false);
                this.destroy();
            }
        }, options);

    return options;
};

function DropDownListSettings(options) {
    if (options === undefined || options == null) options = {};

    options = $.extend(true,
        {
            dataTextField: "text",
            dataValueField: "value",
            dataSource: {}

        }, options);

    return options;
};

function isEmpty(value) {
    return (value === undefined || value === null || value === '');
};

function onEscKeyUp(e) {
    if (e.keyCode == 27) {
        var visibleWindow = $(".k-window:visible > .k-window-content:last");
        if (visibleWindow.length)
            visibleWindow.data("kendoWindow").close();
    }
};

$(document).on('keyup', onEscKeyUp);