(function ($) {

    function changeRowNumber(elem, url, userUpdateParamFunc, trClickFunk, updateTableFunc) {
        elem.find('tbody .footerRow input[name="rowNumber"]').bind('keypress', function (e) {
            // нажал клавишу enter 
            if (e.keyCode == 13) {
                $(this).parent().find('span[name="rowNumberMesErr"]').remove();
                if ($(this).val() < 1) {
                    $(this).after('<span name="rowNumberMesErr" style="color:red;">не коректне значення</span>');
                }
                else {
                    $(this).attr('data-oldvalue', $(this).val());
                    loadNewPage(elem, url, '', 1, userUpdateParamFunc, trClickFunk, updateTableFunc);
                }
            }
        });
    }

    function selNewPage(elem, url, userUpdateParamFunc, trClickFunk, updateTableFunc,viewTfoot) {
        elem.find('tbody .footerRow .footerDiv img').click(function () {
            var p = $(this).attr('alt');
            loadNewPage(elem, url, '', p, userUpdateParamFunc, trClickFunk, updateTableFunc,viewTfoot);
        });
        /*elem.find('tfoot .btNavigateLeft').click(function () {
            var p = elem.find('tfoot .pageNum').html();
            loadNewPage(elem, url, '', p-1, userUpdateParamFunc, trClickFunk, updateTableFunc, viewTfoot);
            elem.find('tfoot .pageNum').html(p-1);
            if ((p-1) < 2) {
                $(this).css('display', 'none');
            }
        });
        elem.find('tfoot .btNavigateRight').click(function () {
            var p = elem.find('tfoot .pageNum').html();
            loadNewPage(elem, url, '', p+1, userUpdateParamFunc, trClickFunk, updateTableFunc, viewTfoot);
            elem.find('tfoot .pageNum').html(p+1)
            if (p+1 > 2) {
                elem.find('tfoot .btNavigateLeft').css('display', 'inline');
            }
        });*/

    }

    function bindTfoot(elem, url, userUpdateParamFunc, trClickFunk, updateTableFunc,viewTfoot) {
        elem.find('tfoot .btNavigateLeft').click(function () {
            var p = parseInt(elem.find('tfoot .pageNum').html());
            loadNewPage(elem, url, '', p - 1, userUpdateParamFunc, trClickFunk, updateTableFunc, true);
            elem.find('tfoot .pageNum').html(p - 1);
            if ((p - 1) < 2) {
                $(this).css('display', 'none');
            }
        });
        elem.find('tfoot .btNavigateRight').click(function () {
            var p = parseInt(elem.find('tfoot .pageNum').html());
            loadNewPage(elem, url, '', p+1, userUpdateParamFunc, trClickFunk, updateTableFunc, true);
            elem.find('tfoot .pageNum').html(p+1)
            if (p+1 > 1) {
                elem.find('tfoot .btNavigateLeft').css('display', 'inline');
            }
        });
        elem.find('tfoot input[name="rowNumber"]').bind('keypress', function (e) {
            // нажал клавишу enter 
            if (e.keyCode == 13) {
                $(this).parent().find('span[name="rowNumberMesErr"]').remove();
                if ($(this).val() < 1) {
                    $(this).after('<span name="rowNumberMesErr" style="color:red;">не коректне значення</span>');
                }
                else {
                    $(this).attr('data-oldvalue', $(this).val());
                    elem.find('tfoot .pageNum').html('1');
                    elem.find('tfoot .btNavigateLeft').css('display', 'none');
                    loadNewPage(elem, url, '', 1, userUpdateParamFunc, trClickFunk, updateTableFunc,true);
                }
            }
        });
        elem.find('tfoot input[name="rowNumber"]').change(function () {
            $(this).parent().find('span[name="rowNumberMesErr"]').remove();
            $(this).val($(this).attr('data-oldvalue'));
        });

    }

    function tbodyTrClick(elem, trClickFunk) {
        elem.find('tbody tr').click(function () {
            var thisRow = $(this);
            if (thisRow.attr('class') != 'footerRow') {
                var oldSelRow = elem.find('tbody tr.selectedRow');
                var t=oldSelRow.attr('data-oldClass');
                oldSelRow.attr('class', oldSelRow.attr('data-oldClass'));
                oldSelRow.attr('data-oldClass', '');
                thisRow.attr('data-oldClass', thisRow.attr('class'));
                thisRow.attr('class', 'selectedRow');
                if (trClickFunk) { trClickFunk.call();}
            }
        });
        /*elem.find('table tbody tr td').click(function () {
            return false;
        });
        elem.find('table tbody tr td input').click(function () {
            if ($(this).prop('checked')) {
                $(this).attr('checked', 'checked');
            }
            else {
                $(this).removeAttr('checked');
            }
        });*/
    }
    

    function theadInputChec(elem) {
        elem.find('table thead tr th input:checkbox').click(function () {
            if (elem.find('table thead tr th input:checkbox').prop('checked')) {
                elem.find('input:checkbox:checkbox').attr('checked', 'checked');
            }
            else {
                elem.find('input:checkbox:checkbox').removeAttr('checked');
            }
        });
    }

    function loadNewPage(elem, url, loadType, pageNum, userUpdateParamFunc, trClickFunk, updateTableFunc, viewTfoot) {
        addLoader(elem);
        if (viewTfoot) {
            //if (url.split('?').length > 1) url += url + '?';
            var pr = params(elem);
            url += '?pageNum=' + pageNum;
            url += '&pageSize=' + pr.pageSize;
        }
        var userParams = null;
        if (userUpdateParamFunc != null) {
            userParams = userUpdateParamFunc(loadType, pageNum);
        }
        $.post(url, userParams /*userUpdateParamFunc(loadType,pageNum)*/ /*updateParam(loadType,pageNum)*/, function getResp(data) {
            switch (data) {
                case '':
                    elem.find('table tbody').html('<tr style="text-align:center;"><td colspan="200">Відсутні данні по заданому фільтру</td></tr>');
                    break;
                case 'NoData':
                    elem.find('table tbody').html('<tr style="text-align:center;"><td colspan="200">Відсутні данні по заданому фільтру</td></tr>');
                    break;
                case 'errDate':
                    elem.find('table tbody').html('<tr style="text-align:center;"><td colspan="200">Некоректно задано значення дат</td></tr>');
                    break;
                case 'end':
                    $('.selectedRow').html('');
                    break;
                default:
                    var domElement = $(data);
                    if (viewTfoot) {
                        var pr = params(elem);
                        if (domElement.length > pr.pageSize) {
                            domElement = domElement.slice(0, pr.pageSize);
                            elem.find('tfoot .btNavigateRight').css('display', 'inline');
                        }
                        else {
                            elem.find('tfoot .btNavigateRight').css('display', 'none');
                        }
                        if (pageNum == 1) {
                            elem.find('tfoot .btNavigateLeft').css('display', 'none');
                        }
                        else {
                            elem.find('tfoot .btNavigateLeft').css('display', 'inline');
                        }
                    }
                    elem.find('table tbody').html(domElement);
                    tbodyTrClick(elem,trClickFunk);
                    changeRowNumber(elem, url, userUpdateParamFunc, trClickFunk, updateTableFunc);
                    selNewPage(elem, url, userUpdateParamFunc, trClickFunk, updateTableFunc);
                    PaintRows(elem);
                    break;
            }
            if (updateTableFunc) updateTableFunc.call();
            removeLoader(elem);
        });
    }

    function PaintRows(elem) {

        $(elem).find('tbody tr:even:not([class="footerRow"])').attr('class', 'normalRow');
        $(elem).find('tbody tr:odd:not([class="footerRow"])').attr('class', 'alternateRow');
    }

    function removeIcoSort(elem) {
        elem.find('thead tr th div span.spanIcoSortASC, table thead tr th div span.spanIcoSortDESC').remove();
    }

    function params(elem) {
        var params = {
            pageNum: parseInt(elem.find('tfoot .pageNum').html()),
            pageSize: parseInt(elem.find('tfoot input[name="rowNumber"]').val())
        }
        return params;
    }

    var methods = {
        init: function (options) {
            options = $.extend({
                updateTableUrl: '',
                funcUpdateParam: '',
                userUpdateParamFunc: null,
                trClickFunk: null,
                updateTableFunc: null,
                viewTfoot: false,
                pageNum: 1,
                pageSize: 10,
                buttonToUpdateId:''
            }, options);
            var elem = this;

            var make = function () {
                theadInputChec(elem);

                elem.addClass('jungGridView');

                elem.find('caption img[name="refresh"]').click(function () {
                    loadNewPage(elem, options.updateTableUrl, '', $(elem).find('[name="pageNum"]').html(), options.userUpdateParamFunc, options.trClickFunk, options.updateTableFunc, options.viewTfoot);
                });

                if (options.buttonToUpdateId != '') {
                    $('#' + options.buttonToUpdateId).click(function () {
                        elem.find('tfoot input[name="rowNumber"]').val(options.pageSize);
                        elem.find('tfoot input[name="rowNumber"]').attr('data-oldvalue', options.pageSize);
                        elem.find('tfoot .pageNum').html('1');
                        elem.find('tfoot .btNavigateLeft').css('display', 'none');
                        loadNewPage(elem, options.updateTableUrl, 'start', 1, options.userUpdateParamFunc, options.trClickFunk, options.updateTableFunc, options.viewTfoot);
                        removeIcoSort(elem);
                    });
                }

                elem.find('table thead tr th div').click(function () {
                    if ($(this).prop('data-sortdir') != undefined) {
                        removeIcoSort(elem);
                        //elem.find('table thead tr th div span.spanIcoSortASC, table thead tr th div span.spanIcoSortDESC').remove();//.each(function (indx, element) { $(element).remove();});

                        sort = $(this).attr('data-sort');
                        sortDir = $(this).attr('data-sortdir');

                        var spanSortIco = '<span class="spanIcoSort' + $(this).attr('data-sortdir') + '">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>';
                        var prop = $(this).prop('data-sortdir') == 'ASC' ? 'DESC' : 'ASC';
                        var thisHtml = $(this).html();
                        thisHtml += spanSortIco;
                        $(this).html(thisHtml);
                        $(this).prop('data-sortdir', prop);//$(this).prop('data-sortdir')=='ASC' ? 'DESC' : 'ASC';
                        elem.find('tfoot .pageNum').html('1');
                        loadNewPage(elem, options.updateTableUrl, '', 1, options.userUpdateParamFunc, options.trClickFunk, options.updateTableFunc, options.viewTfoot);
                    }
                });
                if (options.viewTfoot) {
                    var tfoot = elem.find('tfoot');
                    var colspan = elem.find('thead tr th').length;
                    var navigateLeft = '<img style="display:none;" class="btNavigateLeft" alt="' + (options.pageNum - 1) + '" src="/Common/Images/default/16/navigate_left.png" />';
                    var navigateRight = '<img style="display:none;" class="btNavigateRight" alt="'+(options.pageNum + 1) +'" src="/Common/Images/default/16/navigate_right.png" />';

                    tfoot.html('<tr> \
                                    <td colspan="'+colspan+'"> \
                                            Сторінка:&nbsp; '+navigateLeft+'\
                                            <span>\
                                                <span class="pageNum">'+options.pageNum+'</span>\
                                            </span>'+navigateRight+'\
                                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Рядків на сторінці:&nbsp;\
                                            <input id="rowNumber" name="rowNumber" data-oldvalue="'+options.pageSize+'" type="text" value="'+options.pageSize+'" style="width:30px;text-align:center;" >\
                                    </td>\
                                </tr>');
                }
                //selNewPage(elem,options.updateTableUrl,options.userUpdateParamFunc,options.trClickFunk,options.updateTableFunc,options.viewTfoot)
                bindTfoot(elem, options.updateTableUrl, options.userUpdateParamFunc,options.trClickFunk, options.updateTableFunc);
                tbodyTrClick(elem,options.trClickFunk);
                PaintRows(elem);

                var countRow = elem.find('tbody tr').length;
                if (countRow == 0) {
                    elem.find('tbody').html('<tr style="text-align:center;"><td colspan="200">Відсутні дані для перегляду.</td></tr>');

                }
                else {
                    if(countRow>options.pageSize){
                        elem.find('tfoot .btNavigateRight').css('display', 'inline');
                        elem.find('tbody').html(elem.find('tbody tr').slice(0, options.pageSize));
                    }
                }

            };

            return elem.each(make);
        },

        button: function (options) {
            options = $.extend({
                updateTableId:'table',
                updateTableUrl: '',
                userUpdateParamFunc: '',
                trClickFunk: null,
                updateTableFunc: null,
                pageNum: 1,
                pageSize: 10,
                viewTfoot:false
            }, options);
            var elem = this;
            var thisTable = $('#' + options.updateTableId);

            thisTable.find('tfoot .pageNum').html(1);
            thisTable.find('tfoot input[name="rowName"]').val(options.pageSize);

            var make = function () {
                elem.click(function () {
                    thisTable.find('tfoot input[name="rowNumber"]').val(options.pageSize);
                    thisTable.find('tfoot input[name="rowNumber"]').attr('data-oldvalue', options.pageSize);
                    thisTable.find('tfoot .pageNum').html('1');
                    thisTable.find('tfoot .btNavigateLeft').css('display', 'none');
                    loadNewPage(thisTable, options.updateTableUrl,'start',1,options.userUpdateParamFunc,options.trClickFunk,options.updateTableFunc,options.viewTfoot);
                    removeIcoSort(thisTable);
                });

                tbodyTrClick(elem,options.trClickFunk);
            };

            return elem.each(make);

        },

        refresh: function (options) {
            options = $.extend({
                pageNum:null
            }, options);
            var elem = this;
            if (options.pageNum != null) {
                $(elem).find('[name="pageNum"]').html(options.pageNum);
            }
            elem.find('caption img[name="refresh"]').click();
        },
        hide: function () {
            // ПРАВИЛЬНЫЙ
        },
        update: function (content) {
            // !!!
        }
    };

    $.fn.jungGridView = function (method) {
        if (methods[method]) {
            return methods[method].apply(this, Array.prototype.slice.call(arguments, 1));
        } else if (typeof method === 'object' || !method) {
            return methods.init.apply(this, arguments);
        } else {
            $.error('Метод с именем ' + method + ' не существует');
        }
    }

  })( jQuery );