/**
 * Created by serhii.karchavets on 22-Dec-17.
 */

angular.module(globalSettings.modulesAreas).factory("kendoService", function () {
    /*
    * Возвращает массив выделенных чекбоксом эл. грида
    * */
    var _findCheckedGrid = function (grid) {
        var checked = [];
        grid.tbody.find("input:checked").closest("tr").each(function (index) {
            var uid = $(this).attr('data-uid');
            var item = grid.dataSource.getByUid(uid);
            checked.push(item);
        });
        return checked;
    };
    /*
     * Устанавливает все чекбоксы для грида
     * */
    var _setCheckedGrid = function (grid, isChecked, class_) {
        if(class_ === undefined){class_ = ".chkFormols";}
        var view = grid.dataSource.view();
        for (var i = 0; i < view.length; i++) {
            grid.tbody.find("tr[data-uid='" + view[i].uid + "']")
                .find(class_)
                .prop("checked", isChecked);
        }
    };

    /*
    * Покрасить єл. грида если он зачекан
    * */
    var _setCheckedElemGrid = function (e) {
        var element =$(e.currentTarget);

        var checked = element.is(':checked');
        var row = element.closest("tr");

        if (checked) {
            row.addClass("k-state-selected");
        } else {
            row.removeClass("k-state-selected");
        }
    };

    /*
    * Найти объект в массиве по ключу 'key4Find' и вернуть значение ключа 'key'
    * */
    var _findElInArray = function (array, key4Find, key, value) {
        for(var i = 0; i < array.length; i++){
            if(array[i][key4Find] === value){
                return array[i][key];
            }
        }
        return value;
    };

    return {
        findCheckedGrid: function (grid) { return _findCheckedGrid(grid); },
        setCheckedGrid: function (grid, isChecked) { _setCheckedGrid(grid, isChecked); },
        setCheckedElemGrid: function (e) { _setCheckedElemGrid(e); },
        findElInArray: function (array, key4Find, key, value) { return _findElInArray(array, key4Find, key, value); }
    };
});