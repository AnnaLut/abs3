var branchListCheckedRefresh = null;

$(document).ready(function () {
    // user card tabs init:
    $("#card-tabstrip").kendoTabStrip();
    var tabs = $("#card-tabstrip").kendoTabStrip().data("kendoTabStrip");
    $("#card-tabstrip").children(".t-content").height(500);
    tabs.select(0);

    // user branches:
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

    var dataSource = new kendo.data.TreeListDataSource({
        transport: {
            read: {
                type: "GET",
                url: bars.config.urlContent("/api/admin/UserCardBranches/"),
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

    $("#branches").kendoTreeList({
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
                template: "<input type='checkbox' disabled class='add-branch' data-bind='checked' data-branch='#=BRANCH#'/>", width: "10%"
            }
        ],
        dataBound: function () {
            $("#branches .add-branch").unbind("click").on("click", function () {
                treeExcelLikeClick('#branches', this);
            });
        }
    });

    function initBranchList(data) {
        var editTree = $("#branches").data("kendoTreeList"),
            //editTreeData = editTree.dataSource.view(),
            currentBranches = data.AdditionalBranches, 
            arr = editTree.tbody.find("input"),
            arrlength = editTree.tbody.find("input").length,
            i = 0;
        for (i; i < currentBranches.length; i++) {
            var j = 0;
            for (j; j < arrlength; j++) {
                if (arr[j].getAttribute("data-branch") === currentBranches[i]) {
                    if (arr[j].getAttribute("data-branch") === data.BranchCode) {
                        arr[j].checked = true;
                        arr[j].disabled = true;
                        branchListCheckedRefresh("#branches", arr[j], true);
                    } else {
                        arr[j].checked = true;
                        //arr[j].disabled = false; readonly
                    }
                }
            }
        }
    }

    // user roles:
    var userRolesDataSource = new kendo.data.DataSource({
        type: "aspnetmvc-ajax",
        serverPaging: false,
        serverFiltering: false,
        serverSorting: false,
        transport: {
            read: {
                type: "GET",
                url: bars.config.urlContent("/api/admin/UserCardRoles/"),
                data: { id: login }
            }
        },
        schema: {
            data: "Data",
            total: "Total",
            model: {
                fields: {
                    USER_ID: { type: "number" },
                    ROLE_NAME: { type: "string" },
                    ROLE_ID: { type: "number" },
                    ROLE_CODE: { type: "string" },
                    IS_GRANTED: { type: "number" },
                    IS_APPROVED: { type: "number" }
                }
            }
        }
    });

    $("#roles").kendoGrid({
        autoBind: false, // init after cardContent get result
        height: 400,
        dataSource: userRolesDataSource,
        selectable: "row",
        columns: [
            { field: "ROLE_CODE", expandable: true, title: "Код", width: "35%" },
            { field: "ROLE_NAME", title: "Назва ролі", width: "30%" },
            //{ field: "ROLE_ID", title: "ID Ролі", width: "10%" },
            {
                field: "IS_GRANTED",
                title: "Доступ",
                template: "<input type='checkbox' disabled data-bind='checked' #= IS_GRANTED === 1 ? checked='checked' : ''# data-selectrole='#=ROLE_ID#' />",
                width: "15%",
                filterable: false
            },
            { field: "IS_APPROVED", title: "Підтверджено", width: "20%", filterable: false }

        ],
        sortable: true,
        filterable: {
            mode: "row"
        }
    });

    var cardContent = function(login) {
        if (login) {
            $.ajax({
                type: "GET",
                url: bars.config.urlContent("/api/admin/UserCard/"),
                contentType: "application/json",
                dataType: "json",
                data: { id: login },
                traditional: true
            }).done(function(result) {
                var infoBox = $("#info-main"),
                    infoTemplate = kendo.template($("#Info").html()),
                    authBox = $("#info-auth"),
                    absTemplate = kendo.template($("#AuthMode-ABS").html()),
                    oraTemplate = kendo.template($("#AuthMode-ORA").html()),
                    adTemplate = kendo.template($("#AuthMode-AD").html()),
                    delegationBox = $("#info-delegation"),
                    delegationTemplate = kendo.template($("#Delegations").html()),
                    commentsBox = $("#info-comments"),
                    commentsTemplate = kendo.template($("#Comments").html()),
                    data = result;

                infoBox.html(infoTemplate(data));
                delegationBox.html(delegationTemplate(data));
                commentsBox.html(commentsTemplate(data));
                initBranchList(data);

                $("#roles").data("kendoGrid").dataSource.read();

                switch (data.AuthenticationModeCode) {
                    case "STAFF_USER_CBS":
                        authBox.html(absTemplate(data));
                        break;
                    case "STAFF_USER_ORA":
                        authBox.html(oraTemplate(data));
                        break;
                    case "STAFF_USER_AD":
                        authBox.html(adTemplate(data));
                        break;
                }
            });
        }
    }
    cardContent(login);
});