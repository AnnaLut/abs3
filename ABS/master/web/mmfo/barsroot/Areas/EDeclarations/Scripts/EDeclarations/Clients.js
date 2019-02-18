$(document).ready(function () {

    var obj;

    $('input[name=radio]').change(function () {
        if ($(this).is(':checked'))

        obj = {
            Inn: $(this).data('ipn'),
            DateOfBirth: $(this).data('bday'),  
            Fullname: $(this).data('nmk'),  
            PersonDocType: $(this).data('doctypeid'),  
            PersonDocSerial: $(this).data('ser'),  
            PersonDocNumber: $(this).data('numdoc'),
            Rnk: $(this).data('rnk'),
            DateFrom: $("#date").data('datefrom'),  
            DateTo: $("#date").data('dateto'),   
        };
    });

    $("#Cancel").click(function () {
        window.parent.$('#createWindow').closest(".k-window-content").data("kendoWindow").close();
        window.parent.$('#creatClientsWindow').closest(".k-window-content").data("kendoWindow").close();
    });

    $("#CreateDecl").click(function () {
        var val = $('input[name=radio]:checked').val();
        if (!val) {
            window.parent.$('.k-overlay').css('z-index', '10002');
            bars.ui.alert({
                text: 'Виберіть клієнта!',
            });
            return;
        }
        var data = JSON.stringify(obj);

        $.ajax({
            url: "/barsroot/api/edeclarations/edeclarations/CreateDeclaration",
            type: 'POST',
            data: data,
            success: function (e) {
                window.parent.$('.k-overlay').css('z-index', '10002');
                if (e && !isNaN(+e)) {
                    $.post('/barsroot/api/edeclarations/edeclarations/CreateSearch/' + e,
                        function (response) {
                            bars.ui.alert({
                                text: response,
                                close: function () {
                                    window.parent.$('#createWindow').closest(".k-window-content").data("kendoWindow").close();
                                    window.parent.$('#creatClientsWindow').closest(".k-window-content").data("kendoWindow").close();
                                }
                            });
                        }
                    ).always(function () {
                        $('.k-overlay').remove();
                    });
                    //bars.ui.alert({
                    //    text: '',
                    //    close: function (e) {
                    //        window.parent.$('#createWindow').closest(".k-window-content").data("kendoWindow").close();
                    //        window.parent.$('#creatClientsWindow').closest(".k-window-content").data("kendoWindow").close();
                    //    }
                    //});
                }
                else {
                    bars.ui.alert({
                        text: 'Декларацію сформовано',
                        close: function () {
                            window.parent.$('#createWindow').closest(".k-window-content").data("kendoWindow").close();
                            window.parent.$('#creatClientsWindow').closest(".k-window-content").data("kendoWindow").close();
                        }
                    });
                }
            },
            error: function (err) {
                window.parent.$('.k-overlay').css('z-index', '10002');
                bars.ui.error({
                    text: err.responseJSON,
                    close: function (err) {
                    }
                })
            }
        });
    });
});
