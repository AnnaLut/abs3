<%@ Page Language="C#" AutoEventWireup="true" CodeFile="crkr_customer_history.aspx.cs" Inherits="crkr_cust_history" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="BarsEx" %>
<%@ Register Assembly="Bars.Web.Controls.2" Namespace="UnityBars.WebControls" TagPrefix="Bars" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="Bars.Web.Controls" Namespace="Bars.Web.Controls" TagPrefix="Bars" %>
<%@ Register Src="~/credit/usercontrols/TextBoxDate.ascx" TagName="TextBoxDate" TagPrefix="bec" %>
<%@ Register Src="~/credit/usercontrols/TextBoxDecimal.ascx" TagName="TextBoxDecimal"
    TagPrefix="bec" %>
<%@ Register Src="~/credit/usercontrols/TextBoxNumb.ascx" TagName="TextBoxNumb" TagPrefix="bec" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Історія змін по клієнту</title>
    <link href="/common/css/default.css" type="text/css" rel="Stylesheet" />
    <link href="/common/css/BarsGridView.css" type="text/css" rel="Stylesheet" />
    <link href="/Common/CSS/barsextenders.css" type="text/css" rel="stylesheet" />
    <link href="/Common/CSS/default.css" type="text/css" rel="stylesheet" />
    <script type="text/javascript" src="/Common/WebEdit/NumericEdit.js"></script>
</head>
<body>
    <form id="frm_cust_history" runat="server">
        <div class="pageTitle">
            <asp:Label ID="lbTitle" runat="server" Text="Історія змін по клієнту" />
        </div>
        <br />
        <hr style="margin-left: 10px; margin-right: 10px" />
        <BarsEx:BarsSqlDataSourceEx ID="dsMain" runat="server" AllowPaging="False" ProviderName="barsroot.core"></BarsEx:BarsSqlDataSourceEx>
        <BarsEx:BarsGridViewEx ID="gvMain" runat="server" AllowPaging="True" AllowSorting="True"
            DataSourceID="dsMain" CssClass="barsGridView" DataKeyNames="RNK" ShowPageSizeBox="true"
            AutoGenerateColumns="False" DateMask="dd/MM/yyyy" JavascriptSelectionType="None"
            OnRowDataBound="gvMain_RowDataBound"
            PagerSettings-PageButtonCount="10" PageIndex="0"
            PageSize="20">
            <FooterStyle CssClass="footerRow"></FooterStyle>
            <HeaderStyle CssClass="headerRow"></HeaderStyle>
            <EditRowStyle CssClass="editRow"></EditRowStyle>
            <PagerStyle CssClass="pagerRow"></PagerStyle>
            <NewRowStyle CssClass=""></NewRowStyle>
            <SelectedRowStyle ForeColor="Black"></SelectedRowStyle>
            <AlternatingRowStyle CssClass="alternateRow"></AlternatingRowStyle>
            <Columns>
                 <asp:TemplateField HeaderText="Час модифікації">
                  <ItemTemplate>
                        <asp:Label runat="server" Text='<%# String.Format("{0} ", Eval("LASTEDIT")) %>'  ToolTip='<%# String.Format("{0}", Eval("change_info")) %>'></asp:Label>
                  </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="РНК">
                  <ItemTemplate>
                        <asp:Label runat="server" Text='<%# String.Format("{0} ", Eval("RNK")) %>'  ToolTip='<%# String.Format("{0}", Eval("change_info")) %>'></asp:Label>
                  </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="ПІБ">
                  <ItemTemplate>
                        <asp:Label runat="server" Text='<%# String.Format("{0} ", Eval("NAME")) %>'  ToolTip='<%# String.Format("{0}", Eval("change_info")) %>'></asp:Label>
                  </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="ОКПО">
                  <ItemTemplate>
                        <asp:Label runat="server" Text='<%# String.Format("{0} ", Eval("INN")) %>'  ToolTip='<%# String.Format("{0}", Eval("change_info")) %>'></asp:Label>
                  </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Дата народження">
                  <ItemTemplate>
                        <asp:Label runat="server" Text='<%# String.Format("{0} ", Eval("BIRTH_DATE")) %>'  ToolTip='<%# String.Format("{0}", Eval("change_info")) %>'></asp:Label>
                  </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Резидент">
                  <ItemTemplate>
                        <asp:Label runat="server" Text='<%# String.Format("{0} ", Eval("REZID")) %>'  ToolTip='<%# String.Format("{0}", Eval("change_info")) %>'></asp:Label>
                  </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Документ">
                  <ItemTemplate>
                        <asp:Label runat="server" Text='<%# String.Format("{0} ", Eval("DOC_TYPE")) %>'  ToolTip='<%# String.Format("{0}", Eval("change_info")) %>'></asp:Label>
                  </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Серія">
                  <ItemTemplate>
                        <asp:Label runat="server" Text='<%# String.Format("{0} ", Eval("SER")) %>'  ToolTip='<%# String.Format("{0}", Eval("change_info")) %>'></asp:Label>
                  </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Номер">
                  <ItemTemplate>
                        <asp:Label runat="server" Text='<%# String.Format("{0} ", Eval("NUMDOC")) %>'  ToolTip='<%# String.Format("{0}", Eval("change_info")) %>'></asp:Label>
                  </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Дата видачі">
                  <ItemTemplate>
                        <asp:Label runat="server" Text='<%# String.Format("{0} ", Eval("DATE_OF_ISSUE")) %>'  ToolTip='<%# String.Format("{0}", Eval("change_info")) %>'></asp:Label>
                  </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Телефон">
                  <ItemTemplate>
                        <asp:Label runat="server" Text='<%# String.Format("{0} ", Eval("TEL")) %>'  ToolTip='<%# String.Format("{0}", Eval("change_info")) %>'></asp:Label>
                  </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Мобільний телефон">
                  <ItemTemplate>
                        <asp:Label runat="server" Text='<%# String.Format("{0} ", Eval("TEL_MOB")) %>'  ToolTip='<%# String.Format("{0}", Eval("change_info")) %>'></asp:Label>
                  </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Відділення">
                  <ItemTemplate>
                        <asp:Label runat="server" Text='<%# String.Format("{0} ", Eval("BRANCH")) %>'  ToolTip='<%# String.Format("{0}", Eval("change_info")) %>'></asp:Label>
                  </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Джерело завантаження">
                  <ItemTemplate>
                        <asp:Label runat="server" Text='<%# String.Format("{0} ", Eval("NOTES")) %>'  ToolTip='<%# String.Format("{0}", Eval("change_info")) %>'></asp:Label>
                  </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Дата реєстрації">
                  <ItemTemplate>
                        <asp:Label runat="server" Text='<%# String.Format("{0} ", Eval("DATE_REGISTRY")) %>'  ToolTip='<%# String.Format("{0}", Eval("change_info")) %>'></asp:Label>
                  </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Індекс">
                  <ItemTemplate>
                        <asp:Label runat="server" Text='<%# String.Format("{0} ", Eval("ZIP")) %>'  ToolTip='<%# String.Format("{0}", Eval("change_info")) %>'></asp:Label>
                  </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Область">
                  <ItemTemplate>
                        <asp:Label runat="server" Text='<%# String.Format("{0} ", Eval("DOMAIN")) %>'  ToolTip='<%# String.Format("{0}", Eval("change_info")) %>'></asp:Label>
                  </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Район">
                  <ItemTemplate>
                        <asp:Label runat="server" Text='<%# String.Format("{0} ", Eval("REGION")) %>'  ToolTip='<%# String.Format("{0}", Eval("change_info")) %>'></asp:Label>
                  </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Населений пункт">
                  <ItemTemplate>
                        <asp:Label runat="server" Text='<%# String.Format("{0} ", Eval("LOCALITY")) %>'  ToolTip='<%# String.Format("{0}", Eval("change_info")) %>'></asp:Label>
                  </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Адреса">
                  <ItemTemplate>
                        <asp:Label runat="server" Text='<%# String.Format("{0} ", Eval("ADDRESS")) %>'  ToolTip='<%# String.Format("{0}", Eval("change_info")) %>'></asp:Label>
                  </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Ід.коритувача">
                  <ItemTemplate>
                        <asp:Label runat="server" Text='<%# String.Format("{0} ", Eval("USER_ID")) %>'  ToolTip='<%# String.Format("{0}", Eval("change_info")) %>'></asp:Label>
                  </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="ПІБ користувача">
                  <ItemTemplate>
                        <asp:Label runat="server" Text='<%# String.Format("{0} ", Eval("USER_FIO")) %>'  ToolTip='<%# String.Format("{0}", Eval("change_info")) %>'></asp:Label>
                  </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <RowStyle CssClass="normalRow"></RowStyle>
        </BarsEx:BarsGridViewEx>
        <asp:ScriptManager ID="sm" runat="server" EnableScriptGlobalization="True" EnableScriptLocalization="True">
        </asp:ScriptManager>
    </form>
</body>
</html>