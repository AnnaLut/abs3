// jQuery Alert Dialogs Plugin
//
// Usage:
//		jAlert( message, [title, callback] )
//		jConfirm( message, [title, callback] )
//		jPrompt( message, [value, title, callback] )
//
//
(function ($) {

    $.popups = {

        // These properties can be read/written by accessing $.popups.propertyName from your scripts at any time

        verticalOffset: -75,                // vertical offset of the dialog from center screen, in pixels
        horizontalOffset: 0,                // horizontal offset of the dialog from center screen, in pixels/
        repositionOnResize: true,           // re-centers the dialog on window resize
        overlayOpacity: .50,                // transparency level of overlay
        overlayColor: '#FFFFFF',               // base color of overlay
        draggable: true,                    // make the dialogs draggable (requires UI Draggables plugin)
        resizable: false,                   // make the dialogs resizable (requires UI Resizables plugin)
        okButton: '&nbsp;Закрити&nbsp;',         // text for the OK button
        cancelButton: '&nbsp;Відмінити&nbsp;', // text for the Cancel button
        dialogClass: null,                  // if specified, this class will be applied to all dialogs
        callBackFunction: null,
        afterLoadFunction: null,

        // Public methods

        dialog: function (message, title, callback) {
            if (title == null) title = 'Повідомлення';
            $.popups._dialog(title, message, null, 'info', function (result) {
                if (callback) callback(result);
            });
        },

        info: function (message, title, callback) {
            if (title == null) title = 'Повідомлення';
            $.popups._dialog(title, message, null, 'info', function (result) {
                if (callback) callback(result);
            });
        },

        success: function (message, title, callback) {
            if (title == null) title = 'Повідомлення';
            $.popups._dialog(title, message, null, 'success', function (result) {
                if (callback) callback(result);
            });
        },

        warning: function (message, title, callback) {
            if (title == null) title = 'Попередження';
            $.popups._dialog(title, message, null, 'warning', function (result) {
                if (callback) callback(result);
            });
        },

        error: function (message, title, callback) {
            if (title == null) title = 'Помилка';
            $.popups._dialog(title, message, null, 'error', function (result) {
                if (callback) callback(result);
            });
        },

        error2: function (message, title, callback) {
            if (title == null) title = 'Помилка';
            $.popups._dialog(title, message, null, 'error2', function (result) {
                if (callback) callback(result);
            });
        },

        errorEx: function (obj, title, callback) {
            if (title == null) title = 'Помилка';
            $.popups._dialog(title, null, obj, 'errorEx', function (result) {
                if (callback) callback(result);
            });
        },

        confirm: function (message, title, callback, ctrlBlock) {
            if (title == null) title = 'Підтвердження';
            $.popups._dialog(title, message, null, 'confirm', callback, ctrlBlock);
        },

        prompt: function (message, value, title, callback) {
            if (title == null) title = 'Запит значення';
            $.popups._dialog(title, message, value, 'prompt', function (result) {
                if (callback) callback(result);
            });
        },

        // Private methods
        // Отрисовка диалога
        _dialog: function (title, msg, value, type, callback, ctrlBlock) {
            if ($('#dialogContent').size() == 0) {
                html = '<div id="dialogContent" style="text-align:left;" >';
                html += '  <span style="float: left; margin-right: .3em; width:32px;height:32px"></span>';
                html += '  <p style=" margin-left: 40px;" class="ctrl-lbl"></p>';
                html += '  <div id="dialogCustomData"></div>';
                html += '</div>';
                $(html).appendTo($('body'));
            }

            var dOffset = $('#dialogContent').offset();
            $('#dialogContent').dialog({
                autoOpen: false,
                modal: true,
                autoResize: true,
                bgiframe: true,
                open: function () {
                    $('body').css('overflow', 'hidden');
                },
                close: function () {
                    $('body').css('overflow', 'visible');
                    if (type != "confirm")
                        if (callback) callback();
                }
            });

            $('#dialogContent').dialog('option', 'width', 460);
            $('#dialogContent').dialog('option', 'minWidth', 460);
            $('#dialogContent').dialog('option', 'maxHeight', screen.height - 20);
            if (type == "confirm")
                $('#dialogContent').dialog("option", "buttons", [{ text: "ОК", click: function () { if (!ctrlBlock) $(this).dialog("close"); if (callback) callback(true); }, width: 80 }, { text: "Відміна", click: function () { $(this).dialog("close"); if (callback) callback(false); }, width: 80 }]);
            else
                eval("$('#dialogContent').dialog('option', 'buttons', { 'Закрити': function () { $(this).dialog('close'); } })");

            $('#dialogContent').dialog('option', 'title', title);
            if (msg)
                $("#dialogContent p").html(msg.replace(/\n/g, '<br />'));
            if (ctrlBlock) {
                $("#dialogCustomData").empty();
                $("#dialogCustomData").append(ctrlBlock);
            }

            $('#dialogContent span').removeClass();
            $('#dialogContent span').addClass("sprite-icon");
            switch (type) {
                case 'info':
                    $('#dialogContent span').addClass("sprite-info_32");
                    break;
                case 'success':
                    $('#dialogContent span').addClass("sprite-info_32");
                    break;
                case 'warning':
                    $('#dialogContent span').addClass("sprite-warning_32");
                    break;
                case 'prompt':
                    $('#dialogContent span').addClass("sprite-question_32");
                    break;
                case 'confirm':
                    $('#dialogContent span').addClass("sprite-question_32");
                    break;
                case 'error':
                    $('#dialogContent span').addClass("sprite-error_32");
                    break;
                case 'error2':
                    $('#dialogContent span').addClass("sprite-error_32");
                    break;
                case 'errorEx':
                    $('#dialogContent span').addClass("sprite-error_32");
                    break;
            }

            if (type == "error2") {
                $("#dialogContent p").load("/barsroot/cim/handler.ashx?action=error&r=" + Math.random(), function (response, status, xhr) {
                    if (status == "error") {
                        var msg = "Системна помилка.\nНеможливо отримати опис помилки: ";
                        $("#dialogContent p").html(msg + xhr.status + " " + xhr.statusText);
                    }
					$('#dialogContent').dialog('option', 'width', 600);
                    $('#dialogContent').dialog('open');
                });
            }
            else if (type == "errorEx") {
                $("#dialogContent p").load("/barsroot/cim/handler.ashx?action=error&r=" + Math.random(), function (response, status, xhr) {
                    // если пусто, выводим текст скриптовой ошибки
                    if (status == "error") {
                        var msg = "Системна помилка.\nНеможливо отримати опис помилки: ";
                        $("#dialogContent p").html(msg + xhr.status + " " + xhr.statusText);
                    }
                    else if (response == "" && value) {
                        var stackTrace = value.get_stackTrace();
                        var message = "<b>Помилка на сторінці:</b> " + value.get_message();
                        var statusCode = value.get_statusCode();
                        var exceptionType = value.get_exceptionType();
                        var timedout = value.get_timedOut();
                        $("#dialogContent p").html(message + "<br><br><b>Детальніше:</b>" + stackTrace);
                    }
                    $('#dialogContent').dialog('option', 'width', 600);
                    $('#dialogContent').dialog('open');
                });
            }
            else {
                $('#dialogContent').dialog('open');
                if (type == "confirm") {
                    $('.ui-dialog-buttonpane button:eq(1)').focus();
                }
            }
        },

        _callBack: function (par0,par1,par2,par3,par4,par5) {
            if (callBackFunction) eval(callBackFunction + '(par0,par1,par2,par3,par4,par5)');
        },
        _autoHeight: function (frame, frameContainer, originalHeight) {
            var height = 45;
            if (frame.contentDocument)
                height += frame.contentDocument.body.offsetHeight + 35;
            else
                height += frame.contentWindow.document.body.scrollHeight;
            if (originalHeight < height) {
                frameContainer.dialog('option', 'minHeight', height);
                frameContainer.dialog('option', 'height', height);
            }
        },

        // отрисовка фрейма
        _iframe: function (oArg) {
            if (!oArg) return;

            var callback = null;
            afterLoadFunction = null;
            var url = "about:blank";
            var title = "";
            var width = 470;
            var height = 370;

            if (oArg.width) width = oArg.width;
            if (oArg.height) height = oArg.height;
            if (oArg.url) url = oArg.url;
            if (oArg.title) title = oArg.title;
            if (oArg.callback) callback = oArg.callback;
            if (oArg.returnFunc) callback = oArg.returnFunc;
            if (oArg.afterloadFunc) afterLoadFunction = oArg.afterloadFunc;

            callBackFunction = callback;
            $.ajaxProgress.block();
            var frameContainer = $('#iframeContent');
            var iframe = $("#dialogFrame");
            var overlay = $("#dialogOverlay");

            if (frameContainer.size() > 0) {
                frameContainer.dialog('destroy');
                iframe.remove();
                overlay.remove();
                frameContainer.remove();
            }
            iframe = $("<iframe frameborder='0' scrolling='auto' background='transparent' />")
				        .attr("id", "dialogFrame")
				        .attr("name", "dialogFrame")
                        .attr("src", url)
				        .css("margin", "0").css("border", "0").css("padding", "0")
                        .css("top", "0").css("left", "0").css("right", "0").css("bottom", "0")
				        .css("width", "100%").css("height", "100%");
            overlay = $("<div style='z-index:999'>&nbsp;</div>")
                        .attr("id", "dialogOverlay")
				        .css("position", "fixed")
				        .css("margin", "0").css("border", "0").css("padding", "0")
				        .css("top", "0").css("left", "0").css("right", "0").css("bottom", "0")
				        .css("width", "100%").css("height", "100%")
				        .css("display", "none")
                        .addClass('ui-widget-overlay')
                        .appendTo(document.body);
            frameContainer = $("<div />")
                        .attr("id", "iframeContent")
				        .css("margin", "0").css("border", "0").css("padding", "0")
                        .css("text-align", "left")
				        .css("overflow", "hidden")
                        .hide()
                        .append(iframe)
				        .appendTo(document.body)
                        .dialog({
                            autoOpen: false,
                            modal: false,
                            autoResize: false,
                            open: function () {
                                $('body').css('overflow', 'hidden');
                                $('#iframeContent').css('overflow', 'hidden');
                                $.popups._autoHeight($get('dialogFrame'), $('#iframeContent'), height);
                            },
                            close: function () {
                                overlay.hide();
                                $('body').css('overflow', 'visible');
                                var retVal = window.frames["dialogFrame"].returnVal;
                                $.popups._callBack(retVal, window.frames["dialogFrame"]);
                            }
                        })
                        .dialog('option', 'width', width)
                        .dialog('option', 'minWidth', width)
                        .dialog('option', 'minHeight', height)
                        .dialog('option', 'height', height);
            iframe.load(function () {
                frameContainer = $('#iframeContent');
                $.ajaxProgress.unblock();
                overlay.show();

                var doc = $get('dialogFrame').contentDocument;
                if (!doc && $get('dialogFrame').contentWindow) doc = $get('dialogFrame').contentWindow.document;
                if (!doc) doc = window.frames["dialogFrame"].document;

                if (doc.location.href.indexOf("ibank/login.aspx") > 0) {
                    parent.location.reload();
                    return;
                }

                eval("frameContainer.dialog('option', 'buttons', { '" + jsres$core.close + "': function () { $(this).dialog('close'); } })");
                
                if (afterLoadFunction)
                    eval(afterLoadFunction + '(doc, frameContainer)');

                var pageTitle;
                var pageUrl;
                if ($get('dialogFrame')) {
                    if ($get('dialogFrame').contentDocument) {
                        pageTitle = $get('dialogFrame').contentDocument.title;
                    } else {
                        pageTitle = $get('dialogFrame').contentWindow.document.title;
                    }
                    if (!title)
                        frameContainer.dialog('option', 'title', pageTitle);
                    else
                        frameContainer.dialog('option', 'title', title);
                }
                frameContainer.dialog('open');
            });

            return frameContainer;
        },
        iframe: function (oArg) {
            if (!oArg) return;

            callBackFunction = callback;
            var callback = null;
            var url = "about:blank";
            var title = "";
            var width = 470;
            var height = 370;
            if (oArg.width) width = oArg.width;
            if (oArg.height) height = oArg.height;
            if (oArg.url) url = oArg.url;
            if (oArg.title) title = oArg.title;
            if (oArg.callback) callback = oArg.callback;

            if ($('#iframeContent').size() == 0) {
                html = '<div id="iframeContent" style="text-align:left;padding:0;margin:0;display:none" >';
                html += '<iframe id="dialogFrame" name="dialogFrame" style="text-align:left;border:none;padding:0;width:100%;height:100%;top:0;left:0" scrolling="no" frameborder="0" allowtransparency="true"></iframe>';
                html += '</div>';
                $(html).appendTo($('body'));
            }
            $.ajaxProgress.setElement($('#iframeContent'), "Завантаження...");
            $.ajaxProgress.block();
            // Setup popup dialog
            $('#iframeContent').dialog({
                autoOpen: false,
                modal: true,
                autoResize: false,
                bgiframe: true,
                open: function () {
                    $('body').css('overflow', 'hidden');
                    $('#iframeContent').css('overflow', 'hidden');
                },
                close: function () {
                    $('body').css('overflow', 'visible');
                    var retVal = window.frames["dialogFrame"].returnVal;
                    $.popups._callBack(retVal);
                }
            });
            $('#iframeContent').dialog('option', 'width', width);
            $('#iframeContent').dialog('option', 'minWidth', width);
            $('#iframeContent').dialog('option', 'minHeight', height);
            $('#iframeContent').dialog('option', 'height', height);
            eval("$('#iframeContent').dialog('option', 'buttons', { '" + jsres$core.close + "': function () { $(this).dialog('close'); } })");
            if (title)
                $('#iframeContent').dialog('option', 'title', title);
            $('#dialogFrame').attr("src", url);
            $('#iframeContent').dialog('open');

            $('#dialogFrame').one("load", function () { $.ajaxProgress.unblock(); });
            return $('#iframeContent');
        }
    }

    core$InfoBox = function (message, title, callback) {
        $.popups.info(message, title, callback);
    };

    core$SuccessBox = function (message, title, callback) {
        $.popups.success(message, title, callback);
    };

    core$WarningBox = function (message, title, callback) {
        $.popups.warning(message, title, callback);
    };

    core$ErrorBox = function (message, title, callback) {
        $.popups.error(message, title, callback);
    };

    core$ErrorBox2 = function (message, title, callback) {
        $.popups.error2(message, title, callback);
    };

    core$ErrorBoxEx = function (obj, title, callback) {
        $.popups.errorEx(obj, title, callback);
    };

    core$ConfirmBox = function (message, title, callback, ctrlBlock) {
        $.popups.confirm(message, title, callback, ctrlBlock);
    };

    core$PromptBox = function (message, value, title, callback) {
        $.popups.prompt(message, value, title, callback);
    };

    core$IframeBox = function (oArg) {
        return $.popups._iframe(oArg);
    };

    core$IframeBox2 = function (oArg) {
        return $.popups.iframe(oArg);
    };

    core$DialogBoxClose = function () {
        $('#dialogContent').dialog('close');
    };

    core$IframeBoxClose = function () {
        $('#iframeContent').dialog('close');
    };
})(jQuery);