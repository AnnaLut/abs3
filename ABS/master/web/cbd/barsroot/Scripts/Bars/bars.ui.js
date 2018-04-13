if (!('bars' in window)) window['bars'] = {};
bars.ui = bars.ui || {};

bars.ui.dialog = function (options) {
    'use strict';
    var alertParams = $.extend(
    {
        id: 'barsUiAlertDialog',
        text: '',
        actions: ["Close"],
        title: '',
        winType: "",
        width: '400px',
        height: '400px',
        content: null,
        contentHtml: null,
        iframe: false,
        close: null,
        modal: true,
        position: 'center',
        resizable: true,
        buttons: null,
        visible: false,
        pinned: false,
        draggable: true,
        appendTo: 'body'
    }, options);
    //$('#' + options.id).remove();
    var alert = $('<div id="' + alertParams.id + '"></div>');
    if (alertParams.contentHtml) {
        alert.html(alertParams.contentHtml);
    }
    /*var alertParams1 = {
        animation: options.animation,
        actions: options.actions,
        draggable: options.draggable,
        height: options.height,
        width: options.width,
        visible: options.visible,
        modal: options.modal,
        pinned: options.pinned,
        resizable: options.resizable,
        title: options.title,
        position: options.position,
        iframe: options.iframe,
        close: options.close,
        append: options.append,
        deactivate: function() {
            if (options.deactivate) {
                options.deactivate.apply();
            }
            alert.data("kendoWindow").destroy();
            alert.remove();
        }
    };*/

    alertParams.deactivate = function () {
        if (options.deactivate) {
            options.deactivate.apply();
        }
        alert.data("kendoWindow").destroy();
        alert.remove();
    }

    if (options.content != null) {
        /*alertParams.content = options.content;
        alertParams.open = function() {
            //kendo.ui.progress(alert, true);            
        };
        alertParams.refresh = function () {
            //kendo.ui.progress(alert, false);
        }*/
    } else {
        if (options.winType) {
            var imgTemplate = '<div style="margin:0 5px 0 0;display:inline-block;background-repeat:no-repeat;width:24px;height:24px;background-image:url(/' + bars.config.appName + '/Content/images/PureFlat/24/Hot/{0}.png)"></div>';
            var img = '';
            switch (options.winType) {
            case 'error':
                img = String.format(imgTemplate, 'stop');
                break;
            case 'warning':
                img = String.format(imgTemplate, 'warning');
                break;
            case 'confirm':
                img = String.format(imgTemplate, 'help');
                break;
            case 'info':
            case 'success':
                img = String.format(imgTemplate, 'info');
                break;
            default:
                break;
            }
            options.text = '<table><tr><td valign=top >' + img + '</td><td>' + options.text + '</td></tr></table>';
        } 

        alert.html(options.text);
    }
    alert.appendTo($(alertParams.appendTo)).kendoWindow(alertParams);
    var buttonTemplate = '<button class="delete-confirm k-button" style="float:right;margin:7px 5px 7px 5px;">{0}</button>';
    var controls;
    if (options.buttons != null) {
        //debugger;
        controls = $('<div />', { 'class': 'k-content k-window-footer' }); //'<div class="k-header" style="padding:3px;overflow:auto;">';
        alert.parent().addClass('with-footer').append(controls);
        //debugger
        $.each(options.buttons,function(index,value) {
            var button = $(String.format(buttonTemplate, value.text));
            if (value.css) {
                button.css(value.css);
            }
            if (value["cssClass"]) {
                button.addClass(value["cssClass"]);
            }
            if (value.click) {
                button.on('click', function () {
                    value.click.apply(alert.data("kendoWindow"));
                });
            }
            controls.append(button);
        });

        /*for (var i = 0; i < options.buttons.length; i++) {
            var buttonParams = options.buttons[i];
            var button = $(String.format(buttonTemplate, buttonParams.text));
            if (buttonParams.css) {
                button.css(buttonParams.css);
            }
            if (buttonParams["cssClass"]) {
                button.addClass(buttonParams["cssClass"]);
            }
            if (buttonParams.click) {
                button.bind('click', function () {
                    buttonParams.click.apply(alert.data("kendoWindow"));
                });
            }
            //button.on('click', function () { alert.data("kendoWindow").close(); });
            controls.append(button);
        }*/
        //alert.parent().append(controls);
    }
    if (alertParams.position === 'center') {
        alert.data("kendoWindow").center();
    }
    alert.data("kendoWindow").open();        
    return alert;
}

bars.ui.alert = function(options) {
    options = $.extend(
    {
        id: 'barsUiAlertDialog',
        title: 'Повідомлення!',
        winType: 'info',
        width: '400px',
        height: '120px',
        buttons: [
        {
            text: '<span class="k-icon k-i-tick"></span> Ok',
            click: function () { this.close(); },
            cssClass: 'k-primary'
        }]
    }, options);
    return this.dialog(options);
}
bars.ui.error = function (options) {
    options = $.extend(
    {
        id: 'barsUiErrorDialog',
        title: 'Помилка!',
        winType: 'error'
    }, options);
    return this.alert(options);
}
bars.ui.success = function(options) {
    return this.alert(options);
}
bars.ui.confirm = function (options, func) {
    //для того щоб можна було func передавати в options
    if (func === undefined) {
        func = options.func;
    }
    options = $.extend(
    {
        id: 'barsUiConfirmDialog',
        title: 'Підтвердження!',
        winType: 'confirm',
        buttons: [
            {
                text: 'Відмінити',
                click: function () { this.close(); }
            },
            {
                text: '<span class="k-icon k-i-tick"></span> Ok',
                click: function () { if (func) {
                    func.apply();
                    this.close();
                } },
                cssClass: 'k-primary'
            }
        ]
    }, options);
    return this.alert(options);
}

bars.ui.handBook = function(tableName, func, options) {
    'use strict';
    var rnd = (Math.random() + '').split('.')[1];
    var windowId = 'handBookModalDialog' + rnd;
    var gridId = 'handBookGrid' + rnd;
    //var url = bars.config.urlContent('/reference/handbook/index/' + tableName + '?partial=true');

    var changeCheckRow = function (elem) {
        var $this = $(elem);
        var $thisTable = $('#' + gridId);
        if (!$thisTable.data('selected-row')) {
            $thisTable.data('selected-row',[]);
        }
        var num = -1;
        for (var i=0; i < $thisTable.data('selected-row').length; i++) {
            if ($thisTable.data('selected-row')[i].PrimaryKeyColumn === $this.val()) {
                num = i;
            }
        }

        if ($this.is(':checked')) {
            if (num === -1) {
                var gridData = $thisTable.data('kendoGrid');
                var tr = $this.parentsUntil('tr').parent();
                $thisTable.data('selected-row').push(gridData.dataItem(tr));
            }
        } else {
            if (num !== -1) {
                $thisTable.data('selected-row').splice(num, 1);
            }
        }
    }
    
    var handBookModel = {
        tableName: tableName,
        Columns: '',
        Clause: '',
        MultiSelect: false
    }

    if (options && options.multiSelect === true) {
        handBookModel.MultiSelect = true;
    }
    if (options && options.clause) {
        handBookModel.Clause = options.clause;
    }
    if (options && options.columns) {
        if (typeof options.columns === "string") {
            handBookModel.Columns = options.columns.split(',');
        }
    }

    var handBookGridOptions = {
        dataSource: {
            //type: 'aspnetmvc-ajax',
            type: 'webapi',
            transport: {
                read: bars.config.urlContent('/api/reference/handbook/') + handBookModel.tableName + '?clause=' + handBookModel.Clause
            },
            schema: {
                data: "Data",
                total: "Total",
                errors: "Errors",
                model: {
                    /*fields: {
                        checkRow: {type:'bool'},
                        Id: { type: "string" },
                        Name: { type: "string" }
                    }*/
                }
            },
            pageSize: 15,
            page: 1,
            total: 0,
            serverPaging: true,
            serverSorting: true,
            serverFiltering: true,
            serverGrouping: true,
            serverAggregates: true
        },
        height: 455,
        selectable: "multiple",
        //change: onArchiversGridRowSelect,
        groupable: false,
        sortable: true,
        resizable: true,
        filterable: true,
        scrollable: true,
        pageable: {
            previousNext: false,
            info: false,
            refresh: true,
            pageSizes: [15, 25, 50, 100],
            buttonCount: 1,
            messages: {
                itemsPerPage: ''
            }
        },
        dataBound: function (e) {
            if (e.sender.dataSource.total() === 0) {
                var colCount = e.sender.columns.length;
                $(e.sender.wrapper)
                    .find('tbody')
                    .append('<tr class="kendo-data-row"><td colspan="' + colCount + '" class="no-data">' + e.sender.pager.options.messages.empty + ' :(</td></tr>');
            }
            if (handBookModel.MultiSelect === true) {
                var grid = $(e.sender.wrapper);
                grid.find('#handBookSelectAll' + rnd).prop("checked", false);

                var selector = '';
                var tableArray = grid.data('selected-row');
                if (!tableArray) {
                    tableArray = [];
                }

                for (var i = 0; i < tableArray.length; i++) {
                    if (selector !== '') selector += ',';
                    selector += 'input[type="checkbox"][name="checkRow"][value="' + tableArray[i].PrimaryKeyColumn + '"]';
                }
                grid.find(selector).prop("checked", true);
            }
        }//,
        //columns:columns
    }
    var selectGridData = function () {
        if (func) {
            var result = [];
            //var selectedRow = $('#handBookGrid').find('tbody input[name="checkRow"]:checked');
            var dataSelectedRow = $('#' + gridId).data('selected-row');
            if (/*selectedRow.length != 0*/dataSelectedRow) {
                result = dataSelectedRow; /*selectedRow.map(function () {
                                var tr = $(this).parentsUntil('tr').parent();
                                return gridData.dataItem(tr);
                            }).get();*/
            } else {
                var gridData = $('#' + gridId).data('kendoGrid');
                var selectedRow = gridData.dataItem(gridData.select());
                if (selectedRow) {
                    //result = selectedRow;
                    result[0] = selectedRow;
                }
            }

            func.call(null, result);

            $('#' + windowId).data('kendoWindow').close();
            //this.close();
        }
    }
    var getHandBookMetadata = function () {
        var grid = $('#' + gridId);
        var metadataUrl = '/reference/handbookmetadata/getstructure/?id=' + handBookModel.tableName;

        if (handBookModel.Columns) {
            for (var i = 0; i < handBookModel.Columns.length; i++) {
                metadataUrl = metadataUrl + '&columns=' + handBookModel.Columns[i];
            }
        }
        $.get(bars.config.urlContent(metadataUrl), function (request) {
            if (request.Fields === null) {
                grid.html('<div class="alert alert-danger">\
                            <i class="fa fa-exclamation-triangle"></i>\
                            Опис довідника не знайдено, або до нього відсутній доступ!\
                           </div>');
            } else {
                grid.parentsUntil('.k-window').parent().find('.k-window-title').html('Довідник: <b>' + request.Semantic + '</b>');

                handBookGridOptions.dataSource.schema.model.fields = request.Fields;
                handBookGridOptions.columns = request.Columns;
                if (handBookModel.MultiSelect === true) {
                    handBookGridOptions.columns.splice(0, 0, {
                        field: "checkRow",
                        title: '<input name=checkRow class=checkRow id=handBookSelectAll' + rnd + ' type=checkbox />',
                        width: '30px',
                        template: "<input name='checkRow'  class='checkRow' type='checkbox' value='#= PrimaryKeyColumn #' />",
                        filterable: false,
                        sortable: false
                    });
                }

                grid.kendoGrid(handBookGridOptions);

                if (handBookModel.MultiSelect === true) {
                    grid.find('#handBookSelectAll' + rnd).on('change', function() {
                        var checkedRows = grid.find('input[type="checkbox"][name="checkRow"]');
                        var $this = $(this);
                        if ($this.is(':checked')) {
                            checkedRows.prop("checked", true);
                        } else {
                            checkedRows.prop("checked", false);
                        }
                        for (var i = 0; i < checkedRows.length; i++) {
                            changeCheckRow(checkedRows[i]);
                        }
                    });
                    grid.on('change', 'input[name="checkRow"]', function() {
                        changeCheckRow(this);
                    });
                }

                grid.on("dblclick", "tr.k-state-selected", function () {
                    selectGridData();
                    // insert code here
                });
            }

        });
    };

    var target ={
        id: windowId,
        title: 'Довідник',
        width: '600px',
        height: '480px',
        iframe: false,
        //content: url,
        activate: function() {
            getHandBookMetadata();
        }, 
        text: '<div id="' + gridId + '" class="slim-row"></div>',
        buttons: [
            {
                text: 'Відмінити',
                click: function () {
                    this.close();
                }
            }, {
                text: '<span class="k-icon k-i-tick" ></span> Вибрати',
                click: selectGridData/*function () {
                    if (func) {
                        var result = []; 
                        //var selectedRow = $('#handBookGrid').find('tbody input[name="checkRow"]:checked');
                        var dataSelectedRow = $('#' + gridId).data('selected-row');
                        if (/*selectedRow.length != 0* /dataSelectedRow) {
                            result = dataSelectedRow; /*selectedRow.map(function () {
                                var tr = $(this).parentsUntil('tr').parent();
                                return gridData.dataItem(tr);
                            }).get();* /
                        } else {
                            var gridData = $('#' + gridId).data('kendoGrid');
                            var selectedRow = gridData.dataItem(gridData.select());
                            if (selectedRow) {
                                result[0] = selectedRow;
                            } 
                        }

                        func.call(null, result);

                        this.close();
                    }
                }*/,
                cssClass: 'k-primary'
            }
        ]
    }
    options = $.extend(target, options);

    /*if (options.multiSelect == true) {
        options.content = url + '&multiSelect=true';
    }
    if (options.clause) {
        options.content = options.content + '&clause=' + options.clause;
    }
    if (options.columns) {
        if (typeof options.columns === "string")
            options.columns = options.columns.split(',');
        for (var i= 0;i< options.columns.length; i++) {
            options.content = options.content + '&columns=' + options.columns[i] ;            
        }

    }*/

    return this.dialog(options);
};

bars.ui._onShowNotifyByCenter = function(e) {
    if (!$("." + e.sender._guid)[1]) {
        var element = e.element.parent(),
          eWidth = element.width(),
          eHeight = element.height(),
          wWidth = $(window).width(),
          wHeight = $(window).height(),
          newTop,
          newLeft;
        newLeft = Math.floor(wWidth / 2 - eWidth / 2);
        newTop = Math.floor(wHeight / 2 - eHeight / 2);
        e.element.parent().css({ top: newTop, left: newLeft });
    }
};

bars.ui.notify = function (title, text, type, options) {
    var $this = this;
    var popup = $('#kendoUiPopup');
    if (popup.length === 0) {
        popup = $('<div />', { id: 'kendoUiPopup' });
        popup.append('body');
    }
    options = $.extend({
        position: {
            pinned: true,
            top: 30,
            right: 30
        },
        stacking: "down",
        hide: function() { popup.remove(); },
        autoHideAfter: 40000,
        width: '350px',
        templates: [
            {
                type: type,
                template: '<div style="padding:5px 10px 0px 10px;">\
                     <div class="k-notification-wrap"><h3 style="margin-top:0"><span class="k-icon k-i-note">icon</span> #= title #</h3><span class="k-icon k-i-close">Hide</span></div>'+
                        (text === '' ?'': '<p>#= message #</p>')+
                    '</div>'
            }
        ],
        button: true
    },options);
    if (options.position === 'center') {
        options.show = $this._onShowNotifyByCenter;
    }
    popup.kendoNotification(options).data("kendoNotification").show({
        title: title,
        message: text
    }, type);
}

bars.ui.loader = function (selector, toggle) {
    var object;
    if (typeof selector === 'string') {
        object = $(selector);
    } else if (selector instanceof jQuery) {
        object = selector;
    } else if (selector.element) {
        object = selector.element;
    } else {
        object = selector;
    }
    
    if (toggle === undefined || toggle === true) {
        kendo.ui.progress(object, true);
    } else {
        if (selector === 'body') {
            kendo.ui.progress(object, false);
        } else {
            object.children('.k-loading-mask').remove();
        }
    }
}

