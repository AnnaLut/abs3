<%@ Page Language="C#" AutoEventWireup="true" CodeFile="edit_neruhomi.aspx.cs" Inherits="edit_neruhomi" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="Bars" %>
<%@ Register Assembly="Bars.Web.Controls.2" Namespace="UnityBars.WebControls" TagPrefix="Bars" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="Bars.Web.Controls" Namespace="Bars.Web.Controls" TagPrefix="Bars" %>
<%@ Register Src="~/credit/usercontrols/TextBoxDate.ascx" TagName="TextBoxDate" TagPrefix="bec" %>
<%@ Register Src="~/credit/usercontrols/TextBoxDecimal.ascx" TagName="TextBoxDecimal"
    TagPrefix="bec" %>
<%@ Register Src="~/credit/usercontrols/TextBoxNumb.ascx" TagName="TextBoxNumb" TagPrefix="bec" %>
<%@ Register Src="~/credit/usercontrols/TextBoxScanner.ascx" TagName="TextBoxScanner" TagPrefix="Bars" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Картка вкладу</title>
    <link href="/common/css/default.css" type="text/css" rel="Stylesheet" />
    <link href="/common/css/BarsGridView.css" type="text/css" rel="Stylesheet" />
    <link href="/Common/CSS/barsextenders.css" type="text/css" rel="stylesheet" />
    <link href="/Common/CSS/default.css" type="text/css" rel="stylesheet" />
    <script type="text/javascript" src="/Common/WebEdit/NumericEdit.js"></script>
    <base target="_self" />
    <style type="text/css">
        .hand {cursor:pointer;}
    </style>
</head>
<body>


    <form id="formOperationList" runat="server">

    <asp:ScriptManager ID="ScriptManager1" runat="server" EnableScriptGlobalization="True" EnableScriptLocalization="True">
    </asp:ScriptManager>


    <div class="pageTitle">
        <asp:Label ID="lbTitle" runat="server" Text="Картка вкладу" />
    </div>
    <asp:Panel runat="server" ID="pnRun" GroupingText="Виконання дій:" Style="margin-left: 10px;
        margin-right: 10px">
        <table>
            <tr>
                <td style="padding-left: 5px; padding-right: 5px; border-right: dotted 1px gray">
                    <asp:ImageButton ID="btRefresh" runat="server" ImageUrl="/Common/Images/default/16/refresh.png"
                       ToolTip="Перечитати сторінку" OnClick="btRefresh_Click" />
                </td>
                <td style="padding-left: 5px; padding-right: 5px; border-right: dotted 1px gray">
                    <asp:ImageButton ID="btBack" runat="server" ImageUrl="/Common/Images/default/16/arrow_left.png"
                        ToolTip="Повернутися в портфель нерухомих" OnClick="btBack_over"
                        Width="16px" />
                </td>
            </tr>
        </table>
    </asp:Panel>
    <asp:Panel ID="pnCust" runat="server" GroupingText="Параметри клієнта:" Style="margin-left: 10px;
        margin-right: 10px">
        <table>
        <tr>
            <td>
              <asp:Label runat="server" ID="lbFio" Text="ПІБ:"></asp:Label>
            </td>
            <td>
                <asp:Label runat="server" ID="lbNameFio"></asp:Label>
            </td>
         </tr>
        <tr>
            <td>
              <asp:Label runat="server" ID="lbCode" Text="Ідентифікаційний код:"></asp:Label>
            </td>
            <td>
                <asp:Label runat="server" ID="lbNameCode"></asp:Label>
            </td>
         </tr>
        <tr>
            <td>
                <asp:Label runat="server" ID="lbDocType" Text="Документ:"></asp:Label>
            </td>
            <td>
                <asp:Label runat="server" ID="lbNameDocType"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label runat="server" ID="lbSer" Text="Серія:"></asp:Label>
            </td>
            <td>
                <asp:Label runat="server" ID="lbNameSer"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label runat="server" ID="lbNum" Text="Номер:"></asp:Label>
            </td>
            <td>
                <asp:Label runat="server" ID="lbNameNum"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label runat="server" ID="lbPaspW" Text="Ким видано:"></asp:Label>
            </td>
            <td>
                <asp:Label runat="server" ID="lbNamePaspW"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label runat="server" ID="lbPaspD" Text="Коли видано:"></asp:Label>
            </td>
            <td>
                <asp:Label runat="server" ID="lbNamePaspD"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label runat="server" ID="lbBirthdat" Text="Дата народження:"></asp:Label>
            </td>
            <td>
                <asp:Label runat="server" ID="lbNameBirthdat"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label runat="server" ID="lbBirthpl" Text="Місце народження:"></asp:Label>
            </td>
            <td>
                <asp:Label runat="server" ID="lbNameBirthpl"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label runat="server" ID="lbRegion" Text="Область:"></asp:Label>
            </td>
            <td>
                <asp:Label runat="server" ID="lbNameRegion"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label runat="server" ID="lbDistrict" Text="Район:"></asp:Label>
            </td>
            <td>
                <asp:Label runat="server" ID="lbNameDistrict"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label runat="server" ID="lbCity" Text="Місто:"></asp:Label>
            </td>
            <td>
                <asp:Label runat="server" ID="lbNameCity"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label runat="server" ID="lbAdres" Text="Адреса:"></asp:Label>
            </td>
            <td>
                <asp:Label runat="server" ID="lbNameAdres"></asp:Label>
            </td>
        </tr>
        </table>
    </asp:Panel>
    <asp:Panel ID="pnVklad" runat="server" GroupingText="Параметри вкладу:" Style="margin-left: 10px;
        margin-right: 10px">
        <table>
            <tr>
                <td>
                    <asp:Label runat="server" ID="lbNLS" Text="Рахунок АСВО:"></asp:Label>
                </td>
                <td>
                    <asp:Label runat="server" ID="lbNameNls"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label runat="server" ID="lbDato" Text="Дата відкриття:"></asp:Label>
                </td>
                <td>
                    <asp:Label runat="server" ID="lbNameDato"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label runat="server" ID="lbOst" Text="Залишок на рахунку:"></asp:Label>
                </td>
                <td>
                    <asp:Label runat="server" ID="lbNameOst"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label runat="server" ID="lbDatn" Text="Дата по яку нарах.%%:"></asp:Label>
                </td>
                <td>
                    <asp:Label runat="server" ID="lbNameDatn"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label runat="server" ID="lbSumP" Text="Сума відсотків:"></asp:Label>
                </td>
                <td>
                    <asp:Label runat="server" ID="lbNameSumP"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label runat="server" ID="lbRef" Text="Референс:"></asp:Label>
                </td> 
                <td>
                    <asp:HyperLink runat="server" ID="hlNameRef" Target="_blank">[hlNameRef]</asp:HyperLink>
                </td>
            </tr>
        </table>
    </asp:Panel>
    <asp:Panel  ID="pnPay" GroupingText="Оплата:" runat="server" Style="margin-left: 10px;
        margin-right: 10px">
        <table>
            <asp:Button runat="server" ID="btPay" Text="Виплатити вклад" OnClick="btOk_Pay" OnClientClick='return confirm("Ви впевнені?")'/>
        </table>
    </asp:Panel>
   </form>
</body>
</html>
