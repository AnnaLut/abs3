<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AddRegularPayment.aspx.cs" Inherits="dedosit_AddRegularPayment" %>

<!DOCTYPE html>

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
    <h1>Новий регулярний платіж</h1>    
    <form id="AddRegunarPaymentForm" runat="server">
      <div id="saveResult" runat="server"></div>
      <input id="IDD" type="hidden" runat="server" />
      <input id="RNK" type="hidden" runat="server" />
      <input id="CodVal" type="hidden" runat="server" />
      <style>
        #AddRegunarPaymentForm table tr td { padding: 1px;}      
      </style>
      <div  style="padding-left: 15px;">
        <table>
          <tr>
            <td>
              <span id="lbAccountNLS" runat="server" title="Картковий рахунок в валюті договора (Рахунок відправника)" class="k-label">
                Картковий рахунок (Рахунок відправника)
              </span>
            </td>
            <td>
              <span class="k-textbox k-space-right">
                <input ID="NLSAtext" type ="text" runat="server"
                    maxlength="14" title="Номер рахунку" tabindex="1" />
                <input id="NLSA" type="hidden" runat="server" />
                <a href="#" onclick="SearchAccounts('BPK190', 'textBankAccount', 'textBankMFO', 'textIntRcpOKPO', 'textIntRcpName');" class="k-icon k-i-search">&nbsp;</a>
              </span>
            </td>
          </tr>
          <tr>
            <td>
              <span ID="lbBankMFO" runat="server" class="k-label" >МФО банку</span>
            </td>
            <td>
              <input id="MFOtext" runat="server" type="text" class="k-textbox" disabled
                     maxlength="12" title="МФО банка" tabindex="2" />
              <input id="MFO" type="hidden" runat="server" />
            </td>
          </tr>
          <tr>
            <td>
              <span ID="lbIntRcpName" runat="server" class="k-label">Назва клієнта-платника</span>
            </td>
            <td>
              <input id="NMKtext" runat="server" type="text" class="k-textbox" disabled 
                          maxlength="35" title="Назва клієнта-платника" tabindex="3" style="width: 300px" />
              <input id="NMK" type="hidden" runat="server" />
            </td>
          </tr>
          <tr>
            <td>
              <span ID="lbIntRcpOKPO" runat="server" class="k-label">Код ЄДРПОУ платника</span>
            </td>
            <td>
              <input id="OKPOtext" runat="server" type="text" class="k-textbox" disabled 
                           maxlength="10" title="Код ОКПО" tabindex="4"/>
              <input id="OKPO" type="hidden" runat="server" />
            </td>
          </tr>
          <tr>
            <td>
              <span id="nlsLabel" runat="server" class="k-label">Рахунок договору (Рахунок отримувача)</span>
            </td>
            <td>
              <input id="NLStext" runat="server" disabled class="k-textbox" tabindex="5" maxlength="14" title="Номер рахунку" />
              <input id="NLS" type="hidden" runat="server" />
            </td>
          </tr>
          <tr>
            <td>
              <span id="lbSumRegular" runat="server" class="k-label">Сума регулярного платежу</span>
            </td>
            <td>
              <textarea id="SUMtext" rows = "3" style="width: 300px" runat="server" disabled class="k-textbox" tabindex="6" ></textarea>
              <input id="SUM" type="hidden" runat="server" />
            </td>
          </tr>
          <tr>
            <td>
              <span id="lbNazn" runat="server" class="k-label" >Призначення платежу</span>
            </td>
            <td>
              <textarea id="textNazn" rows="4" tabindex="7" style="width: 300px" class="k-textbox" runat="server" title="Призначення платежу"></textarea> 
            </td>
          </tr>
          <tr>
            <td>
              <span id="lbStartDate" runat="server" class="k-label">Дата початку дії договору</span>
            </td>
            <td>
              <input id="StartDate" type="text" tabindex="8" runat="server" class=""/>
            </td>
          </tr>
          <tr>
            <td>
              <span id="lbEndDate" runat="server" class="k-label">Дата завершення договору</span>
            </td>
            <td>
              <input id="EndDate" type="text" tabindex="9" runat="server" class="" />
            </td>
          </tr>
          <tr>
            <td>
              <span id="lbFreq" runat="server" class="k-label">Періодичність</span>
            </td>
            <td>
              <select id="Freq" runat="server"  style="width: 300px" tabindex="10" class="style2"></select>
            </td>
          </tr>
          <tr>
            <td>
              <span id="lbWeek" runat="server" class="k-label">Врахування вихідних днів</span>
            </td>
            <td>
              <input id="Weekends" value="-1" runat="server" tabindex="11" type="radio" checked />
              <label for="Weekends">-1</label>
            </td>
          </tr>
          <tr>
            <td>
              <span id="lbPrior" runat="server" class="k-label">Прiоритет виконання</span>
            </td>
            <td>
              <select id="Prior" runat="server" tabindex="12" class="k-dropdown k-textbox"></select>
            </td>
          </tr>
          <tr>
            <td></td>
            <td style="padding-top: 10px;">
              <a id="btReg" onclick="savePayment();return false;" tabindex="13" data-role="button" class="k-primary k-button k-button-icontext" role="button" aria-disabled="false" tabindex="0">
                <span class="k-sprite k-icon k-i-tick"></span>
                Зберегти
              </a>
              <input id="btPrint" onclick="printDocum(); return false;" tabindex="14" type="button" value="Друк" runat="server" class="k-button" />
            </td>
          </tr>
        </table>
        </div>
    </form>
    <span id="popupError" style="display:none;"></span>
    <script>
      $(function () {
        $.ajaxSetup({
          // Disable caching of AJAX responses
          cache: false
        });

        $('#StartDate,#EndDate').kendoMaskedTextBox({
          mask: "99/99/9999"
        }).kendoDatePicker({
          culture: "uk-UA",
          format: "dd/MM/yyyy"
        }).removeClass('k-textbox').parent().parent().removeClass('k-textbox');
        /*$('#EndDate').kendoDatePicker({
          culture: "uk-UA",
          format: "dd/MM/yyyy"
        });*/

        $("#popupError").kendoNotification({
          stacking: "down",
          show: onShowPopupError,
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
        });
        document.getElementById('NMKtext').value = document.getElementById('NMK').value;
        $('#NMKtext').val($('#NMK').val());
      });
      function SearchAccounts(type) {
        var url = "DepositCardAcc.aspx?";
        url += "mfo=" + document.getElementById("MFO").value;
        url += "&okpo=" + document.getElementById("OKPO").value;
        url += "&rnk=" + document.getElementById("RNK").value;
        url += "&cur_id=" + document.getElementById("CodVal").value;
        url += "&type=" + type;
        url += "&code=" + Math.random();

        var result = window.showModalDialog(encodeURI(url), null,
        "dialogWidth:600px; dialogHeight:400px; center:yes; status:no");

        if (result != null) {
          document.getElementById('MFO').value = result.mfo;
          document.getElementById('MFOtext').value = result.mfo;
          document.getElementById('NLSA').value = result.nls;
          document.getElementById('NLSAtext').value = result.nls;
          document.getElementById('NMK').value = result.fio;
          document.getElementById('NMKtext').value = result.fio;
        }
      }

      function savePayment() {
        var valid = formAddPaymentValid();
        if (valid.status == 'ok') {
          kendo.ui.progress($("#AddRegunarPaymentForm"), true);
          $('#AddRegunarPaymentForm').submit();
        } else if (valid.status == 'error') {
          $('#popupError').data("kendoNotification").show({
            title: "Помилка",
            message: valid.message
          }, "error");
        }

      }
      function formAddPaymentValid() {
        var result = { status: 'ok', message: '' }

        var idd = $('#IDD').val();
        if (idd != "" && idd != "0") {
          result.status = 'error';
          result.message += '<div>Платіж № '+idd+' вже зареєстровано.</div>';
        }
        if ($('#NLSA').val() == "") {
          result.status = 'error';
          result.message += "<div>Не вибрано рахунок відправника.</div>";
        }
        if ($('#textSumRegular').val() == "") {
          result.status = 'error';
          result.message += "<div>Не заповнено суму платежу.</div>";
        }
      if ($('#StartDate').val() == "") {
          result.status = 'error';
          result.message += "<div>Не заповнено дату початку.</div>";
      }
      var startDateArray = $('#StartDate').val().split('/') //date format 'dd/MM/yyyy'
      var startDate = new Date(startDateArray[2], parseInt(startDateArray[1], 10) - 1, startDateArray[0])
      var endDateArray = $('#EndDate').val().split('/') //date format 'dd/MM/yyyy'yyyy'
      var endDate = new Date(endDateArray[2], parseInt(endDateArray[1], 10) - 1, endDateArray[0])
      
      var tmpDate = new Date();
      var systemDate = new Date(tmpDate.getFullYear(), tmpDate.getMonth(), tmpDate.getDay());

      if (startDate < systemDate) {
          result.status = 'error';
          result.message += "<div>Дата початку має буте більша за поточну або поточна.</div>";
      }
      if ($('#EndDate').val() == "") {
          result.status = 'error';
          result.message += "<div>Не заповнено дату завершення.</div>";
      }
      if (endDate < startDate) {
          result.status = 'error';
          result.message += "<div>Дата завершення має буте більша за дату початку.</div>";
      }      
        return result;
      }

      function onShowPopupError(e) {
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
      }
      function printDocum() {
        var idd = $('#IDD').val();
        if (idd == "" || idd == "0") {
          $('#popupError').data("kendoNotification").show({
            title: "Помилка",
            message: '<div>Документ не зареєстрований, друк не можливий.</div>'
          }, "error");
        } else {
          document.location.href = document.location.href + '&idd=' + idd + '&type=print';
        }
      }
    </script>
  </div>
</body>
</html>
