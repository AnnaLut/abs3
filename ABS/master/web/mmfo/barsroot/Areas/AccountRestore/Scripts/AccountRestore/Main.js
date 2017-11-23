var mainApp = angular.module(globalSettings.modulesAreas);

mainApp.controller("CommonController", function ($scope){
    $scope.extend = function(src, dst) {
        for(var key in src){
            if(src[key] == null || src[key] instanceof Array || ["number", "boolean", "string", "function", "undefined"].indexOf(typeof src[key]) != -1){
                dst[key] = src[key];
            }
            else{
                if(!dst.hasOwnProperty(key)){ dst[key] = {}; }
                arguments.callee(src[key], dst[key]);
            }
        }
    };

    $scope.replaceAll = function(s, oldValue, newValue) {       // replaceAll("Hello world!", "o", "_")
        var newS = "";
        var i;
        var indexes = [];
        for(i = 0; i < s.length; i++){
            if(s[i] === oldValue){
                indexes.push(i);
            }
        }
        for(i = 0; i < s.length; i++){
            if(indexes.indexOf(i) != -1){
                newS += newValue;
            }
            else{
                newS += s[i];
            }
        }
        return newS;
    }
});

mainApp.controller("KendoMainController", function ($controller, $scope){
    $controller('CommonController', { $scope: $scope });     // Расширяем контроллер

    $scope.createDataSource = function (ds) {
        var _ds = {
            type: "aspnetmvc-ajax",
            pageSize: 12,
            serverPaging: true,
            serverFiltering: true,
            serverSorting: true,
            transport: {
                read: {
                    type: "GET",
                    dataType: "json",
                    url: ""
                }
            },
            requestStart: function () { bars.ui.loader("body", true); },
            requestEnd: function (e) { bars.ui.loader("body", false); },
            schema: {
                data: "Data",
                total: "Total",
                model: { fields: {} }
            }
        };

        $scope.extend(ds, _ds);

        return _ds;
    };

    $scope.createGridOptions = function (go) {
        var _go = {
            autoBind: true,
            resizable: true,
            selectable: "row",
            scrollable: true,
            sortable: true,
            pageable: {
                messages: {
                    allPages: "Всі"
                },
                refresh: true,
                pageSizes: [10, 50, 200, 1000, "All"],
                buttonCount: 5
            },
            filterMenuInit: function (e) { e.container.addClass("widerMenu"); },        // resize filter menu
            reorderable: true,
            change: function () {
                var grid = this;
                var row = grid.dataItem(grid.select());
            },

            columns: [ ],
            filterable: true
        };

        $scope.extend(go, _go);

        return _go;
    };
});

mainApp.controller("AccountRestoreCtrl", function ($controller, $scope) {
    $controller('KendoMainController', { $scope: $scope });     // Расширяем контроллер

	    $scope.Title = "";

        var mainDataSource = $scope.createDataSource({
            type: "webapi",
            transport: { read: { url: bars.config.urlContent("/api/AccountRestore/AccountRestore/SearchMain") } },
	    schema: {
			model: {
				fields: {
					ACC: { type: 'number' },
					KF: { type: 'string' },
					NLS: { type: 'string' },
					KV: { type: 'number' },
					BRANCH: { type: 'string' },
					NLSALT: { type: 'string' },
					NBS: { type: 'string' },
					NBS2: { type: 'string' },
					DAOS: { type: 'date' },
					DAPP: { type: 'date' },
					ISP: { type: 'number' },
					NMS: { type: 'string' },
					LIM: { type: 'number' },
					OSTB: { type: 'number' },
					OSTC: { type: 'number' },
					OSTF: { type: 'number' },
					OSTQ: { type: 'number' },
					DOS: { type: 'number' },
					KOS: { type: 'number' },
					DOSQ: { type: 'number' },
					KOSQ: { type: 'number' },
					PAP: { type: 'number' },
					TIP: { type: 'string' },
					VID: { type: 'number' },
					TRCN: { type: 'number' },
					MDATE: { type: 'date' },
					DAZS: { type: 'date' },
					SEC: { type: 'System.Byte[]' },
					ACCC: { type: 'number' },
					BLKD: { type: 'number' },
					BLKK: { type: 'number' },
					POS: { type: 'number' },
					SECI: { type: 'number' },
					SECO: { type: 'number' },
					GRP: { type: 'number' },
					OSTX: { type: 'number' },
					RNK: { type: 'number' },
					NOTIFIER_REF: { type: 'number' },
					TOBO: { type: 'string' },
					BDATE: { type: 'date' },
					OPT: { type: 'number' },
					OB22: { type: 'string' },
					DAPPQ: { type: 'date' },
					SEND_SMS: { type: 'string' },
					DAT_ALT: { type: 'date' }
				}
			}
		}
        });

        $scope.MainGridOptions = $scope.createGridOptions({
            dataSource: mainDataSource,
            columns: [
			{
				field: "ACC",
				title: "ACC",
				width: "10%"
			},
			{
				field: "KF",
				title: "KF",
				width: "10%"
			},
			{
				field: "NLS",
				title: "NLS",
				width: "10%"
			},
			{
				field: "KV",
				title: "KV",
				width: "10%"
			},
			{
				field: "BRANCH",
				title: "BRANCH",
				width: "10%"
			},
			{
				field: "NLSALT",
				title: "NLSALT",
				width: "10%"
			},
			{
				field: "NBS",
				title: "NBS",
				width: "10%"
			},
			{
				field: "NBS2",
				title: "NBS2",
				width: "10%"
			},
			{
				template: "<div style='text-align:center;'>#=(DAOS == null) ? ' ' : kendo.toString(DAOS,'dd.MM.yyyy')#</div>",
				field: "DAOS",
				title: "DAOS",
				width: "10%"
			},
			{
				template: "<div style='text-align:center;'>#=(DAPP == null) ? ' ' : kendo.toString(DAPP,'dd.MM.yyyy')#</div>",
				field: "DAPP",
				title: "DAPP",
				width: "10%"
			},
			{
				field: "ISP",
				title: "ISP",
				width: "10%"
			},
			{
				field: "NMS",
				title: "NMS",
				width: "10%"
			},
			{
				field: "LIM",
				title: "LIM",
				width: "10%"
			},
			{
				field: "OSTB",
				title: "OSTB",
				width: "10%"
			},
			{
				field: "OSTC",
				title: "OSTC",
				width: "10%"
			},
			{
				field: "OSTF",
				title: "OSTF",
				width: "10%"
			},
			{
				field: "OSTQ",
				title: "OSTQ",
				width: "10%"
			},
			{
				field: "DOS",
				title: "DOS",
				width: "10%"
			},
			{
				field: "KOS",
				title: "KOS",
				width: "10%"
			},
			{
				field: "DOSQ",
				title: "DOSQ",
				width: "10%"
			},
			{
				field: "KOSQ",
				title: "KOSQ",
				width: "10%"
			},
			{
				field: "PAP",
				title: "PAP",
				width: "10%"
			},
			{
				field: "TIP",
				title: "TIP",
				width: "10%"
			},
			{
				field: "VID",
				title: "VID",
				width: "10%"
			},
			{
				field: "TRCN",
				title: "TRCN",
				width: "10%"
			},
			{
				template: "<div style='text-align:center;'>#=(MDATE == null) ? ' ' : kendo.toString(MDATE,'dd.MM.yyyy')#</div>",
				field: "MDATE",
				title: "MDATE",
				width: "10%"
			},
			{
				template: "<div style='text-align:center;'>#=(DAZS == null) ? ' ' : kendo.toString(DAZS,'dd.MM.yyyy')#</div>",
				field: "DAZS",
				title: "DAZS",
				width: "10%"
			},
			{
				field: "SEC",
				title: "SEC",
				width: "10%"
			},
			{
				field: "ACCC",
				title: "ACCC",
				width: "10%"
			},
			{
				field: "BLKD",
				title: "BLKD",
				width: "10%"
			},
			{
				field: "BLKK",
				title: "BLKK",
				width: "10%"
			},
			{
				field: "POS",
				title: "POS",
				width: "10%"
			},
			{
				field: "SECI",
				title: "SECI",
				width: "10%"
			},
			{
				field: "SECO",
				title: "SECO",
				width: "10%"
			},
			{
				field: "GRP",
				title: "GRP",
				width: "10%"
			},
			{
				field: "OSTX",
				title: "OSTX",
				width: "10%"
			},
			{
				field: "RNK",
				title: "RNK",
				width: "10%"
			},
			{
				field: "NOTIFIER_REF",
				title: "NOTIFIER_REF",
				width: "10%"
			},
			{
				field: "TOBO",
				title: "TOBO",
				width: "10%"
			},
			{
				template: "<div style='text-align:center;'>#=(BDATE == null) ? ' ' : kendo.toString(BDATE,'dd.MM.yyyy')#</div>",
				field: "BDATE",
				title: "BDATE",
				width: "10%"
			},
			{
				field: "OPT",
				title: "OPT",
				width: "10%"
			},
			{
				field: "OB22",
				title: "OB22",
				width: "10%"
			},
			{
				template: "<div style='text-align:center;'>#=(DAPPQ == null) ? ' ' : kendo.toString(DAPPQ,'dd.MM.yyyy')#</div>",
				field: "DAPPQ",
				title: "DAPPQ",
				width: "10%"
			},
			{
				field: "SEND_SMS",
				title: "SEND_SMS",
				width: "10%"
			},
			{
				template: "<div style='text-align:center;'>#=(DAT_ALT == null) ? ' ' : kendo.toString(DAT_ALT,'dd.MM.yyyy')#</div>",
				field: "DAT_ALT",
				title: "DAT_ALT",
				width: "10%"
			}
		],

        });
});