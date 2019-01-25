function showProfile() {
    var butt = $('#btnProfile');
    $('.toolbar a').not(butt).removeClass('active');
    if (!butt.hasClass('active')) {
        butt.addClass('active');
        $('#userProfile').popupBox({ selector: butt, rightMargin: 5, onClose: function () { butt.removeClass('active'); } });
    } else {
        $.fn.popupBox('close', { onClose: function () { butt.removeClass('active'); } });
    }
}
function changeCounter(count) {
    var buttMess = $('#btnMessage');
    var messCount = buttMess.find('.count');
    var oldCount = parseInt(messCount.html()) || 0;
    if (messCount.length === 0) {
        messCount = $('<div/>', { 'class': 'count', id: '#btnMessageCount' });
        buttMess.prepend(messCount);
    }
    var newCount = oldCount + parseInt(count);
    if (newCount < 1) {
        messCount.remove();
    } else {
        messCount.html(newCount);
    }
}

function reloadMessage() {
    var butt = $('#btnMessage');
    butt.addClass('active');
    var messBlock = $('#userMessage');

    messBlock.load('/barsroot/messagesctrl/index/', { userId: $('#curentUserIdentifier').val() }, function () {
        messBlock.parent().loader('remove');
    });

    messBlock.popupBox({ selector: butt, rightMargin: 65, onClose: function () { butt.removeClass('active'); } });
    messBlock.parent().loader();
}

function showMessage() {
    var butt = $('#btnMessage');
    $('.toolbar a').not(butt).removeClass('active');
    if (!butt.hasClass('active')) {
        reloadMessage();
    } else {
        $.fn.popupBox('close', { onClose: function () { butt.removeClass('active'); } });
    }
}

function reloadTasks() {
    var buttTasks = $('#btnTasks');
    buttTasks.addClass('active');
    var taskBlock = $('#userTasks');

    $.get('/barsroot/api/async/tasks/?$inlinecount=allpages', function (request) {
        taskBlock.parent().loader('remove');

        taskBlock.html('<h2 style="margin-top: 0;margin-left: 5px;">Запущені задачі <button title="Перечитити" class="btn-refresh button" onclick="reloadTasks();"><img  src="/barsroot/content/Themes/ModernUI/css/images/16/refresh.png"/></button></h2>');
        var tasksList = $('<div id="tasksList" class="messages-list"></div>');
        for (var i = 0; i < request.Data.length; i++) {
            var current = request.Data[i];
            var dateStart = new Date(parseInt(current.StartDate.substr(6)));
            var dateStartStr = dateStart.getDate() + '/' + (dateStart.getMonth() + 1) + '/' + dateStart.getFullYear() + ' ' +
                dateStart.getHours() + ':' + dateStart.getMinutes() + ':' + dateStart.getSeconds();
            var loaderTpl = '<div class="messages">\
                                <div class="title">\
                                  <div class="messages-title">'+ (current.SchedulerName == null ? '' : current.SchedulerName) + '</div>\
                                  <div class="messages-date">' + dateStartStr + '</div>\
                                </div>';
            if (current.ProgressPercent != null) {
                loaderTpl += '<div>\
                                 <div class="progress ng-isolate-scope" animate="false" value="dynamic" type="success">\
                                     <div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="62" aria-valuemin="0" aria-valuemax="100" aria-valuetext="62%" ng-transclude="" style="transition: none; -webkit-transition: none; width: ' + current.ProgressPercent + '%;">\
                                     <div class="progress-label"><b>' + current.ProgressPercent + '%</b></div></div>\
                                 </div>\
                              </div>';
            }

            loaderTpl += '<div class="messages-text">' + (current.ProgressText == null ? 'виконується' : current.ProgressText) + '</div>';
            loaderTpl += '</div>';
            tasksList.append(loaderTpl);

        }
        taskBlock.append(tasksList);
        $('#tasksList').slimScroll({
            //height: 'auto',
            railVisible: true,
            size: '8px',
            height: '350px'
        });
    });

    taskBlock.popupBox({ selector: buttTasks, rightMargin: 185, onClose: function () { buttTasks.removeClass('active'); } });
    taskBlock.parent().loader();
}

function showTasks() {
    var buttTasks = $('#btnTasks');
    $('.toolbar a').not(buttTasks).removeClass('active');
    if (!buttTasks.hasClass('active')) {
        reloadTasks();
    } else {
        $.fn.popupBox('close', { onClose: function () { buttTasks.removeClass('active'); } });
    }
}

function reloadAudit() {
    var buttAudit = $('#btnAudit');
    buttAudit.addClass('active');
    var auditBlock = $('#userAudit');
    auditBlock.load('/barsroot/security/account/audit/', function () {
        auditBlock.parent().loader('remove');
    });
    auditBlock.popupBox({ selector: buttAudit, rightMargin: 125, onClose: function () { buttAudit.removeClass('active'); } });
    auditBlock.parent().loader();
}

function showAudit() {
    var buttAudit = $('#btnAudit');
    $('.toolbar a').not(buttAudit).removeClass('active');
    if (!buttAudit.hasClass('active')) {
        reloadAudit();
    } else {
        $.fn.popupBox('close', { onClose: function () { buttAudit.removeClass('active'); } });
    }
}
function showGatges() {
    var butt = $('#btnGatges');
    $('.toolbar a').not(butt).removeClass('active');
    if (!butt.hasClass('active')) {
        butt.addClass('active');
        $('#userGatges').popupBox({ selector: butt, rightMargin: 185, css: { right: '70px' }, onClose: function () { butt.removeClass('active'); } });
    } else {
        $.fn.popupBox('close', { onClose: function () { butt.removeClass('active'); } });
    }
}
function showToolkit() {
    var butt = $('#btnToolkit');
    $('.toolbar a').not(butt).removeClass('active');
    if (!butt.hasClass('active')) {
        butt.addClass('active');
        $('#userToolkit').popupBox({ selector: butt, rightMargin: 185, css: { right: '210px' }, onClose: function () { butt.removeClass('active'); } });
    } else {
        $.fn.popupBox('close', { onClose: function () { butt.removeClass('active'); } });
    }
}
function showBranches() {
    var butt = $('#btnBranches');
    $('.toolbar a').not(butt).removeClass('active');
    if (!butt.hasClass('active')) {
        butt.addClass('active');
        $('#userBranches').popupBox({ selector: butt, rightMargin: 185, css: { right: '210px' }, onClose: function () { butt.removeClass('active'); } });
    } else {
        $.fn.popupBox('close', { onClose: function () { butt.removeClass('active'); } });
    }
}
function showConverter() {
    $.fn.popupBox('close', { onClose: function () { $('#btnGatges').removeClass('active'); } });
    var convertor = $('<div/>');
    convertor.dialog({
        width: '230',
        height: '358',
        title: 'Конвертер',
        position: { at: 'right bottom' },
        close: function () { convertor.remove(); }
    }).css('padding', '0').loader();
    convertor.load('/barsroot/webservices/converter/', function () {
        convertor.loader('remove');
    });
}

function showCalc() {
    $.fn.popupBox('close', { onClose: function () { $('#btnGatges').removeClass('active'); } });
    var calc = $('<div/>');
    calc.dialog({
        width: '200',
        height: '358',
        title: 'Калькулятор',
        position: { at: 'right bottom' },
        close: function () { calc.remove(); }
    }).css('padding', '0').loader();
    calc.load('/barsroot/webservices/calculator/', function () {
        calc.loader('remove');
    });
}

function showNews() {
    $.fn.popupBox('close', { onClose: function () { $('#btnGatges').removeClass('active'); } });
    go('/barsroot/board/index/', this);
}

function showAccounts() {
    $.fn.popupBox('close', { onClose: function () { $('#btnToolkit').removeClass('active'); } });
    go('/barsroot/customerlist/custacc.aspx?type=2', this);
}

function showVerifyKey() {
    $.fn.popupBox('close', { onClose: function () { $('#btnProfile').removeClass('active'); } });
    go('/barsroot/tools/testseckey.aspx', this);
}

function showDocuments() {
    $.fn.popupBox('close', { onClose: function () { $('#btnToolkit').removeClass('active'); } });
    go('/barsroot/DocView/Docs/DocumentDateFilter?type=1', this);
    //go('/barsroot/documentsview/default.aspx?type=1', this);
}

function changeBranch() {
    $('#main').loader();
    document.location.href();
}
function changePassword() {
    var dialog = $('<div />');
    dialog.load('/barsroot/account/changepassword/', { partial: true }, function () {
        dialog.loader('remove');
    });
    dialog.dialog({
        width: 450,
        height: 500,
        modal: true,
        close: function () { dialog.remove(); }
    }).loader();
}


function deleteAllCookies() {
    var cookies = document.cookie.split(";");

    for (var i = 0; i < cookies.length; i++) {
        var cookie = cookies[i];
        var eqPos = cookie.indexOf("=");
        var name = eqPos > -1 ? cookie.substr(0, eqPos) : cookie;
        document.cookie = name + "=;expires=Thu, 01 Jan 1970 00:00:00 GMT";
    }
}

function logout(prepareLogoutUrl, logoutUrl) {
    $.get(prepareLogoutUrl, function (logoutType) {
        if (logoutType == 1) {
            try {
                window.document.execCommand("ClearAuthenticationCache");
                location.reload();
                return false;
            } catch (e) {
                alert("Ваш браузер не підтримує коректного виходу з системи. Для завершення роботи закрийте вікно.");
                window.close();
            }
        }
        $('body').loader();
        $('#btnProfile').click();
        document.location.href = logoutUrl;
        return true;
    });
}

/* ******** */

$(document).ready(function () {

    var branches = new kendo.data.HierarchicalDataSource({
        transport: {
            read: function (options) {
                var id = options.data.BRANCH || 'null';
                $.ajax({
                    url: '/barsroot/api/kernel/headerbranches/get',
                    dataType: "json",
                    data: { id: id.replace(/\s+/g, '') },
                    success: function (result) {
                        options.success(result);
                    },
                    error: function (result) {
                        options.error(result);
                    }
                });
            }
        },
        schema: {
            model: {
                id: "BRANCH",
                hasChildren: "HAS_CHILD"
            }
        }
    });

    function onSelect(e) {
        if (e.sender._current.context.children[0].className === 'disabled') {
            e.preventDefault();
        } else {
            var branch = e.sender._current.context.children[0].innerText,
                requestData = {
                    branch: branch.replace(/\s+/g, '')
                }
            $.ajax({
                type: 'POST',
                url: '/barsroot/api/kernel/headerbranches/post',
                dataType: "json",
                data: requestData
            });
        }
        //parent.window.location.reload();
        setTimeout(function () { location.reload(true); }, 1000);
    }

    $("#treeview").kendoTreeView({
        select: onSelect,
        dataSource: branches,
        template: "<span #= item.CAN_SELECT === 1 ? '' : \"class='disabled'\" #> #= item.BRANCH # </span> <span>  #= item.SHOW_REGIONAL_NAME ? '  - ' + item.NAME: ''# </span>",
        dataBound: function (e) {
            this.expandPath(['/']);
            // expand all
            //this.expand(".k-item");                        
        }
    });

    //для вычисения выпадющего списка
    var element_treeview = document.getElementById("userBranches");
    var Height = document.documentElement.offsetHeight - 100;
    element_treeview.style.maxHeight = Height + "px";
   // alert(document.documentElement.offsetHeight);

});

/* ****Teller messages**** */

function TellerMessages() {
    var url = '/barsroot/messagesctrl/TellerMessages/';
    $.ajax({
        type: 'POST',
        url: url,
        success: function (data) {
            if (data.message)
                ShowTellerMessages(data.message);
        },
        error: function (err) {

        }
    });
}

function ShowTellerMessages(message) {
    $('#teller-message-text').html(message);
    $('#teller-preloader').show().css('zIndex', '1050');
    $('#teller-messages-window').show('fast');
}

function ConfirmReadTellerMessages() {
    $('#teller-messages-window').hide('fast');
    $('#teller-preloader').hide().css('zIndex', '500');
    TellerMessages();
}
