(function ($) {
    //function addLoader(elem) { }

  function addPreload(elem) {
    var h = elem.height(); var w = elem.width();
    elem.parent().append('<div class="divPreloader" style="top:' + ((h / 2) - 35) + 'px;">' +
                            '<div class="overlay" style="top:-' + ((h / 2) - 35) + 'px;height:' + (h) + 'px;width:' + w + 'px"></div>' +
                            '<div class="loading">' +
                              '<div id="lbStatus">Завантаження...</div>' +
                              '<div id="lbImgLoading"></div>' +
                            '</div>' +
                          '</div>');
  }
    function removePreload(elem) { elem.parent().find('.divPreloader').remove(); }

    function changeRowNumber(elem, url, userUpdateParamFunc, trClickFunk, updateTableFunc) {
        elem.find('tbody .footerRow input[name="rowNumber"]').bind('keypress', function (e) {
            // нажал клавишу enter 
            if (e.keyCode == 13) {
                $(this).parent().find('span[name="rowNumberMesErr"]').remove();
                if ($(this).val() < 1) {
                    $(this).after('<span class="text" name="rowNumberMesErr">не коректне значення</span>');
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

    function bindTfoot(elem, url, userUpdateParamFunc, trClickFunk, updateTableFunc/*,viewTfoot*/) {
        elem.find('tfoot .button[name="btLeft"]').click(function () {
            var p = parseInt(elem.find('tfoot .pageNum').html());
            loadNewPage(elem, url, '', p - 1, userUpdateParamFunc, trClickFunk, updateTableFunc, true);
            elem.find('tfoot .pageNum').html(p - 1);
            if ((p - 1) < 2) {
                $(this).css('display', 'none');
            }
        });
        elem.find('tfoot .button[name="btRight"]').click(function () {
            var p = parseInt(elem.find('tfoot .pageNum').html());
            loadNewPage(elem, url, '', p+1, userUpdateParamFunc, trClickFunk, updateTableFunc, true);
          elem.find('tfoot .pageNum').html(p + 1);
            if (p+1 > 1) {
                elem.find('tfoot .button[name="btLeft"]').show();
            }
        });
        elem.find('tfoot input[name="rowNumber"]').bind('keypress', function (e) {
            // нажал клавишу enter 
            if (e.keyCode == 13) {
                $(this).parent().find('span[name="rowNumberMesErr"]').remove();
                if ($(this).val() < 1 || $(this).val() > 999) {
                    $(this).after('<span name="rowNumberMesErr" class="text-error"  >не коректне значення</span>');
                }
                else {
                    $(this).attr('data-oldvalue', $(this).val());
                    elem.find('tfoot .pageNum').html('1');
                    elem.find('tfoot .button[name="btLeft"]').hide();
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
        elem.find('tbody').not('.footerRow').on('click','tr',function () {
            var thisRow = $(this);
            thisRow.addClass('selectedRow');
            elem.find('tbody tr.selectedRow').not(this).removeClass('selectedRow');

            if (trClickFunk) { trClickFunk.call(); }
        });
    }

    /*function tbodyTrClick1(elem, trClickFunk) {
        elem.find('tbody tr').click(function () {
            var thisRow = $(this);
            if (thisRow.attr('class') != 'footerRow') {
                thisRow.addClass('selectedRow');
                elem.find('tbody tr.selectedRow').not(this).removeClass('selectedRow');

                if (trClickFunk) { trClickFunk.call(); }
                /*var oldSelRow = elem.find('tbody tr.selectedRow');
                var t = oldSelRow.attr('data-oldClass');
                oldSelRow.attr('class', oldSelRow.attr('data-oldClass'));
                oldSelRow.attr('data-oldClass', '');
                thisRow.attr('data-oldClass', thisRow.attr('class'));
                thisRow.attr('class', 'selectedRow');
                if (trClickFunk) { trClickFunk.call(); }* /
            }
        });
    }*/

    /*function tbodyTrClick2(elem, trClickFunk) {
        elem.find('tbody tr').click(function () {
            var thisRow = $(this);
            if (thisRow.attr('class') != 'footerRow') {
                var oldSelRow = elem.find('tbody tr.selectedRow');
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
        });* /
    }*/
    

    function theadInputChec(elem) {
        elem.find('thead tr th input:checkbox').click(function () {
            if (elem.find('thead tr th input:checkbox').prop('checked')) {
                elem.find('tbody input:checkbox:checkbox').attr('checked', 'checked');
            }
            else {
                elem.find('tbody input:checkbox:checkbox').removeAttr('checked');
            }
        });
    }

    function loadNewPage(elem, url, loadType, pageNum, userUpdateParamFunc, trClickFunk, updateTableFunc, viewTfoot) {
      addPreload(elem);
      
        if (viewTfoot) {
            //if (url.split('?').length > 1) url += url + '?';
            var pr = params(elem);
            url += '?pageNum=' + pageNum;
            url += '&pageSize=' + pr.pageSize;
            url += '&sort=' + pr.sort;
            url += '&sortdir=' + pr.sortdir;
        }
        var userParams = null;
        if (userUpdateParamFunc != null) {
            userParams = userUpdateParamFunc(loadType, pageNum);
        }
        $.post(url, userParams /*userUpdateParamFunc(loadType,pageNum)*/ /*updateParam(loadType,pageNum)*/, function getResp(data) {
            switch (data) {
                case '':
                    elem.find('tbody').html('<tr class="statusRow"><td colspan="200">Відсутні данні по заданому фільтру</td></tr>');
                    elem.find('tfoot .button[name="btRight"]').hide();
                    break;
                case 'NoData':
                    elem.find('tbody').html('<tr class="statusRow"><td colspan="200">Відсутні данні по заданому фільтру</td></tr>');
                    elem.find('tfoot .button[name="btRight"]').hide();
                    break;
                case 'errDate':
                    elem.find('tbody').html('<tr class="statusRow"><td colspan="200">Некоректно задано значення дат</td></tr>');
                    elem.find('tfoot .button[name="btRight"]').hide();
                    break;
                case 'end':
                    $('.selectedRow').html('');
                    elem.find('tfoot .button[name="btRight"]').hide();
                    break;
                default:
                    var domElement = $(data);
                    if (viewTfoot) {
                        var par = params(elem);
                        if (domElement.length > par.pageSize) {
                            domElement = domElement.slice(0, par.pageSize);
                            elem.find('tfoot .button[name="btRight"]').show();
                        }
                        else {
                          if (domElement.length == 0) {
                            domElement = '<tr style="text-align: center"><td colSpan=200>Відсутні дані для перегляду.</td></tr>';
                          }
                          elem.find('tfoot .button[name="btRight"]').hide();
                        }
                        if (pageNum == 1) {
                            elem.find('tfoot .button[name="btLeft"]').hide();
                        }
                        else {
                            elem.find('tfoot .button[name="btLeft"]').show();
                        }
                    }                
                    elem.find('tbody').html(domElement);
                    //tbodyTrClick(elem,trClickFunk);
                    changeRowNumber(elem, url, userUpdateParamFunc, trClickFunk, updateTableFunc);
                    selNewPage(elem, url, userUpdateParamFunc, trClickFunk, updateTableFunc);
                    paintRows(elem);
                    break;
            }
            if (updateTableFunc) updateTableFunc.call();
            elem.find('thead tr th input:checkbox').removeAttr('checked');
            removePreload(elem);
        });
    }

    function paintRows(elem) {
        $(elem).find('tbody tr:even:not([class="footerRow"])').attr('class', 'normalRow');
        $(elem).find('tbody tr:odd:not([class="footerRow"])').attr('class', 'alternateRow');
    }

    function removeIcoSort(elem,options) {
        elem.find('thead tr th a[name="sort"], table thead tr th a[name="sort"]').remove();
        elem.data('sort', options.sort);
        elem.data('sortdir',options.sortDir);
    }

    function params(elem) {
      var param = {
        pageNum: parseInt(elem.find('tfoot .pageNum').html()),
        pageSize: parseInt(elem.find('tfoot input[name="rowNumber"]').val()),
        sort: elem.data('sort'),
        sortdir: elem.data('sortdir')
      };
        return param;
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
            sort: '',
            sortDir: 'ASC',
            buttonToUpdateId: '',
            viewFilter: true
        }, options);
            var elem = this;

            var make = function () {
                theadInputChec(elem);

                elem.addClass('jungGridView');

                elem.data('sort', options.sort);
                elem.data('sortdir', options.sortDir);

                if (options.buttonToUpdateId != '') {
                    $('#' + options.buttonToUpdateId).click(function () {
                        elem.find('tfoot input[name="rowNumber"]').val(options.pageSize);
                        elem.find('tfoot input[name="rowNumber"]').attr('data-oldvalue', options.pageSize);
                        elem.find('tfoot .pageNum').html('1');
                        elem.find('tfoot .button[name="btLeft"]').hide();
                        loadNewPage(elem, options.updateTableUrl, 'start', 1, options.userUpdateParamFunc, options.trClickFunk, options.updateTableFunc, options.viewTfoot);
                        removeIcoSort(elem,options);
                    });
                }

                elem.find('thead tr th div').on('click', function () {
                  
                  var $this = $(this);
                    if ($this.prop('data-sortdir') != undefined) {
                        removeIcoSort(elem,options);
                        //elem.find('table thead tr th div span.spanIcoSortASC, table thead tr th div span.spanIcoSortDESC').remove();//.each(function (indx, element) { $(element).remove();});

                        var sort = $this.attr('data-sort');
                        var sortDir = $this.attr('data-sortdir');

                        var spanSortIco = '<a class="button" href="#" name="sort" onclick="return false;"><span class="icon sort' + $(this).attr('data-sortdir') + '"></span></a>';
                        //alert('sort'+$(this).attr('data-sortdir'));
                        var prop = sortDir == 'ASC' ? 'DESC' : 'ASC';
                        var thisHtml = $this.html();
                        thisHtml = spanSortIco+thisHtml;
                        $this.html(thisHtml);
                        $this.prop('data-sortdir', prop);//$(this).prop('data-sortdir')=='ASC' ? 'DESC' : 'ASC';
                        elem.find('tfoot .pageNum').html('1');

                        elem.data('sort', sort);
                        elem.data('sortdir', sortDir);

                        loadNewPage(elem, options.updateTableUrl, '', 1, options.userUpdateParamFunc, options.trClickFunk, options.updateTableFunc, options.viewTfoot);
                    }
                }).addClass('colName');
                if (options.viewTfoot) {
                    var tfoot = elem.find('tfoot');
                    var colspan = elem.find('thead tr th').length;
                    var navigateLeft = '<a style="display:none;" class="button" name="btLeft" href="#" onclick="return false;"><span class="icon navigateLeft"></span></a>'/*'<img style="display:none;" class="btNavigateLeft" alt="' + (options.pageNum - 1) + '" src="/Common/Images/default/16/navigate_left.png" />'*/;
                    var navigateRight = '<a style="display:none;" class="button" name="btRight" href="#" onclick="return false;"><span class="icon navigateRight"></span></a>' /*'<img style="display:none;" class="btNavigateRight" alt="'+(options.pageNum + 1) +'" src="/Common/Images/default/16/navigate_right.png" />'*/;

                    tfoot.html('<tr> \
                                    <td colspan="'+colspan+'"> \
                                            <span class="text">Сторінка:</span>\
                                            '+ navigateLeft + '\
                                            <span class="pageNum text" name="pageNum">'+options.pageNum+'</span>\
                                            '+navigateRight+'\
                                            <span style="margin-left:50px" class="text">Рядків на сторінці:</span>\
                                            <input id="rowNumber" name="rowNumber" class="rowNumber" data-oldvalue="'+options.pageSize+'" type="text" value="'+options.pageSize+'"  >\
                                            <a href="#" onclick="return false;" name="refresh" style="display:none;"></a>\
                                    </td>\
                                </tr>');
                }

                var dialogFilter = $('<div />');
                dialogFilter.attr('name', 'dialogFilter').addClass('dialogFilter');
                var select = $('<div><select onkeypress=""><option selected value=0></option><option value=1>=</option><option value=2>&lt;</option><option value=3>&gt;</option><option value=4>&lt;=</option><option value=5>&gt;=</option><option value=6>&lt;&gt;</option><option value=9>СХОЖИЙ</option><option value=10>НЕ СХОЖИЙ</option><option value=7>ПУСТИЙ</option><option value=8>НЕ ПУСТИЙ</option><option value=11>ОДИН З</option><option value=12>ЖОДЕН З</option></select></div>');
                var input = $('<div><input type="text" /></div>');
                dialogFilter.append(select);
                dialogFilter.append(input);
                if (options.viewFilter) {
                  elem.find('thead tr th div').quickEach(function() {
                    if (this.data('sort') != undefined && this.data('sort') != '') {
                      this.css('margin-right', '16px').wrap('<div style="position:relative;"/>');
                      var divBtFilt = $('<div/>');
                      divBtFilt.addClass('addFilter').on('mouseup', function () {
                        var $this = $(this);
                        var curentDialog = $this.parent().find('div.dialogFilter');
                        curentDialog.css('display', 'block');
                        $this.one('click',function () { return false; });
                        // TODO: діалог фільтра закривається в момент першого кліку тобто в момент відкритття
                        $(document).one('click', function() {
                          curentDialog.css('display', 'none');
                          if (curentDialog.find('input').val() != '') {
                            divBtFilt.addClass('filter');
                          } else {
                            divBtFilt.removeClass('filter');
                          }
                        });
                        curentDialog.on('click', function () { return false; });
                        curentDialog.find('input[type="text"], select').on('keypress', function(e) {
                          if (e.keyCode == 13) {
                            curentDialog.css('display', 'none');
                            elem.jungGridView('refresh');
                          }
                        });
                      });
                      var newDialogFilter = dialogFilter.clone();
                      this.parent().append(divBtFilt).append(newDialogFilter);
                    }
                  });
                }

                elem.find('tfoot tr td a[name="refresh"]').click(function () {
                    //elem.find('tfoot input[name="rowNumber"]').val(options.pageSize);
                    //elem.find('tfoot input[name="rowNumber"]').attr('data-oldvalue', options.pageSize);
                    //elem.find('tfoot .pageNum').html('1');
                    //elem.find('tfoot .button[name="btLeft"]').hide();
                    loadNewPage(elem, options.updateTableUrl, '', $(elem).find('span[name="pageNum"]').html(), options.userUpdateParamFunc, options.trClickFunk, options.updateTableFunc, options.viewTfoot);
                    //removeIcoSort(elem,options);
                });
                //selNewPage(elem,options.updateTableUrl,options.userUpdateParamFunc,options.trClickFunk,options.updateTableFunc,options.viewTfoot)
                bindTfoot(elem, options.updateTableUrl, options.userUpdateParamFunc,options.trClickFunk, options.updateTableFunc);
                tbodyTrClick(elem,options.trClickFunk);
                paintRows(elem);

                var countRow = elem.find('tbody tr').length;
                if (countRow == 0) {
                    elem.find('tbody').html('<tr style="text-align:center;"><td colspan="200">Відсутні дані для перегляду.</td></tr>');

                }
                else {
                    if(countRow>options.pageSize){
                        elem.find('tfoot .button[name="btRight"]').show();
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
                sort: '1',
                sortdir:'ASC',
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
                    thisTable.find('tfoot .button[name="btLeft"]').hide();
                    loadNewPage(thisTable, options.updateTableUrl,'start',1,options.userUpdateParamFunc,options.trClickFunk,options.updateTableFunc,options.viewTfoot);
                    removeIcoSort(thisTable,options);
                });

                //tbodyTrClick(elem,options.trClickFunk);
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
            elem.find('tfoot tr td a[name="refresh"]').click();
        },
        //поверне з ид-шніками відмічених рядків
        checked: function (options) { 
            options = $.extend({
                pageNum:null
            }, options);

            var elem = this;
            var checkDoc = elem.find('tbody input:checkbox:checked');
            var result = new Object();
            result.length = 0;
            result.arr = new Object();
            checkDoc.quickEach(function () {
              result.arr[result.length++] = this.val();
            });
            return result;
        },

        hide: function () {
            // ПРАВИЛЬНЫЙ
        },
        update: function () {
            // !!!
        }

    };

  $.fn.jungGridView = function(method) {
    if (methods[method]) {
      return methods[method].apply(this, Array.prototype.slice.call(arguments, 1));
    } else if (typeof method === 'object' || !method) {
      return methods.init.apply(this, arguments);
    } else {
      $.error('Метод с именем ' + method + ' не существует');
    }
    return $.error('Метод с именем ' + method + ' не существует');
  };

})( jQuery );