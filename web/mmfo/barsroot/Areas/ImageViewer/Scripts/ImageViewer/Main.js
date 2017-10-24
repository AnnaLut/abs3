var g_ImagesTypes = null;
var g_filterGrid = null;
var g_mainGridInited = false;
var g_ImagesTypesData = [
	{ text: "Всі", value: "" },
	{ text: "Фотокартка клієнта ФО", value: "PHOTO_JPG" },
	{ text: "Фото з веб-камери", value: "PHOTO_WEB" }
];
//****************************************************

function getImagesTypes() {
	if (g_ImagesTypes == null) {
		var dataSource = CreateKendoDataSource({
			transport: {read:{url: bars.config.urlContent("/api/imageviewer/imageviewertypes")}},
			schema: {model: {fields: {TYPE_IMG: { type: "string" }, NAME_IMG: { type: "string" }}}}
		});
		dataSource.fetch(function () {
			g_ImagesTypes = this.data();
		});
	}
}

function getDDNameById(id) {
	return getNameById(id, g_ImagesTypes, 'TYPE_IMG', 'NAME_IMG');
}

//async get photo from DB
function GetPhoto(rnk, image_type, successCallback) {
	Waiting(true);
	AJAX({ srcSettings: {
		url: bars.config.urlContent("/api/imageviewer/getphoto"),
		success: successCallback,
		error: function(jqXHR, textStatus, errorThrown){            //bars.ui.alert({ text: "ERROR" });
			Waiting(false);
		},
		data: JSON.stringify({rnk: rnk, image_type: image_type})
		//data: JSON.stringify({rnk: rnk, image_type: "PHOTO_JPG"})
	} });
}

function linkToKK(RNK) {
	return '<a href="#" onclick="OpenKK(\''+RNK+'\')" style="color: blue">' + RNK + '</a>';
}

function OpenKK(RNK) {
	if(RNK != null && RNK !== "null"){
		OpenBarsDialog("/barsroot/clientregister/registration.aspx?readonly=0&rnk=" + RNK);
	}
	else{ bars.ui.error({ title: 'Помилка', text: "Неправильний РНК!" }); }
}

function initMainGrid() {
    Waiting(true);

    fillKendoGrid("#gridMain", {
        type: "webapi",
        //sort: [ { field: "ID", dir: "desc" } ],
		pageSize: 10,
		transport: { read: {
				url: bars.config.urlContent("/api/imageviewer/searchmain"),
				// data: function () { return {type_img: "", date_img: new Date(2011, 0, 1)}; }
				data: function () { return g_filterGrid; }
        	}
        },
        schema: {
			model: {
				fields: {
					RNK: { type: "number" },
					OKPO: { type: "string" },
					NMK: { type: "string" },
					TYPE_IMG: { type: "string" },
					DATE_IMG: { type: "date" },
					ISP: {type: "string"}
				}
			}
		}
    }, {
		change: function () {
			var gview = $("#gridMain").data("kendoGrid");
			var selected = gview.dataItem(gview.select());
			if(selected){

				var data = gview.dataSource.data();
				$.each(data, function (i, row) {
					$('tr[data-uid="' + row.uid + '"] ').css("background-color", "");
					if (row.RNK == selected.RNK && row.uid != selected.uid)
						$('tr[data-uid="' + row.uid + '"] ').css("background-color", "rgb(193,234,247)");
				});

				GetPhoto(selected.RNK, selected.TYPE_IMG, function (data) {
					Waiting(false);
					if(data['Data']){
						$("#kkPhoto").show();
						$("#kkPhoto").attr('src', data['Data']);
					}
				});
			}
		},
		pageable: {
			refresh: true,
			pageSizes: [10, 50, 200, 1000, "Всі"],
			buttonCount: 5
		},
		columns: [
			{
				field: "RNK",
				title: "РНК",
				width: "10%",
				template: '#= linkToKK(RNK) #'
			 },
			{
				field: "OKPO",
				title: "ОКПО",
				width: "10%"
			 },
			{
				field: "NMK",
				title: "ПІБ",
				width: "20%"
			 },
			{
				field: "TYPE_IMG",
				title: "Тип фото",
				width: "10%",
				template: "#= getDDNameById(TYPE_IMG) #"
			 },
			{
				field: "DATE_IMG",
				title: "Дата фото",
				width: "10%",
				template: "<div style='text-align:center;'>#=(DATE_IMG == null) ? ' ' : kendo.toString(DATE_IMG,'dd.MM.yyyy')#</div>"
			 },
			{
				field: "ISP",
				title: "Відповідальний<br>працівник",
				width: "10%"
			}
		]
    }, null, null);
}

function Search() {
	var type_img = $("#searchImType").val();
	var searchDateStart = $("#searchDateStart").data("kendoDatePicker").value();
	var searchDateStartStr = kendo.toString(searchDateStart, "MM/dd/yyyy");
	var searchDateEnd = $("#searchDateEnd").data("kendoDatePicker").value();
	var searchDateEndStr = kendo.toString(searchDateEnd, "MM/dd/yyyy");
	g_filterGrid = { type_img: type_img, date_img_start: searchDateStartStr, date_img_end: searchDateEndStr };

	if(g_mainGridInited){
		var grid = $("#gridMain").data("kendoGrid");
		grid.dataSource.fetch();
	}
	else{
		g_mainGridInited = true;
		initMainGrid();
	}
}

function onChangeImType() {
	//var value = $("#searchImType").val();
}

$(document).ready(function () {
	$("#title").html("Перегляд фото клієнта");

	$("#searchDateStart").kendoDatePicker({ format: "dd.MM.yyyy" });
	$("#searchDateEnd").kendoDatePicker({ format: "dd.MM.yyyy" });

	var searchDateEnd = $("#searchDateEnd").data("kendoDatePicker");
	searchDateEnd.value(new Date());

	$("#searchImType").kendoDropDownList({
		dataTextField: "text",
		dataValueField: "value",
		dataSource: g_ImagesTypesData,
		index: 0,
		change: onChangeImType
	});

	getImagesTypes();

	$('#SearchBtn').click(Search);
});