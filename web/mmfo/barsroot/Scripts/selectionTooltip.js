//function insertSelectionTooltip() {
//    $("[class*=k-grid]").kendoTooltip({
//        autohide: true,
//        filter: ".k-state-selected",
//        position: "right",
//        content: function (e) {
//            var grid = $("[class*=k-grid]").data("kendoGrid");
//            var cell = e.target;
//            var index = cell.index();
//            var selectedCells = grid.select();
//            var sum = 0;
//            var val;

//            var selecledCellsInColumnValues = selectedCells.map(function (i, selectedCell) {
//                val = selectedCell.innerText;
//                var val = val.replace(/\s/g, '');
//                if (selectedCell.cellIndex == index && $.isNumeric(val)) {
//                    return val;
//                }
//            });

//            if (0 == selecledCellsInColumnValues.length) return "Дані цього стовпчика не сумуються";

//            for (var i = 0; i < selecledCellsInColumnValues.length; i++) {
//                sum += +selecledCellsInColumnValues[i];
//            }
//            return "Cума виділених елементів стовчика:<br/>" + kendo.toString(sum, '###,##0.00').replace(new RegExp(",", 'g'), ' ');
//        }
//    });
//}

function insertRowSelectionTooltip() {
    $("[class*=k-grid]").kendoTooltip({
        autohide: true,
        filter: ".k-state-selected>[role*=gridcell]",
        position: "right",
        content: function (e) {
            var grid = $("[class*=k-grid]").data("kendoGrid");
            var selectedRows = grid.select();
            var cell = e.target;
            var row = grid.dataItem(cell.closest("tr"));
            var index = cell.index();
            var field = grid.columns[index].field;
            var sum = 0;

            var val;

            if (!$.isNumeric(row[field])) {
                return "Дані цього стовпчика не сумуються";
            }

            var selecledCellsInColumnValues = selectedRows.map(function (i, selectedRow) {
                val = grid.dataItem(selectedRow)[field];
                //val = val.replace(/\s/g, '');
                if ($.isNumeric(val)) {
                    return val;
                }
            });


            if (0 === selecledCellsInColumnValues.length) return "Дані цього стовпчика не сумуються";

            for (var i = 0; i < selecledCellsInColumnValues.length; i++) {
                sum += +selecledCellsInColumnValues[i];
            }
            return "Cума виділених елементів стовчика:<br/>" + kendo.toString(sum, '###,##0.00').replace(new RegExp(",", 'g'), ' ');
        }
    });
}

function insertRowSelectionTooltipByCellIndex(cellIndex) {
    $("[class*=k-grid]").kendoTooltip({
        autohide: true,
        filter : "td:nth-child(" + cellIndex + ")",
        position: "right",
        content: function (e) {
            var grid = $("[class*=k-grid]").data("kendoGrid");
            var selectedRows = grid.select();
            var sum = 0;
            for(var j = 0; j < selectedRows.length; j++){
                if(selectedRows[j].cellIndex == cellIndex-1){
                    var rowSum = parseFloat(selectedRows[j].innerText.replace(/\s/g, ''));
                    if(!isNaN(rowSum)){
                        sum += rowSum;
                    }
                }
            }
            return "Cума виділених елементів стовчика:<br/>" + kendo.toString(sum, '###,##0.00').replace(new RegExp(",", 'g'), ' ');
        }
    });
}