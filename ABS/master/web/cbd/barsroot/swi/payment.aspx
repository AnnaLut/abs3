<%@ Page Language="C#" AutoEventWireup="true" CodeFile="payment.aspx.cs" Inherits="swi_payment" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Приклад CST системи</title>
    <link href="/common/css/default.css" type="text/css" rel="Stylesheet" />
    <link href="/common/css/BarsGridView.css" type="text/css" rel="Stylesheet" />
    <script language="javascript">

        var aSigner;
        function fLoadAX() {
            if (!aSigner) {
                try {
                    //aSigner = new ActiveXObject("BARSAX.RSAC");

                    if (parent.frames.length != 0 && parent.frames["header"].oSigner != null)
                        aSigner = parent.frames["header"].oSigner;
                    else
                        aSigner = new ActiveXObject("BARSAX.RSAC");

                    if (!aSigner.IsInitialized) aSigner.Init("VEG");
                    if (!aSigner.IsInitialized) {
                        alert("ActiveX not initialized");
                        return false;
                    }
                }
                catch (e) {
                    alert(e.description);
                    return;
                }
                aSigner.BufferEncoding = "WIN";
                aSigner.BankDate = "2009/09/15 12:00:00";
                aSigner.IdOper = "289YID00";
            }


            strSignBuf = aSigner.SignBuffer("test");
            alert("Підпис успішно накладено.\n" + strSignBuf);
        }
    </script>
</head>
<body>
    <form id="formPayment" runat="server">
        <div class="pageTitle">
            <asp:Label ID="lbPageTitle" runat="server" Text="Приклад CST системи"></asp:Label>
        </div>
        <div>
            <asp:Label runat="server" ID="lbParams">Вхідні параметри:</asp:Label>
            <asp:TextBox runat="server" ID="tbParams" TextMode="MultiLine" ReadOnly="true" Width="900px"
                Rows="6"></asp:TextBox>
        </div>
        <br />
        <hr />
        <asp:Panel runat="server" ID="pnData" GroupingText="Вихідні данні">
            <table>
                <tr>
                    <td>Сума:
                    </td>
                    <td>
                        <asp:TextBox runat="server" ID="tbSum" Text="125"></asp:TextBox>
                    </td>
                    <td>Призначення платежу:
                    </td>
                    <td>
                        <asp:TextBox runat="server" ID="tbNazn" Width="300px">Тестове призначення</asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>Дод. реквізит - ПІБ:
                    </td>
                    <td>
                        <asp:TextBox runat="server" ID="tbReqvFIO" Text="Иванов И.И."></asp:TextBox>
                    </td>
                    <td></td>
                    <td></td>
                </tr>
            </table>
            <asp:Button ID="btReturnData" runat="server" Text="Повернути данні" OnClick="btReturnData_Click" />
        </asp:Panel>
        <asp:Panel ID="Panel1" runat="server" GroupingText="Тестовые данные">
            <asp:Button ID="btGM" runat="server" Text="GlobalMoney " OnClick="btGM_Click" />
            <asp:Button ID="btProfix1" runat="server" Text="Profix MI1" OnClick="btProfix1_Click" />
            <asp:Button ID="btProfix2" runat="server" Text="Profix BZ2" OnClick="btProfix2_Click"  />
            <asp:Button ID="btProfix3" runat="server" Text="Profix UP3" OnClick="btProfix3_Click" />
            <asp:Button ID="btProfix4" runat="server" Text="Profix CN4" OnClick="btProfix4_Click"  />
        </asp:Panel>
    <asp:Button ID="btReturn" runat="server" Text="Повернутися" OnClick="btReturn_Click" />
        <input type="button" value="TestAX" onclick="fLoadAX()" />
    </form>
</body>
</html>
