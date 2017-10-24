<%@ Page Language="C#" AutoEventWireup="true" CodeFile="vip.aspx.cs" Inherits="vip" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="BarsEx" %>
<%@ Register Assembly="Bars.Web.Controls.2" Namespace="UnityBars.WebControls" TagPrefix="Bars" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="Bars.Web.Controls" Namespace="Bars.Web.Controls" TagPrefix="Bars" %>
<%@ Register Src="~/credit/usercontrols/TextBoxDate.ascx" TagName="TextBoxDate" TagPrefix="bec" %>
<%@ Register Src="~/credit/usercontrols/TextBoxRefer.ascx" TagName="TextBoxRefer" TagPrefix="bec" %>
<%@ Register Src="~/credit/usercontrols/TextBoxString.ascx" TagName="TextBoxString" TagPrefix="bec" %>
<%@ Register Src="~/credit/usercontrols/DDLList.ascx" TagName="DDLList" TagPrefix="bec" %>
<%@ Register Src="~/credit/usercontrols/TextBoxDecimal.ascx" TagName="TextBoxDecimal"
    TagPrefix="bec" %>
<%@ Register Src="~/credit/usercontrols/TextBoxNumb.ascx" TagName="TextBoxNumb" TagPrefix="bec" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Портфель нерухомих</title>
    <link href="/common/css/default.css" type="text/css" rel="Stylesheet" />
    <link href="/common/css/BarsGridView.css" type="text/css" rel="Stylesheet" />
    <link href="/Common/CSS/barsextenders.css" type="text/css" rel="stylesheet" />
    <link href="/Common/CSS/default.css" type="text/css" rel="stylesheet" />
    <script type="text/javascript" src="/Common/WebEdit/NumericEdit.js"></script>
</head>
<body>
    <form id="formOperationList" runat="server">
        <asp:ScriptManager ID="sm" runat="server" EnableScriptGlobalization="True" EnableScriptLocalization="True">
        </asp:ScriptManager>
        <div class="pageTitle">
            <asp:Label ID="lbTitle" runat="server" Text="VIP - КЛІЄНТИ" />
        </div>
        <asp:Panel runat="server" ID="pnInfo" GroupingText="Пошук клієнта:" Style="margin-left: 10px; margin-right: 10px">
            <table>
                <tr>
                    <td>
                        <asp:Label ID="lbRNK" runat="server" Text="РНК:"></asp:Label>
                    </td>
                    <td>
                        <bars:BarsTextBox ID="tbRNK" runat="server"></bars:BarsTextBox>

                    </td>
                    <td>
                        <asp:Label ID="lbFio" runat="server" Text="ПІБ:"></asp:Label>
                    </td>
                    <td id="tdNMK" runat="server">
                        <bars:BarsTextBox ID="tbNMK" runat="server" Width="280">
                        </bars:BarsTextBox>
                    </td>
                    <td>

                        <asp:Label ID="lbP0" runat="server" Text="|"></asp:Label>
                    </td>
                    <td>
                        <asp:RadioButton ID="rbAll" runat="server" AutoPostBack="true" OnCheckedChanged="btRefresh_Click" GroupName="GR" Checked="true" />
                    </td>
                    <td>
                        <asp:Label ID="lbAll" AssociatedControlID="rbAll" runat="server" Text="Всі критерії"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lbP1" runat="server" Text="|"></asp:Label>
                    </td>
                    <td>
                        <asp:RadioButton ID="rbFin" runat="server" AutoPostBack="true" OnCheckedChanged="btRefresh_Click" GroupName="GR" />
                    </td>
                    <td>
                        <asp:Label ID="lbFin" AssociatedControlID="rbFin" runat="server" Text="Фінансовий"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lbP2" runat="server" Text="|"></asp:Label>
                    </td>
                    <td>
                        <asp:RadioButton ID="rbSoc" runat="server" AutoPostBack="true" OnCheckedChanged="btRefresh_Click" GroupName="GR" />
                    </td>
                    <td>
                        <asp:Label ID="lbSoc" AssociatedControlID="rbSoc" runat="server" Text="Соціальний"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lbP3" runat="server" Text="|"></asp:Label>
                    </td>
                    <td>
                        <asp:RadioButton ID="rbPravl" runat="server" AutoPostBack="true" OnCheckedChanged="btRefresh_Click" GroupName="GR" />
                    </td>
                    <td>
                        <asp:Label ID="lbPravl" AssociatedControlID="rbPravl" runat="server" Text="За рішенням правління"></asp:Label>
                    </td>

                    <td>
                        <asp:Label ID="lbP4" runat="server" Text="|"></asp:Label>
                    </td>
                </tr>
            </table>
            <table>
                <tr>
                    <td></td>
                    <td></td>
                    <td style="text-align: right; width: 100%;">
                        <asp:Button
                            ID="bt_refresh"
                            runat="server"
                            TabIndex="3"
                            ToolTip="Знайти по заданим параметрам"
                            OnClick="btRefresh_Click"
                            CausesValidation="False"
                            Text="Пошук" />
                    </td>
                </tr>
            </table>
        </asp:Panel>
        <br />


        <br />
        <hr style="margin-left: 10px; margin-right: 10px" />
        <BarsEx:BarsSqlDataSourceEx ID="sdsVipNew" runat="server" SelectCommand="select id, name from vip_tp" ProviderName="barsroot.core"></BarsEx:BarsSqlDataSourceEx>
        <BarsEx:BarsSqlDataSourceEx ID="sdsKvipNew" runat="server" SelectCommand="select id, name from vip_calc_tp where id not in(1)" ProviderName="barsroot.core"></BarsEx:BarsSqlDataSourceEx>
        <asp:Panel runat="server" ID="pnNew" GroupingText="Додати новий запис" Style="margin-left: 10px; margin-right: 10px">
            <table>
                <tr>
                    <td>
                        <asp:Label ID="lbRNKnew" runat="server" Text="РНК:"></asp:Label>
                        <asp:CheckBox ID="chBox" runat="server" Checked="false" Style="display: none" />
                    </td>
                    <td>
                        <bec:TextBoxRefer ID="trRNK" runat="server" TAB_NAME="CUSTOMER" KEY_FIELD="RNK" SEMANTIC_FIELD="NMK" SHOW_FIELDS="RNK" IsRequired="true" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lbVipNew" runat="server" Text="Ознака VIP клієнта:"></asp:Label>
                    </td>
                    <td>
                        <bec:DDLList ID="ddVipNew" runat="server" DataSourceID="sdsVipNew" DataValueField="ID" DataTextField="NAME" Enabled="false" Width="168"></bec:DDLList>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lbKvipNew" runat="server" Text="Критерій набуття ознаки VIP:"></asp:Label>
                    </td>
                    <td>
                        <bec:DDLList ID="ddKvipNew" runat="server" DataSourceID="sdsKvipNew" DataValueField="ID" DataTextField="NAME" IsRequired="true" Width="168"></bec:DDLList>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lbDatBegNew" runat="server" Text="Дата встановлення ознаки VIP:"></asp:Label>
                    </td>
                    <td>
                        <bec:TextBoxDate runat="server" ID="tbDatBegNew" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lbDatEndNew" runat="server" Text="Дата закінчення ознаки VIP:"></asp:Label>
                    </td>
                    <td>
                        <bec:TextBoxDate runat="server" ID="tbDatEndNew" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lbCommNew" runat="server" Text="Коментар:"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox runat="server" ID="tbCommNew" Width="250" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lbFIOMANAGERNew" runat="server" Text="ПІБ Vip-менеджера:"></asp:Label>
                    </td>
                    <td>
                        <bec:TextBoxString runat="server" ID="tbFIOMANAGERNew" IsRequired="true" Width="250" RequiredErrorText="Заповніть поле" />
                        <%-- <asp:TextBox runat="server" ID="tbFIOMANAGERNew" Width="250" />--%>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lbPHONEMANAGERNew" runat="server" Text="тел./моб. телефон Vip-менеджера:"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox runat="server" ID="tbPHONEMANAGERNew" CssClass="cssTextBoxString" BackColor="#FFEBFF" />

                        <asp:RequiredFieldValidator ID="rfv" runat="server" ControlToValidate="tbPHONEMANAGERNew"
                            Display="None" Enabled="True" ErrorMessage="Заповніть поле"></asp:RequiredFieldValidator>
                        <cc1:ValidatorCalloutExtender ID="vceRFV" runat="server"
                            CloseImageUrl="/Common/Images/default/16/cancel_blue.png"
                            CssClass="validatorCallout" Enabled="True" TargetControlID="rfv"
                            WarningIconImageUrl="/Common/Images/default/16/warning.png">
                        </cc1:ValidatorCalloutExtender>

                        <asp:RegularExpressionValidator Display="None"
                            ControlToValidate="tbPHONEMANAGERNew"
                            ID="RegularExpressionValidator2"
                            ValidationExpression="^[\s\S]{10,}$"
                            runat="server"
                            ErrorMessage="Мінімальна довжина 10 символів"></asp:RegularExpressionValidator>
                        <cc1:ValidatorCalloutExtender ID="ValidatorCalloutExtender1" runat="server"
                            CloseImageUrl="/Common/Images/default/16/cancel_blue.png"
                            CssClass="validatorCallout" Enabled="True" TargetControlID="RegularExpressionValidator2"
                            WarningIconImageUrl="/Common/Images/default/16/warning.png">
                        </cc1:ValidatorCalloutExtender>

                        <cc1:MaskedEditExtender
                            ID="meeCellPhone1" runat="server"
                            TargetControlID="tbPHONEMANAGERNew"
                            Mask="+38(999)9999999" />
                    </td>
                </tr>
            </table>
        </asp:Panel>
        <table>
            <tr>
                <td>
                    <asp:ImageButton ID="bt_new" CausesValidation="False" runat="server" OnClick="bt_new_Click" ToolTip="Додати новий запис" ImageUrl="/Common/Images/default/24/document_add.png" />
                </td>
                <td>
                    <asp:ImageButton ID="bt_save" runat="server" OnClick="bt_save_Click" ToolTip="Зберегти дані" ImageUrl="/Common/Images/default/24/disk_blue.png" />
                </td>
                <td>
                    <asp:ImageButton ID="bt_cancel" CausesValidation="False" Visible="False" runat="server" OnClick="bt_cancelEdit_Click" ToolTip="Відмінити створення" ImageUrl="/Common/Images/default/24/delete2.png" />
                </td>
                <td>
                    <asp:ImageButton ID="bt_Export" CausesValidation="False" runat="server" OnClick="bt_Export_Click" ToolTip="Вигрузити" ImageUrl="/Common/Images/default/24/excel_btn.png" />
                </td>
            </tr>
        </table>
        <br />
        <hr style="margin-left: 10px; margin-right: 10px" />
        <BarsEx:BarsSqlDataSourceEx ID="dsMain" runat="server" AllowPaging="False" ProviderName="barsroot.core"></BarsEx:BarsSqlDataSourceEx>
        <BarsEx:BarsSqlDataSourceEx ID="sdsVip" runat="server" SelectCommand="select id, name from vip_tp" ProviderName="barsroot.core"></BarsEx:BarsSqlDataSourceEx>
        <BarsEx:BarsSqlDataSourceEx ID="sdsKvip" runat="server" SelectCommand="select id, name from vip_calc_tp" ProviderName="barsroot.core"></BarsEx:BarsSqlDataSourceEx>
        <BarsEx:BarsGridViewEx ID="gvMain" runat="server" AllowPaging="True" AllowSorting="True"
            DataSourceID="dsMain" CssClass="barsGridView" DataKeyNames="mfo, rnk, vip, kvip, datbeg, datend, comments, fio_manager, phone_manager" ShowPageSizeBox="true"
            AutoGenerateColumns="False" DateMask="dd/MM/yyyy" JavascriptSelectionType="None"
            OnRowDataBound="gvMain_RowDataBound" OnRowCommand="gvMain_RowCommand" ShowExportExcelButton="false"
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
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:ImageButton CommandName="DEL_ROW" CommandArgument='<%# Eval("MFO") + "," +  Eval("RNK")  %>' ID="btDel" runat="server" Enabled='<%# String.Format("{0}",Eval("KVIP"))=="1"?(false):(true) %>' Visible='<%# String.Format("{0}",Eval("KVIP"))=="1"?(false):(true) %>' ImageUrl="/Common/Images/default/16/delete2.png" ToolTip="Видалити" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="RNK" HeaderText="РНК клієнта" />
                <asp:BoundField DataField="NMK" HeaderText="Назва клієнта" />
                <asp:BoundField DataField="BRANCH" HeaderText="Відділення" />
                <asp:TemplateField HeaderText="Ознака VIP" ItemStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                        <asp:TextBox ID="ddVip" runat="server" Enabled="false" Visible="true" Text='<%# String.IsNullOrEmpty(Convert.ToString(Eval("VIP"))) ? "" : Eval("VIP") %> ' Width="50PX"></asp:TextBox>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Ознака VIP клієнта (назва)" ItemStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                        <asp:TextBox ID="tbVIP_NAME" runat="server" Enabled="false" Visible="true" Text='<%# Convert.ToString(Eval("VIP_NAME")) %>' Width="250PX"></asp:TextBox>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Критерій набуття ознаки VIP" ItemStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                        <bec:DDLList ID="ddKvip" runat="server" DataSourceID="sdsKvipNew" DataValueField="ID" DataTextField="NAME" Enabled='<%# String.Format("{0}",Eval("KVIP"))=="1"?(false):(true) %>' Value='<%# Convert.ToDecimal(Eval("KVIP")) == 1 ? (Decimal?)null : Convert.ToDecimal(Eval("KVIP"))%>' Visible='<%# String.Format("{0}",Eval("KVIP"))=="1"?(false):(true) %>' IsRequired="true"></bec:DDLList>
                        <asp:TextBox ID="tbKvip" runat="server" Text='<%# Eval("KVIP_NAME") %>' Enabled="false" Visible='<%# String.Format("{0}",Eval("KVIP"))=="1"?(true):(false) %>'></asp:TextBox>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Дата встановлення ознаки VIP" ItemStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                        <bec:TextBoxDate runat="server" ID="tbDatBeg" Value='<%#String.IsNullOrEmpty(String.Format("{0}",Eval("DATBEG"))) ? (DateTime?)null:Convert.ToDateTime(String.Format("{0}",Eval("DATBEG"))) %>' Enabled='<%# String.Format("{0}",Eval("KVIP"))=="1"?(false):(true) %>' />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Дата закінчення ознаки VIP" ItemStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                        <bec:TextBoxDate runat="server" ID="tbDatEnd" Value='<%#String.IsNullOrEmpty(String.Format("{0}",Eval("DATEND"))) ? (DateTime?)null:Convert.ToDateTime(String.Format("{0}",Eval("DATEND")))%>' Enabled='<%# String.Format("{0}",Eval("KVIP"))=="1"?(false):(true) %>' />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Коментар" ItemStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                        <asp:TextBox ID="tbComm" runat="server" ToolTip="Коментар" Text='<%#String.Format("{0}",Eval("COMMENTS")) %>' Width="250" EnableTheming="true"></asp:TextBox>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="ПІБ Vip-менеджера" ItemStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                        <bec:TextBoxString
                            ID="tbFIO_MANAGER"
                            Width="250"
                            runat="server"
                            IsRequired="true"
                            RequiredErrorText="Заповніть поле"
                            Enabled="True"
                            ToolTip="ПІБ менеджера"
                            Value='<%#String.Format("{0}",Eval("FIO_MANAGER")) %>' />

                        <%--<asp:TextBox ID="tbFIO_MANAGER" runat="server" Enabled='<%# String.Format("{0}",Eval("KVIP"))=="1"?(true):(true) %>' ToolTip="ПІБ менеджера" Text='<%#String.Format("{0}",Eval("FIO_MANAGER")) %>' Width="250" EnableTheming="true"></asp:TextBox>--%>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="тел./моб. телефон Vip-менеджера" ItemStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                        <asp:TextBox ID="tbPHONE_MANAGER"
                            CssClass="cssTextBoxString"
                            BackColor="#FFEBFF"
                            runat="server"
                            MaxLength="15"
                            meta:resourcekey="tbPHONE_MANAGER"
                            Enabled="True"
                            ToolTip="Телефон мереджера" Text='<%#String.Format("{0}",Eval("PHONE_MANAGER")) %>'
                            Width="150"
                            EnableTheming="true">
                        </asp:TextBox>

                        <asp:RequiredFieldValidator ID="rfvRow" runat="server" ControlToValidate="tbPHONE_MANAGER"
                            Display="None" Enabled="True" ErrorMessage="Заповніть поле"></asp:RequiredFieldValidator>
                        <cc1:ValidatorCalloutExtender ID="vceRFV" runat="server"
                            CloseImageUrl="/Common/Images/default/16/cancel_blue.png"
                            CssClass="validatorCallout" Enabled="True" TargetControlID="rfvRow"
                            WarningIconImageUrl="/Common/Images/default/16/warning.png">
                        </cc1:ValidatorCalloutExtender>

                        <asp:RegularExpressionValidator Display="None"
                            ControlToValidate="tbPHONE_MANAGER"
                            ID="RegularExpressionValidator2"
                            ValidationExpression="^[\s\S]{10,}$"
                            runat="server"
                            ErrorMessage="Мінімальна довжина 10 символів"></asp:RegularExpressionValidator>
                        <cc1:ValidatorCalloutExtender ID="ValidatorCalloutExtender1" runat="server"
                            CloseImageUrl="/Common/Images/default/16/cancel_blue.png"
                            CssClass="validatorCallout" Enabled="True" TargetControlID="RegularExpressionValidator2"
                            WarningIconImageUrl="/Common/Images/default/16/warning.png">
                        </cc1:ValidatorCalloutExtender>

                        <cc1:MaskedEditExtender
                            ID="meeCellPhone" runat="server"
                            TargetControlID="tbPHONE_MANAGER"
                            Mask="+38(999)9999999" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <RowStyle CssClass="normalRow"></RowStyle>
        </BarsEx:BarsGridViewEx>

        <BarsEx:BarsGridViewEx ID="gvExport" runat="server" ShowExportExcelButton="false" ShowMetaFilter="false" ShowFilter="false" CaptionType="Simple" Visible="false" AllowPaging="false" AllowSorting="false" ShowHeader="true" ShowPageSizeBox="false" AutoGenerateColumns="False" DateMask="dd/MM/yyyy">
            <Columns>
                <asp:BoundField DataField="RNK" HeaderText="РНК клієнта" />
                <asp:BoundField DataField="NMK" HeaderText="Назва клієнта" />
                <asp:BoundField DataField="BRANCH" HeaderText="Відділення" />
                <asp:BoundField DataField="VIP" HeaderText="Ознака VIP" />
                <asp:BoundField DataField="VIP_NAME" HeaderText="Ознака VIP клієнта (назва)" />
                <asp:BoundField DataField="KVIP_NAME" HeaderText="Критерій набуття ознаки VIP" />
                <asp:BoundField DataField="DATBEG" HeaderText="Дата встановлення ознаки VIP" />
                <asp:BoundField DataField="DATEND" HeaderText="Дата закінчення ознаки VIP" />
                <asp:BoundField DataField="COMMENTS" HeaderText="Коментар" />
                <asp:BoundField DataField="FIO_MANAGER" HeaderText="ПІБ менеджера" />
                <asp:BoundField DataField="PHONE_MANAGER" HeaderText="Телефон менеджера" />
            </Columns>
        </BarsEx:BarsGridViewEx>
    </form>
</body>
</html>
