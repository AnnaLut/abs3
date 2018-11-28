function inputRequestsWindow(type, guid) {
    var gridSettings = {
        queue: {
            dataSourceOptions: {
                transport: {
                    read: {
                        url: bars.config.urlContent("/api/TranspUi/TranspUi/SearchInputQueue")
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
                        url: bars.config.urlContent("/api/TranspUi/TranspUi/SearchInputTypes")
                    }
                },
                schema: {
                    model: {
                        id: "Id",
                        fields: {
                            Id: { type: "number" },
                            TypeName: { type: "string" },
                            TypeDesc: { type: "string" },
                            SessType: { type: "string" },
                            OutputDataType: { type: "string" },
                            InputDataType: { type: "string" },
                            ContType: { type: "number" },                        
                            Priority: { type: "number" },
                            Xml2json: { type: "number" },
                            Json2xml: { type: "number" },
                            CompressType: { type: "string" },
                            InputDecompress: { type: "number" },
                            OutputCompress: { type: "number" },
                            InputBase64: { type: "number" },
                            OutputBase64: { type: "number" },
                            AddHead: { type: "number" },
                            CheckSum: { type: "string" },
                            StoreHead: { type: "number" },
                            Loging: { type: "number" },
                            ExecTimeout: { type: "number" },
                            AccType: { type: "string" }
                        }
                    }
                }
            },
            gridOptions: {
                columns: [
                    { title: "Назва типу відправки", field: "TypeName", width: "200px" },
                    { title: "Опис типу відправки", field: "TypeDesc", width: "150px" },
                    { title: "Тип сесії", field: "SessType", width: "100px" },
                    { title: "Тип даних запиту", field: "OutputDataType", width: "120px" },
                    { title: "Тип даних відповіді", field: "InputDataType", width: "120px" },
                    { title: "Content-Type", field: "ContType", width: "100px" },
                    { title: "Пріорітет", field: "Priority", width: "110px" },
                    { title: "Процедура обробки", field: "AccType", width: "450px" },
                    { title: "Конвертація запиту xml в json", field: "Xml2json", width: "130px", template: '#=(Xml2json == 1) ? "Так" : "Ні"#' },
                    { title: "Конвертація відповіді json в xml", field: "Json2xml", width: "135px", template: '#=(Json2xml == 1) ? "Так" : "Ні"#' },
                    { title: "Тип архівації", field: "CompressType", width: "120px" },
                    { title: "Признак розархівації даних відповіді", field: "InputDecompress", width: "150px", template: '#=(InputDecompress == 1) ? "Так" : "Ні"#' },
                    { title: "Признак архівації даних запиту", field: "OutputCompress", width: "130px", template: '#=(OutputCompress == 1) ? "Так" : "Ні"#' },
                    { title: "Конвертація відповіді з base_64", field: "InputBase64", width: "130px", template: '#=(InputBase64 == 1) ? "Так" : "Ні"#' },
                    { title: "Конвертація запиту в base_64", field: "OutputBase64", width: "130px", template: '#=(OutputBase64 == 1) ? "Так" : "Ні"#' },
                    { title: "Додавати в хедер", field: "AddHead", width: "100px", template: '#=(AddHead == 1) ? "Так" : "Ні"#' },
                    { title: "Тип генерація контрольної суми", field: "CheckSum", width: "140px" },
                    { title: "Зберігати вміст заголовку запиту", field: "StoreHead", width: "150px", template: '#=(StoreHead == 1) ? "Так" : "Ні"#' },
                    { title: "Видаляти розгорнуті логи", field: "Loging", width: "120px", template: '#=(Loging == 1) ? "Так" : "Ні"#' },
                    { title: "Час обробки (c)", field: "ExecTimeout", width: "150px" }
                ]
            }
        },
        log: {
            dataSourceOptions: {
                transport: {
                    read: {
                        url: bars.config.urlContent("/api/TranspUi/TranspUi/SearchInputLog")
                    }
                },
                schema: {
                    model: {
                        fields: {
                            Id: { type: "number" },
                            ReqId: { type: "string" },
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
                    { title: "Дія", field: "Act" },
                    { title: "Статус", field: "State", width: "100px" },
                    { title: "Результат", field: "Message" }
                ]
            }
        },
        responseparams: {
            dataSourceOptions: {
                transport: {
                    read: {
                        url: bars.config.urlContent("/api/TranspUi/TranspUi/SearchInputResponseParams")
                    }
                },
                schema: {
                    model: {
                        fields: {
                            RespId: { type: "string" },
                            ParamType: { type: "string" },
                            Tag: { type: "string" },
                            Value: { type: "string" }
                        }
                    }
                }
            },
            gridOptions: {
                columns: [
                    { title: "ІД відповіді", field: "RespId" },
                    { title: "Метод запиту", field: "ParamType" },
                    { title: "Тег", field: "Tag" },
                    { title: "Значення", field: "Value" }
                ]
            }
        },
        requestparams: {
            dataSourceOptions: {
                transport: {
                    read: {
                        url: bars.config.urlContent("/api/TranspUi/TranspUi/SearchInputRequestParams")
                    }
                },
                schema: {
                    model: {
                        fields: {
                            ReqId: { type: "string" },
                            ParamType: { type: "string" },
                            Tag: { type: "string" },
                            Value: { type: "string" }
                        }
                    }
                }
            },
            gridOptions: {
                columns: [
                    { title: "ІД запиту", field: "ReqId" },
                    { title: "Метод запиту", field: "ParamType" },
                    { title: "Тег", field: "Tag" },
                    { title: "Значення", field: "Value" }
                ]
            }
        },
        response: {
            dataSourceOptions: {
                transport: {
                    read: {
                        url: bars.config.urlContent("/api/TranspUi/TranspUi/SearchInputResponses")
                    }
                },
                schema: {
                    model: {
                        fields: {
                            ReqId: { type: "string" },
                            InsertTime: { type: "date" },
                            ConvertTime: { type: "date" },
                            SendTime: { type: "date" }
                        }
                    }
                }
            },
            gridOptions: {
                columns: [
                    { title: "ІД запиту", field: "ReqId" },
                    { title: "Дата вставки", field: "InsertTime", template: "<div style='text-align:center;'>#=(InsertTime == null) ? ' ' : kendo.toString(InsertTime,'dd.MM.yyyy HH:mm:ss')#</div>" },
                    { title: "Дата конвертації", field: "ConvertTime", template: "<div style='text-align:center;'>#=(ConvertTime == null) ? ' ' : kendo.toString(ConvertTime,'dd.MM.yyyy HH:mm:ss')#</div>" },
                    { title: "Дата відправки", field: "SendTime", template: "<div style='text-align:center;'>#=(SendTime == null) ? ' ' : kendo.toString(SendTime,'dd.MM.yyyy HH:mm:ss')#</div>" }
                ]
            }
        }
    };

    function getTitle() {
        switch (type) {
            case "queue":
                return "Черга обробки";
            case "types":
                return "Опис вхідних параметрів";
            case "log":
                return "Журнал прийому";
            case "responseparams":
                return "Параметри відповіді";
            case "requestparams":
                return "Параметри запиту";
            case "response":
                return "Відповідь";
            default:
                return null;
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

        window.find("#resultClobBtn").click(function (event) {
            var grid = window.find('#grid').data("kendoGrid");
            var value = getSelectedValue(grid, "Id");

            if (!value) {
                return;
            }

            $.ajax({
                type: "GET",
                contentType: "application/json",
                url: bars.config.urlContent("/api/TranspUi/TranspUi/GetInputLogClob"),
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
    };

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

    function onWindowActivate() {
        bars.ui.loader("#grid", true);

        var dataSourceOptions = gridSettings[type].dataSourceOptions;

        if (type !== "types") {
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

        if (type === "log")
            window.find("#resultClobBtn").removeClass("invisible");

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