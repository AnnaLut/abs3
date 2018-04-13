if (!('bars' in window)) window['bars'] = {};
bars.sepfiles = bars.sepfiles || {
    sepFilesGrid: null,
    sepGridBinded: false,
    ourSab: "",
    datesDropDownBinded: false,
    currenciesDropDownBinded: false,
    banksDropDownBinded: false,
    accessFlags: '',
    fullAccess: false,
    initFilter: null,
    initRequest: null,
    currentBpReason: null,
    numberFormat:  '#,###.00',

    sepDatesDs: new kendo.data.DataSource({
        transport: {
            read: {
                url: bars.config.urlContent('/api/sep/workdates')
            }
        }
    }),

    currListDs:  new kendo.data.DataSource({
        transport: {
            read: {
                url: bars.config.urlContent('/api/kernel/currency')
            }
        },
        schema: {
            data: "Data",
            total: "Total",
            errors: "Errors"
        },
        type: 'webapi',
        serverFiltering: true,
        serverSorting: true,
        sort: [
            {field: "IsUaHrivna", dir: "desc"},
            {field: "LCV", dir: "asc"}
        ],
        filter: {field: "SV", operator: "neq", value: "null"}
    }),

    bankListDs: new kendo.data.DataSource({
        transport: {
            read: {
                url: bars.config.urlContent('/api/kernel/bank')
            }
        }
    }),

    sepGrid: function () {
        if (this.sepFilesGrid == null) {
            this.sepFilesGrid = $('#sepFilesGrid').data('kendoGrid');
        }
        return this.sepFilesGrid;
    },

    refreshGrid: function () {
        if (bars.sepfiles.sepGridBinded) {
            var grid = bars.sepfiles.sepGrid();
            //отключение колонки код ошибки для входящих
            /*
            if (incomingPushed()) {
                grid.hideColumn("ErrorCode");
            } else {
                grid.showColumn(8);
            }*/

            grid.dataSource.read();
            grid.refresh();
        }
    },

    refreshSepFileMask: function () {
        var self = bars.sepfiles;
        var aDate = kendo.parseDate(self.getSelectedDate(), "dd-MM-yyyy");
        var bankList = $('#bankDropDown').data('kendoDropDownList');
        var sab = '';
        if (bankList.selectedIndex > 0) {
            sab = bankList.dataItems()[bankList.selectedIndex - 1].Sab;
        }
        var fileMask = self.getSepFileMask(aDate, sab);
        $('#sepFileNameMask').val(fileMask);
        self.refreshGrid();
    },


    //формирует маску файла СЕП в зависимости от даты
    getSepFileMask:  function(date, sab) {
        var monthChar = bars.utils.sep.getCharForDigit(date.getMonth() + 1);
        var dayChar = bars.utils.sep.getCharForDigit(date.getDate());
        return '*' + sab + monthChar + dayChar + '????';
    },

    refreshToolbar: function () {
        var self = bars.sepfiles;
        var incoming = self.incomingPushed();
        var grid = self.sepGrid();
        var currentRowData = null;

        if (grid.select().length > 0) {
            currentRowData = grid.dataItem(grid.select());
        }

        //аналог ShowButt(4) в центуре
        function showButton4() {
            return grid != null &&
                currentRowData != null &&
                currentRowData.OTM === 0 &&
                (
                    currentRowData.FN.substring(1, 6) === "B" + self.ourSab ||
                        currentRowData.FN.substring(8, 9) === ":" &&
                        currentRowData.FN.substring(2, 6) !== self.ourSab
                );
        }
        function showButton3() {
            return !incoming && //только для исходящих
                grid != null &&
                currentRowData != null &&
                 (currentRowData.OTM === 3 ||
                 (currentRowData.OTM === 1 || currentRowData.OTM === 2) && currentRowData.K_ER != null);
        }


        function showButton1() {
            return grid != null &&
                currentRowData != null &&
                ((currentRowData.OTM === 0 && currentRowData.FN.substring(1, 6) === "B" + self.ourSab && incoming) ||
                (currentRowData.OTM > 0 && currentRowData.OTM < 5 && !incoming));
        }

        bars.utils.sep.enableButton('pbUnCreate', !incoming && currentRowData != null && currentRowData.OTM > 0 && currentRowData.OTM < 3);
        bars.utils.sep.enableButton('pbDel', self.fullAccess && self.accessFlags.substring(0, 1) === "1" && showButton4());
        bars.utils.sep.enableButton('pbNewCreate', self.fullAccess && self.accessFlags.substring(2, 3) === "1" && showButton3());
        bars.utils.sep.enableButton('pbOk', self.fullAccess && self.accessFlags.substring(3, 4) === "1" && showButton1());
        bars.utils.sep.enableButton('pbDocs', currentRowData != null);
        bars.utils.sep.enableButton('pbSave', false);
    },

    getSelectedDate: function () {
        var selectedDate = $('#sepDateDropDown').data('kendoDropDownList');
        return selectedDate.dataItems()[selectedDate.selectedIndex];
    },

    incomingPushed: function () {
        return $('#incomingFilesRadioBtn.k-state-active').length > 0;
    },

    sepFilesData: function () {
        var self = bars.sepfiles;
        var startFilter = self.initFilter;
        if (startFilter != null) {
            $('#sepDateDropDown').data('kendoDropDownList').select(function(dataItem) {
                return dataItem === startFilter.fileDate;
            });
            $('#sepFileNameMask').val(startFilter.fileNameMask);
            $('#currencyDropDown').data('kendoDropDownList').select(function(dataItem) {
                return dataItem.lcv === startFilter.currency;
            });
            var toolBar = $('#sepToolBar2').data('kendoToolBar');
            if (!startFilter.isMatched) {
                toolBar.toggle('#notMatchedFiles', !startFilter.isMatched);
            }
            if (!startFilter.incoming) {
                toolBar.toggle('#notIsIncomingFilesRadioBtn', startFilter.incoming);
            }
            self.initFilter = null;
            }
    return {
        fileNameMask: $('#sepFileNameMask').val(),
        fileDate: self.getSelectedDate(),
        isMatched: $('#matchedFiles.k-state-active').length > 0,
        incoming: self.incomingPushed(),
        currency: self.getSelectedCurrecny()
        }
    },

    getSelectedCurrecny: function () {
        var selectedcurrency = $('#currencyDropDown').data('kendoDropDownList');
        if (selectedcurrency.selectedIndex > 0) {
            return selectedcurrency.dataItems()[selectedcurrency.selectedIndex - 1].LCV;
        } else {
            return '*';
        }
    },

    openSepDocs: function () {
        var self = bars.sepfiles;
        var grid = self.sepGrid();
        var record = grid.dataItem(grid.select());
        self.openFileDocs(record);
    },

    openFileDocs: function (fileRow) {
        var self = bars.sepfiles;
        var docParams = {
            isIncoming: self.incomingPushed(),
            fileName: fileRow.FN,
            fileCreated: kendo.toString(fileRow.DAT, "dd/MM/yyyy HH:mm"),
            accessFlags: self.accessFlags,
            mode: self.fullAccess ? "RW" : "RO"
        };
        window.location = bars.config.urlContent('/Sep/SepDocuments?') + jQuery.param(docParams);
    },

    recreateSepFile: function () {
        var grid = bars.sepfiles.sepGrid();
        var record = grid.dataItem(grid.select());
        var docParams = {
            fileName: record.FN,
            fileCreated: kendo.toString(record.DAT, "dd/MM/yyyy HH:mm")
        }
        $.get(bars.config.urlContent('/Sep/SepFiles/Recreate'), docParams).done(function (data) {
            if (data.status == 'ok') {
                bars.sepfiles.refreshGrid();
                bars.ui.alert({ text: data.message });
            } else {
                bars.ui.error({ text: data.message });
            }
        });
    },

    openSepDocsByDblClick: function () {
        var self = bars.sepfiles;
        var grid = self.sepGrid();
        var record = grid.dataItem($(this));
        self.openFileDocs(record);
    },

    toolsAfterBind: function () {
        var self = bars.sepfiles;
        if (self.datesDropDownBinded && self.currenciesDropDownBinded && self.banksDropDownBinded) {
            self.refreshSepFileMask();
            $('#bpReasonsGrid').kendoGrid({
                selectable: "single",
                columns:[
                    {
                        field: "ID",
                        title: "Код",
                        width: 80
                    },
                    {
                        field: "REASON",
                        title: "Найменування причини",
                        widnh: 250
                    }
                ],
                dataSource: {
                    transport: {
                        read: {
                            dataType: 'json',
                            url: bars.config.urlContent('/api/bpreasons')
                        }
                    }
                },
                change: function() {
                    self.currentBpReason = this.dataItem(this.select()).ID;
                    if (self.currentBpReason) {
                        bars.utils.sep.enableButton('selectBpReason');
                    }
                }
            });

            $("#sepFilesGrid").kendoGrid({
                columns: [
                    {
                        field: "FN",
                        title: "Назва файлу",
                        width: 100
                    },
                    {
                        field: "LCV",
                        title: "Валюта",
                        width: 50,
                        headerAttributes: {
                            style: "white-space: normal;"
                        }
                    },
                    {
                        field: "DAT",
                        title: "Дата/час створення файлу",
                        template: "<div style='text-align:right;'>#=kendo.toString(DAT,'dd/MM/yyyy HH:mm')#</div>",
                        headerAttributes: {
                            style: "white-space: normal;"
                        },
                        width: 100
                    },
                    {
                        field: "SDE",
                        title: "Сума (дебет)",
                        template: "<div style='text-align:right;'>#=kendo.toString((SDE / 100), self.numberFormat)#</div>",
                        width: 100,
                        footerTemplate: "<div style='text-align:right;'>#=kendo.toString((sum/100), self.numberFormat)#</div>"
                    },
                    {
                        field: "SKR",
                        title: "Сума (кредит)",
                        template: "<div style='text-align:right;'>#=kendo.toString((SKR/100), self.numberFormat)#</div>",
                        width: 100,
                        footerTemplate: "<div style='text-align:right;'>#=kendo.toString((sum/100), self.numberFormat)#</div>"
                    },
                    {
                        field: "N",
                        title: "К-сть інф. стрічок",
                        width: 75,
                        template: "<div style='text-align:right;'>#=N#</div>",
                        headerAttributes: {
                            style: "white-space: normal;"
                        },
                        footerTemplate: "<div style='text-align:right;'>#=sum#</div>"
                    },
                    {
                        field: "OTM",
                        title: "Ознака оплати",
                        width: 50,
                        headerAttributes: {
                            style: "white-space: normal;"
                        }
                    },
                    {
                        field: "DATK",
                        title: "Дата/час платежу",
                        template: "<div style='text-align:right;'>#=DATK == null ? '' : kendo.toString(DATK,'dd/MM/yyyy HH:mm')#</div>",
                        width: 100
                    },
                    {
                        field: "K_ER",
                        title: "Код блк",
                        width: 50,
                        headerAttributes: {
                            style: "white-space: normal;"
                        }
                    }
                ],
                dataSource: {
                    type: "aspnetmvc-ajax",
                    sort: {
                        field: "FN",
                        dir: "asc"
                    },
                    transport: {
                        read: {
                            dataType: 'json',
                            url: bars.config.urlContent('/sep/SepFiles/GetSepFilesList'),
                            data: self.sepFilesData
                        }
                    },
                    schema: {
                        data: "Data",
                        total: "Total",
                        errors: "Errors",
                        model: {
                            fields: {
                                FN: { type: "string" },
                                LCV: { type: "string" },
                                DAT: { type: "date" },
                                SDE: { type: "number" },
                                SKR: { type: "number" },
                                N: { type: "number" },
                                OTM: { type: "number" },
                                DATK: { type: "date" },
                                K_ER: {type: "number"}
                            }
                        }
                    },
                    aggregate: [{ field: "SDE", aggregate: "sum" },
                                { field: "SKR", aggregate: "sum" },
                                { field: "N", aggregate: "sum" }],
                    serverPaging: true,
                    serverSorting: true,
                    serverFiltering: true,
                    pageSize: self.initRequest == null ? 10 : self.initRequest.pageSize
                },
                sortable: true,
                resizable: true,
                filterable: true,
                selectable: "single",
                pageable: {
                    refresh: true,
                    pageSizes: true,
                    buttonCount: 5
                },
                change: self.refreshToolbar,
                dataBound: self.refreshToolbar
            });
            
            if (self.initRequest != null) {
                var dataSource = $('#sepFilesGrid').data('kendoGrid').dataSource;
                dataSource.query({
                    page: self.initRequest.page,
                    group: dataSource.group(),
                    filter: dataSource.filter(),
                    sort: dataSource.sort(),
                    pageSize: dataSource.pageSize(),
                    aggregate: dataSource.aggregate()
                });
                self.initRequest = null;
            }
            self.sepGridBinded = true;
        }
    },

    matchSepFile: function () {
        var self = bars.sepfiles;
        bars.ui.confirm({ text: 'Це може призвести до розбіжностей $Z та ЦОСЕП та блокування БАНКу. <br> Сквитувати файл?' },
            function() {
                var grid = self.sepGrid();
                var record = grid.dataItem(grid.select());
                var docParams = {
                    fileName: record.FN,
                    fileCreated: kendo.toString(record.DAT, "dd/MM/yyyy HH:mm"),
                    debitSum: record.DebitSum * 100,
                    kreditSum: record.KreditSum * 100,
                    rowCount: record.RowCount
                }
                $.get(bars.config.urlContent('/Sep/SepFiles/MatchSepFile'), docParams).done(function(data) {
                    if (data.status == 'ok') {
                        self.refreshGrid();
                        bars.ui.alert({ text: data.message });
                    } else {
                        bars.ui.error({ title: "Помилка квитовки файлу!", text: data.message });
                    }
                });
            });
    },

    unCreateSepFile: function () {
        bars.ui.confirm({ text: 'Це може призвести до розбіжностей $Z та ЦОСЕП та блокування БАНКу. <br> Розформувати файл?' },
        function() {
            $('#bpReasonsWindow').data('kendoWindow').center().open();
        });
    },

    deleteSepFile: function () {
        bars.ui.confirm({ text: 'Видалити файл?' },
            function () {
                var self = bars.sepfiles;
                var grid = self.sepGrid();
                var record = grid.dataItem(grid.select());
                var docParams = {
                    fileName: record.FN,
                    fileCreated: kendo.toString(record.DAT, "dd/MM/yyyy HH:mm"),
                    ref: record.Ref
                }
                $.get(bars.config.urlContent('/Sep/SepFiles/DeleteSepFile'), docParams).done(function (data) {
                    if (data.status == 'ok') {
                        self.refreshGrid();
                        bars.ui.alert({ text: data.message });
                    } else {
                        bars.ui.error({ title: "Помилка видалення файлу!", text: data.message });
                    }
                });
            });
    },

    initSepFilesPage: function() {
        var self = bars.sepfiles;
        $.get(bars.config.urlContent("/api/kernel/banksab"), function(data) {
            self.ourSab = data;
        });
        
        $("#sepDateDropDown").kendoDropDownList({
            dataSource: self.sepDatesDs,
            change: self.refreshSepFileMask,
            dataBound: function () {
                self.datesDropDownBinded = true;
                self.toolsAfterBind();
            }
        });

        $("#currencyDropDown").kendoDropDownList({
            dataTextField: "LCV",
            dataValueField: "KV",
            dataSource: self.currListDs,
            optionLabel: "*",
            change: self.refreshGrid,
            dataBound: function () {
                self.currenciesDropDownBinded = true;
                self.toolsAfterBind();
            }
        });

        $("#bankDropDown").kendoDropDownList({
            dataTextField: "Nb",
            dataValueField: "Mfo",
            dataSource: self.bankListDs,
            optionLabel: "*",
            change: self.refreshSepFileMask,
            dataBound: function () {
                self.banksDropDownBinded = true;
                self.toolsAfterBind();
            }
        });

        $("#pbUnCreate").kendoButton();
        $("#pbDel").kendoButton();
        $("#pbNewCreate").kendoButton();
        $("#pbOk").kendoButton();
        $("#pbDocs").kendoButton();
        $("#pbSave").kendoButton();

        $("#selectBpReason").kendoButton({
            enable: false,
            click: function () {
                var grid = self.sepGrid();
                var record = grid.dataItem(grid.select());
                var params = {
                    fileName: record.FN,
                    fileCreated: kendo.toString(record.DAT, "dd/MM/yyyy HH:mm"),
                    debitSum: record.SDE,
                    kreditSum: record.SKR,
                    bpReasonId: self.currentBpReason,
                    rowCount: record.N,
                    errorCode: record.K_ER
                };
                $.get(bars.config.urlContent('/Sep/SepFiles/UnCreateSepFile'), params).done(function (data) {
                    if (data.status == 'ok') {
                        self.refreshGrid();
                        $("#bpReasonsWindow").data('kendoWindow').close();
                        bars.ui.alert({ text: data.message });
                    } else {
                        bars.ui.error({ text: data.message });
                    }
                });
            }
        });

        $("#closeBpReasons").kendoButton({
            click: function () {
                $("#bpReasonsWindow").data('kendoWindow').close();
            }
        });

        $("#sepFilesGrid").on("dblclick", "tbody > tr", bars.sepfiles.openSepDocsByDblClick);

        $('#bpReasonsWindow').kendoWindow({
            width: "400px",
            title: "Оберіть причину розформування файлу",
            visible: false
        });
    }

}