<%@ Page Title="Новий СД {0}" Language="C#" MasterPageFile="~/ins/ins_master.master"
    AutoEventWireup="true" CodeFile="new.aspx.cs" Inherits="ins_new" Trace="false" %>
<%@ MasterType VirtualPath="~/ins/ins_master.master" %>

<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="Bars" %>
<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI.WebControls" TagPrefix="asp" %>
<%@ Register Src="~/credit/usercontrols/DDLList.ascx" TagName="DDLList" TagPrefix="Bars" %>
<%@ Register Src="~/credit/usercontrols/TextBoxString.ascx" TagName="TextBoxString"
    TagPrefix="Bars" %>
<%@ Register Src="~/credit/usercontrols/TextBoxRefer.ascx" TagName="TextBoxRefer"
    TagPrefix="Bars" %>
<%@ Register Src="~/credit/usercontrols/TextBoxDate.ascx" TagName="TextBoxDate" TagPrefix="Bars" %>
<%@ Register Src="~/credit/usercontrols/TextBoxDecimal.ascx" TagName="TextBoxDecimal"
    TagPrefix="Bars" %>
<%@ Register Src="~/credit/usercontrols/RBLFlag.ascx" TagName="RBLFlag" TagPrefix="Bars" %>
<%@ Register Src="~/credit/usercontrols/TextBoxScanner.ascx" TagName="TextBoxScanner"
    TagPrefix="Bars" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cph" runat="Server">
    <bars:BarsObjectDataSource ID="odsCurrencies" runat="server" SelectMethod="SelectCurrencies"
        TypeName="Bars.Ins.VInsCurrencies">
    </bars:BarsObjectDataSource>
    <bars:BarsObjectDataSource ID="odsFrequencies" runat="server" SelectMethod="SelectFrequencies"
        TypeName="Bars.Ins.VInsFrequencies">
    </bars:BarsObjectDataSource>
    <div class="content_container">
        <asp:Wizard ID="wzd" runat="server" ActiveStepIndex="0" DisplaySideBar="False" OnActiveStepChanged="wzd_ActiveStepChanged"
            OnFinishButtonClick="wzd_FinishButtonClick" OnNextButtonClick="wzd_NextButtonClick">
            <HeaderTemplate>
                <div class="wizard_header_container">
                    <div class="subcontainer">
                        <asp:Label ID="lStepTitle" runat="server" CssClass="title_text"></asp:Label>
                    </div>
                </div>
            </HeaderTemplate>
            <StartNavigationTemplate>
                <div class="wizard_navigation_container">
                    <div class="subcontainer">
                        <asp:Button ID="btMoveNext" runat="server" Text="Далі" CommandName="MoveNext" CausesValidation="true"
                            ValidationGroup="Main" />
                    </div>
                </div>
            </StartNavigationTemplate>
            <StepNavigationTemplate>
                <div class="wizard_navigation_container">
                    <div class="subcontainer">
                        <asp:Button ID="btMovePrevious" runat="server" Text="Назад" CommandName="MovePrevious"
                            CausesValidation="false" />
                        <asp:Button ID="btMoveNext" runat="server" Text="Далі" CommandName="MoveNext" CausesValidation="true"
                            ValidationGroup="Main" />
                    </div>
                </div>
            </StepNavigationTemplate>
            <FinishNavigationTemplate>
                <div class="wizard_navigation_container">
                    <div class="subcontainer">
                        <asp:Button ID="btMovePrevious" runat="server" Text="Назад" CommandName="MovePrevious"
                            CausesValidation="false" />
                        <asp:Button ID="btMoveNext" runat="server" Text="Завершити" CommandName="MoveComplete"
                            CausesValidation="true" ValidationGroup="Main" />
                    </div>
                </div>
            </FinishNavigationTemplate>
            <WizardSteps>
                <asp:WizardStep ID="wsKey" Title="Ключові параметри" runat="server" StepType="Start"
                    OnActivate="wsKey_Activate">
                    <div class="wizard_step_container">
                        <table border="0" cellpadding="3" cellspacing="0" class="data_table">
                            <col class="header_column" />
                            <col class="value_column" />
                            <tr>
                                <td>
                                    <asp:Label ID="PARTNER_IDTitle" runat="server" Text="СК: " />
                                </td>
                                <td>
                                    <% //bars:BarsObjectDataSource ID="odsUserPartners" runat="server" SelectMethod="SelectPartners"
                                        //TypeName="Bars.Ins.VInsUserPartners">
                                    //</%>
                                    <bars:BarsSqlDataSourceEx ID="sdsUserPartners" runat="server" ProviderName="barsroot.core">
                                        <SelectParameters>
                                            <asp:QueryStringParameter Name="p_custid" QueryStringField="custtype" Type="Int32" Direction="Input" />
                                        </SelectParameters>
                                    </bars:BarsSqlDataSourceEx>
                                    <bars:DDLList ID="PARTNER_ID" runat="server" DataSourceID="sdsUserPartners" DataValueField="PARTNER_ID"
                                        DataTextField="NAME" OnValueChanged="PARTNER_ID_ValueChanged" Width="400" IsRequired="true"
                                        ValidationGroup="Main" TabIndex="101" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="TYPE_IDTitle" runat="server" Text="Тип договору: " />
                                </td>
                                <td>
                                    <bars:BarsObjectDataSource ID="odsUserPartnerTypes" runat="server" SelectMethod="SelectPartnerTypes"
                                        TypeName="Bars.Ins.VInsUserPartnerTypes">
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="PARTNER_ID" Name="PARTNER_ID" PropertyName="SelectedValue"
                                                Type="Decimal" />
                                        </SelectParameters>
                                    </bars:BarsObjectDataSource>
                                    <bars:DDLList ID="TYPE_ID" runat="server" DataSourceID="odsUserPartnerTypes" DataValueField="TYPE_ID"
                                        DataTextField="TYPE_NAME" Width="400" IsRequired="true" ValidationGroup="Main"
                                        TabIndex="102" />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <asp:Panel ID="pnlInsParams" runat="server" GroupingText="Страхувальник">
                                        <table border="0" cellpadding="3" cellspacing="0" class="data_table">
                                            <col class="header_column" />
                                            <col class="value_column" />
                                            <tr>
                                                <td>
                                                    <asp:Label ID="INS_RNKTitle" runat="server" Text="РНК: " />
                                                </td>
                                                <td>
                                                    <bars:TextBoxRefer ID="INS_RNK" runat="server" TAB_NAME="CUSTOMER" KEY_FIELD="RNK"
                                                        SEMANTIC_FIELD="NMK" SHOW_FIELDS="OKPO"
                                                        IsRequired="true" ValidationGroup="Main" Width="200" OnValueChanged="INS_RNK_ValueChanged"
                                                        TabIndex="103" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="INS_FIOTitle" runat="server" Text="ПІБ: " />
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="INS_FIO" runat="server" Enabled="false" Width="400" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="INS_DOCTitle" runat="server" Text="Документ: " />
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="INS_DOC" runat="server" Enabled="false" Width="400" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="INS_INNTitle" runat="server" Text="ІПН: " />
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="INS_INN" runat="server" Enabled="false" Width="200" />
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <asp:Panel ID="pnlDealParams" runat="server" GroupingText="Договір страхування">
                                        <table border="0" cellpadding="3" cellspacing="0" class="data_table">
                                            <colgroup>
                                                <col class="header_column" />
                                                <col class="value_column" />
                                                <%/*<tr>
                                                    <td>
                                                        <asp:Label ID="SERTitle" runat="server" Text="Серія:" />
                                                    </td>
                                                    <td>
                                                        <bars:TextBoxString ID="SER" runat="server" TabIndex="104" />
                                                    </td>
                                                </tr>*/%>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="NUMTitle" runat="server" Text="Номер:" />
                                                    </td>
                                                    <td>
                                                        <bars:TextBoxString ID="NUM" runat="server" IsRequired="true" ValidationGroup="Main"
                                                            TabIndex="105" MaxLength="100" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="SDATETitle" runat="server" Text="Дата початку дії:" />
                                                    </td>
                                                    <td>
                                                        <bars:TextBoxDate ID="SDATE" runat="server" IsRequired="true" ValidationGroup="Main"
                                                            TabIndex="106" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="EDATETitle" runat="server" Text="Дата закінчення дії:" />
                                                    </td>
                                                    <td>
                                                        <bars:TextBoxDate ID="EDATE" runat="server" IsRequired="true" ValidationGroup="Main"
                                                            TabIndex="107" />
                                                    </td>
                                                </tr>
                                            </colgroup>
                                        </table>
                                    </asp:Panel>
                                </td>
                            </tr>
                        </table>
                    </div>
                </asp:WizardStep>
                <asp:WizardStep ID="wsObject" Title="Об`єкт страхування" runat="server" StepType="Step"
                    OnActivate="wsObject_Activate">
                    <div class="wizard_step_container">
                        <table border="0" cellpadding="3" cellspacing="0" class="data_table">
                            <colgroup>
                                <col class="value_column" />
                                <tr id="ObjectRowCL" runat="server">
                                    <td>
                                        <asp:RadioButton ID="rbCL" runat="server" GroupName="rbgObject" Text="Страхування контрагента"
                                            OnCheckedChanged="rbCL_CheckedChanged" AutoPostBack="true" TabIndex="201" />
                                        <asp:Panel ID="pnlCL" runat="server" GroupingText="Застрахована особа">
                                            <table border="0" cellpadding="3" cellspacing="0" class="data_table">
                                                <colgroup>
                                                    <col class="header_column" />
                                                    <col class="value_column" />
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="CL_RNKTitle" runat="server" Text="РНК: " />
                                                        </td>
                                                        <td>
                                                            <bars:TextBoxRefer ID="CL_RNK" runat="server" TAB_NAME="CUSTOMER" KEY_FIELD="RNK"
                                                                SEMANTIC_FIELD="NMK" SHOW_FIELDS="OKPO" 
                                                                IsRequired="true" ValidationGroup="Main" Value='<%# Bind("CL_RNK") %>' Width="200"
                                                                OnValueChanged="CL_RNK_ValueChanged" TabIndex="202" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="CL_FIOTitle" runat="server" Text="ПІБ: " />
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="CL_FIO" runat="server" Enabled="false" Width="400" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="CL_DOCTitle" runat="server" Text="Документ: " />
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="CL_DOC" runat="server" Enabled="false" Width="400" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="CL_INNTitle" runat="server" Text="ІПН: " />
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="CL_INN" runat="server" Enabled="false" Width="200" />
                                                        </td>
                                                    </tr>
                                                </colgroup>
                                            </table>
                                        </asp:Panel>
                                    </td>
                                </tr>
                                <tr id="ObjectRowsSeparator" runat="server">
                                    <td class="rows_separator"></td>
                                </tr>
                                <tr id="ObjectRowGRT" runat="server">
                                    <td>
                                        <asp:RadioButton ID="rbGRT" runat="server" GroupName="rbgObject" Text="Страхування забезпечення"
                                            OnCheckedChanged="rbGRT_CheckedChanged" AutoPostBack="true" TabIndex="203" />
                                        <asp:Panel ID="pnlGRT" runat="server" GroupingText="Договір забезпечення">
                                            <table border="0" cellpadding="3" cellspacing="0" class="data_table">
                                                <colgroup>
                                                    <col class="header_column" />
                                                    <col class="value_column" />
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="GRT_IDTitle" runat="server" Text="Ідентифікатор: " />
                                                        </td>
                                                        <td>
                                                            <bars:TextBoxRefer ID="GRT_ID" runat="server" TAB_NAME="V_INS_GRT_DEALS" KEY_FIELD="DEAL_ID"
                                                                SEMANTIC_FIELD="DEAL_NUM" SHOW_FIELDS="DEAL_DATE,DEAL_RNK,FIO,TYPE_NAME" IsRequired="true"
                                                                ValidationGroup="Main" Width="200" OnValueChanged="GRT_ID_ValueChanged" TabIndex="204" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="GRT_TYPETitle" runat="server" Text="Тип: " />
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="GRT_TYPE" runat="server" Enabled="false" Width="400" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="GRT_DEAL_NUMTitle" runat="server" Text="Номер: " />
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="GRT_DEAL_NUM" runat="server" Enabled="false" Width="200" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="GRT_DEAL_DATETitle" runat="server" Text="Дата: " />
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="GRT_DEAL_DATE" runat="server" Enabled="false" Width="200" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="GRT_GRT_NAMETitle" runat="server" Text="Опис: " />
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="GRT_GRT_NAME" runat="server" Enabled="false" Width="400" />
                                                        </td>
                                                    </tr>
                                                </colgroup>
                                            </table>
                                        </asp:Panel>
                                    </td>
                                </tr>
                                <tr id="ObjectRowCredContract" runat="server">
                                    <td>
                                        <asp:Panel ID="pnlNd" runat="server" GroupingText="Кредитний договір">
                                            <table border="0" cellpadding="3" cellspacing="0" class="data_table">
                                                <colgroup>
                                                    <col class="header_column" />
                                                    <col class="value_column" />
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="NDTitle" runat="server" Text="Ідентифікатор: " />
                                                        </td>
                                                        <td>
                                                            <bars:TextBoxRefer ID="ND" runat="server" TAB_NAME="V_INS_CC_DEALS" KEY_FIELD="ND"
                                                                SEMANTIC_FIELD="NUM" SHOW_FIELDS="SDATE,DEAL_RNK,FIO" IsRequired="true" ValidationGroup="Main"
                                                                Width="200" OnValueChanged="ND_ValueChanged" TabIndex="205" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="ND_NUMTitle" runat="server" Text="Номер: " />
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="ND_NUM" runat="server" Enabled="false" Width="200" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="ND_SDATETitle" runat="server" Text="Дата початку дії: " />
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="ND_SDATE" runat="server" Enabled="false" Width="200" />
                                                        </td>
                                                    </tr>
                                                </colgroup>
                                            </table>
                                        </asp:Panel>
                                    </td>
                                </tr>
                                <tr id="ObjectRowAnyContract" runat="server">
                                    <td>
                                        <asp:Panel ID="pnlAny" runat="server" GroupingText="Довільний об'єкт страхування">
                                            <%-- Якщо ввести більше MaxLength символів не виводить MinMaxLengthErrorText, а виводить 'Заповніть поле', проте йти далі не дозволяє. --%>
                                            <bars:TextBoxString ID="ANY" runat="server" MaxLength="4000" Rows="20" Width="500" ValidationGroup="Main" MinMaxLengthErrorText="Дозволено не більше 4000 символів."/>
                                        </asp:Panel>
                                    </td>
                                </tr>
                            </colgroup>
                        </table>
                    </div>
                </asp:WizardStep>
                <asp:WizardStep ID="wsFinance" Title="Фінансові параметри" runat="server" StepType="Step"
                    OnActivate="wsFinance_Activate">
                    <div class="wizard_step_container">
                        <table border="0" cellpadding="3" cellspacing="0" class="data_table">
                            <col class="header_column" />
                            <col class="value_column" />
                            <tr>
                                <td colspan="2">
                                    <asp:Panel ID="pnlSUM" runat="server" GroupingText="Страхова сума">
                                        <table border="0" cellpadding="3" cellspacing="0" class="data_table">
                                            <colgroup>
                                                <col class="header_column" />
                                                <col class="value_column" />
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="SUMTitle" runat="server" Text="Сума: " />
                                                    </td>
                                                    <td>
                                                        <bars:TextBoxDecimal ID="SUM" runat="server" IsRequired="true" ValidationGroup="Main"
                                                            TabIndex="301" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="SUM_KVTitle" runat="server" Text="Валюта: " />
                                                    </td>
                                                    <td>
                                                        <bars:DDLList ID="SUM_KV" runat="server" DataSourceID="odsCurrencies" DataValueField="KV"
                                                            DataTextField="DESCR" Width="200" IsRequired="true" ValidationGroup="Main" TabIndex="302" />
                                                    </td>
                                                </tr>
                                            </colgroup>
                                        </table>
                                    </asp:Panel>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <asp:Panel ID="pnlEvents" runat="server" GroupingText="Події">
                                        <table border="0" cellpadding="3" cellspacing="0" class="data_table">
                                            <colgroup>
                                                <col class="header_column" />
                                                <col class="value_column" />
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="PAY_FREQTitle" runat="server" Text="Періодичність сплати стрх. платежів: " />
                                                    </td>
                                                    <td>
                                                        <bars:DDLList ID="PAY_FREQ" runat="server" DataSourceID="odsFrequencies" DataValueField="ID"
                                                            DataTextField="NAME" Width="200" IsRequired="true" ValidationGroup="Main" TabIndex="304" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="RENEW_NEEDTitle" runat="server" Text="Чи необхідно перезаключати після закінчення?: " />
                                                    </td>
                                                    <td>
                                                        <bars:RBLFlag ID="RENEW_NEED" runat="server" IsRequired="true" DefaultValue="true"
                                                            ValidationGroup="Main" TabIndex="306" />
                                                    </td>
                                                </tr>
                                            </colgroup>
                                        </table>
                                    </asp:Panel>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <asp:Panel ID="pnlRate" runat="server" GroupingText="Страхова премія">
                                        <table border="0" cellpadding="3" cellspacing="0" class="data_table">
                                            <tr>
                                                <td>
                                                    <asp:RadioButton ID="rbTARIFF" runat="server" Checked="true" GroupName="rbgFinance"
                                                        Text="Тариф (%):" OnCheckedChanged="rbTARIFF_CheckedChanged" AutoPostBack="true"
                                                        TabIndex="303" />
                                                </td>
                                                <td>
                                                    <bars:TextBoxDecimal ID="INSU_TARIFF" runat="server" IsRequired="true" ValidationGroup="Main" Precision="5"
                                                        TabIndex="308" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:RadioButton ID="rbINSU_SUM" runat="server" GroupName="rbgFinance" Text="Фіксована сума:"
                                                        OnCheckedChanged="rbINSU_SUM_CheckedChanged" AutoPostBack="true" TabIndex="305" />
                                                </td>
                                                <td>
                                                    <bars:TextBoxDecimal ID="INSU_SUM" runat="server" IsRequired="true" ValidationGroup="Main"
                                                        TabIndex="309" />
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </td>
                            </tr>
                        </table>
                    </div>
                </asp:WizardStep>
                <asp:WizardStep ID="wsAttrs" Title="Додаткові реквізити" runat="server" StepType="Step"
                    OnActivate="wsAttrs_Activate">
                    <div class="wizard_step_container">
                        <table border="0" cellpadding="3" cellspacing="0" class="data_table">
                            <colgroup>
                                <col class="header_column" />
                                <col class="value_column" />
                                <bars:BarsObjectDataSource ID="odsPartnerTypeAttrs" runat="server" SelectMethod="SelectPartnerTypeAttrs"
                                    TypeName="Bars.Ins.VInsPartnerTypeAttrs" OnSelecting="odsPartnerTypeAttrs_Selecting">
                                    <SelectParameters>
                                        <asp:Parameter DefaultValue="-1" Name="PARTNER_ID" Type="Decimal" />
                                        <asp:Parameter DefaultValue="-1" Name="TYPE_ID" Type="Decimal" />
                                    </SelectParameters>
                                </bars:BarsObjectDataSource>
                                <asp:DataList ID="dlPartnerTypeAttrs" runat="server" DataSourceID="odsPartnerTypeAttrs"
                                    DataKeyField="ATTR_ID">
                                    <ItemTemplate>
                                        <tr>
                                            <td>
                                                <asp:Label ID="ATTR_NAME" runat="server" Text='<%# Eval("ATTR_NAME") + ": " %>' />
                                            </td>
                                            <td>
                                                <asp:HiddenField ID="ATTR_TYPE_ID" runat="server" Value='<%# Eval("ATTR_TYPE_ID") %>' />
                                                <bars:TextBoxString ID="ATTR_ID_S" runat="server" IsRequired='<%# (Decimal?)Eval("IS_REQUIRED") == 1 ? true : false %>'
                                                    ValidationGroup="Attrs" Visible='<%# (String)Eval("ATTR_TYPE_ID") == "S" ? true : false %>' />
                                                <bars:TextBoxDecimal ID="ATTR_ID_N" runat="server" IsRequired='<%# (Decimal?)Eval("IS_REQUIRED") == 1 ? true : false %>'
                                                    ValidationGroup="Attrs" Visible='<%# (String)Eval("ATTR_TYPE_ID") == "N" ? true : false %>' />
                                                <bars:TextBoxDate ID="ATTR_ID_D" runat="server" IsRequired='<%# (Decimal?)Eval("IS_REQUIRED") == 1 ? true : false %>'
                                                    ValidationGroup="Attrs" Visible='<%# (String)Eval("ATTR_TYPE_ID") == "D" ? true : false %>' />
                                            </td>
                                        </tr>
                                    </ItemTemplate>
                                </asp:DataList>
                            </colgroup>
                        </table>
                    </div>
                </asp:WizardStep>
                <asp:WizardStep ID="wsScans" Title="Сканкопії" runat="server" StepType="Step" OnActivate="wsScans_Activate">
                    <div class="wizard_step_container">
                        <table border="0" cellpadding="3" cellspacing="0" class="data_table">
                            <colgroup>
                                <col class="header_column" />
                                <col class="value_column" />
                                <bars:BarsObjectDataSource ID="odsPartnerTypeScans" runat="server" SelectMethod="SelectPartnerTypeScans"
                                    TypeName="Bars.Ins.VInsPartnerTypeScans" OnSelecting="odsPartnerTypeScans_Selecting">
                                    <SelectParameters>
                                        <asp:Parameter DefaultValue="-1" Name="PARTNER_ID" Type="Decimal" />
                                        <asp:Parameter DefaultValue="-1" Name="TYPE_ID" Type="Decimal" />
                                    </SelectParameters>
                                </bars:BarsObjectDataSource>
                                <asp:DataList ID="dlPartnerTypeScans" runat="server" DataSourceID="odsPartnerTypeScans"
                                    DataKeyField="SCAN_ID">
                                    <ItemTemplate>
                                        <tr>
                                            <td>
                                                <asp:Label ID="SCAN_NAME" runat="server" Text='<%# Eval("SCAN_NAME") + ": " %>' />
                                            </td>
                                            <td>
                                                <bars:TextBoxScanner ID="SCAN_ID" runat="server" IsRequired='<%# (Decimal?)Eval("IS_REQUIRED") == 1 ? true : false %>'
                                                    ValidationGroup="Scans" />
                                            </td>
                                        </tr>
                                    </ItemTemplate>
                                </asp:DataList>
                            </colgroup>
                        </table>
                    </div>
                </asp:WizardStep>
                <asp:WizardStep ID="wsPaymentsSchedule" Title="Платіжний графік" runat="server" StepType="Finish"
                    OnActivate="wsPaymentsSchedule_Activate">
                    <div class="wizard_step_container">
                        <bars:BarsObjectDataSource ID="odsPaymentsSchedule" runat="server" SelectMethod="SelectPaymentsSchedule"
                            TypeName="Bars.Ins.VInsPaymentsSchedule" DataObjectTypeName="Bars.Ins.VInsPaymentsScheduleRecord"
                            OnSelecting="odsPaymentsSchedule_Selecting">
                            <SelectParameters>
                                <asp:Parameter DefaultValue="-1" Name="DEAL_ID" Type="Decimal" />
                            </SelectParameters>
                        </bars:BarsObjectDataSource>
                        <asp:ListView ID="lvPaymentsSchedule" runat="server" DataKeyNames="ID,DEAL_ID" DataSourceID="odsPaymentsSchedule"
                            OnItemCreated="lvPaymentsSchedule_ItemCreated" OnItemInserting="lvPaymentsSchedule_ItemInserting"
                            OnItemUpdating="lvPaymentsSchedule_ItemUpdating" OnItemDeleting="lvPaymentsSchedule_ItemDeleting">
                            <LayoutTemplate>
                                <table class="tbl_style1" width="500px">
                                    <thead>
                                        <tr>
                                            <th></th>
                                            <th>
                                                <asp:Label ID="PLAN_DATE" runat="server" Text="План-Дата" />
                                            </th>
                                            <th>
                                                <asp:Label ID="PLAN_SUM" runat="server" Text="План-Сума" />
                                            </th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr runat="server" id="itemPlaceholder">
                                        </tr>
                                    </tbody>
                                    <tfoot id="tblPSFoot" runat="server">
                                        <tr>
                                            <td class="command">
                                                <asp:ImageButton ID="ibAddNew" runat="server" CausesValidation="False" OnClick="ibAddNew_Click"
                                                    ImageUrl="/common/images/default/16/new.png" ToolTip="Додати" />
                                            </td>
                                            <td colspan="2"></td>
                                        </tr>
                                    </tfoot>
                                </table>
                            </LayoutTemplate>
                            <ItemTemplate>
                                <tr id="tr" runat="server">
                                    <td class="command">
                                        <asp:ImageButton ID="ibEdit" runat="server" CausesValidation="False" CommandName="Edit"
                                            ImageUrl="/common/images/default/16/open.png" ToolTip="Редагувати" Visible='<%# ((Decimal)Eval("PAYED") == 1 ? false : true) %>' />
                                        <asp:ImageButton ID="ibDelete" runat="server" CausesValidation="False" CommandName="Delete"
                                            ImageUrl="/common/images/default/16/delete.png" ToolTip="Видалити" Visible='<%# ((Decimal)Eval("PAYED") == 1 ? false : true) %>' />
                                    </td>
                                    <td align="center">
                                        <asp:Label ID="PLAN_DATE" runat="server" Text='<%# Eval("PLAN_DATE", "{0:d}") %>'></asp:Label>
                                    </td>
                                    <td align="right">
                                        <asp:Label ID="PLAN_SUM" runat="server" Text='<%# Eval("PLAN_SUM", "{0:F2}") %>'></asp:Label>
                                    </td>
                                </tr>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <tr id="tr" runat="server" class="edit">
                                    <td class="command">
                                        <asp:ImageButton ID="ibUpdate" runat="server" CausesValidation="True" ValidationGroup="Update"
                                            CommandName="Update" ImageUrl="/common/images/default/16/save.png" ToolTip="Зберегти" />
                                        <asp:ImageButton ID="ibCancel" runat="server" CausesValidation="False" CommandName="Cancel"
                                            ImageUrl="/common/images/default/16/cancel.png" ToolTip="Відміна" />
                                    </td>
                                    <td align="center">
                                        <bars:TextBoxDate ID="PLAN_DATE" runat="server" Value='<%# Bind("PLAN_DATE") %>'
                                            IsRequired="true" ValidationGroup="Update" Width="100px" />
                                    </td>
                                    <td align="right">
                                        <bars:TextBoxDecimal ID="PLAN_SUM" runat="server" Value='<%# Bind("PLAN_SUM") %>'
                                            IsRequired="true" ValidationGroup="Update" Width="100px" />
                                    </td>
                                </tr>
                            </EditItemTemplate>
                            <InsertItemTemplate>
                                <tr id="tr2" runat="server" class="new">
                                    <td class="command">
                                        <asp:ImageButton ID="ibInsert" runat="server" CausesValidation="True" ValidationGroup="Insert"
                                            CommandName="Insert" ImageUrl="/common/images/default/16/save.png" Text="Додати" />
                                        <asp:ImageButton ID="ibCancel" runat="server" CausesValidation="False" OnClick="ibCancel_Click"
                                            ImageUrl="/common/images/default/16/cancel.png" ToolTip="Відміна" />
                                    </td>
                                    <td align="center">
                                        <bars:TextBoxDate ID="PLAN_DATE" runat="server" Value='<%# Bind("PLAN_DATE") %>'
                                            IsRequired="true" ValidationGroup="Insert" Width="100px" />
                                    </td>
                                    <td align="right">
                                        <bars:TextBoxDecimal ID="PLAN_SUM" runat="server" Value='<%# Bind("PLAN_SUM") %>'
                                            IsRequired="true" ValidationGroup="Insert" Width="100px" />
                                    </td>
                                </tr>
                            </InsertItemTemplate>
                        </asp:ListView>
                    </div>
                </asp:WizardStep>
            </WizardSteps>
        </asp:Wizard>
    </div>
</asp:Content>
