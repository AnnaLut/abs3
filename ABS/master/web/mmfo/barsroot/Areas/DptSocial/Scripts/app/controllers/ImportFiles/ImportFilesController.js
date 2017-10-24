angular.module('BarsWeb.Controllers', [])
    .controller('AppController', ['$scope', '$http', function ($scope, $http) {
        var paths = GetPaths();
        var file_type = angular.element("#ddFileType").kendoDropDownList({
            dataTextField: "text",
            dataValueField: "value",
            dataSource: [{ value: 1, text: "Пенсії" }, { value: 2, text: "Соціальні виплати" }],
            index: 0,
            change: function (e) {
                SetPath(angular.element("#ddFileType").val());
            },
            dataBound: function (e) {
                SetPath(angular.element("#ddFileType").val());
            }
        }); 

        function GetPaths() {
            obj = {};
            $.ajax({
                url: bars.config.urlContent("api/dptsocial/importfilesapi/GetPath"),
                method: "GET",
                dataType: "json",
                async: false,
                success: function (data) {
                    debugger;
                    obj = data;
                }
            });
            return obj;
        }

        function SetPath(file_tp) {
            debugger;
            for (var i = 0; i < paths.length; i++)
            {
                if (parseInt(file_tp) === paths[i].id)
                {
                    angular.element("#path").val(paths[i].path);
                }
            }
        }

        angular.element("#btnProcess").click(function () {
            angular.element("#loader").show();
            $.ajax({
                url: bars.config.urlContent("/api/dptsocial/importfilesapi/ProcessFiles") + "?path=" + angular.element("#path").val() + "&file_tp=" + angular.element("#ddFileType").val(),
                method: "GET",
                dataType: "json",
                success: function (data) {
                    angular.element("#result").val(data.replace(new RegExp('<br/>', 'g'), "\n"));
                    bars.ui.confirm({ text: data + "<br/>Перейти на сторінку перегляду імпортованих файлів?" }, function () {
                        window.location = bars.config.urlContent('/dptsocial/importfiles/viewimportedfiles') + "?file_tp=" + angular.element("#ddFileType").val();
                    });
                },
                complete: function () {
                    angular.element("#loader").hide();
                }
            });
        });
    }]);