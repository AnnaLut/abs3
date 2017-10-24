(function ($) {
  function gridLoader(gridLoad) {
    gridLoad.find('tfoot tr td a[data-use="gridrefresh"]').html('<i class="icon-spinner icon-spin orange"></i>');
  }
  function gridLoaderRemove(gridLoad) {
    gridLoad.find('tfoot tr td a[data-use="gridrefresh"]').html('<i class="icon-refresh"></i>');
  }
  function gridAjaxLoading(urlData, gridLoad, data, afterLoadFunc) {
    var splitUrl = urlData.split('?');
    gridLoad.data('selected-row', null);
    var url = gridLoad.data('ajax-loading-url') + '?' + (splitUrl.length > 1 ? splitUrl[1] : splitUrl[0]);
    var thisTable = gridLoad.find('table').parent();
    if (!gridLoad.data('isloading')) {
      gridLoad.data('isloading', 'false');
    }
    if (gridLoad.data('isloading') == 'false') {
      gridLoad.data('isloading', 'true');
      gridLoader(gridLoad);
      if (typeof data === 'function') {
        data = data.call();
      }
      $.post(url, $.extend(data, { 'grid-RenderRowsOnly': 'true' }), function (loadingData) {
        thisTable.empty();
        thisTable.html(loadingData);
        //todo: добавити обробку функцій
        initClearFilterButton(thisTable.find('table'));
        //initHoverFilter(thisTable.find('table'));
        pageGrids[gridLoad.data('gridname')].initFilters();
        gridLoad.data('isloading', 'false');
        gridLoaderRemove(gridLoad);
        if (afterLoadFunc) {
          afterLoadFunc.call();
        }
        gridLoad.find('tfoot tr td div.grid-footer div.grid-pager ul.pagination li select').attr('onchange', null);
      });
    }
  }


  var methods = {
    init: function(options) {
      options = $.extend({ url: document.location.href, updateData: null, afterLoadFunc:null }, options);
      var grid = $(this);
      grid.data('afterLoadFunc', options.afterLoadFunc);
      grid.data('updateData', options.updateData);
      grid.data('ajax-loading-url', options.url);

      GridMvc.prototype.applyFilterValues = function (initialUrl, columnName, values, skip) {
        var filters = this.jqContainer.find(".grid-filter");
        if (initialUrl.length > 0) {
          initialUrl += "&";
        } else {
          initialUrl += "?";
        }

        var url = "";
        if (!skip) {
          url += this.getFilterQueryData(columnName, values);
        }

        if (this.options.multiplefilters) { //multiple filters enabled
          for (var i = 0; i < filters.length; i++) {
            if ($(filters[i]).attr("data-name") != columnName) {
              var filterData = this.parseFilterValues($(filters[i]).attr("data-filterdata"));
              if (filterData.length == 0) continue;
              if (url.length > 0) url += "&";
              url += this.getFilterQueryData($(filters[i]).attr("data-name"), filterData);
            } else {
              continue;
            }
          }
        } 
        if (grid.data('ajax-loading-url') != null) {
          gridAjaxLoading(initialUrl + url, this.jqContainer, options.updateData, options.afterLoadFunc);
        } else {
          window.location.search = initialUrl + url;
        }
      };

      var table = grid.find('table').parent();
      table.on('click', 'tfoot tr td div.grid-footer div.grid-pager ul.pagination li a:not([data-use="gridexpexel"])', function () {
        gridAjaxLoading($(this).attr('href'), grid, options.updateData, options.afterLoadFunc);
        return false;
      });
      table.on('click', 'thead tr th div.grid-header-title a', function() {
        gridAjaxLoading($(this).attr('href'), grid, options.updateData, options.afterLoadFunc);
        return false;
      });
      table.find('tfoot tr td div.grid-footer div.grid-pager ul.pagination li select').attr('onchange',null);
      table.on('change', 'tfoot tr td div.grid-footer div.grid-pager ul.pagination li select', function() {
        var urlData = table.find('tfoot a[data-use="gridrefresh"]').attr('href');
        urlData = urlData.replace(/grid-page-size=\d*/, '').replace(/grid-page=\d*/, 'grid-page=1');
        gridAjaxLoading(urlData + '&grid-page-size=' + $(this).val(), grid, options.updateData, options.afterLoadFunc);
      });


    },
    reload: function () {
      var grid = $(this);
      var urlData = grid.find('tfoot a[data-use="gridrefresh"]').attr('href');
      //urlData = urlData.replace(/&grid-page-size=\d*/, '').replace(/grid-page=\d*/, 'grid-page=1');
      gridAjaxLoading(urlData, grid, grid.data('updateData'), grid.data('afterLoadFunc'));
    }
  };
  $.fn.ajaxLoading = function(method) {
    if (methods[method]) {
      return methods[method].apply(this, Array.prototype.slice.call(arguments, 1));
    } else if (typeof method === 'object' || !method) {
      return methods.init.apply(this, arguments);
    } else {
      return $.error('Метод с именем ' + method + ' не существует');
    }
  };
})(jQuery);
/*
$.extend($.gridmvc, {
  initAjaxLoading: function (url) {
    var grid = $(this);
    grid.data('ajax-loading-url', url);
    var table = grid.find('table');
    table.on('click', 'tfoot tr td div.grid-footer div.grid-pager ul.pagination li a', function() {
      gridAjaxLoading(this.getAttribute('href'), grid);
      return false;
    });
    table.on('click', 'thead tr th div.grid-header-title a', function() {
      gridAjaxLoading(this.getAttribute('href'), grid);
      return false;
    });
    table.on('change', 'tfoot tr td div.grid-footer div.grid-pager ul.pagination li select', function() {
      var urlData = table.find('tfoot a[data-use="gridrefresh"]').attr('href');
      //alert(urlData.split('grid-page-size').length);
      //if (urlData.split('grid-page-size').length > 1) {
      urlData = urlData.replace(/&grid-page-size=\d* /, '').replace(/grid-page=\d* /, 'grid-page=1');
      //}
      gridAjaxLoading(urlData + '&grid-page-size=' + $(this).val(), grid);
    });
  },
  gridLoader: function(grid) {
    grid.find('tfoot tr td a[data-use="gridrefresh"]').html('<i class="icon-spinner icon-spin orange"></i>');
  },
  gridLoaderRemove: function(grid) {
    grid.find('tfoot tr td a[data-use="gridrefresh"]').html('<i class="icon-refresh"></i>');
  },
  gridAjaxLoading: function(urlData, grid, data) {
    var url = grid.data('ajax-loading-url') + urlData;
    var table = grid.find('table');
    if (!grid.data('isloading')) {
      grid.data('isloading', 'false');
    }
    if (grid.data('isloading') == 'false') {
      grid.data('isloading', 'true');
      gridLoader(grid);
      $.post(url, $.extend(data, { 'grid-RenderRowsOnly': 'true' }), function(loadingData) {
        table.empty();
        table.html(loadingData);
        pageGrids[grid.data('gridname')].initFilters();
        grid.data('isloading', 'false');
        gridLoaderRemove(grid);
      });
    }
  }
});*/








