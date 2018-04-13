if (!('bars' in window)) window['bars'] = {};
bars.sepdocs = bars.sepdocs || {
	sepDocsGrid: null,

	getSepDocsGrid: function () {
	    var self = bars.sepdocs;
	    if (self.sepDocsGrid == null) {
	    	self.sepDocsGrid = $('#sepDocumentsGrid').data('kendoGrid');
        }
	    return self.sepDocsGrid;
	},

	refreshToolbar: function () {
		var grid = bars.sepdocs.getSepDocsGrid();
	    var selection = grid.select();
	    bars.utils.sep.enableButton('pbViewDoc', selection.length === 1);
	    bars.utils.sep.enableButton('pbRequest', selection.length > 0);
	},

    openDocByDblClick: function() {
        var grid = bars.sepdocs.getSepDocsGrid();
        var record = grid.dataItem($(this));
        bars.sepdocs.openDocByRow(record);
    },

	openDoc: function () {
	    var grid = bars.sepdocs.getSepDocsGrid();
		var record = grid.dataItem(grid.select());
		bars.sepdocs.openDocByRow(record);
	},

	openDocByRow: function (row) {
	    if (row.REF != null) {
	        var docUrl = bars.config.urlContent("/documents/item/" + row.REF + "/");
	        window.location = docUrl;
	    } else {
	        var sepDocViewer = bars.sepfiles.sepDocViewer;
	        var data = {
	            NAM_A: row.NAMB,
	            NAM_B: row.NAMA,
	            NB: row.NBB,
	            FN: row.FN_A ? row.FN_A : row.FN_B,
	            DAT: row.DAT_A ? row.DAT_A : row.DAT_B
	    };
	        $.extend(data, row);

	        data.S = data.S / 100;
	        data.KV = data.LCV;
	        sepDocViewer.loadFirstTab(data);
	        sepDocViewer.loadSecondTab.part1(data);
	        sepDocViewer.loadSecondTab.part2(data);
	        sepDocViewer.show();
	    }
	},

	requestDoc: function() {
	    var grid = bars.sepdocs.getSepDocsGrid();
	    var selection = grid.select();
	    var rows = [];
	    for (var i = 0; i < selection.length; i++) {
	        rows.push(grid.dataItem(selection[i]));
	    }

	    $.post(bars.config.urlContent('/Sep/SepFiles/RequestIps'), {
	        docListJson: JSON.stringify(rows)
	    }).done(function (data) {
	        if (data.status == 'ok') {
	            bars.ui.alert({ text: data.message });
	        } else {
	            bars.ui.error({ text: data.message });
	        }
	    });
	},

	initPage: function() {
		$("#pbGoBack").kendoButton();
		$("#pbViewDoc").kendoButton();
		$("#pbFilter").kendoButton();
		$("#pbRequest").kendoButton();
	}
}