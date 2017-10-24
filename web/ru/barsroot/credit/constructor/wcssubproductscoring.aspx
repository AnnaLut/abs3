﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="wcssubproductscoring.aspx.cs"
    Inherits="credit_constructor_wcssubproductscoring" Theme="default" MasterPageFile="~/credit/constructor/master.master"
    Title="Карта скоринга (фин. сост.)" %>

<%@ MasterType VirtualPath="~/credit/constructor/master.master" %>
<%@ Register Src="../usercontrols/TextBoxString.ascx" TagName="TextBoxString" TagPrefix="bec" %>
<%@ Register Src="../usercontrols/TextBoxNumb.ascx" TagName="TextBoxNumb" TagPrefix="bec" %>
<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="Bars" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">
    <Bars:BarsSqlDataSourceEx ID="sds" runat="server" SelectCommand="select * from v_wcs_scorings s where not exists (select * from wcs_subproduct_scoring ss where ss.subproduct_id = :SUBPRODUCT_ID and ss.scoring_id = s.scoring_id)"
        AllowPaging="False" ProviderName="barsroot.core">
        <SelectParameters>
            <asp:SessionParameter Name="SUBPRODUCT_ID" SessionField="WCS_SUBPRODUCT_ID" Type="String"
                Direction="Input" />
        </SelectParameters>
    </Bars:BarsSqlDataSourceEx>
    <div class="dataContainer">
        <table border="0" cellpadding="3" cellspacing="0">
            <tr>
                <td>
                    <asp:ListBox ID="lb" runat="server" DataSourceID="sds" DataTextField="SCORING_NAME"
                        DataValueField="SCORING_ID" Height="200px" Width="300px" OnDataBound="lb_DataBound">
                    </asp:ListBox>
                </td>
                <td valign="middle" align="center" style="width: 50px">
                    <table border="0" cellpadding="3" cellspacing="0">
                        <tr>
                            <td>
                                <asp:ImageButton ID="ibAdd" runat="server" ImageUrl="/Common/Images/default/16/ok.png"
                                    ToolTip="Добавить" OnClick="ibAdd_Click" />
                            </td>
                        </tr>
                    </table>
                </td>
                <td valign="top">
                    <asp:Panel ID="pnlParams" runat="server" GroupingText="Текущая карта скоринга" Height="200px"
                        Width="450px" HorizontalAlign="Left">
                        <table border="0" cellpadding="3" cellspacing="0" class="contentTable">
                            <tr>
                                <td class="titleCell">
                                    <asp:Label ID="SCORING_IDTitle" runat="server" Text='Идентификатор :' />
                                </td>
                                <td>
                                    <bec:TextBoxString ID="SCORING_ID" runat="server" Enabled="false"></bec:TextBoxString>
                                </td>
                            </tr>
                            <tr>
                                <td class="titleCell">
                                    <asp:Label ID="SCORING_NAMETitle" runat="server" Text='Наименование :' />
                                </td>
                                <td>
                                    <bec:TextBoxString ID="SCORING_NAME" runat="server" Width="300px" Enabled="false">
                                    </bec:TextBoxString>
                                </td>
                            </tr>
                            <tr>
                                <td class="titleCell">
                                    <asp:Label ID="QUEST_CNTTitle" runat="server" Text='Кол-во вопросов :' />
                                </td>
                                <td>
                                    <bec:TextBoxNumb ID="QUEST_CNTTextBox" runat="server" Enabled="false"></bec:TextBoxNumb>
                                </td>
                            </tr>
                            <tr>
                                <td class="actionButtonsContainer" colspan="2" style="text-align: right">
                                    <asp:Button ID="btDelete" runat="server" Text="Удалить" OnClick="btDelete_Click" />
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
