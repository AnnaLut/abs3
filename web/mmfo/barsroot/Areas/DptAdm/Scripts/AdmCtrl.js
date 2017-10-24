$(document).ready(function () {
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //Население гридов 
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    html = document.documentElement;
    var height = Math.max(html.clientHeight, html.scrollHeight, html.offsetHeight);
    var viddTools = "#vidd_toolbar";    
    /*модели гридов*/
    var dpt_type_list = kendo.data.Model.define({
        id: dpt_type_list,        
        fields: {
            TYPE_ID: { type: "number"},
            TYPE_CODE: { type: "string" },
            TYPE_NAME: { type: "string" },
            FL_ACTIVE: { type: "string" },
            SORT_ORD: { type: "int" },
            FL_DEMAND: { type: "string" },
            FL_WEBBANKING: { type: "string" },
            COUNT_ACTIVE: { type: "int" }
        }
    });

    var dpt_vidd_list = kendo.data.Model.define({
        id: dpt_vidd_list,
        fields: {
            type_id: { type: "int" },
            flag: { type: "string" },
            flagid: { type: "int" },
            vidd: { type: "number" },
            TYPE_COD: { type: "string" },
            KV: { type: "int" },
            TYPE_NAME: { type: "string" },
            CountActive: { type: "number" },
            DURATION: { type: "string" },
            DURATION_DAYS: { type: "string" },
            MIN_SUMM: { type: "string" },
            LIMIT: { type: "string" },
            FREQ_K: { type: "string" },
            FL_DUBL: { type: "int" }
        }
    });
    var dpt_vidd_tts = kendo.data.Model.define({
        id: dpt_vidd_tts,
        fields: {
            vidd: { type: "int" },
            added: { type: "string" },
            OP_TYPE: { type: "string" },
            OP_NAME: { type: "string" },
            TT_ID: { type: "int" },
            TT_NAME: { type: "string" },
            TT_CASH: { type: "int" }
        }
    });

    // устанавливает строку в главном гриде на первую
    function setDefaultRow() {       
        var gridtype = $('#grid_dpt_types').data('kendoGrid');
        prepareCombo();
        var currentRow = gridtype.dataItem(gridtype.select());
        if (gridtype != null || (currentRow)) {
            gridtype.select("tr:eq(1)");
        }
        showActualGrpData();
    }
    function setDefaultViddRow() {
        var gridvidd = $('#grid_dpt_vidd').data('kendoGrid');
        if (gridvidd != null) {
            gridvidd.select("tr:eq(1)");
        }
        
    }
    // отдает идентификатор выбранной строки родительского грида
    function currentRowData() {
        var tgrid = $('#grid_dpt_types').data('kendoGrid');
        var currentRow = tgrid.dataItem(tgrid.select());
        if (!!currentRow)
            return { TYPE_ID: currentRow.TYPE_ID };
        else
            return null;
    }
    function currentRowDataCod() {
        var grid = $('#grid_dpt_types').data('kendoGrid');
        var currentRow = grid.dataItem(grid.select());
        if (!!currentRow)
            return { TYPE_CODD: currentRow.TYPE_CODE };
        else
            return null;
    }
    /*функция, связывающая гриды по идентификатору выбранной строки*/
    function showActualGrpData() {
        currentRowData();
        $('#grid_dpt_vidd').data('kendoGrid').dataSource.read();
        $('#grid_dpt_vidd').data('kendoGrid').refresh();
    }
    // грид типов депозитных договоров
    var grid_dpt_types = $('#grid_dpt_types').kendoGrid({
        autobind: true,
        selectable: "row",        
        sortable: true,
        scrolable: true,
        height: (height / 3).toString() + "px",
        toolbar: [{ template: '<a class="k-button" href="\\#" onclick="return toolbar_typeclick_add()">Додати</a>' },
                  { template: '<a class="k-button" href="\\#" onclick="return toolbar_typeclick_view()">Перегляд</a>' },
                  { template: '<a class="k-button" href="\\#" onclick="return toolbar_typeclick()">Редагувати</a>' },
                  { template: '<a class="k-button" disabled href="\\#" onclick="return toolbar_typeclick_clon()">Копіювати лінійку</a>' },
                  { template: '<a class="k-button" enabled href="\\#" onclick="return toolbar_typeclick_delete()">Видалити тип</a>' },
                  { template: '<a class="k-button" enabled href="\\#" onclick="return toolbar_typeclick_docscheme()">Шаблони для типу</a>' }],
        columns: [{
            field: "TYPE_ID",
            title: "Ідентифікатор",
            width: "5%",          
            attributes: { "readonly": true, "class": "table-cell", style: "text-align: center; font-size: 12px" }
        }, {
            field: "TYPE_CODE",
            title: "Код типу",
            width: "15%",            
            attributes: { "class": "table-cell", style: "text-align: center; font-size: 12px" }
        },
        {
            field: "TYPE_NAME",
            title: "Назва",
            width: "40%",
            attributes: { "class": "table-cell", style: "text-align: left; font-size: 12px" }
        },
        {
            field: "FL_ACTIVE",
            title: "Ознака використання",
            width: "20%",
            attributes: { "class": "table-cell", style: "text-align: center; font-size: 12px" },
            template: "<button class='k-button' onclick='activateType(#=TYPE_ID#);'> #=FL_ACTIVE#",
            filterable: {
                multi: true,
                search: true
            }
        },
        {
            field: "COUNT_ACTIVE",
            title: "К-ть активних",
            attributes: { "class": "table-cell", style: "text-align: center; font-size: 12px" },
            width: "10%"
        },
        {
            field: "FL_DEMAND",
            title: "Тип строковості",
            width: "10%",
            attributes: { "class": "table-cell", style: "text-align: center; font-size: 12px" },
            filterable: {
            multi: true,
            search: true
    }
        },
        {
            field: "FL_WEBBANKING",
            title: "WEB-BANKING",
            width: "15%",
            template: "<button class='k-button' onclick='setWBType(#=TYPE_ID#);'> #=FL_WEBBANKING#",
            filterable: {
                multi: true,
                search: true
            }
        },
        {
            field: "SORT_ORD",
            title: "Порядок<br> сортування</br>",
            width: "15%",
            template: "<button class='k-button' onclick='upPriority(#=TYPE_ID#);'><i class='k-icon k-i-arrow-n' visible='false'></i></button>   #=SORT_ORD#   <button class='k-button' onclick='downPriority(#=TYPE_ID#);'><i class='k-icon k-i-arrow-s'></i></button>"
        }
        ],
        dataSource: {
            type: "aspnetmvc-ajax",
            transport: {
                read: {
                    dataType: 'json',
                    url: bars.config.urlContent('/DptAdm/DptAdm/GetDptType')
                }
            },
            schema: {
                data: "data",                
                model: dpt_type_list
            }
        },
        filterable: {messages: {
            search: "Search category"
        }},
        dataBound: setDefaultRow,
        change: showActualGrpData,
        edit: function () {
            if (grid_dpt_types.select()) {
                var wnd_type = $("#wnd_type_info").data("kendoWindow");
                var flag_ok = prepareTypeDialog("edit");
                wnd_type.center().open();
            }
        }
    });
    // кнопки управления типами
    toolbar_typeclick = function () {
        var wnd_type = $("#wnd_type_info").data("kendoWindow");
        prepareTypeDialog("edit");
        return false;
    }
    toolbar_typeclick_view = function () {
        var wnd_type = $("#wnd_type_info").data("kendoWindow");
        prepareTypeDialog("view");
        return false;
    }
    toolbar_typeclick_add = function () {
        var wnd_type = $("#wnd_type_info").data("kendoWindow");
        prepareTypeDialog("add");
        return false;
    }
    toolbar_typeclick_clon = function () {
        var wnd_type = $("#wnd_type_info").data("kendoWindow");
        prepareTypeDialog("clon");
        return false;
    }
    toolbar_typeclick_docscheme = function () {
        var wnd_type = $("#wnd_typedoc").data("kendoWindow");
        prepareDOCTypeDialog();
        return false;
    }

    deleteType = function (TYPE_ID) {
        $.ajax({
            type: "POST",
            url: bars.config.urlContent('/DptAdm/DptAdm/DeleteType'),
            data: { TYPE_ID: TYPE_ID },
            success: function (data) {
                if (data.status != 'error') {
                    bars.ui.alert({ text: data.message });
                } else {
                    bars.ui.error({ text: data.message });
                }               
            }
        });
        $('#grid_dpt_types').data('kendoGrid').dataSource.read();
        $('#grid_dpt_types').data('kendoGrid').refresh();
    }
    deleteVidd = function (vidd) {
        $.ajax({
            type: "POST",
            url: bars.config.urlContent('/DptAdm/DptAdm/DeleteVidd'),
            data: { VIDD: vidd },
            success: function (data) {
                if (data.status != 'error') {
                    bars.ui.alert({ text: data.message });
                } else {
                    bars.ui.error({ text: data.message });
                }
                $('#grid_dpt_vidd').data('kendoGrid').dataSource.read();
                $('#grid_dpt_vidd').data('kendoGrid').refresh();
            }
        });
    }
    toolbar_typeclick_delete = function () {
        var wnd_type = $("#wnd_type_info").data("kendoWindow");
        var grid = $("#grid_dpt_types").data("kendoGrid");
        var currentRowData = null;
        if (grid.select().length > 0) {
            currentRowData = grid.dataItem(grid.select());
            if (currentRowData.COUNT_ACTIVE > 0)
            { bars.ui.error({ text: 'Неможливо видалити тип, якщо є діючі вклади ' + currentRowData.COUNT_ACTIVE + ' штук' }); }
            else if (confirm('Бажаєте видалити тип вкладу ' + currentRowData.TYPE_CODE + '?')) {
                deleteType(currentRowData.TYPE_ID);               
            }

        }
        else { bars.ui.error({ text: "Не обрано тип депозиту!" }); }
        return false;
    }

    toolbar_viddclick_delete = function () {
        var wnd_type = $("#wnd_vidd_info").data("kendoWindow");
        var grid = $("#grid_dpt_vidd").data("kendoGrid");
        var currentRowData = null;
        if (grid.select().length > 0) {
            currentRowData = grid.dataItem(grid.select());
            if (currentRowData.CountActive > 0)
            { bars.ui.error({ text: 'Неможливо видалити вид, якщо є діючі вклади ' + currentRowData.CountActive + ' штук' }); }
            else if (confirm('Бажаєте видалити вид вкладу ' + currentRowData.vidd + '?')) {
                deleteVidd(currentRowData.vidd);
            }
        }
        else { bars.ui.error({ text: "Не обрано вид депозиту!" }); }
        return false;
    }

    prepareTTSDialog = function (mode) {
        var wnd_vidd = $("#wnd_vidd_info").data("kendoWindow");
        var wnd_tts = $("#wnd_tts").data("kendoWindow");
        var grid = $("#grid_dpt_vidd").data("kendoGrid");
        var currentViddData = null;
        var titlestr;
        if (grid.select().length > 0) {
            currentViddData = grid.dataItem(grid.select());
            if (mode === "edit") {
                workmode(true);
                titlestr = "Редагування переліку операцій виду вкладу " + currentViddData.TYPE_NAME;
                populateTTS(currentViddData.vidd, 0);
            }
            else if (mode === "view") {
                workmode(false);
                titlestr = "Перегляд переліку операцій виду вкладу " + currentViddData.TYPE_NAME;
                populateTTS(currentViddData.vidd, 0);
            }
            wnd_tts.title(titlestr);
            wnd_tts.center().open();
        }
        else { bars.ui.error({ text: "Не обрано вид депозиту!" }); }
    }
    var DOCDropDownList = $("#DOC_SCHEME").data("kendoDropDownList");
    var DOC_FRDropDownList = $("#DOCFR_SCHEME").data("kendoDropDownList");


    prepareParamDialog = function () {
        var grid = $("#grid_dpt_vidd").data("kendoGrid");
        var wnd_param = $("#wnd_param").data("kendoWindow");
        var currentViddData = null;        
        if (grid.select().length > 0) {
            currentViddData = grid.dataItem(grid.select());
            populateParam(currentViddData.vidd);            
            wnd_param.center().open();
        }
        else { bars.ui.error({ text: "Не обрано вид депозиту!" }); }
    }

    prepareDOCDialog = function (mode) {
        var wnd_vidd = $("#wnd_vidd_info").data("kendoWindow");
        var wnd_doc = $("#wnd_doc").data("kendoWindow");
        var grid = $("#grid_dpt_vidd").data("kendoGrid");
        var currentViddData = null;
        var titlestr;
        if (grid.select().length > 0) {
            currentViddData = grid.dataItem(grid.select());
            if (mode === "edit") {
                workmode(true);
                titlestr = "Редагування переліку шаблонів виду вкладу " + currentViddData.TYPE_NAME;
                populateDOC(currentViddData.vidd, 0);
            }
            else if (mode === "view") {
                workmode(false);
                titlestr = "Перегляд переліку шаблонів виду вкладу " + currentViddData.TYPE_NAME;
                populateDOC(currentViddData.vidd, 0);
            }
            wnd_doc.title(titlestr);
            wnd_doc.center().open();
        }
        else { bars.ui.alert({ text: "Не обрано вид депозиту!" }); }
    }

    // кнопки управления видами
    toolbar_click = function () {
        var wnd = $("#wnd_vidd_info").data("kendoWindow");
        prepareViddDialog("edit");
        return false;
    }
    toolbar_click_view = function () {
        var wnd = $("#wnd_vidd_info").data("kendoWindow");
        prepareViddDialog("view");
        return false;
    }
    toolbar_click_add = function () {
        var wnd = $("#wnd_vidd_info").data("kendoWindow");
        prepareViddDialog("add");
        return false;
    }
    toolbar_click_clon = function () {
        var wnd = $("#wnd_vidd_info").data("kendoWindow");
        prepareViddDialog("clon");
        return false;
    }
    toolbar_click_enable = function () {
        var wnd = $("#wnd_vidd_info").data("kendoWindow");
        prepareViddDialog("activate");
        return false;
    }

    toolbar_click_tts = function () {
        var wnd = $("#wnd_vidd_info").data("kendoWindow");
        var wnd = $("#wnd_tts").data("kendoWindow");
        prepareTTSDialog("edit");
        return false;
    }
    toolbar_click_doc = function () {
        var wnd = $("#wnd_doc").data("kendoWindow");
        prepareDOCDialog("edit");
        return false;
    }

    toolbar_click_param = function () {
        var wnd = $("#wnd_param").data("kendoWindow");
        prepareParamDialog();
        return false;
    }
    toolbar_docclick_add = function () {
        var wnd_docadd = $("#wnd_doc_add").data("kendoWindow");
        var grid = $("#grid_dpt_vidd").data("kendoGrid");
        var currentViddData = null;
        var titlestr;
        if (grid.select().length > 0) {
            currentViddData = grid.dataItem(grid.select());
            prepareDOCaddDialog(currentViddData.vidd);
            wnd_docadd.center().open();
        }
        else { bars.ui.alert({ text: "Не обрано вид депозиту!" }); }
        return false;
    }

    // грид видов депозитных договоров
    var grid_dpt_vidd = $('#grid_dpt_vidd').kendoGrid({
        autobind: false,
        selectable: "row",
        sortable: true,
        scrollable: true,
        height: (height / 1.5).toString() + "px",
        toolbar: [{ template: '<a class="k-button" href="\\#" onclick="return toolbar_click()">Редагувати вид</a>' },
                    { template: '<a class="k-button" href="\\#" onclick="return toolbar_click_view()">Перегляд виду</a>' },
                    { template: '<a class="k-button" href="\\#" onclick="return toolbar_click_add()">Додати новий вид</a>' },
                    { template: '<a class="k-button" href="\\#" onclick="return toolbar_click_clon()">Копіювати обраний вид</a>' },
                    { template: '<a class="k-button" href="\\#" onclick="return toolbar_click_tts()">Операції виду вкладу</a>' },
                    { template: '<a class="k-button" href="\\#" onclick="return toolbar_click_doc()">Шаблони виду вкладу</a>' },
                    { template: '<a class="k-button" href="\\#" onclick="return toolbar_click_param()">Параметри виду вкладу</a>' },
                    { template: '<a class="k-button" href="\\#" onclick="return toolbar_viddclick_delete()">Видалити вид</a>' }],
        columns: [{
            field: "flagid",
            title: "АКТ",
            width: "25px",
            attributes: { style: "text-align: center;" },
            template: '<input type="checkbox" class="checkbox" #= flagid == 1 ? "checked=checked" : "" # onclick="activateVidd(#=vidd#);" ></input>'
        },
            {
                field: "vidd",
                title: "Код",
                width: "40px",
                attributes: { "class": "table-cell", style: "text-align: center; font-size: 12px;" }
            },
            {
                field: "TYPE_COD",
                title: "Код типу",
                width: "60px",
                attributes: { "class": "table-cell", style: "text-align: center; font-size: 12px;" }
            },
            {
                field: "KV",
                title: "Валюта",
                width: "30px",
                attributes: { "class": "table-cell", style: "text-align: center; font-size: 12px;" }
            },
            {
                field: "TYPE_NAME",
                title: "Назва",
                width: "250px",
                attributes: { "class": "table-cell", style: "text-align: left; font-size: 12px;" }
            },
            {
                field: "CountActive",
                title: "Кількість<br>активних</br>",
                width: "70px",
                attributes: { "class": "table-cell", style: "text-align: center; font-size: 12px;" }
            },
            {
                field: "DURATION",
                title: "Строк(міс.)",
                width: "70px",
                attributes: { "class": "table-cell", style: "text-align: center; font-size: 12px;" }
            },
            {
                field: "DURATION_DAYS",
                title: "Строк(дн.)",
                width: "70px",
                attributes: { "class": "table-cell", style: "text-align: center; font-size: 12px;" }
            },
            {
                field: "MIN_SUMM",
                title: "Мін.сума<br>вкладу</br>",
                width: "100px",
                attributes: { "class": "table-cell", style: "text-align: center; font-size: 12px;" }
            },
            {
                field: "LIMIT",
                title: "Мін.поповнення",
                width: "100px",
                attributes: { "class": "table-cell", style: "text-align: center; font-size: 12px;" }
            },
            {
                field: "FREQ_K",
                title: "Періодичність<br>виплати %%<br/>",
                width: "150px",
                attributes: { "class": "table-cell", style: "text-align: center; font-size: 12px;" }
            },
            {
                field: "FL_DUBL",
                title: "Автопролонгація",
                width: "70px",
                attributes: { "class": "table-cell", style: "text-align: center; font-size: 12px;" }
            }
        ],
        dataSource: {
            type: "aspnetmvc-ajax",
            transport: {
                read: {
                    dataType: 'json',
                    url: bars.config.urlContent('/DptAdm/DptAdm/GetDptVidd'),
                    data: currentRowData
                }
            },
            schema: {
                data: "data",
                total: "Total",
                model: dpt_vidd_list
            }
        },      
        filterable: true,
        databound: setDefaultViddRow,
        edit: function () {
            if (grid_dpt_vidd.select()) {            
                var wnd = $("#wnd_vidd_info").data("kendoWindow");
                var flag_ok = prepareViddDialog("edit");
                wnd.center().open();
            }
        }
    });
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //Население гридов закончилось, начинаю работу с диалогами
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // выпадающие списки
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    var prepareCombo = function () {
        var active_list = kendo.data.Model.define({
            id: active_list,
            fields: { id: { type: "int" }, NAME: { type: "string" } }
        });
        var kv_list = kendo.data.Model.define({
            id: kv_list,
            fields: { KV: { type: "string" }, LCV: { type: "string" }, NAME: { type: "string" } }
        });
        var bsd_list = kendo.data.Model.define({
            id: bsd_list,
            fields: { BSD: { type: "string" }, NAME: { type: "string" } }
        });
        var basey_list = kendo.data.Model.define({
            id: basey_list,
            fields: { BASEY: { type: "string" }, NAME: { type: "string" } }
        });
        var freq_n_list = kendo.data.Model.define({
            id: freq_n_list,
            fields: { BASEY: { type: "string" }, NAME: { type: "string" } }
        });
        var metr_list = kendo.data.Model.define({
            id: metr_list,
            fields: { METR: { type: "int" }, NAME: { type: "string" } }
        });
        var ion_list = kendo.data.Model.define({
            id: ion_list,
            fields: { IO: { type: "int" }, NAME: { type: "string" } }
        });
        var brates_list = kendo.data.Model.define({
            id: brates_list,
            fields: { BR_ID: { type: "int" }, NAME: { type: "string" } }
        });
        var dpt_stop_list = kendo.data.Model.define({
            id: dpt_stop_list,
            fields: { ID: { type: "int" }, NAME: { type: "string" } }
        });
        var dpt_vidd_extypes_list = kendo.data.Model.define({
            id: dpt_vidd_extypes_list,
            fields: { ID: { type: "int" }, NAME: { type: "string" } }
        });
        var tarif_list = kendo.data.Model.define({
            id: tarif_list,
            fields: { KOD: { type: "int" }, NAME: { type: "string" } }
        });

        //////////////////////////////////////////////////////////////////////////////

        var kv_data = new kendo.data.DataSource({
            type: "aspnetmvc-ajax",
            transport: { read: { dataType: 'json', url: bars.config.urlContent('/DptAdm/DptAdm/GetKv') } },
            schema: { data: "data", model: kv_list }
        });
        var bsd_data = new kendo.data.DataSource({
            type: "aspnetmvc-ajax",
            transport: { read: { dataType: 'json', url: bars.config.urlContent('/DptAdm/DptAdm/GetBSD') } },
            schema: { data: "data", model: bsd_list }
        });
        var basey_data = new kendo.data.DataSource({
            type: "aspnetmvc-ajax",
            transport: { read: { dataType: 'json', url: bars.config.urlContent('/DptAdm/DptAdm/GetBASEY') } },
            schema: { data: "data", model: basey_list }
        });
        var freq_data = new kendo.data.DataSource({
            type: "aspnetmvc-ajax",
            transport: { read: { dataType: 'json', url: bars.config.urlContent('/DptAdm/DptAdm/GetFREQ') } },
            schema: { data: "data", model: freq_n_list }
        });
        var metr_data = new kendo.data.DataSource({
            type: "aspnetmvc-ajax",
            transport: { read: { dataType: 'json', url: bars.config.urlContent('/DptAdm/DptAdm/GetMETR') } },
            schema: { data: "data", model: metr_list }
        });
        var ion_data = new kendo.data.DataSource({
            type: "aspnetmvc-ajax",
            transport: { read: { dataType: 'json', url: bars.config.urlContent('/DptAdm/DptAdm/GetION') } },
            schema: { data: "data", model: ion_list }
        });
        var brates_data = new kendo.data.DataSource({
            type: "aspnetmvc-ajax",
            transport: { read: { dataType: 'json', url: bars.config.urlContent('/DptAdm/DptAdm/GetBRATES') } },
            schema: { data: "data", model: brates_list }
        });
        var brates_data_wd = new kendo.data.DataSource({
            type: "aspnetmvc-ajax",
            transport: { read: { dataType: 'json', url: bars.config.urlContent('/DptAdm/DptAdm/GetBRATES') } },
            schema: { data: "data", model: brates_list }
        });
        var dpt_stop_data = new kendo.data.DataSource({
            type: "aspnetmvc-ajax",
            transport: { read: { dataType: 'json', url: bars.config.urlContent('/DptAdm/DptAdm/GetDPT_STOP') } },
            schema: { data: "data", model: dpt_stop_list }
        });
        var dpt_vidd_extypes_data = new kendo.data.DataSource({
            type: "aspnetmvc-ajax",
            transport: { read: { dataType: 'json', url: bars.config.urlContent('/DptAdm/DptAdm/GetDPT_VIDD_EXTYPES') } },
            schema: { data: "data", model: dpt_vidd_extypes_list }
        });
        var tarif_data = new kendo.data.DataSource({
            type: "aspnetmvc-ajax",
            transport: { read: { dataType: 'json', url: bars.config.urlContent('/DptAdm/DptAdm/GetTARIF') } },
            schema: { data: "data", model: tarif_list }
        });
        var active_data = new kendo.data.DataSource({
            type: "aspnetmvc-ajax",
            transport: { read: { dataType: 'json', url: bars.config.urlContent('/DptAdm/DptAdm/GetActive') } },
            schema: { data: "data", model: active_list }
        });

        //////////////////////////////////////////////////////////////////////////////
        $('#kvlst').kendoDropDownList({
            dataTextField: "NAME",            
            dataValueField: "KV",
            dataSource: kv_data,
            change: function () {
                $('#val_kv').val(this.value());
                $('#val_kv2').val(this.value());
            },
            dataBound: function () {
                $('#val_kv').val(this.value());
                $('#val_kv2').val(this.value());
            }
        });
        $("#TYPE_CODE").kendoDropDownList({
            dataTextField: "TYPE_NAME",
            dataValueField: "TYPE_CODE",
            dataSource: {
                type: "aspnetmvc-ajax",
                transport: {
                    read: {
                        dataType: 'json',
                        url: bars.config.urlContent('/DptAdm/DptAdm/GetDptType')
                    }
                },
                schema: {
                    data: "data",
                    model: dpt_type_list
                }
            },
            filter: "contains"
        });
        $('#bsdlst').kendoDropDownList({
            dataTextField: "NAME",
            dataValueField: "BSD",
            dataSource: bsd_data,
            change: function () { prepareBSN(this.value()); },
            dataBound: function () { prepareBSN(this.value()); }
        });
        $('#baseyddl').kendoDropDownList({
            dataTextField: "NAME",
            dataValueField: "BASEY",
            dataSource: basey_data,
            change: function () { $('#basey').val(this.value()); },
            dataBound: function () { $('#basey').val(this.value()); },
            filter: "contains"
        });
        $('#freq_intddl').kendoDropDownList({
            dataTextField: "NAME",
            dataValueField: "FREQ",
            dataSource: freq_data,
            change: function () { $('#freq_int').val(this.value()); },
            dataBound: function () { $('#freq_int').val(this.value()); },
            filter: "contains"
        });
        $('#payddl').kendoDropDownList({
            dataTextField: "NAME",
            dataValueField: "FREQ",
            dataSource: freq_data,
            change: function () { $('#pay').val(this.value()); },
            dataBound: function () { $('#pay').val(this.value()); },
            filter: "contains"
        });
        $('#methodddl').kendoDropDownList({
            dataTextField: "NAME",
            dataValueField: "METR",
            dataSource: metr_data,
            change: function () { $('#method').val(this.value()); },
            dataBound: function () { $('#method').val(this.value()); },
            filter: "contains"
        });
        $('#ostddl').kendoDropDownList({
            dataTextField: "NAME",
            dataValueField: "IO",
            dataSource: ion_data,
            change: function () { $('#ost').val(this.value()); },
            dataBound: function () { $('#ost').val(this.value()); },
            filter: "contains"
        });
        $('#ostddl').kendoDropDownList({
            dataTextField: "NAME",
            dataValueField: "IO",
            dataSource: ion_data,
            change: function () { $('#ost').val(this.value()); },
            dataBound: function () { $('#ost').val(this.value()); },
            filter: "contains"
        });
        $('#intrddl').kendoDropDownList({
            dataTextField: "NAME",
            dataValueField: "BR_ID",
            dataSource: brates_data,
            change: function () {
                //debugger;
                var br_id = this.value();
                var kv = $("#val_kv").val();                         
                $('#intr').val(br_id);
                if (br_id != null && kv != null && br_id != undefined && kv != undefined) {
                    getbaserate(br_id, kv, 1);
                    getbaseratedate(br_id, kv, 1);
                }
            },
            dataBound: function () { $('#intr').val(this.value()); },
            filter: "contains"
        });
        $('#penddl').kendoDropDownList({
            dataTextField: "NAME",
            dataValueField: "ID",
            dataSource: dpt_stop_data,
            change: function () { $('#pen').val(this.value()); },
            dataBound: function () { $('#pen').val(this.value()); },
            filter: "contains"
        });
        $('#partddl').kendoDropDownList({
            dataTextField: "NAME",
            dataValueField: "BR_ID",
            dataSource: brates_data_wd,
            change: function () {
                //debugger;
                $('#part').val(this.value());
                var br_id_part = this.value();
                var kv = $("#val_kv").val();                          
                if (br_id_part != null && kv != null && br_id_part != undefined && kv != undefined) {
                    getbaserate(br_id_part, kv, 2);
                    getbaseratedate(br_id_part, kv, 2);
            }
            },
            dataBound: function () {
                $('#part').val(this.value());                    
            },
            filter: "contains"
        });
        $('#extenddl').kendoDropDownList({
            dataTextField: "NAME",
            dataValueField: "ID",
            dataSource: dpt_vidd_extypes_data,
            change: function () { $('#exten').val(this.value()); },
            dataBound: function () { $('#exten').val(this.value()); },
            filter: "contains"
        });
        $('#rate_afterddl').kendoDropDownList({
            dataTextField: "NAME",
            dataValueField: "BR_ID",
            dataSource: brates_data,
            change: function () { $('#rate_afterval').val(this.value()); },
            dataBound: function () { $('#rate_afterval').val(this.value()); },
            filter: "contains"
        });
        $('#feeddl').kendoDropDownList({
            dataTextField: "NAME",
            dataValueField: "KOD",
            dataSource: tarif_data,
            change: function () { $('#feeval').val(this.value()); },
            dataBound: function () { $('#feeval').val(this.value()); },
            filter: "contains"
        });
        $('#activeddl').kendoDropDownList({
            dataTextField: "NAME",
            dataValueField: "ID",
            dataSource: active_data
        });
    }

    var prepareBSN = function (vBSD) {
        var bsn_list = kendo.data.Model.define({
            id: bsn_list,
            fields: { BSN: { type: "string" }, NAME: { type: "string" } }
        });
        var bsn_data = new kendo.data.DataSource({
            type: "aspnetmvc-ajax",
            transport: { read: { dataType: 'json', url: bars.config.urlContent('/DptAdm/DptAdm/GetBSN?BSD=') + vBSD } },
            schema: { data: "data", model: bsn_list }
        });
        $('#bsnlst').kendoDropDownList({
            dataTextField: "NAME",
            dataValueField: "BSN",
            dataSource: bsn_data
        });
    }

    var prepareBSA = function (vBSD, vAvans) {
        var bsa_list = kendo.data.Model.define({
            id: bsa_list,
            fields: { BSA: { type: "string" }, NAME: { type: "string" } }
        });
        var bsa_data = new kendo.data.DataSource({
            type: "aspnetmvc-ajax",
            transport: { read: { dataType: 'json', url: bars.config.urlContent('/DptAdm/DptAdm/GetBSA?BSD=' + vBSD + '&flag=' + vAvans) } },
            schema: { data: "data", model: bsa_list }
        });
        $('#bsalst').kendoDropDownList({
            dataTextField: "NAME",
            dataValueField: "BSA",
            dataSource: bsa_data
        });
    }
    var onAvansChange = function () {
        var $viddFrm = $('#wnd_vidd_info');
        var v_bsd = $viddFrm.find('#bsdlst').val();

        if ($viddFrm.find('#avans').prop('checked')) {
            prepareBSA(v_bsd, 1);
        }
    }

    var $viddForm = $('#wnd_vidd_info');

    function DOCDropDownEditor(container, options) {
        var doc_scheme_list = kendo.data.Model.define({
            id: doc_scheme_list,
            fields: { ID: { type: "string" } }
        });
        var doc_scheme = new kendo.data.DataSource({
            type: "aspnetmvc-ajax",
            transport: { read: { dataType: 'json', url: bars.config.urlContent('/DptAdm/DptAdm/GetDocScheme?FR=0') } },
            schema: { data: "data", model: doc_scheme_list }
        });
        $('<input required data-text-field="ID" data-value-field="ID" data-bind="value:' + options.field + '"style = "width:200px; font-size:10px"/>')
            .appendTo(container)
            .kendoDropDownList({
                autoBind: false,
                dataSource: doc_scheme,
                filter: "contains"
            });
    }

    function DOC_FRDropDownEditor(container, options) {
        var doc_scheme_list = kendo.data.Model.define({
            id: doc_scheme_list,
            fields: { ID: { type: "string" } }
        });
        var doc_fr_scheme = new kendo.data.DataSource({
            type: "aspnetmvc-ajax",
            transport: { read: { dataType: 'json', url: bars.config.urlContent('/DptAdm/DptAdm/GetDocScheme?FR=1') } },
            schema: { data: "data", model: doc_scheme_list }
        });

        $('<input required data-text-field="ID" data-value-field="ID" data-bind="value:' + options.field + '"style = "width:200px; font-size:10px" />')
           .appendTo(container)
           .kendoDropDownList({
               autoBind: false,
               dataSource: doc_fr_scheme,
               dataTextField: "ID",
               dataValueField: "ID",
               valueTemplate: "<span>#=ID#</span>",
               filter: "contains"
           });
    }


    clearFields = function () {    
        var VIDDtextbox = $("#VIDD").data("kendoNumericTextBox"); VIDDtextbox.value(null);
        var TYPE_NAMEtextbox = $("#TYPE_NAME").data("kendoMaskedTextBox"); TYPE_NAMEtextbox.value(null);
        var TYPE_CODEddl = $("#TYPE_CODE").data("kendoDropDownList"); TYPE_CODEddl.value(null);
        var kvlstddl = $('#kvlst').data("kendoDropDownList"); kvlstddl.value(980);
        $('#val_kv').val(980); $('#val_kv2').val(980);
        var bsdlstddl = $("#bsdlst").data("kendoDropDownList"); bsdlstddl.value(null);
        var bsnlstddl = $("#bsnlst").data("kendoDropDownList"); bsnlstddl.value(null);
        var bsnlstddl = $("#bsnlst").data("kendoDropDownList"); bsnlstddl.value(null);
        var baseyddl = $("#baseyddl").data("kendoDropDownList"); baseyddl.value(null);
        var limittextbox = $("#LIMIT").data("kendoNumericTextBox"); limittextbox.value(null);
        $('input[name=term1][value=0]').prop('checked', false);
        $('input[name=term1][value=1]').prop('checked', false);
        $('input[name=term1][value=2]').prop('checked', false);
        var monthstextbox = $("#months").data("kendoNumericTextBox"); monthstextbox.value(1);
        var daystextbox = $("#days").data("kendoNumericTextBox"); daystextbox.value(0);
        var months_maxtextbox = $("#months_max").data("kendoNumericTextBox"); months_maxtextbox.value(null);
        var days_maxtextbox = $("#days_max").data("kendoNumericTextBox"); days_maxtextbox.value(null);
        $('#from').val(null); $('#till').val(null); $('#avans').prop('checked', false);
        var kvlstddl = $("#kvlst").data("kendoDropDownList"); kvlstddl.value(null);
        //$('#avans').attr('checked', false);        
        var bsdlstddl = $("#bsdlst").data("kendoDropDownList"); bsdlstddl.value(null);
        var bsnlstddl = $("#bsnlst").data("kendoDropDownList"); bsnlstddl.value(null);
        var bsalstddl = $("#bsalst").data("kendoDropDownList"); bsalstddl.value(null);
        $('#minadd').val(0); $('#maxadd').val(0);
        $('#noadd').prop('checked', false); $('#autoadd').prop('checked', false);
        $('#termaddmin').val(0); $('#termaddmax').val(0);
        /*друга вкладка*/
        var baseyddl = $("#baseyddl").data("kendoDropDownList"); baseyddl.value(null); $('#basey').val(null);
        var freq_intddl = $("#freq_intddl").data("kendoDropDownList"); freq_intddl.value(null); $('#freq_int').val(null);
        var payddl = $("#payddl").data("kendoDropDownList"); payddl.value(null); $('#pay').val(null);
       
        $('#capddl').prop('checked', false); $('#int_fix').prop('checked', false);
        var methodddl = $("#methodddl").data("kendoDropDownList"); methodddl.value(null); $('#method').val(null);
        var ostddl = $("#ostddl").data("kendoDropDownList"); ostddl.value(null); $('#ost').val(null);
        var intrddl = $("#intrddl").data("kendoDropDownList"); intrddl.value(null); $('#intr').val(null); $('#PROC').val(null); $('#DAT_BRAT').val(null);
        var penddl = $("#penddl").data("kendoDropDownList"); penddl.value(null); $('#pen').val(-1);
        var partddl = $("#partddl").data("kendoDropDownList"); partddl.value(null); $('#part').val(-1);
        $('#tt').val("%%1");

        /*третя вкладка*/
        $('#teh2620').prop('checked', false);
        $('#auto_prol_flag1').prop('checked', false); $('#count_double').val(null);
        $('#auto_prol_flag2').prop('checked', false); var extenddl = $("#extenddl").data("kendoDropDownList"); extenddl.value(null); $('#exten').val(null);

        $('#rate_after').prop('checked', false); var rate_afterddl = $("#rate_afterddl").data("kendoDropDownList"); rate_afterddl.value(0); $('#rate_afterval').val(null);
        $('#fee').prop('checked', false); var feeddl = $("#feeddl").data("kendoDropDownList"); feeddl.value(null); $('#feeval').val(null);

        /*четверта вкладка*/
        $('#COMMENTS').val(null);
    }
    workmode = function (w_mode) {
        if (w_mode) { v_enabled = "enabled" } else { v_enabled = "disable" }
        savebtn = $("#buttonSave").data("kendoButton"); savebtn.enable(w_mode);
        savebtntype = $("#buttonsavetype").data("kendoButton"); savebtntype.enable(w_mode);
        var VIDDtextbox = $("#VIDD").data("kendoNumericTextBox"); VIDDtextbox.enable(false);
        var TYPE_NAMEtextbox = $("#TYPE_NAME").data("kendoMaskedTextBox"); TYPE_NAMEtextbox.enable(w_mode);
        var TYPE_CODEddl = $("#TYPE_CODE").data("kendoDropDownList"); TYPE_CODEddl.enable(w_mode);        
        var limittextbox = $("#LIMIT").data("kendoNumericTextBox"); limittextbox.enable(w_mode);
        var monthstextbox = $("#months").data("kendoNumericTextBox"); monthstextbox.enable(w_mode);
        var daystextbox = $("#days").data("kendoNumericTextBox"); daystextbox.enable(w_mode);
        var months_maxtextbox = $("#months_max").data("kendoNumericTextBox"); months_maxtextbox.enable(w_mode);
        var days_maxtextbox = $("#days_max").data("kendoNumericTextBox"); days_maxtextbox.enable(w_mode);
        var kvlstddl = $('#kvlst').data("kendoDropDownList"); kvlstddl.enable(w_mode);
        $('#val_kv').prop("disabled", !v_enabled); $('#val_kv2').prop("disabled", !v_enabled);
        var bsdlstddl = $("#bsdlst").data("kendoDropDownList"); bsdlstddl.enable(w_mode);
        var bsnlstddl = $("#bsnlst").data("kendoDropDownList"); bsnlstddl.enable(w_mode);
        var bsnlstddl = $("#bsnlst").data("kendoDropDownList"); bsnlstddl.enable(w_mode);
        var baseyddl = $("#baseyddl").data("kendoDropDownList"); baseyddl.enable(w_mode);
        var limittextbox = $("#LIMIT").data("kendoNumericTextBox"); limittextbox.enable(w_mode);
        $('input[name=term1][value=0]').prop("disabled", !v_enabled);
        $('input[name=term1][value=1]').prop("disabled", !v_enabled);
        $('input[name=term1][value=2]').prop("disabled", !v_enabled);
        var monthstextbox = $("#months").data("kendoNumericTextBox"); monthstextbox.enable(w_mode);
        var daystextbox = $("#days").data("kendoNumericTextBox"); daystextbox.enable(w_mode);
        var months_maxtextbox = $("#months_max").data("kendoNumericTextBox"); //months_maxtextbox.enable(w_mode);
        var days_maxtextbox = $("#days_max").data("kendoNumericTextBox"); //days_maxtextbox.enable(w_mode);
        var fromdatepicker = $("#from").data("kendoDatePicker"); //fromdatepicker.enable(w_mode);
        var tilldatepicker = $("#till").data("kendoDatePicker"); //tilldatepicker.enable(w_mode);
        $('#avans').prop('enabled', w_mode);
        var kvlstddl = $("#kvlst").data("kendoDropDownList"); kvlstddl.enable(w_mode);
        var bsdlstddl = $("#bsdlst").data("kendoDropDownList"); bsdlstddl.enable(w_mode);
        var bsnlstddl = $("#bsnlst").data("kendoDropDownList"); bsnlstddl.enable(w_mode);
        var bsalstddl = $("#bsalst").data("kendoDropDownList"); bsalstddl.enable(w_mode);
        $('#minadd').prop("disabled", !v_enabled); $('#maxadd').prop("disabled", !v_enabled);
        $('#noadd').prop("disabled", !v_enabled); $('#autoadd').prop("disabled", !v_enabled);
        $('#termaddmin').prop("disabled", !v_enabled); $('#termaddmax').prop("disabled", !v_enabled);
        var baseyddl = $("#baseyddl").data("kendoDropDownList"); baseyddl.value(null); $('#basey').prop("disabled", !v_enabled);
        var freq_intddl = $("#freq_intddl").data("kendoDropDownList"); freq_intddl.value(null); $('#freq_int').prop("disabled", !v_enabled);
        var payddl = $("#payddl").data("kendoDropDownList"); payddl.enable(w_mode); $('#pay').prop("disabled", !v_enabled);

        $('#capddl').prop('checked', false); $('#int_fix').prop('checked', false);
        var methodddl = $("#methodddl").data("kendoDropDownList"); methodddl.enable(w_mode); $('#method').prop("disabled", !v_enabled);
        var ostddl = $("#ostddl").data("kendoDropDownList"); ostddl.enable(w_mode); $('#ost').prop("disabled", !v_enabled);
        var intrddl = $("#intrddl").data("kendoDropDownList"); intrddl.enable(w_mode); $('#intr').prop("disabled", !v_enabled);
        var penddl = $("#penddl").data("kendoDropDownList"); penddl.enable(w_mode); $('#pen').prop("disabled", !v_enabled);
        var partddl = $("#partddl").data("kendoDropDownList"); partddl.enable(w_mode); $('#part').prop("disabled", !v_enabled);
        $('#tt').prop("disabled", !v_enabled);

        /*третя вкладка*/
        //$('#teh2620').attr("enabled", v_enabled);
        //$('#auto_prol_flag1').attr("enabled", v_enabled); $('#count_double').attr("enabled", v_enabled);
        //$('#auto_prol_flag2').attr("enabled", v_enabled); var extenddl = $("#extenddl").data("kendoDropDownList"); extenddl.enable(w_mode); $('#exten').attr("enabled", v_enabled);

        //$('#rate_after').attr("enabled", v_enabled); 
        var rate_afterddl = $("#rate_afterddl").data("kendoDropDownList"); rate_afterddl.enable(w_mode);
        //$('#rate_afterval').attr("enabled", v_enabled);
        //$('#fee').attr("enabled", v_enabled);
        var feeddl = $("#feeddl").data("kendoDropDownList"); feeddl.enable(w_mode);
        //$('#feeval').attr("enabled", v_enabled);

        /*четверта вкладка*/
        //$('#COMMENTS').attr("enabled", v_enabled);
    }
    clearTypeFields = function () {
        var TYPE_IDtextbox = $("#TYPEINFO_TYPE_ID").data("kendoNumericTextBox"); TYPE_IDtextbox.value(null);
        var TYPE_NAMEtextbox = $("#TYPEINFO_TYPE_NAME").data("kendoMaskedTextBox"); TYPE_NAMEtextbox.value(null);
        var TYPE_CODEtextbox = $("#TYPEINFO_TYPE_CODE").data("kendoMaskedTextBox"); TYPE_CODEtextbox.value(null);
        var TYPE_FL_ACTIVEddl = $("#TYPEINFO_FL_ACTIVE").data("kendoDropDownList"); TYPE_FL_ACTIVEddl.value(null);
        var TYPE_FL_WEBBANKINGddl = $("#TYPEINFO_FL_WEBBANKING").data("kendoDropDownList"); TYPE_FL_WEBBANKINGddl.value(null);
        var TYPE_FL_DEMANDddl = $("#TYPEINFO_FL_DEMAND").data("kendoDropDownList"); TYPE_FL_DEMANDddl.value(null);
        var SORT_ORDtextbox = $("#TYPEINFO_SORT_ORD").data("kendoNumericTextBox"); SORT_ORDtextbox.value(null);
    }
    populateType = function (result, clon) {
        var TYPE_IDtextbox = $("#TYPEINFO_TYPE_ID").data("kendoNumericTextBox");
        if (clon == 1) { result.data[0].TYPE_ID = null; }
        TYPE_IDtextbox.value(result.data[0].TYPE_ID);        
        var TYPE_NAMEtextbox = $("#TYPEINFO_TYPE_NAME").data("kendoMaskedTextBox"); TYPE_NAMEtextbox.value(result.data[0].TYPE_NAME);
        var TYPE_CODEtextbox = $("#TYPEINFO_TYPE_CODE").data("kendoMaskedTextBox"); TYPE_CODEtextbox.value(result.data[0].TYPE_CODE);
        var TYPE_FL_ACTIVEddl = $("#TYPEINFO_FL_ACTIVE").data("kendoDropDownList"); TYPE_FL_ACTIVEddl.value(result.data[0].FL_ACT);
        var TYPE_FL_WEBBANKINGddl = $("#TYPEINFO_FL_WEBBANKING").data("kendoDropDownList"); TYPE_FL_WEBBANKINGddl.value(result.data[0].FL_WB);
        var TYPE_FL_DEMANDddl = $("#TYPEINFO_FL_DEMAND").data("kendoDropDownList"); TYPE_FL_DEMANDddl.value(result.data[0].FL_DEM);
        var SORT_ORDtextbox = $("#TYPEINFO_SORT_ORD").data("kendoNumericTextBox"); SORT_ORDtextbox.value(result.data[0].SORT_ORD);
    }
    populateTTS = function (VIDD, clon) {
        $.get(bars.config.urlContent('/DptAdm/DptAdm/GetViddTTS'), { VIDD: VIDD }).done(function (result) {
            if (result.status == "ok") {
                // грид операций вида
                var grid_vidd_tts = $('#grid_vidd_tts').kendoGrid({
                    autobind: true,
                    selectable: "row",
                    scrolable: true,                    
                    columns: [{
                        field: "added",
                        title: "-/+",
                        width: "5%",
                        attributes: { "class": "table-cell", style: "text-align: center; font-size: 12px" },
                        template: "<input type='checkbox' class='checkbox' #= added == '+' ? 'checked=checked' : '' # onclick='addTTS(" + VIDD + "," + '"#=OP_TYPE#"' + ");'>"
                    },
                        {
                            field: "OP_TYPE",
                            title: "КОД",
                            width: "5%",
                            attributes: { "class": "table-cell", style: "text-align: center; font-size: 12px" }
                        }, {
                            field: "OP_NAME",
                            title: "Назва операції",
                            width: "30%",
                            attributes: { "class": "table-cell", style: "text-align: left; font-size: 12px" }
                        }, {
                            field: "TT_ID",
                            title: "Код<br>типу</br>",
                            width: "4%",
                            attributes: { "class": "table-cell", style: "text-align: center; font-size: 12px" }
                        },
                    {
                        field: "TT_NAME",
                        title: "Зміст/призначення операції",
                        width: "20%",
                        attributes: { "class": "table-cell", style: "text-align: left; font-size: 12px" }
                    }, {
                        field: "TT_CASH",
                        title: "Ознака<br>каси</br>",
                        width: "3%",
                        attributes: { "class": "table-cell", style: "text-align: center; font-size: 12px" }
                    }
                    ],
                    dataSource: result.data
                });
            }
        });
    }

    addTTS = function (VIDD, OP_TYPE) {
        $.ajax({
            type: "POST",
            url: bars.config.urlContent('/DptAdm/DptAdm/AddTTS'),
            data: { VIDD: VIDD, OP_TYPE: OP_TYPE },
            success: function (data) {
                if (data.error) {
                    bars.utils.sto.showModalWindow(data.error);
                } else {
                    populateTTS(VIDD, 0);
                }
            }
        });
    }

    activateDoc = function (VIDD, FLG, DOC, DOC_FR) {
        // alert(VIDD + ';' + FLG + ';' + DOC+ ';' + DOC_FR);
        /* if (DOC == "null" && DOC_FR == "null")
         { alert('Один з шаблонів повинен бути підв"язаний!') }
         else {
             $.ajax({
                 type: "POST",
                 url: bars.config.urlContent('/DptAdm/DptAdm/ActivateDOC'),
                 data: { VIDD: VIDD, FLG: FLG, DOC: DOC, DOC_FR: DOC_FR },
                 success: function (data) {
                     if (data.error) {
                         bars.utils.sto.showModalWindow(data.error);
                     } else {
                         populateDOC(VIDD, 0);
                     }
                 }
             });
         }*/
    }
    populateParam = function (VIDD) {
        var GetViddParamdataSource = new kendo.data.DataSource({
            type: "aspnetmvc-ajax",
            transport: {
                read: {
                    dataType: 'json',
                    url: bars.config.urlContent('/DptAdm/DptAdm/GetDptViddParam?VIDD=' + VIDD)
                },
                parameterMap: function (options, operation) {
                    if (operation !== "read" && options.models) {
                        return { models: kendo.stringify(options.models) };
                    }
                }
            }, batch: true,
            schema: {
                data: "data",
                model: {
                    fields: {
                        tag: { editable: false },                        
                        name: { editable: false },
                        val: { editable: true}
                    }
                }
            }
        });

        // грид параметров вида
        var grid_vidd_param = $('#grid_vidd_param').kendoGrid({
            autobind: true,
            selectable: "raw",
            scrolable: true,
            sortable: true, 
            dataSource: GetViddParamdataSource,
            columns: [
                 {
                     field: "tag",
                     title: "Код",
                     width: "15%",
                     attributes: { "class": "table-cell", style: "enabled: false; text-align: center; font-size: 12px" }
                 }, {
                     field: "name", 
                     title: "Назва параметру",
                     width: "40%",
                     attributes: { "class": "table-cell", style: "enabled: false; text-align: left; font-size: 12px" }
                 },
                {
                    field: "val",
                    title: "Значення",
                    width: "15%",
                    attributes: { "class": "table-cell", style: "enabled: true; text-align: center; font-size: 12px" }
                },
                { command: "edit" }
            ],
            filterable: true,
            editable: "popup",
            save: function (e) {                
                setParam(e.model.vidd, e.model.tag, e.model.val);
                GetViddParamdataSource.read();
                $('#grid_vidd_param').data('kendoGrid').refresh();
            }
        });        
    }
    var dateRegExp = /[0-9]{2}\/[0-9]{2}\/[0-9]{4}$/;
    setParam = function (vidd, tag, val) {        
        if ((tag == 'FORB_EARLY_DATE' && (dateRegExp.exec(val) != null || val =="")) || tag != 'FORB_EARLY_DATE')
        {
            $.ajax({
                type: "POST",
                url: bars.config.urlContent('/DptAdm/DptAdm/PutParam'),
                data: { vidd: vidd, tag: tag, val: val },
                success: function (data) {
                    if (data.error) {
                        bars.ui.error({ text: 'Параметри виду не збережено! Помилка даних' });
                        return true;
                    } else {
                        bars.ui.alert({ text: 'Параметри виду збережено!' });
                        return false;
                    }
                }
            });
        }
        else
        {
            bars.ui.error({ text: 'Параметри виду не збережено! Помилка даних формата параметра FORB_EARLY_DATE (dd/mm/yyyy)!' });
            return false;
        }
    }

    populateDOC = function (VIDD, clon) {

        var GetViddDOCdataSource = new kendo.data.DataSource({
            type: "aspnetmvc-ajax",
            transport: {
                read: {
                    dataType: 'json',
                    url: bars.config.urlContent('/DptAdm/DptAdm/GetViddDOC?VIDD=' + VIDD)
                },
                parameterMap: function (options, operation) {
                    if (operation !== "read" && options.models) {
                        return { models: kendo.stringify(options.models) };
                    }
                }
            }, batch: true,
            schema: {
                data: "data",
                model: {
                    fields: {
                        Active: { editable: false },
                        FLG: { editable: false },
                        NAME: { editable: false },
                        DOC: { editable: true },
                        DOC_FR: { editable: true }
                    }
                }
            }
        });

        // грид шаблонов вида
        var grid_vidd_doc = $('#grid_vidd_doc').kendoGrid({
            autobind: true,
            selectable: "row",
            scrolable: true,
            sortable: true, autoSync: true,
            dataSource: GetViddDOCdataSource,            
            columns: [          
            {
                field: "FLG",
                title: "КОД",
                width: "5%",
                attributes: { "class": "table-cell", style: "enabled: false; text-align: center; font-size: 12px" }
            }, {
                field: "NAME", editable: false,
                title: "Тип договору (додаткової угоди)",
                width: "30%",
                attributes: { "class": "table-cell", style: "enabled: false; text-align: left; font-size: 12px" },
                editor: { }
            }, {
                field: "DOC",
                title: "Шаблон",
                width: "20%",
                attributes: { "class": "table-cell", style: "text-align: left; font-size: 12px" },
                editor: DOCDropDownEditor
            },
            {
                field: "DOC_FR",
                title: "Шаблон FRX",
                width: "20%",
                attributes: { "class": "table-cell", style: "text-align: left; font-size: 12px" },
                editor: DOC_FRDropDownEditor
            },
             { command: "edit" }, { template: '<a class="k-button" enabled href="\\#" onclick="return clearDoc(#=FLG#)">Відв"язати</a>' }
            ],
            filterable: true,
            editable: "popup",
            save: function (e) {                
                if (e.model.DOC != " " && e.model.DOC_FR != " "){
                    setDoc(VIDD, e.model.FLG, e.model.DOC, e.model.DOC_FR);
                }
                else if (e.model.DOC != " " && e.model.DOC_FR == " ") {
                    setDoc(VIDD, e.model.FLG, e.model.DOC, null);
                }
                else if (e.model.DOC == " " && e.model.DOC_FR != " ") {
                    setDoc(VIDD, e.model.FLG, null, e.model.DOC_FR);
                }
                else {  bars.ui.error({ text: "Зміни не внесено!"}); }
                GetViddDOCdataSource.read();
                return false;
            }
        });
            
    
        setDoc = function (vidd, flg, doc, doc_fr) {                      
            $.ajax({
                type: "POST",
                url: bars.config.urlContent('/DptAdm/DptAdm/AddDoc2Vidd'),
                data: { vidd: vidd, flg: flg, doc: doc, doc_fr: doc_fr },
                success: function (data) {
                    if (data.error) {
                        bars.ui.error({ text: "Не збережено! Помилка даних" });
                    } else {
                        bars.ui.alert({ text: "Збережено!" });
                        GetViddDOCdataSource.read();
                    }
                    $('#grid_vidd_doc').data('kendoGrid').dataSource.read();
                    $('#grid_vidd_doc').data('kendoGrid').refresh();
                }
            });
        }

        clearDoc = function (FLG) {
            var gridvidd = $('#grid_dpt_vidd').data('kendoGrid');
            var currentRow = gridvidd.dataItem(gridvidd.select());           
            $.ajax({
                type: "POST",
                url: bars.config.urlContent('/DptAdm/DptAdm/ClearDoc2Vidd'),
                data: { VIDD: currentRow.vidd, FLG: FLG },
                success: function (data) {
                    if (data.error) {
                        bars.ui.error({ text: 'Не збережено! Помилка даних' });
                    } else {
                        bars.ui.alert({ text: 'Збережено!' });
                    }
                    $('#grid_vidd_doc').data('kendoGrid').dataSource.read();
                    $('#grid_vidd_doc').data('kendoGrid').refresh();
                }
            });
        }
    }

    populateVidd = function (result, clon) {
        /*Перша вкладка*/        
        var VIDDtextbox = $("#VIDD").data("kendoNumericTextBox");
        if (clon == 1) { result.data[0].VIDD = null; }
        VIDDtextbox.value(result.data[0].VIDD);
        var TYPE_NAMEtextbox = $("#TYPE_NAME").data("kendoMaskedTextBox"); TYPE_NAMEtextbox.value(result.data[0].TYPE_NAME);
        var TYPE_CODEddl = $("#TYPE_CODE").data("kendoDropDownList"); TYPE_CODEddl.value(result.data[0].TYPE_COD);
        $('#val_kv').val(result.data[0].KV);
        $('#KV').val(result.data[0].KV);
        var limittextbox = $("#LIMIT").data("kendoNumericTextBox"); limittextbox.value(result.data[0].MIN_SUMM);

        $('#val_kv2').val(result.data[0].KV);
        $('input[name=term1][value=0]').prop('checked', result.data[0].TERM_TYPE == 0);
        $('input[name=term1][value=1]').prop('checked', result.data[0].TERM_TYPE == 1);
        $('input[name=term1][value=2]').prop('checked', result.data[0].TERM_TYPE == 2);
        var monthstextbox = $("#months").data("kendoNumericTextBox"); monthstextbox.value(result.data[0].DURATION);
        var daystextbox = $("#days").data("kendoNumericTextBox"); daystextbox.value(result.data[0].DURATION_DAYS);
        var months_maxtextbox = $("#months_max").data("kendoNumericTextBox"); months_maxtextbox.value(result.data[0].DURATION_MAX);
        var days_maxtextbox = $("#days_max").data("kendoNumericTextBox"); days_maxtextbox.value(result.data[0].DURATION_DAYS_MAX);
        $('#from').val(result.data[0].DATN);
        $('#till').val(result.data[0].DATK);
        $('#avans').prop('checked', result.data[0].METR == 1);
        $('#kvlst').data("kendoDropDownList").value(result.data[0].KV);
        var dropdownlist = $("#kvlst").data("kendoDropDownList");
        var vAvans;
        if (result.data[0].AMR_METR == 4) { vAvans = 1 } else { vAvans = 0 }
        //if (vAvans == 1) { $('#avans').attr('checked', true); } else { $('#avans').attr('checked', false); }
        $('#bsdlst').data("kendoDropDownList").value(result.data[0].BSD);
        var dropdownlist = $("#bsdlst").data("kendoDropDownList");

        prepareBSN(result.data[0].BSD);
        var dropdownlist = $("#bsnlst").data("kendoDropDownList");
        var dropdownlist = $("#bsalst").data("kendoDropDownList");
        if (result.data[0].METR != 1) prepareBSA(result.data[0].BSD, vAvans);
        dropdownlist.enable(true);            
        var minaddtextbox = $("#minadd").data("kendoNumericTextBox"); minaddtextbox.value(result.data[0].LIMIT);
        $('#noadd').prop('checked', result.data[0].DISABLE_ADD == 1);        
        var maxaddtextbox = $("#maxadd").data("kendoNumericTextBox"); maxaddtextbox.value(result.data[0].MAX_LIMIT);
        $('#autoadd').prop('checked', result.data[0].AUTO_ADD == 1);
        //debugger;
        var m_add = Math.round(result.data[0].TERM_ADD, 0);
        var d_add = Math.round(100 * (result.data[0].TERM_ADD - Math.round(result.data[0].TERM_ADD, 0)), 0);
        var termaddmintextbox = $("#termaddmin").data("kendoNumericTextBox"); termaddmintextbox.value(m_add);
        var termaddmaxtextbox = $("#termaddmax").data("kendoNumericTextBox"); termaddmaxtextbox.value(d_add);        
        /*друга вкладка*/
        $("#baseyddl").data("kendoDropDownList").value(result.data[0].BASEY);
        var dropdownlist = $("#baseyddl").data("kendoDropDownList");
        dropdownlist.enable(true);
        $('#basey').val(result.data[0].BASEY);
        $("#freq_intddl").data("kendoDropDownList").value(result.data[0].FREQ_N);
        var dropdownlist = $("#freq_intddl").data("kendoDropDownList");
        dropdownlist.enable(true);
        $('#freq_int').val(result.data[0].FREQ_N);

        $("#payddl").data("kendoDropDownList").value(result.data[0].FREQ_K);
        var dropdownlist = $("#payddl").data("kendoDropDownList");
        dropdownlist.enable(true);
        $('#pay').val(result.data[0].FREQ_K);
        //debugger;
        $('#capddl').prop('checked', result.data[0].COMPROC == 1);
        $('#int_fix').prop('checked', result.data[0].BASEM == 1);

        $("#methodddl").data("kendoDropDownList").value(result.data[0].METR);
        var dropdownlist = $("#methodddl").data("kendoDropDownList");
        dropdownlist.enable(true);
        $('#method').val(result.data[0].METR);

        $("#ostddl").data("kendoDropDownList").value(result.data[0].TIP_OST);
        var dropdownlist = $("#ostddl").data("kendoDropDownList");
        dropdownlist.enable(true);
        $('#ost').val(result.data[0].TIP_OST);

        $("#intrddl").data("kendoDropDownList").value(result.data[0].BR_ID);
        var dropdownlist = $("#intrddl").data("kendoDropDownList");
        dropdownlist.enable(true);
        
        $('#intr').val(result.data[0].BR_ID);
        $('#PROC').prop('disabled', true);
        $('#DAT_BRAT').prop('disabled', true);

        $('#PROC').val(null); $('#DAT_BRAT').val(null);
        getbaserate(result.data[0].BR_ID, result.data[0].KV,1);
        getbaseratedate(result.data[0].BR_ID, result.data[0].KV,1);
       
        $('#penddl').data("kendoDropDownList").value(result.data[0].ID_STOP);
        var dropdownlist = $("#penddl").data("kendoDropDownList");
        dropdownlist.enable(true);
        $('#pen').val(result.data[0].ID_STOP);

        $('#partddl').data("kendoDropDownList").value(result.data[0].BR_WD);
        var dropdownlist = $("#partddl").data("kendoDropDownList");
        dropdownlist.enable(true);
        $('#part').val(result.data[0].BR_WD);
        $('#partval').val(null); $('#partdate').val(null);
        $('#partval').prop('disabled', true); $('#partdate').prop('disabled', true);
        getbaserate(result.data[0].BR_WD, result.data[0].KV, 2);
        getbaseratedate(result.data[0].BR_WD, result.data[0].KV, 2);

        $('#tt').val(result.data[0].TT);

        /*третя вкладка*/
        $('#teh2620').prop('checked', result.data[0].FL_2620 == 1);
        $('#auto_prol_flag1').prop('checked', result.data[0].FL_DUBL == 1);
        $('#count_double').val(result.data[0].TERM_DUBL);
        $('#auto_prol_flag2').prop('checked', result.data[0].FL_DUBL == 2);

        $('#extenddl').data("kendoDropDownList").value(result.data[0].EXTENSION_ID);
        var dropdownlist = $("#extenddl").data("kendoDropDownList");
        dropdownlist.enable(true);
        $('#exten').val(result.data[0].EXTENSION_ID);

        $('#rate_after').prop('checked', result.data[0].BR_ID_L >= 1);
        $('#rate_afterddl').data("kendoDropDownList").value(result.data[0].BR_ID_L);
        var dropdownlist = $("#rate_afterddl").data("kendoDropDownList");
        dropdownlist.enable(true);
        $('#rate_afterval').val(result.data[0].BR_ID_L);

        $('#fee').prop('checked', result.data[0].CODE_TARIF >= 1);
        $('#feeddl').data("kendoDropDownList").value(result.data[0].CODE_TARIF);
        var dropdownlist = $("#feeddl").data("kendoDropDownList");
        dropdownlist.enable(true);
        $('#feeval').val(result.data[0].CODE_TARIF);

        /*четверта вкладка*/
        $('#COMMENTS').val(result.data[0].COMMENTS);
    }

    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // окно вида вклада карточка
    prepareViddDialog = function (mode) {
        var wnd = $("#wnd_vidd_info").data("kendoWindow");
        var grid = $("#grid_dpt_vidd").data("kendoGrid");
        var currentRowData = null;
        var titlestr;
        var NextVidd = 0;
        if (mode === "add") {
            workmode(true);
            titlestr = "Картка виду вкладу [Додавання нового]";
            var gridtype = $("#grid_dpt_types").data("kendoGrid");
            var currentRowDataType = null;
            if (gridtype.select().length > 0) {
                currentRowDataType = gridtype.dataItem(grid.select());
                var TYPE_CODEddl = $("#TYPE_CODE").data("kendoDropDownList"); TYPE_CODEddl.value(currentRowDataCod().TYPE_CODD);
                clearFields();               
                $.get(bars.config.urlContent('/DptAdm/DptAdm/GetNextVidd')).done(function (result) {
                    if (result.status == "ok") {
                        NextVidd = result.data;                       
                        var VIDDtextbox = $("#VIDD").data("kendoNumericTextBox"); VIDDtextbox.value(NextVidd);                        
                    }
                });
                wnd.title(titlestr);
                wnd.center().open();
            }
        } else {
            if (grid.select().length > 0) {
                currentRowData = grid.dataItem(grid.select());
                $.get(bars.config.urlContent('/DptAdm/DptAdm/GetDptViddINFOALL'), { VIDD: currentRowData.vidd }).done(function (result) {
                    if (result.status == "ok") {
                        if (mode === "edit") {
                            workmode(true);
                            titlestr = "Картка виду вкладу [Редагування вкладу № " + currentRowData.TYPE_NAME + "]";
                            populateVidd(result, 0);
                        }
                        else if (mode === "view") {
                            workmode(false);
                            titlestr = "Картка виду вкладу [Перегляд вкладу № " + currentRowData.TYPE_NAME + "]";
                            populateVidd(result, 0);
                        }
                        else if (mode === "clon") {
                            workmode(true);
                            titlestr = "Картка виду вкладу [Копіювання вкладу № " + currentRowData.TYPE_NAME + "]";
                            $.get(bars.config.urlContent('/DptAdm/DptAdm/GetNextVidd')).done(function (result) {
                                if (result.status == "ok") {
                                    NextVidd = result.data;
                                    var VIDDtextbox = $("#VIDD").data("kendoNumericTextBox"); VIDDtextbox.value(NextVidd);
                                }
                            });
                            populateVidd(result, 1);
                        }
                        wnd.title(titlestr);
                        wnd.center().open();
                    }
                });
            }
            else { bars.ui.alert({ text: "Не обрано вид депозиту!" }); }
        }
    }
    grid_dpt_types.bind("edit", function () { prepareTypeDialog("view"); });
    grid_dpt_types.bind("dblclick", function () { var flag_ok = prepareTypeDialog("edit"); });
    grid_dpt_vidd.bind("edit", function () { prepareViddDialog("view"); });
    grid_dpt_vidd.bind("dblclick", function () { var flag_ok = prepareViddDialog("edit"); });
    getVIDDFilter = function () { return { csp: $('#grid_dpt_vidd').serializeObject() } };

    function checkZero(input) {
        if (input.is("[data-notzero-msg]") && input.prop('required')) {
            return input.val() > 0;
        }
        return true;
    }
    var validationRules = {
        notzero: function (input) {
            return checkZero(input);
        }
    };

    var validationContainer = $('#wnd_vidd_info');
    kendo.init(validationContainer);
    validationContainer.kendoValidator({
        rules: validationRules
    });


    getViddData = function () {
        var $viddFrm = $('#wnd_vidd_info');

        if ($('#auto_prol_flag1').prop('checked')) { v_FL_DUBL = 1; }
        else {
            if ($('#auto_prol_flag2').prop('checked')) { v_FL_DUBL = 2; }
            else { v_FL_DUBL = 0; }
        }
        if ($viddFrm.find('#teh2620').prop('checked')) { v_FL_2620 = 1; }
        else { v_FL_2620 = 0; }

        if ($viddFrm.find('#capddl').prop('checked')) { v_COMPROC = 1; }
        else { v_COMPROC = 0; }

        if ($viddFrm.find('#autoadd').prop('checked')) { v_AUTO_ADD = 1; }
        else { v_AUTO_ADD = 0; }

        if ($viddFrm.find('#noadd').prop('checked')) { v_DISABLE_ADD = 1; }
        else { v_DISABLE_ADD = 0; }
        //debugger;
        if ($viddFrm.find('#int_fix').prop('checked')) { v_BASEM = 1; } //Признак фиксир.%-ной ставки
        else { v_BASEM = 0; }
        debugger;
        if ($viddFrm.find('#avans').prop('checked')) { v_AMR_METR = 4; } else { v_AMR_METR = 0; }        
        return {
            VIDD: $viddFrm.find('#VIDD').val(),
            TYPE_COD: $viddFrm.find('#TYPE_CODE').val(),
            TYPE_NAME: $viddFrm.find('#TYPE_NAME').val(),
            BASEY: $viddFrm.find('#basey').val(),
            BASEM: v_BASEM, //Признак фиксир.%-ной ставки
            BR_ID: $viddFrm.find('#intr').val(),
            FREQ_N: $viddFrm.find('#freq_int').val(),
            FREQ_K: $viddFrm.find('#pay').val(),
            BSD: $viddFrm.find('#bsdlst').val(),
            BSN: $viddFrm.find('#bsnlst').val(),
            METR: $viddFrm.find('#method').val(),
            AMR_METR: v_AMR_METR,
            DURATION: $viddFrm.find('#months').val(),
            TERM_TYPE: $viddFrm.find('input[name=term1]:checked').val(),
            MIN_SUMM: $viddFrm.find('#LIMIT').val(),
            COMMENTS: $viddFrm.find('#COMMENTS').val(),
            DEPOSIT_COD: "",
            KV: $viddFrm.find('#val_kv').val(),
            TT: $viddFrm.find('#tt').val(),
            SHABLON: "",
            IDG: "",
            IDS: "",
            NLS_K: "",
            DATN: $viddFrm.find('#from').val(),
            DATK: $viddFrm.find('#till').val(),
            BR_ID_L: $viddFrm.find('#rate_afterval').val(),
            FL_DUBL: v_FL_DUBL,
            ACC7: "",
            ID_STOP: $viddFrm.find('#pen').val(),
            KODZ: "",
            FMT: "",
            FL_2620: v_FL_2620,
            COMPROC: v_COMPROC,
            LIMIT: $viddFrm.find('#minadd').val(),            
            TERM_ADD: parseFloat($viddFrm.find('#termaddmin').val()) + parseFloat(($viddFrm.find('#termaddmax').val() / 100)),
            TERM_DUBL: $viddFrm.find('#count_double').val(),
            DURATION_DAYS: $viddFrm.find('#days').val(),
            EXTENSION_ID: $viddFrm.find('#exten').val(),
            TIP_OST: $viddFrm.find('#ost').val(),
            BR_WD: $viddFrm.find('#part').val(),
            NLSN_K: "",
            BSA: "",
            MAX_LIMIT: $viddFrm.find('#maxadd').val(),
            BR_BONUS: 0,
            BR_OP: 0,
            AUTO_ADD: v_AUTO_ADD,
            TYPE_ID: "",
            DISABLE_ADD: v_DISABLE_ADD,
            CODE_TARIFF: $viddFrm.find('#feeval').val(),
            DURATION_MAX: $viddFrm.find('#months_max').val(),
            DURATION_DAYS_MAX: $viddFrm.find('#days_max').val(),
            IRREVOCABLE: 0
        }
    };

    t_isUsedType = function (type_code, mode) {
        if (mode === "add") {
            var gridtype = $('#grid_dpt_types').data('kendoGrid');

            var count = gridtype._data.length;
            for (var i = 0; i < count; i++) {
                bars.ui.alert({ text: gridtype._data[i].TYPE_CODE + ' - ' + type_code });
                if (gridtype._data[i].TYPE_CODE == type_code) { return true; }
            }
            return false;
        } else return false;
    }

    getTypeData = function (mode) {
        var $TypeFrm = $('#wnd_type_info');
        return {
            TYPE_ID: $TypeFrm.find('#TYPEINFO_TYPE_ID').val(),
            TYPE_CODE: $TypeFrm.find('#TYPEINFO_TYPE_CODE').val(),
            TYPE_NAME: $TypeFrm.find('#TYPEINFO_TYPE_NAME').val(),
            FL_ACTIVE: "",
            FL_DEMAND: "",
            FL_ACT: $TypeFrm.find('#TYPEINFO_FL_ACTIVE').val(),
            FL_DEM: $TypeFrm.find('#TYPEINFO_FL_DEMAND').val(),
            FL_WEBBANKING: $TypeFrm.find('#TYPEINFO_FL_WEBBANKING').val(),
            SORT_ORD: $TypeFrm.find('#TYPEINFO_SORT_ORD').val(),
            COUNT_ACTIVE: 0
        }
    };
    getDocData = function (mode) {
        var grid_docs = $("#grid_vidd_doc").data("kendoGrid");
        var currentDocData = null;
        if (grid_docs.select().length > 0) {
            currentDocData = grid_docs.dataItem(grid_docs.select());
            bars.ui.alert({ text: grid_docs._data[currentDocData.FLG].DOC });
            return {
                vidd: currentDocData.vidd,
                FLG: currentDocData.FLG,
                DOC: grid_docs._data[currentDocData.FLG - 1].DOC,
                DOC_FR: grid_docs._data[currentDocData.FLG - 1].DOC_FR
            }
        }
    };

    saveproc = function () {
        $.ajax({
            type: "POST",
            url: bars.config.urlContent('/DptAdm/DptAdm/saveVidd'),
            data: getViddData(),
            success: function (data) {
                if (data.status == "error")
                    bars.ui.error({ text: data.message });
                else {
                    bars.ui.alert({ text: data.message });
                }               
                $('#grid_dpt_vidd').data('kendoGrid').dataSource.read();
                $('#grid_dpt_vidd').data('kendoGrid').refresh();
            }
        });
    };
    saveTypeproc = function (mode) {
        $.ajax({
            type: "POST",
            url: bars.config.urlContent('/DptAdm/DptAdm/saveTYPE'),
            data: getTypeData(mode),
            success: function (data) {
                if (data.status == "error")
                    bars.ui.error({ text: data.message });
                else {
                    bars.ui.alert({ text: data.message });
                    $('#grid_dpt_types').data("kendoGrid").dataSource.read();
                    $('#grid_dpt_types').data("kendoGrid").refresh();
                }
            },
            error: function () { bars.ui.error({ text: data.message }); }
        });
    };

    $("#buttonSave").kendoButton();
    var button = $("#buttonSave").data("kendoButton");

    button.bind("click", function (e) {
        var wnd = $("#wnd_vidd_info").data("kendoWindow");        
        saveproc();
        wnd.refresh();        
    }); 

    $("#buttonsavetype").kendoButton();
    var buttontype = $("#buttonsavetype").data("kendoButton");

    buttontype.bind("click", function (e) {
        var wnd_type = $("#wnd_type_info").data("kendoWindow");
        saveTypeproc("add");
    });

    function doNum() {
        if (controlKey(event)) return true;
        var digit = ((event.keyCode > 95 && event.keyCode < 106)
        || (event.keyCode > 47 && event.keyCode < 58));
        if ((event.keyCode > 8) && !digit) return false;
        else return true;
    }

    $("#TYPEINFO_TYPE_ID").kendoNumericTextBox({
        width: "100px",
        maxlength: "5",
        readonly: false,
        spinners: false,
        format: "d"
    });
    $("#TYPEINFO_TYPE_NAME").kendoMaskedTextBox({
        style: { width: "550px", maxlength: "50" }
    });
    $("#TYPEINFO_TYPE_CODE").kendoMaskedTextBox({
        style: { width: "550px", maxlength: "5" },
        mask: "&&&&",
        readonly:true
    });
    $("#TYPEINFO_SORT_ORD").kendoNumericTextBox({
        width: "100px",
        maxlength: "5",
        readonly: false,
        spinners: true,
        format: "d",
        min: 0,
        max: 1000,
        step: 1
    });
    var FL_DEMANDdataSource = new kendo.data.DataSource({
        data: [
          { ID: 1, NAME: "До запитання" },
          { ID: 0, NAME: "Строковий" }
        ]
    });
    $("#TYPEINFO_FL_DEMAND").kendoDropDownList({
        dataTextField: "NAME",
        dataValueField: "ID",
        dataSource: FL_DEMANDdataSource
    });
    var FL_WEBBANKINGdataSource = new kendo.data.DataSource({
        data: [
          { ID: 1, NAME: "Використовується" },
          { ID: 0, NAME: "Не використовується" }
        ]
    });
    $("#TYPEINFO_FL_WEBBANKING").kendoDropDownList({
        dataTextField: "NAME",
        dataValueField: "ID",
        dataSource: FL_WEBBANKINGdataSource
    });
    var FL_ACTIVEdataSource = new kendo.data.DataSource({
        data: [
          { ID: 0, NAME: "Не використовується" },
          { ID: 1, NAME: "Активний" }
        ]
    });
    $("#TYPEINFO_FL_ACTIVE").kendoDropDownList({
        dataTextField: "NAME",
        dataValueField: "ID",
        dataSource: FL_ACTIVEdataSource
    });


    $("#VIDD").kendoNumericTextBox({
        width: "100px",
        maxlength: "5",
        readonly: false,
        spinners: false,
        format: "s"
    });
    $("#LIMIT").kendoNumericTextBox({
        spinners: true,
        min: 0,
        format: "n",
        width: "50px"
    });
    $("#months").kendoNumericTextBox({
        spinners: true,
        min: 0,
        format: "n",
        style: { width: "50px" }
    });
    $("#days").kendoNumericTextBox({
        spinners: true,
        min: 0,
        max: 31,
        format: "n",
        style: { width: "50px" }
    });
    $("#months_max").kendoNumericTextBox({
        spinners: true,
        min: 0,
        format: "n",
        style: { width: "50px" }
    });
    $("#days_max").kendoNumericTextBox({
        spinners: true,
        min: 0, max: 31,
        format: "n",
        style: { width: "50px" }
    });
    $("#TYPE_NAME").kendoMaskedTextBox({
        style: { width: "550px", maxlength: "50" }
    });


    upPriority = function (id) { ShiftPriority(id, -1); };
    downPriority = function (id) { ShiftPriority(id, 1); }
    ShiftPriority = function (id, direction) {
        $.ajax({
            type: "POST",
            url: bars.config.urlContent('/DptAdm/DptAdm/ShiftPriority'),
            data: { TYPE_ID: id, direction: direction },
            success: function (data) {
                if (data.error) {
                    bars.utils.sto.showModalWindow(data.error);
                } else {
                    $('#grid_dpt_types').data("kendoGrid").dataSource.read();
                }
            }
        });
    }

    activateType = function (type_id) {
        if (confirm('Змінити статус типу договору ' + type_id + '?')) {
            $.ajax({
                type: "POST",
                url: bars.config.urlContent('/DptAdm/DptAdm/ActivateType'),
                data: { TYPE_ID: type_id },
                success: function (data) {
                    if (data.error) {
                        bars.utils.sto.showModalWindow(data.error);
                    } else {
                        $('#grid_dpt_types').data("kendoGrid").dataSource.read();
                    }
                }
            });
        }
    }
    setWBType = function (type_id) {
        if (confirm('Змінити статус WB типу договору ' + type_id + '?')) {
            $.ajax({
                type: "POST",
                url: bars.config.urlContent('/DptAdm/DptAdm/setWBType'),
                data: { TYPE_ID: type_id },
                success: function (data) {
                    if (data.error) {
                        bars.utils.sto.showModalWindow(data.error);
                    } else {
                        $('#grid_dpt_types').data("kendoGrid").dataSource.read();
                    }
                }
            });
        }
    }
    activateVidd = function (vidd) {
        $.ajax({
            type: "POST",
            url: bars.config.urlContent('/DptAdm/DptAdm/ActivateVidd'),
            data: { Vidd: vidd },
            success: function (data) {
                if (data.error) {
                    bars.utils.sto.showModalWindow(data.error);
                } else {
                    $('#grid_dpt_vidd').data("kendoGrid").dataSource.read();
                }
            }
        });
    }
    prepareTypeDialog = function (mode) {
        clearFields();
        var wnd_type = $("#wnd_type_info").data("kendoWindow");
        var grid = $("#grid_dpt_types").data("kendoGrid");
        var currentRowData = null;
        var titlestr;
        var NextTypeId = 0;
        var TYPE_IDtextbox = $("#TYPEINFO_TYPE_ID").data("kendoNumericTextBox");
        if (mode === "add") {
            workmode(true);
            titlestr = "Тип вкладу [Додавання нового]";
            clearTypeFields();           
            $.get(bars.config.urlContent('/DptAdm/DptAdm/GetNextTypeId')).done(function (result) {
                if (result.status == "ok") {
                    NextTypeId = result.data;
                    TYPE_IDtextbox.value(NextTypeId);        
                }
            });
            wnd_type.title(titlestr);
            wnd_type.center().open();
        } else {
            if (grid.select().length > 0) {
                TYPE_IDtextbox.enable(false);
                currentRowData = grid.dataItem(grid.select());                                
                $.get(bars.config.urlContent('/DptAdm/DptAdm/GetDptTypeInfo'), { TYPE_ID: currentRowData.TYPE_ID }).done(function (result) {
                    if (result.status == "ok") {
                        if (mode === "edit") {
                            //debugger;
                            workmode(true);
                            titlestr = "Редагування типу вкладу " + currentRowData.TYPE_NAME;
                            populateType(result, 0);                            
                        }
                        else if (mode === "view") {
                            workmode(false);
                            titlestr = "Перегляд типу вкладу " + currentRowData.TYPE_NAME;
                            populateType(result, 0);
                        }
                        else if (mode === "clon") {
                            workmode(true);
                            titlestr = "Копіювання лінійки типу " + currentRowData.TYPE_NAME;
                            populateType(result, 1);
                        }
                        wnd_type.title(titlestr);
                        wnd_type.center().open();
                    }
                });
            }
            else { bars.ui.error({ text: "Не обрано вид депозиту!" }); }
        }
    }

    
    prepareTypeDocDialog = function (TYPE_ID) {       
        var GetTypeDOCdataSource = new kendo.data.DataSource({
            type: "aspnetmvc-ajax",
            transport: {
                read: {
                    dataType: 'json',
                    url: bars.config.urlContent('/DptAdm/DptAdm/GetDptTypeDocs?TYPE_ID=' + TYPE_ID)
                },
                parameterMap: function (options, operation) {
                    if (operation !== "read" && options.models) {
                        return { models: kendo.stringify(options.models) };
                    }
                }
            }, batch: true,
            schema: {
                data: "data",
                model: {
                    fields: {
                        Active: { editable: false },
                        FLG: { editable: false },
                        NAME: { editable: false },
                        DOC: { editable: true },
                        DOC_FR: { editable: true }
                    }
                }
            }
        });

        // грид шаблонов вида
        var grid_vidd_doc = $('#grid_type_doc').kendoGrid({
            autobind: true,
            title:"Підв'язка шаблонів друкованих форм",
            selectable: "row",
            scrolable: true,
            sortable: true, 
            autoSync: true,
            dataSource: GetTypeDOCdataSource,
            columns: [
            {
                field: "FLG",
                title: "КОД",
                width: "5%",
                attributes: { "class": "table-cell", style: "enabled: false; text-align: center; font-size: 12px" }
            }, {
                field: "NAME", editable: false,
                title: "Тип договору (додаткової угоди)",
                width: "30%",
                attributes: { "class": "table-cell", style: "enabled: false; text-align: left; font-size: 12px" },
                editor: {}
            }, {
                field: "DOC",
                title: "Шаблон",
                width: "20%",
                attributes: { "class": "table-cell", style: "text-align: left; font-size: 12px" },
                editor: DOCDropDownEditor
            },
            {
                field: "DOC_FR",
                title: "Шаблон FRX",
                width: "20%",
                attributes: { "class": "table-cell", style: "text-align: left; font-size: 12px" },
                editor: DOC_FRDropDownEditor
            },
             { command: "edit" },
             { template: '<a class="k-button" enabled href="\\#" onclick="return clearDoc2Type(#=FLG#)">Відв"язати</a>' }
            ],
            filterable: true,
            editable: "popup",
            save: function (e) {                
                if (e.model.DOC != " " && e.model.DOC_FR != " ") {
                    setDoc2Type(TYPE_ID, e.model.FLG, e.model.DOC, e.model.DOC_FR);
                }
                else if (e.model.DOC != " " && e.model.DOC_FR == " ") {
                    setDoc2Type(TYPE_ID, e.model.FLG, e.model.DOC, null);
                }
                else if (e.model.DOC == " " && e.model.DOC_FR != " ") {
                    setDoc2Type(TYPE_ID, e.model.FLG, null, e.model.DOC_FR);
                }
                else { bars.ui.alert({ text: "Зміни не внесено!" }); }
                GetTypeDOCdataSource.read();
                return false;
            }            
        });

        setDoc2Type = function (type, flg, doc, doc_fr) {            
            $.ajax({
                type: "POST",
                url: bars.config.urlContent('/DptAdm/DptAdm/AddDoc2Type'),
                data: { TYPE_ID: type, FLG: flg, DOC: doc, DOC_FR: doc_fr },
                success: function (data) {
                    if (data.error) {
                        bars.ui.err({ text: 'Шаблон до типу не збережено! Помилка даних' });
                    } else {
                        bars.ui.alert({ text: 'Шаблон до типу збережено!' });
                    }
                    $('#grid_type_doc').data('kendoGrid').dataSource.read();
                    $('#grid_type_doc').data('kendoGrid').refresh();
                }
            });
        }

        clearDoc2Type = function (FLG) {
            var gridtype = $('#grid_dpt_types').data('kendoGrid');
            var currentRow = gridtype.dataItem(gridtype.select());
            $.ajax({
                type: "POST",
                url: bars.config.urlContent('/DptAdm/DptAdm/ClearDoc2Type'),
                data: { TYPE_ID: currentRow.TYPE_ID, FLG: FLG },
                success: function (data) {
                    if (data.error) {
                        bars.ui.error({ text: 'Не збережено! Помилка даних' });
                    } else {
                        bars.ui.alert({ text: 'Шаблон відвязаний!' });
                    }
                    $('#grid_type_doc').data('kendoGrid').dataSource.read();
                    $('#grid_type_doc').data('kendoGrid').refresh();
                }
            });
        }      
    }
    prepareDOCTypeDialog = function () {
        var wnd_vidd = $("#wnd_type_info").data("kendoWindow");
        var wnd_typedoc = $("#wnd_typedoc").data("kendoWindow");
        var grid = $("#grid_dpt_types").data("kendoGrid");
        var currentTypeData = null;
        var titlestr;
        if (grid.select().length > 0) {
            currentTypeData = grid.dataItem(grid.select());
            titlestr = "Перегляд переліку шаблонів типу вкладу " + currentTypeData.TYPE_NAME;            
            prepareTypeDocDialog(currentTypeData.TYPE_ID);           
            wnd_typedoc.title(titlestr);
            wnd_typedoc.center().open();
        }
        else { bars.ui.alert({ text: "Не обрано вид депозиту!" }); }
    }
    getbaserate = function (br_id, kv, type) {
        if (br_id != undefined && br_id != null && kv != null && kv != undefined) {
            $.ajax({
                type: "POST",
                url: bars.config.urlContent('/DptAdm/DptAdm/GetRate'),
                data: { br_id: br_id, kv: kv },
                success: function (data) {
                 //  debugger;
                    if (data.error) {
                        bars.utils.sto.showModalWindow(data.error);
                    } else {                        
                        if (type == 1) {
                            $('#PROC').val(data.data);
                            if (data.data == null || data.data == undefined)
                                $('#buttonTierBrate')[0].disabled = false;
                            else
                                $('#buttonTierBrate')[0].disabled = true;
                        }
                        else
                            $('#partval').val(data.data);
                        
                    }
                }
            });     
        }
    }
    getbaseratedate = function (br_id, kv, type) {
        if (br_id != undefined && br_id != null && kv != null && kv != undefined) {
            $.ajax({
                type: "POST",
                url: bars.config.urlContent('/DptAdm/DptAdm/GetRateDate'),
                data: { br_id: br_id, kv: kv },
                success: function (data) {
                    if (data.error) {
                        bars.utils.sto.showModalWindow(data.error);
                    } else {
                        if (type == 1)
                            $('#DAT_BRAT').val(data.data);
                        else
                            $('#partdate').val(data.data);
                    }
                }
            });
        }
    }    
    var int_fix = $('#int_fix');

   
    preparegridtier = function () {
        var t_br_id = $("#intr").val();
        var t_kv = $("#val_kv").val();

        var dpt_brtier_model = kendo.data.Model.define({
            id: dpt_brtier_model,
            fields: {
                BDATE: { type: "string" },
                LCV: { type: "string" },
                S: { type: "string" },
                RATE: { type: "number" }
            }
        });

        var grid_br_tier = $('#grid_br_tier').kendoGrid({
            autobind: false,
            selectable: "row",
            scrolable: true,            
            columns: [
                {
                    field: "BDATE",
                    title: "Дата",
                    width: "15%",
                    attributes: { "class": "table-cell", style: "text-align: center; font-size: 12px" }
                },
                {
                    field: "LCV",
                    title: "Валюта",
                    width: "15%",
                    attributes: { "class": "table-cell", style: "text-align: center; font-size: 12px" }
                },
                {
                    field: "S",
                    title: "Сума",
                    width: "25%",
                    attributes: { "class": "table-cell", style: "text-align: right; font-size: 12px" }
                },
                {
                    field: "RATE",
                    title: "Ставка",
                    width: "15%",
                    attributes: { "class": "table-cell", style: "text-align: left; font-size: 12px" }
                }
            ],
            dataSource: {
                type: "aspnetmvc-ajax",
                transport: {
                    read: {
                        dataType: 'json',
                        url: bars.config.urlContent('/DptAdm/DptAdm/GetDpBrTier'),
                        data: { br_id: t_br_id, kv: t_kv }
                    }
                },
                schema: {
                    data: "data",
                    model: dpt_brtier_model
                }
            }
        });
        $('#grid_br_tier').data('kendoGrid').dataSource.read();
        return true;
    }
    var btntire = $("#buttonTierBrate").kendoButton();
    btntire.bind("click", function () {
        var wnd = $("#wnd_bratestier").data("kendoWindow");
        //debugger;
        preparegridtier();        
        wnd.center().open();        
    });
});
