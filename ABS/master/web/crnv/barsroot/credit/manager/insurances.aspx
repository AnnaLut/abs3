<%@ Page Language="C#" AutoEventWireup="true" CodeFile="insurances.aspx.cs" Inherits="credit_constructor_insurances"
    Theme="default" MasterPageFile="~/credit/manager/master.master" Title="Страховки клиента по заявке №{0}"
    Trace="false" meta:resourcekey="PageResource1" %>

<%@ MasterType VirtualPath="~/credit/manager/master.master" %>
<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="Bars" %>
<%@ Register Src="../usercontrols/TextBoxString.ascx" TagName="TextBoxString" TagPrefix="bec" %>
<%@ Register Src="../usercontrols/DDLList.ascx" TagName="DDLList" TagPrefix="bec" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">
    <table class="dataTable">
        <tr>
            <td id="tdContainer" runat="server">
                <div class="dataContainer">
                    <asp:ObjectDataSource ID="ods" runat="server" SelectMethod="SelectBidInsurances"
                        TypeName="credit.VWcsBidInsurances">
                        <SelectParameters>
                            <asp:QueryStringParameter Name="BID_ID" QueryStringField="bid_id" Type="Decimal" />
                        </SelectParameters>
                    </asp:ObjectDataSource>
                    <Bars:BarsGridViewEx ID="gv" runat="server" AutoGenerateColumns="False" CaptionText=""
                        ClearFilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_delete.png"
                        CssClass="barsGridView" DataSourceID="ods" DateMask="dd.MM.yyyy" ExcelImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.export_excel.png"
                        FilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_open.png"
                        MetaFilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_open.png"
                        MetaTableName="" RefreshImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.refresh.png"
                        ShowPageSizeBox="False" AutoSelectFirstRow="True" JavascriptSelectionType="ServerSelect"
                        CloseFilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_close.png"
                        EnableModelValidation="True" HoverRowCssClass="hoverRow" ShowExportExcelButton="True"
                        DataKeyNames="INSURANCE_ID,INSURANCE_NUM" meta:resourcekey="gvResource1">
                        <FooterStyle CssClass="footerRow"></FooterStyle>
                        <HeaderStyle CssClass="headerRow"></HeaderStyle>
                        <EditRowStyle CssClass="editRow"></EditRowStyle>
                        <PagerStyle CssClass="pagerRow"></PagerStyle>
                        <NewRowStyle CssClass=""></NewRowStyle>
                        <SelectedRowStyle CssClass="selectedRow"></SelectedRowStyle>
                        <AlternatingRowStyle CssClass="alternateRow"></AlternatingRowStyle>
                        <Columns>
                            <asp:BoundField DataField="INSURANCE_NAME" HeaderText="Тип" 
                                SortExpression="INSURANCE_NAME" meta:resourcekey="BoundFieldResource1">
                            </asp:BoundField>
                            <asp:BoundField DataField="INSURANCE_NUM" HeaderText="№" 
                                SortExpression="INSURANCE_NUM" meta:resourcekey="BoundFieldResource2" />
                            <asp:BoundField DataField="STATUS_NAME" HeaderText="Статус" 
                                SortExpression="STATUS_NAME" meta:resourcekey="BoundFieldResource3"></asp:BoundField>
                            <asp:BoundField DataField="PARTNER_NAME" HeaderText="СК" 
                                SortExpression="PARTNER_NAME" meta:resourcekey="BoundFieldResource4" />
                            <asp:BoundField DataField="SER" HeaderText="Сер. дог." SortExpression="SER" 
                                meta:resourcekey="BoundFieldResource5" />
                            <asp:BoundField DataField="NUM" HeaderText="№ дог." SortExpression="NUM" 
                                meta:resourcekey="BoundFieldResource6" />
                            <asp:BoundField DataField="DATE_ON" DataFormatString="{0:d}" HeaderText="Дата нач."
                                SortExpression="DATE_ON" meta:resourcekey="BoundFieldResource7">
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="DATE_OFF" DataFormatString="{0:d}" HeaderText="Дата окон."
                                SortExpression="DATE_OFF" meta:resourcekey="BoundFieldResource8">
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="SUM" DataFormatString="{0:### ### ### ##0.00}" HeaderText="Страховая сумма"
                                SortExpression="SUM" meta:resourcekey="BoundFieldResource9">
                                <ItemStyle HorizontalAlign="Right" />
                            </asp:BoundField>
                        </Columns>
                        <RowStyle CssClass="normalRow"></RowStyle>
                    </Bars:BarsGridViewEx>
                </div>
                <div class="formViewContainer">
                    <asp:ObjectDataSource ID="odsFV" runat="server" DataObjectTypeName="credit.VWcsBidInsurancesRecord"
                        DeleteMethod="Delete" InsertMethod="Insert" SelectMethod="SelectBidInsurance"
                        TypeName="credit.VWcsBidInsurances">
                        <SelectParameters>
                            <asp:QueryStringParameter Name="BID_ID" QueryStringField="bid_id" Type="Decimal" />
                            <asp:ControlParameter ControlID="gv" Name="INSURANCE_ID" PropertyName="SelectedDataKey[0]"
                                Size="100" Type="String" />
                            <asp:ControlParameter ControlID="gv" Name="INSURANCE_NUM" PropertyName="SelectedDataKey[1]"
                                Type="Decimal" />
                        </SelectParameters>
                        <DeleteParameters>
                            <asp:QueryStringParameter Name="BID_ID" QueryStringField="bid_id" Type="Decimal" />
                            <asp:ControlParameter ControlID="gv" Name="INSURANCE_ID" PropertyName="SelectedDataKey[0]"
                                Size="100" Type="String" />
                            <asp:ControlParameter ControlID="gv" Name="INSURANCE_NUM" PropertyName="SelectedDataKey[1]"
                                Type="Decimal" />
                        </DeleteParameters>
                    </asp:ObjectDataSource>
                    <Bars:BarsSqlDataSourceEx ID="sds" runat="server" ProviderName="barsroot.core" 
                        SelectCommand="select i.* from wcs_insurances i, wcs_subproduct_insurances si, wcs_bids b where i.id = si.insurance_id and si.subproduct_id = b.subproduct_id and b.id = :BID_ID" 
                        AllowPaging="False" FilterStatement="" PageButtonCount="10" 
                        PagerMode="NextPrevious" PageSize="10" PreliminaryStatement="" 
                        SortExpression="" SystemChangeNumber=""  WhereStatement="">
                        <SelectParameters>
                            <asp:QueryStringParameter Name="BID_ID" QueryStringField="bid_id" Type="Decimal" />
                        </SelectParameters>
                    </Bars:BarsSqlDataSourceEx>
                    <asp:FormView ID="fv" runat="server" DataKeyNames="BID_ID,INSURANCE_ID,INSURANCE_NUM"
                        DataSourceID="odsFV" OnItemDeleted="fv_ItemDeleted" OnItemInserted="fv_ItemInserted"
                        OnItemCommand="fv_ItemCommand" CssClass="formView" EnableModelValidation="True"
                        OnItemInserting="fv_ItemInserting" meta:resourcekey="fvResource1">
                        <ItemTemplate>
                            <table class="contentTable">
                                <col class="titleCell" />
                                <tr>
                                    <td>
                                        <asp:Label ID="INSURANCE_NAMETitle" runat="server" Text='Тип :' 
                                            meta:resourcekey="INSURANCE_NAMETitleResource1" />
                                    </td>
                                    <td>
                                        <asp:Label ID="INSURANCE_NAME" runat="server" 
                                            Text='<%# Bind("INSURANCE_NAME") %>' 
                                            meta:resourcekey="INSURANCE_NAMEResource1" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="INSURANCE_NUMTitle" runat="server" Text='№ :' 
                                            meta:resourcekey="INSURANCE_NUMTitleResource1" />
                                    </td>
                                    <td>
                                        <asp:Label ID="INSURANCE_NUM" runat="server" 
                                            Text='<%# Bind("INSURANCE_NUM") %>' meta:resourcekey="INSURANCE_NUMResource1" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="STATUS_NAMETitle" runat="server" Text='Статус :' 
                                            meta:resourcekey="STATUS_NAMETitleResource1" />
                                    </td>
                                    <td>
                                        <asp:Label ID="STATUS_NAME" runat="server" Text='<%# Bind("STATUS_NAME") %>' 
                                            meta:resourcekey="STATUS_NAMEResource1" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="actionButtonsContainer" colspan="2">
                                        <asp:LinkButton ID="lbtSurvey" runat="server" CommandName="Survey" 
                                            ToolTip="Анкета" meta:resourcekey="lbtSurveyResource1">Анкета</asp:LinkButton>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="actionButtonsContainer" colspan="2">
                                        <asp:ImageButton ID="ibDelete" runat="server" CausesValidation="False" CommandName="Delete"
                                            SkinID="ibDelete" OnClientClick="return confirm('Удалить строку?');" 
                                            meta:resourcekey="ibDeleteResource1" />
                                        <asp:ImageButton ID="ibNew" runat="server" CausesValidation="False" CommandName="New"
                                            ImageUrl="/Common/Images/default/16/new.png" ToolTip="Добавить строку" 
                                            meta:resourcekey="ibNewResource2" />
                                    </td>
                                </tr>
                            </table>
                        </ItemTemplate>
                        <InsertItemTemplate>
                            <table class="contentTable">
                                <col class="titleCell" />
                                <tr>
                                    <td>
                                        <asp:Label ID="INSURANCE_IDTitle" runat="server" Text='Тип :' 
                                            meta:resourcekey="INSURANCE_IDTitleResource1" />
                                    </td>
                                    <td>
                                        <bec:DDLList ID="INSURANCE_ID" runat="server" DataSourceID="sds" DataValueField="ID"
                                            DataTextField="NAME" IsRequired="true" SelectedValue='<%# Bind("INSURANCE_ID") %>' >
                                        </bec:DDLList>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="actionButtonsContainer" colspan="2">
                                        <asp:ImageButton ID="ibUpdate" runat="server" CommandName="Insert" ImageUrl="/Common/Images/default/16/save.png"
                                            ToolTip="Добавить" meta:resourcekey="ibUpdateResource1" />
                                        <asp:ImageButton ID="ibCancel" runat="server" CausesValidation="False" CommandName="Cancel"
                                            SkinID="ibCancel" meta:resourcekey="ibCancelResource1" />
                                    </td>
                                </tr>
                            </table>
                        </InsertItemTemplate>
                        <EmptyDataTemplate>
                            <table class="contentTable">
                                <tr>
                                    <td class="actionButtonsContainer">
                                        <asp:ImageButton ID="ibNew" runat="server" CausesValidation="False" CommandName="New"
                                            ImageUrl="/Common/Images/default/16/new.png" ToolTip="Добавить строку" 
                                            meta:resourcekey="ibNewResource1" />
                                    </td>
                                </tr>
                            </table>
                        </EmptyDataTemplate>
                    </asp:FormView>
                </div>
            </td>
        </tr>
        <tr>
            <td class="nextButtonContainer" colspan="2">
                <asp:Button ID="bNext" SkinID="bNext" runat="server" OnClick="bNext_Click" 
                    meta:resourcekey="bNextResource1" />
            </td>
        </tr>
    </table>
</asp:Content>
