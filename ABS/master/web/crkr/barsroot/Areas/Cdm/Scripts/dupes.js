if (!("bars" in window)) window["bars"] = {};
bars.dupes = bars.dupes || {
    dupFilter: new kendo.data.ObservableObject({
        custName: "",
        custRnk: null,
        custInn: "",
        custDocSerial: "",
        custDocNumber: "",
        custQuality: "",
        custBranch: "",
        doFilter: function() {
            var grid = $("#grid").data("kendoGrid");
            grid.dataSource.read();
            grid.refresh();
        }
    }),
    //датасорс грида 
    dupesDs: new kendo.data.DataSource({
        schema: {
            data: "Data",
            total: "Total",
            errors: "Errors"
        },
        pageSize: 20,
        serverPaging: true,
        serverSorting: true,
        sort: {
            field: "M_RNK",
            dir: "asc"
        },
        type: "aspnetmvc-ajax",
        transport: {
            read: {
                url: bars.config.urlContent("/Cdm/Deduplicate/GetDuplicateGroupList"),
                data: function() {
                    var self = bars.dupes;
                    return {
                        Nmk: self.dupFilter.custName,
                        M_rnk: self.dupFilter.custRnk,
                        Okpo: self.dupFilter.custInn,
                        Document: self.dupFilter.custDocSerial + " " + self.dupFilter.custDocNumber,
                        Card_Quality: self.dupFilter.custQuality,
                        Branch: self.dupFilter.custBranch
                    }
                }
            }
        }
    }),

    initMainPage: function() {
        var self = bars.dupes;
        $("#filterBlock").kendoPanelBar();
        var filterPanel = $("#filterBlock").data("kendoPanelBar");
        filterPanel.expand($("#mainFilter"));
        $("#qulityFilterSlider").kendoSlider({
            value: 100,
            min: 0,
            max: 100,
            showButtons: false,
            change: self.dupFilter.doFilter,
            tooltip: {
                enablet: true,
                template: kendo.template("# return '0 - ' + value #")
            }
        });
        $("#grid").kendoGrid({
            columns: [
                {
                    field: "M_rnk",
                    title: "RNK",
                    width: 100,
                    template: "<span class='hoverIndicator'></span>#=M_rnk#"
                },
                {
                    field: "Nmk",
                    title: "ПІБ",
                    width: 280
                },
                {
                    field: "Qty_d_rnk",
                    title: "Кількість дублікатів",
                    width: 80,
                    template: "<div style='text-align:center;color:\\#DF7A7A;'>#=Qty_d_rnk#</div>",
                    headerAttributes: {
                        style: "white-space: normal;"
                    }
                },
                {
                    field: "Branch",
                    title: "BRANCH",
                    width: 120
                }
            ],
            scrollable: {
                virtual: true
            },
            sortable: true,
            height: 650,
            dataSource: self.dupesDs,
            dataBound: function() {
                var grid = $("#grid").data("kendoGrid");
                $(grid.tbody).off("click", "td").on("click", "td", function() {
                    var row = $(this).closest("tr");
                    var data = grid.dataItem(row);
                    self.selectCustomer(data.M_rnk);
                });
                $("#grid tr").on("mouseover", bars.quality.higlihtGridRow);
            }
        });
        kendo.bind($("#filterBlock"), self.dupFilter);
        self.currentDuplicates.bind("change", function (e) {
            //синхронизация галочки "паспорт" с серией и номером документа
            if (e.field === "selectedChildAttributes.DOCUMENT") {
                var isPassportChecked = self.currentDuplicates.selectedChildAttributes.DOCUMENT;
                self.currentDuplicates.selectedChildAttributes.SER = isPassportChecked;
                self.currentDuplicates.selectedChildAttributes.NUMDOC = isPassportChecked;
                
            }
            //синхронизация галочек "SN" и "NUMDOC"
            if (e.field === "selectedChildAttributes.SN" || e.field === "selectedChildAttributes.NUMDOC") {
                var isSerialChecked = self.currentDuplicates.selectedChildAttributes.SN;
                var isNumDocChecked = self.currentDuplicates.selectedChildAttributes.SNNUMDOC;
                self.currentDuplicates.selectedChildAttributes.DOCUMENT = isSerialChecked && isNumDocChecked;
            }
            //обработчик события изменения модели дубликатов
            if (self.currentDuplicates.isAnyChildFieldSelected()) {
                $("#copyAttributesToMainCard").show();
            } else {
                $("#copyAttributesToMainCard").hide();
            }
        });

        $('#fio').focus(function () {
            var input = $(this);
            if (input.val() == input.attr('placeholder')) {
                input.val('');
                input.removeClass('placeholder');
            }
        }).blur(function () {
            var input = $(this);
            if (input.val() == '' || input.val() == input.attr('placeholder')) {
                input.addClass('placeholder');
                input.val(input.attr('placeholder'));
            }
        }).blur();

        $("#branches").kendoDropDownList({
            optionLabel: " ",
            dataSource:
                {
                    type: "aspnetmvc-ajax",
                    transport: {
                        read: {
                            url: bars.config.urlContent("/Cdm/Quality/BranchList")
                        }
                    }
                }
        });
    },

    currentDuplicates: new kendo.data.ObservableObject({
        rnk: null,
        mainCard: {},
        childCards: [],
        currentChildCard: null,
        currentChildIdx: 0,
        getCurrentChild: function() {
            return this.get("currentChildIdx") + 1;
        },
        isAttrHasDifferentValue: function(attrName) {
            var self = bars.dupes.currentDuplicates;
            var childAtrValue = null;
            for (var j = 0; j < self.childCardAttributes.length; j++) {
                if (self.childCardAttributes[j].NAME === attrName) {
                    childAtrValue = self.childCardAttributes[j].DB_VALUE;
                    break;
                }
            }
            var mainAtrValue = null;
            for (j = 0; j < self.mainAttributes.length; j++) {
                if (self.mainAttributes[j].NAME === attrName) {
                    mainAtrValue = self.mainAttributes[j].DB_VALUE;
                    break;
                }
            }
            return mainAtrValue !== childAtrValue;
        },
        getChildsCount: function() {
            return this.get("childCards").length;
        },
        selectNextChild: function() {
            var currIdx = this.get("currentChildIdx");

            if (currIdx + 1 < bars.dupes.currentDuplicates.childCards.length) {
                this.set("currentChildIdx", ++currIdx);
                this.set("currentChildCard", bars.dupes.currentDuplicates.childCards[currIdx]);
                bars.dupes.currentDuplicates.loadCurrentChildAttributes();
            } 
        },
        selectPrevChild: function () {
            var currIdx = this.get("currentChildIdx");

            if (currIdx > 0) {
                this.set("currentChildIdx", --currIdx);
                this.set("currentChildCard", bars.dupes.currentDuplicates.childCards[currIdx]);
                bars.dupes.currentDuplicates.loadCurrentChildAttributes();
            }
        },
        currChildLastDateModifStr: function () {
            var currCard = bars.dupes.currentDuplicates.get("currentChildCard");
            if (currCard) {
                return kendo.toString(kendo.parseDate(currCard.LAST_MODIFC_DATE), "dd.MM.yyyy");
            }
            return "";
        },
        mainLastDateModifStr: function () {
            if (bars.dupes.currentDuplicates.mainCard && bars.dupes.currentDuplicates.mainCard.LAST_MODIFC_DATE) {
                return kendo.toString(kendo.parseDate(bars.dupes.currentDuplicates.mainCard.LAST_MODIFC_DATE), "dd.MM.yyyy");
            }
            return "";
        },
        isPrevChildDisabled: function () {
            return this.get("currentChildIdx") === 0;
        },
        isNextChildDisabled: function() {
            return (this.get("currentChildIdx") + 1) === bars.dupes.currentDuplicates.getChildsCount();
        },
        attrGroups: [],
        childCardAttributes: [],
        loadCurrentChildAttributes: function() {
            var that = bars.dupes.currentDuplicates;
            var dRnk = that.currentChildCard.D_RNK;
            $.get(bars.config.urlContent("/Cdm/Deduplicate/GetRnkAttributes?rnk=" + dRnk)).done(function (data) {
                that.set("childCardAttributes", data.Attributes);

                var newSelectedAttrModel = {};
                for (var i = 0; i < data.Attributes.length; i++) {
                    newSelectedAttrModel[data.Attributes[i].NAME] = false;
                }
                that.set("selectedChildAttributes", newSelectedAttrModel);

                var template = kendo.template($("#dupesChildcardAttrTpl").html());
                $("#childrenAttributesPanel").html(template({ groups: that.attrGroups, attributes: that.childCardAttributes, attrHasDiffVal: that.isAttrHasDifferentValue }));
                $("#childrenAttributesPanel").kendoPanelBar({
                    expandMode: "single",
                    activate: function (e) {
                        var group = $(e.item).data("groupid");
                        var mainPanel = $("#mainAttributesPanel").data("kendoPanelBar");
                        mainPanel.expand($("[data-groupid=" + group + "]"), false);
                    }
                });

                kendo.bind($("#dupesWork"), bars.dupes.currentDuplicates);
            });
        },
        selectedChildAttributes: {},
        setCurrentChildAsMain: function() {
            var self = bars.dupes.currentDuplicates;
            bars.ui.confirm({ text: "Ви впевнені?" },
                function () {
                    bars.ui.loader("body", true);
                    $.get(bars.config.urlContent("/Cdm/Deduplicate/SetNewMainCard?mRnk=" + self.rnk + "&dRnk=" + self.currentChildCard.D_RNK)).done(function (data) {
                        if (data.status === "ok") {
                            bars.dupes.selectCustomer(self.currentChildCard.D_RNK);
                        } else {
                            bars.ui.error({ text: data.message });
                        }
                        bars.ui.loader("body", false);
                    });
                });
        },
        ignoreCurrentChild: function () {
            var self = bars.dupes.currentDuplicates;
            bars.ui.confirm({ text: "Ви впевнені?" },
                function () {
                    bars.ui.loader("body", true);
                    $.get(bars.config.urlContent("/Cdm/Deduplicate/IgnoreChild?mRnk=" + self.rnk + "&dRnk=" + self.currentChildCard.D_RNK)).done(function (data) {
                        if (data.status === "ok") {
                            bars.dupes.selectCustomer(self.rnk);
                        } else {
                            bars.ui.error({ text: data.message });
                        }
                        bars.ui.loader("body", false);
                    });
                });
        },
        mergeCurrentChild: function () {
            var self = bars.dupes.currentDuplicates;
            bars.ui.confirm({ text: "Ви впевнені?" },
                function () {
                    bars.ui.loader("body", true);
                    $.get(bars.config.urlContent("/Cdm/Deduplicate/MergeDupes?mRnk=" + self.rnk + "&dRnk=" + self.currentChildCard.D_RNK)).done(function (data) {
                        if (data.status === "ok") {
                            bars.dupes.selectCustomer(self.rnk);
                        } else {
                            bars.ui.error({ text: data.message });
                        }
                        bars.ui.loader("body", false);
                    });
                });
        },
        moveAttributesFromCurrentChild: function() {
            var self = bars.dupes.currentDuplicates;
            bars.ui.confirm({ text: "Ви впевнені?" },
                function() {
                    bars.ui.loader("body", true);
                    var attrNames = [];
                    var values = [];
                    for (var name in self.selectedChildAttributes) {
                        if (self.selectedChildAttributes.hasOwnProperty(name) && self.selectedChildAttributes[name] === true && name !== "DOCUMENT") {
                            attrNames.push(name);
                            for (var j = 0; j < self.childCardAttributes.length; j++) {
                                if (self.childCardAttributes[j].NAME === name) {
                                    values.push(self.childCardAttributes[j].DB_VALUE);
                                    break;
                                }
                            }
                        }
                    }
                    $.ajax({
                        type: "POST",
                        url: bars.config.urlContent("/Cdm/Deduplicate/MoveAttributesFromChild"),
                        data: { rnk: self.rnk, attributes: attrNames, values: values },
                        dataType: "json",
                        traditional: true,
                        success: function(data) {
                            if (data.status === "ok") {
                                bars.dupes.selectCustomer(self.rnk);
                            } else {
                                bars.ui.error({ text: data.message });
                            }
                            bars.ui.loader("body", false);
                        }
                    });

                });
        },
        isAnyChildFieldSelected: function() {
            var self = bars.dupes.currentDuplicates;
            for (var name in self.selectedChildAttributes) {
                if (self.selectedChildAttributes.hasOwnProperty(name) && self.selectedChildAttributes[name] === true) {
                        return true;
                    }
                }
            return false;
        },
        loadNextGrp: function () {
            var self = bars.dupes;
            if (!this.isNextGrpDisabled()) {
                var grps = self.dupesDs.data();
                var currRnk = self.currentDuplicates.get("rnk");
                for (var i = 0; i < grps.length; i++) {
                    if (grps[i].M_rnk === currRnk) {
                        self.selectCustomer(grps[i + 1].M_rnk);
                        break;
                    }
                }
            }
        },
        loadPrevGrp: function () {
            var self = bars.dupes;
            if (!this.isPrevGrpDisabled()) {
                var grps = self.dupesDs.data();
                var currRnk = self.currentDuplicates.get("rnk");
                for (var i = 0; i < grps.length; i++) {
                    if (grps[i].M_rnk === currRnk) {
                        self.selectCustomer(grps[i - 1].M_rnk);
                        break;
                    }
                }
            }
        },
        isNextGrpDisabled: function() {
            var self = bars.dupes;
            var grps = self.dupesDs.data();
            var currRnk = self.currentDuplicates.get("rnk");
            for (var i = 0; i < grps.length - 1; i++) {
                if (grps[i].M_rnk === currRnk) {
                    return false;
                }
            }
            return true;
        },
        isPrevGrpDisabled: function () {
            var self = bars.dupes;
            var grps = self.dupesDs.data();
            var currRnk = self.currentDuplicates.get("rnk");
            for (var i = 1; i < grps.length; i++) {
                if (grps[i].M_rnk === currRnk) {
                    return false;
                }
            }
            return true;
        }
    }),

    selectCustomer: function (rnk) {
        var self = bars.dupes;
        $.get(bars.config.urlContent("/Cdm/Deduplicate/GetRnkDuplicates?rnk=" + rnk)).done(function (data) {
            if (data.MainCard) {

                self.currentDuplicates.set("rnk", rnk);
                self.currentDuplicates.set("mainCard", data.MainCard);
                self.currentDuplicates.set("childCards", data.ChildCards);
                if (data.ChildCards.length > 0) {
                    self.currentDuplicates.set("currentChildCard", data.ChildCards[0]);
                }
                self.currentDuplicates.set("attrGroups", data.AttrGroups);
                self.currentDuplicates.set("mainAttributes", data.MainAttributes);

                $("#dupesList").hide();
                $("#dupesWork").show();

                $("#dupesWork table td.q-group").removeAttr("class").attr("class", "q-group name" + data.MainCard.GROUP_ID);

                var template = kendo.template($("#dupesMaincardAttrTpl").html());
                $("#mainAttributesPanel").html(template({ groups: self.currentDuplicates.attrGroups, attributes: self.currentDuplicates.mainAttributes }));
                bars.dupes.currentDuplicates.loadCurrentChildAttributes();
                $("#mainAttributesPanel").kendoPanelBar({
                    expandMode: "single",
                    activate: function(e) {
                        var group = $(e.item).data("groupid");
                        var cgildPanel = $("#childrenAttributesPanel").data("kendoPanelBar");
                        cgildPanel.expand($("[data-groupid=" + group + "]"), false);
                    }
                });
            } else {
                //карточки уже нет - дубликаты закончились, переходим на список дубликатов
                self.backToDupelist();
            }

        });
        
    },
    backToDupelist: function() {
        $("#dupesWork").hide();
        $("#dupesList").show();
        bars.dupes.dupesDs.read();
    }
    
}