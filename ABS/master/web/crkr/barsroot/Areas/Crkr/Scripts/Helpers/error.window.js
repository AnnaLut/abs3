var error = error || {};

$(document).ready(function () {

    var showError = function (data) {
        var startPos = data.indexOf(':') + 1;
        var endPos = data.indexOf('ORA', 2);
        var textRes = data.substring(startPos, endPos);
        return textRes;
    }

	error.window = function (msg) {
		$("#showStack").click(function () {
			$("#stack").toggle();
		});
		function onClose() {
			$("#error").fadeIn();
		}
		$("#msg").text(showError(msg));
		$("#stack").text(msg);

		$("#error").kendoWindow({
			width: "500px",
			title: "Виникла помилка!",
			resizable: false,
			visible: false,
			modal: true,
			actions: [
                "Close"
			],
			close: onClose
		}).data("kendoWindow").center().open();
		$("#error").show();
	}	
});