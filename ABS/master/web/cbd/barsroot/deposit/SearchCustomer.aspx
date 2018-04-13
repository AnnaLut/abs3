<%@ Page Language="c#" CodeFile="SearchCustomer.aspx.cs" AutoEventWireup="true" Inherits="deposit.SearchCustomer" EnableViewState="True" Debug="False" %>

<!DOCTYPE html >

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
  <title></title>
  <link href="../Content/Bootstrap/bootstrap.css" rel="stylesheet" />
  <link href="../Content/Themes/Kendo/kendo.common.min.css" rel="stylesheet" />
  <link href="../Content/Themes/Kendo/kendo.dataviz.min.css" rel="stylesheet" />
  <link href="../Content/Themes/Kendo/kendo.bootstrap.min.css" rel="stylesheet" />
  <link href="../Content/Themes/Kendo/kendo.dataviz.bootstrap.min.css" rel="stylesheet" />
  <link href="../Content/Themes/Kendo/Styles.css" rel="stylesheet" />
  <!-- Le HTML5 shim, for IE6-8 support of HTML5 elements -->
  <!--[if lt IE 9]>
  <script src="../scripts/html5shiv.js"></script>
  <script src="../scripts/respond.min.js"></script>
<![endif]-->
  <!--[if gt IE 6]>
  <style>
    input[type="text"]{padding:2px 4px;}
    input.date{background-position:1px 1px;}
  </style>
<![endif]-->
  <!--[if gte IE 7]>
    <style>
      input[type="text"]{padding:2px 4px;}
      input.date{background-position:3px 3px;}
    </style>
<![endif]-->
  <script src="../Scripts/jquery/jquery.js"></script>
  <script src="../Scripts/bootstrap/bootstrap.js"></script>
  <script src="../Scripts/jquery/jquery.bars.ui.js"></script>
  <script src="../Scripts/kendo/kendo.all.min.js"></script>
  <script src="../Scripts/kendo/kendo.aspnetmvc.min.js"></script>
  <script src="../Scripts/kendo/kendo.timezones.min.js"></script>

  <script src="../Scripts/kendo/cultures/kendo.culture.uk.min.js"></script>
  <script src="../Scripts/kendo/cultures/kendo.culture.uk-UA.min.js"></script>
  <script src="../Scripts/kendo/messages/kendo.messages.uk-UA.min.js"></script>
</head>
<body>
  <div>
    <h2>Пошук клієнта</h2>
    <form id="seachCustomerForm" method="post" runat="server" style="padding-left: 10px;">
      <style>
        #seachCustomerForm table tr td {
          padding: 1px;
        }
      </style>
      <table style="width: 100%">
        <tr>
          <td>
            <span id="lbNMK" runat="server" class="k-label">ПІБ</span>
          </td>
          <td style="width: 70%">
            <input id="textClientName" runat="server" type="text" class="k-textbox" 
              maxlength="35" title="ПІБ клієнта" tabindex="1" style="width: 100%" />
          </td>
        </tr>
        <tr>
          <td>
            <span id="lbId" class="k-label" runat="server">Ідентифікаційний код</span>
          </td>
          <td>
            <input id="textClientCode" runat="server" class="k-textbox" title="Ідентифікаційний код"
              maxlength="10" tabindex="2" />
          </td>
        </tr>
        <tr>
          <td>
            <span id="lbBirthDate" class="k-label" runat="server">Дата народження</span>
          </td>
          <td>
            <input id="textClientDate" runat="server" title="Дата народження" tabindex="3" />
          </td>
        </tr>
        <tr>
          <td>
            <span id="lbDocSerial" class="k-label" runat="server">Серія документа</span>
          </td>
          <td>
            <input id="textClientSerial" runat="server" class="k-textbox" title="Серія документа"
              maxlength="10" tabindex="4" />
          </td>
        </tr>
        <tr>
          <td>
            <span id="lbDocNumber" class="k-label" runat="server">Номер документа</span>
          </td>
          <td>
            <input id="textClientNumber" runat="server" class="k-textbox" title="Номер документа"
              maxlength="20" tabindex="5" />
          </td>
        </tr>
        <tr>
          <td></td>
          <td style="padding-top: 10px;">
            <a href="#" id="btSearchCustomer" onclick="SearchCustomer.search();return false;" data-role="button" class="k-primary k-button k-button-icontext" role="button" aria-disabled="false" tabindex="0">
              <span class="k-sprite k-icon k-i-search"></span>
              Пошук
            </a>
          </td>
        </tr>
      </table>

      <h3>Виберіть відповідний запис із знайдених</h3>
      <div style="margin-bottom: 5px;">
        <a href="#" id="btSelectCustomer" onclick="SearchCustomer.select();return false;" data-role="button" class="k-primary k-button k-button-icontext" role="button" aria-disabled="false" tabindex="0">
          <span class="k-sprite k-icon k-i-tick"></span>
          Вибрати
        </a>        
      </div>
      <div id="seachCustomerGrid"></div>
    </form>
    <script>
      $(function () {
        SearchCustomer.formInit();
        $.ajaxSetup({
          // Disable caching of AJAX responses
          cache: false
        });
      });

      var SearchCustomer = {
        _form: null,
        dataSource: {
          url: 'searchcustomer.aspx'
        },
        form: function () {
          if (this._form == null) {
            this._form = $('#seachCustomerForm');
          }
          return this._form;
        },
        formInit: function () {
          var $this = this;
          $this.form().data('SearchCustomer', this);
          $this.form().find('#textClientDate').kendoMaskedTextBox({
            mask: "99/99/9999"
          }).kendoDatePicker({
            culture: "uk-UA",
            format: "dd/MM/yyyy"
          }).removeClass('k-textbox').parent().parent().removeClass('k-textbox');

          $this.form().find('#textClientCode').kendoMaskedTextBox({ mask: "9999999999", promptChar: " " })/*.kendoNumericTextBox({ format: 'g' })*/
              .parent().removeClass('k-numeric-wrap')
                    .removeClass('k-state-default')
                    .removeClass('k-state-focused')
              .parent()
                    .removeClass('k-widget')
                    .removeClass('k-numerictextbox')
                    .removeClass('k-textbox')
              .find(".k-select").hide();

          $this.form().find("#seachCustomerGrid").kendoGrid({
            dataSource: {
              data: $this.response.data,
              schema: {
                model: {
                  fields: {
                    Edrpo: { type: "string" },
                    Fio: { type: "string" },
                    DocumType: { type: "string" },
                    DocumNumber: { type: "string" },
                    Address: { type: "string" },
                    Branch: { type: "string" }
                  }
                }
              },
              pageSize: 5
            },
            height: 250,
            selectable: "multiple",
            groupable: false,
            sortable: true,
            pageable: {
              refresh: true,
              pageSizes: true,
              buttonCount: 5
            },
            columns: [{
              field: "Edrpo",
              title: "Ідент. код",
              width: 80
            }, {
              field: "Fio",
              title: "ПІБ",
              width: 250
            }, {
              field: "DocumType",
              title: "Тип документа",
              width: 120
            }, {
              field: "DocumSeries",
              title: "серія",
              width: 80
            }, {
              field: "DocumNumber",
              title: "номер",
              width: 80
            }, {
              field: "Address",
              title: "Адреса",
              width: 250
            }, {
              field: "Branch",
              title: "Відділення",
              width: 160
            }]
          });
        },
        search: function () {
          var $this = this;
          var valid = $this.validateForm();
          if (valid.status == 'error') {
            $this.showError(valid.message);
          } else {
            kendo.ui.progress($this.form(), true);
            $.post($this.dataSource.url, $this.request(), function (result) {
              kendo.ui.progress($this.form(), false);
              if (result.Status == 'ok') {
                $this.response.data = result.Data;
                $this.form().find('#seachCustomerGrid').data('kendoGrid').dataSource.data($this.response.data);
              } else {
                $this.showError(result.Message);
              }
            }, 'json');
          }
        },
        select: function() {
          var grid = this.form().find("#seachCustomerGrid").data("kendoGrid");
          var selectedItem = grid.dataItem(grid.select());
          if (selectedItem == null) {
            this.showError('Не вибрано жодного клієнта');
          } else {
            var parentFrame = window.frameElement;
            if (parentFrame) {
              var $parentFrame = parent.window.$(parentFrame);
              $parentFrame.data('result',selectedItem);
              $parentFrame.parent().data('kendoWindow').close();
            } 
          }
        },
        request: function () {
          return {
            fio: this.form().find('#textClientName').val(),
            edrpo: this.form().find('#textClientCode').val(),
            birthDate: this.form().find('#textClientDate').val(),
            documSeries: this.form().find('#textClientSerial').val(),
            documNumber: this.form().find('#textClientNumber').val()
          }
        },
        response: {
          status: '',
          data: new Array()
        },
        validateForm: function () {
          var result = new this.ValidateStatus();
          if (this.form().find('#textClientName').val() == ''
              && this.form().find('#textClientCode').val() == ''
              && this.form().find('#textClientDate').val() == ''
              && this.form().find('#textClientSerial').val() == ''
              && this.form().find('#textClientNumber').val() == '') {
            result.Status = 'error';
            result.Message += "<div>Не достатньо параметрів для пошуку</div>";
          }
          return result;
        },
        showError: function (text) {
          var $this = this;
          var popup = $('<div />', { id: 'searchCustomerPopupError' });
          popup.append('body');
          popup.kendoNotification({
            stacking: "down",
            show: $this._onShowPopupError,
            hide: function () { popup.remove(); },
            autoHideAfter: 40000,
            width: '350px',
            templates: [{
              type: "error",
              template: '<div style="padding:10px;">\
                     <div class="k-notification-wrap"><h3 style="margin-top:0"><span class="k-icon k-i-note">error</span> #= title #</h3><span class="k-icon k-i-close">Hide</span></div>\
                        <p>#= message #</p>\
                    </div>'
            }],
            button: true
          }).data("kendoNotification").show({
            title: "Помилка",
            message: text
          }, "error");
        },
        _onShowPopupError: function (e) {
          if (!$("." + e.sender._guid)[1]) {
            var element = e.element.parent(),
                eWidth = element.width(),
                eHeight = element.height(),
                wWidth = $(window).width(),
                wHeight = $(window).height(),
                newTop, newLeft;
            newLeft = Math.floor(wWidth / 2 - eWidth / 2);
            newTop = Math.floor(wHeight / 2 - eHeight / 2);
            e.element.parent().css({ top: newTop, left: newLeft });
          }
        },
        ValidateStatus: function () {
          this.Status = '';
          this.Message = '';
        }
      };

    </script>
  </div>
</body>
</html>
