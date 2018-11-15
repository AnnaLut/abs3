$(document).ready(function () {
    var data = [
        { text: "----- не вибрано -----", value: "0" },
        { text: "Помилка в ПЗ АБС `БАРС Millennium`", value: "1" },
        { text: "Відмова клієнта щодо обслуговування за ДКБО", value: "2" },
        { text: "Технологічна та/або апаратна помилка інфраструктури (принтер, сканер, перебої у електромережі тощо)", value: "3" },
        { text: "Інше", value: "4" }
    ];


    $("#txtTicketNum").keydown(function (e) {
        // Allow: backspace, delete, tab, escape, enter and .
        if ($.inArray(e.keyCode, [46, 8, 9, 27, 13, 110, 190]) !== -1 ||
            // Allow: Ctrl/cmd+A
            (e.keyCode == 65 && (e.ctrlKey === true || e.metaKey === true)) ||
            // Allow: Ctrl/cmd+C
            (e.keyCode == 67 && (e.ctrlKey === true || e.metaKey === true)) ||
            // Allow: Ctrl/cmd+X
			(e.keyCode == 88 && (e.ctrlKey === true || e.metaKey === true)) ||
			// Allow: Ctrl/cmd+V
			(e.keyCode == 86 && (e.ctrlKey === true || e.metaKey === true)) ||
            // Allow: home, end, left, right
            (e.keyCode >= 35 && e.keyCode <= 39)) {
            // let it happen, don't do anything
            return;
		}

        // Ensure that it is a number and stop the keypress
        if ((e.shiftKey || (e.keyCode < 48 || e.keyCode > 57)) && (e.keyCode < 96 || e.keyCode > 105)) {
            e.preventDefault();
		}

    });

    var ddlReason = $("#ddlReason").kendoDropDownList({
        dataTextField: "text",
        dataValueField: "value",
        dataSource: data
    }).data("kendoDropDownList");

    var btnGetNote = $("#btnGetNote").kendoButton({
        enable: true
    }).data("kendoButton");

	$("#btnGetNote").click(function () {		
        var TicketNumValue = $("#txtTicketNum").val();
        var ddlReasonValue = $("#ddlReason").val();
        var txtTicketNumSpan = $('#txtTicketNumSpan');
        var ddlReasonSpan = $('#ddlReasonSpan');

		(TicketNumValue.length > 0) ? txtTicketNumSpan.hide() : txtTicketNumSpan.show();
        (ddlReasonValue > 0) ? ddlReasonSpan.hide() : ddlReasonSpan.show();

		if (ddlReasonValue > 0 && TicketNumValue.length > 0)
        {
            Waiting(true);
            window.location = bars.config.urlContent("/api/BpkW4/AutoOfficialNoteApi/GetOfficialNote?id_ticket=") + TicketNumValue + "&reason=" + ddlReasonValue;
            Waiting(false);
        }

    });
});


