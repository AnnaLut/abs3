<%@ Page Language="C#" AutoEventWireup="true" CodeFile="wcssubproductgarantees.aspx.cs"
    Inherits="credit_constructor_wcssubproductgarantees" Theme="default" MasterPageFile="~/credit/constructor/master.master"
    Title="Обеспечение" %>

<%@ MasterType VirtualPath="~/credit/constructor/master.master" %>
<%@ Register Src="../usercontrols/TextBoxString.ascx" TagName="TextBoxString" TagPrefix="bec" %>
<%@ Register Src="../usercontrols/DDLList.ascx" TagName="DDLList" TagPrefix="bec" %>
<%@ Register Src="../usercontrols/RBLFlag.ascx" TagName="RBLFlag" TagPrefix="bec" %>
<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="Bars" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">
    <Bars:BarsObjectDataSource ID="ods" runat="server" SelectMethod="SelectSubproductGarantees"
        TypeName="credit.VWcsSubproductGarantees" DataObjectTypeName="credit.VWcsSubproductGaranteesRecord">
        <SelectParameters>
            <asp:SessionParameter Name="SUBPRODUCT_ID" SessionField="WCS_SUBPRODUCT_ID" Type="String"
                Direction="Input" />
        </SelectParameters>
    </Bars:BarsObjectDataSource>
    <Bars:BarsObjectDataSource ID="odsVWcsGarantees" runat="server" SelectMethod="Select"
        TypeName="credit.VWcsGarantees" DataObjectTypeName="credit.VWcsGaranteesRecord">
    </Bars:BarsObjectDataSource>
    <div class="dataContainer">
        <table border="0" cellpadding="3" cellspacing="0">
            <tr>
                <td>
                    <asp:ListBox ID="lb" runat="server" DataSourceID="ods" DataTextField="GARANTEE_NAME"
                        DataValueField="GARANTEE_ID" Height="200px" Width="300px" OnDataBound="lb_DataBound"
                        AutoPostBack="True" OnSelectedIndexChanged="lb_SelectedIndexChanged"></asp:ListBox>
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
                    <asp:Panel ID="pnlParams" runat="server" GroupingText="Тип обеспечения" Height="200px"
                        Width="450px" HorizontalAlign="Left">
                        <table border="0" cellpadding="3" cellspacing="0" class="contentTable">
                            <tr>
                                <td class="titleCell">
                                    <asp:Label ID="GARANTEE_IDTitle" runat="server" Text='Наименование :' />
                                </td>
                                <td>
                                    <bec:DDLList ID="GARANTEE_ID" runat="server" DataSourceID="odsVWcsGarantees" DataValueField="GARANTEE_ID"
                                        DataTextField="GARANTEE_NAME" SelectedValue='<%# Bind("GARANTEE_ID") %>' >
                                    </bec:DDLList>
                                </td>
                            </tr>
                            <tr>
                                <td class="titleCell">
                                    <asp:Label ID="IS_REQUIREDTitle" runat="server" Text='Обязательная :' />
                                </td>
                                <td>
                                    <bec:RBLFlag ID="IS_REQUIRED" IsRequired="true" DefaultValue="false" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td class="actionButtonsContainer" colspan="2" style="text-align: right">
                                    <asp:Button ID="btSave" runat="server" Text="Сохранить" OnClick="btSave_Click" />
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
