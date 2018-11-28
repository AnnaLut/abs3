function requestsWindow(type, guid) {

    var gridSettings = {
        reqs: {
            dataSourceOptions: {
                transport: {
                    read: {
                        url: bars.config.urlContent("/api/TranspUi/TranspUi/SearchReqs")
                    }
                },
                schema: {
                    model: {
                        fields: {
                            Id: { type: "string" },
                            MainId: { type: "string" },
                            ReqId: { type: "string" },
                            UriGrId: { type: "string" },
                            UriKf: { type: "string" },
                            TypeId: { type: "string" },
                            InsertTime: { type: "date" },
                            SendTime: { type: "date" },
                            Status: { type: "number" },
                            ProcessedTime: { type: "date" }
                        }
                    }
                }
            },
            gridOptions: {
                columns: [
                    { title: "Ід підзапиту", field: "Id" },
                    { title: "Ід запиту", field: "MainId" },
                    { title: "Ід запиту збоку адресата", field: "ReqId" },
                    { title: "Група адресатів", field: "UriGrId" },
                    { title: "Ід адресата", field: "UriKf"  },
                    { title: "Назва типу запиту", field: "TypeId" },
                    { title: "Дата вставки", field: "InsertTime", template: "<div style='text-align:center;'>#=(InsertTime == null) ? ' ' : kendo.toString(InsertTime,'dd.MM.yyyy HH:mm:ss')#</div>" },
                    { title: "Дата доставки", field: "SendTime", template: "<div style='text-align:center;'>#=(SendTime == null) ? ' ' : kendo.toString(SendTime,'dd.MM.yyyy HH:mm:ss')#</div>" },
                    { title: "Статус", field: "Status" },
                    { title: "Час опрацювання запиту", field: "ProcessedTime", template: "<div style='text-align:center;'>#=(ProcessedTime == null) ? ' ' : kendo.toString(ProcessedTime,'dd.MM.yyyy HH:mm:ss')#</div>" }
                ]
            }
        },
        queue: {
            dataSourceOptions: {
                transport: {
                    read: {
                        url: bars.config.urlContent("/api/TranspUi/TranspUi/SearchQueue")
                    }
                },
                schema: {
                    model: {
                        fields: {
                            ReqId: { type: "string" },
                            IsMain: { type: "number" },
                            Priority: { type: "number" },
                            Status: { type: "number" },
                            InsertTime: { type: "date" },
                            ExecTry: { type: "number" },
                            LastTry: { type: "date" }
                        }
                    }
                }
            },
            gridOptions: {
                columns: [
                    { title: "Ід підзапиту", field: "ReqId" },
                    { title: "Пріорітет", field: "Priority" },
                    { title: "Статус", field: "Status" },
                    { title: "Дата вставки", field: "InsertTime", template: "<div style='text-align:center;'>#=(InsertTime == null) ? ' ' : kendo.toString(InsertTime,'dd.MM.yyyy HH:mm:ss')#</div>" },
                    { title: "Кількість спроб", field: "ExecTry" },
                    { title: "Остання спроба", field: "LastTry", template: "<div style='text-align:center;'>#=(LastTry == null) ? ' ' : kendo.toString(LastTry,'dd.MM.yyyy HH:mm:ss')#</div>" }
                ]
            }
        },
        types: {
            dataSourceOptions: {
                transport: {
                    read: {
                        url: bars.config.urlContent("/api/TranspUi/TranspUi/SearchTypes")
                    }
                },
                schema: {
                    model: {
                        id: "Id",
                        fields: {
                            Id: {type: "number" },
                            TypeName: { type: "string" },
                            TypeDesc: { type: "string" },
                            SessType: { type: "string" },
                            WebMethod: { type: "string" },
                            HttpMethod: { type: "string" },
                            OutputDataType: { type: "string" },
                            InputDataType: { type: "string" },
                            ContType: { type: "number" },
                            IsParallel: { type: "number" },
                            SendType: { type: "string" },
                            UriGroup: { type: "string" },
                            UriSuf: { type: "string" },
                            Priority: { type: "number" },
                            DoneAcction: { type: "string" },
                            MainTimeout: { type: "number" },
                            SendTrys: { type: "number" },
                            SendPause: { type: "number" },
                            ChkPause: { type: "number" },
                            Xml2json: { type: "number" },
                            Json2xml: { type: "number" },
                            CompressType: { type: "string" },
                            InputDecompress: { type: "number" },
                            OutputCompress: { type: "number" },
                            InputBase64: { type: "number" },
                            OutputBase64: { type: "number" },
                            CheckSum: { type: "string" },
                            StoreHead: { type: "number" },
                            AccContType: { type: "number" },
                            Loging: { type: "number" }
                        }
                    }
                }
            },
            gridOptions: {
                //toolbar: kendo.template($("#commandsTemplate").html()),
                //editable: "inline",
                columns: [
                    { title: "Назва типу відправки", field: "TypeName", width: "250px" },
                    { title: "Опис типу відправки", field: "TypeDesc", width: "250px" },
                    { title: "Тип сесії", field: "SessType", width: "100px" },
                    { title: "Метод відправки", field: "WebMethod", width: "120px" },
                    { title: "Тип HTTP запиту", field: "HttpMethod", width: "120px" },
                    { title: "Тип даних запиту", field: "OutputDataType", width: "120px" },
                    { title: "Тип даних відповіді", field: "InputDataType", width: "120px" },
                    { title: "Content-Type", field: "ContType", width: "100px" },
                    { title: "Паралельне виконання", field: "IsParallel", width: "125px", template: '#=(IsParallel == 1) ? "Так" : "Ні"#' },
                    { title: "Тип відправки", field: "SendType", width: "120px" },
                    { title: "ІД групи адресатів", field: "UriGroup", width: "150px" },
                    { title: "Шлях до сервісу", field: "UriSuf", width: "250px" },
                    { title: "Пріорітет", field: "Priority", width: "110px" },
                    { title: "Процедура після виконання.", field: "DoneAcction", width: "250px" },
                    { title: "Таймаут запиту з підзапитами", field: "MainTimeout", width: "125px" },
                    { title: "Кількість спроб відправки основного запиту", field: "SendTrys", width: "155px" },
                    { title: "Проміжок часу між запитам", field: "SendPause", width: "130px" },
                    { title: "Проміжок між запитами", field: "ChkPause", width: "120px" },
                    { title: "Конвертація запиту xml в json", field: "Xml2json", width: "130px", template: '#=(Xml2json == 1) ? "Так" : "Ні"#' },
                    { title: "Конвертація відповіді json в xml", field: "Json2xml", width: "135px", template: '#=(Json2xml == 1) ? "Так" : "Ні"#' },
                    { title: "Тип архівації", field: "CompressType", width: "120px" },
                    { title: "Признак розархівації даних відповіді", field: "InputDecompress", width: "150px", template: '#=(InputDecompress == 1) ? "Так" : "Ні"#' },
                    { title: "Признак архівації даних запиту", field: "OutputCompress", width: "130px", template: '#=(OutputCompress == 1) ? "Так" : "Ні"#' },
                    { title: "Конвертація відповіді з base_64", field: "InputBase64", width: "130px", template: '#=(InputBase64 == 1) ? "Так" : "Ні"#' },
                    { title: "Конвертація запиту в base_64", field: "OutputBase64", width: "130px", template: '#=(OutputBase64 == 1) ? "Так" : "Ні"#' },
                    { title: "Тип генерація контрольної суми", field: "CheckSum", width: "140px" },
                    { title: "Зберігати вміст заголовку запиту", field: "StoreHead", width: "150px", template: '#=(StoreHead == 1) ? "Так" : "Ні"#' },
                    { title: "Сontent-Type, який очікується в відповіді", field: "AccContType", width: "150px" },
                    { title: " Видаляти розгорнуті логи", field: "Loging", width: "120px", template: '#=(Loging == 1) ? "Так" : "Ні"#' }
                ]
            }
        },
        log: {
            dataSourceOptions: {
                transport: {
                    read: {
                        url: bars.config.urlContent("/api/TranspUi/TranspUi/SearchLog")
                    }
                },
                schema: {
                    model: {
                        fields: {
                            Id: { type: "number" },
                            ReqId: { type: "string" },
                            SubReq: { type: "string" },
                            ChkReq: { type: "string" },
                            Act: { type: "string" },
                            State: { type: "string" },
                            Message: { type: "string" },
                            InsertDate: { type: "date" }
                        }
                    }
                }
            },
            gridOptions: {
                columns: [
                    { title: "Ід", field: "Id", width: "100px" },
                    { title: "Дата повідомлення", field: "InsertDate", template: "<div style='text-align:center;'>#=(InsertDate == null) ? ' ' : kendo.toString(InsertDate,'dd.MM.yyyy HH:mm:ss')#</div>", width: "150px" },
                    { title: "Ід запиту", field: "ReqId" },
                    { title: "Ід підзапиту", field: "SubReq" },
                    { title: "Дія", field: "Act" },
                    { title: "Статус", field: "State", width: "100px" },
                    { title: "Результат", field: "Message" }         
                ]
            }
        },
        params: {
            dataSourceOptions: {
                transport: {
                    read: {
                        url: bars.config.urlContent("/api/TranspUi/TranspUi/SearchParams")
                    }
                },
                schema: {
                    model: {
                        fields: {
                            ParamName: { type: "string" },
                            ParamValue: { type: "string" }
                        }
                    }
                }
            },
            gridOptions: {
                columns: [
                    { title: "Назва параметру", field: "ParamName" },
                    { title: "Значення параметру", field: "ParamValue" }
                ]
            }
        }
    };

    function getTitle() {
        switch (type) {
            case "reqs":
                return "Вихідні підзапити";
            case "queue":
                return "Черга на відправку";
            case "types":
                return "Опис вихідних параметрів";
            case "log":
                return "Журнал відправки";
            case "params":
                return "Параметри запиту";
            default:
                return null;
        }
    }

    function updateRequestsGrid() {
        var grid = window.find("#grid").data("kendoGrid");
        if (grid) {
            grid.dataSource.read();
        }
    };

    function clearRequestsFilters() {
        var grid = window.find("#grid").data("kendoGrid");
        if (grid) {
            var dataSource = grid.dataSource;
            dataSource.filter({});
            dataSource.sort({});
        }
    };

    function configureButtonsEvents() {
        window.find("#updateRequestsGrid").click(function () {
            updateRequestsGrid();
        }).end();

        window.find("#clearRequestsFilters").click(function () {
            clearRequestsFilters();
            window.find("form.k-filter-menu button[type='reset']").trigger("click");
        }).end();

        window.find("#reqClobBtn,#respClobBtn,#errorClobBtn").click(function (event) {
            var btn = event.currentTarget.id.slice(0, -3);

            if (type !== "reqs" && type !== "log")
                return;

            var url = "/api/TranspUi/TranspUi/GetLogClob";

            if (type === "reqs") {
                url = btn === "reqClob" ? "/api/TranspUi/TranspUi/GetReqClob" : "/api/TranspUi/TranspUi/GetRespClob";
            }

            var grid = window.find('#grid').data("kendoGrid");
            var value = getSelectedValue(grid, "Id");

            if (!value) {
                return;
            }

            $.ajax({
                type: "GET",
                contentType: "application/json",
                url: bars.config.urlContent(url),
                beforeSend: function () {
                    bars.ui.loader("#grid", true);
                },
                data: {
                    id: value
                },
                success: function (data) {
                    if (!data)
                        bars.ui.notify("Повідомлення", "CLOB IS EMPTY", 'info', { autoHideAfter: 5 * 1000 });
                    else
                        clobWindow(data);
                },
                complete: function () {
                    bars.ui.loader("#grid", false);
                }
            });
        }).end();
    }

    function onWindowActivate() {
        bars.ui.loader("#grid", true);

        var dataSourceOptions = gridSettings[type].dataSourceOptions;

        if (type !== "types" || type !== "params")
        {
            dataSourceOptions.transport.read.data = function () {
                return {
                    guid: guid
                };
            };
        }        

        dataSourceOptions.requestEnd = function () { bars.ui.loader("#grid", false); };

        var dataSource = new kendo.data.DataSource(DataSourceSettings(dataSourceOptions));

        var gridOptions = gridSettings[type].gridOptions;

        gridOptions.toolbar = kendo.template($("#requestsToolbarTemplate").html());
                            
        gridOptions.dataSource = dataSource;

        var grid = new GridSettings(gridOptions);

        window.find('#grid').kendoGrid(grid).end();

        if (type === "reqs") {
            window.find("#reqClobBtn").removeClass("invisible");
            window.find("#respClobBtn").removeClass("invisible");
        }

        if (type === "log")
            window.find("#errorClobBtn").removeClass("invisible");

        configureButtonsEvents();

        changeGridMaxHeight();
    }

    var windowOptions = {
        activate: onWindowActivate,
        title: getTitle(),
        overflow: "hidden",
        content: {
            template: kendo.template($("#windowTemplate").html())
        }
    };

    var window = $("<div />").kendoWindow(WindowSettings(windowOptions));    

    window.data("kendoWindow").center().open();
}