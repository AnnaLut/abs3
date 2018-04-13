<%@ Page Language="C#" AutoEventWireup="true" CodeFile="mt_search.aspx.cs" Inherits="money_transfer_mt_search"
    Theme="default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Пошук готівкових переказів</title>
    <link href="/Common/CSS/default.css" type="text/css" rel="stylesheet" />

    <script language="javascript" type="text/javascript">
        function ShowPayDialog(url) {
            var rnd = Math.random();
            var result = window.showModalDialog(url + '&rnd=' + rnd, window, 'dialogHeight:650px; dialogWidth:650px; resizable: yes');

            window.location.replace('/barsroot/money_transfer/mt_search.aspx');
        }
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <div class="pageTitle">
        <asp:Label ID="lbPageTitle" runat="server" Text="Пошук готівкових переказів"></asp:Label>
    </div>
    <asp:Panel ID="pnlSearch" runat="server" GroupingText="Пошук" DefaultButton="ibSearch">
        <table border="0" cellpadding="3" cellspacing="0">
            <tr>
                <td>
                    <asp:Label ID="lbMagicWord" runat="server" Text="Код переказу : "></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="tbMagicWord" runat="server" ValidationGroup="Search" />
                </td>
                
                <td>
                    <asp:ImageButton ID="ibSearch" runat="server" AlternateText="Пошук" ImageUrl="/Common/Images/default/16/find.png"
                        ToolTip="Пошук" OnClick="ibSearch_Click" CausesValidation="true" ValidationGroup="Search" />
                </td>
                <td>
                    <asp:RequiredFieldValidator ID="rfvMagicWord" runat="server" ControlToValidate="tbMagicWord"
                        ErrorMessage="Введіть код переказу  "></asp:RequiredFieldValidator>
                </td>
               
              </tr>
        </table>
    </asp:Panel>
    <asp:Panel ID="pnlResult" runat="server" GroupingText="Результат пошуку">
        <asp:MultiView ID="mvResult" runat="server">
            <asp:View ID="vOk" runat="server">
                <table border="0" cellpadding="3" cellspacing="0">
                    <tr>
                        <td>
                            <asp:Label ID="lbOkText" runat="server" ForeColor="Green"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td align="left" style="padding-top: 10px">
                            <asp:Button ID="btPay" runat="server" Text="Видати" ToolTip="Видати переказ" OnClick="btPay_Click" />
                        </td>
                    </tr>
                </table>
            </asp:View>
            <asp:View ID="vError" runat="server">
                <asp:Label ID="lbErrorText" runat="server" ForeColor="Red"></asp:Label>
            </asp:View>
        </asp:MultiView>
    </asp:Panel>
    </form>
</body>
</html>
