<%@ Page Title="РНК СК у відділеннях" Language="C#"
    AutoEventWireup="true" CodeFile="branch_rnk.aspx.cs" Inherits="ins_branch_rnk" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajx" %>
<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="Bars" %>
<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI.WebControls" TagPrefix="asp" %>
<%@ Register Src="~/credit/usercontrols/TextBoxRefer.ascx" TagName="TextBoxRefer"
    TagPrefix="Bars" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title title="РНК СК у відділеннях"></title>
    <base target="_self" />
    <link href="/barsroot/ins/ins.css" type="text/css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <ajx:ToolkitScriptManager ID="sm" runat="server">
            <Scripts>
                <asp:ScriptReference Path="/barsroot/credit/JScript/JScript.js?v1" />
            </Scripts>
        </ajx:ToolkitScriptManager>
        <div class="content_container" style="width: 100%; text-align: center">
            <table border="0" cellpadding="3" cellspacing="0" class="data_table">
                <tr>
                    <td>
                        <bars:BarsObjectDataSource ID="ods" runat="server" SelectMethod="SelectPartnerBranchRnk" TypeName="Bars.Ins.VInsPartnerBranchRnk">
                            <selectparameters>
                            <asp:QueryStringParameter Name="PARTNER_ID" Type="Decimal" QueryStringField="partner_id" />
                        </selectparameters>
                        </bars:BarsObjectDataSource>
                        <asp:ListView ID="lv" runat="server" DataKeyNames="PARTNER_ID,BRANCH" DataSourceID="ods" OnItemInserting="lv_ItemInserting"
                            OnItemUpdating="lv_ItemUpdating" OnItemDeleting="lv_ItemDeleting">
                            <LayoutTemplate>
                                <table class="tbl_style1" width="650px">
                                    <thead>
                                        <tr>
                                            <th></th>
                                            <th>
                                                <asp:Label ID="BRANCH" runat="server" Text="Відділення" />
                                            </th>
                                            <th>
                                                <asp:Label ID="RNK" runat="server" Text="Контрагент" />
                                            </th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr runat="server" id="itemPlaceholder">
                                        </tr>
                                    </tbody>
                                    <tfoot id="tblPSFoot" runat="server">
                                        <tr>
                                            <td class="command">
                                                <asp:ImageButton ID="ibAddNew" runat="server" CausesValidation="False" OnClick="ibAddNew_Click"
                                                    ImageUrl="/common/images/default/16/new.png" ToolTip="Додати" />
                                            </td>
                                            <td colspan="2"></td>
                                        </tr>
                                    </tfoot>
                                </table>
                            </LayoutTemplate>
                            <EmptyDataTemplate>
                                <table class="tbl_style1" width="650px">
                                    <thead>
                                        <tr>
                                            <th></th>
                                            <th>
                                                <asp:Label ID="BRANCH" runat="server" Text="Відділення" />
                                            </th>
                                            <th>
                                                <asp:Label ID="RNK" runat="server" Text="Контрагент" />
                                            </th>
                                        </tr>
                                    </thead>
                                    <tfoot id="Tfoot1" runat="server">
                                        <tr>
                                            <td class="command">
                                                <asp:ImageButton ID="ibAddNew" runat="server" CausesValidation="False" OnClick="ibAddNew_Click"
                                                    ImageUrl="/common/images/default/16/new.png" ToolTip="Додати" />
                                            </td>
                                            <td colspan="2"></td>
                                        </tr>
                                    </tfoot>
                                </table>
                            </EmptyDataTemplate>
                            <ItemTemplate>
                                <tr id="tr" runat="server">
                                    <td class="command">
                                        <asp:ImageButton ID="ibEdit" runat="server" CausesValidation="False" CommandName="Edit"
                                            ImageUrl="/common/images/default/16/open.png" ToolTip="Редагувати" />
                                        <asp:ImageButton ID="ibDelete" runat="server" CausesValidation="False" CommandName="Delete"
                                            ImageUrl="/common/images/default/16/delete.png" ToolTip="Видалити" />
                                    </td>
                                    <td>
                                        <asp:Label ID="BRANCH" runat="server" Text='<%# String.Format("{0} - {1}", Eval("BRANCH"), Eval("BRANCH_NAME"))  %>' />
                                    </td>
                                    <td>
                                        <asp:Label ID="RNK" runat="server" Text='<%# String.Format("{0} - {1} ({2})", Eval("RNK"), Eval("NAME_FULL"), Eval("INN"))  %>' />
                                    </td>
                                </tr>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <tr id="tr1" runat="server" class="edit">
                                    <td class="command">
                                        <asp:ImageButton ID="ibUpdate" runat="server" CausesValidation="True" ValidationGroup="Update"
                                            CommandName="Update" ImageUrl="/common/images/default/16/save.png" ToolTip="Зберегти" />
                                        <asp:ImageButton ID="ibCancel" runat="server" CausesValidation="False" CommandName="Cancel"
                                            ImageUrl="/common/images/default/16/cancel.png" ToolTip="Відміна" />
                                    </td>
                                    <td>
                                        <asp:Label ID="BRANCH" runat="server" Text='<%# String.Format("{0} - {1}", Eval("BRANCH"), Eval("BRANCH_NAME"))  %>' />
                                    </td>
                                    <td>
                                        <bars:TextBoxRefer ID="RNK" runat="server" TAB_NAME="V_INS_CORPS" KEY_FIELD="RNK"
                                            SEMANTIC_FIELD="NAME_FULL" SHOW_FIELDS="NAME_SHORT,INN,TEL,MFO,NLS,ADR" IsRequired="true"
                                            Width="200" Value='<%# Bind("RNK") %>' ValidationGroup="Update" />
                                    </td>
                                </tr>
                            </EditItemTemplate>
                            <InsertItemTemplate>
                                <tr id="tr2" runat="server" class="new">
                                    <td class="command">
                                        <asp:ImageButton ID="ibInsert" runat="server" CausesValidation="True" ValidationGroup="Insert"
                                            CommandName="Insert" ImageUrl="/common/images/default/16/save.png" Text="Додати" TabIndex="102" />
                                        <asp:ImageButton ID="ibCancel" runat="server" CausesValidation="False" OnClick="ibCancel_Click"
                                            ImageUrl="/common/images/default/16/cancel.png" ToolTip="Відміна" TabIndex="103" />
                                    </td>
                                    <td>
                                        <bars:TextBoxRefer ID="BRANCH" runat="server" TAB_NAME="BRANCH" KEY_FIELD="BRANCH"
                                            SEMANTIC_FIELD="NAME" WHERE_CLAUSE="where date_closed is null" ORDERBY_CLAUSE="order by branch" IsRequired="true"
                                            Width="200" Value='<%# Bind("RNK") %>' ValidationGroup="Insert" TabIndex="101" />
                                    </td>
                                    <td>
                                        <bars:TextBoxRefer ID="RNK" runat="server" TAB_NAME="V_INS_CORPS" KEY_FIELD="RNK"
                                            SEMANTIC_FIELD="NAME_FULL" SHOW_FIELDS="NAME_SHORT,INN,TEL,MFO,NLS,ADR" IsRequired="true"
                                            Width="200" Value='<%# Bind("BRANCH") %>' ValidationGroup="Insert" TabIndex="100" />
                                    </td>
                                </tr>
                            </InsertItemTemplate>
                        </asp:ListView>
                    </td>
                </tr>
                <tr>
                    <td align="center">
                        <asp:LinkButton ID="lbClose" runat="server" Text="Закрити" OnClientClick="window.returnValue = true; window.close(); return false; " CausesValidation="false"
                            TabIndex="1000"></asp:LinkButton>
                    </td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
