<%@ Page Language="C#" AutoEventWireup="true" CodeFile="wcsscancopies.aspx.cs" Inherits="credit_constructor_wcsscancopies"
    Theme="default" MasterPageFile="~/credit/constructor/master.master" Title="Карты сканкопий"
    Trace="false" MaintainScrollPositionOnPostback="true" %>

<%@ MasterType VirtualPath="~/credit/constructor/master.master" %>
<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="Bars" %>
<%@ Register Src="../usercontrols/TextBoxString.ascx" TagName="TextBoxString" TagPrefix="bec" %>
<%@ Register Src="../usercontrols/DDLList.ascx" TagName="DDLList" TagPrefix="bec" %>
<%@ Register Src="../usercontrols/RBLFlag.ascx" TagName="RBLFlag" TagPrefix="bec" %>
<%@ Register Src="../usercontrols/TextBoxQuestion_ID.ascx" TagName="TextBoxQuestion_ID"
    TagPrefix="bec" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">
    <div class="dataContainer">
        <asp:ObjectDataSource ID="ods" runat="server" SelectMethod="Select" TypeName="credit.VWcsScancopies"
            DataObjectTypeName="credit.VWcsScancopiesRecord" SortParameterName="SortExpression">
        </asp:ObjectDataSource>
        <Bars:BarsGridViewEx ID="gv" runat="server" AutoGenerateColumns="False" CaptionText=""
            ClearFilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_delete.png"
            CssClass="barsGridView" DataSourceID="ods" DateMask="dd.MM.yyyy" ExcelImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.export_excel.png"
            FilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_open.png"
            MetaFilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_open.png"
            MetaTableName="" RefreshImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.refresh.png"
            ShowPageSizeBox="False" DataKeyNames="SCOPY_ID" AutoSelectFirstRow="True" JavascriptSelectionType="ServerSelect"
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
                <asp:BoundField DataField="SCOPY_ID" HeaderText="Идентификатор" SortExpression="SCOPY_ID">
                    <ItemStyle Width="20%" />
                </asp:BoundField>
                <asp:BoundField DataField="SCOPY_NAME" HeaderText="Наименование" SortExpression="SCOPY_NAME" />
                <asp:BoundField DataField="QUEST_CNT" HeaderText="Кол-во сканкопий" SortExpression="QUEST_CNT">
                    <ItemStyle Width="30%" />
                </asp:BoundField>
            </Columns>
            <RowStyle CssClass="normalRow"></RowStyle>
        </Bars:BarsGridViewEx>
    </div>
    <div class="formViewContainer">
        <asp:ObjectDataSource ID="odsFV" runat="server" DataObjectTypeName="credit.VWcsScancopiesRecord"
            DeleteMethod="Delete" InsertMethod="Insert" SelectMethod="SelectScancopy" TypeName="credit.VWcsScancopies"
            UpdateMethod="Update">
            <SelectParameters>
                <asp:ControlParameter ControlID="gv" Name="SCOPY_ID" PropertyName="SelectedValue"
                    Size="100" Type="String" />
            </SelectParameters>
        </asp:ObjectDataSource>
        <Bars:BarsObjectDataSource ID="odsVWcsScancopyQuestions" runat="server" DataObjectTypeName="credit.VWcsScancopyQuestionsRecord"
            SelectMethod="SelectScancopyQuestions" TypeName="credit.VWcsScancopyQuestions">
            <SelectParameters>
                <asp:ControlParameter ControlID="gv" Name="SCOPY_ID" PropertyName="SelectedValue"
                    Size="100" Type="String" />
            </SelectParameters>
        </Bars:BarsObjectDataSource>
        <asp:ObjectDataSource ID="odsWcsScancopyQuestionTypes" runat="server" SelectMethod="Select"
            TypeName="credit.WcsScancopyQuestionTypes"></asp:ObjectDataSource>
        <asp:FormView ID="fv" runat="server" DataKeyNames="SCOPY_ID" DataSourceID="odsFV"
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
                                Value='<%# Bind("SCOPY_ID") %>'></bec:TextBoxString>
                        </td>
                    </tr>
                    <tr>
                        <td class="titleCell">
                            <asp:Label ID="NAMELabelTitle" runat="server" Text='Наименование :' meta:resourcekey="NAMELabelTitleResource2" />
                        </td>
                        <td>
                            <bec:TextBoxString ID="NAMETextBox" runat="server" IsRequired="True" Value='<%# Bind("SCOPY_NAME") %>'
                                Width="300px" />
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
                                    <col class="titleCell" />
                                    <tr>
                                        <td class="titleCell">
                                            <asp:Label ID="Label1" runat="server" Text='Идентификатор :' meta:resourcekey="IDLabelTitleResource1" />
                                        </td>
                                        <td>
                                            <asp:Label ID="Label2" runat="server" Text='<%# Bind("SCOPY_ID") %>' meta:resourcekey="IDLabelResource1" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="titleCell">
                                            <asp:Label ID="Label3" runat="server" Text='Наименование :' meta:resourcekey="NAMELabelTitleResource1" />
                                        </td>
                                        <td>
                                            <bec:TextBoxString ID="NAMETextBox" runat="server" IsRequired="True" Value='<%# Bind("SCOPY_NAME") %>'
                                                Width="300px" ValidationGroup="MainParams" ReadOnly="true"></bec:TextBoxString>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="actionButtonsContainer" colspan="2">
                                            <asp:ImageButton ID="ImageButton2" runat="server" CausesValidation="False" CommandName="Edit"
                                                ImageUrl="/Common/Images/default/16/open.png" Text="Редактировать" ToolTip="Редактировать" />
                                            <asp:ImageButton ID="ImageButton3" runat="server" CausesValidation="False" CommandName="Delete"
                                                SkinID="ibDelete" OnClientClick="return confirm('Удалить строку?');" />
                                            <asp:ImageButton ID="ImageButton4" runat="server" CausesValidation="False" CommandName="New"
                                                ImageUrl="/Common/Images/default/16/new.png" Text="Добавить строку" ToolTip="Добавить строку" />
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </td>
                    </tr>
                    <tr>
                        <td class="titleCell" style="text-align: left">
                            <asp:Panel ID="pnl" runat="server" GroupingText="Сканкопии">
                                <table border="0" cellpadding="3" cellspacing="0" class="contentTable" style="width: auto">
                                    <tr>
                                        <td>
                                            <asp:ListBox ID="lb" runat="server" DataSourceID="odsVWcsScancopyQuestions" DataTextField="QUESTION_DESC"
                                                DataValueField="QUESTION_ID" Height="300px" Width="500px" AutoPostBack="True"
                                                OnDataBound="lb_DataBound" OnSelectedIndexChanged="lb_SelectedIndexChanged">
                                            </asp:ListBox>
                                        </td>
                                        <td valign="middle" align="center" style="width: 50px">
                                        </td>
                                        <td valign="top">
                                            <asp:Panel ID="pnlParams" runat="server" GroupingText="Параметры" Height="350px"
                                                Width="450px" HorizontalAlign="Left" Enabled="false">
                                                <table border="0" cellpadding="3" cellspacing="0" class="contentTable" style="width: 100%">
                                                    <col class="titleCell" />
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="QUESTION_IDTitle" runat="server" Text='Идентификатор :' />
                                                        </td>
                                                        <td>
                                                            <bec:TextBoxQuestion_ID ID="QUESTION_ID" IsRequired="true" runat="server"
                                                                ValidationGroup="Params" SECTIONS="inc:SCANCOPIES"
                                                                TYPES="FILE" />
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
                                                            <asp:Label ID="TYPE_IDTitle" runat="server" Text='Тип :' />
                                                        </td>
                                                        <td>
                                                            <bec:DDLList ID="ddllTYPE_ID" runat="server" DataSourceID="odsWcsScancopyQuestionTypes"
                                                                DataTextField="NAME" DataValueField="ID" IsRequired="true">
                                                            </bec:DDLList>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="IS_REQUIREDTitle" runat="server" Text='Обязательный :' />
                                                        </td>
                                                        <td>
                                                            <bec:RBLFlag ID="IS_REQUIREDRBLFlag" IsRequired="true" DefaultValue="false" runat="server" />
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
                </table>
            </ItemTemplate>
            <EditItemTemplate>
                <table border="0" cellpadding="3" cellspacing="0" class="contentTable" style="width: auto">
                    <tr>
                        <td class="titleCell" style="text-align: left">
                            <asp:Panel ID="pnlBase" runat="server" GroupingText="Базовые параметры">
                                <table border="0" cellpadding="3" cellspacing="0" class="contentTable" style="width: auto">
                                    <col class="titleCell" />
                                    <tr>
                                        <td class="titleCell">
                                            <asp:Label ID="IDLabelTitle" runat="server" Text='Идентификатор :' meta:resourcekey="IDLabelTitleResource1" />
                                        </td>
                                        <td>
                                            <asp:Label ID="IDLabel" runat="server" Text='<%# Bind("SCOPY_ID") %>' meta:resourcekey="IDLabelResource1" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="titleCell">
                                            <asp:Label ID="NAMELabelTitle" runat="server" Text='Наименование :' meta:resourcekey="NAMELabelTitleResource1" />
                                        </td>
                                        <td>
                                            <bec:TextBoxString ID="NAMETextBox" runat="server" IsRequired="True" Value='<%# Bind("SCOPY_NAME") %>'
                                                Width="300px" ValidationGroup="MainParams"></bec:TextBoxString>
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
                            </asp:Panel>
                        </td>
                    </tr>
                    <tr>
                        <td class="titleCell" style="text-align: left">
                            <asp:Panel ID="pnl" runat="server" GroupingText="Сканкопии">
                                <table border="0" cellpadding="3" cellspacing="0" class="contentTable" style="width: auto">
                                    <tr>
                                        <td>
                                            <asp:ListBox ID="lb" runat="server" DataSourceID="odsVWcsScancopyQuestions" DataTextField="QUESTION_DESC"
                                                DataValueField="QUESTION_ID" Height="300px" Width="500px" AutoPostBack="True"
                                                OnDataBound="lb_DataBound" OnSelectedIndexChanged="lb_SelectedIndexChanged">
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
                                                            ToolTip="Удалить" CausesValidation="False" OnClick="idDelete_Click" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:ImageButton ID="ibNew" runat="server" ImageUrl="/Common/Images/default/16/new.png"
                                                            ToolTip="Добавить новый" CausesValidation="False" OnClick="ibNew_Click" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td valign="top">
                                            <asp:Panel ID="pnlParams" runat="server" GroupingText="Параметры" Height="350px"
                                                Width="450px" HorizontalAlign="Left">
                                                <table border="0" cellpadding="3" cellspacing="0" class="contentTable" style="width: 100%">
                                                    <col class="titleCell" />
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="QUESTION_IDTitle" runat="server" Text='Идентификатор :' />
                                                        </td>
                                                        <td>
                                                            <bec:TextBoxQuestion_ID ID="QUESTION_ID" IsRequired="true" runat="server"
                                                                ValidationGroup="Params" SECTIONS="inc:SCANCOPIES"
                                                                TYPES="FILE" />
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
                                                            <asp:Label ID="TYPE_IDTitle" runat="server" Text='Тип :' />
                                                        </td>
                                                        <td>
                                                            <bec:DDLList ID="ddllTYPE_ID" runat="server" DataSourceID="odsWcsScancopyQuestionTypes"
                                                                DataTextField="NAME" DataValueField="ID" IsRequired="true">
                                                            </bec:DDLList>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="IS_REQUIREDTitle" runat="server" Text='Обязательный :' />
                                                        </td>
                                                        <td>
                                                            <bec:RBLFlag ID="IS_REQUIREDRBLFlag" IsRequired="true" DefaultValue="false" runat="server" />
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
                </table>
            </EditItemTemplate>
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
        </asp:FormView>
    </div>
</asp:Content>
