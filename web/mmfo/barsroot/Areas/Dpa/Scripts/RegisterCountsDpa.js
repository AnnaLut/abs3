angular.module('BarsWeb.Controllers', [])
.controller('RegisterCountsDpa', ['$scope', '$http', function ($scope, $http) {
    $scope.AjaxGetFunction = function (url) {
        $.ajax({
            url: url,
            method: "GET",
            dataType: "json",
            async: false,
            complete:
                    function (data) {
                        $('#mydiv').hide();
                        $scope.tmp = data.responseJSON;
                    }
        });
        return $scope.tmp;
    };

    $scope.AjaxPostFunction = function (url, post_data,callBackFunction) {
        $.ajax({
            url: url,
            method: "POST",
            dataType: "json",
            data: post_data,
            contentType: "application/json",
            async: false,
            complete:
                    function (data) {
                        $('#mydiv').hide();
                        $scope.tmp = data.responseJSON;
                        if(typeof(callBackFunction) == 'function')
                        callBackFunction();
                    }
        });
        return $scope.tmp;
    };

    angular.element('#mydiv').hide();
    $scope.kvs = $scope.AjaxGetFunction(bars.config.urlContent("/api/Dpa/RegisterCountsDpaApi/GetKVs"));
    $scope.countries = $scope.AjaxGetFunction(bars.config.urlContent("/api/Dpa/RegisterCountsDpaApi/GetCountries"));
    $scope.branch = $scope.AjaxGetFunction(bars.config.urlContent("/api/Dpa/RegisterCountsDpaApi/GetBranch"));
    $scope.dateFromDate = kendo.toString(kendo.parseDate($scope.AjaxGetFunction(bars.config.urlContent("/api/Dpa/RegisterCountsDpaApi/GetBankDate")), 'yyyy-MM-dd'), 'dd/MM/yyyy');
    $scope.processFileName = "";
    $scope.date_selected = false;
    $scope.ListViewData = [];
    $scope.ProcessFileData = [];
    $scope.formed_files = true;
    $scope.process_files = true;
    $scope.k_file_disable = true;
    $scope.in_archive = false;
    $scope.print_f0_name = "";
    $scope.save_file_name = "";

    $scope.GetEmptyListFiles = function (fileType) {
        if (fileType === "F") {
            $scope.listViewGridOptions = {
                dataSource: {
                    data: [],
                    schema: {
                        model: {
                            fields: {
                                fileName: { type: "string" }
                            }
                        }
                    }
                },
                columns:
                    [
                    {
                        field: "fileName",
                        title: $scope.path,
                        width: "300px"
                    }],
                selectable: "row",
                scrollable: true,
                height: 440
            }
        }
        else {
            $scope.listRViewGridOptions = {
                dataSource: {
                    data: [],
                    schema: {
                        model: {
                            fields: {
                                fileName: { type: "string" }
                            }
                        }
                    }
                },
                columns:
                    [
                    {
                        field: "fileName",
                        title: $scope.path,
                        width: "300px"
                    }],
                selectable: "row",
                scrollable: true,
                height: 440
            }
        }
    };

    $scope.GetDataListFiles = function (fileType, data) {
        if (fileType === "F") {
            $scope.listViewGridOptions = {
                dataSource: {
                    data: data,
                    schema: {
                        model: {
                            fields: {
                                fileName: { type: "string" }
                            }
                        }
                    }
                },
                columns:
                    [
                    {
                        field: "fileName",
                        title: $scope.path,
                        width: "300px"
                    }],
                selectable: "row",
                scrollable: true,
                height: 440
            }
        }
        else {
            $scope.listRViewGridOptions = {
                dataSource: {
                    data: data,
                    schema: {
                        model: {
                            fields: {
                                fileName: { type: "string" }
                            }
                        }
                    }
                },
                columns:
                    [
                    {
                        field: "fileName",
                        title: $scope.path,
                        width: "300px"
                    }],
                selectable: "row",
                scrollable: true,
                height: 440
            }
        }
    };

    $scope.GetEmptyListArchive = function (fileType) {
        if (fileType === "F") {
            $scope.listViewGridOptions = {
                dataSource: {
                    data: [],
                    schema: {
                        model: {
                            fields: {
                                FNK: { type: "string" }
                            }
                        }
                    }
                },
                columns:
                    [
                    {
                        field: "FNK",
                        title: $scope.path,
                        width: "300px"
                    }],
                selectable: "row",
                scrollable: true,
                height: 440
            }
        }
        else {
            $scope.listRViewGridOptions = {
                dataSource: {
                    data: [],
                    schema: {
                        model: {
                            fields: {
                                FN: { type: "string" }
                            }
                        }
                    }
                },
                columns:
                    [
                    {
                        field: "FN",
                        title: $scope.path,
                        width: "300px"
                    }],
                selectable: "row",
                scrollable: true,
                height: 440
            }
        }
    };

    $scope.GetDataListArchive = function (fileType, data) {
        if (fileType === "F") {
            $scope.listViewGridOptions = {
                dataSource: {
                    data: data,
                    schema: {
                        model: {
                            fields: {
                                FNK: { type: "string" }
                            }
                        }
                    }
                },
                columns:
                    [
                    {
                        field: "FNK",
                        title: $scope.path,
                        width: "300px"
                    }],
                selectable: "row",
                scrollable: true,
                height: 440
            }
        }
        else {
            $scope.listRViewGridOptions = {
                dataSource: {
                    data: data,
                    schema: {
                        model: {
                            fields: {
                                FN: { type: "string" }
                            }
                        }
                    }
                },
                columns:
                    [
                    {
                        field: "FN",
                        title: $scope.path,
                        width: "300px"
                    }],
                selectable: "row",
                scrollable: true,
                height: 440
            }
        }
    };

    //получаем столбцы для грида 
    $scope.GetColumnsForGrid = function (file_type, columns_width) {
        if (file_type === "F") {
            return [
                {
                    field: "IDROW",
                    hidden: true
                },
                {
                    field: "MFO",
                    title: "МФО",
                    width: "90px"
                },
                {
                    field: "ID_A",
                    title: "ЗКПО",
                    width: "100px"
                },
                {
                    field: "RT",
                    title: "Реєстр",
                    width: "70px"
                },
                {
                    field: "OT",
                    title: "Опр.",
                    editor: kvDropDownEditor,
                    template: '#: GetName(OT, "OT") #',
                    width: "90px"
                },
                {
                    field: "ODAT",
                    title: "Дата операції",
                    template: "#= kendo.toString(kendo.parseDate(ODAT, 'yyyy-MM-dd'), 'dd/MM/yyyy') #",
                    width: "90px"
                },
                {
                    field: "NLS",
                    title: "Рахунок клієнта",
                    width: "150px"
                },
                {
                    field: "KV",
                    title: "Валюта",
                    format: "{0:0}",
                    editor: kvDropDownEditor,
                    template: '#: GetName(KV, "KV") #',
                    width: "110px"
                },
                {
                    field: "C_AG",
                    title: "Рез.",
                    editor: kvDropDownEditor,
                    template: '#: GetName(C_AG, "C_AG") #',
                    width: "110px"
                },
                {
                    field: "NMK",
                    title: "Назва",
                    width: columns_width
                },
                {
                    field: "ADR",
                    title: "Адреса",
                    width: columns_width
                },
                {
                    field: "C_REG",
                    title: "Код ДПА",
                    width: "70px"
                },
                {
                    field: "C_DST",
                    title: "Код ограну реєстрації",
                    format: "{0:0}",
                    width: "70px"
                }
            ];
        }
        else if (file_type === "CA") {
            return [
                    {
                        field: "IDROW",
                        hidden: true
                    },
                    {
                        field: "MFO",
                        title: "МФО",
                        width: "90px"
                    },
                    {
                        field: "NB",
                        title: "Банк",
                        width: columns_width
                    },
                    {
                        field: "NLS",
                        title: "Рахунок",
                        width: columns_width
                    },
                    {
                        field: "DAOS",
                        title: "Дата відкриття",
                        template: "#= kendo.toString(kendo.parseDate(DAOS, 'yyyy-MM-dd'), 'dd/MM/yyyy') #",
                        width: columns_width

                    },
                    {
                        field: "VID",
                        title: "Вид",
                        width: columns_width
                    },
                    {
                        field: "TVO",
                        title: "ТВО",
                        width: columns_width
                    },
                    {
                        field: "NAME_BLOCK",
                        title: "Ім'я блоку",
                        width: columns_width
                    },
                    {
                        field: "FIO_BLOCK",
                        title: "ФІО блок",
                        width: columns_width
                    },
                    {
                        field: "FIO_ISP",
                        title: "ФІО",
                        width: columns_width
                    },
                    {
                        field: "INF_ISP",
                        title: "ІНФ",
                        width: columns_width
                    },
                    {
                        field: "ADDR",
                        title: "Адреса",
                        width: columns_width
                    },
                    {
                        field: "OKPO",
                        title: "ЗКПО",
                        width: columns_width
                    }
            ];
        }
        else if (file_type === "CV") {
            return [
                {
                    field: "IDROW",
                    hidden: true
                },
                 {
                     field: "NLS",
                     title: "Рахунок",
                     width: columns_width
                 },
                 {
                     field: "VID",
                     title: "ВІД",
                     format: "{0:0}",
                     width: columns_width
                 },
                {
                    field: "FDAT",
                    title: "Дата",
                    template: "#= kendo.toString(kendo.parseDate(FDAT, 'yyyy-MM-dd'), 'dd/MM/yyyy') #",
                    width: columns_width
                },
                {
                    field: "OPLDOC_REF",
                    title: "РЕФ",
                    width: columns_width,
                    hidden: true
                },
                {
                    field: "MFO_D",
                    title: "МФО А",
                    width: columns_width
                },
                 {
                     field: "NLS_D",
                     title: "Рахунок А",
                     width: columns_width
                 },
                 {
                     field: "MFO_K",
                     title: "МФО Б",
                     width: columns_width
                 },
                 {
                     field: "NLS_K",
                     title: "Рахунок Б",
                     width: columns_width
                 },
                 {
                     field: "DK",
                     title: "ДК",
                     format: "{0:0}",
                     width: columns_width
                 },
                 {
                     field: "S",
                     title: "Сума",
                     format: "{0:0}",
                     width: columns_width
                 },
                 {
                     field: "VOB",
                     title: "Вид",
                     format: "{0:0}",
                     width: columns_width
                 },
                 {
                     field: "ND",
                     title: "№ документа",
                     width: columns_width
                 },
                 {
                     field: "KV",
                     title: "Валюта",
                     format: "{0:0}",
                     editor: kvDropDownEditor,
                     template: '#: GetName(KV, "KV") #',
                     width: columns_width
                 },
                 {
                     field: "DATD",
                     title: "Дата документу",
                     template: "#= kendo.toString(kendo.parseDate(DATD, 'yyyy-MM-dd'), 'dd/MM/yyyy') #",
                     width: columns_width
                 },
                 {
                     field: "DATP",
                     title: "Дата сплати",
                     template: "#= kendo.toString(kendo.parseDate(DATP, 'yyyy-MM-dd'), 'dd/MM/yyyy') #",
                     width: columns_width
                 },
                 {
                     field: "NAM_A",
                     title: "Платник",
                     width: columns_width
                 },
                 {
                     field: "NAM_B",
                     title: "Отримувач",
                     width: columns_width
                 },
                 {
                     field: "NAZN",
                     title: "Призначення",
                     width: columns_width
                 },
                 {
                     field: "D_REC",
                     title: "Додатковий реквізит",
                     width: columns_width
                 },
                 {
                     field: "NAZNK",
                     title: "Призн. до",
                     width: columns_width
                 },
                 {
                     field: "NAZNS",
                     title: "Призн. з",
                     width: columns_width
                 },
                 {
                     field: "ID_D",
                     title: "ЗКПО А",
                     width: columns_width
                 },
                 {
                     field: "ID_K",
                     title: "ЗКПО Б",
                     width: columns_width
                 },
                 {
                     field: "REF",
                     title: "Реф.",
                     format: "{0:0}",
                     width: columns_width
                 },
                 {
                     field: "DAT_A",
                     title: "Дата А",
                     template: "#= kendo.toString(kendo.parseDate(DAT_A, 'yyyy-MM-dd'), 'dd/MM/yyyy') #",
                     width: columns_width
                 },
                 {
                     field: "DAT_B",
                     title: "Дата Б",
                     template: "#= kendo.toString(kendo.parseDate(DAT_B, 'yyyy-MM-dd'), 'dd/MM/yyyy') #",
                     width: columns_width
                 }
            ];
        }
        else if (file_type === "F2") {
            return [
                {
                    field: "ERR",
                    title: "Код помилки",
                    width: columns_width
                },
                {
                    field: "MFO",
                    title: "МФО",
                    width: columns_width
                },
                {
                    field: "OKPO",
                    title: "ЗКПО",
                    width: columns_width
                },
                {
                    field: "RTYPE",
                    title: "Тип держ. реєстра",
                    width: columns_width
                },
                {
                    field: "NMMK",
                    title: "Найменування клієнта",
                    width: columns_width
                },
                {
                    field: "OTYPE",
                    title: "Тип оп.",
                    format: "{0:0}",
                    width: columns_width
                },
                {
                    field: "ODATE",
                    title: "Дата операції",
                    template: "#= kendo.toString(kendo.parseDate(ODATE, 'yyyy-MM-dd'), 'dd/MM/yyyy') #",
                    width: columns_width
                },
                {
                    field: "NLS",
                    title: "Рахунок",
                    width: columns_width
                },
                {
                    field: "KV",
                    title: "Валюта",
                    width: columns_width
                },
                {
                    field: "RESID",
                    title: "Код ДПА",
                    width: columns_width
                }
            ];
        }
        else if (file_type === "F0List") {
            return [
                    {
                        field: "FN",
                        title: "Назва файлу",
                        width: "200px"
                    },
                    {
                        field: "D_f0", //previous DAT
                        title: "Дата файлу",
                        //template: "#= kendo.toString(kendo.parseDate(D_f0, 'yyyy-MM-dd'), 'dd/MM/yyyy') #",
                        //template: "#= kendo.toString(D_f0, 'dd/MM/yyyy') #",
                        format: "{0:dd/MM/yyyy}",
                        filterable:
                        {
                            //ui: "datepicker"
                            ui: function (element) {
                                element.kendoDatePicker({
                                    format: "dd/MM/yyyy"
                                });
                            }
                        },
                        width: "100px"
                    },
                    {
                        field: "D_f1",
                        title: "Дата та час надходження квитанції @F1",
                        //template: "#= kendo.toString(D_f1, 'dd/MM/yyyy HH:mm:ss') #",
                        format: "{0:dd/MM/yyyy HH:mm}",
                        filterable:
                        {
                            //ui: "datetimepicker"
                            ui: function (element) {
                                element.kendoDateTimePicker({
                                    format: "dd/MM/yyyy HH:mm"
                                });
                            }
                        },
                        width: "100px"
                    },
                    {
                        field: "D_f2",
                        title: "Дата та час надходження квитанції @F2",
                        //template: "#= kendo.toString(D_f2, 'dd/MM/yyyy HH:mm:ss') #",
                        format: "{0:dd/MM/yyyy HH:mm}",
                        filterable:
                        {
                            //ui: "datetimepicker"
                            ui: function (element) {
                                element.kendoDateTimePicker({
                                    format: "dd/MM/yyyy HH:mm"
                                });
                            }
                        },
                        width: "100px"
                    },
                    {
                        field: "D_r0",
                        title: "Дата та час надходження квитанції @R0",
                        //template: "#= kendo.toString(D_r0,'dd/MM/yyyy HH:mm:ss') #",
                        format: "{0:dd/MM/yyyy HH:mm}",
                        filterable:
                        {
                            //ui: "datetimepicker"
                            ui: function (element) {
                                element.kendoDateTimePicker({
                                    format: "dd/MM/yyyy HH:mm"
                                });
                            }
                        },
                        width: "100px"
                    },
                    {
                        field: "ERR",
                        title: "Код помилки",
                        width: "100px"
                    },
                    {
                        field: "ERR_MSG",
                        title: "Найменування  помилки",
                        width: "250px"
                    }
            ]
        }
        else if (file_type === "K0List") {
            return [
                    {
                        field: "FN",
                        title: "Назва файлу",
                        width: "200px"
                    },
                    {
                        field: "DAT",
                        title: "Дата файлу",
                        template: "#= kendo.toString(kendo.parseDate(DAT, 'yyyy-MM-dd'), 'dd/MM/yyyy') #",
                        width: "100px"
                    },
                    {
                        field: "ERR",
                        title: "Код помилки",
                        width: "100px"
                    }
            ]
        }
        else if (file_type === "F0") {
            return [
                {
                    field: "MFO",
                    title: "МФО",
                    width: columns_width
                },
                {
                    field: "OKPO",
                    title: "ЗКПО",
                    width: columns_width
                },
                {
                    field: "RTYPE",
                    title: "Тип держ. реєстра",
                    width: columns_width
                },
                {
                    field: "OTYPE",
                    title: "Тип оп.",
                    format: "{0:0}",
                    width: columns_width
                },
                {
                    field: "ODATE",
                    title: "Дата операції",
                    template: "#= kendo.toString(kendo.parseDate(ODATE, 'yyyy-MM-dd'), 'dd/MM/yyyy') #",
                    width: columns_width
                },
                {
                    field: "NLS",
                    title: "Рахунок",
                    width: columns_width
                },
                {
                    field: "KV",
                    title: "Валюта",
                    width: columns_width
                },
                {
                    field: "RESID",
                    title: "Код ДПА",
                    width: columns_width
                },
                {
                    field: "NMKK",
                    title: "Найменування клієнта",
                    width: columns_width
                },
                {
                    field: "ADR",
                    title: "Адреса",
                    width: columns_width
                },
                {
                    field: "C_REG",
                    title: "Код ДПА",
                    width: columns_width
                },
                {
                    field: "C_DST",
                    title: "Код ограну реєстрації",
                    width: columns_width
                },
                {
                    field: "ERR",
                    title: "Код помилки",
                    width: columns_width
                },
                {
                    field: "KOD_REG",
                    hidden: true
                },
                {
                    field: "REC_O",
                    hidden: true
                }
            ];
        }
        else if (file_type === "K0") {
            return [
                {
                    field: "MFO",
                    title: "МФО",
                    width: columns_width
                },
                {
                    field: "OKPO",
                    title: "ЗКПО",
                    width: columns_width
                },
                {
                    field: "OTYPE",
                    title: "Тип оп.",
                    format: "{0:0}",
                    width: columns_width
                },
                {
                    field: "DAT",
                    title: "Дата операції",
                    template: "#= kendo.toString(kendo.parseDate(DAT, 'yyyy-MM-dd'), 'dd/MM/yyyy') #",
                    width: columns_width
                },
                {
                    field: "NLS",
                    title: "Рахунок",
                    width: columns_width
                },
                {
                    field: "KV",
                    title: "Валюта",
                    width: columns_width
                },
                {
                    field: "RESID",
                    title: "Код ДПА",
                    width: columns_width
                },
                {
                    field: "COUNTRY",
                    title: "Країна",
                    width: columns_width
                },
                {
                    field: "NMKK",
                    title: "Назва",
                    width: columns_width
                },
                {
                    field: "C_REG",
                    title: "Код ДПА",
                    width: columns_width
                },
                {
                    field: "ERR",
                    title: "Код помилки",
                    width: columns_width
                }
            ];
        }
        else if (file_type === "R0") {
            return [
                {
                    field: "ERR",
                    title: "Код помилки",
                    width: columns_width
                },
                {
                    field: "COM",
                    title: "Пояснення",
                    width: columns_width
                },
                {
                    field: "MFO",
                    title: "МФО",
                    width: columns_width
                },
                {
                    field: "OKPO",
                    title: "ЗКПО",
                    width: columns_width
                },
                {
                    field: "RTYPE",
                    title: "Тип держ. реєстра",
                    width: columns_width
                },
                {
                    field: "NMKK",
                    title: "Найменування клієнта",
                    width: columns_width
                },
                {
                    field: "ODATE",
                    title: "Дата операції",
                    template: "#= kendo.toString(kendo.parseDate(ODATE, 'yyyy-MM-dd'), 'dd/MM/yyyy') #",
                    width: columns_width
                },
                {
                    field: "NLS",
                    title: "Рахунок",
                    width: columns_width
                },
                {
                    field: "KV",
                    title: "Валюта",
                    width: columns_width
                },
                {
                    field: "RESID",
                    title: "Резидентність",
                    width: columns_width
                },
                {
                    field: "DAT_IN_DPA",
                    title: "Дата отримання повідомлення",
                    template: "#= kendo.toString(kendo.parseDate(DAT_IN_DPA, 'yyyy-MM-dd'), 'dd/MM/yyyy') #",
                    width: columns_width
                },
                {
                    field: "DAT_ACC_DPA",
                    title: "Дата взяття рахунка на облік",
                    template: "#= kendo.toString(kendo.parseDate(DAT_IN_DPA, 'yyyy-MM-dd'), 'dd/MM/yyyy') #",
                    width: columns_width
                },
                {
                    field: "ID_PR",
                    title: "Код причини відмови у взяті на облік",
                    width: columns_width
                },
                {
                    field: "ID_DPA",
                    title: "Код ДПА",
                    width: columns_width
                },
                {
                    field: "ID_DPS",
                    title: "Код ДПС",
                    width: columns_width
                },
                {
                    field: "ID_REC",
                    title: "Ідентифікатор запису",
                    width: columns_width
                },
                {
                    field: "FN_F",
                    title: "Найменування файлу",
                    width: columns_width
                },
                {
                    field: "N_F",
                    title: "Порядковий номер файлу",
                    width: columns_width
                }
            ];
        }
        else if (file_type === "K") {
            return [
                {
                    field: "IDROW",
                    hidden: true
                },
                {
                    field: "MFO",
                    title: "МФО",
                    width: columns_width
                },
                {
                    field: "NMK",
                    title: "Назва",
                    width: columns_width
                },
                {
                    field: "OT",
                    title: "Опр.",
                    editor: kvDropDownEditor,
                    template: '#: GetName(OT, "OT") #',
                    width: columns_width
                },
                {
                    field: "ODAT",
                    title: "Дата операції",
                    template: "#= kendo.toString(kendo.parseDate(ODAT, 'yyyy-MM-dd'), 'dd/MM/yyyy') #",
                    width: columns_width
                },
                {
                    field: "NLS",
                    title: "Рахунок клієнта",
                    width: columns_width
                },
                {
                    field: "KV",
                    title: "Валюта",
                    format: "{0:0}",
                    editor: kvDropDownEditor,
                    template: '#: GetName(KV, "KV") #',
                    width: columns_width
                },
                {
                    field: "C_AG",
                    title: "Рез.",
                    editor: kvDropDownEditor,
                    template: '#: GetName(C_AG, "C_AG") #',
                    width: columns_width
                },
                {
                    field: "C_REG",
                    title: "Код ДПА",
                    width: columns_width
                },
                {
                    field: "COUNTRY",
                    title: "Країна",
                    editor: kvDropDownEditor,
                    template: '#: GetName(COUNTRY, "COUNTRY") #',
                    width: columns_width
                },
                {
                    field: "OKPO",
                    title: "ЗКПО",
                    width: columns_width
                }
            ];
        }
        else if (file_type === "K2") {
            return [
                {
                    field: "ERR",
                    title: "Код помилки",
                    width: columns_width
                },
                {
                    field: "MFO",
                    title: "МФО",
                    width: columns_width
                },
                {
                    field: "OKPO",
                    title: "ЗКПО",
                    width: columns_width
                },
                {
                    field: "OTYPE",
                    title: "Тип оп.",
                    format: "{0:0}",
                    width: columns_width
                },
                {
                    field: "DAT",
                    title: "Дата операції",
                    template: "#= kendo.toString(kendo.parseDate(DAT, 'yyyy-MM-dd'), 'dd/MM/yyyy') #",
                    width: columns_width
                },
                {
                    field: "NLS",
                    title: "Рахунок",
                    width: columns_width
                },
                {
                    field: "KV",
                    title: "Валюта",
                    width: columns_width
                },
                {
                    field: "RESID",
                    title: "Код ДПА",
                    width: columns_width
                },
                {
                    field: "COUNTRY",
                    title: "Країна",
                    width: columns_width
                },
                {
                    field: "NMKK",
                    title: "Назва",
                    width: columns_width
                },
                {
                    field: "C_REG",
                    title: "Код ДПА",
                    width: columns_width
                }
            ];
        }
    };

    //получаем данные для грида 
    $scope.GetDataSourceForGrid = function (file_type) {
        if (file_type === "F") {
            $scope.save_file_name = "@F";
            return {
                async: false,
                type: 'webapi',
                transport: {
                    read: {
                        url: bars.config.urlContent("/api/Dpa/RegisterCountsDpaApi/GetDataForFileReport") + "?date=" + "&fileType="
                    }
                },
                schema: {
                    data: "Data",
                    model: {
                        fields: {
                            IDROW: { type: 'string' },
                            MFO: {
                                type: 'string',
                                validation:
                                    {
                                        required: { message: "Поле МФО обов'язкове!" }
                                    }
                            },
                            ID_A: {
                                type: 'string',
                                validation:
                                    {
                                        required: { message: "Поле ЗКПО обов'язкове!" }
                                    }
                            },
                            RT: {
                                type: 'number',
                                validation: {
                                    required: { message: "Поле Реєстр обов'язкове!" }
                                }
                            },
                            OT: {
                                type: 'string',
                                validation: {
                                    required: { message: "Поле Операція обов'язкове!" }
                                }
                            },
                            ODAT: {
                                type: 'date',
                                validation: {
                                    required: { message: "Поле Дата реєстрації обов'язкове!" }
                                }
                            },
                            NLS: {
                                type: 'string',
                                validation: {
                                    required: { message: "Поле Рахунок клієнта обов'язкове!" },
                                    onlynumber: function (input) {
                                        if (input.is("[name='NLS']") && input.val() != "") {
                                            input.attr("data-onlynumber-msg", "Має бути числом.");
                                            return /^[0-9]/.test(input.val());
                                        }

                                        return true;
                                    },
                                    amount: function (input) {
                                        if (input.is("[name='NLS']") && input.val() != "") {
                                            input.attr("data-amount-msg", "Має буди більше 5 символів.");
                                            if (input.val().length < 5) {
                                                return false;
                                            }
                                        }

                                        return true;
                                    }
                                }
                            },
                            KV: {
                                type: 'number',
                                validation: {
                                    required: { message: "Поле Валюта обов'язкове!" }
                                }
                            },
                            C_AG: {
                                type: 'string',
                                validation: {
                                    required: { message: "Поле Рез. обов'язкове!" }
                                }
                            },
                            NMK: {
                                type: 'string',
                                validation: {
                                    required: { message: "Поле Назва обов'язкове!" },
                                    maxlength:
                                    function(input) {
                                        if (input.val().length > 38) {
                                            input.attr("data-maxlength-msg", "Кількість символів не повинна перевищувати 38!");
                                            return false;
                                        }
                                        return true;
                                    }
                                }
                            },
                            ADR: {
                                type: 'string',
                                validation: {
                                    required: { message: "Поле Адреса обов'язкове!" }
                                }
                            },
                            C_REG: {
                                type: 'number',
                                validation: {
                                    required: { message: "Поле Код ДПА обов'язкове!" }
                                }
                            },
                            C_DST: {
                                type: 'number',
                                validation: {
                                    required: { message: "Поле Код ограну реєстрації обов'язкове!" }
                                }
                            },
                            KOD_REG: {
                                type: 'string'
                            },
                            REC_O: {
                                type: 'number'
                            }
                        }
                    }
                }

            };
        }
        else if (file_type === "CA") {
            $scope.save_file_name = "CA";
            return {
                type: 'webapi',
                transport: {
                    read: {
                        url: bars.config.urlContent("/api/Dpa/RegisterCountsDpaApi/GetDataForFileReport") + "?date=" + "&fileType="
                    }
                },
                schema: {
                    data: "Data",
                    model: {
                        fields: {
                            IDROW: { type: 'string' },
                            MFO: {
                                type: 'string',
                                validation: {
                                    required: { message: "Поле МФО обов'язкове!" }
                                }
                            },
                            NB: {
                                type: 'string',
                                validation: {
                                    required: { message: "Поле Банк обов'язкове!" }
                                }
                            },
                            NLS: {
                                type: 'string',
                                validation: {
                                    required: { message: "Поле Рахунок обов'язкове!" }
                                }
                            },
                            DAOS: {
                                type: 'date',
                                validation: {
                                    required: { message: "Поле Дата відкриття обов'язкове!" }
                                }
                            },
                            VID: {
                                type: 'string',
                                validation: {
                                    required: { message: "Поле ВІД обов'язкове!" }
                                }
                            },
                            TVO: {
                                type: 'string',
                                validation: {
                                    required: { message: "Поле ТВО обов'язкове!" }
                                }
                            },
                            NAME_BLOK: {
                                type: 'string',
                                validation: {
                                    required: { message: "Поле Ім'я блок обов'язкове!" }
                                }
                            },
                            FIO_BLOK: {
                                type: 'string',
                                validation: {
                                    required: { message: "Поле ФІО блок обов'язкове!" }
                                }
                            },
                            FIO_ISP: {
                                type: 'string',
                                validation: {
                                    required: { message: "Поле ФІО обов'язкове!" }
                                }
                            },
                            INF_ISP: {
                                type: 'string',
                                validation: {
                                    required: { message: "Поле Інф. обов'язкове!" }
                                }
                            },
                            ADDR: {
                                type: 'string',
                                validation: {
                                    required: { message: "Поле Адреса обов'язкове!" }
                                }
                            },
                            OKPO: {
                                type: 'string',
                                validation: {
                                    required: { message: "Поле ЗКПО обов'язкове!" }
                                }
                            }
                        }
                    }
                }

            };
        }
        else if (file_type === "K") {
            $scope.save_file_name = "K";
            return {
                type: 'webapi',
                transport: {
                    read: {
                        url: bars.config.urlContent("/api/Dpa/RegisterCountsDpaApi/GetDataForFileReport") + "?date=" + "&fileType="
                    }
                },
                schema: {
                    data: "Data",
                    model: {
                        fields: {
                            IDROW: { type: 'string' },
                            MFO: {
                                type: 'string',
                                validation: {
                                    required: { message: "Поле МФО обов'язкове!" }
                                }
                            },
                            NMK: {
                                type: 'string',
                                validation: {
                                    required: { message: "Поле Назва обов'язкове!" }
                                },
                                maxlength:
                                function (input) {
                                    if (input.val().length > 38) {
                                        input.attr("data-maxlength-msg", "Кількість символів не повинна перевищувати 38!");
                                        return false;
                                    }
                                    return true;
                                }
                            },
                            OT: {
                                type: 'string',
                                validation: {
                                    required: { message: "Поле Операція обов'язкове!" }
                                }
                            },
                            ODAT: {
                                type: 'date',
                                validation: {
                                    required: { message: "Поле Дата реэстрації обов'язкове!" }
                                }
                            },
                            NLS: {
                                type: 'string',
                                validation: {
                                    required: { message: "Поле Рахунок обов'язкове!" }
                                }
                            },
                            KV: {
                                type: 'string',
                                validation: {
                                    required: { message: "Поле Валюта обов'язкове!" }
                                }
                            },
                            C_AG: {
                                type: 'string',
                                validation: {
                                    required: { message: "Поле Рез обов'язкове!" }
                                }
                            },
                            COUNTRY: {
                                type: 'string',
                                validation: {
                                    required: { message: "Поле Країна обов'язкове!" }
                                }
                            },
                            C_REG: {
                                type: 'number',
                                validation: {
                                    required: { message: "Поле Код ДПА обов'язкове!" }
                                }
                            },
                            OKPO: {
                                type: 'string',
                                validation: {
                                    required: { message: "Поле ЗКПО обов'язкове!" }
                                }
                            }
                        }
                    }
                }

            };
        }
        else if (file_type === "CV") {
            $scope.save_file_name = "CV";
            return {
                type: 'webapi',
                transport: {
                    read: {
                        url: bars.config.urlContent("/api/Dpa/RegisterCountsDpaApi/GetDataForFileReport") + "?date=" + "&fileType="
                    }
                },
                schema: {
                    data: "Data",
                    model: {
                        fields: {
                            IDROW: { type: 'string' },
                            NLS: {
                                type: 'string',
                                validation: {
                                    required: { message: "Поле Рахунок обов'язкове!" }
                                }
                            },
                            OPLDOC_REF: {
                                type: 'number',
                                validation: {
                                    required: { message: "Поле Реф обов'язкове!" },
                                    onlynumber: function (input) {
                                        if (input.is("[name='OPLDOC_REF']") && input.val() != "") {
                                            input.attr("data-productnamevalidation-msg", "Повинно бути числом");
                                            return /^[0-9]/.test(input.val());
                                        }

                                        return true;
                                    }
                                }
                            },
                            VID: {
                                type: 'number',
                                validation: {
                                    required: { message: "Поле ВІД обов'язкове!" },
                                    onlynumber: function (input) {
                                        if (input.is("[name='VID']") && input.val() != "") {
                                            input.attr("data-productnamevalidation-msg", "Повинно бути числом");
                                            return /^[0-9]/.test(input.val());
                                        }

                                        return true;
                                    }
                                }
                            },
                            FDAT: {
                                type: 'date',
                                validation: {
                                    required: { message: "Поле Дата обов'язкове!" }
                                }
                            },
                            MFO_D: {
                                type: 'string',
                                validation: {
                                    required: { message: "Поле МФО А обов'язкове!" }
                                }
                            },
                            NLS_D: {
                                type: 'string',
                                validation: {
                                    required: { message: "Поле Рахунок А обов'язкове!" }
                                }
                            },
                            MFO_K: {
                                type: 'string',
                                validation: {
                                    required: { message: "Поле МФО Б обов'язкове!" }
                                }
                            },
                            NLS_K: {
                                type: 'string',
                                validation: {
                                    required: { message: "Поле Рахунок Б обов'язкове!" }
                                }
                            },
                            DK: {
                                type: 'number',
                                validation: {
                                    required: { message: "Поле ДК обов'язкове!" },
                                    onlynumber: function (input) {
                                        if (input.is("[name='DK']") && input.val() != "") {
                                            input.attr("data-productnamevalidation-msg", "Повинно бути числом");
                                            return /^[0-9]/.test(input.val());
                                        }

                                        return true;
                                    }
                                }
                            },
                            S: {
                                type: 'number',
                                validation: {
                                    required: { message: "Поле Сума обов'язкове!" },
                                    onlynumber: function (input) {
                                        if (input.is("[name='S']") && input.val() != "") {
                                            input.attr("data-productnamevalidation-msg", "Повинно бути числом");
                                            return /^[0-9]/.test(input.val());
                                        }

                                        return true;
                                    }
                                }
                            },
                            VOB: {
                                type: 'number',
                                validation: {
                                    required: { message: "Поле Вид обов'язкове!" },
                                    onlynumber: function (input) {
                                        if (input.is("[name='VOB']") && input.val() != "") {
                                            input.attr("data-productnamevalidation-msg", "Повинно бути числом");
                                            return /^[0-9]/.test(input.val());
                                        }

                                        return true;
                                    }
                                }
                            },
                            ND: {
                                type: 'string',
                                validation: {
                                    required: { message: "Поле № документу обов'язкове!" }
                                }
                            },
                            KV: {
                                type: 'number',
                                validation: {
                                    required: { message: "Поле Валюта обов'язкове!" }
                                }
                            },
                            DATD: {
                                type: 'date',
                                validation: {
                                    required: { message: "Поле Дата документу обов'язкове!" }
                                }
                            },
                            DATP: {
                                type: 'date',
                                validation: {
                                    required: { message: "Поле Дата сплати обов'язкове!" }
                                }
                            },
                            NAM_A: {
                                type: 'string',
                                validation: {
                                    required: { message: "Поле Платник обов'язкове!" }
                                }
                            },
                            NAM_B: {
                                type: 'string',
                                validation: {
                                    required: { message: "Поле Отримувач обов'язкове!" }
                                }
                            },
                            NAZN: {
                                type: 'string',
                                validation: {
                                    required: { message: "Поле Призначення обов'язкове!" }
                                }
                            },
                            D_REC: {
                                type: 'string',
                                validation: {
                                    required: { message: "Поле Додатковий реквізит обов'язкове!" }
                                }
                            },
                            NAZNK: {
                                type: 'string',
                                validation: {
                                    required: { message: "Поле Призн. до обов'язкове!" }
                                }
                            },
                            NAZNS: {
                                type: 'string',
                                validation: {
                                    required: { message: "Поле Призн. з обов'язкове!" }
                                }
                            },
                            ID_D: {
                                type: 'string',
                                validation: {
                                    required: { message: "Поле ЗКПО А обов'язкове!" }
                                }
                            },
                            ID_K: {
                                type: 'string',
                                validation: {
                                    required: { message: "Поле ЗКПО Б обов'язкове!" }
                                }
                            },
                            REF: {
                                type: 'number',
                                validation: {
                                    required: { message: "Поле Реф. обов'язкове!" },
                                    onlynumber: function (input) {
                                        if (input.is("[name='REF']") && input.val() != "") {
                                            input.attr("data-productnamevalidation-msg", "Повинно бути числом");
                                            return /^[0-9]/.test(input.val());
                                        }

                                        return true;
                                    }
                                }
                            },
                            DAT_A: {
                                type: 'date',
                                validation: {
                                    required: { message: "Поле Дата А обов'язкове!" }
                                }
                            },
                            DAT_B: {
                                type: 'date',
                                validation: {
                                    required: { message: "Поле Дата Б обов'язкове!" }
                                }
                            }
                        }
                    }
                }

            };
        }
        else if (file_type === "F2") {
            $scope.save_file_name = $scope.f2_file_name;
            return {
                async: false,
                type: 'webapi',
                transport: {
                    read: {
                        url: bars.config.urlContent("/api/Dpa/RegisterCountsDpaApi/GetF2Grid") + "?fileName=" + $scope.f2_file_name,
                    }
                },
                serverPaging: true,
                serverFiltering: true,
                serverSortering: true,
                pageSize: 13,
                schema: {
                    data: "Data",
                    total: "Total",
                    model: {
                        fields: {
                            ERR: {
                                type: 'string'
                            },
                            MFO: {
                                type: 'string'
                            },
                            OKPO: {
                                type: 'string'
                            },
                            RTYPE: {
                                type: 'number'
                            },
                            NMMK: {
                                type: 'string'
                            },
                            OTYPE: {
                                type: 'string'
                            },
                            ODATE: {
                                type: 'date'
                            },
                            NLS: {
                                type: 'string',
                            },
                            KV: {
                                type: 'number'
                            },
                            RESID: {
                                type: 'number'
                            },
                        }
                    }
                }

            };
        }
        else if (file_type === "F0") {
            $scope.save_file_name = $scope.selected_f0_name;
            return {
                async: false,
                type: 'webapi',
                transport: {
                    read: {
                        url: bars.config.urlContent("/api/Dpa/RegisterCountsDpaApi/GetF0Grid") + "?fileName=" + $scope.selected_f0_name,
                    }
                },
                serverFiltering: true,
                serverSortering: true,
                schema: {
                    data: "Data",
                    total: "Total",
                    model: {
                        fields: {
                            MFO: {
                                type: 'string'
                            },
                            OKPO: {
                                type: 'string'
                            },
                            RTYPE: {
                                type: 'number'
                            },
                            OTYPE: {
                                type: 'number'
                            },
                            ODATE: {
                                type: 'date'
                            },
                            NLS: {
                                type: 'string',
                            },
                            KV: {
                                type: 'number'
                            },
                            NMKK: {
                                type: 'string'
                            },
                            ADR: {
                                type: 'string'
                            },
                            RESID: {
                                type: 'number'
                            },
                            C_REG: {
                                type: 'number'
                            },
                            ID_DPS: {
                                type: 'number'
                            },
                            C_DST: {
                                type: 'number'
                            },
                            KOD_REG: {
                                type: 'string'
                            },
                            REC_O: {
                                type: 'number'
                            },
                            ERR: {
                                type: 'string'
                            },
                        }
                    }
                }

            };
        }
        else if (file_type === "K0") {
            $scope.save_file_name = $scope.selected_f0_name;
            return {
                async: false,
                type: 'webapi',
                transport: {
                    read: {
                        url: bars.config.urlContent("/api/Dpa/RegisterCountsDpaApi/GetF0Grid") + "?fileName=" + $scope.selected_f0_name,
                    }
                },
                serverFiltering: true,
                serverSortering: true,
                schema: {
                    data: "Data",
                    total: "Total",
                    model: {
                        fields: {
                            MFO: {
                                type: 'string'
                            },
                            OKPO: {
                                type: 'string'
                            },
                            OTYPE: {
                                type: 'number'
                            },
                            ODATE: {
                                type: 'date'
                            },
                            NLS: {
                                type: 'string',
                            },
                            KV: {
                                type: 'number'
                            },
                            RESID: {
                                type: 'number'
                            },
                            COUNTRY: {
                                type: 'string'
                            },
                            NMKK: {
                                type: 'string'
                            },
                            C_REG: {
                                type: 'string'
                            },
                            ERR: {
                                type: 'string'
                            }
                        }
                    }
                }

            };
        }
        else if (file_type === "F0List") {
            return {
                async: false,
                type: 'webapi',
                transport: {
                    read: {
                        url: bars.config.urlContent("/api/Dpa/RegisterCountsDpaApi/GetFormedFilesF0Grid") + "?file_type=" + file_type,
                    }
                },
                serverFiltering: true,
                serverSortering: true,
                schema: {
                    data: "Data",
                    total: "Total",
                    model: {
                        fields: {
                            FN: {
                                type: 'string'
                            },
                            D_f0: {
                                type: 'date'
                            },
                            D_f1: {
                                type: 'date'
                            },
                            D_f2: {
                                type: 'date'
                            },
                            D_r0: {
                                type: 'date'
                            },
                            ERR: {
                                type: 'string'
                            },
                            ERR_MSG: {
                                type: 'string'
                            }
                        }
                    }
                }

            };
        }
        else if (file_type === "K0List") {
            return {
                async: false,
                type: 'webapi',
                transport: {
                    read: {
                        url: bars.config.urlContent("/api/Dpa/RegisterCountsDpaApi/GetFormedFilesF0Grid") + "?file_type=" + file_type,
                    }
                },
                serverFiltering: true,
                serverSortering: true,
                schema: {
                    data: "Data",
                    total: "Total",
                    model: {
                        fields: {
                            FN: {
                                type: 'string'
                            },
                            DAT: {
                                type: 'date'
                            },
                            ERR: {
                                type: 'string'
                            }
                        }
                    }
                }

            };
        }
        else if (file_type === "R0") {
            $scope.save_file_name = $scope.f2_file_name;
            return {
                async: false,
                type: 'webapi',
                transport: {
                    read: {
                        url: bars.config.urlContent("/api/Dpa/RegisterCountsDpaApi/GetR0Grid") + "?fileName=" + $scope.f2_file_name,
                    }
                },
                serverPaging: true,
                serverFiltering: true,
                serverSortering: true,
                pageSize: 13,
                schema: {
                    data: "Data",
                    total: "Total",
                    model: {
                        fields: {
                            ERR: {
                                type: 'string'
                            },
                            COM: {
                                type: 'string'
                            },
                            MFO: {
                                type: 'string'
                            },
                            OKPO: {
                                type: 'string'
                            },
                            RTYPE: {
                                type: 'number'
                            },
                            NMKK: {
                                type: 'string'
                            },
                            ODATE: {
                                type: 'date'
                            },
                            NLS: {
                                type: 'string'
                            },
                            KV: {
                                type: 'number'
                            },
                            RESID: {
                                type: 'number'
                            },
                            DAT_IN_DPA: {
                                type: 'date'
                            },
                            DAT_ACC_DPA: {
                                type: 'date'
                            },
                            ID_PR: {
                                type: 'number'
                            },
                            ID_DPA: {
                                type: 'number'
                            },
                            ID_DPS: {
                                type: 'number'
                            },
                            ID_REC: {
                                type: 'string'
                            },
                            FN_F: {
                                type: 'string'
                            },
                            N_F: {
                                type: 'number'
                            },
                        }
                    }
                }

            };
        }
        else if (file_type === "K2") {
            $scope.save_file_name = $scope.selected_f0_name;
            return {
                async: false,
                type: 'webapi',
                transport: {
                    read: {
                        url: bars.config.urlContent("/api/Dpa/RegisterCountsDpaApi/GetK2Grid") + "?fileName=" + $scope.selected_f0_name,
                    }
                },
                serverFiltering: true,
                serverSortering: true,
                schema: {
                    data: "Data",
                    total: "Total",
                    model: {
                        fields: {
                            ERR: {
                                type: 'string'
                            },
                            MFO: {
                                type: 'string'
                            },
                            OKPO: {
                                type: 'string'
                            },
                            OTYPE: {
                                type: 'number'
                            },
                            ODATE: {
                                type: 'date'
                            },
                            NLS: {
                                type: 'string',
                            },
                            KV: {
                                type: 'number'
                            },
                            RESID: {
                                type: 'number'
                            },
                            COUNTRY: {
                                type: 'string'
                            },
                            NMKK: {
                                type: 'string'
                            },
                            C_REG: {
                                type: 'string'
                            }
                        }
                    }
                }

            };
        }
    };

    function kvDropDownEditor(container, options) {
        if (options.field === "KV") {
            data = $scope.kvs;
        }
        else if (options.field === "OT") {
            data = [
                {
                    ID: 1,
                    NAME: "Відкриття"
                },
                {
                    ID: 3,
                    NAME: "Закриття"
                },
                {
                    ID: 5,
                    NAME: "Закриття. Не за ініціативою клієнта"
                },
                {
                    ID: 5,
                    NAME: "Закриття. Не за ініціативою клієнта"
                },
                {
                    ID: 6,
                    NAME: "Відкриття. Не за ініціативою клієнта"
                }
            ]
        }
        else if (options.field === "C_AG") {
            data = [
                    {
                        ID: 1,
                        NAME: "Резидент"
                    },
                    {
                        ID: 2,
                        NAME: "Нерезидент"
                    }
            ]
        }
        else if (options.field === "COUNTRY") {
            data = $scope.countries;
        }

        $('<input required name="' + options.field + '"/>')
            .appendTo(container)
            .kendoDropDownList({
                filter: "contains",
                dataTextField: "NAME",
                dataValueField: "ID",
                dataSource: {
                    data: data
                }
            });
    }

    GetName = function (value, field) {//value .id
        if (field === "KV") {
            data = $scope.kvs;
        }
        else if (field === "OT") {
            data = [
                {
                    ID: 1,
                    NAME: "Відкриття"
                },
                {
                    ID: 3,
                    NAME: "Закриття"
                },
                {
                    ID: 5,
                    NAME: "Закриття. Не за ініціативою клієнта"
                },
                {
                    ID: 6,
                    NAME: "Відкриття. Не за ініціативою клієнта"
                }
            ]
        }
        else if (field === "C_AG") {
            data = [
                {
                    ID: 1,
                    NAME: "Резидент"
                },
                {
                    ID: 2,
                    NAME: "Нерезидент"
                }
            ]
        } else if (field === "COUNTRY") {
            data = $scope.countries;
        }

        if (value !== null && typeof (value) === 'object') {
            idvalue = value.ID
        }
        else
            idvalue = value

        for (var i = 0; i < data.length; i++) {
            if (data[i].ID === parseInt(idvalue)) {
                return data[i].NAME
            }
        }
        return "";
    };

    //добавляем столбцы и данные для грида после выбора типа файла из выпадающего окна
    $scope.onChange = function () {
        $scope.fileType = angular.element("#dropdownlist").val();
        if ($scope.fileType === "K")
            $scope.k_file_disable = !$scope.k_file_disable;
        $scope.formFilesReportsGridOptions.dataSource = $scope.GetDataSourceForGrid($scope.fileType);
        $scope.formFilesReportsGridOptions.columns = $scope.GetColumnsForGrid($scope.fileType, "250px");
    }

    //наполняем грид данными
    $scope.GetDataForGrid = function () {
        $scope.fileType = angular.element("#dropdownlist").val();
        $scope.selected_date = $scope.dateFromDate;
        $scope.date_selected = true;

        if ($scope.selected_date !== "" && $scope.fileType !== "Виберіть тип файлу") {
            $scope.formFilesReportsGridOptions.dataSource.transport.read.url = bars.config.urlContent("/api/Dpa/RegisterCountsDpaApi/GetDataForFileReport") + "?date=" + $scope.selected_date + "&fileType=" + $scope.fileType;
        }
        angular.element("#formFilesReportsGrid").data("kendoGrid").dataSource.read();
    };

    //визуально добаляем строку в грид
    $scope.AddRow = function () {
        if (angular.element("#dropdownlist").val() !== "Виберіть тип файлу") {
            var grid = angular.element("#formFilesReportsGrid").data("kendoGrid");
            grid.addRow();
            angular.element(".k-grid-edit-row").appendTo("#grid tbody");
        }
        else
            bars.ui.error({ text: "Оберіть тип файлу" });
    }

    if ($scope.branch === "/300465/") {
        //типы файлов для выпадающего окна
        $scope.allTypes = [
            {
                text: "Виберіть тип файлу"
            },
            {
                text: "Файл @F - ДПА", value: "F"
            },
            {
                text: "Файл CV - ДПА", value: "CV"
            },
            {
                text: "Файл @K - ДПА", value: "K"
            }
        ];
    }
    else {
        $scope.allTypes = [
            {
                text: "Виберіть тип файлу"
            },
            {
                text: "Файл @F - ДПА", value: "F"
            },
            {
                text: "Файл CV - ДПА", value: "CV"
            }
        ];
    }

    //визуально удалить строку из грида
    $scope.RemoveRowFromGrid = function () {
        if (angular.element("#dropdownlist").val() !== "Виберіть тип файлу") {
            var gridElement = angular.element("#formFilesReportsGrid").data("kendoGrid");
            var gridData = gridElement.dataSource.data();
            if (gridData.length !== 0) {
                var rows = gridElement.select();
                if (rows.length != 0) {
                    var rows_for_delete = [];
                    rows.each(function (index, row) {
                        var selectedItem = gridElement.dataItem(row);
                        rows_for_delete.push(selectedItem);
                    });
                    for (var i = 0; i < rows_for_delete.length; i++) {
                        gridElement.dataSource.remove(rows_for_delete[i]);
                    }

                    bars.ui.success({ text: "Успішно видалено з таблиці " + rows_for_delete.length + " рядків" });
                }
                else
                    bars.ui.error({ text: "Жодного рядка не обрано" });
            }
            else
                bars.ui.error({ text: "Наповніть таблицю" });
        }
        else
            bars.ui.error({ text: "Оберіть тип файлу та наповніть таблицю" });
    };

    //визуально удалить строку из грида
    $scope.DeleteRow = function () {
        $scope.CloseWindow("Delete accept");
        if (angular.element("#dropdownlist").val() !== "Виберіть тип файлу") {
            var gridElement = angular.element("#formFilesReportsGrid").data("kendoGrid");
            var gridData = gridElement.dataSource.data();
            if (gridData.length !== 0) {
                var rows = gridElement.select();
                if (rows.length != 0) {
                    $scope.rows_for_delete = [];
                    rows.each(function (index, row) {
                        var selectedItem = gridElement.dataItem(row);
                        $scope.rows_for_delete.push(selectedItem);
                    });
                    var url = bars.config.urlContent("/api/Dpa/RegisterCountsDpaApi/DeleteRow/");
                    var post_data = JSON.stringify({ rows: $scope.rows_for_delete });
                    var data = $scope.AjaxPostFunction(url, post_data);
                    bars.ui.success({ text: "Успішно видалено з бази " + $scope.rows_for_delete.length + " рядків" });
                    gridElement.dataSource.read();
                }
                else
                    bars.ui.error({ text: "Жодного рядка не обрано" });
            }
            else
                bars.ui.error({ text: "Наповніть таблицю" });
        }
        else
            bars.ui.error({ text: "Оберіть тип файлу та наповніть таблицю" });
    };

    $scope.GetListF = function (url) {
        var url = url;
        var data = $scope.AjaxGetFunction(url);
        $scope.FILES = data;
        if (!$scope.in_archive) {
            $scope.path = data[0].path;
            if (data[0].fileName !== null) {
                $scope.GetDataListFiles("F", data);
            }
            else {
                $scope.GetEmptyListFiles("F");
            }
        }
        else {
            $scope.path = "Архів";
            $scope.processingReceiptGridOptions.dataSource = {};
            $scope.processingReceiptGridOptions.columns = $scope.GetColumnsForGrid("F2", "200px");
            if (data[0].fileName !== null) {
                $scope.GetDataListArchive("F", data);
            }
            else {
                $scope.GetEmptyListArchive("F");
            }
        }
    };

    $scope.GetListR = function (url) {
        var url = url;
        var data = $scope.AjaxGetFunction(url);
        $scope.FILES = data;
        if (!$scope.in_archive) {
            $scope.path = data[0].path;
            if (data[0].fileName !== null) {
                $scope.GetDataListFiles("R", data);
            }
            else {
                $scope.GetEmptyListFiles("R");
            }
        }
        else {
            $scope.path = "Архів";
            if (data !== null) {
                $scope.GetDataListArchive("R", data);
            }
            else {
                $scope.GetEmptyListArchive("R");
            }
        }
    };

    $scope.ReloadList = function (fileType) {
        var url = "";
        if (fileType === "F") {
            if (!$scope.in_archive)
                url = bars.config.urlContent("/api/Dpa/RegisterCountsDpaApi/GetAllFiles") + "?fileType=" + fileType;
            else
                url = bars.config.urlContent("/api/Dpa/RegisterCountsDpaApi/GetF2Archive");
            $scope.GetListF(url);
            angular.element("#processingReceiptGrid").data("kendoGrid").dataSource.read();
            angular.element("#listViewGrid").data("kendoGrid").dataSource.read();
        }
        else if (fileType === "R") {
            if (!$scope.in_archive)
                url = bars.config.urlContent("/api/Dpa/RegisterCountsDpaApi/GetAllFiles") + "?fileType=" + fileType;
            else
                url = bars.config.urlContent("/api/Dpa/RegisterCountsDpaApi/GetR0Archive");
            $scope.GetListR(url);
            angular.element("#listRViewGrid").data("kendoGrid").dataSource.read();
        }
        if (fileType === "K") {
            if (!$scope.in_archive)
                url = bars.config.urlContent("/api/Dpa/RegisterCountsDpaApi/GetAllFiles") + "?fileType=" + fileType;
            else
                url = bars.config.urlContent("/api/Dpa/RegisterCountsDpaApi/GetK2Archive");
            $scope.GetListF(url);
            angular.element("#processingReceiptGrid").data("kendoGrid").dataSource.read();
            angular.element("#listViewGrid").data("kendoGrid").dataSource.read();
        }
    }

    //открыть диалоговое окно
    $scope.OpenWindow = function (windowName, grid_name) {
        var url = "";
        var data = [];
        if (windowName === "Accept") {
            if (angular.element("#dropdownlist").val() !== "Виберіть тип файлу") {
                $scope.AcceptWindow.center().open();
            }
            else if ($scope.fileType === "F") {
                $scope.AcceptWindow.center().open();
            }
            else {
                bars.ui.error({ text: "Оберіть тип файлу та наповніть таблицю" });
            }
        }
        else if (windowName === "FormReceipt") {
            if ($scope.fileType === "F" || $scope.fileType === "K") {
                $scope.process_files = true;
                $scope.ProcessFileData = [];
                $scope.in_archive = false;
                $('#mydiv').show();
                url = bars.config.urlContent("/api/Dpa/RegisterCountsDpaApi/GetAllFiles") + "?fileType=" + $scope.fileType;
                data = $scope.AjaxGetFunction(url);
                $scope.FILES = data;
                $('#mydiv').hide();
                $scope.path = data[0].path;
                if (data[0].fileName !== null) {
                    $scope.GetDataListFiles("F", data);
                }
                else {
                    $scope.GetEmptyListFiles("F");
                }
                $scope.processingReceiptGridOptions.dataSource = {};
                $scope.processingReceiptGridOptions.dataSource.data = $scope.ProcessFileData;
                $scope.processingReceiptGridOptions.columns = $scope.ProcessGridColumns;
                $scope.FormReceiptWindow.maximize();
                $scope.FormReceiptWindow.center().open();
            }
            else
                bars.ui.error({ text: "Оберіть тип файлу: @F, @K" });
        }
        else if (windowName === "Delete accept") {
            if (angular.element("#dropdownlist").val() !== "Виберіть тип файлу") {
                $scope.DeleteAcceptWindow.center().open();
            }
            else {
                bars.ui.error({ text: "Оберіть тип файлу та наповніть таблицю" });
            }
        }
        else if (windowName === "Delete file accept") {
            var gridElement = angular.element("#listViewGrid").data("kendoGrid");
            var gridData = gridElement.dataSource.data();
            var row = gridElement.select();
            if (row.length !== 0) {
                $scope.DeleteFileAcceptWindow.center().open();
            }
            else {
                bars.ui.error({ text: "Жодного файлу не обрано" });
            }
        }
        else if (windowName === "Delete R file accept") {
            var gridElement = angular.element("#listRViewGrid").data("kendoGrid");
            var gridData = gridElement.dataSource.data();
            var row = gridElement.select();
            if (row.length !== 0) {
                $scope.DeleteRFileAcceptWindow.center().open();
            }
            else {
                bars.ui.error({ text: "Жодного файлу не обрано" });
            }
        }
        else if (windowName === "Formed F0 Files") {
            $scope.FillFormdedF0FilesGrid();
            $scope.FormedF0FilesWindow.center().open();
        }
        else if (windowName === "Form R Files Receipt") {
            $scope.process_files = true;
            $scope.ProcessFileData = [];
            $scope.in_archive = false;
            $('#mydiv').show();
            url = bars.config.urlContent("/api/Dpa/RegisterCountsDpaApi/GetAllFiles") + "?fileType=" + "R";
            data = $scope.AjaxGetFunction(url);
            $scope.FILES = data;
            $scope.path = data[0].path;
            if (data[0].fileName !== null) {
                $scope.GetDataListFiles("R", data);
            }
            else {
                $scope.GetEmptyListFiles("R");
            }
            $scope.processingRReceiptGridOptions.dataSource = {};
            $scope.processingRReceiptGridOptions.dataSource.data = $scope.ProcessFileData;
            $scope.processingRReceiptGridOptions.columns = $scope.ProcessGridColumns;
            $scope.FormRReceiptWindow.maximize();
            $scope.FormRReceiptWindow.center().open();
        }
        else if (windowName === "Save grid") {
            $scope.grid_for_save = grid_name;
            $scope.SaveGridWindow.center().open();
        }
    };

    $scope.FormedFilesEnabled = function () {
        if ($scope.fileType === "F" || $scope.fileType === "K") {
            $scope.formed_files = !$scope.formed_files;
            if ($scope.fileType === "K")
                $scope.k_file_disable = !$scope.k_file_disable;
            var dropdownlist = angular.element('#dropdownlist').data("kendoDropDownList");
            var datepicker = $("#DateGrid").data("kendoDatePicker");
            dropdownlist.enable(false);
            datepicker.enable(false);
            if ($scope.formed_files) {
                dropdownlist.enable(true);
                datepicker.enable(true);
                angular.element("#formed_file").val("");
                $scope.fileType = angular.element("#dropdownlist").val();
                $scope.formFilesReportsGridOptions.dataBound = function dataBound() { };
                $scope.formFilesReportsGridOptions.dataSource = $scope.GetDataSourceForGrid($scope.fileType);
                $scope.formFilesReportsGridOptions.columns = $scope.GetColumnsForGrid($scope.fileType, "250px");
            }
        }
        else {
            angular.element("#arc_checkbox").prop("checked", false);
            bars.ui.error({ text: "Оберіть тип файлу: @F, @K" });
        }
    };

    //закрыть диалоговое окно
    $scope.CloseWindow = function (windowName) {
        if (windowName === "Accept") {
            $scope.AcceptWindow.close();
        }
        else if (windowName === "Delete accept") {
            $scope.DeleteAcceptWindow.close();
        }
        else if (windowName === "Formed F0 Files") {
            $scope.FormedF0FilesWindow.close();
        }
        else if (windowName === "Delete file accept") {
            $scope.DeleteFileAcceptWindow.close();
        }
    };

    handleSaveChanges = function (grid) {
        
        var valid = true;
        // See if there are any insert rows
        var rows = grid.tbody.find("tr");
        for (var i = 0; i < rows.length; i++) {

            // Get the model
            var model = grid.dataItem(rows[i]);
            // Check the id property - this will indicate an insert row
            if (model && valid) {

                // Loop through the columns and validate them
                var cols = $(rows[i]).find("td");
                for (var j = 0; j < cols.length; j++) {
                    // Put cell into edit mode
                    grid.editCell($(cols[j]));

                    // By calling editable end we will make validation fire
                    if (!grid.editable.end()) {
                        valid = false;
                        break;
                    }
                    else {
                        // Take cell out of edit mode
                        grid.closeCell();
                    }
                }
            }
            else {
                // We're now to existing rows or have a validation error so we can stop
                break;
            }
        }

        if (!valid) {
            bars.ui.error({ text: "Заповніть усі поля." });
            return false;
        }
        return true;
    };

    //формируем файлы @F, CV
    $scope.UploadGrid = function () {
        var gridElement = angular.element("#formFilesReportsGrid").data("kendoGrid");
        var gridData = gridElement.dataSource.view();

        $scope.CloseWindow("Accept")
        if (!handleSaveChanges(gridElement))
            return false;

        if (!$scope.date_selected) {
            $scope.selected_date = $scope.dateFromDate;
        }

        if (gridData.length !== 0) {
            var grid = [];
            for (var i = 0; i < gridData.length; i++)
                grid.push(gridData[i]);

            angular.element('#mydiv').show();

            var url = bars.config.urlContent("/api/Dpa/RegisterCountsDpaApi/UploadGrid");
            var post_data = JSON.stringify({ grid: grid, fileType: $scope.fileType, date: $scope.selected_date });
            var data = $scope.AjaxPostFunction(url, post_data);

            //перевірка на наявність в результаті виконання post-запиту шляху (якщо його немає, відбулась помилка і повідомлення bars.ui.success не виводити)
            if (data.path) {
                if ($scope.fileType === "F") {
                    bars.ui.success({ text: data.filename + " файл завантажено до " + data.path });
                    $scope.GetDataForGrid();
                }
                else if ($scope.fileType === "CV") {
                    bars.ui.success({ text: $scope.fileType + " файл(и) завантажено до " + data.path });
                }
                else if ($scope.fileType === "K")
                    bars.ui.success({ text: data.filename + " файл завантажено до " + data.path });
            }
        }
        else {
            bars.ui.error({ text: "Наповніть спочатку таблицю" });
        }
    }

    //формирование фалов @F1, @F2
    $scope.ProcessFilesDPA = function () {
        angular.element('#mydiv').show();
        var gridElement = angular.element("#listViewGrid").data("kendoGrid");
        var gridData = gridElement.dataSource.data();
        var row = gridElement.select();
        var url = "";
        var data = [];
        if (row.length !== 0) {
            if ($scope.processFileName !== gridElement.dataItem(row).fileName) {
                $scope.processFileName = gridElement.dataItem(row).fileName;
                $scope.ProcessFileData.push({ category: "Квитуємий файл", errorcode: null, info: $scope.processFileName });
                angular.element("#processingReceiptGrid").data("kendoGrid").dataSource.read();
            }
            for (var i = 0; i < $scope.FILES.length; i++) {
                if ($scope.FILES[i].fileName === $scope.processFileName) {
                    url = bars.config.urlContent("/api/Dpa/RegisterCountsDpaApi/InsertTicket");
                    var post_data = JSON.stringify({ file: $scope.FILES[i] });
                    data = $scope.AjaxPostFunction(url, post_data);
                    angular.element('#mydiv').show();
                    $.ajax({
                        url: bars.config.urlContent("/api/Dpa/RegisterCountsDpaApi/ProcessFilesDPA") + "?fileName=" + $scope.processFileName + "&source_path=" + $scope.path,
                        method: "GET",
                        dataType: "json",
                        async: false,
                        success:
                            function (data) {
                                angular.element('#mydiv').hide();
                                $scope.ProcessFileData.push({ category: "Код квитовки файлу", errorcode: data, info: "Прийнято до оброблення" });
                                $scope.processingReceiptGridOptions.dataSource.data = $scope.ProcessFileData;
                                if ($scope.processFileName.indexOf("@F2") !== -1 || $scope.processFileName.indexOf("@K2") !== -1) {
                                    url = bars.config.urlContent("/api/Dpa/RegisterCountsDpaApi/GetCodesF2") + "?fileName=" + $scope.processFileName;
                                    data = $scope.AjaxGetFunction(url);
                                    for (var i = 0; i < data.length; i++) {
                                        $scope.ProcessFileData.push({ category: null, errorcode: data[i].ERR, info: data[i].N_ER });
                                        $scope.processingReceiptGridOptions.dataSource.data = $scope.ProcessFileData;
                                    }
                                }
                            },
                        error:
                            function (data) {
                                angular.element('#mydiv').hide();
                                $scope.ProcessFileData.push({ category: null, errorcode: null, info: data.responseText });
                                $scope.processingReceiptGridOptions.dataSource.data = $scope.ProcessFileData;
                            }

                    });
                    break;
                }
            }
            if ($scope.fileType == 'F')
                $scope.ReloadList('F');
            else
                $scope.ReloadList('K');
        }
        else {
            bars.ui.error({ text: "Спочатку оберіть файл" });
        }
    }

    $scope.processRFilesDPA = function () {
        angular.element('#mydiv').show();
        var gridElement = angular.element("#listRViewGrid").data("kendoGrid");
        var gridData = gridElement.dataSource.data();
        var row = gridElement.select();
        var url = "";
        var data = [];
        if (row.length !== 0) {
            if ($scope.processFileName !== gridElement.dataItem(row).fileName) {
                $scope.processFileName = gridElement.dataItem(row).fileName;
            }
            for (var i = 0; i < $scope.FILES.length; i++) {
                if ($scope.FILES[i].fileName === $scope.processFileName) {
                    url = bars.config.urlContent("/api/Dpa/RegisterCountsDpaApi/InsertR0Ticket");
                    var post_data = JSON.stringify({ file: $scope.FILES[i] });
                    data = $scope.AjaxPostFunction(url, post_data);
                    if (data === undefined) {
                        $scope.f2_file_name = $scope.processFileName;
                    }
                    break;
                }
            }
            $scope.processingRReceiptGridOptions.dataSource = $scope.GetDataSourceForGrid("R0");
            $scope.processingRReceiptGridOptions.columns = $scope.GetColumnsForGrid("R0", "250px");
            angular.element("#processingRReceiptGrid").data("kendoGrid").dataSource.read();
            url = bars.config.urlContent("/api/Dpa/RegisterCountsDpaApi/GetAllFiles") + "?fileType=" + "R0";
            $scope.GetListR(url);
            angular.element("#listRViewGrid").data("kendoGrid").dataSource.read();
        }
        else {
            bars.ui.error({ text: "Спочатку оберіть файл" });
        }
    };

    $scope.GetF2Archive = function () {
        $('#mydiv').show();
        $scope.process_files = false;
        $scope.in_archive = !$scope.in_archive;
        var url = "";
        if ($scope.in_archive) {
            $('#mydiv').show();
            if ($scope.fileType === "F")
                url = bars.config.urlContent("/api/Dpa/RegisterCountsDpaApi/GetF2Archive");
            else
                url = bars.config.urlContent("/api/Dpa/RegisterCountsDpaApi/GetK2Archive");
            $scope.path = "Архів";
            var data = $scope.AjaxGetFunction(url);
            if (data !== null) {
                $scope.GetDataListArchive("F", data);
            }
            else {
                $scope.GetEmptyListArchive("F");
            }
            $scope.processingReceiptGridOptions.dataSource = {}
            $scope.processingReceiptGridOptions.columns = $scope.GetColumnsForGrid("F2", "200px");
            angular.element("#processingReceiptGrid").data("kendoGrid").dataSource.read();
        }
        else {
            $('#mydiv').show();
            $scope.process_files = true;
            $scope.ProcessFileData = [];
            $scope.processingReceiptGridOptions.dataSource = {};
            url = bars.config.urlContent("/api/Dpa/RegisterCountsDpaApi/GetAllFiles") + "?fileType=" + $scope.fileType;
            var data = $scope.AjaxGetFunction(url);
            $scope.FILES = data;
            $('#mydiv').hide();
            $scope.path = data[0].path;
            if (data[0].fileName !== null) {
                $scope.GetDataListFiles("F", data);
            }
            else {
                $scope.GetEmptyListFiles("F");
            }
            $scope.processingReceiptGridOptions.dataSource.data = $scope.ProcessFileData;
            $scope.processingReceiptGridOptions.columns = $scope.ProcessGridColumns;
            angular.element("#processingReceiptGrid").data("kendoGrid").dataSource.read();
        }
    };

    $scope.FilesGridChange = function (fileType) {
        if ($scope.in_archive) {
            if (fileType === "F2") {
                var gridElement = angular.element("#listViewGrid").data("kendoGrid");
                var gridData = gridElement.dataSource.data();
                var row = gridElement.select();
                $scope.f2_file_name = gridElement.dataItem(row).FNK;
                if ($scope.fileType === "F") {
                    $scope.processingReceiptGridOptions.dataSource = $scope.GetDataSourceForGrid(fileType);
                    $scope.processingReceiptGridOptions.columns = $scope.GetColumnsForGrid(fileType, "250px");
                }
                else {
                    $scope.selected_f0_name = gridElement.dataItem(row).FNK;
                    $scope.processingReceiptGridOptions.dataSource = $scope.GetDataSourceForGrid("K2");
                    $scope.processingReceiptGridOptions.columns = $scope.GetColumnsForGrid("K2", "250px");
                }
                angular.element("#processingReceiptGrid").data("kendoGrid").dataSource.read();
            }
            else {
                var gridElement = angular.element("#listRViewGrid").data("kendoGrid");
                var gridData = gridElement.dataSource.data();
                var row = gridElement.select();
                $scope.f2_file_name = gridElement.dataItem(row).FN;
                $scope.processingRReceiptGridOptions.dataSource = $scope.GetDataSourceForGrid(fileType);
                $scope.processingRReceiptGridOptions.columns = $scope.GetColumnsForGrid(fileType, "250px");
                angular.element("#processingRReceiptGrid").data("kendoGrid").dataSource.read();
            }
        }
    };

    $scope.DeleteFile = function (fileType) {
        if (fileType === "F") {
            var gridElement = angular.element("#listViewGrid").data("kendoGrid");
            $scope.DeleteFileAcceptWindow.close();
        }
        else {
            var gridElement = angular.element("#listRViewGrid").data("kendoGrid");
            $scope.DeleteRFileAcceptWindow.close();
        }
        var gridData = gridElement.dataSource.data();
        var row = gridElement.select();

        $('#mydiv').show();
        var url = bars.config.urlContent("/api/Dpa/RegisterCountsDpaApi/DeleteFile") + "?fileName=" + gridElement.dataItem(row).fileName + "&source_path=" + $scope.path;
        var data = $scope.AjaxGetFunction(url);
        bars.ui.success({ text: "Файл успішно видалений" });
        $scope.ReloadList(fileType);
    }

    $scope.FillFormdedF0FilesGrid = function () {
        file_type = "";
        if ($scope.fileType == "F")
            file_type = "F0List";
        else
            file_type = "K0List";
        $scope.formedF0FilesGridOptions.dataSource = $scope.GetDataSourceForGrid(file_type);
        $scope.formedF0FilesGridOptions.columns = $scope.GetColumnsForGrid("F0List", "200px");
    };

    $scope.FillF0FilesGrid = function () {
        var gridElement = angular.element("#formedF0FilesGrid").data("kendoGrid");
        var gridData = gridElement.dataSource.data();
        var row = gridElement.select();
        if (row.length !== 0) {
            $scope.FormedF0FilesWindow.close();
            $scope.selected_f0_name = gridElement.dataItem(row).FN;
            $scope.print_f0_name = $scope.selected_f0_name;
            angular.element("#formed_file").val($scope.selected_f0_name);
            if ($scope.fileType == "F") {
                $scope.formFilesReportsGridOptions = {
                    dataSource: $scope.GetDataSourceForGrid("F0"),
                    selectable: "multiple",
                    columns: $scope.GetColumnsForGrid("F0", "200px"),
                    dataBound: function dataBound(e) {
                        var grid = $("#formFilesReportsGrid").data("kendoGrid");
                        var gridData = grid.dataSource.view();
                        for (var i = 0; i < gridData.length; i++) {
                            if (gridData[i].ERR !== "0000") {
                                grid.table.find("tr[data-uid='" + gridData[i].uid + "']").addClass("red-row");
                            }
                        }
                    },
                    filterable: true,
                    editable: {
                        createAt: "top"
                    },
                    srollable: true,
                    resizable: true,
                    height: 450
                };
            }
            else {
                $scope.formFilesReportsGridOptions = {
                    dataSource: $scope.GetDataSourceForGrid("K0"),
                    selectable: "multiple",
                    columns: $scope.GetColumnsForGrid("K0", "200px"),
                    dataBound: function dataBound(e) {
                        var grid = $("#formFilesReportsGrid").data("kendoGrid");
                        var gridData = grid.dataSource.view();
                        for (var i = 0; i < gridData.length; i++) {
                            if (gridData[i].ERR !== "0000") {
                                grid.table.find("tr[data-uid='" + gridData[i].uid + "']").addClass("red-row");
                            }
                        }
                    },
                    filterable: true,
                    editable: {
                        createAt: "top"
                    },
                    srollable: true,
                    resizable: true,
                    height: 450
                };
            }
        }
        else
            bars.ui.error({ text: "Оберіть спочатку файл" });
    };

    $scope.GetR0Archive = function () {
        $('#mydiv').show();
        $scope.process_files = false;
        $scope.in_archive = !$scope.in_archive;
        var url = "";
        if ($scope.in_archive) {
            $('#mydiv').show();
            url = bars.config.urlContent("/api/Dpa/RegisterCountsDpaApi/GetR0Archive");
            var data = $scope.AjaxGetFunction(url);
            $scope.path = "Архів";
            if (data !== null) {
                $scope.GetDataListArchive("R", data);
            }
            else {
                $scope.GetEmptyListArchive("R");
            }
            $scope.processingRReceiptGridOptions.dataSource = {};
            $scope.processingRReceiptGridOptions.columns = $scope.GetColumnsForGrid("R0", "200px");
        }
        else {
            $('#mydiv').show();
            $scope.process_files = true;
            var url = "";
            $scope.ProcessFileData = [];
            url = bars.config.urlContent("/api/Dpa/RegisterCountsDpaApi/GetAllFiles") + "?fileType=" + "R";
            var data = $scope.AjaxGetFunction(url);
            $scope.FILES = data;
            $('#mydiv').hide();
            $scope.path = data[0].path;
            if (data[0].fileName !== null) {
                $scope.GetDataListFiles("R", data);
            }
            else {
                $scope.GetEmptyListFiles("R");
            }
            $scope.processingRReceiptGridOptions.dataSource = {};
            $scope.processingRReceiptGridOptions.dataSource.data = $scope.ProcessFileData;
            $scope.processingRReceiptGridOptions.columns = $scope.ProcessGridColumns;
        }
    };

    $scope.ProcessGridColumns = [
            {
                field: "category",
                title: "Категорія"
            },
            {
                field: "errorcode",
                title: "Код помилки"
            },
            {
                field: "info",
                title: "Пояснення"
            }
    ];



    $scope.ifNull = function (value) {
        if (value === null)
            return "";
        else
            return value;
    };

    $scope.SaveFileAs = function () {
        $scope.SaveGridWindow.close();
        var grid = angular.element("#" + $scope.grid_for_save).data("kendoGrid");
        var option = angular.element("#export").find("input:checked").val();
        if (grid.dataSource.data().length !== 0) {
            if (($scope.save_file_name === "@F" || $scope.save_file_name === "CV" || $scope.save_file_name === "CA") && ($scope.dateFromDate === "" || $scope.dateFromDate === undefined)) {
                bars.ui.error({ text: "Оберіть дату" });
            }
            else
                window.open("/barsroot/Dpa/RegisterCountsDpa/SaveFile" + "?fileName=" + $scope.save_file_name + "&entereddate=" + $scope.dateFromDate + "&save_type=" + option);
        }
        else
            bars.ui.error({ text: "Наповніть таблицю" });
    };

    $scope.Print = function (grid_name) {
        var gridElement = $('#' + grid_name).data("kendoGrid").dataSource.data(),
            win = window.open('', '', ''),
            doc = win.document.open(),
            columns = [],
            fields = [];

        if (grid_name === "formFilesReportsGrid") {
            columns = $scope.formFilesReportsGridOptions.columns;
        }
        else if (grid_name === "processingReceiptGrid") {
            columns = $scope.processingReceiptGridOptions.columns;
        }
        else if (grid_name === "processingRReceiptGrid") {
            columns = $scope.processingRReceiptGridOptions.columns;
        }

        var url = bars.config.urlContent("/api/Dpa/RegisterCountsDpaApi/GetPrintHeader");
        var header = $scope.AjaxGetFunction(url)

        var current_date = kendo.toString(kendo.parseDate(header.DATE, 'yyyy-MM-dd'), 'dd/MM/yyyy');
        var current_hours = parseInt(kendo.toString(kendo.parseDate(header.DATE, 'hh'), 'hh')) + 12;
        var current_time = current_hours + ":" + kendo.toString(kendo.parseDate(header.DATE, 'mm:ss'), 'mm:ss');
        var htmlStart =
                '<html>' +
                '<head>' +
                '<title></title>' +
                '</head>' +
                '<style>' +
                'table {' +
                'border-collapse: collapse;' +
                '}' +
                'body, table, th, td {' +
                    'font-size: 10pt;' +
                    'padding: 5px;' +
                    'font-family: monospace;' +
                    'text-align: left;' +
                '}' +
                'table, th, td {' +
                    'border: 1px solid black;' +
                    'font-size: 10pt;' +
                    'padding: 5px;' +
                    'font-family: monospace;' +
                    'text-align: left;' +
                '}' +
                '</style>' +
                '<body>' +
                'Користувач: ' + header.USER_NAME + "<br/>" +
                'Дата: ' + current_date + "      Час: " + current_time + "<br/><br/>" +
                '<table>' +
                '<tr>';



        for (var i = 0; i < columns.length; i++) {
            if (typeof (columns[i].hidden) !== 'boolean') {
                htmlStart = htmlStart + '<th>' + columns[i].title + '</th>';
                fields.push(columns[i].field);
            }
        }

        htmlStart = htmlStart + '</tr>';
        for (var j = 0; j < gridElement.length; j++) {
            htmlStart = htmlStart + '<tr>';
            for (var k = 0; k < fields.length; k++) {
                if (typeof (gridElement[j][fields[k]]) === 'object') {
                    var date = kendo.toString(kendo.parseDate(gridElement[j][fields[k]], 'yyyy-MM-dd'), 'dd/MM/yyyy');
                    htmlStart = htmlStart +
                                '<th>' + $scope.ifNull(date) + '</th>';
                }
                else
                    htmlStart = htmlStart + '<th>' + $scope.ifNull(gridElement[j][fields[k]]) + '</th>';
            }
            htmlStart = htmlStart + '</tr>';
        }

        htmlStart = htmlStart +
                         '</table>' +
                         '</body>' +
                         '</html>';

        doc.write(htmlStart);
        doc.close();
        win.print();
    }

    $scope.formedF0FilesGridOptions = {
        dataSource: {},
        selectable: "multiple",
        columns: [],
        filterable: true,
        sortable: true,
        srollable: true,
        resizable: true
    }

    //начальные настройки грида @F0, CV, CA
    $scope.formFilesReportsGridOptions = {
        dataSource: {},
        excel: {
            fileName: "DPA_Export.xlsx",
            proxyURL: bars.config.urlContent('/dpa/registercountsdpa/convertBase64toFile/'),
            filterable: false,
            pagenable: false,
            allPages: true
        },
        pdf: {
            allPages: true,
            avoidLinks: true,
            paperSize: "A4",
            margin: { top: "2cm", left: "1cm", right: "1cm", bottom: "1cm" },
            fileName: "DPA_Export.pdf",
            proxyURL: bars.config.urlContent('/dpa/registercountsdpa/convertBase64toFile/'),
            landscape: true,
            repeatHeaders: true,
            scale: 0.01
        },
        selectable: "multiple",
        filterable: true,
        columns: [],
        editable: {
            createAt: "top"
        },
        height: 450,
        srollable: true
    }

    //начальные настройки грида @F1, @F2
    $scope.processingReceiptGridOptions = {
        dataSource: {
            data: $scope.ProcessFileData
        },
        selectable: "row",
        columns: [
                    {
                        field: "category",
                        title: "Категорія"
                    },
                    {
                        field: "errorcode",
                        title: "Код помилки"
                    },
                    {
                        field: "info",
                        title: "Пояснення"
                    }
        ],
        height: 440,
        sortable: true,
        filterable: true
    }

    //начальные настройки грида @R0, @R2
    $scope.processingRReceiptGridOptions = {
        dataSource: {
            data: $scope.ProcessFileData
        },
        selectable: "row",
        columns: [
                    {
                        field: "category",
                        title: "Категорія"
                    },
                    {
                        field: "errorcode",
                        title: "Код помилки"
                    },
                    {
                        field: "info",
                        title: "Пояснення"
                    }
        ],
        height: 440,
        sortable: true,
        filterable: true
    }

    $scope.listRViewGridOptions = {
        dataSource: {
            data: [],
            schema: {}
        },
        columns: [],
        selectable: "row",
        scrollable: true,
        height: 440
    }

    $scope.PrintF0 = function () {
        
        var url = bars.config.urlContent("/api/Dpa/RegisterCountsDpaApi/PrintF0Files");
        var gridElement = angular.element("#formFilesReportsGrid").data("kendoGrid");
        var grid = gridElement.dataSource.data();
        $scope.lastTemplateFileName = angular.element("#formed_file").val();
        var post_data = JSON.stringify({ fileName: $scope.lastTemplateFileName, grid: grid });
        if (angular.element("#formed_file").val() !== "") {
            var data = $scope.AjaxPostFunction(url, post_data, $scope.getFileCallBackFunction);


        }
        else
            bars.ui.error({ text: "Оберіть спочатку файл" });
    }

    $scope.getFileCallBackFunction = function (errorMsg){
        
        if(!errorMsg)
        {

            var gridElement = angular.element("#formFilesReportsGrid").data("kendoGrid");
            var grid = gridElement.dataSource.data();
            bars.ui.alert({ text: "Надруковано " + grid.length + " повідомлень " },$scope.getFileFunction);
        }
        else
            bars.ui.notify('Помилка', 'Сталася помилка при виклику сервісу', errorMsg);
    }

    $scope.getFileFunction = function () {
        window.open(bars.config.urlContent("/api/Dpa/RegisterCountsDpaApi/GetLastGeneratedTemplate?fileName="+$scope.lastTemplateFileName));
    }

}]);