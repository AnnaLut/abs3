//предотвращаем дублирование запросов на получение данных виртуального грида
//подробности http://www.telerik.com/forums/grid-with-remote-virtual-scrolling-fires-mutiple-read-requests-when-scrolling-fast
kendo.ui.VirtualScrollable.fn.options.prefetch = false;
if (!('bars' in window)) window['bars'] = {};
bars.quality = bars.quality || {
    groups: [],
    subGroups: [],
    groupsMenuDs: [],
    qGroupsContainer: null,
    qGroupSign: [
        { text: "<", value: "lt" },
        { text: ">", value: "gt" },
        { text: "=", value: "eq" },
        { text: ">=", value: "gte" },
        { text: "<=", value: "lte" }
    ],
    isAdvisoryMode: true,
    custAdvisory: new kendo.data.DataSource({
        transport: {
            read: {
                url: bars.config.urlContent('/Cdm/Quality/GetCustAdvisoryList'),
                data: function () {
                    var self = bars.quality;
                    return {
                        rnk: self.currentRnk,
                        type: GetPersonType()
                    }
                },
                complete: function () {
                    bars.quality.allAttrGroups.read();
                    bars.ui.loader('body', false);
                }
            }
        }
    }),
    custAttributes: new kendo.data.DataSource({
        transport: {
            read: {
                url: bars.config.urlContent('/Cdm/Quality/GetCustAttributesList'),
                data: function () {
                    var self = bars.quality;
                    return {
                        rnk: self.currentRnk,
                        type: GetPersonType()
                    }
                },
                complete: function (data) {
                    kendo.bind($('#advSummaryInfo'), bars.quality);
                    kendo.bind($('#allAdvTypes'), bars.quality);
                    kendo.bind($('#cardQualityInfo'), bars.quality);


                    $("#attrTypesMenu").kendoMenu({
                        select: bars.quality.loadCustomerAttributes,
                        animation: { open: { effects: "fadeIn" } },
                        orientation: "vertical"
                    });
                    bars.quality.fillInputBuffer();
                    bars.quality.customerAttributesRender();
                }
            }
        }
    }),
    allAttrGroups: new kendo.data.DataSource({
        transport: {
            read: {
                url: bars.config.urlContent('/Cdm/Quality/GetAllAttrGroups'),
                complete: function (data) {
                    bars.quality.custAttributes.read();
                }
            }
        }
    }),
    attrGroups: function () {
        return bars.quality.allAttrGroups.data();
    },
    currentGroup: null,
    currentSub: null,
    getCurrentSubgroup: function () {
        var self = bars.quality;
        if (!self.currentSub || !self.subGroups) {
            return null;
        };
        var sGroup =
            $.grep(self.subGroups, function (g) {
                return g.Id_Grp === self.currentGroup && g.Prc_Quality_Ord === self.currentSub;
            });
        if (sGroup.length > 0) {
            return sGroup[0];
        };
        return null;
    },
    getCurrentSubgroupOrd: function () {
        var sGroup = bars.quality.getCurrentSubgroup();
        if (sGroup) {
            return sGroup.Prc_Quality_Ord;
        }
        return null;
    },
    getCurrentSubgroupId: function () {
        var sGroup = bars.quality.getCurrentSubgroup();
        if (sGroup) {
            return sGroup.Id_Prc_Quality;
        }
        return null;
    },
    currentRnk: null,
    prevRnk: null,
    nextRnk: null,
    currentAtrrGroup: null,
    currentNmk: "",
    currentAtrsCount: null,
    currentQuality: null,
    isAdminMode: false,
    //датасорс грида 
    advisoryDs: new kendo.data.DataSource({
        schema: {
            data: "Data",
            total: "Total",
            errors: "Errors",
            model: {
                fields: {
                    LAST_CARD_UPD: { type: "date" }
                }
            }
        },
        pageSize: 20,
        serverPaging: true,
        serverSorting: false,
        sort: {
            field: "RNK",
            dir: "asc"
        },
        type: "aspnetmvc-ajax",
        transport: {
            read: {
                url: bars.config.urlContent('/Cdm/Quality/GetAdvisoryList'),
                data: function () {
                    var self = bars.quality;
                    return {
                        groupId: self.currentGroup,
                        subGroupId: function () { return self.currentSub; },
                        subGroupOrd: GetSubGroupOrd(),
                        custName: self.custFilter.custName,
                        custRnk: self.custFilter.custRnk,
                        custInn: self.custFilter.custInn,
                        custDocSerial: self.custFilter.custDocSerial,
                        custDocNumber: self.custFilter.custDocNumber,
                        custQualityGroup: self.custFilter.custQualityGroup,
                        custQuality: self.custFilter.custQuality,
                        custAtrCount: self.custFilter.custAtrCount,
                        custBranch: self.custFilter.custBranch,
                        type: GetPersonType()
                    }
                },
                complete: function (result) {
                    bars.quality.advisoryParams.set("cardsInGroup", result.responseJSON.Total);
                    bars.quality.advisoryParams.refreshGroupParams();
                }
            }
        },
        requestStart: function () {
            $('#blockButtons').addClass('k-loading-image k-overlay blockButtons');
        },
        requestEnd: function () {
            $('#blockButtons').removeClass('k-loading-image k-overlay blockButtons');
        }
    }),
    loadGroups: function (callback, params) {

        var type = GetPersonType();
        if (!type) {
            bars.ui.loader('body', false);
            bars.ui.error({ text: "У посиланні функції відсутній тип особи." });
            return;
        }

        bars.ui.loader('body', true);
        $.get(bars.config.urlContent('/Cdm/Quality/GetGroups?isAdminMode=' + bars.quality.isAdminMode + '&type=' + type)).done(function (data) {
            bars.ui.loader('body', false);
            bars.quality.groups = data;
            if (callback) {
                callback(params);
            }
        });
    },
    renderAdvisoryGroup: function (selector) {
        var self = bars.quality;
        for (var i = 0; i < self.groups.length; i++) {
            if (self.groups[i].Id === self.currentGroup) {
                $(selector).text(self.groups[i].Name);
                $('#armName a').text(self.groups[i].Name);
                break;
            }
        }
    },
    loadAndRenderGroups: function (selector, isAdminMode) {
        if (selector) {
            bars.quality.qGroupsContainer = selector;
        }
        if (isAdminMode) {
            bars.quality.isAdminMode = isAdminMode;
        }
        bars.quality.loadGroups(bars.quality.loadSubGroups, bars.quality.qGroupsContainer);
    },
    loadSubGroups: function (selector) {

        var type = GetPersonType();

        bars.ui.loader('body', true);
        $.get(bars.config.urlContent('/Cdm/Quality/GetSubGroups?type=' + type)).done(function (data) {
            bars.ui.loader('body', false);
            bars.quality.subGroups = data;
            if (bars.quality.advisoryParams) {
                bars.quality.advisoryParams.refreshGroupParams();
            }
            if (selector) {
                bars.quality.renderGroups(selector);
            }
        });
    },
    renderGroups: function (selector) {
        var groupsContainer = $(selector);
        var template = kendo.template($("#qualityGroupsTmpl").html());
        groupsContainer.html(template({ groups: bars.quality.groups, subGroups: bars.quality.subGroups, isAdminMode: bars.quality.isAdminMode }));
        if (bars.quality.isAdminMode) {
            $('.q-group-container .q-add-group-btn').click(function () {
                $(this).hide().next('.q-add-group-form').show();
            });
            $('.q-group-container .q-real-sub').click(function () {
                var button = this;
                bars.ui.confirm({ text: 'Ви дійсно бажаєте видалити обрану групу?' }, function () {
                    bars.ui.loader('body', true);
                    $.ajax(
                        {
                            method: 'POST',
                            url: bars.config.urlContent('/Cdm/Quality/DeleteSubgroup'),
                            data: { group: $(button).data('group'), subGroup: $(button).data('sub') },
                            success: function (data) {
                                bars.ui.loader('body', false);
                                if (data.status == 'ok') {
                                    bars.quality.loadAndRenderGroups();
                                } else {
                                    bars.ui.error({ text: data.message });
                                }
                            }
                        });
                });
            });
            $('.q-group-container .q-cancel').click(function () {
                $(this).parents('.q-add-group-form').hide().prev('.q-add-group-btn').show();
            });
            $('.q-group-container .q-save').click(function () {
                var button = $(this);
                var groupId = button.data('group');
                $.ajax(
                        {
                            method: 'POST',
                            url: bars.config.urlContent('/Cdm/Quality/AddSubgroup'),
                            data: { group: groupId, sign: $('#q-sign-' + groupId).data("kendoDropDownList").value(), percent: $('#q-percent-' + groupId).data("kendoNumericTextBox").value() },
                            success: function (data) {
                                bars.ui.loader('body', false);
                                if (data.status == 'ok') {
                                    bars.quality.loadAndRenderGroups();
                                } else {
                                    bars.ui.error({ text: data.message });
                                }
                            }
                        });
            });


            $('.q-group-container .q-sign').kendoDropDownList({
                dataTextField: "text",
                dataValueField: "value",
                dataSource: bars.quality.qGroupSign,
                index: 0
            });
            $('.q-group-container .q-percent').kendoNumericTextBox({
                format: "#",
                max: 100,
                min: 0,
                value: 50
            });

        } else {
            $('.q-group-container .row').click(bars.quality.openAdvisoryList);
        }
    },
    fillGroupMenuDataSource: function (selector) {
        var self = bars.quality;
        self.groupsMenuDs = [];
        for (var i = 0; i < self.groups.length; i++) {
            self.groupsMenuDs.push({ text: self.groups[i].Name, id: self.groups[i].Id, count: self.groups[i].CardCount });
        }
        $(selector).kendoMenu({
            dataSource: self.groupsMenuDs
        });
    },
    loadTemplate: function (path) {
        $.get(path).success(function (result) {
            $("body").append(result);
        }).error(function (result) {
            alert("Помилка завантаження шаблону розширених парамтерів ордера!");
        });
    },
    openAdvisoryList: function () {
        var self = bars.quality;
        var rowParams = $(this).data();
        if (rowParams.sub != null) {
            var advisoryListUrl = bars.config.urlContent('/Cdm/Quality/AdvisoryList?groupId=' + rowParams.group);
            if (rowParams.sub) {
                self.currentGroup = rowParams.group;
                self.currentSub = rowParams.sub;
                advisoryListUrl = advisoryListUrl + '&subGroupId=' + rowParams.sub + '&SubGroupOrd=' + rowParams.subord + '&type=' + GetPersonType();
            }
            window.location = advisoryListUrl
        }
    },
    refreshAdvisoryGrid: function (selector, group, sub) {
        var self = bars.quality;
        self.currentGroup = group;
        self.currentSub = sub;
        var grid = $(selector).data('kendoGrid');
        grid.dataSource.read();
    },
    initAttrValuesDialog: function (selector) {
        var self = bars.quality;
        $(selector).kendoGrid({
            selectable: "single",
            autoBind: false,
            columns: [
                {
                    field: "ID",
                    title: "Код",
                    width: 100
                },
                {
                    field: "NAME",
                    title: "Значення",
                    width: 300
                }
            ],
            sortable: true,
            pageable: {
                refresh: true,
                pageSizes: true,
                buttonCount: 5
            },
            filterable: true,
            dataSource: {
                type: "aspnetmvc-ajax",
                sort: {
                    field: "ID",
                    dir: "asc"
                },
                transport: {
                    read: {
                        dataType: 'json',
                        url: bars.config.urlContent('/cdm/Quality/GetDialogData'),
                        data: { dialogName: self.getDialogName },
                        complete: function (result) {
                            $('#attrDictionary').data('kendoWindow').title(result.responseJSON.Title);
                        }
                    }
                },
                schema: {
                    data: "Data",
                    total: "Total",
                    errors: "Errors"
                },
                serverPaging: true,
                serverSorting: true,
                serverFiltering: true,
                pageSize: 20
            },
            change: function (e) {
                if (this.select()) {
                    $('#attrDictionary .select-button').prop("disabled", false);
                } else {
                    $('#attrDictionary .select-button').prop("disabled", "disabled");
                }

            }

        });
    },
    initAdvisoryGrid: function (selector, group, sub) {
        var self = bars.quality;
        self.currentGroup = group;
        self.currentSub = sub;
        $(selector).kendoGrid({
            columns: [
                {
                    field: "RNK",
                    title: "RNK",
                    width: 100,
                    template: "<span class='hoverIndicator'></span>#=RNK#"
                },
                {
                    field: "OKPO",
                    title: "ІНН",
                    width: 100
                },
                {
                    field: "DOCUMENT",
                    title: "Документ",
                    width: 100
                },
                {
                    field: "NMK",
                    title: "ПІБ",
                    width: 280
                },
                {
                    field: "QUALITY",
                    title: "Якість",
                    width: 100
                },
                {
                    field: "ATTR_QTY",
                    title: "Кількість атрибутів",
                    width: 80,
                    template: "<div style='text-align:center;color:\\#DF7A7A;'>#=ATTR_QTY#</div>",
                    headerAttributes: {
                        style: "white-space: normal;"
                    }
                },
                {
                    field: "LAST_CARD_UPD",
                    title: "Дата останньої модифікації",
                    template: "<div style='text-align:right;'>#=LAST_CARD_UPD == null ? '' :kendo.toString(LAST_CARD_UPD,'dd/MM/yyyy')#</div>",
                    headerAttributes: {
                        style: "white-space: normal;"
                    },
                    width: 110
                },
                {
                    field: "LAST_USER_UPD",
                    title: "Останній редактор",
                    headerAttributes: {
                        style: "white-space: normal;"
                    },
                    width: 180
                },
                {
                    field: "BRANCH",
                    title: "BRANCH",
                    width: 120
                }
            ],
            scrollable: {
                virtual: true
            },
            sortable: true,
            height: 650,
            dataSource: self.advisoryDs,
            dataBound: function (e) {
                var grid = $("#grid").data("kendoGrid");
                $(grid.tbody).off("click", "td").on("click", "td", function (e) {
                    var row = $(this).closest("tr");
                    var data = grid.dataItem(row);
                    self.selectCustomer(data.RNK);
                });
                $("#grid tr").on("mouseover", self.higlihtGridRow);
                self.loadDropDownData();
            }
        });
    },
    customerAttributesRender: function () {
        var self = bars.quality;

        if (self.isAdvisoryMode) {
            var tmp = {};
            var groups = [];
            var _data = self.custAdvisory.data();
            var len = _data.length;
            for (var i = 0; i < len; i++) {
                if (tmp.hasOwnProperty(_data[i].ATTR_GR_ID)) {
                    continue;
                }
                groups.push({ NAME: _data[i].ATTR_GR_NAME, ID: _data[i].ATTR_GR_ID });
                tmp[_data[i].ATTR_GR_ID] = 1;
            }
            $('#attrTypesMenu li.selected').removeClass('selected');
        } else {
            groups = [{ NAME: '', ID: self.currentAtrrGroup }];
        }
        var template = kendo.template($("#custAdvisoryTemplate").html());
        $('#custAttrTypesList').html(template({ groups: groups, items: self.custAttributes.data(), advisoryOnly: self.isAdvisoryMode }));
        kendo.bind('#custAttrTypesList', self.attrChangeBuffer);

        $('#advisoryTable input[data-type="String"]').unbind("click").on("click", self.refreshSaveBtn);

        $('#advisoryTable input[data-type="Integer"]').kendoNumericTextBox({
            format: "#",
            change: self.refreshSaveBtn
        });

        $('#advisoryOnly').unbind("click").on('click', function () {
            self.isAdvisoryMode = true;
            self.customerAttributesRender();
        });

        $('#customerName').show().find('a').text("Клієнт(" + self.currentNmk + ")").end().css("display", "inline-block");

        //выпадающие списки
        var dData = bars.quality.dropDownData;
        if (dData) {
            for (var m = 0; m < dData.length; m++) {
                $('#advisoryTable input[data-name="' + dData[m].ATTR_NAME + '"]').kendoDropDownList({
                    dataTextField: "NAME",
                    dataValueField: "ID",
                    dataSource: dData[m].DROPDOWN_DATA,
                    valuePrimitive: true,
                    change: function () {
                        var sender = this.element;

                        if ((sender.hasClass('attr-advisored') || sender.hasClass('attr-advise-confirmed')) && self.isAdvisoredFilled(sender.data('name'))) {
                            sender.removeClass('attr-advisored').addClass('attr-advise-confirmed');
                            sender.parents('.k-dropdown').removeClass('attr-advisored').addClass('attr-advise-confirmed');
                        } else {
                            sender.removeClass('attr-advise-confirmed').addClass('attr-advisored');
                            sender.parents('.k-k-dropdown').removeClass('attr-advise-confirmed').addClass('attr-advisored');
                        }
                        self.refreshSaveBtn();
                    }
                });
            }
        }

        //календари
        $('#advisoryTable input[data-type="Date"]').kendoDatePicker({
            culture: "uk-UA",
            change: function () {
                var sender = this.element;

                if ((sender.hasClass('attr-advisored') || sender.hasClass('attr-advise-confirmed')) && self.isAdvisoredFilled(sender.data('name'))) {
                    sender.removeClass('attr-advisored').addClass('attr-advise-confirmed');
                    sender.parents('.k-datepicker').removeClass('attr-advisored').addClass('attr-advise-confirmed');
                } else {
                    sender.removeClass('attr-advise-confirmed').addClass('attr-advisored');
                    sender.parents('.k-datepicker').removeClass('attr-advise-confirmed').addClass('attr-advisored');
                }
                self.refreshSaveBtn();
            }
        });

        //диалоги прикручиваем и тултипы
        $('#custAttrTypesList .attr-advisored[data-type="String"]').on('focus', self.changeAttributeDialog);

        $('#custAttrTypesList').kendoTooltip({
            width: 220,
            filter: '.k-dropdown.attr-advisored, .k-datepicker.attr-advisored, input[data-type="Dialog"].attr-advisored, input[data-type="String"].attr-advisored',
            content: function (e) {
                var atrName = e.target.data('name');
                var atrType = e.target.data('type');
                if (!atrName) {
                    atrName = e.target.find('input').data('name');
                    atrType = e.target.find('input').data('type');
                }

                var atrRow = null;
                var data = self.custAdvisory.data();
                for (var i = 0; i < data.length; i++) {
                    if (data[i].NAME === atrName) {
                        atrRow = data[i];
                        break;
                    }
                }
                var result = ((atrRow) ? atrRow.ATT_UKR_NAME + "</br>" : "");
                result = result + ((atrRow && atrRow.DESCR) ? atrRow.DESCR + "</br>" : "");
                if (atrRow && atrRow.RECOMMENDVALUE) {
                    result = result + "Рекомендовано замінити на: ";
                    switch (atrType) {
                        case "Date":
                        case "String":
                            result = result + "'" + atrRow.RECOMMENDVALUE + "'";
                            break;
                        case "DropDown":
                            //подствавим вместо кода - значений из соответствующего справочника
                            var recomVal = atrRow.RECOMMENDVALUE;
                            var dData = bars.quality.dropDownData;
                            if (dData) {
                                for (var m = 0; m < dData.length; m++) {
                                    if (dData[m].ATTR_NAME === atrName) {
                                        for (var n = 0; n < dData[m].DROPDOWN_DATA.length; n++) {
                                            if (dData[m].DROPDOWN_DATA[n].ID === recomVal) {
                                                recomVal = dData[m].DROPDOWN_DATA[n].NAME;
                                                break;
                                            }
                                        }
                                        break;
                                    }
                                }
                            }
                            result = result + "'" + recomVal + "'";
                            break;
                        case "Dialog":
                            result = result + "значення із кодом " + atrRow.RECOMMENDVALUE + ",</br>" +
                                "що відфільтроване у діалозі.";
                    }
                }
                return result;
            }
        });

        $('#atr-KF, #atr-BRANCH, #atr-DATE_OFF').addClass('k-state-disabled');
        return true;
    },
    fillInputBuffer: function () {
        var inputData = {};
        var self = bars.quality;
        var data = self.custAttributes.data();
        for (var i = 0; i < data.length; i++) {
            var isAdvisory = self.isAttributeAdvisored(data[i].NAME);
            inputData[data[i].NAME] = { oldVal: data[i].DB_VALUE, newVal: data[i].DB_VALUE, changed: false, isAdv: isAdvisory, modified: function () { return newVal !== oldVal; } }
        }
        self.attrChangeBuffer = new kendo.data.ObservableObject(inputData);
    },
    isAttributeAdvisored: function (attrName) {
        var self = bars.quality;
        var result = false;
        var advisoryData = self.custAdvisory.data();
        for (var j = 0; j < advisoryData.length; j++) {
            if (advisoryData[j].NAME === attrName) {
                result = true;
                break;
            }
        }
        return result;
    },
    isAdvisoredFilled: function (attrName) {
        var self = bars.quality;
        var newVal = self.attrChangeBuffer.get(attrName).get('newVal');
        var oldVal = self.attrChangeBuffer.get(attrName).get('oldVal');
        if (typeof newVal == "string" && oldVal == null && newVal.replace(/^\s+|\s+$/gm, '') === "") {
            self.attrChangeBuffer.get(attrName).set('newVal', null);
        }
        newVal = self.attrChangeBuffer.get(attrName).get('newVal');
        return newVal !== oldVal;
    },
    isAnyChanged: function () {
        var self = bars.quality;
        var data = self.custAttributes.data();
        for (var i = 0; i < data.length; i++) {
            if (self.isAdvisoredFilled(data[i].NAME)) {
                return true;
            }
        }
        return false;
    },
    refreshSaveBtn: function () {
        var self = bars.quality;
        var attrName = $(this).data("name");
        //установка полного наименования клиента
        if (attrName === "SN_LN" || attrName === "SN_FN" || attrName === "SN_MN") {
            var ln = self.attrChangeBuffer.get("SN_LN").get("newVal");
            var fn = self.attrChangeBuffer.get("SN_FN").get("newVal");
            var mn = self.attrChangeBuffer.get("SN_MN").get("newVal");
            var nmk = (ln ? ln.toUpperCase() : "") + " " +
                    (fn ? fn.toUpperCase() : "") + " " +
                    (mn ? mn.toUpperCase() : "");
            self.attrChangeBuffer.get("NMK").set("newVal", nmk);
            var serviceUrl = bars.config.urlContent('/clientregister/defaultWebService.asmx/TranslateKMU');
            $.ajax({
                type: "POST",
                url: serviceUrl,
                dataType: "json",
                data: JSON.stringify({ txt: nmk }),
                headers: {
                    Accept: "application/json; charset=utf-8",
                    "Content-Type": "application/json; charset=utf-8"
                },
                success: function (data) {
                    self.attrChangeBuffer.get("NMKV").set("newVal", data.d);
                }
            });
        }

        if (bars.quality.isAnyChanged()) {
            $('#saveBtn i').removeClass('disabled').unbind('click').on('click', function () { bars.quality.saveAllAttributes() });
        } else {
            $('#saveBtn i').addClass('disabled').unbind('click');
        }
    },
    backToAdvisoryList: function () {
        $('#advisoryApply').hide();
        $('#advisoryList').show();
        $('#customerName').hide();
    },
    higlihtGridRow: function () {
        $('#grid td').removeClass('q-row-hover');
        $(this).find('td').first().addClass('q-row-hover');
    },
    selectCustomer: function (rnk) {
        $('#advisoryApply').show();
        $('#advisoryList').hide();
        var self = bars.quality;
        self.currentRnk = rnk;
        var data = self.advisoryDs.data();
        for (var i = 0; i < data.length; i++) {
            if (data[i].RNK === rnk) {
                self.currentNmk = data[i].NMK;
                self.currentAtrsCount = data[i].ATTR_QTY;
                self.currentQuality = data[i].QUALITY + "%";
                self.prevRnk = null;
                if (i > 0) {
                    self.prevRnk = data[i - 1].RNK;
                }
                self.nextRnk = null;
                if (i < (data.length - 1)) {
                    self.nextRnk = data[i + 1].RNK;
                }
                break;
            }
        }
        if (!self.prevRnk) {
            $('#advisoryApply .q-cust-prev')
                .removeClass('k-link')
                .find('a')
                .unbind('click')
                .find('i')
                .addClass('pf-disabled');
        } else {
            $('#advisoryApply .q-cust-prev')
                .addClass('k-link')
                .find('a')
                .unbind('click')
                .on('click', function () {
                    self.selectCustomer(self.prevRnk);
                    return false;
                })
                .find('i')
                .removeClass('pf-disabled');
        }
        if (!self.nextRnk) {
            $('#advisoryApply .q-cust-next')
                .removeClass('k-link')
                .find('a')
                .unbind('click')
                .find('i')
                .addClass('pf-disabled');
        } else {
            $('#advisoryApply .q-cust-next')
                .addClass('k-link')
                .find('a')
                .unbind('click')
                .on('click', function () {
                    self.selectCustomer(self.nextRnk);
                    return false;
                })
                .find('i')
                .removeClass('pf-disabled');
        }
        bars.ui.loader('body', true);
        bars.quality.custAdvisory.read();
        bars.quality.refreshSaveBtn();
        $('#attrEditDlg').data("kendoWindow").close();
    },
    attrChangeBuffer: null,
    attrGroups4Render: [],
    changeAttributeDialog: function () {
        var self = bars.quality;
        var $dlg = $('#attrEditDlg');
        var dlg = $dlg.data("kendoWindow");
        var inputPos = $(this).position();
        var atrName = $(this).attr('id');
        atrName = atrName.substring(4);
        var atrRow = null;
        var data = self.custAdvisory.data();
        for (var i = 0; i < data.length; i++) {
            if (data[i].NAME === atrName) {
                atrRow = data[i];
                break;
            }
        }
        dlg.setOptions({
            title: (atrRow) ? atrRow.ATT_UKR_NAME : "",
            position: {
                top: inputPos.top,
                left: inputPos.left + 500
            }
        });
        if (atrRow && atrRow.DESCR !== null) {
            $('#attrEditDlg label').text(atrRow.DESCR);
        } else {
            $('#attrEditDlg label').text('Без пояснень');
        }
        if (atrRow && atrRow.RECOMMENDVALUE !== null) {
            $('#attrNewVal').val(atrRow.RECOMMENDVALUE);
        } else {
            $('#attrNewVal').val('');
        };
        if (atrRow && atrRow.NAME !== null) {
            $('#attrEditDlg button').data('atr-name', atrRow.NAME).unbind("click").on('click', self.saveAtr);
        }
        dlg.open();
    },
    saveAtr: function () {
        var self = bars.quality;
        var atrName = $(this).data('atr-name');
        self.attrChangeBuffer.get(atrName).set('newVal', $('#attrNewVal').val());
        if (self.isAdvisoredFilled(atrName)) {
            $('#custAttrTypesList [data-name="' + atrName + '"]').removeClass('attr-advisored').addClass('attr-advise-confirmed');
        }
        self.refreshSaveBtn();
        $('#attrEditDlg').data("kendoWindow").close();
    },
    refreshCustAttributes: function () {
        var self = bars.quality;
        self.custAttributes.read();
        bars.quality.fillInputBuffer();
        bars.quality.customerAttributesRender();
    },
    saveAllAttributes: function () {
        var self = bars.quality;
        var newAttributes = [];
        var allAttributes = self.custAttributes.data();
        for (var i = 0; i < allAttributes.length; i++) {
            if (self.isAdvisoredFilled(allAttributes[i].NAME)) {
                var currAttr = self.attrChangeBuffer.get(allAttributes[i].NAME);
                var currAttrVal = null;
                if (allAttributes[i].TYPE === "Date") {
                    var td = new Date(currAttr.get('newVal'));
                    currAttrVal = (td.getDate()) + "." + (td.getMonth() + 1) + "." + (td.getFullYear());
                } else {
                    currAttrVal = currAttr.get('newVal');
                }
                newAttributes.push({
                    rnk: self.currentRnk,
                    attributeName: allAttributes[i].NAME,
                    newValue: currAttrVal
                });
            }
        }
        var params = JSON.stringify(newAttributes);
        bars.ui.loader('body', true);
        $.ajax(
            {
                method: 'POST',
                url: bars.config.urlContent('/Cdm/Quality/SaveCustomerAttributes'),
                data: { newData: params, type: GetPersonType() },
                success: function (data) {
                    bars.ui.loader('body', false);
                    var queuedMsg = "<br />Картку буде надіслано на оцінку якості до ЕБК в найближчий час у пакетному режимі.";
                    if (status == 'ok') {
                        if (data.data.Data.status === "NEEDS_TO_BE_CORRECTED") {
                            bars.ui.alert({ text: "Перевірка атрибутів картки виявила необхідність її корегування.<br /> Перегляньте рекомендації та внесіть відповідні зміни." });
                        } else {
                            bars.ui.alert({ text: data.message });
                        }
                    } else {
                        bars.ui.alert({ text: data.message + queuedMsg });
                    }
                    self.resyncCurrentAdvisories();
                    self.refreshCustAttributes();
                    self.refreshSaveBtn();
                },
                error: function () {
                    bars.ui.alert({ text: queuedMsg });
                }
            }
        );
    },
    loadCustomerAttributes: function (item) {
        var self = bars.quality;
        var menuItem = $(item.item);
        self.currentAtrrGroup = menuItem.data('groupid');
        $('#attrTypesMenu li.selected').removeClass('selected');
        menuItem.addClass('selected');
        self.isAdvisoryMode = false;
        self.customerAttributesRender();
    },
    dropDownData: null,
    loadDropDownData: function () {
        if (bars.quality.dropDownData == null) {
            $.get(bars.config.urlContent('/Cdm/Quality/GetDropDownData?type=' + GetPersonType())).done(function (data) {
                bars.quality.dropDownData = data;
            });
        }
    },
    custFilter: new kendo.data.ObservableObject({
        custName: null,
        custRnk: null,
        custInn: null,
        custDocSerial: null,
        custDocNumber: null,
        custQualityGroup: null,
        custQuality: null,
        custAtrCount: null,
        custBranch: null,
        doFilter: function () {
            bars.quality.advisoryDs.read();
        },
        qualityGroupList: [{
            QUALITY_GROUP_DESC: 1,
            QUALITY_GROUP: 1
        }]
    }),
    lastDlgType: null,
    //показ окна диалога
    showAttributeDialog: function (dialogType) {
        var self = bars.quality;
        var dlg = $('#attrDictionary').data('kendoWindow');
        if (self.lastDlgType !== dialogType) {
            self.lastDlgType = dialogType;
            var grid = $('#listOfAttrValues').data('kendoGrid');

            //установим или сбросим фильтр в зависимости от наличия рекомендованого значения
            var atrRow = null;
            var data = self.custAdvisory.data();
            for (var i = 0; i < data.length; i++) {
                if (data[i].NAME === dialogType) {
                    atrRow = data[i];
                    break;
                }
            }

            if (atrRow && atrRow.RECOMMENDVALUE) {
                grid.dataSource.filter({ field: "ID", operator: "eq", value: atrRow.RECOMMENDVALUE });
            } else {
                grid.dataSource.filter({});
            }

            //grid.dataSource.read();
            grid.refresh();
            $('#attrDictionary .select-button').prop("disabled", "disabled");
        }
        dlg.center().open();
    },
    closeAttributeDialog: function () {
        var self = bars.quality;
        var sender = $('input[data-name="' + self.lastDlgType + '"]');
        if (sender.hasClass('attr-advisored') || sender.hasClass('attr-advise-confirmed')) {
            if (self.isAdvisoredFilled(self.lastDlgType)) {
                sender.removeClass('attr-advisored').addClass('attr-advise-confirmed');
            } else {
                sender.removeClass('attr-advise-confirmed').addClass('attr-advisored');
            }
        }
        self.refreshSaveBtn();
    },
    getDialogName: function () {
        return bars.quality.lastDlgType;
    },
    advisoryParams: null,

    resyncCurrentAdvisories: function () {
        var self = bars.quality;
        if (!self.currentRnk) {
            return;
        }
        var gridData = self.advisoryDs.data();

        $.get(bars.config.urlContent('/Cdm/Quality/GetAdvisoryListByRnk?rnk=' + self.currentRnk + "&groupId=" + self.currentGroup + "&type=" + GetPersonType())).done(function (data) {
            var newData = data.data;

            for (var i = 0; i < gridData.length; i++) {
                if (gridData[i].RNK === self.currentRnk) {
                    var gridRecord = gridData[i];
                    if (newData && newData.length > 0) {
                        newData = newData[0];
                        self.currentAtrsCount = newData.ATTR_QTY;
                        self.currentNmk = newData.NMK;
                        self.currentQuality = newData.QUALITY + "%";
                        gridRecord.set("ATTR_QTY", newData.ATTR_QTY);
                        gridRecord.set("BIRTH_DAY", newData.BIRTH_DAY);
                        gridRecord.set("DOCUMENT", newData.DOCUMENT);
                        gridRecord.set("NMK", newData.NMK);
                        gridRecord.set("OKPO", newData.OKPO);
                        gridRecord.set("QUALITY", newData.QUALITY);

                    } else {
                        gridRecord.set("ATTR_QTY", 0);
                        self.currentAtrsCount = 0;
                    }

                    self.custAdvisory.read();
                    self.refreshSaveBtn();
                    break;
                }
            }

        });
    },

    initAdvisoryParams: function (groupId, subId, subOrd) {
        var self = bars.quality;
        self.currentGroup = groupId;
        self.currentSub = subId;
        bars.quality.advisoryParams = kendo.observable({
            selectedGroup: groupId,
            selectedSub: subOrd,
            groupFilled: "",
            cardsInGroup: 0,
            getCurrentSubGroups: function () {
                return $.grep(bars.quality.subGroups,
                    function (o) {
                        return o.Id_Grp === bars.quality.currentGroup;
                    }).map(
                    function (o) {
                        return o.Prc_Quality_Ord;
                    });
            },
            currSub: function () {
                var subTxt = this.get("selectedSub");
                if (subTxt) {
                    return subTxt;
                } else {
                    return 'Всі';
                };
            },
            subLabel: function () {
                var subTxt = this.get("selectedSub");
                if (subTxt) {
                    return 'група';
                } else {
                    return 'групи';
                }
            },
            nextSub: function () {
                var subTxt = this.get("selectedSub");
                var currentGroups = this.getCurrentSubGroups();
                if (!subTxt) {
                    var minSubOrd = Math.min.apply(Math, currentGroups);
                    this.set("selectedSub", minSubOrd);
                } else {
                    var maxSubOrd = Math.max.apply(Math, currentGroups);
                    if (subTxt < maxSubOrd) {
                        this.set("selectedSub", ++subTxt);
                    } else {
                        this.set("selectedSub", null);
                    }
                }
                bars.quality.refreshAdvisoryGrid('#grid', bars.quality.advisoryParams.selectedGroup, bars.quality.advisoryParams.selectedSub);
            },
            prevSub: function () {
                var subTxt = this.get("selectedSub");
                var currentGroups = this.getCurrentSubGroups();
                if (!subTxt) {
                    var maxSubOrd = Math.max.apply(Math, currentGroups);
                    this.set("selectedSub", maxSubOrd);
                } else {
                    var minSubOrd = Math.min.apply(Math, currentGroups);
                    if (subTxt > minSubOrd) {
                        this.set("selectedSub", --subTxt);
                    } else {
                        this.set("selectedSub", null);
                    }
                }
                bars.quality.refreshAdvisoryGrid('#grid', bars.quality.advisoryParams.selectedGroup, bars.quality.advisoryParams.selectedSub);
            },
            groupName: function () {
                var grp = this.get("selectedGroup");
                if (!grp) {
                    return "--";
                }
                for (var i = 0; i < bars.quality.groups.length; i++) {
                    if (bars.quality.groups[i].Id === grp) {
                        return bars.quality.groups[i].Name;
                    }
                }
                return "";
            },
            refreshGroupParams: function () {
                var grp = this.get("selectedGroup");
                var subGrp = this.get("selectedSub");
                if (subGrp == null) {
                    this.set("groupFilled", "0-100%")
                    return true;
                }
                for (var i = 0; i < bars.quality.subGroups.length; i++) {
                    if (bars.quality.subGroups[i].Id_Grp === grp && bars.quality.subGroups[i].Prc_Quality_Ord === subGrp) {
                        this.set("groupFilled", bars.quality.subGroups[i].Prc_Quality_Name + "%");
                        break;
                    }
                }
            }
        });
    }
}
function GetPersonType() {

    var url = document.location.href;
    var parseUrl = url.split('type=');
    var type = parseUrl[1];

    return type;
}

function GetSubGroupOrd() {

    var type = GetPersonType();

    if (type == 'individualPerson') {
        var url = document.location.href;
        var parseUrl = url.split('SubGroupOrd=');
        var subGroupOrdToParse = parseUrl[1];
        var subGroupOrd = subGroupOrdToParse.match(/\d+/)[0];

        return subGroupOrd;
    }
    else {
        return null;
    }
}