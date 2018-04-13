<%@ Page Language="C#" AutoEventWireup="true" CodeFile="wcssubproductsurvey.aspx.cs"
    Inherits="credit_constructor_wcssubproductsurvey" Theme="default" MasterPageFile="~/credit/constructor/master.master"
    Title="Анкета клиента" %>

<%@ MasterType VirtualPath="~/credit/constructor/master.master" %>
<%@ Register Src="../usercontrols/TextBoxString.ascx" TagName="TextBoxString" TagPrefix="bec" %>
<%@ Register Src="../usercontrols/TextBoxNumb.ascx" TagName="TextBoxNumb" TagPrefix="bec" %>
<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="Bars" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">
    <Bars:BarsSqlDataSourceEx ID="sds" runat="server" SelectCommand="select * from v_wcs_surveys s where not exists (select * from wcs_subproduct_survey ss where ss.subproduct_id = :SUBPRODUCT_ID and ss.survey_id = s.survey_id)"
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
                    <asp:ListBox ID="lb" runat="server" DataSourceID="sds" DataTextField="SURVEY_NAME"
                        DataValueField="SURVEY_ID" Height="200px" Width="300px" OnDataBound="lb_DataBound">
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
                    <asp:Panel ID="pnlParams" runat="server" GroupingText="Текущая анкета клиента" Height="200px"
                        Width="450px" HorizontalAlign="Left">
                        <table border="0" cellpadding="3" cellspacing="0" class="contentTable">
                            <tr>
                                <td class="titleCell">
                                    <asp:Label ID="SURVEY_IDTitle" runat="server" Text='Идентификатор :' />
                                </td>
                                <td>
                                    <bec:TextBoxString ID="SURVEY_ID" runat="server" Enabled="false"></bec:TextBoxString>
                                </td>
                            </tr>
                            <tr>
                                <td class="titleCell">
                                    <asp:Label ID="SURVEY_NAMETitle" runat="server" Text='Наименование :' />
                                </td>
                                <td>
                                    <bec:TextBoxString ID="SURVEY_NAME" runat="server" Width="300px" Enabled="false">
                                    </bec:TextBoxString>
                                </td>
                            </tr>
                            <tr>
                                <td class="titleCell">
                                    <asp:Label ID="GRP_CNTTitle" runat="server" Text='Кол-во груп :' />
                                </td>
                                <td>
                                    <bec:TextBoxNumb ID="GRP_CNT" runat="server" Enabled="false"></bec:TextBoxNumb>
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
