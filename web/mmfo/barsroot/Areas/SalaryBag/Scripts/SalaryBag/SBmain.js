///*** GLOBALS
var pageInitalCount = 15;
var gridSelector = "#SalaryBagMainGrid";
var formOptions = {
    // 0 - deal bag (front office)
    // 3 - deal bag (back office)
    // 1 - deals that are on back office approval
    // 2 - archive deals
    _fType: 0,
    getFilter: function () {
        switch (+this._fType) {
            case 0: return [0, 1, 2, 3, 4, 5, 6, 7];
            case 1: return [1, 3, 6];
            case 2: return [-1];
            default: return [0, 1, 2, 3, 4, 5, 6, 7];
        }
    },
    getFormType: function () {
        return this._fType;
    },
    setFormType: function (value) {
        if (isNaN(value) || +value > 3 || +value < 0)
            this._fType = 0;
        else
            this._fType = +value;
    },
    getTitle: function () {
        switch (+this._fType) {
            case 0: return 'Портфель Зарплатних проектів (фронт-офіс)';
            case 3: return 'Портфель Зарплатних проектів (бек-офіс)';
            case 1: return 'Угоди на візуванні';
            case 2: return 'Архів угод ЗП';
            default: return 'Портфель Зарплатних проектів';
        }
    },
    getFilterDs: function () {
        switch (+this._fType) {
            case 3:
            case 0: return [
                { value: 0, text: 'Новий' },
                { value: 1, text: 'Очікує підтвердження БО' },
                { value: 2, text: 'Відхилений БО' },
                { value: 3, text: 'Очікує підтвердження внесених змін БО' },
                { value: 4, text: 'Внесені зміни відхилені БО' },
                { value: 5, text: 'Діючий' },
                { value: 6, text: 'Очікує підтвердження закриття БО' },
                { value: 7, text: 'Закриття відхилене БО' }
            ];
            case 1: return [
                { value: 1, text: 'Очікує підтвердження БО' },
                { value: 3, text: 'Очікує підтвердження внесених змін БО' },
                { value: 6, text: 'Очікує підтвердження закриття БО' }
            ];
                break;
            default: return [];
        }
    },
    _toolbox: '',
    getToolBoxTemplate: function () {
        switch (+this._fType) {
            case 0:
                this._toolbox = '   <div class="row" style="margin-bottom:0px;margin-left:10px;">'
                    + '                 <div class="row" style="margin-bottom:5px;">'
                    + '                     <div class="col-md-8 btn-group">'
                    + '                         <a class="btn custom-btn custom-btn-add" title="Введення нового зарплатного договору"></a>'
                    + '                         <a class="btn custom-btn custom-btn-delete" title="Видалення договору"></a>'
                    + '                         <a class="btn custom-btn custom-btn-print" title="Формування шаблонів"></a>'
                    + '                         <a class="btn custom-btn custom-btn-client-card" title="Картка клієнта ЮО"></a>'
                    + '                         <a class="btn custom-btn custom-btn-goto-way4" title="Way4.Портфель БПК"></a>'
                    + '                         <a class="btn custom-btn custom-btn-edit" title="Редагувати обраний договір"></a>'
                    + '                         <a class="btn custom-btn custom-btn-submit" title="Підтвердження договору менеджером (ФО, БПК, ДРБ) для передачі його на візування відповідальним працівником БО.&#013;Відправка діючого договору на візування БО."></a>'
                    + '                         <a class="btn custom-btn custom-btn-close" title="Закриття договору"></a>'
                    + '                         <a class="btn custom-btn custom-btn-view" title="Перегляд договору"></a>'

                    + '                         <a class="btn custom-btn custom-btn-2625" title="Рахунки 2625"></a>'

                    + '                         <div class="dropdown">'
                    + '                             <a class="btn custom-btn custom-btn-history dropbtn" title="Перегляд історії"></a>'
                    + '                             <div class="dropdown-content">'
                    + '                                  <a class="btn custom-btn custom-btn-payroll-history" title="Перегляд історії платежів">Історія платежів</a>'
                    + '                                  <a class="btn custom-btn custom-btn-edit-history" title="Перегляд історії редагування договору">Історія редагування</a>'
                    + '                             </div>'
                    + '                         </div>'
                    + '                         <div class="dropdown">'
                    + '                             <a class="btn custom-btn custom-btn-watch-archive dropbtn" title="Робота з електронним архівом"></a>'
                    + '                             <div class="dropdown-content">'
                    + '                                  <a class="btn custom-btn custom-btn-ea-view" title="Перегляд докуменітв у ЕА">Перегляд</a>'
                    //+ '                                  <a class="btn custom-btn custom-btn-ea-before-scan" title="Сканування документів та збереження їх у ЕА">Сканування</a>'
                    + '                             </div>'
                    + '                         </div>'

                    + '                     </div>'
                    + '                         <div class="col-md-2"></div>' // it is very interesting offset :)
                    + '                         <div class="col-md-2 btn-group">'
                    + '                         <div class="colored-box white-tr" title="Новий"></div>'
                    + '                         <div class="colored-box green-tr" title="Діючий"></div>'
                    + '                         <div class="colored-box yellow-tr" title="Очікує підтвердження БО&#013;Очікує підтвердження внесених змін БО"></div>'
                    + '                         <div class="colored-box red-tr" title="Відхилений БО&#013;Внесені зміни відхилені БО&#013;Закриття відхилене БО"></div>'
                    + '                     </div>'
                    + '                 </div>'

                    + '                 <table>'
                    + '                     <tr>'
                    + '                         <td><a id="filterBox"/></td>'
                    + '                         <td><a id="btnClearFilter" disabled class="btn btn-primary custom-btn custom-btn-clear-filter" title="Очистити фільтр"></a></td>'
                    + '                     </tr>'
                    + '                 </table>'
                    + '             </div>';
                return this._toolbox;
            case 3:
                this._toolbox = '<div class="row" style="margin-bottom:0px;margin-left:10px;">'
                    + '<div class="row" style="margin-bottom:5px;">'
                    + '<div class="col-md-8 btn-group">'
                    + '<a class="btn custom-btn custom-btn-print" title="Формування шаблонів"></a>'
                    + '<a class="btn custom-btn custom-btn-client-card" title="Картка клієнта ЮО"></a>'
                    + '<a class="btn custom-btn custom-btn-goto-way4" title="Way4.Портфель БПК"></a>'
                    + '<a class="btn custom-btn custom-btn-view" title="Перегляд договору"></a>'

                    + '<div class="dropdown">'
                    + '    <a class="btn custom-btn custom-btn-history dropbtn" title="Перегляд історії"></a>'
                    + '    <div class="dropdown-content">'
                    + '         <a class="btn custom-btn custom-btn-payroll-history" title="Перегляд історії платежів">Історія платежів</a>'
                    + '         <a class="btn custom-btn custom-btn-edit-history" title="Перегляд історії редагування договору">Історія редагування</a>'
                    + '    </div>'
                    + '</div>'

                    + '<a class="btn custom-btn custom-btn-3570" title="Погашення деб.заборгованості 3570">Погашення 3570</a>'
                    + '<a class="btn custom-btn custom-btn-ea-view custom-btn-separated-watch-archive" title="Перегляд документів в ЕА"></a>'

                    + '</div>'
                    + '<div class="col-md-2"></div>' // it is very interesting offset :)
                    + '<div class="col-md-2 btn-group">'
                    + '<div class="colored-box white-tr" title="Новий"></div>'
                    + '<div class="colored-box green-tr" title="Діючий"></div>'
                    + '<div class="colored-box yellow-tr" title="Очікує підтвердження БО&#013;Очікує підтвердження внесених змін БО"></div>'
                    + '<div class="colored-box red-tr" title="Відхилений БО&#013;Внесені зміни відхилені БО&#013;Закриття відхилене БО"></div>'
                    + '</div>'
                    + '</div>'

                    + '<table>'
                    + '<tr>'
                    + '<td><a id="filterBox"/></td>'
                    + '<td><a id="btnClearFilter" disabled class="btn btn-primary custom-btn custom-btn-clear-filter" title="Очистити фільтр"></a></td>'
                    + '</tr>'
                    + '</table>'
                    + '</div>';
                return this._toolbox;
            case 1:
                this._toolbox = '<div class="row" style="margin-bottom:0px;margin-left:10px;">'
                    + '<div class="btn-group">'
                    + '<a class="btn custom-btn custom-btn-visa" title="Авторизувати&#013;Підтвердити"></a>'
                    + '<a class="btn custom-btn custom-btn-reject" title="Відхилити"></a>'
                    + '<a class="btn custom-btn custom-btn-view" title="Перегляд договору"></a>'
                    + '<a class="btn custom-btn custom-btn-ea-view custom-btn-separated-watch-archive" title="Перегляд документів в ЕА"></a>'
                    + '</div>'
                    + '<hr style="margin:5px;"/>'
                    + '<table>'
                    + '<tr>'
                    + '<td><a id="filterBox"/></td>'
                    + '<td><a id="btnClearFilter" disabled class="btn custom-btn custom-btn-clear-filter" title="Очистити фільтр"></a></td>'
                    + '</tr>'
                    + '</table>'
                    + '</div>';
                return this._toolbox;
            case 2:
                this._toolbox = '<div class="btn-group">'
                    + '<a class="btn custom-btn custom-btn-view" title="Перегляд договору"></a>'
                    + '<a class="btn custom-btn custom-btn-ea-view custom-btn-separated-watch-archive" title="Перегляд документів в ЕА"></a>'
                    + '</div>';
                return this._toolbox;
        }
    }
};
///***
function updateMainGrid() {
    var grid = $(gridSelector).data("kendoGrid");
    if (grid) {
        grid.dataSource.read();
        grid.refresh();
    }
}

function initMainGrid() {
    var selectFilter = {};

    var dataSourceObj = {
        type: "webapi",
        requestEnd: function () {
            bars.ui.loader('body', false);
        },
        transport: {
            read: {
                type: "POST",
                url: bars.config.urlContent("/api/SalaryBag/SalaryBag/SearchMain"),
                data: {
                    sos: formOptions.getFilter()
                },
                dataType: "json"
            }
        },
        pageSize: pageInitalCount,
        schema: {
            data: "Data",
            total: "Total",
            model: {
                fields: {
                    id: { type: 'number' },
                    deal_id: { type: 'string' },
                    start_date: { type: 'date' },
                    close_date: { type: 'date' },
                    rnk: { type: 'number' },
                    nmk: { type: 'string' },
                    deal_name: { type: 'string' },
                    fs_name: { type: 'string' },
                    fs: { type: "number" },
                    sos: { type: 'number' },
                    sos_name: { type: 'string' },
                    deal_premium: { type: 'number' },
                    central: { type: 'number' },
                    nls_2909: { type: 'string' },
                    ostc_2909: { type: 'number' },
                    nls_3570: { type: 'string' },
                    ostc_3570: { type: 'number' },
                    branch: { type: 'string' },
                    fio: { type: 'string' },
                    corp2: { type: 'string' },
                    kod_tarif: { type: 'number' },
                    tarif_name: { type: 'string' },
                    tar: { type: 'number' },
                    max_tarif: { type: 'string' },
                    ind_acc_tarif: { type: 'string' },
                    comm_reject: { type: 'string' },
                    tip: { type: "number" },
                    okpo: { type: "string" },
                    acc_2909: { type: "number" },
                    acc_3570: { type: "number" }
                }
            }
        },
        sort: ([
            {
                field: "start_date", dir: "desc"
            }
        ])
    };

    var mainGridDataSource = new kendo.data.DataSource(dataSourceObj);

    var mainGridOptions = {
        dataSource: mainGridDataSource,
        pageable: {
            refresh: true,
            messages: {
                empty: "Дані відсутні",
                allPages: "Всі"
            },
            pageSizes: [pageInitalCount, 25, 50, 200, 1000, "All"],
            buttonCount: 5
        },
        reorderable: false,
        resizable: true,
        sortable: {
            mode: "single",
            allowUnsort: true
        },
        columns: [
            //{ field: "id", title: "ID договору", width: "90px" },
            { field: "deal_id", title: "Номер договору", width: "140px" },
            { field: "start_date", title: "Дата відкриття", width: "125px", template: "<div style='text-align:center;'>#=(start_date == null) ? ' ' : kendo.toString(start_date,'dd.MM.yyyy')#</div>" },
            { field: "close_date", title: "Дата закриття", width: "125px", template: "<div style='text-align:center;'>#=(close_date == null) ? ' ' : kendo.toString(close_date,'dd.MM.yyyy')#</div>", hidden: !(formOptions.getFormType() == 2) },
            {
                field: "rnk", title: "РНК", width: "80px", filterable: {
                    ui: function (element) {
                        element.kendoNumericTextBox({
                            format: "#"
                        });
                    }
                }
            },
            { field: "okpo", title: "ЄДРПОУ", width: "100px" },
            { field: "nmk", title: "Назва ЮО", width: "150px" },
            { field: "deal_name", title: "Назва договору", width: "150px" },
            { field: "fs_name", title: "Тип організації", width: "140px" },
            //{ field: "sos", title: "Код стану", width: "100px" },
            { field: "sos_name", title: "Стан договору", width: "170px" },
            { field: "deal_premium", title: "Преміальний", width: "100px", template: "<div style='text-align:center;'>#=(deal_premium == null || deal_premium == 0) ? 'ні' : 'так'#</div>", filterable: false },
            { field: "central", title: "Централізований договір", width: "125px", template: "<div style='text-align:center;'>#=(central == null || central == 0) ? 'ні' : 'так'#</div>", filterable: false },
            {
                field: "nls_2909",
                title: "Рахунок 2909",
                width: "120px",
                template: +formOptions.getFormType() === 2 ? '#=nls_2909#' : '<a title="Перехід до параметрів рахунку #=nls_2909#" href="/barsroot/viewaccounts/accountform.aspx?type=2&acc=#= acc_2909 #&rnk=&accessmode=1" onclick="runLoader()">#=nls_2909#</a>'
            },
            {
                field: "ostc_2909", title: "Залишок на 2909, &#8372;", width: "110px", template: '<div style="text-align:right;">#= convertToMoneyStr(ostc_2909) #</div>',
                sortable: {
                    compare: function (a, b) {
                        return a.ostc_2909 - b.ostc_2909;
                    }
                }
            },
            { field: "nls_3570", title: "Рахунок 3570", width: "120px" },
            {
                field: "ostc_3570", title: "Залишок на 3570, &#8372;", width: "110px", template: '<div style="text-align:right;#= +ostc_3570 < 0 ? "color:red;" : "" #">#= convertToMoneyStr(ostc_3570) #</div>',
                sortable: {
                    compare: function (a, b) {
                        return a.ostc_3570 - b.ostc_3570;
                    }
                }
            },
            { field: "branch", title: "Відділення", width: "120px" },
            { field: "fio", title: "Менеджер", width: "120px" },
            { field: "corp2", title: "Клієнт-банк(Корп2)", width: "110px", filterable: false },
            { field: "kod_tarif", title: "Код тарифу", width: "110px" },
            { field: "tarif_name", title: "Назва тарифу", width: "250px" },
            { field: "tar", title: "Тариф (грн)", width: "110px", template: '<div style="text-align:right;">#= convertToMoneyStr(tar) #</div>' },
            { field: "max_tarif", title: "Тариф (%)", width: "125px", template: '<div style="text-align:right;">#= max_tarif #</div>' },
            { field: "ind_acc_tarif", title: "Індивід. тариф", width: "110px", template: '<div style="text-align:#= (ind_acc_tarif == null || ind_acc_tarif <= 0) ? "center" : "right" #;">#= (ind_acc_tarif == null || ind_acc_tarif <= 0) ? "-" : ind_acc_tarif #</div>' },
            { field: "comm_reject", title: "Коментар", width: "400px" }
        ],
        selectable: "row",
        editable: false,
        scrollable: true,
        filterable: true,
        noRecords: {
            template: '<hr class="modal-hr"/><b>На жаль нічого не знайдено ;(</b><hr class="modal-hr"/>'
        },
        dataBound: function () {
            $(".custom-btn:not(#btnClearFilter)").removeAttr('disabled');

            if (formOptions.getFormType() != 0 && formOptions.getFormType() != 3) return;
            var mainGrid = $(gridSelector).data("kendoGrid");
            var trInTbodyArr = $(gridSelector).find("tr");
            if (trInTbodyArr.length <= 1) return;

            for (var i = 0; i < trInTbodyArr.length; i++) {
                var sos = +mainGrid.dataItem(trInTbodyArr[i]).sos;
                switch (sos) {
                    case 5:
                        $(trInTbodyArr[i]).addClass('green-tr');
                        break;
                    case 1:
                    case 3:
                    case 6:
                        $(trInTbodyArr[i]).addClass('yellow-tr');
                        break;
                    case 2:
                    case 4:
                    case 7:
                        $(trInTbodyArr[i]).addClass('red-tr');
                        break;
                    default:
                        $(trInTbodyArr[i]).addClass('white-tr');
                }
            }
        },
        change: function () {
            // -2 : Видалений
            // -1 : Закритий           
            //  0 : Новий            
            //  1 : Очікує підтвердження БО
            //  2 : Відхилений БО
            //  3 : Очікує підтвердження внесених змін БО
            //  4 : Внесені зміни відхилені БО
            //  5 : Діючий
            //  6 : Очікує підтвердження закриття БО
            //  7 : Закриття відхилене БО

            var data = this.dataItem(this.select());
            var sos = +data.sos;
            var ost3570 = +data.ostc_3570;

            var isMirgated = data.fs == null || data.kod_tarif == null;

            enableElem('.custom-btn-3570', ost3570 < 0 && sos >= 3);
            if (formOptions.getFormType() !== 0) return;

            enableElem('.custom-btn-delete', sos == 0);

            //enableElem('.custom-btn-edit', sos == 0 || sos == 2 || sos == 4 || sos == 5 || sos == 7);
            enableElem('.custom-btn-edit', sos == 0 || sos == 2 || sos == 4 || sos == 5);

            enableElem('.custom-btn-submit', (sos == 0 || sos == 2 || sos == 4 || sos == 5 || sos == 7) && !isMirgated);

            enableElem('.custom-btn-close', sos == 5);

            enableElem('.custom-btn-2625', sos == 5);

            enableElem('.custom-btn-3570', ost3570 < 0 && sos >= 3);
        }
    };

    $(gridSelector).kendoGrid(mainGridOptions);

    selectFilter = $("#filterBox").kendoMultiSelect({
        dataTextField: "text",
        dataValueField: "value",
        dataSource: formOptions.getFilterDs(),
        //placeholder: "   Фільтр по стану договору",
        placeholder: "Натисніть для фільтрування по стану договору",
        autoClose: false,
        autoWidth: true,
        height: "auto",
        tagMode: "single",
        highlightFirst: false,
        tagTemplate: kendo.template($("#filterSelectedTag").html()),
        //tagTemplate: '<span class="selected-value" title="#:data.text#">#:data.text.substring(0, 7)+"..."#</span>',
        itemTemplate: '<input type="checkbox"/><label class="k-state-default" style="margin-left:5px;">#: data.text #</label>',
        change: function () {
            $(".custom-btn-edit, .custom-btn-delete").removeAttr('disabled');

            var items = this.ul.find("li");
            checkInputs(items);

            var values = this.value();

            if (values === undefined || values == null || values == [] || $.trim(values) == "") {
                $("#btnClearFilter").attr('disabled', 'disabled');
            } else {
                $("#btnClearFilter").removeAttr("disabled");
            }

            var filter = { logic: "or", filters: [] };
            $.each(values, function (i, v) {
                filter.filters.push({ field: "sos", operator: "eq", value: +v });
            });
            mainGridDataSource.filter(filter);
            mainGridDataSource.read();
        },
        dataBound: function () {
            var items = this.ul.find("li");
            setTimeout(function () {
                checkInputs(items);
            });
        }
    }).data("kendoMultiSelect");

    var checkInputs = function (elements) {
        elements.each(function () {
            var element = $(this);
            var input = element.children("input");

            input.prop("checked", element.hasClass("k-state-selected"));
        });
    };

    $("#btnClearFilter").click(function () {
        selectFilter.value('');
        selectFilter._savedOld = undefined;
        mainGridDataSource.filter({});
        mainGridDataSource.read();

        selectFilter.trigger("change");

        $("#btnClearFilter").attr('disabled', 'disabled');
    });
};

function runLoader() {
    bars.ui.loader('body', true);
};

function addEventListenersToButtons() {
    $(".custom-btn-client-card").on("click", function () {
        var grid = $(gridSelector).data("kendoGrid");
        var selectedItem = grid.dataItem(grid.select());
        if (selectedItem == null || selectedItem == undefined) {
            bars.ui.alert({ text: "Не вибрано жодного рядка." });
            return;
        };
        goToClientCard(selectedItem.rnk);
    });

    $(".custom-btn-goto-way4").on("click", goToWay4);
    $(".custom-btn-submit").on("click", approveDeal);
    $(".custom-btn-delete").on("click", deleteDeal);

    $(".custom-btn-view").on("click", function () {
        var selectedItem = checkIfRowIsSelected();
        if (selectedItem == null) return;

        viewForm(selectedItem);
    });

    $(gridSelector).on("dblclick", "tr:not(:first)", function (event) {
        var mainGrid = $(gridSelector).data("kendoGrid");
        var row = $(this).closest("tr");

        var dataItem = mainGrid.dataItem(row);

        viewForm(dataItem);
    });

    $(".custom-btn-edit").on("click", function () {
        var selectedItem = checkIfRowIsSelected();
        if (selectedItem == null) return;

        addEditForm("edit", selectedItem);
    });

    $('.custom-btn-payroll-history').on('click', function () {
        var selectedItem = checkIfRowIsSelected();
        if (selectedItem == null) return;

        historyForm(selectedItem.id, null, true);
    });

    $(".custom-btn-add").on("click", function () {
        addEditForm("add");
    });

    $(".custom-btn-visa").on("click", authorizeDeal);

    $(".custom-btn-reject").on("click", function () {
        var selectedItem = checkIfRowIsSelected();
        if (selectedItem == null) return;

        eacForm({
            title: "Відхилення договору",
            okFunc: function (data) {
                rejectDeal(data.userData.id, data.reason, selectedItem.deal_name);
            },
            maxLength: 500,
            minLength: 5,
            customTemplate: messageTemplateForApproVeClose(selectedItem.deal_name, selectedItem.deal_id),
            additionalData: selectedItem
        });
    });

    $(".custom-btn-close").on('click', closeDeal);

    $(".custom-btn-2625").on('click', function () {
        var selectedItem = checkIfRowIsSelected();
        if (selectedItem == null) return;

        goToAcc2625(selectedItem.id, selectedItem.deal_name, selectedItem.deal_id);
    });

    $(".custom-btn-print").on('click', function () {
        var selectedItem = checkIfRowIsSelected();
        if (selectedItem == null) return;

        showDocsCreationForm(selectedItem);
    });

    $('.custom-btn-3570').on('click', pay3570);

    $('.custom-btn-ea-view').on('click', function () {
        var selectedItem = checkIfRowIsSelected();
        if (selectedItem == null) return;

        bars.ui.loader('body', true);

        showViewEADocsForm(selectedItem);
    });
    //$('.custom-btn-ea-before-scan').on('click', function () {
    //    var selectedItem = checkIfRowIsSelected();
    //    if (selectedItem == null) return;

    //    beforeScanForm(selectedItem);
    //});

    $('.custom-btn-edit-history').on('click', function () {
        var selectedItem = checkIfRowIsSelected();
        if (selectedItem == null) return;

        dealChangesHistoryForm(selectedItem.id, selectedItem.deal_id);
    });
};

var eaMenuObject = {
    toggleMenu: function () {
        var menuContent = $('#eaDropDownMenu');

        if (menuContent.css('display') == 'block')
            this.closeMenu();
        else
            this.openMenu();
    },
    openMenu: function () {
        $('#eaDropDownMenu').show(300);
        $('.custom-btn-watch-archive').addClass('menu-opened');
    },
    closeMenu: function () {
        $('#eaDropDownMenu').hide(300);
        $('.custom-btn-watch-archive').removeClass('menu-opened');
    }
};

function rejectDeal(id, comment, dealName) {
    bars.ui.loader('body', true);
    $.ajax({
        type: "POST",
        url: bars.config.urlContent("/api/SalaryBag/SalaryBag/RejectDeal"),
        data: {
            Id: +id,
            Comment: comment
        },
        success: function (data) {
            bars.ui.loader('body', false);
            if (data.Result != "OK") {
                showBarsErrorAlert(data.ErrorMsg);
            } else {
                bars.ui.alert({ text: 'Договір <b>"' + dealName + '"</b> відхилено.' });
                updateMainGrid();
            }
        }
    });
};

function authorizeDeal() {
    var selectedItem = checkIfRowIsSelected();
    if (selectedItem == null) return;

    var word = ' договір';

    switch (+selectedItem.sos) {
        case 3:
            word = ' внесені <u>зміни</u> в договір';
            break;
        case 6:
            word = ' <u>закриття</u> договору';
            break;
    }

    bars.ui.confirm({ text: 'Ви впевненні, що хочете підтвердити' + word + ' № <b>' + selectedItem.deal_id + '</b> ("<b>' + selectedItem.deal_name + '</b>") ?' }, function () {
        bars.ui.loader('body', true);
        $.ajax({
            type: "GET",
            url: bars.config.urlContent("/api/SalaryBag/SalaryBag/AuthorizeDeal"),
            data: {
                id: +selectedItem.id
            },
            success: function (data) {
                bars.ui.loader('body', false);
                if (data.Result != "OK") {
                    showBarsErrorAlert(data.ErrorMsg);
                } else {
                    bars.ui.alert({ text: 'Договір №<b>' + selectedItem.deal_id + '</b> "<b>' + selectedItem.deal_name + '</b>" підтверджено.' });
                    updateMainGrid();
                }
            }
        });
    });
};

function approveDeal() {
    var selectedItem = checkIfRowIsSelected();
    if (selectedItem == null) return;

    eacForm({
        title: selectedItem.sos == 5 ? "Відправка діючого договору на візування БО" : "Підтвердження договору",
        okFunc: function (data) {
            executeDealApproval(data.userData, data.reason);
        },
        customTemplate: messageTemplateForApproVeClose(selectedItem.deal_name, selectedItem.deal_id),
        additionalData: selectedItem
    });
};

function closeDeal() {
    var selectedItem = checkIfRowIsSelected();
    if (selectedItem == null) return;

    eacForm({
        title: "Закриття договору",
        okFunc: function (data) {
            executeCloseDeal(data.userData, data.reason);
        },
        customTemplate: messageTemplateForApproVeClose(selectedItem.deal_name, selectedItem.deal_id),
        additionalData: selectedItem
    });
};

function pay3570() {
    var selectedItem = checkIfRowIsSelected();
    if (selectedItem == null) return;

    bars.ui.confirm({ text: 'Ви впевненні, що хочете погасити заборгованість по 3570 для договору № <b>' + selectedItem.deal_id + '</b> ("<b>' + selectedItem.deal_name + '</b>") ?' }, function () {
        bars.ui.loader('body', true);
        $.ajax({
            type: "GET",
            url: bars.config.urlContent("/api/SalaryBag/SalaryBag/Pay3570"),
            data: {
                acc: selectedItem.acc_3570
            },
            success: function (data) {
                bars.ui.loader('body', false);
                if (data.Result != "OK") {
                    showBarsErrorAlert(data.ErrorMsg);
                } else {
                    bars.ui.alert({ text: 'Забргованість погашено.' });
                    updateMainGrid();
                }
            }
        });
    });
};

function messageTemplateForApproVeClose(name, id) {
    return '<div class="row">'
        + '<div class="col-md-12" style="margin:3px;">'
        + '<div class="row">'
        + '<div class="col-md-2">'
        + '<label class="k-label bold-lbl">Договір: </label>'
        + '</div>'
        + '</div>'
        + '<div class="row">'
        + '<div class="col-md-2">'
        + '<label class="k-label" style="padding-left:10px;">Назва: </label>'
        + '</div>'
        + '<div class="col-md-8">'
        + '<label class="k-label bold-lbl">' + name + '</label>'
        + '</div>'
        + '</div>'
        + '<div class="row">'
        + '<div class="col-md-2">'
        + '<label class="k-label" style="padding-left:10px;">№:</label>'
        + '</div>'
        + '<div class="col-md-8">'
        + '<label class="k-label bold-lbl">' + id + '</label>'
        + '</div>'
        + '</div>'
        + '</div>'
        + '<hr />'
        + '</div>'
}

function executeCloseDeal(selectedItem, reason) {
    bars.ui.loader('body', true);
    $.ajax({
        type: "GET",
        url: bars.config.urlContent("/api/SalaryBag/SalaryBag/CloseDeal"),
        data: {
            id: +selectedItem.id,
            comment: reason
        },
        success: function (data) {
            bars.ui.loader('body', false);
            if (data.Result != "OK") {
                showBarsErrorAlert(data.ErrorMsg);
            } else {
                bars.ui.alert({ text: 'Договір №<b>' + selectedItem.deal_id + '</b> "<b>' + selectedItem.deal_name + '</b>" подано на закриття.' });
                updateMainGrid();
            }
        }
    });
};

function executeDealApproval(selectedItem, reason) {
    bars.ui.loader('body', true);
    $.ajax({
        type: "GET",
        url: bars.config.urlContent("/api/SalaryBag/SalaryBag/ApproveDeal"),
        data: {
            id: +selectedItem.id,
            comment: reason,
            sos: +selectedItem.sos
        },
        success: function (data) {
            bars.ui.loader('body', false);
            if (data.Result != "OK") {
                showBarsErrorAlert(data.ErrorMsg);
            } else {
                bars.ui.alert({ text: 'Договір №<b>' + selectedItem.deal_id + '</b> "<b>' + selectedItem.deal_name + '</b>" ' + (selectedItem.sos == 5 ? 'відправлено на візування БО.' : 'успішно підтверджено.') });
                updateMainGrid();
            }
        }
    });
};

function deleteDeal() {
    var selectedItem = checkIfRowIsSelected();
    if (selectedItem == null) return;

    bars.ui.confirm({ text: 'Ви впевненні, що хочете видалити договір № <b>' + selectedItem.deal_id + '</b> ("<b>' + selectedItem.deal_name + '</b>") ?' }, function () {
        bars.ui.loader('body', true);
        $.ajax({
            type: "GET",
            url: bars.config.urlContent("/api/SalaryBag/SalaryBag/DeleteDeal"),
            data: {
                id: +selectedItem.id
            },
            success: function (data) {
                bars.ui.loader('body', false);
                if (data.Result != "OK") {
                    showBarsErrorAlert(data.ErrorMsg);
                } else {
                    bars.ui.alert({ text: 'Договір №<b>' + selectedItem.deal_id + '</b> "<b>' + selectedItem.deal_name + '</b>" видалено.' });
                    updateMainGrid();
                }
            }
        });
    });
};

function checkIfRowIsSelected() {
    var grid = $(gridSelector).data("kendoGrid");
    var selectedItem = grid.dataItem(grid.select());
    if (selectedItem == null || selectedItem === undefined) {
        bars.ui.alert({ text: "Не вибрано жодного рядка." });
        return null;
    };
    return selectedItem;
};

function goToClientCard(rnk) {
    goToSomewhere('/barsroot/clientregister/registration.aspx?readonly=0&rnk=' + rnk);
};
function goToWay4() {
    goToSomewhere('/barsroot/barsweb/dynform.aspx?form=bpkw4.frm.portfolio');
};
function goToAcc2625(id, name, number) {
    goToSomewhere('Acc2625?dealId=' + id + '&name=' + name + '&number=' + number);
};

function changeGridMaxHeight() {
    var a1 = $(".k-grid-content").height();
    var a2 = $(".k-grid-content").offset();
    var a3 = $(document).height();
    var a4 = a3 - a2.top;

    $(".k-grid-content").css("max-height", a4 * 0.9);
};

function htmlDecode(value) {
    return value.replace(/&lt;/g, "<").replace(/&gt;/g, ">");
};

$(document).ready(function () {
    bars.ui.loader('body', true);
    formOptions.setFormType(getUrlParameter("formType"));

    $('#toolbox').html(formOptions.getToolBoxTemplate());

    $("#title").html(formOptions.getTitle());

    initMainGrid();

    changeGridMaxHeight();
    addEventListenersToButtons();
});
