<%@ Page Language="C#" AutoEventWireup="true" CodeFile="wcssurveys.aspx.cs" Inherits="credit_constructor_wcssurveys"
    Theme="default" MasterPageFile="~/credit/constructor/master.master" Title="Анкеты"
    Trace="false" ValidateRequest="false" MaintainScrollPositionOnPostback="true" %>

<%@ MasterType VirtualPath="~/credit/constructor/master.master" %>
<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="bars" %>
<%@ Register Src="../usercontrols/TextBoxString.ascx" TagName="TextBoxString" TagPrefix="bec" %>
<%@ Register Src="../usercontrols/TextBoxNumb.ascx" TagName="TextBoxNumb" TagPrefix="bec" %>
<%@ Register Src="../usercontrols/TextBoxQuestion_ID.ascx" TagName="TextBoxQuestion_ID"
    TagPrefix="bec" %>
<%@ Register Src="usercontrols/TextBoxSQLBlock.ascx" TagName="TextBoxSQLBlock" TagPrefix="bec" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script language="javascript" type="text/jscript">
        function ShowSurveyGroups(survey_id) {
            var rnd = Math.random();
            var result = window.showModalDialog('/barsroot/credit/constructor/dialogs/wcsavlbsurveygroups.aspx?survey_id=' + survey_id + '&rnd=' + rnd, window, dialogFeatures);

            if (result == null) return false;
            else return true;
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">
    <div class="dataContainer">
        <asp:ObjectDataSource ID="ods" runat="server" SelectMethod="Select" TypeName="credit.VWcsSurveys"
            DataObjectTypeName="credit.VWcsSurveysRecord" SortParameterName="SortExpression">
        </asp:ObjectDataSource>
        <bars:BarsGridViewEx ID="gv" runat="server" AutoGenerateColumns="False" CaptionText=""
            ClearFilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_delete.png"
            CssClass="barsGridView" DataSourceID="ods" DateMask="dd.MM.yyyy" ExcelImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.export_excel.png"
            FilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_open.png"
            MetaFilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_open.png"
            MetaTableName="" RefreshImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.refresh.png"
            ShowPageSizeBox="False" DataKeyNames="SURVEY_ID" AutoSelectFirstRow="True" JavascriptSelectionType="ServerSelect"
            CloseFilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_close.png"
            EnableModelValidation="True" HoverRowCssClass="hoverRow" AllowSorting="true">
            <FooterStyle CssClass="footerRow"></FooterStyle>
            <HeaderStyle CssClass="headerRow"></HeaderStyle>
            <EditRowStyle CssClass="editRow"></EditRowStyle>
            <PagerStyle CssClass="pagerRow"></PagerStyle>
            <NewRowStyle CssClass=""></NewRowStyle>
            <SelectedRowStyle CssClass="selectedRow"></SelectedRowStyle>
            <AlternatingRowStyle CssClass="alternateRow"></AlternatingRowStyle>
            <Columns>
                <asp:BoundField DataField="SURVEY_ID" HeaderText="Идентификатор" SortExpression="SURVEY_ID">
                    <ItemStyle Width="20%" />
                </asp:BoundField>
                <asp:BoundField DataField="SURVEY_NAME" HeaderText="Наименование" SortExpression="SURVEY_NAME" />
                <asp:BoundField DataField="GRP_CNT" HeaderText="Кол-во груп" SortExpression="GRP_CNT">
                    <ItemStyle Width="30%" />
                </asp:BoundField>
            </Columns>
            <RowStyle CssClass="normalRow"></RowStyle>
        </bars:BarsGridViewEx>
    </div>
    <div class="formViewContainer">
        <bars:BarsObjectDataSource ID="odsFV" runat="server" DataObjectTypeName="credit.VWcsSurveysRecord"
            DeleteMethod="Delete" InsertMethod="Insert" SelectMethod="SelectSurvey" TypeName="credit.VWcsSurveys"
            UpdateMethod="Update">
            <SelectParameters>
                <asp:ControlParameter ControlID="gv" Name="SURVEY_ID" PropertyName="SelectedValue"
                    Size="100" Type="String" />
            </SelectParameters>
        </bars:BarsObjectDataSource>
        <bars:BarsObjectDataSource ID="odsVWcsSurveyGroups" runat="server" DataObjectTypeName="credit.VWcsSurveyGroupsRecord"
            DeleteMethod="Delete" InsertMethod="Insert" SelectMethod="SelectSurveyGroups"
            TypeName="credit.VWcsSurveyGroups" UpdateMethod="Update">
            <SelectParameters>
                <asp:ControlParameter ControlID="gv" Name="SURVEY_ID" PropertyName="SelectedValue"
                    Size="100" Type="String" />
            </SelectParameters>
        </bars:BarsObjectDataSource>
        <asp:FormView ID="fv" runat="server" DataKeyNames="SURVEY_ID" DataSourceID="odsFV"
            OnItemDeleted="fv_ItemDeleted" OnItemInserted="fv_ItemInserted" OnItemUpdated="fv_ItemUpdated"
            CssClass="formView" EnableModelValidation="True">
            <InsertItemTemplate>
                <table border="0" cellpadding="3" cellspacing="0" class="contentTable" style="width: auto">
                    <tr>
                        <td class="titleCell">
                            <asp:Label ID="SURVEY_IDTitle" runat="server" Text='Идентификатор :' />
                        </td>
                        <td>
                            <bec:TextBoxString ID="SURVEY_ID" runat="server" IsRequired="True" MaxLength="100"
                                Value='<%# Bind("SURVEY_ID") %>' ValidationGroup="MainParams"></bec:TextBoxString>
                        </td>
                    </tr>
                    <tr>
                        <td class="titleCell">
                            <asp:Label ID="SURVEY_NAMETitle" runat="server" Text='Наименование :' />
                        </td>
                        <td>
                            <bec:TextBoxString ID="SURVEY_NAME" runat="server" IsRequired="True" Value='<%# Bind("SURVEY_NAME") %>'
                                Width="300px" ValidationGroup="MainParams" />
                        </td>
                    </tr>
                    <tr>
                        <td class="actionButtonsContainer" colspan="2">
                            <asp:ImageButton ID="ibUpdate" runat="server" CommandName="Insert" ImageUrl="/Common/Images/default/16/save.png"
                                Text="Добавить" ToolTip="Добавить" />
                            <asp:ImageButton ID="ibCancel" runat="server" CausesValidation="False" CommandName="Cancel"
                                SkinID="ibCancel" />
                        </td>
                    </tr>
                </table>
            </InsertItemTemplate>
            <ItemTemplate>
                <table border="0" cellpadding="3" cellspacing="0" class="contentTable" style="width: auto">
                    <tr>
                        <td class="titleCell" style="text-align: left">
                            <asp:Panel ID="pnlBase" runat="server" GroupingText="Базовые параметры">
                                <table border="0" cellpadding="3" cellspacing="0" class="contentTable" style="width: auto">
                                    <tr>
                                        <td class="titleCell">
                                            <asp:Label ID="SURVEY_IDTitle" runat="server" Text='Идентификатор :' />
                                        </td>
                                        <td>
                                            <bec:TextBoxString ID="SURVEY_ID" runat="server" IsRequired="True" MaxLength="100"
                                                Value='<%# Bind("SURVEY_ID") %>' ValidationGroup="MainParams" ReadOnly="true">
                                            </bec:TextBoxString>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="titleCell">
                                            <asp:Label ID="SURVEY_NAMETitle" runat="server" Text='Наименование :' meta:resourcekey="NAMELabelTitleResource2" />
                                        </td>
                                        <td>
                                            <bec:TextBoxString ID="SURVEY_NAME" runat="server" IsRequired="True" Value='<%# Bind("SURVEY_NAME") %>'
                                                Width="300px" ValidationGroup="MainParams" ReadOnly="true" />
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </td>
                    </tr>
                    <tr>
                        <td class="titleCell" style="text-align: left">
                            <asp:Panel ID="pnl" runat="server" GroupingText="Групы вопросов">
                                <table border="0" cellpadding="3" cellspacing="0" class="contentTable" style="width: auto">
                                    <tr>
                                        <td>
                                            <asp:ListBox ID="lb" runat="server" DataSourceID="odsVWcsSurveyGroups" DataTextField="GROUP_NAME"
                                                DataValueField="GROUP_ID" Height="200px" Width="300px" AutoPostBack="True" OnDataBound="lb_DataBound"
                                                OnSelectedIndexChanged="lb_SelectedIndexChanged"></asp:ListBox>
                                        </td>
                                        <td valign="middle" align="center" style="width: 50px">
                                        </td>
                                        <td valign="top">
                                            <asp:Panel ID="pnlParams" runat="server" GroupingText="Параметры" Height="250px"
                                                Width="450px" HorizontalAlign="Left">
                                                <table border="0" cellpadding="3" cellspacing="0" class="contentTable" style="width: 100%">
                                                    <tr>
                                                        <td class="titleCell">
                                                            <asp:Label ID="GROUP_IDTitle" runat="server" Text='Идентификатор :' />
                                                        </td>
                                                        <td>
                                                            <bec:TextBoxString ID="GROUP_ID" IsRequired="true" runat="server" Enabled="false" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="titleCell">
                                                            <asp:Label ID="GROUP_NAMETitle" runat="server" Text='Наименование :' />
                                                        </td>
                                                        <td>
                                                            <bec:TextBoxString ID="GROUP_NAME" IsRequired="true" runat="server" Enabled="false"
                                                                Width="300px" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="titleCell">
                                                            <asp:Label ID="DNSHOW_IFTitle" runat="server" Text='Не показывать если :' />
                                                        </td>
                                                        <td>
                                                            <bec:TextBoxSQLBlock ID="DNSHOW_IF" IsRequired="false" Enabled="false" Rows="2" TextMode="MultiLine"
                                                                Width="300px" runat="server" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="titleCell">
                                                            <asp:Label ID="QUEST_CNTTitle" runat="server" Text='Вопросов в групе :' />
                                                        </td>
                                                        <td>
                                                            <bec:TextBoxNumb ID="QUEST_CNT" runat="server" ValidationGroup="Params" Enabled="false">
                                                            </bec:TextBoxNumb>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </asp:Panel>
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </td>
                    </tr>
                    <tr>
                        <td class="actionButtonsContainer">
                            <asp:ImageButton ID="ibEdit" runat="server" CausesValidation="False" CommandName="Edit"
                                ImageUrl="/Common/Images/default/16/open.png" Text="Редактировать" ToolTip="Редактировать" />
                            <asp:ImageButton ID="ibDelete" runat="server" CausesValidation="False" CommandName="Delete"
                                SkinID="ibDelete" OnClientClick="return confirm('Удалить строку?');" />
                            <asp:ImageButton ID="ibNew" runat="server" CausesValidation="False" CommandName="New"
                                ImageUrl="/Common/Images/default/16/new.png" Text="Добавить строку" ToolTip="Добавить строку" />
                        </td>
                    </tr>
                </table>
            </ItemTemplate>
            <EmptyDataTemplate>
                <table border="0" cellpadding="3" cellspacing="0" class="contentTable" style="width: auto">
                    <tr>
                        <td class="actionButtonsContainer" colspan="2">
                            <asp:ImageButton ID="ibNew" runat="server" CausesValidation="False" CommandName="New"
                                ImageUrl="/Common/Images/default/16/new.png" Text="Добавить строку" ToolTip="Добавить строку" />
                        </td>
                    </tr>
                </table>
            </EmptyDataTemplate>
            <EditItemTemplate>
                <table border="0" cellpadding="3" cellspacing="0" class="contentTable" style="width: auto">
                    <tr>
                        <td class="titleCell" style="text-align: left">
                            <asp:Panel ID="pnlBase" runat="server" GroupingText="Базовые параметры">
                                <table border="0" cellpadding="3" cellspacing="0" class="contentTable" style="width: auto">
                                    <tr>
                                        <td class="titleCell">
                                            <asp:Label ID="SURVEY_IDTitle" runat="server" Text='Идентификатор :' />
                                        </td>
                                        <td>
                                            <bec:TextBoxString ID="IDTextBox" runat="server" IsRequired="True" MaxLength="100"
                                                Value='<%# Bind("SURVEY_ID") %>' ValidationGroup="MainParams"></bec:TextBoxString>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="titleCell">
                                            <asp:Label ID="SURVEY_NAMETitle" runat="server" Text='Наименование :' />
                                        </td>
                                        <td>
                                            <bec:TextBoxString ID="SURVEY_NAME" runat="server" IsRequired="True" Value='<%# Bind("SURVEY_NAME") %>'
                                                Width="300px" ValidationGroup="MainParams" />
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </td>
                    </tr>
                    <tr>
                        <td class="titleCell" style="text-align: left">
                            <asp:Panel ID="pnl" runat="server" GroupingText="Групы вопросов">
                                <table border="0" cellpadding="3" cellspacing="0" class="contentTable" style="width: auto">
                                    <tr>
                                        <td>
                                            <asp:ListBox ID="lb" runat="server" DataSourceID="odsVWcsSurveyGroups" DataTextField="GROUP_NAME"
                                                DataValueField="GROUP_ID" Height="200px" Width="300px" AutoPostBack="True" OnDataBound="lb_DataBound"
                                                OnSelectedIndexChanged="lb_SelectedIndexChanged"></asp:ListBox>
                                        </td>
                                        <td valign="middle" align="center" style="width: 50px">
                                            <table border="0" cellpadding="3" cellspacing="0">
                                                <tr>
                                                    <td>
                                                        <asp:ImageButton ID="ibUp" runat="server" ImageUrl="/Common/Images/default/16/arrow_up.png"
                                                            ToolTip="Переместить вверх" CausesValidation="False" OnClick="ibUp_Click" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:ImageButton ID="ibDown" runat="server" ImageUrl="/Common/Images/default/16/arrow_down.png"
                                                            ToolTip="Переместить вниз" CausesValidation="False" OnClick="ibDown_Click" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:ImageButton ID="idDelete" runat="server" ImageUrl="/Common/Images/default/16/cancel.png"
                                                            ToolTip="Удалить" CausesValidation="False" OnClick="idDelete_Click" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:ImageButton ID="ibNew" runat="server" ImageUrl="/Common/Images/default/16/new.png"
                                                            ToolTip="Добавить новую" CausesValidation="False" OnClick="ibNew_Click" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:ImageButton ID="ibNewFromRef" runat="server" CausesValidation="False" OnClientClick=<%# "return ShowSurveyGroups('" + Eval("SURVEY_ID") + "');" %>
                                                            ImageUrl="/Common/Images/default/16/reference_open.png" ToolTip="Добавить групу из справочника" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td valign="top">
                                            <asp:Panel ID="pnlParams" runat="server" GroupingText="Параметры" Width="450px" HorizontalAlign="Left">
                                                <table border="0" cellpadding="3" cellspacing="0" class="contentTable" style="width: 100%">
                                                    <tr>
                                                        <td class="titleCell">
                                                            <asp:Label ID="GROUP_IDTitle" runat="server" Text='Идентификатор :' />
                                                        </td>
                                                        <td>
                                                            <bec:TextBoxString ID="GROUP_ID" IsRequired="true" runat="server" ValidationGroup="Params" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="titleCell">
                                                            <asp:Label ID="GROUP_NAMETitle" runat="server" Text='Наименование :' />
                                                        </td>
                                                        <td>
                                                            <bec:TextBoxString ID="GROUP_NAME" runat="server" IsRequired="true" ValidationGroup="Params"
                                                                Width="300px" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="titleCell">
                                                            <asp:Label ID="DNSHOW_IFTitle" runat="server" Text='Не показывать если :' />
                                                        </td>
                                                        <td>
                                                            <bec:TextBoxSQLBlock ID="DNSHOW_IF" IsRequired="false" Rows="2" TextMode="MultiLine"
                                                                Width="300px" runat="server" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="actionButtonsContainer" colspan="2" style="text-align: right">
                                                            <asp:Button ID="btSave" runat="server" Text="Сохранить" OnClick="btSave_Click" ValidationGroup="Params" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </asp:Panel>
                                            <asp:Panel ID="pnlQuestions" runat="server" GroupingText="Дополнительно" Width="450px"
                                                HorizontalAlign="Left">
                                                <asp:LinkButton ID="lbQuestions" runat="server" OnClick="lbQuestions_Click">
                                                    <asp:Label ID="lQuestions" runat="server" Text="Вопросы"></asp:Label>
                                                    <asp:Label ID="lQUEST_CNT" runat="server"></asp:Label>
                                                </asp:LinkButton>
                                            </asp:Panel>
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </td>
                    </tr>
                    <tr>
                        <td class="actionButtonsContainer" colspan="2">
                            <asp:ImageButton ID="ibUpdate" runat="server" CommandName="Update" ImageUrl="/Common/Images/default/16/save.png"
                                Text="Сохранить" ToolTip="Сохранить" ValidationGroup="MainParams" />
                            <asp:ImageButton ID="ibCancel" runat="server" CausesValidation="False" CommandName="Cancel"
                                SkinID="ibCancel" />
                        </td>
                    </tr>
                </table>
            </EditItemTemplate>
        </asp:FormView>
    </div>
</asp:Content>
