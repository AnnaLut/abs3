///*** GLOBALS
var PAGE_INITIAL_COUNT = 10;
///***

function updateMainGrid() {
    var grid = $("#gridMain").data("kendoGrid");
    if (grid){grid.dataSource.fetch();}
} 

function initMainGrid() {
    Waiting(true);

    fillKendoGrid("#gridMain", {
        type: "webapi",
        //sort: [ { field: "ID", dir: "desc" } ],
        transport: { read: { url: bars.config.urlContent("/api/CustomerList/CustomerList/SearchMain") } },pageSize: PAGE_INITIAL_COUNT,
        schema: {
			model: {
				fields: {
					ACC: { type: 'number' },
					NLS: { type: 'string' },
					NLSALT: { type: 'string' },
					KV: { type: 'number' },
					LCV: { type: 'string' },
					DIG: { type: 'number' },
					DENOM: { type: 'number' },
					KF: { type: 'string' },
					BRANCH: { type: 'string' },
					TOBO: { type: 'string' },
					NBS: { type: 'string' },
					NBS2: { type: 'string' },
					DAOS: { type: 'date' },
					DAPP: { type: 'date' },
					ISP: { type: 'number' },
					RNK: { type: 'number' },
					NMS: { type: 'string' },
					LIM: { type: 'number' },
					OST: { type: 'number' },
					OSTB: { type: 'number' },
					OSTC: { type: 'number' },
					OSTF: { type: 'number' },
					OSTQ: { type: 'number' },
					OSTX: { type: 'number' },
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
					OB22: { type: 'string' },
					NOTIFIER_REF: { type: 'number' },
					BDATE: { type: 'date' },
					OPT: { type: 'number' },
					FIO: { type: 'string' }
				}
			}
		}
    }, {
        pageable: {
            refresh: true,
            messages: {
                empty: "Дані відсутні",
                allPages: "Всі"
            },
            pageSizes: [PAGE_INITIAL_COUNT, 50, 200, 1000, "All"],
            buttonCount: 5
        },
	filterMenuInit: function (e) { e.container.addClass("widerMenu"); },        // resize filter menu
        reorderable: true,
        change: function () {
            var grid = $('#gridMain').data("kendoGrid");
            if (grid)
                var row = grid.dataItem(grid.select());
        },
        columns: [
			{
				field: "ACC",
				title: "ACC",
				width: "10%"
			},
			{
				field: "NLS",
				title: "NLS",
				width: "10%"
			},
			{
				field: "NLSALT",
				title: "NLSALT",
				width: "10%"
			},
			{
				field: "KV",
				title: "KV",
				width: "10%"
			},
			{
				field: "LCV",
				title: "LCV",
				width: "10%"
			},
			{
				field: "DIG",
				title: "DIG",
				width: "10%"
			},
			{
				field: "DENOM",
				title: "DENOM",
				width: "10%"
			},
			{
				field: "KF",
				title: "KF",
				width: "10%"
			},
			{
				field: "BRANCH",
				title: "BRANCH",
				width: "10%"
			},
			{
				field: "TOBO",
				title: "TOBO",
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
				field: "RNK",
				title: "RNK",
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
				field: "OST",
				title: "OST",
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
				field: "OSTX",
				title: "OSTX",
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
				field: "OB22",
				title: "OB22",
				width: "10%"
			},
			{
				field: "NOTIFIER_REF",
				title: "NOTIFIER_REF",
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
				field: "FIO",
				title: "FIO",
				width: "10%"
			}
		],

    }, null, null);
}

$(document).ready(function () {
	$("#title").html("Підсумки");
	
   initMainGrid();
});