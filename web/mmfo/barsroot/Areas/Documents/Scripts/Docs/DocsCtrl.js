function getParam(param) {
    var pageURL = window.location.search.substring(1);
    var URLVariables = pageURL.split('&');
    for (var i = 0; i < URLVariables.length; i++) {
        var parameterName = URLVariables[i].split('=');
        if (parameterName[0] == param) {
            return parameterName[1];
        }
    }
}

$(document).ready(function () {
    var _ref = getParam('refid');
    if (_ref != null) {
        console.log('found ref');
        $('#searchInput').val(_ref);
        setTimeout(function () {
            $("#btnSearch").click();
        }, 0);
        
    }

    $("#loader").hide();
    var ref_id;
    // Search row values validation, numbers only
    $("#searchInput").keyup(function () {
        this.value = this.value.replace(/[^0-9]/g, '');
    });

    $("#searchInput").keyup(function (event) {
        if (event.keyCode == 13) {
            $("#btnSearch").click();
        }
    });


    $("#btnSearch").on("click", function () {
        var refId = $("#searchInput").val();
        if (!!refId) {
            $("#loader").show();
            $.get(urlToSearchRef, { id: refId }).done(function (result) {
                if (result.indexOf("notFound") > -1) {
                    $("#docInfoSection").empty();
                    $("#loader").hide();
                    $("#btnBack").removeClass("btn-success");
                    var noDataResponsed = "<div class='alert alert-warning'>" +
                         "<a href='#' class='close' data-dismiss='alert'>&times;</a>" +
                         "<strong>Увага!</strong> Документ не знайдено. Перевірте введене значення.</div>";
                    ref_id = null;
                    $("#docInfoSection").append(noDataResponsed);
                } else {
                    $("#docInfoSection").empty();
                    $("#loader").hide();
                    $("#btnBack").addClass("btn-success");
                    ref_id = refId;
                    $("#docInfoSection").append(result);
                }
            });
        } else {
            $("#btnBack").removeClass("btn-success");
            $("#docInfoSection").empty();
            var emptySearchingVal = "<div class='alert alert-danger fade in'>" +
                         "<a href='#' class='close' data-dismiss='alert'>&times;</a>" +
                         "<strong>Увага!</strong> Ви не ввели значення REF.</div>";
            $("#docInfoSection").append(emptySearchingVal);
        }
    });

    function confirm(referenceId) {
        var reasonId = $("#ConfirmReason").data("kendoDropDownList").value();
        $.post(urlBackWeb, { id: referenceId, reason: reasonId }).done(function (result) {
            debugger;
            if (result.status === "ok") {
                $("#docInfoSection").empty();
                var resultDataOk = "<div class='alert alert-success fade in'>" +
                             "<a href='#' class='close' data-dismiss='alert'>&times;</a>" +
                             "<strong>Увага! </strong>" + result.message + "</div>";
                $("#docInfoSection").append(resultDataOk);
                $("#btnBack").removeClass("btn-success");
                $("#searchInput").val("");
                ref_id = null;
            } else if (result.status === "error") {
                $("#docInfoSection").empty();
                var resultDataError = "<div class='alert alert-warning'>" +
                    "<a href='#' class='close' data-dismiss='alert'>&times;</a>" +
                    "<strong>Увага! </strong>" + result.message + "</div>";
                $("#docInfoSection").append(resultDataError);
                $("#btnBack").removeClass("btn-success");
                $("#searchInput").val("");
                ref_id = null;
            } else {
                $("#docInfoSection").empty();
                var foreignError = "<div class='alert alert-danger fade in'>" +
                    "<a href='#' class='close' data-dismiss='alert'>&times;</a>" +
                    "<strong>Увага! </strong>" + result.message + "</div>";
                $("#docInfoSection").append(foreignError);
                $("#btnBack").removeClass("btn-success");
                $("#searchInput").val("");
                ref_id = null;
            }
        });
    }

    function showComfirmWindow(ref_id) {
        var dfd = new jQuery.Deferred();
        var result = false;

        $("<div id='popupWindow'></div>")
        .appendTo("body")
        .kendoWindow({
            width: "350px",
            modal: true,
            resizable: false,
            title: "Підтвердження...",
            visible: false,
            close: function (e) {
                this.destroy();
                dfd.resolve(result);
            }
        }).data('kendoWindow').content($('#confirmationTemplate').html()).center().open();

        function onChange() {
            $('#popupWindow .confirm_yes').removeAttr('disabled');
        }

        var comfirmDrop = $("#ConfirmReason").kendoDropDownList({
            dataTextField: "REASON",
            dataValueField: "ID",
            autoBind: false,
            select: onChange,
            //optionLabel: "Всі",
            dataSource: {
                type: "odata",
                severFiltering: true,
                transport: {
                    read: {
                        dataType: "json",
                        url: bars.config.urlContent("/documents/docs/ReasonsHandbook")
                    }
                },
                schema: {
                    data: "Data",
                    total: "Total"
                }
            }
        });

        $('#popupWindow .confirm_yes').val('OK');
        $('#popupWindow .confirm_yes').attr('disabled', true);

        $('#popupWindow .confirm_no').val('Відмінити');

        $('#popupWindow .confirm_no').click(function () {
            $('#popupWindow').data('kendoWindow').close();
        });

        $('#popupWindow .confirm_yes').click(function () {
            result = true;
            confirm(ref_id);
            $('#popupWindow').data('kendoWindow').close();
        });

        return dfd.promise();
    }

    $("#btnBack").on("click", function () {
        if (!!ref_id) {
            showComfirmWindow(ref_id);
        } else {
            $("#docInfoSection").empty();
            var noData = "<div class='alert alert-danger fade in'>" +
                         "<a href='#' class='close' data-dismiss='alert'>&times;</a>" +
                         "<strong>Увага!</strong> Документ не знайдено. Сторнування неможливо.</div>";
            $("#docInfoSection").append(noData);
        }
    });
});

