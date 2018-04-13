<%@ Page Language="C#" AutoEventWireup="true" CodeFile="rep_print.aspx.cs" Inherits="cbirep_rep_print"
    Theme="default" %>

<%@ Register Assembly="FastReport.Web" Namespace="FastReport.Web" TagPrefix="FR" %>
<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="Bars" %>
<%@ Register Src="~/credit/usercontrols/TextBoxDate.ascx" TagName="TextBoxDate" TagPrefix="bec" %>
<%@ Register Src="~/credit/usercontrols/TextBoxRefer.ascx" TagName="TextBoxRefer"
    TagPrefix="bec" %>
<%@ Register Src="~/credit/usercontrols/TextBoxString.ascx" TagName="TextBoxString"
    TagPrefix="bec" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Друк звіту - № {0} ({1})</title>
    <link href="/common/css/default.css" type="text/css" rel="Stylesheet" />
    <link href="/Common/CSS/barsextenders.css" type="text/css" rel="stylesheet" />
</head>
<body>
  <style>
    .view-txt-document {
      margin-left: 0;
      font-size: 8pt; 
      color: black; 
      font-family: 'Courier New'; 
      background-color: gainsboro;
      max-height: 100%;
      white-space: pre;
      padding: 5px;
      overflow: auto;
    }
  </style>
  <script>
    function printFile(file) {
      try {
        var ax = document.getElementById('BarsPrint');
        ax.CallDPrint(file, '');
      }
      catch (e) {
        alert('Не вдалося завантажити активний копонент BarsIE : ' + e.description);
      }
    }
  </script>
    <form id="form1" runat="server">
        <div class="pageTitle">
            <asp:Label ID="lbPageTitle" runat="server" Text="Друк звіту - № {0} ({1})"></asp:Label>
        </div>
        <div>
            <table border="0" cellpadding="3" cellspacing="0" style="width: 99%">
                <tr>
                    <td>
                        <asp:Panel ID="pnlParams" runat="server" GroupingText="Параметри звіту">
                            <asp:Repeater ID="rParams" runat="server">
                                <HeaderTemplate>
                                    <table border="0" cellpadding="3" cellspacing="0">
                                        <tr>
                                </HeaderTemplate>
                                <SeparatorTemplate>
                                    </tr>
                                    <tr>
                                </SeparatorTemplate>
                                <ItemTemplate>
                                    <td>
                                        <asp:Label ID="NameLabel" runat="server" Text='<%# Eval("Name") %>' />
                                    </td>
                                    <td>
                                        <asp:Label ID="ValueLabel" runat="server" Text='<%# Eval("DefaultValueString") %>'
                                            Font-Bold="true" />
                                    </td>
                                </ItemTemplate>
                                <FooterTemplate>
                                    </tr>
                                    </table>
                                </FooterTemplate>
                            </asp:Repeater>
                        </asp:Panel>
                    </td>
                </tr>
                <tr>
                    <td align="left" valign="middle">
                        <asp:DropDownList ID="ddlFileTypes" runat="server">
                            <asp:ListItem Value="DBF" Text="DBF"></asp:ListItem>
                            <asp:ListItem Value="EXCEL" Text="Excel"></asp:ListItem>
                            <asp:ListItem Value="TEXT" Text="Text"></asp:ListItem>
                            <asp:ListItem Value="PDF" Text="PDF"></asp:ListItem>
                        </asp:DropDownList>
                        <asp:Button ID="btSave" runat="server" Text="Зберегти" ToolTip="Зберегти звіт" OnClick="btSave_Click"
                            CausesValidation="false" />
                        <asp:Button ID="btPrint" runat="server" Text="Роздрукувати" ToolTip="Роздрукувати звіт" CausesValidation="false" />
                        &nbsp;
                        <asp:Button ID="btBack" runat="server" Text="Повернутися" ToolTip="Повернутися до списку звітів" CausesValidation="false" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <iframe id="ifText" width="100%" style="border: solid 0 black" runat="server"></iframe>
                        <pre id="textReportView" runat="server" Visible="False" class="view-txt-document"></pre>
                        <FR:WebReport ID="wr" runat="server" Width="100%" ShowPrint="true" ShowExports="true" Height="100%" ShowRefreshButton="False" ShowZoomButton="true" ToolbarIconsStyle="Blue" />
                    </td> 
                </tr>
            </table>
        </div>
        <object id="BarsPrint" classid="CLSID:0E21DB0E-5A6E-435B-885B-04D3D92AA3BE" style="border: 0; width: 0; height: 0;">
        </object>
    </form>
</body>
</html>
