/*
    Сервисные функции по отображению сканкопий
*/

// инициализация картинки
function InitByteImage(img_id, sid, pcount_id, imgcount, type) {
    var img_obj = $('#' + img_id);

    // ид. сессии
    img_obj.attr('sid', sid);

    // контролы пейджера
    img_obj.attr('pcount_id', pcount_id);

    // значения пейджера
    img_obj.attr('imgcount', 0);
    img_obj.attr('curimg', 0);

    // режим отображения картинки Original - полный размер, Thumbnail - уменьшенные картинки
    img_obj.attr('type', type);

    // устанавливаем кол-во картинок и загружаем первую если есть
    img_obj.attr('imgcount', imgcount);
    img_obj.attr('curimg', 1);
    ShowCurrentImage(img_id);

    // отображем подпись
    RedrawPagerTitle(img_id);
}

// пейджинг
function ShowCurrentImage(img_id) {
    var img_obj = $('#' + img_id);
    var ImgUrl = location.protocol + '//' + location.host + '/barsroot/credit/usercontrols/dialogs/byteimage_tiffile.ashx?sid=' + img_obj.attr('sid') + '&type=' + img_obj.attr('type') + '&page=' + img_obj.attr('curimg');
    img_obj.attr('src', ImgUrl);
}
function RedrawPagerTitle(img_id) {
    var img_obj = $('#' + img_id);

    // если нет контрола для отображенияы пейджера то выходим
    if (img_obj.attr('pcount_id') == null || $(img_obj.attr('pcount_id')) == null) return;

    var pcount_obj = $('#' + img_obj.attr('pcount_id'));
    pcount_obj.html('Зображення ' + img_obj.attr('curimg') + ' з ' + img_obj.attr('imgcount'));
}
function ShowPrevImage(img_id) {
    var img_obj = $('#' + img_id);
    var curimg = parseInt(img_obj.attr('curimg'), 10);

    if (curimg - 1 >= 1) {
        img_obj.attr('curimg', curimg - 1);
        ShowCurrentImage(img_id);
        RedrawPagerTitle(img_id);
    }
}
function ShowNextImage(img_id) {
    var img_obj = $('#' + img_id);
    var curimg = parseInt(img_obj.attr('curimg'), 10);
    var imgcount = parseInt(img_obj.attr('imgcount'), 10);

    if (curimg + 1 <= imgcount) {
        img_obj.attr('curimg', curimg + 1);
        ShowCurrentImage(img_id);
        RedrawPagerTitle(img_id);
    }
}

// изменение размеров картинки
// получение максимального размера окна
function MaxWidth(ImgWidth) {
    var width = null;

    if (window.innerWidth != null) {
        width = window.innerWidth;
    }
    else if (document.documentElement.clientWidth != null) {
        width = document.documentElement.clientWidth;
    }
    else if (document.body != null) {
        width = document.body.clientWidth;
    }

    return Math.min(ImgWidth + 50, width - 50);
}
function MaxHeight(ImgHeight) {
    var height = null;

    if (window.innerHeight != null) {
        height = window.innerHeight;
    }
    else if (document.documentElement.clientHeight != null) {
        height = document.documentElement.clientHeight;
    }
    else if (document.body != null) {
        height = document.body.clientHeight;
    }

    return Math.min(ImgHeight + 50, height - 150);
}
function ResizeImageToWindow(img_id) {
    var img_obj = $('#' + img_id);

    // размер картинки
    img_obj.width(MaxWidth(img_obj.width()));
    // Закоментировал чтоб сохранить пропорции 
    // img_obj.height(MaxHeight(img_obj.height()));
}

// просмотр
function ViewClick(img_id) {
    var img_obj = $('#' + img_id);

    var DialogOptions = 'width=600, height=620, toolbar=no, location=no, directories=no, menubar=no, scrollbars=yes, resizable=yes, status=no';
    var result = window.open('/barsroot/credit/usercontrols/dialogs/byteimage_show.aspx?sid=' + img_obj.attr('sid') + '&rnd=' + Math.random(), 'view_window', DialogOptions);
}