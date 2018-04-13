<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AddRegular.aspx.cs" Inherits="deposit_AddRegular" %>

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
  <style>
    #addRegularForm table tr td {
      padding: 1px;
    }
  </style>
  <h1>Кредити - погашення заборгованості з карткового рахунку (регулярні платежі)</h1>
    <form id="addRegularForm" method="GET" runat="server">
      <asp:ScriptManager runat="server"></asp:ScriptManager>
      <div style="padding-left: 15px;">
        <table>
          <tr>
            <td> 
              <span ID="lbClientInfo" class="k-label" runat="server">Клієнт</span>
            </td>
            <td class="style3">
              <a id="btSearch" onclick="openSearchCustDialog();return false;" data-role="button" class="k-button k-button-icontext" role="button" aria-disabled="false" tabindex="0">
                <span class="k-sprite k-icon k-i-search"></span>
                Пошук
              </a>
              <input id="NMK" runat="server" type="text" class="k-textbox"
                disabled maxlength="12"
                tabindex="1" style="width: 500px" />

            </td>
          </tr>
          <tr>
               <td> 
                 <asp:Label ID="lbContractType" runat="server" CssClass="InfoText">Реєстраційний номер клієнта</asp:Label>
               </td>
               <td class="style3">
                 <input ID="RNKtext" runat="server" 
                        class="k-textbox" disabled maxlength="12" 
                        TabIndex="2" style="width: 100px"/>    
                 <input type="hidden" id="RNK" name="RNK" runat="server" value=""/> 
               </td>
          </tr>
          <tr>
               <td> 
                 <asp:Label ID="lbContractID" runat="server" CssClass="InfoText">№ кредитного договору</asp:Label>
               </td>
               <td class="style3">
                 <select id="NdList" style="width: 100%" class="k-dropdown k-textbox" runat="server" onchange="onNdListChange();" ></select>
<%--                   <asp:DropDownList ID="NdList" style="width: 500px" TabIndex="3" runat="server"  class="k-dropdown k-textbox" ReadOnly="False" AutoPostBack="True" >
                   </asp:DropDownList>--%>
               </td>
          </tr>
          <tr>
              <td class="style2"> 
                <asp:Label ID="lbCur" runat="server" CssClass="InfoText">Рахунок погашення</asp:Label>
              </td>
              <td>
                <div id="NLSblock" runat="server">
                  <input id="NLStext" runat="server" class="k-textbox" disabled MaxLength="12" 
                       TabIndex="4" BackColor="WhiteSmoke" style="width: 200px"/>
                  <input type="hidden" id="NLS" value="" runat="server"/>
                  <input type="hidden" id="CodeVal" value="" runat="server"/>
                  <span id="NLSblockErrorText" runat="server"></span>
                </div>
              </td>
           </tr>
        </table>
      </div>
      <div style="display: none" runat="server" id="regPrForCurentCust">
        <h2 style="padding-top: 15px">Перелік існуючих ДУ про регулярні платежі клієнта</h2>
        <div runat="server" id="addRegPlButtonBlock" style="margin-bottom: 10px;display: none">
          <a id="addRegPlButton" onclick="openAddRegularWindow();return false;" data-role="button" class="k-button k-button-icontext" role="button" aria-disabled="false" tabindex="0">
            <span class="k-sprite k-icon k-add"></span>
            Створити новий регулярний платіж
          </a>
        </div>
          <div id="gridRegularBlock" style="">
            <asp:datagrid id="gridRegular" runat="server" 
                CssClass="BaseGrid" EnableViewState="False" HorizontalAlign="Left"
		    	AutoGenerateColumns="False" style="margin-right: 0">
              
              <Columns>
		    		<asp:BoundColumn DataField="ord" HeaderText="Пріоритет">
		    			<HeaderStyle Width="2%"></HeaderStyle>
		    		</asp:BoundColumn>
		    		<asp:BoundColumn DataField="freq" HeaderText="Періодичність">
		    			<HeaderStyle Width="2%"></HeaderStyle>
		    		</asp:BoundColumn>
                    <asp:BoundColumn DataField="DAT1" HeaderText="З">
		    			<HeaderStyle Width="2%"></HeaderStyle>
		    		</asp:BoundColumn>
                    <asp:BoundColumn DataField="DAT2" HeaderText="По">
		    			<HeaderStyle Width="3%"></HeaderStyle>
		    		</asp:BoundColumn>
                    <asp:BoundColumn DataField="nlsa" HeaderText="Рахунок А">
		    			<HeaderStyle Width="3%"></HeaderStyle>
		    		</asp:BoundColumn>
		    		<asp:BoundColumn DataField="nlsb" HeaderText="Рахунок B">
		    			<HeaderStyle Width="15%"></HeaderStyle>
		    		</asp:BoundColumn>								
                    <asp:BoundColumn DataField="FSUM" HeaderText="Сума" >
		    			<HeaderStyle Width="15%"></HeaderStyle>
                        <ItemStyle CssClass="money"></ItemStyle>
		    		</asp:BoundColumn>						    
                    <asp:BoundColumn DataField="NAZN" HeaderText="Призначення">
		    			<HeaderStyle Width="45%"></HeaderStyle>
		    		</asp:BoundColumn>
		    	</Columns>
		    </asp:datagrid>
                        <script>
                          function bindGridRegular() {
                            var grid = $("#gridRegular");
                            grid.prepend('<thead><tr>\
                                <th data-field="ord">Пріоритет</th>\
                                <th data-field="freq">Періодичність</th>\
                                <th data-field="DAT1">З</th>\
                                <th data-field="DAT2">По</th>\
                                <th data-field="nlsa">Рахунок A</th>\
                                <th data-field="nlsb">Рахунок B</th>\
                                <th data-field="FSUM">Сума</th>\
                                <th data-field="NAZN">Призначення</th>\
                            </tr></thead>');
                            grid.find('tbody tr').eq(0).remove();
                            grid.kendoGrid({
                              //height: 550,
                              selectable:true,
                              sortable: true,
                              columns: [{
                                field: "ord",
                                title: "Пріоритет",
                                width: 80
                              }, {
                                field: "freq",
                                title: "Періодичність",
                                width: 100
                              }, {
                                field: "DAT1",
                                title: "З",
                                width: 60
                              }, {
                                field: "DAT2",
                                title: "По",
                                width: 60
                              }, {
                                field: "nlsa",
                                title: "Рахунок A",
                                width: 110
                              }, {
                                field: "nlsb",
                                title: "Рахунок B",
                                width: 110
                              }, {
                                field: "FSUM",
                                title: "Сума",
                                attributes: {
                                  "class": "money"//,
                                  //style: "text-align: right; font-size: 14px"
                                },
                                width: 160
                              }, {
                                field: "NAZN",
                                title: "Призначення"
                              }]
                            });
                          }
                          $(document).ready(function () {
                            bindGridRegular();
                          });
                        </script>
          </div>
       

      </div>
    </form>
  
  <div id="addRegularWindow"></div>
  <span id="popupError" style="display:none;"></span>
  <script type="text/javascript">
    $(function () {
      $.ajaxSetup({
        // Disable caching of AJAX responses
        cache: false
      });
      $("#addRegularWindow").kendoWindow({
        actions: ["Refresh", "Maximize", "Minimize", "Close"],
        draggable: true,
        height: "550px",
        visible: false,
        modal: true,
        pinned: false,
        resizable: false,
        title: "",
        width: "520px",
        position: "center",
        iframe: true,
        content: "",
        close: function (e) {
          e.sender.element.context.innerHTML = '';
          reloadGrid();
        },
        refresh: function () {
          //var iframe = $(this.element).find("iframe");
          kendo.ui.progress($("#addRegularWindow"), false);
        }
      });

      $("#popupError").kendoNotification({
        stacking: "down",
        show: onShowPopupError,
        autoHideAfter: 20000,
        width: '350px',
        templates: [{
          type: "error",
          template: '<div style="padding:10px;">\
                     <div class="k-notification-wrap"><h2><span class="k-icon k-i-note">error</span> #= title #</h2><span class="k-icon k-i-close">Hide</span></div>\
                        <p>#= message #</p>\
                    </div>'
        }],
        button: true
      });
    });

    function openAddRegularWindow() {
      var url = 'AddRegularPayment.aspx';
      var rnk = document.getElementById('RNK').value;
      if (rnk == "") {
        $('#popupError').data("kendoNotification").show({
          title: "Помилка",
          message: "Не вибрано клієнта."
        }, "error");
        return;
      }
      var nls = document.getElementById('NLS').value;
      if (nls == "") {
        $('#popupError').data("kendoNotification").show({
          title: "Помилка",
          message: "Не вибрано рахунок погашення."
        }, "error");
        return;
      }
      var nd = document.getElementById('NdList').value;
      var codeval = document.getElementById('CodeVal').value;
      var windowAddPl = $("#addRegularWindow").data("kendoWindow");
      var content = {};
      content.url = url + '?rnk='+rnk +'&nls='+nls +'&nd=' + nd + '&codeval=' + codeval;
      windowAddPl.options.content = content;
      windowAddPl.center().open().refresh();
      kendo.ui.progress($("#addRegularWindow"), true);
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

    function onLoadAddRegularWindow() {
      kendo.ui.progress($("#addRegularWindow"), false);
    }

    // Виклик модального діалогу пошуку клієнтів
    function openSearchCustDialog() {
      var dialog = $('<div/>', { id: 'searchCustDialog' });
      dialog.append('body');
      //kendo.ui.progress(dialog,true);
      dialog.kendoWindow({
        actions: ["Refresh", "Maximize", "Minimize", "Close"],
        draggable: true,
        height: "600px",
        width: "630px",
        visible: false,
        modal: true,
        pinned: false,
        resizable: true,
        title: "",
        position: "center",
        iframe: true,
        content:'SearchCustomer.aspx?code=' + Math.random(),
        close: function (e) {
          var result = dialog.find('iframe').data('result');
          dialog.remove();
          if (result) {
            document.getElementById("RNK").value = result.Rnk;
            $('#addRegularForm').submit();
          }
        },
        refresh: function () {
          //kendo.ui.progress($("#addRegularWindow"), false);
        }
      }).data("kendoWindow").center().open();

      /*var url = "SearchCustomer.aspx?code=" + Math.random();
      var result = window.showModalDialog(url,  "dialogWidth:600px; dialogHeight:425px; center:yes; status:no");
      if (result) {
        document.getElementById("RNK").value = result;
        $('#addRegularForm').submit();
      }*/
    }

    function onNdListChange() {
      $('#addRegularForm').submit();
    }

    function reloadGrid() {
      var gridBlock = $('#gridRegularBlock');
      kendo.ui.progress(gridBlock.parent(), true);
      gridBlock.load(document.location.href + ' #gridRegular', function () {
        kendo.ui.progress(gridBlock.parent(), false);
        bindGridRegular();
      });
    }
  </script>
</body>
</html>
