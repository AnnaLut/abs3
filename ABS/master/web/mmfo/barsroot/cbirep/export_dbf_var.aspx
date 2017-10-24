<%@ Page Language="C#" AutoEventWireup="true" CodeFile="export_dbf_var.aspx.cs" Inherits="cbirep_export_dbf_var" %>

<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="BarsEx" %>
<%@ Register Assembly="Bars.Web.Controls.2" Namespace="UnityBars.WebControls" TagPrefix="Bars" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="Bars.Web.Controls" Namespace="Bars.Web.Controls" TagPrefix="Bars" %>
<%@ Register Src="~/credit/usercontrols/TextBoxString.ascx" TagName="TextBoxString" TagPrefix="bec" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Експорт каталогізованих запитів в DBF</title>
    <link href="/common/css/default.css" type="text/css" rel="Stylesheet" />
    <link href="/common/css/BarsGridView.css" type="text/css" rel="Stylesheet" />
    <link href="/Common/CSS/barsextenders.css" type="text/css" rel="stylesheet" />
    <link href="/Common/CSS/default.css" type="text/css" rel="stylesheet" />
    <script type="text/javascript" src="/Common/WebEdit/NumericEdit.js"></script>
    <base target="_self"/>
</head>
<body>
    <form id="form1" runat="server">
         <asp:ScriptManager ID="sm" runat="server" EnableScriptGlobalization="True" EnableScriptLocalization="True">
        </asp:ScriptManager>
    <div>
    
    </div>
        <asp:Panel runat="server" ID="pnEncoding" GroupingText="Кодування">
            <asp:RadioButton runat="server" ID="rbWIN" Text="WIN" Checked="true" GroupName="ENCODING"/>
            <asp:RadioButton runat="server" ID="rbDOS" Text="DOS" GroupName="ENCODING"/>
            <asp:RadioButton runat="server" ID="rbUKG" Text="UKG" GroupName="ENCODING"/>
        </asp:Panel>
         <asp:Panel runat="server" ID="pnZAPROS" GroupingText="Вхідні параметри">

                        <BarsEx:BarsSqlDataSourceEx ID="dsMainZapros" runat="server" AllowPaging="False" ProviderName="barsroot.core"></BarsEx:BarsSqlDataSourceEx>
                        <BarsEx:BarsGridViewEx ID="gvMainZapros" runat="server" AllowPaging="True" AllowSorting="True"
                            DataSourceID="dsMainZapros" CssClass="barsGridView" ShowPageSizeBox="true"
                            AutoGenerateColumns="False" DateMask="dd/MM/yyyy" JavascriptSelectionType="None" DataKeyNames="tag"
                            PagerSettings-PageIndex="0" Width="100%"
                            PageSize="10">
                        <FooterStyle CssClass="footerRow"></FooterStyle>
                        <HeaderStyle CssClass="headerRow"></HeaderStyle>
                        <EditRowStyle CssClass="editRow"></EditRowStyle>
                        <PagerStyle CssClass="pagerRow"></PagerStyle>
                        <NewRowStyle CssClass=""></NewRowStyle>
                        <SelectedRowStyle ForeColor="Black"></SelectedRowStyle>
                        <AlternatingRowStyle CssClass="alternateRow"></AlternatingRowStyle>
                            <Columns>
                                <asp:BoundField DataField="TAG" HeaderText="Код змінної" />
                                <asp:BoundField DataField="NAME" HeaderText="Найменування" />
                               <asp:TemplateField HeaderText="Значення">
                                   <ItemTemplate>
                                        <bec:TextBoxString
                                            ID="tbVal"
                                            Width="250"
                                            runat="server"
                                            IsRequired="true"
                                            RequiredErrorText="Заповніть поле"
                                            Enabled="True"
                                            ToolTip="Значення"
                                             />
                                   </ItemTemplate>
                               </asp:TemplateField>
                            </Columns>
                                        <RowStyle CssClass="normalRow"></RowStyle>
                        </BarsEx:BarsGridViewEx>
       </asp:Panel>
         <asp:Button runat="server" ID="btOk" Text="Підтвердити" OnClick="btOk_Click"/>
    </form>
</body>
</html>
