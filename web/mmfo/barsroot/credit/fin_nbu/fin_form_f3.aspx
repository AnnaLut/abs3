<%@ Page Language="C#" AutoEventWireup="true" CodeFile="fin_form_f3.aspx.cs" Inherits="credit_fin_form_f3" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="Bars" %>
<%@ Register Assembly="Bars.Web.Controls.2" Namespace="UnityBars.WebControls" TagPrefix="Bars" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="Bars.Web.Controls" Namespace="Bars.Web.Controls" TagPrefix="Bars" %>
<%@ Register Src="~/credit/usercontrols/TextBoxDate.ascx" TagName="TextBoxDate" TagPrefix="bec" %>
<%@ Register Src="~/credit/usercontrols/TextBoxDecimal.ascx" TagName="TextBoxDecimal"
    TagPrefix="bec" %>
<%@ Register Src="~/credit/usercontrols/TextBoxNumb.ascx" TagName="TextBoxNumb" TagPrefix="bec" %>
<%@ Register Src="~/credit/usercontrols/DDLList.ascx" TagName="DDLList" TagPrefix="bec" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Введення фінрезу</title>
    <link href="/common/css/default.css" type="text/css" rel="Stylesheet" />
    <link href="/common/css/BarsGridView.css" type="text/css" rel="Stylesheet" />
    <link href="/Common/CSS/barsextenders.css" type="text/css" rel="stylesheet" />
    <link href="/Common/CSS/default.css" type="text/css" rel="stylesheet" />
    <script type="text/javascript" src="/Common/WebEdit/NumericEdit.js"></script>
    <script language="javascript" type="text/javascript" src="/barsroot/credit/jscript/JScript.js"></script>
</head>
<body>
    <form id="formOperationList" runat="server">
    <div class="pageTitle">
        <asp:Label ID="lbTitle" runat="server" Text="Введення ФІНРЕЗУ" />
    </div>
    <asp:Panel runat="server" ID="pnInfo" GroupingText="Виконання дій" Style="margin-left: 10px;
        margin-right: 10px">
        <table>
            <tr>
                <td>
                    <asp:Label ID="tbOKP" runat="server" Text="ОКПО:" meta:resourcekey="lbCC_IDResource1"></asp:Label>
                </td>
                <td>
                    <asp:TextBox runat="server" ID="tbOKPO" TabIndex="8" ReadOnly="true" BackColor="Azure"
                        Width="100Px" />
                </td>
                <td>
                    <asp:Label ID="tbDAT" runat="server" Text="Дата:" meta:resourcekey="lbCC_IDResource2"> </asp:Label>
                </td>
                <td>
                    <asp:DropDownList ID="tbFDat" runat="server" IsRequired="true" Width="100Px" BackColor="Azure" />
                </td>
                <td style="padding-left: 5px; padding-right: 5px; border-right: dotted 1px gray">
                    <asp:ImageButton ID="btRefresh" runat="server" ImageUrl="/Common/Images/default/16/find.png"
                        CausesValidation="false" TabIndex="4" ToolTip="Вибрати дані" OnClick="btRefresh_Click" />
                </td>
                <td style="padding-left: 5px; padding-right: 5px; border-right: dotted 1px gray">
                    <asp:ImageButton ID="btOk" runat="server" ImageUrl="/Common/Images/default/16/save.png"
                        CausesValidation="false" TabIndex="7" ToolTip="Виконати" OnClick="btOk_Click"
                        Width="16px" />
                    <%--OnClientClick='return confirm("Ви дійсно бажаєте зберегти?")'--%>
                </td>
                <td style="padding-left: 5px; padding-right: 5px; border-right: dotted 1px gray">
                    <asp:ImageButton ID="BtPrint" runat="server" ImageUrl="/Common/Images/default/16/print.png"
                        CausesValidation="false" TabIndex="7" ToolTip="Друк форми в форматі XLS" OnClientClick='return confirm(" Увага.\n Друк необхідно проводити після збереження даних!!! \n Продовжити?")'
                        Width="16px" OnClick="BtPrint_Click" />
                </td>
                <td style="padding-left: 5px; padding-right: 5px; border-right: dotted 1px gray">
                    <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="/Common/Images/default/16/arrow_left.png"
                        CausesValidation="true" TabIndex="7" ToolTip="повернутись на попередню сторінку"
                        OnClick="backToFolders" Width="16px" />
                </td>
                <td>
                    <asp:TextBox ID="t_read" runat="server" Width="23px" Visible="false"></asp:TextBox>
                </td>
            </tr>
        </table>
    </asp:Panel>
    <asp:Panel runat="server" ID="pnGrid" Style="margin-left: 40px;margin-top: 30px" >
        <Bars:BarsSqlDataSourceEx ID="dsMain" runat="server" AllowPaging="False" ProviderName="barsroot.core">
        </Bars:BarsSqlDataSourceEx>
        <Bars:BarsGridViewEx ID="gvMain" runat="server" AllowPaging="False" AllowSorting="True"
            CssClass="titledText" DataKeyNames="OKPO,KOD,ID,TYPE_ROW,FDAT" ShowPageSizeBox="False"
            AutoGenerateColumns="False" DateMask="dd/MM/yyyy" JavascriptSelectionType="None"
            OnRowDataBound="gvMain_RowDataBound" ShowCaption="False">
            <FooterStyle CssClass="footerRow"></FooterStyle>
            <HeaderStyle CssClass="headerRow"></HeaderStyle>
            <EditRowStyle CssClass="editRow"></EditRowStyle>
            <PagerStyle CssClass="pagerRow"></PagerStyle>
            <NewRowStyle CssClass=""></NewRowStyle>
            <SelectedRowStyle ForeColor="Black"></SelectedRowStyle>
            <AlternatingRowStyle CssClass="alternateRow"></AlternatingRowStyle>
            <Columns>
                <asp:BoundField DataField="OKPO" HeaderText="ЕДРПО" Visible="false" />
                <asp:BoundField DataField="FDAT" HeaderText="Дата" Visible="false" />
                <asp:BoundField DataField="KOD" HeaderText="Код" />
                <asp:BoundField DataField="NAME" HeaderText="Стаття" />
                <asp:TemplateField HeaderText="За звітний період">
                    <ItemTemplate>
                        <Bars:NumericEdit Visible='<%# (Convert.ToString(Eval("KOD")) == "")?(false):(true) %>'
                            runat="server" Width="150px" ID="tbS" Value='<%#  (Convert.ToString(Eval("COLUM3")) == "")?(0):(Convert.ToDecimal(Eval("COLUM3")))  %>'
                            MinValue="-1000000000" MaxValue="1000000000" Enabled='<%# (Convert.ToString(t_read.Text) == "0")?(false):(true) %>'
                            EnableTheming="True" /></ItemTemplate>
                    <ItemStyle HorizontalAlign="Right" />
                </asp:TemplateField>
                <asp:BoundField DataField="KOD" HeaderText="Код" Visible="false" />
                <asp:BoundField DataField="TYPE_ROW" HeaderText="type_row" Visible="false" />
            </Columns>
            <RowStyle CssClass="normalRow"></RowStyle>
        </Bars:BarsGridViewEx>
        <Bars:BarsSqlDataSourceEx ID="dsMain4" runat="server" AllowPaging="False" ProviderName="barsroot.core">
        </Bars:BarsSqlDataSourceEx>
        <Bars:BarsGridViewEx ID="gvMain4" runat="server" AllowPaging="False" AllowSorting="True"
            AutoGenerateColumns="False" CssClass="titledText" DataKeyNames="OKPO,KOD,ID,TYPE_ROW,FDAT"
            DateMask="dd/MM/yyyy" JavascriptSelectionType="None" OnRowDataBound="gvMain_RowDataBound"
            ShowCaption="False" ShowPageSizeBox="False">
            <FooterStyle CssClass="footerRow" />
            <HeaderStyle CssClass="headerRow" />
            <EditRowStyle CssClass="editRow" />
            <PagerStyle CssClass="pagerRow" />
            <NewRowStyle CssClass="" />
            <SelectedRowStyle ForeColor="Black" />
            <AlternatingRowStyle CssClass="alternateRow" />
            <Columns>
                <asp:BoundField DataField="OKPO" HeaderText="ЕДРПО" Visible="false" />
                <asp:BoundField DataField="FDAT" HeaderText="Дата" Visible="false" />
                <asp:BoundField DataField="KOD" HeaderText="Код" />
                <asp:BoundField DataField="NAME" HeaderText="Стаття" />
                <asp:TemplateField HeaderText="Надходження">
                    <ItemTemplate>
                        <Bars:NumericEdit ID="tbS3" runat="server" Enabled='<%# (Convert.ToString(t_read.Text) == "0")?(false):(true) %>'
                            EnableTheming="True" MaxValue="1000000000" MinValue="-1000000000" Value='<%#  (Convert.ToString(Eval("COLUM3")) == "")?(0):(Convert.ToDecimal(Eval("COLUM3")))  %>'
                            Visible='<%# (Convert.ToString(Eval("KOD")) == ""|Convert.ToString(Eval("COL3"))=="X")?(false):(true) %>' Width="150px" />
                             <asp:TextBox ID="idTexb3" runat="server"  readonly= "true" 
                        Visible='<%# (Convert.ToString(Eval("COL3"))=="X")?(true):(false) %>' Width="150px"  Style="text-align: center;" ></asp:TextBox>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Right" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Видаток">
                    <ItemTemplate>
                        <Bars:NumericEdit ID="tbS4" runat="server" Enabled='<%# (Convert.ToString(t_read.Text) == "0")?(false):(true) %>'
                            EnableTheming="True" MaxValue="1000000000" MinValue="-1000000000" Value='<%#  (Convert.ToString(Eval("COLUM4")) == "")?(0):(Convert.ToDecimal(Eval("COLUM4")))  %>'
                            Visible='<%# (Convert.ToString(Eval("KOD")) == ""|Convert.ToString(Eval("COL4"))=="X")?(false):(true) %>' Width="150px" />
                        <asp:TextBox ID="idTexb4" runat="server"  readonly= "true" 
                        Visible='<%# (Convert.ToString(Eval("COL4"))=="X")?(true):(false) %>' Width="150px"  Style="text-align: center;" ></asp:TextBox>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Right" />
                </asp:TemplateField>
                <asp:BoundField DataField="KOD" HeaderText="Код" Visible="false" />
                <asp:BoundField DataField="TYPE_ROW" HeaderText="type_row" Visible="false" />
            </Columns>
            <RowStyle CssClass="normalRow" />
        </Bars:BarsGridViewEx>
    </asp:Panel>
    <asp:ScriptManager ID="sm" runat="server" EnableScriptGlobalization="True" EnableScriptLocalization="True">
    </asp:ScriptManager>
    <div>
        <asp:HiddenField ID="tbFrm" runat="server" />
    </div>
    </form>
</body>
</html>
