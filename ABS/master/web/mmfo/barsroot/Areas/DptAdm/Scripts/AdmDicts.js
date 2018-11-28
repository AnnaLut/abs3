$(document)
    .ready(function () {

        $('#mydiv').hide();
        /*var grid_dpt_dicts_model = kendo.data.Model.define({
            id: grid_dpt_dicts_model,
            fields: {
                ID: { type: "number" },
                TYPE_NAME: { type: "string" }
            }
        });
        var grid_dpt_dicts_DS = new kendo.data.DataSource({
            type: "aspnetmvc-ajax",
            transport: { read: { dataType: 'json', url: bars.config.urlContent('/DptAdm/DptAdm/GetDicts') } },
            schema: { data: "data", model: grid_dpt_dicts_model }
        });*/

        /*var grid_dpt_dicts = $('#grid_dpt_dicts')
            .kendoGrid({
                autobind: true,
                selectable: "row",
                sortable: true,
                scrolable: true,
                datasource: grid_dpt_dicts_DS,
                columns: [
                    {
                        field: "semantic",
                        title: "Назва",
                        width: "95%",
                        attributes: { "class": "table-cell", style: "text-align: center; font-size: 12px" }
                    }
                ]
            });
            */

        // Тулбар
        $("#toolbar")
            .kendoToolBar({
                items: [
                    {
                        type: "button",
                        text: "Корекція терміну вкладу",
                        imageUrl: "/barsroot/Content/images/PureFlat/16/tool_pencil.png",
                        click: termDepCorr, overflow: "never"
                    },
                    {
                        type: "button",
                        text: "Корекція дат закінчення депозиту при переносі робочих днів",
                        imageUrl: "/barsroot/Content/images/PureFlat/16/calendar2.png",
                        click: CorrHolyday, overflow: "never"
                    },
                    {
                        type: "button",
                        text: "Експорт базових відсоткових ставок",
                        click: openExportsBaseInterestRates,
                        title: "Edit example",
                        overflow: "never",
                        imageUrl: "/barsroot/Content/images/PureFlat/16/arrow_download.png"
                    },
                    {
                        type: "button",
                        text: "Формування звiту для ПФ",
                        click: formReportForPf,
                        overflow: "never",
                        imageUrl: "/barsroot/Content/images/PureFlat/16/Hot/report_open-import.png"
                    },
                    {
                        type: "button",
                        text: "Перенесення строк.вкладів",
                        click: openTransferSrokdeposits,
                        overflow: "never",
                        imageUrl: "/barsroot/Content/images/PureFlat/16/undo_green.png"

                    },
                    {
                        type: "button",
                        text: "DPT Оновлення базових ставок по видам депозитів ФО",
                        click: openUpdatedDepositsFL,
                        imageUrl: "/barsroot/Content/images/PureFlat/16/application-update.png",
                        overflow: "never"
                    },
                    {
                        type: "button",
                        imageUrl: "/barsroot/Areas/DptAdm/Content/Images/UPDOWN.png",
                        text: "Синхронізація % ставок по змігрованим депозитам",
                        click: openSynchronizeDeposits,
                        overflow: "never"
                    },
                    {
                        type: "button",
                        imageUrl: "/barsroot/Content/images/PureFlat/16/Hot/document_header_footer-ok2.png",
                        text: "Підготовка даних для звіту для ПФ (повний) + довіреність",
                        click: openReportPFnew,
                        overflow: "never"
                    }

                ]

            });


        // Модальное окно "Коррекция срока вклада"  
        window.modalWinTermDepCorr = $("#mdWinTermDepCorr")
            .kendoWindow({
                width: "400",
                modal: true,
                title: "Корекція сроку вкладу:",
                visible: false,
                actions: [
                    "Pin",
                    "Minimize",
                    "Maximize",
                    "Close"
                ],
                close: onClose
            })
            .data("kendoWindow");

        function termDepCorr() {
            modalWinTermDepCorr.center().open();
        };

        function CorrHolyday() {
            mdWinCorrHolyday.center().open();
        }

        var mdWinCorrHolyday = $("#mdWinCorrHolyday").kendoWindow({
            width: "370",
            modal: true,
            visible: false,
            actions: [ "Close" ]
        }).data("kendoWindow");

        var HolydayNewDateEnd = $("#HolydayNewDateEnd").kendoDatePicker({ format: "dd/MM/yyyy" });
        var HolydayCurrentDateEnd = $("#HolydayCurrentDateEnd").kendoDatePicker({ format: "dd/MM/yyyy" });

        $("#CorrHolydayCancel").click(function () { mdWinCorrHolyday.center().close(); });

        $("#CorrHolydayOK").click(function () { CorrHolydayDpt(); });


        // При закрытии формы очищаем данные формы
        function onClose(e) {

            $("#FormTermDepCorr").trigger("reset");

            $("#DepositNumberValidate").empty();
            $("#NewDepositStartDateValidate").empty();
            $("#NewDepositEndDateValidate").empty();
            $("#ProlongationNumberValidate").empty();

            removeClass(document.getElementById("DepositNumberValidate"), "required-star");
            removeClass(document.getElementById("NewDepositStartDateValidate"), "required-star");
            removeClass(document.getElementById("NewDepositEndDateValidate"), "required-star");
            removeClass(document.getElementById("ProlongationNumberValidate"), "required-star");
        }


        //Создание datePicker
        $("#DepositStartDate")
            .kendoDatePicker({
                format: "dd/MM/yyyy"
            });
        $("#DepositEndDate")
            .kendoDatePicker({
                format: "dd/MM/yyyy"
            });

        var newDepositStartDate = $("#NewDepositStartDate")
            .kendoDatePicker({
                format: "dd/MM/yyyy"
            });

        var newDepositEndDate = $("#NewDepositEndDate")
            .kendoDatePicker({
                format: "dd/MM/yyyy"
            });

        // По клику осуществить валидацию формы
        $("#formValidate")
            .click(function () {
                formValidation();
            });

        // По клику закрыть форму
        $("#cancelForm")
            .click(function () {
                modalWinTermDepCorr.center().close();

            });
        // Инициализация поля № Вкладу и отслеживание ввода данных пользователем
        $("#DepositNumber")
            .kendoNumericTextBox({
                spinners: false,
                format: "#",
                decimals: 0,
                min: 0,

                change: function () {
                    var value = this.value();
                    if (value !== null) {
                        getDates(parseInt(value));
                    }
                }
            });

        // Модальное окно "Формування звiту для ПФ "Рах,по яким не отрим.персiонери""  
        window.formReportForPnFond = $("#mdWinReportForPnFond")
            .kendoWindow({
                width: "550",
                modal: true,
                title: 'Формування звiту для ПФ "Рах, по яким не отрим. персiонери"',
                visible: false,
                actions: [
                    "Pin",
                    "Minimize",
                    "Maximize",
                    "Close"
                ],
                close: onCloseFormReportForPnFond
            })
            .data("kendoWindow");

        // Инициализация поля Звiтний перiод/мiс:
        $("#ReportPeriodNumber")
            .kendoNumericTextBox({
                spinners: false,
                format: "#",
                decimals: 0,
                min: 1
            });


        // cоздание datePicker для поля Звiтна дата:
        $("#ReportDate")
            .kendoDatePicker({
                format: "dd/MM/yyyy"
            });


        // вызов функции Формування звiту для ПФ "Рах,по яким не отрим.персiонери"
        function formReportForPf() {
            formReportForPnFond.center().open();

        }

        // По клику осуществить валидацию формы "Формування звiту для ПФ "Рах,по яким не отрим.персiонери""
        $("#ValidateFormReportForPnFond")
            .click(function () {
                reportForPnFondformValidation();
            });

        // По клику закрыть форму "Формування звiту для ПФ "Рах,по яким не отрим.персiонери""
        $("#CancelFormReportForPnFond")
            .click(function () {
                formReportForPnFond.close();

            });

        // При закрытии формы очищаем данные формы "Формування звiту для ПФ "Рах,по яким не отрим.персiонери""
        function onCloseFormReportForPnFond() {
            $("#FormReportForPnFond").trigger("reset");
            $("#ReportPeriodValidate").empty();
            $("#ReportDateValidate").empty();
            removeClass(document.getElementById("ReportPeriodValidate"), "errorStyle");
            removeClass(document.getElementById("ReportDateValidate"), "errorStyle");
        }


        // вызов функции Перенесення строк.вкладів на вклади до запит.зг.Пост.НБУ № 159
        function moveTermDeposit() {

        }


        // Модальное окно "Экспорт базовых процентных ставок"  
        var modalWinExportsBaseInterestRates = $("#mdWinExportBaseInsRates").kendoWindow({
            width: "390",
            modal: true,
            title: "Експорт базових відсоткових ставок:",
            visible: false,
            actions: [
                "Pin",
                "Minimize",
                "Maximize",
                "Close"
            ]
        }).data("kendoWindow");


        function openExportsBaseInterestRates() {
            modalWinExportsBaseInterestRates.title("Експорт базових відсоткових ставок:");
            $('#mdWinExportBaseInsRates legend').text("Оберіть дату експорту:");
            $('#sendToNewPF').attr('id', 'confirmSendDateToBratesExport');
            modalWinExportsBaseInterestRates.center().open();
        };

        function openReportPFnew() {
            modalWinExportsBaseInterestRates.title("Підготовка даних для звіту для ПФ");
            $('#mdWinExportBaseInsRates legend').text("Оберіть дату для звіту ПФ");
            $('#confirmSendDateToBratesExport').attr('id', 'sendToNewPF');
            modalWinExportsBaseInterestRates.center().open();
        };

        function newPF() {
            bars.ui.loader('body', true);
            $.ajax({
                type: "POST",
                url: bars.config.urlContent("/DptAdm/DptAdm/NewPF"),
                data: { date:  $("#BratesExportData").val() },
                success: function (data) {
                    if (data.message != null) {
                        bars.ui.loader('body', false);
                        bars.ui.error({ text: data.message });
                    } else {
                        bars.ui.loader('body', false);
                        bars.ui.success({ text: "Підготовка даних успішно здійснена!" });
                        modalWinExportsBaseInterestRates.close();
                    }
                }
            });
        };

        $("#cnclSendDateToBratesExport")
            .kendoButton({
                click: closeBrateExpWin
            });

        function closeBrateExpWin(e) {
            modalWinExportsBaseInterestRates.close();
        };

        $("#confirmSendDateToBratesExport")
            .kendoButton({
                click: sendDateBrateExpWin
            });

        function sendDateBrateExpWin(e) {
            if (e.sender.element.context.id !== "sendToNewPF") {
                var sendDate = $("#BratesExportData").val();
                window.open("/barsroot/DptAdm/DptAdm/DptBratesExport?" +
                    "date=" +
                    sendDate
                );
                modalWinExportsBaseInterestRates.close();
            }
            else
                newPF();
        };


        var todayDate = kendo.toString(kendo.parseDate(new Date()), 'dd/MM/yyyy');
        //Создание DatePicker BratesExportData 
        $("#BratesExportData")
            .kendoDatePicker({
                format: "dd/MM/yyyy"
            });
        $("#BratesExportData").val(todayDate);


        //Валидация формы
        var validator = $("#FormTermDepCorr").kendoValidator().data("kendoValidator"),
            status = $(".status");

        var expDateValidator = $("#FormExpDate").kendoValidator().data("kendoValidator"),
            status = $(".status");

        ///////////////////////

        // Модальное окно "Синхронізація % ставок по змігрованим депозитам"  
        var modalWinSynchronizeDeposits = $("#SynchronizeDeposits").kendoWindow({
            width: "500",
            modal: true,
            title: "Синхронізація % ставок по змігрованим депозитам:",
            visible: false,
            actions: [
                "Pin",
                "Minimize",
                "Maximize",
                "Close"
            ]
        }).data("kendoWindow");
        function openSynchronizeDeposits() {

            modalWinSynchronizeDeposits.center().open();
        };

        $("#cncldep").kendoButton({
            click: function () {
                debugger;
                modalWinSynchronizeDeposits.close();
            }
        });

        $("#confirmSynchronizeDeposits").kendoButton({
            click: function () {
                debugger;
                var sel = $(document.body);
                $.ajax({
                    url: bars.config.urlContent("/api/DptAdm/AdditionalFuncApi/SynchronizeDeposits"),
                    method: "GET",
                    async: false,
                    complete: function (data) {
                    }
                });

                modalWinSynchronizeDeposits.close();
            }
        });

        //////Модальное окно "DPT Оновлення базових ставок по видам депозитів ФО"
        var modalWinUpdatedDepositsFL = $("#UpdatedDepositsFL").kendoWindow({
            width: "500",
            modal: true,
            //title: "DPT Оновлення базових ставок по видам депозитів ФО:",
            visible: false,
            actions: [
                "Pin",
                "Minimize",
                "Maximize",
                "Close"
            ]
        }).data("kendoWindow");

        function openUpdatedDepositsFL() {
            modalWinUpdatedDepositsFL.center().open();
        };
        $("#cnclUpdatedDepositsFL").kendoButton({
            click: function () {
                modalWinUpdatedDepositsFL.close();
            }
        });
        $("#confirmUpdatedDepositsFL").kendoButton({
            click: function () {
                {

                    $.ajax({
                        url: bars.config.urlContent("/api/DptAdm/AdditionalFuncApi/UpdatedDepositsFL"),
                        method: "GET",
                        async: false,
                        complete: function (data) {
                        }
                    });

                    modalWinUpdatedDepositsFL.close();
                };
            }
        });


        //////Модальное окно "Перенесення строк.вкладів"
        var modalWinTransferSrokdeposits = $("#TransferSrokdeposits").kendoWindow({
            width: "90%",
            modal: true,
            title: "Перенесення строк.вкладів:",
            visible: false,
            actions: [
                "Pin",
                "Minimize",
                "Maximize",
                "Close"
            ]
        }).data("kendoWindow");

        var DialogTransdeposits = $("#DialogTransdeposits").kendoWindow({
            width: "30%",
            modal: true,
            //title: "Перенесення строк.вкладів:",
            visible: false,
            actions: [
                "Close"
            ]
        }).data("kendoWindow");

        function openTransferSrokdeposits() {
            kendo.ui.progress($("#grid"), true);

            debugger;
            modalWinTransferSrokdeposits.center().open();
            $("#TransferSrokdeposits").closest(".k-window").css({
                top: 55
            });
            $("#grid").kendoGrid({
                dataSource: {
                    type: 'webapi',
                    transport: {
                        read: {
                            url: bars.config.urlContent("/api/DptAdm/AdditionalFuncApi/GetVDPT")// /api/DptAdm/EditFinesDFOApi/GetVDPT

                        }
                    },
                    pageSize: 15,
                    serverPaging: true,
                    serverFiltering: true,
                    schema:
                    {

                        data: "Data",
                        total: "Total",
                        model:
                        {
                            fields:
                                {
                                    DPTID: {
                                        type: 'number',
                                        editable: false
                                    },
                                    DPTNUM: {
                                        editable: false
                                    },
                                    DPTDAT: {
                                        type: 'string',
                                        editable: false
                                    },
                                    DATBEG: {
                                        editable: false,
                                        type: "date"
                                    },
                                    DATEND: {
                                        editable: false
                                    },
                                    TYPEID: {
                                        type: 'number',
                                        editable: false
                                    },
                                    TYPENAME: {
                                        type: 'string',
                                        editable: false
                                    },
                                    RATE: {
                                        type: 'number',
                                        editable: false
                                    },
                                    CURID: {
                                        type: 'string',
                                        editable: false
                                    },
                                    CURCODE: {
                                        type: 'string',
                                        editable: false
                                    },
                                    CUSTID: {
                                        type: 'number',
                                        editable: false
                                    },
                                    CUSTNAME: {
                                        type: 'string',
                                        editable: false
                                    },
                                    CUSTCODE: {
                                        type: 'string',
                                        editable: false
                                    },
                                    DEPACCID: {
                                        type: 'number',
                                        editable: false
                                    },
                                    DEPACCNUM: {
                                        type: 'string',
                                        editable: false
                                    },
                                    DEPCCNAME: {
                                        type: 'string',
                                        editable: false
                                    },
                                    DEPSAL_FACT: {
                                        type: 'number',
                                        editable: false
                                    },
                                    DEPSAL_PLAN: {
                                        type: 'number',
                                        editable: false
                                    },
                                    DEPISP: {
                                        type: 'number',
                                        editable: false
                                    },
                                    DEPGRP: {
                                        type: 'number',
                                        editable: false
                                    },
                                    DEPTYPE: {
                                        type: 'string',
                                        editable: false
                                    },
                                    INTACCID: {
                                        type: 'number',
                                        editable: false
                                    },
                                    INTACCNUM: {
                                        type: 'string',
                                        editable: false
                                    },
                                    INTACCNAME: {
                                        type: 'string',
                                        editable: false
                                    },
                                    INTSAL_FACT: {
                                        type: 'number',
                                        editable: false
                                    },
                                    INTSAL_PLAN: {
                                        type: 'number',
                                        editable: false
                                    },
                                    INTISP: {
                                        type: 'number',
                                        editable: false
                                    },
                                    INTGRP: {
                                        type: 'number',
                                        editable: false
                                    },
                                    INTTYPE: {
                                        type: 'string',
                                        editable: false
                                    },
                                    BRANCH: {
                                        type: 'string',
                                        editable: false
                                    },
                                    BRANCHNAME: {
                                        type: 'string',
                                        editable: false
                                    },
                                }
                        }
                    }
                },
                pageable: {
                    refresh: true,
                    pageSizes: 10
                },
                selectable: "multiple",
                scrolable: true,
                editable: { createAt: "bottom" },
                columns: [
                     {
                         field: "DPTID",
                         title: "Код вкладу",
                         width: "200px"
                     },
                    {
                        field: "DPTNUM",
                        title: "№ договору",
                        width: "200px"
                    },
                   
                    {
                        field: "DPTDAT",
                        title: "Дата договору",
                        width: "200px",
                        template:"#= kendo.toString(kendo.parseDate(DPTDAT, 'yyyy-MM-dd'), 'dd/MM/yyyy') #"
                    },
                    {
                        field: "TYPEID",
                        title: "Вид вкладу",
                        width: "200px"
                    },
                    {
                        field: "TYPENAME",
                        title: "Назва виду вкладу",
                        width: "200px"
                    },
                    {
                        field: "CURID",
                        title: "Код вал",
                        width: "200px"
                    },
                    {
                        field: "CURCODE",
                        title: "Вал ISO",
                        width: "200px"
                    },
                    {
                        field: "DATBEG",
                        title: "Дата початку",
                        width: "200px",
                        template: '#= kendo.toString(DATBEG, "dd/MM/yyyy") #'
                    },
                    {
                        field: "DATEND",
                        title: "Дата закінчення",
                        width: "200px",
                        template: '#= kendo.toString(DATBEG, "dd/MM/yyyy") #'
                    },
                    {
                        field: "RATE",
                        title: "Відсоткова ставка",
                        width: "200px"
                    },
                      {
                          field: "CUSTID",
                          title: "Рег. № клієнта",
                          width: "200px"
                      },
                    {
                        field: "CUSTNAME",
                        title: "'ПІБ клієнта",
                        width: "200px"
                    },
                     {
                         field: "CUSTCODE",
                         title: "Ідентиф.код клієнта",
                         width: "200px"
                     },
                      {
                          field: "DEPACCNUM",
                          title: "Депозитний рахунок",
                          width: "200px"
                      },
                     {
                         field: "DEPSAL_FACT",
                         title: "Сума деп.(факт)",
                         width: "200px"
                     },
                    {
                        field: "DEPSAL_PLAN",
                        title: "Сума деп.(план)",
                        width: "200px"
                    },
                    {
                        field: "INTSAL_FACT",
                        title: "'Сума %% (факт)",
                        width: "200px"
                    },
                    {
                        field: "INTSAL_PLAN",
                        title: "Сума %%~(план)",
                        width: "200px"
                    },
                    {
                        field: "BRANCH",
                        title: "Код підрозділу",
                        width: "200px"
                    },
                    {
                        field: "BRANCHNAME",
                        title: "'Назва підрозділу",
                        width: "200px"
                    },
                    /////
                    {
                        field: "DEPACCID",
                        title: "f",
                        width: "200px",
                        hidden: true
                    },
                   
                    {
                        field: "DEPCCNAME",
                        title: "h",
                        width: "200px",
                        hidden: true
                    },
                    
                    {
                        field: "DEPISP",
                        title: "l",
                        width: "200px",
                        hidden: true
                    },
                    {
                        field: "DEPGRP",
                        title: "z",
                        width: "200px",
                        hidden: true
                    },
                    {
                        field: "DEPTYPE",
                        title: "x",
                        width: "200px",
                        hidden: true
                    },
                    {
                        field: "INTACCID",
                        title: "c",
                        width: "200px",
                        hidden: true
                    },
                    {
                        field: "INTACCNUM",
                        title: "Процентний рахунок",
                        width: "200px",
                        hidden: true
                    },
                    {
                        field: "INTACCNAME",
                        title: "b",
                        width: "200px",
                        hidden: true
                    },
                    
                    {
                        field: "INTISP",
                        title: "qq",
                        width: "200px",
                        hidden: true
                    },
                    {
                        field: "INTGRP",
                        title: "ww",
                        width: "200px",
                        hidden: true
                    },
                    {
                        field: "INTTYPE",
                        title: "ee",
                        width: "200px",
                        hidden: true
                    }
                    
                ],
                dataBound: function (e) {
                    kendo.ui.progress($("#grid"), false);
                },
                srollable: true
            });
            debugger;
            //kendo.ui.progress($("#grid"), false);
            //$("#grid").data("kendoGrid").dataSource = GetDataSourceForGrid();
        };

        var dateRegExp = /^\/Date\((.*?)\)\/$/;

        function toDate(value) {
            debugger;
            var date = dateRegExp.exec(value);
            return new Date(parseInt(date[1]));
        }
        function closeTransferSrokdepositsWin(e) {
            DialogTransdeposits.close();
        };
        function openDialogTransdeposits() {
            debugger;
            DialogTransdeposits.center().open();

            $("#operations").kendoDropDownList({
                dataSource: ["Chai", "Chang", "Tofu"],
                filter: "contains"
            });
        };
        $("#cnclTransferSrokdeposits").kendoButton({
            click: function () {
                DialogTransdeposits.close();
            }
        });

        $("#confirmTransferSrokdeposits").kendoButton({
            click: function () {
                debugger;
                var OPERATION = $("#operations").data("kendoDropDownList").value();
                var SELECTED = GetSelected();
                SELECTED = SELECTED.DPTID;
                console.log(SELECTED);
                $.ajax({
                    url: bars.config.urlContent("/api/DptAdm/AdditionalFuncApi/TransferSrokdeposits"),
                    method: "POST",
                    dataType: "json",
                    data: JSON.stringify({ OPERATION: OPERATION, SELECTED: SELECTED }),
                    contentType: "application/json",
                    async: false,
                    complete: function (data) {
                        AlertNotifySuccess();
                        DialogTransdeposits.close();
                    }
                });

            }
        });
        $("#DialogTransdepositsButtton").kendoButton({
            click: function () {
                var selected = GetSelected();
                if (selected) {
                    $("#operations").kendoDropDownList({
                        dataTextField: "NAME",
                        dataValueField: "TT",
                        dataSource: {
                            type: 'webapi',
                            transport: {
                                read: {
                                    url: bars.config.urlContent("/api/DptAdm/AdditionalFuncApi/GetOperations")// /api/DptAdm/EditFinesDFOApi/GetVDPT
                                }
                            },
                        },
                        filter: "contains"
                    });
                    DialogTransdeposits.center().open();
                }
                else {
                    // alert("GJGJ");
                    AlertNotifyError();
                }

            }
        });



        function GetSelected() {
            debugger;
            var gridElement = angular.element("#grid").data("kendoGrid");
            var selected = gridElement.dataItem(gridElement.select());
            return selected;
        }
        AlertNotifyInfo = function (info) {
            var popupNotification = $("#popupNotification").kendoNotification({
                position: {
                    top: 10,
                    right: 20,
                },
            }).data("kendoNotification");
            popupNotification.show((kendo.toString("Виконується операція. Зачекайте")), "info");
        }
        AlertNotifySuccess = function (info) {
            var popupNotification = $("#popupNotification").kendoNotification({
                position: {
                    pinned: true,
                    top: true,
                    right: 20,
                },
            }).data("kendoNotification");
            popupNotification.show((kendo.toString("Виконано")), "info");
        }
        AlertNotifyError = function () {
            debugger;
            var popupNotification = $("#popupNotification").kendoNotification({
                position: {
                    top: 10,
                    right: 20
                },
                show: onShow
            }).data("kendoNotification");
            popupNotification.show((kendo.toString("Жодного рядка не обрано!")), "error");
            debugger;
            // console.log(popupNotification);
        }
        function onShow(e) {
            e.element.parent().css({
                zIndex: 22222
            });
        }

        function CorrHolydayDpt() {
            bars.ui.loader('body', true);

            var curr_date = $("#HolydayCurrentDateEnd").data("kendoDatePicker").value();
            var new_date = $("#HolydayNewDateEnd").data("kendoDatePicker").value();

            if (!curr_date) {
                bars.ui.error({ text: "Поле <b>Поточна дата закінчення</b> - обов'язкове" });
                return;
            }

            if (!new_date) {
                bars.ui.error({ text: "Поле <b>Нова дата закінчення</b> - обов'язкове" });
                return;
            }

            $.ajax({
                url: bars.config.urlContent("/DptAdm/DptAdm/CorrectHolydayDeposit"),
                method: "POST",
                dataType: "json",
                data: {
                    correct_holyday_data: JSON.stringify({
                        Current_Date_End: curr_date,
                        New_Date_End: new_date,
                        Corr_Type: $("#CorrNoAutoProlong").is(':checked') ? 1 : 0
                    })
                },
                async: true,
                success: function (data) {
                    if(data.message)
                        bars.ui.error({ text: data.message });
                    else
                        bars.ui.alert({ text: "Операція успішно почалась." });
                },
                complete: function () {
                    bars.ui.loader('body', false);
                    mdWinCorrHolyday.close();
                }
            });
        }
    });