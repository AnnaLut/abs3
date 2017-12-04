/**
 * Created by serhii.karchavets on 15.03.2017.
 */

angular.module("BarsWeb.Areas").directive('maskedDatePicker', [function () {
    return {
        link: function (scope, elem, attrs) {
            $(elem).kendoMaskedTextBox({
                mask: "00/00/0000"
            });
            $(elem).removeClass("k-textbox");
        }
    }
}]);