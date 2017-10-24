angular.module('BarsWeb.Controllers')
    .controller('CommunicationObjectCtrl',
        function () {

            var vm = this;

            vm.model = {};
            vm.model.id = '';

            vm.commObjGridDataSource = new kendo.data.DataSource({
                type: 'aspnetmvc-ajax',
                serverPaging: true,
                serverSorting: true,
                serverFiltering: true,
                pageSize: 10,
                transport: {
                    read: {
                        type: "GET",
                        contentType: "application/json",
                        url: bars.config.urlContent("Admin/CommunicationObject/GetCommObjGrid"),
                        data: function () {
                            var parametrs = {
                                id: vm.model.id
                            };
                            return parametrs;
                        },
                        dataType: 'json',
                        cache: false
                    }
                },
                schema: {
                    data: "Data",
                    total: "Total",
                    model: {
                        fields: {
                            idWhom: { type: "string" },
                            objNameWhom: { type: "string" },
                            idWhat: { type: "string" },
                            objNameWhat: { type: "string" }
                        }
                    }
                }
            });

            vm.commObjGridOptions = {
                autoBind: false,
                dataSource: vm.commObjGridDataSource,
                sortable: true,
                filterable: true,
                pageable: {
                    pageSizes: [10, 20, 50, 100, 200],
                    buttonCount: 3,
                },
                columns: [
                    {
                        field: "idWhom",
                        title: "Код об'єкта <br> (Кому, куди видано)",
                        width: "15%",
                        headerAttributes: {
                            style: "text-align: center;"
                        }
                    },
                    {
                        field: "objNameWhom",
                        title: "Найменування об'єкта <br> (Кому, куди видано)",
                        width: "35%",
                        headerAttributes: {
                            style: "text-align: center;"
                        }
                    },
                    {
                        field: "idWhat",
                        title: "Код об'єкта <br> (Що видано)",
                        width: "15%",
                        headerAttributes: {
                            style: "text-align: center;"
                        }
                    },
                    {
                        field: "objNameWhat",
                        title: "Найменування об'єкта <br> (Що видано)",
                        width: "35%",
                        headerAttributes: {
                            style: "text-align: center;"
                        }
                    }
                ]
            };


            vm.commObjDataSource = {
                transport: {
                    read: {
                        type: "GET",
                        url: bars.config.urlContent("Admin/CommunicationObject/GetDropDownCommObj")
                    }
                }
            };

            vm.commObjDropDownOptions = {
                autoBind: false,
                select: function (e) {
                    var item = e.item.index();
                    vm.commObjGridDataSource.read({ filter: vm.commObjGridDataSource.filter({}), sort: vm.commObjGridDataSource.sort({}), id: item });
                    vm.model.id = item;
                }
            }
        });