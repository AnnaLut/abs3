<%@ Page Title="Новий СД" Language="C#" MasterPageFile="~/w4/w4_master.master" AutoEventWireup="true"
    CodeFile="import_esk_file.aspx.cs" Inherits="w4_import_esk_file" Trace="false" %>

<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="Bars" %>
<%@ Register Src="~/credit/usercontrols/DDLList.ascx" TagName="DDLList" TagPrefix="Bars" %>
<%@ Register Src="~/credit/usercontrols/TextBoxRefer.ascx" TagName="TextBoxRefer"
    TagPrefix="Bars" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cph" runat="Server">
    <bars:BarsObjectDataSource ID="odsEskData" runat="server" SelectMethod="SelectEskData"
        TypeName="Bars.W4.VOwEskData" DataObjectTypeName="Bars.W4.VOwEskDataRecord"
        OnSelecting="odsVOwEskData_Selecting">
        <SelectParameters>
            <asp:Parameter DefaultValue="-1" Name="FileID" Type="Decimal" />
        </SelectParameters>
    </bars:BarsObjectDataSource>
    <bars:BarsObjectDataSource ID="odsEskData2" runat="server" SelectMethod="SelectEskData2"
        TypeName="Bars.W4.VOwEskData" DataObjectTypeName="Bars.W4.VOwEskDataRecord"
        OnSelecting="odsVOwEskData2_Selecting">
        <SelectParameters>
            <asp:Parameter DefaultValue="-1" Name="FileID" Type="Decimal" />
        </SelectParameters>
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
                            ValidationGroup="Main" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    </div>
                </div>
            </StartNavigationTemplate>
            <StepNavigationTemplate>
                <div class="wizard_navigation_container">
                    <div class="subcontainer">
                        <asp:Button ID="btMovePrevious" runat="server" Text="Назад" CommandName="MovePrevious"
                            CausesValidation="false" />
                        <asp:Button ID="btMoveNext" runat="server" Text="Далі" CommandName="MoveNext" CausesValidation="true"
                            ValidationGroup="Main" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    </div>
                </div>
            </StepNavigationTemplate>
            <FinishNavigationTemplate>
                <div class="wizard_navigation_container">
                    <div class="subcontainer">
                        <asp:Button ID="btMovePrevious" runat="server" Text="Назад" CommandName="MovePrevious"
                            CausesValidation="false" />
                        <asp:Button ID="btMoveNext" runat="server" Text="Завершити" CommandName="MoveComplete"
                            CausesValidation="true" ValidationGroup="Main" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    </div>
                </div>
            </FinishNavigationTemplate>
            <WizardSteps>
                <asp:WizardStep ID="wsFile" Title="Файл" runat="server" StepType="Start">
                    <div class="wizard_step_container">
                        <table border="0" cellpadding="3" cellspacing="0" class="data_table">
                            <tr>
                                <td>
                                    <asp:FileUpload ID="fuFile" runat="server" TabIndex="101" Width="300px" />
                                    <asp:RequiredFieldValidator ID="rfvFile" runat="server" ControlToValidate="fuFile"
                                        ErrorMessage="Не вибрано файл" ValidationGroup="Main">
                                    </asp:RequiredFieldValidator>
                                </td>
                            </tr>
                        </table>
                    </div>
                </asp:WizardStep>
                <asp:WizardStep ID="wsImportResults" Title="Результати імпорту" runat="server" StepType="Step"
                    OnActivate="wsImportResults_Activate">
                    <div class="wizard_step_container">
                        <table border="0" cellpadding="3" cellspacing="0" class="data_table">
                            <tr>
                                <td>
                                    <asp:Label ID="FileTitle" runat="server" Font-Bold="true" />
                                </td>
                            </tr>
                            <tr>
                                <td class="rows_separator"></td>
                            </tr>
                            <tr>
                                <td>
                                    <bars:BarsGridViewEx ID="gvEskData" runat="server" AutoGenerateColumns="False"
                                        DataSourceID="odsEskData">
                                        <NewRowStyle CssClass=""></NewRowStyle>
                                        <AlternatingRowStyle CssClass="alternateRow"></AlternatingRowStyle>
                                        <Columns>
                                            <asp:TemplateField HeaderText="Повідомлення" SortExpression="STR_ERR">
                                                <ItemTemplate>
                                                    <div style="width: 200px; white-space: normal">
                                                        <asp:Label ID="STR_ERR" runat="server" Text='<%# Eval("STR_ERR") %>'></asp:Label>
                                                    </div>
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Left" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="ПІБ" SortExpression="LAST_NAME">
                                                <ItemTemplate>
                                                    <asp:Label ID="lNAME" runat="server" Text='<%# String.Format("{0} {1} {2}", Eval("LAST_NAME"), Eval("FIRST_NAME"), Eval("MIDDLE_NAME")) %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Документ" SortExpression="PASPNUM">
                                                <ItemTemplate>
                                                    <asp:Label ID="lDOC" runat="server" Text='<%# String.Format("{0}{1}", Eval("PASPSERIES"), Eval("PASPNUM")) %>'
                                                        ToolTip='<%# String.Format("{0}{1} виданий {2} від {3:d}", Eval("PASPSERIES"), Eval("PASPNUM"), Eval("PASPISSUER"), Eval("PASPDATE")) %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="BDAY" DataFormatString="{0:d}" HeaderText="Дата народж."
                                                SortExpression="BDAY" />
                                            <asp:BoundField DataField="OKPO" HeaderText="ЗКПО" SortExpression="OKPO" />
                                            <%-- <asp:BoundField DataField="PHONE_MOB" HeaderText="Телефон моб." SortExpression="PHONE_MOB" />--%>
                                            <asp:TemplateField HeaderText="Адреса реєстрації" SortExpression="ADDR1_CITYNAME">
                                                <ItemTemplate>
                                                    <asp:Label ID="lADDR1" runat="server" Text='<%# String.Format("{0}; {1}", Eval("ADDR1_CITYNAME"), Eval("ADDR1_STREET")) %>'
                                                        ToolTip='<%# String.Format("{0}; {1}; {2}; {3}",  Eval("ADDR1_DOMAIN"), Eval("ADDR1_REGION"), Eval("ADDR1_CITYNAME"), Eval("ADDR1_STREET")) %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="TABN" HeaderText="Квиток" SortExpression="TABN" />
                                        </Columns>
                                        <EditRowStyle CssClass="editRow"></EditRowStyle>
                                        <FooterStyle CssClass="footerRow"></FooterStyle>
                                        <HeaderStyle CssClass="headerRow"></HeaderStyle>
                                        <PagerStyle CssClass="pagerRow"></PagerStyle>
                                        <RowStyle CssClass="normalRow"></RowStyle>
                                        <SelectedRowStyle CssClass="selectedRow"></SelectedRowStyle>
                                    </bars:BarsGridViewEx>
                                </td>
                            </tr>
                        </table>
                    </div>
                </asp:WizardStep>
                <asp:WizardStep ID="wsProcParams" Title="Параметри обробки" runat="server" StepType="Step">
                    <div class="wizard_step_container">
                        <table border="0" cellpadding="3" cellspacing="0" class="data_table">
                            <tr>
                                <td>
                                    <asp:Label ID="BRANCHTitle" runat="server" Text="Відділення:"></asp:Label>
                                </td>
                                <td>
                                    <bars:TextBoxRefer ID="BRANCH" runat="server" TAB_NAME="OUR_BRANCH" KEY_FIELD="BRANCH"
                                        SEMANTIC_FIELD="NAME" IsRequired="true" ValidationGroup="Main" OnValueChanged="BRANCH_ValueChanged"
                                        Width="300px" TabIndex="301" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="BRANCHNAMETitle" runat="server" Text="Назва відділення:"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="BRANCHNAME" runat="server" Width="300px" Enabled="false" />
                                </td>
                            </tr>
                            <tr class="rows_separator">
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="STAFFTitle" runat="server" Text="Відп.виконавець:"></asp:Label>
                                </td>
                                <td>
                                    <bars:TextBoxRefer ID="STAFF" runat="server" TAB_NAME="STAFF" KEY_FIELD="ID" SEMANTIC_FIELD="FIO"
                                        IsRequired="true" ValidationGroup="Main" OnValueChanged="STAFF_ValueChanged"
                                        Width="300px" TabIndex="302" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="STAFFFIOTitle" runat="server" Text="ПІБ виконавця:"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="STAFFFIO" runat="server" Width="300px" Enabled="false" />
                                </td>
                            </tr>
                            <tr class="rows_separator">
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="PROJECTTitle" runat="server" Text="З/П проект:"></asp:Label>
                                </td>
                                <td>
                                    <bars:TextBoxRefer ID="PROJECT" runat="server" TAB_NAME="BPK_PROECT" KEY_FIELD="ID" WHERE_CLAUSE=" where product_code like 'SAL_STUD_UAH%'"
                                        SEMANTIC_FIELD="NAME" SHOW_FIELDS="OKPO" IsRequired="false" ValidationGroup="Main"
                                        Width="300px" TabIndex="303" ShowSemantic="true" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="CARDCODETitle" runat="server" Text="Тип картки:"></asp:Label>
                                </td>
                                <td>
                                    <bars:TextBoxRefer ID="CARDCODE" runat="server" TAB_NAME="V_W4_CARD" KEY_FIELD="CODE" WHERE_CLAUSE=" where code like '%VECCST%'"
                                        SEMANTIC_FIELD="SUB_NAME" IsRequired="true" ValidationGroup="Main" Width="300px"
                                        TabIndex="304" ShowSemantic="true" />
                                </td>
                            </tr>
                            <tr class="rows_separator">
                            </tr>
                        </table>
                    </div>
                </asp:WizardStep>
                <asp:WizardStep ID="wsProcCheck" Title="Результати перевірки" runat="server" StepType="Step"
                    OnActivate="wsProcCheck_Activate">
                    <div class="wizard_step_container">
                        <table border="0" cellpadding="3" cellspacing="0" class="data_table">
                            <tr>
                                <td>
                                    <asp:Label ID="CheckTitle" runat="server" Font-Bold="true" />
                                </td>
                            </tr>
                            <tr>
                                <td class="rows_separator"></td>
                            </tr>
                            <tr>
                                <td>
                                    <bars:BarsGridViewEx ID="gvEskDataCheck" runat="server" AutoGenerateColumns="False"
                                        DataSourceID="odsEskData2" DataKeyNames="ID,IDN">
                                        <NewRowStyle CssClass=""></NewRowStyle>
                                        <AlternatingRowStyle CssClass="alternateRow"></AlternatingRowStyle>
                                        <Columns>
                                            <asp:TemplateField HeaderText="Відкрити?" SortExpression="FLAG_OPEN">
                                                <ItemTemplate>
                                                    <asp:CheckBox ID="FLAG_OPEN" runat="server" Enabled='<%# (Decimal?)Eval("FLAG_OPEN") == 2 ? true : false %>' ToolTip='<%# Eval("FLAG_OPEN") %>' />
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Center" />
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="ND" HeaderText="Ном. дог." SortExpression="ND"></asp:BoundField>
                                            <asp:BoundField DataField="RNK" HeaderText="РНК" SortExpression="RNK"></asp:BoundField>
                                            <asp:BoundField DataField="NLS" HeaderText="Карт. рахунок" SortExpression="NLS"></asp:BoundField>
                                            <asp:TemplateField HeaderText="ПІБ" SortExpression="LAST_NAME">
                                                <ItemTemplate>
                                                    <asp:Label ID="lNAME" runat="server" Text='<%# String.Format("{0} {1} {2}", Eval("LAST_NAME"), Eval("FIRST_NAME"), Eval("MIDDLE_NAME")) %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Документ" SortExpression="PASPNUM">
                                                <ItemTemplate>
                                                    <asp:Label ID="lDOC" runat="server" Text='<%# String.Format("{0}{1}", Eval("PASPSERIES"), Eval("PASPNUM")) %>'
                                                        ToolTip='<%# String.Format("{0}{1} виданий {2} від {3:d}", Eval("PASPSERIES"), Eval("PASPNUM"), Eval("PASPISSUER"), Eval("PASPDATE")) %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="BDAY" DataFormatString="{0:d}" HeaderText="Дата народж."
                                                SortExpression="BDAY" />
                                            <asp:BoundField DataField="OKPO" HeaderText="ЗКПО" SortExpression="OKPO" />
                                            <asp:BoundField DataField="PHONE_MOB" HeaderText="Телефон моб." SortExpression="PHONE_MOB" />
                                            <asp:TemplateField HeaderText="Адреса реєстрації" SortExpression="ADDR1_CITYNAME">
                                                <ItemTemplate>
                                                    <asp:Label ID="lADDR1" runat="server" Text='<%# String.Format("{0}; {1}", Eval("ADDR1_CITYNAME"), Eval("ADDR1_STREET")) %>'
                                                        ToolTip='<%# String.Format("{0}; {1}; {2}; {3}",  Eval("ADDR1_DOMAIN"), Eval("ADDR1_REGION"), Eval("ADDR1_CITYNAME"), Eval("ADDR1_STREET")) %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="TABN" HeaderText="Квиток" SortExpression="TABN" />
                                        </Columns>
                                        <EditRowStyle CssClass="editRow"></EditRowStyle>
                                        <FooterStyle CssClass="footerRow"></FooterStyle>
                                        <HeaderStyle CssClass="headerRow"></HeaderStyle>
                                        <PagerStyle CssClass="pagerRow"></PagerStyle>
                                        <RowStyle CssClass="normalRow"></RowStyle>
                                        <SelectedRowStyle CssClass="selectedRow"></SelectedRowStyle>
                                    </bars:BarsGridViewEx>
                                </td>
                            </tr>
                        </table>
                    </div>
                </asp:WizardStep>
                <asp:WizardStep ID="wsProcResults" Title="Результати обробки" runat="server" StepType="Finish"
                    OnActivate="wsProcResults_Activate">
                    <div class="wizard_step_container">
                        <table border="0" cellpadding="3" cellspacing="0" class="data_table">
                            <tr>
                                <td>
                                    <asp:Label ID="FileResTitle" runat="server" Font-Bold="true" />&nbsp;
                                    <asp:LinkButton ID="FileResMatch" runat="server" Text="Квитанція" ToolTip="Завантажити квитанцію"
                                        OnClick="FileResMatch_Click"></asp:LinkButton>
                                </td>
                            </tr>
                            <tr>
                                <td class="rows_separator"></td>
                            </tr>
                            <tr>
                                <td>
                                    <bars:BarsGridViewEx ID="gvEskDataRes" runat="server" AutoGenerateColumns="False"
                                        DataSourceID="odsEskData">
                                        <NewRowStyle CssClass=""></NewRowStyle>
                                        <AlternatingRowStyle CssClass="alternateRow"></AlternatingRowStyle>
                                        <Columns>
                                            <asp:TemplateField HeaderText="Повідомлення" SortExpression="STR_ERR">
                                                <ItemTemplate>
                                                    <div style="width: 200px; white-space: normal">
                                                        <asp:Label ID="STR_ERR" runat="server" Text='<%# Eval("STR_ERR") %>'></asp:Label>
                                                    </div>
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Left" />
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="ND" HeaderText="Ном. дог." SortExpression="ND"></asp:BoundField>
                                            <asp:BoundField DataField="RNK" HeaderText="РНК" SortExpression="RNK"></asp:BoundField>
                                            <asp:BoundField DataField="NLS" HeaderText="Карт. рахунок" SortExpression="NLS"></asp:BoundField>
                                            <asp:TemplateField HeaderText="ПІБ" SortExpression="LAST_NAME">
                                                <ItemTemplate>
                                                    <asp:Label ID="lNAME" runat="server" Text='<%# String.Format("{0} {1} {2}", Eval("LAST_NAME"), Eval("FIRST_NAME"), Eval("MIDDLE_NAME")) %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Документ" SortExpression="PASPNUM">
                                                <ItemTemplate>
                                                    <asp:Label ID="lDOC" runat="server" Text='<%# String.Format("{0}{1}", Eval("PASPSERIES"), Eval("PASPNUM")) %>'
                                                        ToolTip='<%# String.Format("{0}{1} виданий {2} від {3:d}", Eval("PASPSERIES"), Eval("PASPNUM"), Eval("PASPISSUER"), Eval("PASPDATE")) %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="BDAY" DataFormatString="{0:d}" HeaderText="Дата народж."
                                                SortExpression="BDAY" />
                                            <asp:BoundField DataField="OKPO" HeaderText="ЗКПО" SortExpression="OKPO" />
                                            <%--   <asp:BoundField DataField="PHONE_MOB" HeaderText="Телефон моб." SortExpression="PHONE_MOB" />--%>
                                            <asp:TemplateField HeaderText="Адреса реєстрації" SortExpression="ADDR1_CITYNAME">
                                                <ItemTemplate>
                                                    <asp:Label ID="lADDR1" runat="server" Text='<%# String.Format("{0}; {1}", Eval("ADDR1_CITYNAME"), Eval("ADDR1_STREET")) %>'
                                                        ToolTip='<%# String.Format("{0}; {1}; {2}; {3}",  Eval("ADDR1_DOMAIN"), Eval("ADDR1_REGION"), Eval("ADDR1_CITYNAME"), Eval("ADDR1_STREET")) %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="TABN" HeaderText="Квиток" SortExpression="TABN" />
                                        </Columns>
                                        <EditRowStyle CssClass="editRow"></EditRowStyle>
                                        <FooterStyle CssClass="footerRow"></FooterStyle>
                                        <HeaderStyle CssClass="headerRow"></HeaderStyle>
                                        <PagerStyle CssClass="pagerRow"></PagerStyle>
                                        <RowStyle CssClass="normalRow"></RowStyle>
                                        <SelectedRowStyle CssClass="selectedRow"></SelectedRowStyle>
                                    </bars:BarsGridViewEx>
                                </td>
                            </tr>
                        </table>
                    </div>
                </asp:WizardStep>
            </WizardSteps>
        </asp:Wizard>
    </div>
</asp:Content>
