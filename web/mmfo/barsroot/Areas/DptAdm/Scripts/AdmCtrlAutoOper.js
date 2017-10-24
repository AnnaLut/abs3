$(document).ready(function () {

    var dptDataSource = new kendo.data.DataSource({
        type: "aspnetmvc-ajax",
        pageSize: 10,
        serverPaging: true,
        serverFiltering: true,
        transport: {
            read: {
                dataType: 'json',
                url: bars.config.urlContent('/DptAdm/DptAdm/GetDptJobs')
            }
        },
        schema: {
            data: "data",
            total: "total",
            model: {
                fields: {
                    job_code: { type: "string" },
                    job_name: { type: "string" },
                    job_proc: { type: "string" },
                    ord: { type: "int" }
                }
            }
        }
    });

    // функція ініціалізації табів та грідів ресурсів для обраної процедури.
    function detailInit(e) {
        
        var detailRow = e.detailRow;
        var masterRow = e.masterRow;
        var grid = this;
        var rowData = grid.dataItem(masterRow);

        var autoOperTabstripDataSource = new kendo.data.DataSource({
            type: "aspnetmvc-ajax",
            pageSize: 5,
            serverPaging: true,
            serverFiltering: true,
            serverSorting: true,
            transport: {
                read: {                  
                    dataType: "json",
                    url: bars.config.urlContent("/DptAdm/DptAdm/GetDptJobsJrnl"),
                    data: { JOB_ID: rowData.job_id },
                    success: function (elem) {

                    },
                    error: function (xhr, error) {
                        bars.ui.error({ text: "Сталася помилка при спробі завантажити дані.<br/>" + error });
                    }
                },
                parameterMap: function (data, operation) {
                    debugger;
                    return kendo.stringify(data);
                }
            },
            schema: {
                data: "Data",
                total: "Total",
                model: {
                    fields: {
                        RUN_ID: { type: "number" },
                        JOB_ID: { type: "number" },
                        START_DATE: { type: "date" },
                        FINISH_DATE: { type: "date" },
                        BANK_DATE: { type: "date" },
                        USER_ID: { type: "number" },
                        STATUS: { type: "number" },
                        ERRMSG: { type: "string" },
                        BRANCH: { type: "string" },
                        DELETED: { type: "date" },
                        KF: { type: "string" }                       
                    }
                }
            }
        });

        detailRow.find("#AutoOperTabstrip").kendoTabStrip({
            animation: {
                open: { effects: "fadeIn" }
            }
        });

        detailRow.find("#job_jrnl").kendoGrid({
            dataSource: autoOperTabstripDataSource,
            scrollable: false,
            sortable: true,
            filterable: true,
            pageable: true,
            detailTemplate: kendo.template($("#templateLog").html()),
            detailInit: detailInitLog,
            columns: [{
                field: "KF",
                title: "KF",               
                width: "90px"
            },
            {
                field: "START_DATE",
                title: "START_DATE",
                format: "{0:dd/MM/yyyy}",
                width: "80px"
            },
             {
                 field: "FINISH_DATE",
                 title: "FINISH_DATE",
                 format: "{0:dd/MM/yyyy}",
                 width: "80px"
             },
             {
                 field: "BANK_DATE",
                 title: "BANK_DATE",
                 format: "{0:dd/MM/yyyy}",
                 width: "80px"
             },
             {
                 field: "USER_ID",
                 title: "USER_ID",
                 width: "70px"
             },
             {
                 field: "STATUS",
                 title: "STATUS",
                 width: "40px"
             },
             {
                 field: "ERRMSG",
                 title: "ERRMSG",
                 width: "230px"
             },
             {
                 field: "BRANCH",
                 title: "BRANCH",
                 width: "230px"
             }]
        });
    };


    // функція ініціалізації табів та грідів ресурсів для подробиць процедури.
    function detailInitLog(e) {
        
        var detailRow = e.detailRow;
        var masterRow = e.masterRow;
        var grid = this;
        var rowData = grid.dataItem(masterRow);

        var autoOperTabstripDataSource = new kendo.data.DataSource({
            type: "aspnetmvc-ajax",
            pageSize: 5,
            serverPaging: true,
            serverFiltering: true,
            serverSorting: true,
            transport: {
                read: {
                    dataType: "json",
                    url: bars.config.urlContent("/DptAdm/DptAdm/GetDptJobsBlog"),
                    data: { RUN_ID: rowData.RUN_ID },
                    success: function (elem) {

                    },
                    error: function (xhr, error) {
                        bars.ui.error({ text: "Сталася помилка при спробі завантажити дані.<br/>" + error });
                    }
                },
                parameterMap: function (data, operation) {
                    debugger;
                    return kendo.stringify(data);
                }
            },
            schema: {
                data: "Data",
                total: "Total",
                model: {
                    fields: {
                        REC_ID: { type: "number" },
                        RUN_ID: { type: "number" },
                        JOB_ID: { type: "number" },
                        DPT_ID: { type: "number" },
                        BRANCH: { type: "string" },
                        REF: { type: "number" },
                        RNK: { type: "number" },
                        KV: { type: "number" },
                        DPT_SUM: { type: "number" },
                        INT_SUM: { type: "number" },
                        STATUS: { type: "number" },
                        ERRMSG: { type: "string" },
                        NLS: { type: "string" },
                        CONTRACT_ID: { type: "number" },
                        DEAL_NUM: { type: "string" },
                        RATE_VAL: { type: "number" },
                        RATE_DAT: { type: "date" },
                        KF: { type: "string" }    
                    }
                }
            }
        });

        detailRow.find("#AutoOperTabstripLog").kendoTabStrip({
            animation: {
                open: { effects: "fadeIn" }
            }
        });

        detailRow.find("#job_jrnl_log").kendoGrid({
            dataSource: autoOperTabstripDataSource,
            filterable: true,
            scrollable: true,
            resizable: true,
            sortable: true,
            pageable: true,
            height: 220,
            columns: [{
                field: "RUN_ID",
                title: "RUN_ID",
                width: "90px"
            },
            {
                field: "DPT_ID",
                title: "DPT_ID",
                width: "90px"
            },
            {
                field: "BRANCH",
                title: "BRANCH",
                width: "180px"
            },
            {
                field: "REF",
                title: "REF",
                width: "90px"
            },
            {
                field: "RNK",
                title: "RNK",
                width: "90px"
            },
            {
                field: "KV",
                title: "KV",
                width: "50px"
            },
            {
                field: "DPT_SUM",
                title: "DPT_SUM",
                width: "90px"
            },
            {
                field: "INT_SUM",
                title: "INT_SUM",
                width: "90px"
            },
            {
                field: "STATUS",
                title: "STATUS",
                width: "50px"
            },
            {
                field: "ERRMSG",
                title: "ERRMSG",
                width: "250px"
            },
            {
                field: "NLS",
                title: "NLS",
                width: "130px"
            },
            {
                field: "CONTRACT_ID",
                title: "CONTRACT_ID",
                width: "90px"
            },
            {
                field: "DEAL_NUM",
                title: "DEAL_NUM",
                width: "90px"
            },
            {
                field: "RATE_VAL",
                title: "RATE_VAL",
                width: "90px"
            },           
            {
                field: "RATE_DAT",
                title: "RATE_DAT",
                format: "{0:dd/MM/yyyy}",
                width: "90px"
            }
            ]
        });

        
    };

    var grid_dpt_types = $('#grid_job_list').kendoGrid({
        autobind: true,
        selectable: "row",
        sortable: true,
        scrolable: true,
        columns: [{
            field: "job_code",
            title: "Код типу",
            width: "100px"
        },
                  {
                      field: "job_name",
                      title: "Назва",
                      width: "300px"
                  },
                   {
                       field: "job_proc",
                       title: "Процедура",
                       width: "150px"
                   },
                {
                    field: "ord",
                    title: "Пор.сортування",
                    width: "20px"
                },
                {
                    command: {text: "Виконати", click: executeProc},
                    title: "Виконати",
                    width: "50px"                    
                }
        ],
        dataSource: dptDataSource,
        detailTemplate: kendo.template($("#template").html()),
        detailInit: detailInit,       
        filterable: true,
    });
});

function executeProc(e) {
    e.preventDefault();
    //выбираем рядок со значениями 
    var dataItem = this.dataItem($(e.currentTarget).closest("tr"));
    //выдиляем рядок
    this.select($(e.currentTarget).closest("tr"));
    // винимаем название процедуры
    $('#proc_name').text(dataItem.job_name);
    $.ajax({
        type: "POST",
        url: bars.config.urlContent('/DptAdm/DptAdm/DoJobCode'),
        data: { JOB_CODE: dataItem.job_code },
        beforeSend: function () {
            //запускаем таймер
            timer();
            //скрываем таблицу и отображаем спиннер с таймером 
            $('#loading').show();
            $('#panel_title').hide();
            $('#panel_proc_title').show();
            $('#panel_body').hide();            
            $('#timer').show();
        },
        complete: function () {
            $('#loading').hide();
            $('#panel_title').show();
            $('#panel_proc_title').hide();
            $('#panel_body').show();
            //останавливаем счётчик
            clearInterval(interval);
            $('#timer').hide();
        },
        success: function (data) {
            if (data.message != null) {
                bars.ui.error({                    
                    text: data.message
                });
            } else {
                bars.ui.success({
                    text: "Процедура виконана успішно!"
                });
            }
        }
    });
};

var interval;
var timer = function () {
    var time = 0,
       hours,
       minutes,
       seconds;
    interval = setInterval(function () {
        hours = parseInt(time / 3600 % 24, 10);
        minutes = parseInt(time / 60 % 60, 10);
        seconds = parseInt(time % 60, 10);
        hours = hours < 10 ? "0" + hours : hours;
        minutes = minutes < 10 ? "0" + minutes : minutes;
        seconds = seconds < 10 ? "0" + seconds : seconds;
        $('#timer').text(hours + ":" + minutes + ":" + seconds);
        time++;
     }, 1000);
};

