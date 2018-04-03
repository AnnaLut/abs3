<%@ Page Language="C#" AutoEventWireup="true" CodeFile="wcsinfoqueries.aspx.cs" Inherits="credit_constructor_wcsinfoqueries"
    Theme="default" MasterPageFile="~/credit/constructor/master.master" Title="Информационные запросы"
    Trace="false" ValidateRequest="false" MaintainScrollPositionOnPostback="true" %>

<%@ MasterType VirtualPath="~/credit/constructor/master.master" %>
<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="bars" %>
<%@ Register Src="../usercontrols/TextBoxString.ascx" TagName="TextBoxString" TagPrefix="bec" %>
<%@ Register Src="../usercontrols/DDLList.ascx" TagName="DDLList" TagPrefix="bec" %>
<%@ Register Src="../usercontrols/RBLFlag.ascx" TagName="RBLFlag" TagPrefix="bec" %>
<%@ Register Src="usercontrols/TextBoxSQLBlock.ascx" TagName="TextBoxSQLBlock" TagPrefix="bec" %>
<%@ Register Src="../usercontrols/TextBoxQuestion_ID.ascx" TagName="TextBoxQuestion_ID"
    TagPrefix="bec" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">
    <div class="dataContainer">
        <asp:ObjectDataSource ID="ods" runat="server" SelectMethod="Select" TypeName="credit.VWcsInfoqueries"
            DataObjectTypeName="credit.VWcsInfoqueriesRecord" SortParameterName="SortExpression">
        </asp:ObjectDataSource>
        <bars:BarsGridViewEx ID="gv" runat="server" AutoGenerateColumns="False" CaptionText=""
            ClearFilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_delete.png"
            CssClass="barsGridView" DataSourceID="ods" DateMask="dd.MM.yyyy" ExcelImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.export_excel.png"
            FilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_open.png"
            MetaFilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_open.png"
            MetaTableName="" RefreshImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.refresh.png"
            ShowPageSizeBox="False" DataKeyNames="IQUERY_ID" AutoSelectFirstRow="True" JavascriptSelectionType="ServerSelect"
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
                <asp:BoundField DataField="IQUERY_ID" HeaderText="Идентификатор" SortExpression="IQUERY_ID">
                    <ItemStyle Width="20%" />
                </asp:BoundField>
                <asp:BoundField DataField="IQUERY_NAME" HeaderText="Наименование" SortExpression="IQUERY_NAME" />
                <asp:BoundField DataField="TYPE_NAME" HeaderText="Тип" SortExpression="TYPE_NAME" />
            </Columns>
            <RowStyle CssClass="normalRow"></RowStyle>
        </bars:BarsGridViewEx>
    </div>
    <div class="formViewContainer">
        <bars:BarsObjectDataSource ID="odsFV" runat="server" DataObjectTypeName="credit.VWcsInfoqueriesRecord"
            DeleteMethod="Delete" InsertMethod="Insert" SelectMethod="SelectInfoquery" TypeName="credit.VWcsInfoqueries"
            UpdateMethod="Update">
            <SelectParameters>
                <asp:ControlParameter ControlID="gv" Name="IQUERY_ID" PropertyName="SelectedValue"
                    Size="100" Type="String" />
            </SelectParameters>
        </bars:BarsObjectDataSource>
        <bars:BarsObjectDataSource ID="odsVWcsAuthorizationQuestions" runat="server" DataObjectTypeName="credit.VWcsInfoqueryQuestionsRecord"
            DeleteMethod="Delete" InsertMethod="Insert" SelectMethod="SelectInfoqueryQuestions"
            TypeName="credit.VWcsInfoqueryQuestions" UpdateMethod="Update">
            <SelectParameters>
                <asp:ControlParameter ControlID="gv" Name="IQUERY_ID" PropertyName="SelectedValue"
                    Size="100" Type="String" />
            </SelectParameters>
        </bars:BarsObjectDataSource>
        <bars:BarsObjectDataSource ID="odsWcsInfoqueryTypes" runat="server" SelectMethod="Select"
            TypeName="credit.WcsInfoqueryTypes">
        </bars:BarsObjectDataSource>
        <asp:FormView ID="fv" runat="server" DataKeyNames="IQUERY_ID" DataSourceID="odsFV"
            OnItemDeleted="fv_ItemDeleted" OnItemInserted="fv_ItemInserted" OnItemUpdated="fv_ItemUpdated"
            CssClass="formView" EnableModelValidation="True">
            <InsertItemTemplate>
                <table border="0" cellpadding="3" cellspacing="0" class="contentTable" style="width: auto">
                    <tr>
                        <td class="titleCell">
                            <asp:Label ID="IDLabelTitle" runat="server" Text='Идентификатор :' />
                        </td>
                        <td>
                            <bec:TextBoxString ID="IDTextBox" runat="server" IsRequired="True" MaxLength="100"
                                Value='<%# Bind("IQUERY_ID") %>'>
                            </bec:TextBoxString>
                        </td>
                    </tr>
                    <tr>
                        <td class="titleCell">
                            <asp:Label ID="NAMELabelTitle" runat="server" Text='Наименование :' meta:resourcekey="NAMELabelTitleResource2" />
                        </td>
                        <td>
                            <bec:TextBoxString ID="NAMETextBox" runat="server" IsRequired="True" Value='<%# Bind("IQUERY_NAME") %>'
                                Width="300px" />
                        </td>
                    </tr>
                    <tr>
                        <td class="titleCell">
                            <asp:Label ID="TYPETitle" runat="server" Text="Тип :" meta:resourcekey="TYPETitleResource1" />
                        </td>
                        <td>
                            <bec:DDLList ID="TYPEDropDownList" runat="server" DataSourceID="odsWcsInfoqueryTypes"
                                DataValueField="ID" DataTextField="NAME" SelectedValue='<%# Bind("TYPE_ID") %>'>
                            </bec:DDLList>
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
                        <td class="titleCell">
                            <asp:Label ID="IDLabelTitle" runat="server" Text='Идентификатор :' meta:resourcekey="IDLabelTitleResource3" />
                        </td>
                        <td>
                            <asp:Label ID="IDLabel" runat="server" Text='<%# Bind("IQUERY_ID") %>' meta:resourcekey="IDLabelResource2" />
                        </td>
                    </tr>
                    <tr>
                        <td class="titleCell">
                            <asp:Label ID="NAMELabelTitle" runat="server" Text='Наименование :' meta:resourcekey="NAMELabelTitleResource3" />
                        </td>
                        <td>
                            <asp:Label ID="NAMELabel" runat="server" Text='<%# Bind("IQUERY_NAME") %>' meta:resourcekey="NAMELabelResource1" />
                        </td>
                    </tr>
                    <tr>
                        <td class="titleCell">
                            <asp:Label ID="TYPETitle" runat="server" Text="Тип :" meta:resourcekey="TYPETitleResource3" />
                        </td>
                        <td>
                            <bec:DDLList ID="TYPEDropDownList" runat="server" DataSourceID="odsWcsInfoqueryTypes"
                                DataValueField="ID" DataTextField="NAME" ReadOnly="true" SelectedValue='<%# Bind("TYPE_ID") %>'>
                            </bec:DDLList>
                        </td>
                    </tr>
                    <tr>
                        <td class="titleCell" colspan="2" style="text-align: left">
                            <asp:Label ID="PLSQLTitle" runat="server" Text="plsql блок :" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <bec:TextBoxSQLBlock ID="PLSQLTextBox" Value='<%# Bind("PLSQL") %>' IsRequired="true"
                                Rows="10" TextMode="MultiLine" Width="600px" runat="server" Enabled="false" />
                        </td>
                    </tr>
                    <tr>
                        <td class="actionButtonsContainer" colspan="2">
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
                                            <asp:Label ID="IDLabelTitle" runat="server" Text='Идентификатор :' />
                                        </td>
                                        <td>
                                            <bec:TextBoxString ID="IDTextBox" runat="server" IsRequired="True" MaxLength="100"
                                                Value='<%# Bind("IQUERY_ID") %>' ValidationGroup="MainParams">
                                            </bec:TextBoxString>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="titleCell">
                                            <asp:Label ID="NAMELabelTitle" runat="server" Text='Наименование :' meta:resourcekey="NAMELabelTitleResource2" />
                                        </td>
                                        <td>
                                            <bec:TextBoxString ID="NAMETextBox" runat="server" IsRequired="True" Value='<%# Bind("IQUERY_NAME") %>'
                                                Width="300px" ValidationGroup="MainParams" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="titleCell">
                                            <asp:Label ID="TYPETitle" runat="server" Text="Тип :" meta:resourcekey="TYPETitleResource1" />
                                        </td>
                                        <td>
                                            <bec:DDLList ID="TYPEDropDownList" runat="server" DataSourceID="odsWcsInfoqueryTypes"
                                                DataValueField="ID" DataTextField="NAME" SelectedValue='<%# Bind("TYPE_ID") %>'
                                                ValidationGroup="MainParams">
                                            </bec:DDLList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="titleCell" colspan="2" style="text-align: left">
                                            <asp:Label ID="PLSQLTitle" runat="server" Text="plsql блок :" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <bec:TextBoxSQLBlock ID="PLSQLTextBox" Value='<%# Bind("PLSQL") %>' IsRequired="true"
                                                Rows="10" TextMode="MultiLine" Width="600px" runat="server" ValidationGroup="MainParams" />
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </td>
                    </tr>
                    <tr>
                        <td class="titleCell" style="text-align: left">
                            <asp:Panel ID="pnl" runat="server" GroupingText="Вопросы">
                                <table border="0" cellpadding="3" cellspacing="0" class="contentTable" style="width: auto">
                                    <tr>
                                        <td>
                                            <asp:ListBox ID="lb" runat="server" DataSourceID="odsVWcsAuthorizationQuestions"
                                                DataTextField="QUESTION_NAME" DataValueField="QUESTION_ID" Height="150px" Width="400px"
                                                AutoPostBack="True" OnDataBound="lb_DataBound" OnSelectedIndexChanged="lb_SelectedIndexChanged">
                                            </asp:ListBox>
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
                                                            ToolTip="Удалить" CausesValidation="False" OnClick="idDelete_Click" Width="16px"
                                                            Height="16px" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:ImageButton ID="ibNew" runat="server" ImageUrl="/Common/Images/default/16/new.png"
                                                            ToolTip="Добавить новый" OnClick="ibNew_Click" CausesValidation="False" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td valign="top">
                                            <asp:Panel ID="pnlParams" runat="server" GroupingText="Параметры" Height="320px"
                                                Width="500px" HorizontalAlign="Left">
                                                <table border="0" cellpadding="3" cellspacing="0" class="contentTable" style="width: 100%">
                                                    <col class="titleCell" />
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="QUESTION_IDTitle" runat="server" Text='Идентификатор :' />
                                                        </td>
                                                        <td>
                                                            <bec:TextBoxQuestion_ID ID="QUESTION_ID" IsRequired="true" runat="server" ValidationGroup="Params" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="QUESTION_NAMETitle" runat="server" Text='Наименование :' />
                                                        </td>
                                                        <td>
                                                            <bec:TextBoxString ID="QUESTION_NAME" runat="server" Enabled="false" Width="300px" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="TYPE_NAMETitle" runat="server" Text='Тип :' />
                                                        </td>
                                                        <td>
                                                            <bec:TextBoxString ID="TYPE_NAME" runat="server" Enabled="false" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="IS_REQUIREDTitle" runat="server" Text='Обязателен :' />
                                                        </td>
                                                        <td>
                                                            <bec:RBLFlag ID="IS_REQUIRED" IsRequired="true" DefaultValue="true" runat="server"
                                                                ValidationGroup="Params" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="IS_CHECKABLETitle" runat="server" Text='Проверяется :' />
                                                        </td>
                                                        <td>
                                                            <bec:RBLFlag ID="IS_CHECKABLE" IsRequired="true" DefaultValue="false" runat="server"
                                                                OnValueChanged="IS_CHECKABLE_ValueChanged" OnPreRender="IS_CHECKABLE_PreRender"
                                                                ValidationGroup="Params" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="CHECK_PROCTitle" runat="server" Text='Текст проверки :' />
                                                        </td>
                                                        <td>
                                                            <bec:TextBoxSQLBlock ID="CHECK_PROC" runat="server" Rows="5" TextMode="MultiLine"
                                                                Width="350px" TYPES="TEXT,NUMB,DECIMAL,DATE,LIST,REFER,BOOL" ValidationGroup="Params">
                                                            </bec:TextBoxSQLBlock>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="actionButtonsContainer" colspan="2" style="text-align: right">
                                                            <asp:Button ID="btSave" runat="server" Text="Сохранить" OnClick="btSave_Click" ValidationGroup="Params" />
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
