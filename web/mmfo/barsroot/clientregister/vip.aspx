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
                    <%--<td>

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
                    </td>--%>
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
                <tr>
                    <td>
                        <asp:Label ID="lbMAIL_MANAGER_NEW" runat="server" Text="E-mail менеджера:"></asp:Label>
                    </td>
                    <td>
                         <asp:TextBox runat="server" ID="tbMAIL_MANAGER_NEW" CssClass="cssTextBoxString" BackColor="#FFEBFF" />

                        <asp:RequiredFieldValidator ID="rfvRowMail" runat="server" ControlToValidate="tbMAIL_MANAGER_NEW"
                            Display="None" Enabled="True" ErrorMessage="Заповніть поле"></asp:RequiredFieldValidator>
                        <cc1:ValidatorCalloutExtender ID="vceRFVMail" runat="server"
                            CloseImageUrl="/Common/Images/default/16/cancel_blue.png"
                            CssClass="validatorCallout" Enabled="True" TargetControlID="rfvRowMail"
                            WarningIconImageUrl="/Common/Images/default/16/warning.png">
                        </cc1:ValidatorCalloutExtender>

                        <asp:RegularExpressionValidator Display="None"
                            ControlToValidate="tbMAIL_MANAGER_NEW"
                            ID="RegularExpressionValidator3"
                            ValidationExpression="^([\w\.\-]+)@([\w\-]+)((\.(\w){2,3})+)$"
                            runat="server"
                            ErrorMessage="Не коректно заповнено E-mail"></asp:RegularExpressionValidator>
                        <cc1:ValidatorCalloutExtender ID="ValidatorCalloutExtender2" runat="server"
                            CloseImageUrl="/Common/Images/default/16/cancel_blue.png"
                            CssClass="validatorCallout" Enabled="True" TargetControlID="RegularExpressionValidator3"
                            WarningIconImageUrl="/Common/Images/default/16/warning.png">
                        </cc1:ValidatorCalloutExtender>
                      </td>
                </tr>
            </table>
        </asp:Panel>
        <table>
            <tr>
                <%--<td>
                    <asp:ImageButton ID="bt_new" CausesValidation="False" runat="server" OnClick="bt_new_Click" ToolTip="Додати новий запис" ImageUrl="/Common/Images/default/24/document_add.png" Enabled="false" Visible="false" />
                </td>--%>
                <td>
                    <asp:ImageButton ID="bt_save" runat="server" OnClick="bt_save_Click" ToolTip="Зберегти дані" ImageUrl="/Common/Images/default/24/disk_blue.png" />
                </td>
                <%--<td>
                    <asp:ImageButton ID="bt_cancel" CausesValidation="False" Visible="False" runat="server" OnClick="bt_cancelEdit_Click" ToolTip="Відмінити створення" ImageUrl="/Common/Images/default/24/delete2.png" />
                </td>--%>
                <td>
                    <asp:ImageButton ID="bt_Export" CausesValidation="False" runat="server" OnClick="bt_Export_Click" ToolTip="Вигрузити" ImageUrl="/Common/Images/default/24/excel_btn.png" />
                </td>
            </tr>
        </table>
        <br />
        <hr style="margin-left: 10px; margin-right: 10px" />
        <BarsEx:BarsSqlDataSourceEx ID="dsMain" runat="server" AllowPaging="False" ProviderName="barsroot.core"></BarsEx:BarsSqlDataSourceEx>
        <BarsEx:BarsSqlDataSourceEx ID="dsUser" runat="server" SelectCommand="select id, fio from staff" ProviderName="barsroot.core"></BarsEx:BarsSqlDataSourceEx>
        <BarsEx:BarsGridViewEx ID="gvMain" runat="server" AllowPaging="True" AllowSorting="True"
            DataSourceID="dsMain" CssClass="barsGridView" DataKeyNames="branch, rnk, fio_manager, phone_manager, mail_manager, account_manager" ShowPageSizeBox="true"
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
                <asp:TemplateField HeaderText="РНК Клієнта" ItemStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                        <asp:HyperLink runat="server" ID="hlRNK" Text='<%#Eval("RNK") %>' NavigateUrl='<%# "/barsroot/clientregister/registration.aspx?readonly=1&rnk="+Eval("RNK")%>'></asp:HyperLink>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="NMK" HeaderText="Назва клієнта" />
                <asp:BoundField DataField="BRANCH" HeaderText="Відділення" />
                <asp:BoundField DataField="customer_segment_financial" HeaderText="Фінансовий сегмент" />
                <asp:BoundField DataField="customer_segment_activity" HeaderText="Сегмент активності"/>
                <asp:BoundField DataField="customer_segment_products_amnt" HeaderText="Продуктове навантаження"/>
                <asp:BoundField DataField="rlvip" HeaderText="Член родини преміум клієнта"/>
                <asp:TemplateField HeaderText="Акаунт менеджера">
                    <ItemTemplate>
                        <bec:TextBoxRefer ID="trUSER" runat="server" TAB_NAME="STAFF" KEY_FIELD="ID"  SEMANTIC_FIELD="FIO" SHOW_FIELDS="LOGNAME, TABN" IsRequired="true" Value='<%#Convert.ToString(Eval("ACCOUNT_MANAGER")) %>' />
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
                 <asp:TemplateField HeaderText="E-mail менеджера" ItemStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                        <asp:TextBox ID="tbMAIL_MANAGER"
                            CssClass="cssTextBoxString"
                            BackColor="#FFEBFF"
                            runat="server"
                            meta:resourcekey="tbMAIL_MANAGER"
                            Enabled="True"
                            ToolTip="E-mail мереджера" Text='<%#String.Format("{0}",Eval("MAIL_MANAGER")) %>'
                            Width="150"
                            EnableTheming="true">
                        </asp:TextBox>

                        <asp:RequiredFieldValidator ID="rfvRowMail" runat="server" ControlToValidate="tbMAIL_MANAGER"
                            Display="None" Enabled="True" ErrorMessage="Заповніть поле"></asp:RequiredFieldValidator>
                        <cc1:ValidatorCalloutExtender ID="vceRFVMail" runat="server"
                            CloseImageUrl="/Common/Images/default/16/cancel_blue.png"
                            CssClass="validatorCallout" Enabled="True" TargetControlID="rfvRowMail"
                            WarningIconImageUrl="/Common/Images/default/16/warning.png">
                        </cc1:ValidatorCalloutExtender>

                        <asp:RegularExpressionValidator Display="None"
                            ControlToValidate="tbMAIL_MANAGER"
                            ID="RegularExpressionValidator3"
                            ValidationExpression="^([\w\.\-]+)@([\w\-]+)((\.(\w){2,3})+)$"
                            runat="server"
                            ErrorMessage="Не коректно заповнено E-mail"></asp:RegularExpressionValidator>
                        <cc1:ValidatorCalloutExtender ID="ValidatorCalloutExtender2" runat="server"
                            CloseImageUrl="/Common/Images/default/16/cancel_blue.png"
                            CssClass="validatorCallout" Enabled="True" TargetControlID="RegularExpressionValidator3"
                            WarningIconImageUrl="/Common/Images/default/16/warning.png">
                        </cc1:ValidatorCalloutExtender>
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
                <asp:BoundField DataField="customer_segment_financial" HeaderText="Фінансовий сегмент" />
                <asp:BoundField DataField="customer_segment_activity" HeaderText="Сегмент активності"/>
                <asp:BoundField DataField="customer_segment_products_amnt" HeaderText="Продуктове навантаження"/>
                <asp:BoundField DataField="rlvip" HeaderText="Член родини преміум клієнта"/>
                <asp:BoundField DataField="ACCOUNT_MANAGER" HeaderText="Акаунт менеджера" />
                <asp:BoundField DataField="FIO_MANAGER" HeaderText="ПІБ менеджера" />
                <asp:BoundField DataField="PHONE_MANAGER" HeaderText="Телефон менеджера" />
                <asp:BoundField DataField="MAIL_MANAGER" HeaderText="E-mail менеджера" />
            </Columns>
        </BarsEx:BarsGridViewEx>
    </form>
</body>
</html>
