var branchListCheckedRefresh = null; 


$(document).ready(function () {

    function treeExcelLikeClick(treeList, node, onlyParentRefresh) {
        var row = $(node).closest("tr");
        var dataItem = $(treeList).data("kendoTreeList").dataItem(row);

        var isChecked = $(treeList + ' input:checkbox[data-branch="' + dataItem.BRANCH + '"]').prop('checked');

        //обработаем все дочерние ветки
        if (!onlyParentRefresh && dataItem.HAS_CHILD === "Y") {
            $(treeList + ' input:enabled:checkbox[data-branch^="' + dataItem.BRANCH + '"]').prop('checked', isChecked);
            $(treeList).data("kendoTreeList").expand(row);
        }

        //поднимемся вверх рекурсивно
        (function renderParentBranch(currentBranch) {
            var parentBranch = currentBranch.substring(0, currentBranch.length - 2);
            parentBranch = parentBranch.substring(0, parentBranch.lastIndexOf('/') + 1);

            if (parentBranch !== "") {
                if (isChecked) {
                    var allChildrenChecked = $(treeList + ' input:checkbox:not(:checked)[data-branch^="' + parentBranch + '"]').not('[data-branch="' + parentBranch + '"]').length === 0;
                    if (allChildrenChecked) {
                        $(treeList + ' input:checkbox[data-branch="' + parentBranch + '"]')
                            .prop("indeterminate", false);
                    } else {
                        $(treeList + ' input:checkbox[data-branch="' + parentBranch + '"]')
                            .prop("indeterminate", true);
                    }
                } else {
                    var allChildrenUnchecked = $(treeList + ' input:checkbox:checked[data-branch^="' + parentBranch + '"]').not('[data-branch="' + parentBranch + '"]').length === 0;
                    if (allChildrenUnchecked) {
                        $(treeList + ' input:checkbox[data-branch="' + parentBranch + '"]')
                            .prop("indeterminate", false);
                    } else {
                        $(treeList + ' input:checkbox[data-branch="' + parentBranch + '"]')
                            .prop("indeterminate", true);
                    }
                }

                renderParentBranch(parentBranch);
            }
        })(dataItem.BRANCH);
    }

    branchListCheckedRefresh = treeExcelLikeClick;
    // branch's grid of tab: Загальна інформація

    $("#branchWindow").kendoWindow({
        width: "600px",
        height: "500px",
        title: "Доступні відділення",
        resizable: false,
        visible: false,
        actions: ["Close"]
    });

    var branchGrid = null;

    function getBranchGrid() {
        if (branchGrid == null) {
            branchGrid = $("#branchGrid").data("kendoGrid");
        }
        return branchGrid;
    }

    function setDefaultSelectedBranch() {
        var grid = $("#branchGrid").data("kendoGrid");
        if (grid != null) {
            grid.select("tr:eq(1)");
        }
    }
    

    $("#branchToolBar").kendoToolBar({
        items: [
            { template: "<button id='pbAddBranchToUser' type='button' class='k-button' title='Додати відділення'><i class='pf-icon pf-16 pf-ok'></i></button>" },
            { template: "<button id='pbRefreshBranchGrid' type='button' class='k-button' title='Оновити дані таблиці'><i class='pf-icon pf-16 pf-reload_rotate'></i></button>" },
            { template: "<button id='pbCloseWin' type='button' class='k-button' title='Завершити'><i class='pf-icon pf-16 pf-delete'></i></button>" }
        ]
    });


    function refreshBranchGrid() {
        $("#branchGrid").data("kendoTreeList").dataSource.read();
    }

    function closeBranchWindow() {
        $("#branchWindow").data("kendoWindow").close();
    }

    // ***
    function setBranchToUser() {
        var tv = $('#branchGrid').data('kendoTreeList'),
        selected = tv.select(),
        item = tv.dataItem(selected);
        if (item != null) {

            $("#branchId").val(item.BRANCH);
            $("#branchName").val(item.NAME);
            $("#branchWindow").data("kendoWindow").close();

            // Todo: set same branch in tab-branches
            /*
            var treeList = $("#treelist").data("kendoTreeList"),
                arr = treeList.tbody.find("input"),
                arrlength = treeList.tbody.find("input").length,
                i = 0;
            for (i; i < arrlength; i++) {
                arr[i].checked = false;
                arr[i].disabled = false;
                if (arr[i].getAttribute("data-branch") === item.BRANCH) {
                    arr[i].checked = true;
                    arr[i].disabled = true;
                    treeExcelLikeClick("#treelist", arr[i], true);
                }
            }
            */
        }
    }

    $("#pbAddBranchToUser").kendoButton({
        click: setBranchToUser
    });
    $("#pbRefreshBranchGrid").kendoButton({
        click: refreshBranchGrid
    });
    $("#pbCloseWin").kendoButton({
        click: closeBranchWindow
    });


    // treeList of tab: Доступні braches

    var dataSource = new kendo.data.TreeListDataSource({
        transport: {
            read: {
                url: bars.config.urlContent("/admin/admu/GetBranchLookups"),
                dataType: "json"
            }
        },
        schema: {
            data: "Data",
            model: {
                id: "BRANCH",
                parentId: "PARENT_BRANCH",
                fields: {
                    BRANCH: { type: "string", nullable: false },
                    PARENT_BRANCH: { field: "PARENT_BRANCH", nullable: true }
                }
            }
        }
    });

    $("#treelist").kendoTreeList({
        //autoBind: false,
        height: 400,
        dataSource: dataSource,
        selectable: "row",
        columns: [
            { field: "BRANCH", expandable: true, title: "BRANCH", width:"90%" },
            //{ field: "NAME", title: "Name", width: "45%" },
            //{ field: "PARENT_BRANCH" },
            //{ field: "HAS_CHILD" },
            {
                template: "<input type='checkbox' class='add-branch' data-bind='checked' data-branch='#=BRANCH#'/>", width: "10%"
            }
        ],
        dataBound: function () {
            $("#treelist .add-branch").unbind("click").on("click", function () {
                treeExcelLikeClick('#treelist', this);
            });
        }
    });

    function setEditDefaultSelectedBranch() {
        var grid = $("#editBranchGrid").data("kendoGrid");
        if (grid != null) {
            grid.select("tr:eq(1)");
        }
    }

    $("#branchGrid").kendoTreeList({
        selectable: "row",
        height: 440,
        sortable: true,
        pageable: {
            refresh: true
        },
        columns: [{ field: "BRANCH", expandable: true, title: "BRANCH", width: "100%" }],
        dataSource: dataSource,
        dataBound: setDefaultSelectedBranch
    });

    $("#editBranchGrid").kendoTreeList({
        selectable: "row",
        height: 440,
        sortable: true,
        pageable: {
            refresh: true
        },
        columns: [{ field: "BRANCH", expandable: true, title: "BRANCH", width: "100%" }],
        dataSource: dataSource,
        dataBound: setEditDefaultSelectedBranch
    });


    // Edit main Branch:
    $("#editBranchWindow").kendoWindow({
        width: "600px",
        height: "500px",
        title: "Доступні відділення",
        resizable: false,
        visible: false,
        actions: ["Close"]
    });



    $("#editBranchToolBar").kendoToolBar({
        items: [
            { template: "<button id='pbEditBranchToUser' type='button' class='k-button' title='Додати відділення'><i class='pf-icon pf-16 pf-ok'></i></button>" },
            { template: "<button id='pbRefreshEditBranchGrid' type='button' class='k-button' title='Оновити дані таблиці'><i class='pf-icon pf-16 pf-reload_rotate'></i></button>" },
            { template: "<button id='pbCloseEditWin' type='button' class='k-button' title='Завершити'><i class='pf-icon pf-16 pf-delete'></i></button>" }
        ]
    });


    function refreshEditBranchGrid() {
        $("#editBranchGrid").data("kendoTreeList").dataSource.read();
    }

    function closeEditBranchWindow() {
        $("#editBranchWindow").data("kendoWindow").close();
    }

   function setEditBranchToUser() {
        var tv = $('#editBranchGrid').data('kendoTreeList'),
       selected = tv.select(),
       item = tv.dataItem(selected);
        if (item != null) {
            $("#ed_branchId").val(item.BRANCH);
            $("#ed_branch").val(item.NAME);
            $("#editBranchWindow").data("kendoWindow").close();

            // Todo: set same branch in tab-branches
            /*
            var treeList = $("#edit-branch-treelist").data("kendoTreeList"),
                arr = treeList.tbody.find("input"),
                arrlength = treeList.tbody.find("input").length,
                i = 0;
            for (i; i < arrlength; i++) {
                if (arr[i].disabled === true && arr[i].getAttribute("data-branch") !== item.BRANCH) {
                    arr[i].disabled = false;
                    arr[i].checked = false;
                }
                if (arr[i].getAttribute("data-branch") === item.BRANCH) {
                    arr[i].checked = true;
                    arr[i].disabled = true;
                }
            }
            */
        }
    }

    $("#pbEditBranchToUser").kendoButton({
        click: setEditBranchToUser
    });
    $("#pbRefreshEditBranchGrid").kendoButton({
        click: refreshEditBranchGrid
    });
    $("#pbCloseEditWin").kendoButton({
        click: closeEditBranchWindow
    });

    // Edit all branches:

    $("#edit-branch-treelist").kendoTreeList({
        //autoBind: false,
        height: 400,
        dataSource: dataSource,
        selectable: "row",
        columns: [
            { field: "BRANCH", expandable: true, title: "BRANCH", width: "90%" },
            //{ field: "NAME", title: "Name", width: "45%" },
            //{ field: "PARENT_BRANCH" },
            //{ field: "HAS_CHILD" },
            {
                template: "<input type='checkbox' class='add-branch' data-bind='checked' data-branch='#=BRANCH#'/>", width: "10%"
            }
        ],
        dataBound: function () {
            $("#edit-branch-treelist .add-branch").unbind("click").on("click", function () {
                treeExcelLikeClick('#edit-branch-treelist', this);
            });
        }
    });
});