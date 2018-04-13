<%@ Page Language="C#" AutoEventWireup="true" CodeFile="overdue_loans.aspx.cs" Inherits="credit_overdue_loans"
    meta:resourcekey="PageResource1" Theme="default"%>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="Bars" %>
<%@ Register Src="usercontrols/TextBoxDate.ascx" TagName="TextBoxDate" TagPrefix="bec" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Список планових платежів позичальників ФО по КД</title>
    <link href="/Common/CSS/jquery/jquery-ui.css" type="text/css" rel="stylesheet" />
    <script language="javascript" type="text/jscript" src="/Common/jquery/jquery.js"></script>
    <script language="javascript" type="text/jscript" src="/Common/jquery/jquery-ui-1.9.2.js"></script>
    <script language="javascript" type="text/javascript">
        $(document).ready(function () {
            $('#modalView').dialog({
                modal: true,
                title: 'Список планових платежів',
                width: 300,
                height: 280,
                resizable: false,
                closeOnEscape: true,
                autoOpen: true
            });
            $("#btnStart").click(function () {
                return $("#modalView").dialogCloseAndSubmit($(this).attr('id'));
            });

            $.fn.extend({
                dialogCloseAndSubmit: function (butOkId) {
                    var dlg = $(this).clone();
                    $(this).dialog('destroy').remove();

                    dlg.css('display', 'none');
                    $('form:first').append(dlg);
                    $('#' + butOkId, dlg).click();

                    return true;
                }
            });
        });
    </script>
    <style type="text/css">
        .date_center {
            text-align:center;
        }
        .button {
            width: 90px;
            color: #fff; /* Цвет текста ссылки */
            text-shadow: 1px 1px 1px #fff; /* Tень для текста */
            background:#4297d7; /* Цвет фона кнопки по умолчанию */
            filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#a6c9e2', endColorstr='#4297d7'); /* Градиент кнопки */
            background: -webkit-gradient(linear, left top, left bottom, from(#a6c9e2), to(#4297d7)); /* Градиент кнопки */
            background: -moz-linear-gradient(top,  #a6c9e2, #4297d7); /* Градиент кнопки */
            background: gradient(linear, top,  #a6c9e2, #4297d7); /* Градиент кнопки */
            border: 1px solid #4297d7; /* Обводка кнопки solid - сплошной*/
            border-radius: 2px; /* Радиус закругленых углов кнопки */
            padding: 2px 5px; /* Внутреннии отступы кнопки */
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="sm" runat="server" EnableScriptGlobalization="True" EnableScriptLocalization="True">
    </asp:ScriptManager>
    <div id="modalView" style="display:none">
      <table>
          <tr>
              <td>Дата:</td>
              <td><bec:TextBoxDate ID="DATE_FROM" runat="server" IsRequired="false" ValidationGroup="Filter"
                        TabIndex="1" Visible="true" CssClass="date_center" /></td>
          </tr>
          <tr>
              <td colspan="2" style="height:30px"></td>
          </tr>
          <tr>
              <td colspan="2" style="text-align: right">
                  <asp:Button ID="btnStart" runat="server" Text="Вибрати" CssClass="button" OnClick="btnStart_Click" />
              </td>
          </tr>
      </table>
    </div>
    </form>
</body>
</html>
