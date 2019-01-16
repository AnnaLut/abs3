// http://afuchs.tumblr.com/post/23550124774/datenow-in-ie8
Date.now = Date.now || function() { return +new Date; };

///*** GLOBALS
var PAGE_INITIAL_COUNT = 10;
var PAGEABLE = {
	refresh: true,
		messages: {
		empty: "Дані відсутні",
			allPages: "Всі"
	},
	pageSizes: [PAGE_INITIAL_COUNT, 50, 200, 1000, "All"],
		buttonCount: 5
};

var g_dataMainInited = false;
var g_MainInited = false;
var g_selectedGridMainId = null;
var g_dateStart = null;
var g_dateEnd = null;
var g_deal = { p_fileid: null,	project: null,	p_card_code: null,	p_branch: null,	p_isp: null, p_proect_id: null };

var IS_DEBUG = false;
function print(o) {	if(IS_DEBUG){console.log(o);}}

var REFER_SETTINGS = {
	BRANCHES_REF: {
		tabName: "V_USER_BRANCHES",
		whereClause: function () { return 'where date_closed is null'; },
		fields: "BRANCH,NAME",		//fields for show
		uiElem: "#edtBranchValue",	// ui elem with value
		deal: "p_branch",			// key name in g_deal
		deal_field: "BRANCH"		// field name in 'tabName'
	},
	STAFF_REF: {
		tabName: "STAFF",
		whereClause: function () { return "where BRANCH = '" + g_deal[REFER_SETTINGS['BRANCHES_REF'].deal] + "'"; },
		fields: "FIO,LOGNAME,ID",
		uiElem: "#edtStaffValue",
		deal: "p_isp",
		deal_field: "ID"
	},
	PRODUCTGRP_REF: {
		tabName: "V_W4_PRODUCTGRP_BATCH",
		whereClause: function () { return ''; },
		fields: "CODE,NAME",
		uiElem: "#edtProdValue",
		deal: "p_fileid",
		deal_field: "CODE"
	},
	PROJECT_REF: {
		tabName: ["V_BPK_PROECT_BATCH", "V_W4_PRODUCT_BATCH"],
		whereClause: function () { return "WHERE GRP_CODE ='" + g_deal[REFER_SETTINGS['PRODUCTGRP_REF'].deal] + "'";},
		fields: ["PRODUCT_CODE,PRODUCT_NAME,NAME", "CODE,NAME"],
		uiElem: "#edtProjectValue",
		deal: "project",
		deal_field: ["PRODUCT_CODE", "CODE"]
	},
	CARD_REF: {
		tabName: "V_W4_CARD_BATCH",
		whereClause: function () { return "WHERE PRODUCT_CODE ='" + g_deal[REFER_SETTINGS['PROJECT_REF'].deal] + "'"; },
		fields: "CODE,PRODUCT_CODE,SUB_CODE,SUB_NAME",
		uiElem: "#edtCardValue",
		deal: "p_card_code",
		deal_field: "CODE"
	}
};
///***

function updateMainGrid() {
    var grid = $("#gridMain").data("kendoGrid");
    if (grid){grid.dataSource.fetch();}
}

function initMainGrid() {
    Waiting(true);

    fillKendoGrid("#gridMain", {
        type: "webapi",
        sort: [ { field: "ID", dir: "desc" } ],
        transport: { read: { 
        	url: bars.config.urlContent("/api/BatchOpeningCardAccounts/BatchOpeningCardAccounts/SearchMain"),
			data: function () {
				return {dateStart: g_dateStart, dateEnd: g_dateEnd};
			}
        } },
		pageSize: PAGE_INITIAL_COUNT,
        schema: {
			model: {
				fields: {
					ID: { type: 'number' },
					FILE_NAME: { type: 'string' },
					ZIPFILE_NAME: { type: 'string' },
					FILE_DATE: { type: 'date' },
					CARD_CODE: { type: 'string' },
					BRANCH: { type: 'string' },
					ISP: { type: 'number' },
					PROECT_ID: { type: 'number' },
					FILE_N: { type: 'number' },
					FILE_TYPE: { type: 'number' },
					STATE: { type: 'number' },
					KF: { type: 'string' }
				}
			}
		}
    }, {
        pageable: PAGEABLE,
		filterMenuInit: function (e) { e.container.addClass("widerMenu"); },        // resize filter menu
        reorderable: true,
        change: function () {
            var grid = this;
			var row = grid.dataItem(grid.select());
			g_selectedGridMainId = row.ID;

			$("#FireBtn").prop('disabled', parseInt(row.STATE) < 3);
			$("#GetKvitBtn").prop('disabled', parseInt(row.STATE) != 10);

			if(g_dataMainInited){
				updateDataGrid();
			}
			else {
				g_dataMainInited = true;
				initDataGrid();
			}
        },
		dataBound: function(e) {
			Waiting(false);

			var grid = this;
			var doc_h = $(document).height();
			var h = 24*doc_h/100;
			$('#gridMain .k-grid-content').height(h);

			var data = grid.dataSource.data();
			$.each(data, function (i, row) {
				$('tr[data-uid="' + row.uid + '"] ').css("background-color", "");
				if (parseInt(row.STATE) < 3){
					$('tr[data-uid="' + row.uid + '"] ').css("background-color", "rgb(255,0,0)");
				}
				else if(parseInt(row.STATE) == 3){
					$('tr[data-uid="' + row.uid + '"] ').css("background-color", "rgb(0,255,0)");
				}
			});
		},
		columns: [
			{
				field: "ID",
				title: "ID",
				width: "10%"
			},
			{
				field: "FILE_NAME",
				title: "FILE_NAME",
				width: "10%"
			},
			{
				field: "ZIPFILE_NAME",
				title: "ZIPFILE_NAME",
				width: "10%"
			},
			{
				template: "<div style='text-align:center;'>#=(FILE_DATE == null) ? ' ' : kendo.toString(FILE_DATE,'dd.MM.yyyy')#</div>",
				field: "FILE_DATE",
				title: "FILE_DATE",
				width: "10%"
			},
			{
				field: "CARD_CODE",
				title: "CARD_CODE",
				width: "10%"
			},
			{
				field: "BRANCH",
				title: "BRANCH",
				width: "10%"
			},
			{
				field: "ISP",
				title: "ISP",
				width: "10%"
			},
			{
				field: "PROECT_ID",
				title: "PROECT_ID",
				width: "10%"
			},
			{
				field: "FILE_N",
				title: "FILE_N",
				width: "10%"
			},
			{
				field: "FILE_TYPE",
				title: "FILE_TYPE",
				width: "10%"
			},
			{
				field: "STATE",
				title: "STATE",
				width: "10%"
			},
			{
				field: "KF",
				title: "KF",
				width: "10%"
			}
		]
    }, null, null);
}

function updateDataGrid() {
	var grid = $("#dataMain").data("kendoGrid");
	if (grid){grid.dataSource.fetch();}
}

function initDataGrid() {
	Waiting(true);

	fillKendoGrid("#dataMain", {
		type: "webapi",
		//sort: [ { field: "ID", dir: "desc" } ],
		transport: { read: { 
			url: bars.config.urlContent("/api/BatchOpeningCardAccounts/BatchOpeningCardAccounts/SearchData")
			,data: function () { return {Id: g_selectedGridMainId}; }
		} },
		pageSize: PAGE_INITIAL_COUNT,
		schema: {
			model: {
				fields: {
					ID: { type: 'number' },
					IDN: { type: 'number' },
					OKPO: { type: 'string' },
					FIRST_NAME: { type: 'string' },
					LAST_NAME: { type: 'string' },
					MIDDLE_NAME: { type: 'string' },
					TYPE_DOC: { type: 'number' },
					PASPSERIES: { type: 'string' },
					PASPNUM: { type: 'string' },
					PASPISSUER: { type: 'string' },
					PASPDATE: { type: 'date' },
					BDAY: { type: 'date' },
					COUNTRY: { type: 'string' },
					RESIDENT: { type: 'string' },
					GENDER: { type: 'string' },
					PHONE_HOME: { type: 'string' },
					PHONE_MOB: { type: 'string' },
					EMAIL: { type: 'string' },
					ENG_FIRST_NAME: { type: 'string' },
					ENG_LAST_NAME: { type: 'string' },
					MNAME: { type: 'string' },
					ADDR1_CITYNAME: { type: 'string' },
					ADDR1_PCODE: { type: 'string' },
					ADDR1_DOMAIN: { type: 'string' },
					ADDR1_REGION: { type: 'string' },
					ADDR1_STREET: { type: 'string' },
					ADDR1_STREETTYPE: { type: 'number' },
					ADDR1_STREETNAME: { type: 'string' },
					ADDR1_BUD: { type: 'string' },
					REGION_ID1: { type: 'number' },
					AREA_ID1: { type: 'number' },
					SETTLEMENT_ID1: { type: 'number' },
					STREET_ID1: { type: 'number' },
					HOUSE_ID1: { type: 'number' },
					ADDR2_CITYNAME: { type: 'string' },
					ADDR2_PCODE: { type: 'string' },
					ADDR2_DOMAIN: { type: 'string' },
					ADDR2_REGION: { type: 'string' },
					ADDR2_STREET: { type: 'string' },
					ADDR2_STREETTYPE: { type: 'number' },
					ADDR2_STREETNAME: { type: 'string' },
					ADDR2_BUD: { type: 'string' },
					REGION_ID2: { type: 'number' },
					AREA_ID2: { type: 'number' },
					SETTLEMENT_ID2: { type: 'number' },
					STREET_ID2: { type: 'number' },
					HOUSE_ID2: { type: 'number' },
					WORK: { type: 'string' },
					OFFICE: { type: 'string' },
					DATE_W: { type: 'date' },
					OKPO_W: { type: 'string' },
					PERS_CAT: { type: 'string' },
					AVER_SUM: { type: 'number' },
					TABN: { type: 'string' },
					STR_ERR: { type: 'string' },
					RNK: { type: 'number' },
					ND: { type: 'number' },
					FLAG_OPEN: { type: 'number' },
					ACC_INSTANT: { type: 'number' },
					KK_SECRET_WORD: { type: 'string' },
					KK_REGTYPE: { type: 'number' },
					KK_CITYAREAID: { type: 'number' },
					KK_STREETTYPEID: { type: 'number' },
					KK_STREETNAME: { type: 'string' },
					KK_APARTMENT: { type: 'string' },
					KK_POSTCODE: { type: 'string' },
					MAX_TERM: { type: 'number' },
					PASP_END_DATE: { type: 'date' },
					PASP_EDDRID_ID: { type: 'string' },
					KF: { type: 'string' }
				}
			}
		}
	}, {
		pageable: PAGEABLE,
		filterMenuInit: function (e) { e.container.addClass("widerMenu"); },        // resize filter menu
		reorderable: true,
		change: function () {
			var grid = this;
			if (grid)
				var row = grid.dataItem(grid.select());
		},
		columns: [
			{
				field: "ID",
				title: "ID",
				width: 100
			},
			{
				field: "IDN",
				title: "IDN",
				width: 100
			},
			{
				field: "OKPO",
				title: "OKPO",
				width: 100
			},
			{
				field: "FIRST_NAME",
				title: "FIRST_NAME",
				width: 100
			},
			{
				field: "LAST_NAME",
				title: "LAST_NAME",
				width: 100
			},
			{
				field: "MIDDLE_NAME",
				title: "MIDDLE_NAME",
				width: 100
			},
			{
				field: "TYPE_DOC",
				title: "TYPE_DOC",
				width: 100
			},
			{
				field: "PASPSERIES",
				title: "PASPSERIES",
				width: 100
			},
			{
				field: "PASPNUM",
				title: "PASPNUM",
				width: 100
			},
			{
				field: "PASPISSUER",
				title: "PASPISSUER",
				width: 100
			},
			{
				template: "<div style='text-align:center;'>#=(PASPDATE == null) ? ' ' : kendo.toString(PASPDATE,'dd.MM.yyyy')#</div>",
				field: "PASPDATE",
				title: "PASPDATE",
				width: 100
			},
			{
				template: "<div style='text-align:center;'>#=(BDAY == null) ? ' ' : kendo.toString(BDAY,'dd.MM.yyyy')#</div>",
				field: "BDAY",
				title: "BDAY",
				width: 100
			},
			{
				field: "COUNTRY",
				title: "COUNTRY",
				width: 100
			},
			{
				field: "RESIDENT",
				title: "RESIDENT",
				width: 100
			},
			{
				field: "GENDER",
				title: "GENDER",
				width: 100
			},
			{
				field: "PHONE_HOME",
				title: "PHONE_HOME",
				width: 100
			},
			{
				field: "PHONE_MOB",
				title: "PHONE_MOB",
				width: 100
			},
			{
				field: "EMAIL",
				title: "EMAIL",
				width: 100
			},
			{
				field: "ENG_FIRST_NAME",
				title: "ENG_FIRST_NAME",
				width: 100
			},
			{
				field: "ENG_LAST_NAME",
				title: "ENG_LAST_NAME",
				width: 100
			},
			{
				field: "MNAME",
				title: "MNAME",
				width: 100
			},
			{
				field: "ADDR1_CITYNAME",
				title: "ADDR1_CITYNAME",
				width: 100
			},
			{
				field: "ADDR1_PCODE",
				title: "ADDR1_PCODE",
				width: 100
			},
			{
				field: "ADDR1_DOMAIN",
				title: "ADDR1_DOMAIN",
				width: 100
			},
			{
				field: "ADDR1_REGION",
				title: "ADDR1_REGION",
				width: 100
			},
			{
				field: "ADDR1_STREET",
				title: "ADDR1_STREET",
				width: 100
			},
			{
				field: "ADDR1_STREETTYPE",
				title: "ADDR1_STREETTYPE",
				width: 100
			},
			{
				field: "ADDR1_STREETNAME",
				title: "ADDR1_STREETNAME",
				width: 100
			},
			{
				field: "ADDR1_BUD",
				title: "ADDR1_BUD",
				width: 100
			},
			{
				field: "REGION_ID1",
				title: "REGION_ID1",
				width: 100
			},
			{
				field: "AREA_ID1",
				title: "AREA_ID1",
				width: 100
			},
			{
				field: "SETTLEMENT_ID1",
				title: "SETTLEMENT_ID1",
				width: 100
			},
			{
				field: "STREET_ID1",
				title: "STREET_ID1",
				width: 100
			},
			{
				field: "HOUSE_ID1",
				title: "HOUSE_ID1",
				width: 100
			},
			{
				field: "ADDR2_CITYNAME",
				title: "ADDR2_CITYNAME",
				width: 100
			},
			{
				field: "ADDR2_PCODE",
				title: "ADDR2_PCODE",
				width: 100
			},
			{
				field: "ADDR2_DOMAIN",
				title: "ADDR2_DOMAIN",
				width: 100
			},
			{
				field: "ADDR2_REGION",
				title: "ADDR2_REGION",
				width: 100
			},
			{
				field: "ADDR2_STREET",
				title: "ADDR2_STREET",
				width: 100
			},
			{
				field: "ADDR2_STREETTYPE",
				title: "ADDR2_STREETTYPE",
				width: 100
			},
			{
				field: "ADDR2_STREETNAME",
				title: "ADDR2_STREETNAME",
				width: 100
			},
			{
				field: "ADDR2_BUD",
				title: "ADDR2_BUD",
				width: 100
			},
			{
				field: "REGION_ID2",
				title: "REGION_ID2",
				width: 100
			},
			{
				field: "AREA_ID2",
				title: "AREA_ID2",
				width: 100
			},
			{
				field: "SETTLEMENT_ID2",
				title: "SETTLEMENT_ID2",
				width: 100
			},
			{
				field: "STREET_ID2",
				title: "STREET_ID2",
				width: 100
			},
			{
				field: "HOUSE_ID2",
				title: "HOUSE_ID2",
				width: 100
			},
			{
				field: "WORK",
				title: "WORK",
				width: 100
			},
			{
				field: "OFFICE",
				title: "OFFICE",
				width: 100
			},
			{
				template: "<div style='text-align:center;'>#=(DATE_W == null) ? ' ' : kendo.toString(DATE_W,'dd.MM.yyyy')#</div>",
				field: "DATE_W",
				title: "DATE_W",
				width: 100
			},
			{
				field: "OKPO_W",
				title: "OKPO_W",
				width: 100
			},
			{
				field: "PERS_CAT",
				title: "PERS_CAT",
				width: 100
			},
			{
				field: "AVER_SUM",
				title: "AVER_SUM",
				width: 100
			},
			{
				field: "TABN",
				title: "TABN",
				width: 100
			},
			{
				field: "STR_ERR",
				title: "STR_ERR",
				width: 100
			},
			{
				field: "RNK",
				title: "RNK",
				width: 100
			},
			{
				field: "ND",
				title: "ND",
				width: 100
			},
			{
				field: "FLAG_OPEN",
				title: "FLAG_OPEN",
				width: 100
			},
			{
				field: "ACC_INSTANT",
				title: "ACC_INSTANT",
				width: 100
			},
			{
				field: "KK_SECRET_WORD",
				title: "KK_SECRET_WORD",
				width: 100
			},
			{
				field: "KK_REGTYPE",
				title: "KK_REGTYPE",
				width: 100
			},
			{
				field: "KK_CITYAREAID",
				title: "KK_CITYAREAID",
				width: 100
			},
			{
				field: "KK_STREETTYPEID",
				title: "KK_STREETTYPEID",
				width: 100
			},
			{
				field: "KK_STREETNAME",
				title: "KK_STREETNAME",
				width: 100
			},
			{
				field: "KK_APARTMENT",
				title: "KK_APARTMENT",
				width: 100
			},
			{
				field: "KK_POSTCODE",
				title: "KK_POSTCODE",
				width: 100
			},
			{
				field: "MAX_TERM",
				title: "MAX_TERM",
				width: 100
			},
			{
				template: "<div style='text-align:center;'>#=(PASP_END_DATE == null) ? ' ' : kendo.toString(PASP_END_DATE,'dd.MM.yyyy')#</div>",
				field: "PASP_END_DATE",
				title: "PASP_END_DATE",
				width: 100
			},
			{
				field: "PASP_EDDRID_ID",
				title: "PASP_EDDRID_ID",
				width: 100
			},
			{
				field: "KF",
				title: "KF",
				width: 100
			}
		]
	}, null, null);
}

function Search() {
	var dateStart = $('#startDate');
	var dateEnd = $('#endDate');
	g_dateStart = kendo.toString(dateStart.data('kendoMaskedDatePicker').value(), 'dd.MM.yyyy');
	g_dateEnd = kendo.toString(dateEnd.data('kendoMaskedDatePicker').value(), 'dd.MM.yyyy');
	if(g_MainInited){
		updateMainGrid();
	}
	else{
		g_MainInited = true;
		initMainGrid();
	}
}

function Load() {
	$("#dialogLoad").data('kendoWindow').center().open();
}

function prepareProcessing() {
	uiEnabled(["BRANCHES_REF"], true);
	uiEnabled(["PRODUCTGRP_REF"], true);

	var checkNullArr = ["STAFF_REF", "PROJECT_REF", "CARD_REF"];
	for(var i = 0; i < checkNullArr.length; i++ ){
		uiEnabled([checkNullArr[i]], g_deal[REFER_SETTINGS[checkNullArr[i]].deal] != null);
	}
}

function uiEnabled(kArr, isEnabled) {
	for(var i = 0; i < kArr.length; i++){
		var uiEl = REFER_SETTINGS[kArr[i]].uiElem;
		uiEl = uiEl.substr(0, uiEl.indexOf("Value"));
		$(uiEl).prop('disabled', !isEnabled);
	}
}

function clearRefer(kArr) {
	for(var i = 0; i < kArr.length; i++){
		var k = kArr[i];
		g_deal[REFER_SETTINGS[k].deal] = null;
		$(REFER_SETTINGS[k].uiElem).text("");
	}
}

function reFillRefer(ID) {
	switch (ID){
		case "BRANCHES_REF":
			clearRefer(["STAFF_REF"]);
			uiEnabled(["STAFF_REF"], true);
			break;
		case "STAFF_REF":
			break;
		case "PRODUCTGRP_REF":
			clearRefer(["PROJECT_REF", "CARD_REF"]);
			uiEnabled(["CARD_REF"], false);
			uiEnabled(["PROJECT_REF"], true);
			break;
		case "PROJECT_REF":
			clearRefer(["CARD_REF"]);
			uiEnabled(["CARD_REF"], true);
			break;
	}
}

function showRefer(ID) {
	var tabName = REFER_SETTINGS[ID].tabName;
	var fields = REFER_SETTINGS[ID].fields;
	var deal_field = REFER_SETTINGS[ID].deal_field;
	if(ID == "PROJECT_REF"){
		var isSal = g_deal[REFER_SETTINGS['PRODUCTGRP_REF'].deal] == "SALARY";
		tabName = isSal ? tabName[0] : tabName[1];
		fields = isSal ? fields[0] : fields[1];
		deal_field = isSal ? deal_field[0] : deal_field[1];
	}

	bars.ui.handBook(tabName, function (data) {
		var val = data[0][fields.split(",")[0]];
		var deal_val = data[0][deal_field];
		if(val != g_deal[REFER_SETTINGS[ID].deal]){
			$(REFER_SETTINGS[ID].uiElem).text(val);
			g_deal[REFER_SETTINGS[ID].deal] = deal_val;

			// hack for Vitalik. Need save ID field for SALARY
			if(ID == "PROJECT_REF"){
				g_deal['p_proect_id'] = g_deal[REFER_SETTINGS['PRODUCTGRP_REF'].deal] == "SALARY" ? data[0].ID : null;
			}

			reFillRefer(ID);
			print(g_deal);
		}
	},
	{
		multiSelect: false,
		clause: REFER_SETTINGS[ID].whereClause(),
		columns: fields
	});
}

function FireConfirm() {
	for(var k in g_deal){
		if(g_deal[k] == null && k != 'p_proect_id'){	// p_proect_id skip
			bars.ui.error({ title: 'Помилка', text: "Деякі парметри не визначено" });
			return;
		}
	}

	kendo.ui.progress($(".search-proc"), true);
	AJAX({ srcSettings: {
		url: bars.config.urlContent("/api/BatchOpeningCardAccounts/BatchOpeningCardAccounts/ProcessingFile"),
		success: function (data) {
			$("#dialogProcessing").data('kendoWindow').close();
			updateMainGrid();
			bars.ui.notify("До відома", "Файл оброблено", 'info', {autoHideAfter: 5*1000});
		},
		complete: function(jqXHR, textStatus){ kendo.ui.progress($(".search-proc"), false); }
		,data: JSON.stringify({
			p_fileid: g_selectedGridMainId,
			p_proect_id: g_deal['p_proect_id'],	// not null - SALARY		null - PENSION, SOCIAL
			p_card_code: g_deal['p_card_code'],
			p_branch: g_deal['p_branch'],
			p_isp: g_deal['p_isp']
		})
	} });
}

function GetKvit() {
	if(g_selectedGridMainId == null){
		bars.ui.notify("Помилка", "Файл не обрано", 'error', {autoHideAfter: 5*1000});
		return;
	}
	window.location = bars.config.urlContent('/api/BatchOpeningCardAccounts/BatchOpeningCardAccounts/FormTicket?p_fileid='+g_selectedGridMainId);
}

function Fire() {
	if(g_selectedGridMainId == null){
		bars.ui.notify("Помилка", "Файл не обрано", 'error', {autoHideAfter: 5*1000});
		return;
	}

	$("#dialogProcessing").data('kendoWindow').center().open();
}

function getFiletype() {
	fillDropDownList("#filetype", {
		transport: {read: { url: bars.config.urlContent("/api/BatchOpeningCardAccounts/BatchOpeningCardAccounts/FileTypes") }},
		schema: {model: {fields: { ID: { type: "number" }, DESCR: { type: "string" } }}}
	}, {
		//optionLabel: " ",
		dataTextField: "DESCR",
		dataValueField: "ID",
		filter: "contains"
	});
}

$(document).ready(function () {
	$("#title").html("Пакетне відкриття карткових рахунків");

	$("#startDate").kendoMaskedDatePicker({ format: "dd/MM/yyyy", value: new Date(2000, 0, 1) });
	$("#endDate").kendoMaskedDatePicker({ format: "dd/MM/yyyy", value: new Date(Date.now()) });

	$('#SearchBtn').click(Search);
	$('#LoadBtn').click(Load);
	$('#FireBtn').click(Fire);
	$('#GetKvitBtn').click(GetKvit);
	$('#FireConfirmBtn').click(FireConfirm);

	InitGridWindow({windowID: "#dialogLoad", srcSettings: {title: "Завантаження файлу", open: getFiletype}});
	InitGridWindow({windowID: "#dialogProcessing", srcSettings: {title: "Обробка файлу", open: prepareProcessing}});

	// $("#load_file").kendoUpload({
	// 	upload: function (e) {
	// 		e.data = {filetype: $("#filetype").data("kendoDropDownList").value()};
	// 	},
	// 	localization: {
	// 		select: "Виберіть файл (розширення zip)",
	// 		headerStatusUploading: "",
	// 		headerStatusUploaded: ""
	// 	},
	// 	async: {
	// 		autoUpload: true,
	// 		saveUrl: bars.config.urlContent("/api/BatchOpeningCardAccounts/BatchOpeningCardAccounts/LoadFile")
	// 	},
	// 	showFileList: true,
	// 	multiple: false,
	// 	error: function (e) {
	// 		var error = e.XMLHttpRequest.responseText;
	// 		bars.ui.notify("Помилка завантаження", error, 'error', {autoHideAfter: 5*1000});
	// 	},
	// 	success: function (e) {
	// 		$("#dialogLoad").data('kendoWindow').close();
	// 		bars.ui.notify("До відома", "Файл успішно завантажено", 'info', {autoHideAfter: 5*1000});
	// 	}
	// });
});