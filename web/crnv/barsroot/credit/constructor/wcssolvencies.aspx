﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="wcssolvencies.aspx.cs" Inherits="credit_constructor_wcssolvencies"
    Theme="default" MasterPageFile="~/credit/constructor/master.master" Title="Карты кредитоспособности"
    Trace="false" MaintainScrollPositionOnPostback="true" %>

<%@ MasterType VirtualPath="~/credit/constructor/master.master" %>
<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="Bars" %>
<%@ Register Src="../usercontrols/TextBoxString.ascx" TagName="TextBoxString" TagPrefix="bec" %>
<%@ Register Src="../constructor/usercontrols/TextBoxSQLBlock.ascx" TagName="TextBoxSQLBlock"
    TagPrefix="bec" %>
<%@ Register Src="../usercontrols/TextBoxQuestion_ID.ascx" TagName="TextBoxQuestion_ID"
    TagPrefix="bec" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">
    <div class="dataContainer">
        <asp:ObjectDataSource ID="ods" runat="server" SelectMethod="Select" TypeName="credit.VWcsSolvencies"
            DataObjectTypeName="credit.VWcsSolvenciesRecord" SortParameterName="SortExpression"></asp:ObjectDataSource>
        <bars:BarsGridViewEx ID="gv" runat="server" AutoGenerateColumns="False" CaptionText=""
            ClearFilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_delete.png"
            CssClass="barsGridView" DataSourceID="ods" DateMask="dd.MM.yyyy" ExcelImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.export_excel.png"
            FilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_open.png"
            MetaFilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_open.png"
            MetaTableName="" RefreshImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.refresh.png"
            ShowPageSizeBox="False" DataKeyNames="SOLV_ID" AutoSelectFirstRow="True" JavascriptSelectionType="ServerSelect"
            CloseFilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_close.png"
            EnableModelValidation="True" HoverRowCssClass="hoverRow" AllowSorting="true" OnSelectedIndexChanged="gv_SelectedIndexChanged">
            <FooterStyle CssClass="footerRow"></FooterStyle>
            <HeaderStyle CssClass="headerRow"></HeaderStyle>
            <EditRowStyle CssClass="editRow"></EditRowStyle>
            <PagerStyle CssClass="pagerRow"></PagerStyle>
            <NewRowStyle CssClass=""></NewRowStyle>
            <SelectedRowStyle CssClass="selectedRow"></SelectedRowStyle>
            <AlternatingRowStyle CssClass="alternateRow"></AlternatingRowStyle>
            <Columns>
                <asp:BoundField DataField="SOLV_ID" HeaderText="Идентификатор" SortExpression="SOLV_ID">
                    <ItemStyle Width="20%" />
                </asp:BoundField>
                <asp:BoundField DataField="SOLV_NAME" HeaderText="Наименование" SortExpression="SOLV_NAME" />
                <asp:BoundField DataField="QUEST_CNT" HeaderText="Кол-во вопросов" SortExpression="QUEST_CNT">
                    <ItemStyle Width="30%" />
                </asp:BoundField>
            </Columns>
            <RowStyle CssClass="normalRow"></RowStyle>
        </bars:BarsGridViewEx>
    </div>
    <div class="formViewContainer">
        <asp:ObjectDataSource ID="odsFV" runat="server" DataObjectTypeName="credit.VWcsSolvenciesRecord"
            DeleteMethod="Delete" InsertMethod="Insert" SelectMethod="SelectSolvency" TypeName="credit.VWcsSolvencies"
            UpdateMethod="Update">
            <SelectParameters>
                <asp:ControlParameter ControlID="gv" Name="SOLV_ID" PropertyName="SelectedValue"
                    Size="100" Type="String" />
            </SelectParameters>
        </asp:ObjectDataSource>
        <bars:BarsObjectDataSource ID="odsVWcsSolvencyQuestions" runat="server" DataObjectTypeName="credit.VWcsSolvencyQuestionsRecord"
            DeleteMethod="Delete" InsertMethod="Insert" SelectMethod="SelectSolvencyQuestions"
            TypeName="credit.VWcsSolvencyQuestions" UpdateMethod="Update">
            <SelectParameters>
                <asp:ControlParameter ControlID="gv" Name="SOLV_ID" PropertyName="SelectedValue"
                    Size="100" Type="String" />
            </SelectParameters>
        </bars:BarsObjectDataSource>
        <asp:FormView ID="fv" runat="server" DataKeyNames="SOLV_ID" DataSourceID="odsFV"
            OnItemDeleted="fv_ItemDeleted" OnItemInserted="fv_ItemInserted" OnItemUpdated="fv_ItemUpdated"
            CssClass="formView" EnableModelValidation="True" OnPreRender="fv_PreRender">
            <InsertItemTemplate>
                <table border="0" cellpadding="3" cellspacing="0" class="contentTable" style="width: auto">
                    <tr>
                        <td class="titleCell">
                            <asp:Label ID="SOLV_IDTitle" runat="server" Text='Идентификатор :' />
                        </td>
                        <td>
                            <bec:TextBoxString ID="SOLV_ID" runat="server" IsRequired="True" MaxLength="100"
                                Value='<%# Bind("SOLV_ID") %>'></bec:TextBoxString>
                        </td>
                    </tr>
                    <tr>
                        <td class="titleCell">
                            <asp:Label ID="SOLV_NAMETitle" runat="server" Text='Наименование :' meta:resourcekey="NAMELabelTitleResource2" />
                        </td>
                        <td>
                            <bec:TextBoxString ID="SOLV_NAME" runat="server" IsRequired="True" Value='<%# Bind("SOLV_NAME") %>'
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
                                            <asp:Label ID="SOLV_IDTitle" runat="server" Text='Идентификатор :' meta:resourcekey="IDLabelTitleResource1" />
                                        </td>
                                        <td>
                                            <asp:Label ID="SOLV_ID" runat="server" Text='<%# Bind("SOLV_ID") %>' meta:resourcekey="IDLabelResource1" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="titleCell">
                                            <asp:Label ID="SOLV_NAMETitle" runat="server" Text='Наименование :' meta:resourcekey="NAMELabelTitleResource1" />
                                        </td>
                                        <td>
                                            <bec:TextBoxString ID="SOLV_NAME" runat="server" IsRequired="True" Value='<%# Bind("SOLV_NAME") %>'
                                                Width="300px" ValidationGroup="MainParams"></bec:TextBoxString>
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
                                            <asp:ListBox ID="lb" runat="server" DataSourceID="odsVWcsSolvencyQuestions" DataTextField="QUESTION_DESC"
                                                DataValueField="QUESTION_ID" Height="300px" Width="500px" AutoPostBack="True"
                                                OnDataBound="lb_DataBound" OnSelectedIndexChanged="lb_SelectedIndexChanged"></asp:ListBox>
                                        </td>
                                        <td valign="middle" align="center" style="width: 50px">
                                            <table border="0" cellpadding="3" cellspacing="0">
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
                                            <asp:Panel ID="pnlParams" runat="server" GroupingText="Параметры" Height="350px"
                                                Width="450px" HorizontalAlign="Left">
                                                <table border="0" cellpadding="3" cellspacing="0" class="contentTable" style="width: 100%">
                                                    <tr>
                                                        <td class="titleCell">
                                                            <asp:Label ID="QUESTION_IDTitle" runat="server" Text='Идентификатор :' />
                                                        </td>
                                                        <td>
                                                            <bec:TextBoxQuestion_ID ID="QUESTION_ID" IsRequired="true" ReadOnly="false" runat="server"
                                                                ValidationGroup="Params" SECTIONS="inc:AUTHS,SURVEYS,CREDITDATAS,GARANTEES,INSURANCES,INFOQUERIES,SOLVENCIES,SCORINGS,STOPS"
                                                                TYPES="TEXT,NUMB,DECIMAL,DATE,LIST,REFER,MATRIX,BOOL" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="titleCell">
                                                            <asp:Label ID="QUESTION_NAMETitle" runat="server" Text='Наименование :' />
                                                        </td>
                                                        <td>
                                                            <bec:TextBoxString ID="QUESTION_NAME" runat="server" Enabled="false" Width="300px" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="titleCell">
                                                            <asp:Label ID="TYPE_NAMETitle" runat="server" Text='Тип :' />
                                                        </td>
                                                        <td>
                                                            <bec:TextBoxString ID="TYPE_NAME" runat="server" Enabled="false" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="titleCell" colspan="2" style="text-align: left">
                                                            <asp:Label ID="CALC_PROCTitle" runat="server" Text="Текст вычисления :" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="2">
                                                            <bec:TextBoxSQLBlock ID="CALC_PROC" IsRequired="true" Rows="8" TextMode="MultiLine"
                                                                Width="400px" runat="server" />
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
            <ItemTemplate>
                <table border="0" cellpadding="3" cellspacing="0" class="contentTable" style="width: auto">
                    <tr>
                        <td class="titleCell" style="text-align: left">
                            <asp:Panel ID="pnlBase" runat="server" GroupingText="Базовые параметры">
                                <table border="0" cellpadding="3" cellspacing="0" class="contentTable" style="width: auto">
                                    <tr>
                                        <td class="titleCell">
                                            <asp:Label ID="SOLV_IDTitle" runat="server" Text='Идентификатор :' meta:resourcekey="IDLabelTitleResource1" />
                                        </td>
                                        <td>
                                            <asp:Label ID="SOLV_ID" runat="server" Text='<%# Bind("SOLV_ID") %>' meta:resourcekey="IDLabelResource1" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="titleCell">
                                            <asp:Label ID="SOLV_NAMETitle" runat="server" Text='Наименование :' meta:resourcekey="NAMELabelTitleResource1" />
                                        </td>
                                        <td>
                                            <bec:TextBoxString ID="SOLV_NAME" runat="server" IsRequired="True" Value='<%# Bind("SOLV_NAME") %>'
                                                Width="300px" ValidationGroup="MainParams" ReadOnly="true"></bec:TextBoxString>
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
                                            <asp:ListBox ID="lb" runat="server" DataSourceID="odsVWcsSolvencyQuestions" DataTextField="QUESTION_DESC"
                                                DataValueField="QUESTION_ID" Height="300px" Width="500px" AutoPostBack="True"
                                                OnDataBound="lb_DataBound" OnSelectedIndexChanged="lb_SelectedIndexChanged"></asp:ListBox>
                                        </td>
                                        <td valign="middle" align="center" style="width: 50px"></td>
                                        <td valign="top">
                                            <asp:Panel ID="pnlParams" runat="server" GroupingText="Параметры" Height="350px"
                                                Width="450px" HorizontalAlign="Left">
                                                <table border="0" cellpadding="3" cellspacing="0" class="contentTable" style="width: 100%">
                                                    <tr>
                                                        <td class="titleCell">
                                                            <asp:Label ID="QUESTION_IDTitle" runat="server" Text='Идентификатор :' />
                                                        </td>
                                                        <td>
                                                            <bec:TextBoxQuestion_ID ID="QUESTION_ID" IsRequired="true" ReadOnly="true" runat="server"
                                                                ValidationGroup="Params" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="titleCell">
                                                            <asp:Label ID="QUESTION_NAMETitle" runat="server" Text='Наименование :' />
                                                        </td>
                                                        <td>
                                                            <bec:TextBoxString ID="QUESTION_NAME" runat="server" Enabled="false" Width="300px" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="titleCell">
                                                            <asp:Label ID="TYPE_NAMETitle" runat="server" Text='Тип :' />
                                                        </td>
                                                        <td>
                                                            <bec:TextBoxString ID="TYPE_NAME" runat="server" Enabled="false" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="titleCell" colspan="2" style="text-align: left">
                                                            <asp:Label ID="CALC_PROCTitle" runat="server" Text="Текст вычисления :" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="2">
                                                            <bec:TextBoxSQLBlock ID="CALC_PROC" IsRequired="true" Rows="8" TextMode="MultiLine"
                                                                Width="400px" Enabled="false" runat="server" />
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
        </asp:FormView>
    </div>
</asp:Content>
