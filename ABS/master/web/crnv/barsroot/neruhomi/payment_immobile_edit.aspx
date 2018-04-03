<%@ Page Language="C#" AutoEventWireup="true" CodeFile="payment_immobile_edit.aspx.cs" Inherits="payment_edit" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="Bars" %>
<%@ Register Assembly="Bars.Web.Controls.2" Namespace="UnityBars.WebControls" TagPrefix="Bars" %>
<%@ Register Assembly="Bars.Web.Controls" Namespace="Bars.Web.Controls" TagPrefix="Bars" %>
<%@ Register Src="~/credit/usercontrols/TextBoxDate.ascx" TagName="TextBoxDate" TagPrefix="bec" %>
<%@ Register Src="~/credit/usercontrols/TextBoxDecimal.ascx" TagName="TextBoxDecimal"
    TagPrefix="bec" %>
<%@ Register Src="~/credit/usercontrols/TextBoxNumb.ascx" TagName="TextBoxNumb" TagPrefix="bec" %>
<%@ Register Src="~/credit/usercontrols/DDLList.ascx" TagName="DDLList" TagPrefix="bec" %>
<%@ Register Src="~/credit/usercontrols/TextBoxRefer.ascx" TagName="TextBoxRefer" TagPrefix="bec" %>
<%@ Register Src="~/credit/usercontrols/TextBoxScanner.ascx" TagName="TextBoxScanner" TagPrefix="Bars" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajax" %>
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
    <asp:Panel ID="pnCust" runat="server" GroupingText="Параметри клієнта:" Style="margin-left: 10px;
        margin-right: 10px">
        <table>
        <tr>
            <td>
              <asp:Label runat="server" ID="lbFio" Text="ПІБ:"></asp:Label>
            </td>
            <td>
                <asp:TextBox runat="server" ID="tbNameFio" Width="300"></asp:TextBox>
            </td>
         </tr>
        <tr>
            <td>
              <asp:Label runat="server" ID="lbCode" Text="Ідентифікаційний код:"></asp:Label>
            </td>
            <td>
                <asp:TextBox runat="server" ID="tbNameCode" MaxLength="10"></asp:TextBox>
            </td>
         </tr>
        <tr>
            <td>
                <asp:Label runat="server" ID="lbDocType" Text="Документ:"></asp:Label>
            </td>
            <td>
                <bec:TextBoXRefer ID="tbNameDocType" runat="server" TAB_NAME="DOC_IMMOBILE" KEY_FIELD="ID_DOC" SEMANTIC_FIELD="NAME" IsRequired="false"/>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label runat="server" ID="lbSer" Text="Серія:"></asp:Label>
            </td>
            <td>
                <asp:TextBox runat="server" ID="tbNameSer"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label runat="server" ID="lbNum" Text="Номер:"></asp:Label>
            </td>
            <td>
                <asp:TextBox runat="server" ID="tbNameNum"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label runat="server" ID="lbPaspW" Text="Ким видано:"></asp:Label>
            </td>
            <td>
                <asp:TextBox runat="server" ID="tbNamePaspW"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label runat="server" ID="lbPaspD" Text="Коли видано:"></asp:Label>
            </td>
            <td>
                <bec:TextBoxDate runat="server" ID="tbNamePaspD"></bec:TextBoxDate>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label runat="server" ID="lbBirthdat" Text="Дата народження:"></asp:Label>
            </td>
            <td>
                <bec:TextBoxDate  runat="server" ID="tbNameBirthdat"></bec:TextBoxDate>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label runat="server" ID="lbBirthpl" Text="Місце народження:"></asp:Label>
            </td>
            <td>
                <asp:TextBox runat="server" ID="tbNameBirthpl"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label runat="server" ID="lbRegion" Text="Область:"></asp:Label>
            </td>
            <td>
                <asp:TextBox runat="server" ID="tbNameRegion"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label runat="server" ID="lbDistrict" Text="Район:"></asp:Label>
            </td>
            <td>
                <asp:TextBox runat="server" ID="tbNameDistrict"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label runat="server" ID="lbCity" Text="Місто:"></asp:Label>
            </td>
            <td>
                <asp:TextBox runat="server" ID="tbNameCity"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label runat="server" ID="lbAdres" Text="Адреса:"></asp:Label>
            </td>
            <td>
                <asp:TextBox runat="server" ID="tbNameAdres"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
              <asp:Label runat="server" ID="lbPhone1" Text="Телефон №1:"></asp:Label>
            </td>
            <td>
                <asp:TextBox id="tbPhone1" runat="server"></asp:TextBox>
                  <ajax:MaskedEditExtender ID="ipMobilePhone_MaskedEditExtender" runat="server" Enabled="True"
                                    Mask="99(999) 999-99-99" TargetControlID="tbPhone1" CultureAMPMPlaceholder=""
                                    CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                                    CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder="">
                                </ajax:MaskedEditExtender>
            </td>
        </tr>
        <tr>
            <td>
            <asp:Label runat="server" ID="lbPhone2" Text="Телефон №2:"></asp:Label>
            </td>
            <td>
                <asp:TextBox id="tbPhone2" runat="server"></asp:TextBox>
                  <ajax:MaskedEditExtender ID="MaskedEditExtender" runat="server" Enabled="True"
                                    Mask="99(999) 999-99-99" TargetControlID="tbPhone2" CultureAMPMPlaceholder=""
                                    CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                                    CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder="">
                                </ajax:MaskedEditExtender>
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
                    <asp:TextBox runat="server" ID="tbNameNls" Enabled="false"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label runat="server" ID="lbDato" Text="Дата відкриття:"></asp:Label>
                </td>
                <td>
                    <bec:TextBoxDate runat="server" ID="tbNameDato" Enabled="false"></bec:TextBoxDate>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label runat="server" ID="lbOst" Text="Залишок на рахунку:"></asp:Label>
                </td>
                <td>
                    <asp:TextBox runat="server" ID="tbNameOst" Enabled="false"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label runat="server" ID="lbDatn" Text="Дата по яку нарах.%%:"></asp:Label>
                </td>
                <td>
                    <bec:TextBoxDate runat="server" ID="tbNameDatn" Enabled="false"></bec:TextBoxDate>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label runat="server" ID="lbRef" Text="Референс:" Visible="false"></asp:Label>
                </td> 
                <td>
                    <asp:HyperLink runat="server" Visible="false" ID="hlNameRef" Target="_blank">[hlNameRef]</asp:HyperLink>
                </td>
            </tr>
        </table>
    </asp:Panel>
    <asp:Panel  ID="pnPay" GroupingText="Виконання дій:" runat="server" Style="margin-left: 10px;
        margin-right: 10px">
        <tr>
            <td>
                <asp:Button runat="server" ID="bt_back" Text="Повернутися назад" OnClick="bt_back_Click"/>
            </td>
            <td>
                <asp:Button runat="server" ID="bt_Edit" Text="Редагувати" OnClick="bt_Edit_Click"/>
            </td>
            <td>
                <asp:Button runat ="server" ID="btSave" Text="Зберегти зміни" OnClick="btSave_Click" OnClientClick='return confirm("Зберегти дані? Після збереження дані будуть відіслані на підтвердження!")'/>
            </td>
            <td>
                <asp:Button runat="server" ID="bt_Cencel" Text="Відмінити редагування" OnClick="bt_Cencel_Click" OnClientClick='return confirm("Відмінити введені дані?")'/>
            </td>
        </tr>
    </asp:Panel>
   </form>
</body>
</html>
