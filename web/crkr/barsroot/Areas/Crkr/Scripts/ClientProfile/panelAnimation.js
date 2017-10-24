var panel = panel || {};
$(document).ready(function () {
    panel.initPanel = function() {
        $(".panel-heading").each(function () {
            if ($(this).hasClass('panel-collapsed')) {
                $(this).parents('.panel').find('.panel-body').slideDown();
                $(this).removeClass('panel-collapsed');
            } else {
                $(this).parents('.panel').find('.panel-body').slideUp();
                $(this).addClass('panel-collapsed');
            }

        });

        $(".panel-heading").on("click", function () {
            if ($(this).hasClass('panel-collapsed')) {
                $(this).parents('.panel').find('.panel-body').slideDown();
                $(this).removeClass('panel-collapsed');
                $(this).find('.pull-right').removeClass('glyphicon-menu-down').addClass('glyphicon-menu-up');
            } else {
                $(this).parents('.panel').find('.panel-body').slideUp();
                $(this).addClass('panel-collapsed');
                $(this).find('.pull-right').removeClass('glyphicon-menu-up').addClass('glyphicon-menu-down');
            }
        });

        $("#clientNextBtn").on("click", function () {
            $("#clientPanelHead").parents('.panel').find('.panel-body').slideUp();
            $("#clientPanelHead").removeClass('panel-collapsed');
            $("#docPanelHead").parents('.panel').find('.panel-body').slideDown();
            $("#docPanelHead").addClass('panel-collapsed');
        });

        $("#docNextBtn").on("click", function () {
            $("#docPanelHead").parents('.panel').find('.panel-body').slideUp();
            $("#docPanelHead").removeClass('panel-collapsed');
            $("#addressPanelHead").parents('.panel').find('.panel-body').slideDown();
            $("#addressPanelHead").addClass('panel-collapsed');
        });

        $("#addressNextBtn").on("click", function () {
            $("#addressPanelHead").parents('.panel').find('.panel-body').slideUp();
            $("#addressPanelHead").removeClass('panel-collapsed');
            $("#reqPanelHead").parents('.panel').find('.panel-body').slideDown();
            $("#reqPanelHead").addClass('panel-collapsed');
        });
    }
});