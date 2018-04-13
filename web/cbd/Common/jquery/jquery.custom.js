//  Вызов PageMethods и методов веб-сервиса с отображением прогресса выполнения
//
(function ($) {

    var progressTimer = null; // объект таймер
    var displayAfter = 500;   // интервал в мсек. для показа окна загрузки
    var blockElement = null;
    var blockElementMessage = null;
    var blockTitle = null;
    var elemProgress;
    var inProgress = false;

    // обработка окна процесса загрузки
    $.ajaxProgress = {
        start: function () {
            if (!progressTimer) return;
            progressTimer = null;
            window.clearTimeout(progressTimer);
            $.ajaxProgress.block();
        },
        begin: function () {
            progressTimer = window.setTimeout($.ajaxProgress.start, displayAfter);
        },
        block: function () {
            if (inProgress) return;
            inProgress = true;
            if (blockElement) {
                blockElement.block({
                    theme: false,
                    message: '<table><tr><td><img src="/common/css/jquery/images/ajax-loader.gif" style="border-width:0px;" /></td><td class="ctrl-lbl" style="text-align:left">' + blockElementMessage + '</td></tr></table>'
                });
            }
            else {
                if (!blockTitle) blockTitle = "Завантаження...";
                elemProgress = $('<div><img src="/common/css/jquery/images/loader.gif" style="border-width:0px;" /></div>');
                elemProgress.dialog({
                    autoOpen: true,
                    dialogClass: "loadingScreenWindow",
                    closeOnEscape: false,
                    draggable: false,
                    width: 250,
                    minHeight: 50,
                    modal: true,
                    buttons: {},
                    resizable: false
                });
                elemProgress.dialog('option', 'title', blockTitle);
            }
        },
        unblock: function () {
            if (blockElement) {
                blockElement.unblock();
                blockElement = null;
            }
            else if (elemProgress) {
                elemProgress.dialog('close');
            }
            inProgress = false;
            $(".loadingScreenWindow").hide();
        },
        stop: function () {
            window.clearTimeout(progressTimer);
            progressTimer = null;
            $.ajaxProgress.unblock();
        },
        setTitle: function (title) {
            blockTitle = title;
        },
        setElement: function (elem, message) {
            blockElement = elem;
            blockElementMessage = message;
        }
    }

    $.ajaxCallHelper = {

        init: function () {
            // Цепляем обработку на начало запроса
            $(document).ajaxStart(function () {
                progressTimer = window.setTimeout($.ajaxProgress.start, displayAfter);
            });
            // Цепляем обработку на окончание запроса
            $(document).ajaxStop(function () { $.ajaxProgress.stop(); });
        },

        call: function (url, method, params, successFn, errorFn) {
            if (!errorFn)
                errorFn = $.ajaxCallHelper.errorFunc;

            $.ajax({
                type: "POST",
                url: url + "/" + method,
                contentType: "application/json; charset=utf-8",
                data: params,
                dataType: "json",
                success: function (result) { try { successFn(result) } catch (e) { $.ajaxProgress.stop(); throw e; }; },
                error: errorFn
            });
        },

        errorFunc: function (request, status, error) {
			core$ErrorBox2();
            //alert(request.responseText);
            //alert(status);
            //alert(error);
        }
    }

    // Вызов PageMethod с текущей страницы
    CallPageMethod = function (fn, jsonArg, successFn, errorFn) {
        var pagePath = window.location.pathname;
        $.ajaxCallHelper.call(pagePath, fn, jsonArg, successFn, errorFn);
    }

    // Вызов WebService
    CallWebServiceMethod = function (serviceName, fn, jsonArg, successFn, errorFn) {
        //Call the webservice method  
        $.ajaxCallHelper.call(serviceName, fn, jsonArg, successFn, errorFn);
    }

})(jQuery);