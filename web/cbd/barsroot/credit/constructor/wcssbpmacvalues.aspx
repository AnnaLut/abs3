<%@ Page Language="C#" AutoEventWireup="true" CodeFile="wcssbpmacvalues.aspx.cs"
    Inherits="credit_constructor_wcssbpmacvalues" Theme="default" MasterPageFile="~/credit/constructor/master.master"
    Title="Значения МАКа {0} ({1}) для субпродукта {2} ({3})" MaintainScrollPositionOnPostback="true"
    Trace="false" %>

<%@ MasterType VirtualPath="~/credit/constructor/master.master" %>
<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="Bars" %>
<%@ Register Src="../usercontrols/TextBoxString.ascx" TagName="TextBoxString" TagPrefix="bec" %>
<%@ Register Src="../usercontrols/TextBoxDate.ascx" TagName="TextBoxDate" TagPrefix="bec" %>
<%@ Register Src="../usercontrols/TextBoxDecimal.ascx" TagName="TextBoxDecimal" TagPrefix="bec" %>
<%@ Register Src="../usercontrols/TextBoxFile.ascx" TagName="TextBoxFile" TagPrefix="bec" %>
<%@ Register Src="../usercontrols/TextBoxNumb.ascx" TagName="TextBoxNumb" TagPrefix="bec" %>
<%@ Register Src="../usercontrols/TextBoxRefer.ascx" TagName="TextBoxRefer" TagPrefix="bec" %>
<%@ Register Src="../usercontrols/DDLList.ascx" TagName="DDLList" TagPrefix="bec" %>
<%@ Register Src="../usercontrols/RBLFlag.ascx" TagName="RBLFlag" TagPrefix="bec" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">
    <div class="dataContainer">
        <asp:Panel ID="pnlBranches" runat="server" GroupingText="Отделения">
            <asp:ObjectDataSource ID="ods" runat="server" SelectMethod="SelectSbpMacBranches"
                TypeName="credit.VWcsSbpMacBranches" DataObjectTypeName="credit.VWcsSbpMacBranchesRecord">
                <SelectParameters>
                    <asp:QueryStringParameter Name="SUBPRODUCT_ID" QueryStringField="subproduct_id" Size="100"
                        Type="String" />
                    <asp:QueryStringParameter Name="MAC_ID" QueryStringField="mac_id" Size="100" Type="String" />
                </SelectParameters>
            </asp:ObjectDataSource>
            <asp:TreeView ID="tv" runat="server" OnSelectedNodeChanged="tv_SelectedNodeChanged">
                <SelectedNodeStyle Font-Bold="True" />
            </asp:TreeView>
        </asp:Panel>
        <asp:Panel ID="pnlDates" runat="server" GroupingText="Даты">
            <table border="0" cellpadding="2" cellspacing="0">
                <tr>
                    <td>
                        <asp:ObjectDataSource ID="odsWcsMacListItems" runat="server" SelectMethod="Select"
                            TypeName="credit.WcsMacListItems">
                            <SelectParameters>
                                <asp:QueryStringParameter Name="MAC_ID" QueryStringField="mac_id" Size="100" Type="String" />
                            </SelectParameters>
                        </asp:ObjectDataSource>
                        <asp:ObjectDataSource ID="odsDates" runat="server" SelectMethod="SelectSbpMacBranchDates"
                            UpdateMethod="Update" DeleteMethod="Delete" TypeName="credit.VWcsSbpMacBranchDates"
                            DataObjectTypeName="credit.VWcsSbpMacBranchDatesRecord">
                            <SelectParameters>
                                <asp:QueryStringParameter Name="SUBPRODUCT_ID" QueryStringField="subproduct_id" Size="100"
                                    Type="String" />
                                <asp:QueryStringParameter Name="MAC_ID" QueryStringField="mac_id" Size="100" Type="String" />
                                <asp:ControlParameter Name="BRANCH" Size="100" Type="String" ControlID="tv" PropertyName="SelectedValue" />
                            </SelectParameters>
                        </asp:ObjectDataSource>
                        <bars:BarsGridViewEx ID="gv" runat="server" AutoGenerateColumns="False" CaptionText=""
                            ClearFilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_delete.png"
                            CloseFilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_close.png"
                            CssClass="barsGridView" DataSourceID="odsDates" DataKeyNames="SUBPRODUCT_ID,MAC_ID,TYPE_ID,BRANCH,APPLY_DATE"
                            DateMask="dd.MM.yyyy" EnableModelValidation="True" ExcelImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.export_excel.png"
                            FilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_open.png"
                            HoverRowCssClass="hoverRow" MetaFilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_open.png"
                            MetaTableName="" RefreshImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.refresh.png"
                            ShowExportExcelButton="True" ShowPageSizeBox="False" ShowFooter="True">
                            <NewRowStyle CssClass="" />
                            <NewRowStyle CssClass="" />
                            <NewRowStyle CssClass="" />
                            <AlternatingRowStyle CssClass="alternateRow" />
                            <Columns>
                                <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" EditImageUrl="/Common/Images/default/16/open.png"
                                    EditText="Редактировать" DeleteImageUrl="/Common/Images/default/16/delete.png"
                                    DeleteText="Удалить" UpdateImageUrl="/Common/Images/default/16/save.png" UpdateText="Сохранить"
                                    CancelImageUrl="/Common/Images/default/16/cancel_1.png" CancelText="Отмена" ButtonType="Image">
                                    <ItemStyle HorizontalAlign="Center" Width="50px" />
                                </asp:CommandField>
                                <asp:BoundField DataField="APPLY_DATE" DataFormatString="{0:d}" HeaderText="Дата"
                                    SortExpression="APPLY_DATE" ReadOnly="true">
                                    <ItemStyle Width="100px" HorizontalAlign="Center" />
                                </asp:BoundField>
                                <asp:TemplateField HeaderText="Значение" SortExpression="VAL">
                                    <ItemTemplate>
                                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("VAL") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <bec:TextBoxString ID="VAL_TEXT" runat="server" IsRequired="True" Value='<%# Bind("VAL_TEXT") %>'
                                            Visible='<%# (String)Eval("TYPE_ID") == "TEXT" %>' />
                                        <bec:TextBoxNumb ID="VAL_NUMB" runat="server" IsRequired="True" Value='<%# Bind("VAL_NUMB") %>'
                                            Visible='<%# (String)Eval("TYPE_ID") == "NUMB" %>' />
                                        <bec:TextBoxDecimal ID="VAL_DECIMAL" runat="server" IsRequired="True" Value='<%# Bind("VAL_DECIMAL") %>'
                                            Visible='<%# (String)Eval("TYPE_ID") == "DECIMAL" %>' />
                                        <bec:TextBoxDate ID="VAL_DATE" runat="server" IsRequired="True" Value='<%# Bind("VAL_DATE") %>'
                                            Visible='<%# (String)Eval("TYPE_ID") == "DATE" %>' />
                                        <bec:DDLList ID="VAL_LIST" runat="server" AppendSelectedValue="True" DataSourceID="odsWcsMacListItems"
                                            DataTextField="TEXT" DataValueField="ORD" Value='<%# Bind("VAL_LIST") %>' Visible='<%# (String)Eval("TYPE_ID") == "LIST" %>'>
                                        </bec:DDLList>
                                        <bec:TextBoxRefer ID="VAL_REFER" runat="server" IsRequired="True" MAC_ID='<%# Bind("MAC_ID") %>'
                                            Value='<%# Bind("VAL_REFER") %>' Visible='<%# (String)Eval("TYPE_ID") == "REFER" %>' />
                                        <bec:TextBoxFile ID="VAL_FILE" runat="server" FileData='<%# Bind("VAL_FILE") %>'
                                            FileName="ico.jpg" Visible='<%# (String)Eval("TYPE_ID") == "FILE" %>' />
                                        <bec:RBLFlag ID="VAL_BOOL" runat="server" DefaultValue="false" IsRequired="true"
                                            Value='<%# Bind("VAL_BOOL") %>' Visible='<%# (String)Eval("TYPE_ID") == "BOOL" %>' />
                                    </EditItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <EditRowStyle CssClass="editRow" />
                            <FooterStyle CssClass="footerRow" />
                            <HeaderStyle CssClass="headerRow" />
                            <PagerStyle CssClass="pagerRow" />
                            <RowStyle CssClass="normalRow" />
                            <SelectedRowStyle CssClass="selectedRow" />
                        </bars:BarsGridViewEx>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Panel ID="pnlNew" runat="server" GroupingText="Новая дата">
                            <table border="0" cellpadding="2" cellspacing="0" width="99%">
                                <col class="titleCell" />
                                <tr>
                                    <td>
                                        <asp:Label ID="APPLY_DATETitle" runat="server" Text="Дата :" />
                                    </td>
                                    <td>
                                        <bec:TextBoxDate ID="APPLY_DATE" runat="server" IsRequired="True" Value='<%# Bind("APPLY_DATE") %>' ValidationGroup="NewDate" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="VALTitle" runat="server" Text="Значение :" />
                                    </td>
                                    <td>
                                        <asp:PlaceHolder ID="ph" runat="server"></asp:PlaceHolder>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right" colspan="2" style="padding-top:10px">
                                        <asp:Button ID="btAdd" runat="server" Text="Добавить" OnClick="btAdd_Click" ValidationGroup="NewDate" />
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                    </td>
                </tr>
            </table>
        </asp:Panel>
    </div>
</asp:Content>
