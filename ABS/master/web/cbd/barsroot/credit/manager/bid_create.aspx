<%@ Page Language="C#" MasterPageFile="~/credit/manager/master.master" AutoEventWireup="true"
    CodeFile="bid_create.aspx.cs" Inherits="credit_manager_bid_create" Title="Выбор субпродукта"
    Theme="default" Trace="false" meta:resourcekey="PageResource1" %>

<%@ MasterType VirtualPath="~/credit/manager/master.master" %>
<%@ Register Src="../usercontrols/TextBoxString.ascx" TagName="TextBoxString" TagPrefix="bec" %>
<%@ Register Src="../usercontrols/ByteImage.ascx" TagName="ByteImage" TagPrefix="bec" %>
<%@ Register Src="../usercontrols/DDLList.ascx" TagName="DDLList" TagPrefix="bec" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">
    <div class="dataContainer">
        <asp:ObjectDataSource ID="odsVWcsProducts" runat="server" SelectMethod="SelectProducts"
            TypeName="credit.VWcsProducts"></asp:ObjectDataSource>
        <table border="0" cellpadding="3" cellspacing="0">
            <tr>
                <td class="titleCell">
                    <asp:Label ID="PRODUCT_IDTitle" runat="server" Text='Продукт :' 
                        meta:resourcekey="PRODUCT_IDTitleResource1" />
                </td>
                <td>
                    <bec:DDLList ID="PRODUCT_ID" runat="server" DataSourceID="odsVWcsProducts" DataValueField="PRODUCT_ID"
                        DataTextField="PRODUCT_NAME" IsRequired="true" Width="600px">
                    </bec:DDLList>
                </td>
                <td>
                    <asp:Button ID="btSearch" runat="server" Text="Застосувати" SkinID="bSearch" 
                        OnClick="btSearch_Click" meta:resourcekey="btSearchResource1" />
                </td>
            </tr>
        </table>
    </div>
    <div class="dataContainer">
        <asp:ObjectDataSource ID="ods" runat="server" SelectMethod="SelectMgrSbpDetails"
            TypeName="credit.VWcsMgrSbpDetails">
            <SelectParameters>
                <asp:ControlParameter Name="PRODUCT_ID" ControlID="PRODUCT_ID" PropertyName="SelectedValue"
                    Size="100" Type="String" />
            </SelectParameters>
        </asp:ObjectDataSource>
        <asp:DataList ID="dl" runat="server" DataSourceID="ods" 
            OnItemCommand="dl_ItemCommand" meta:resourcekey="dlResource1">
            <ItemTemplate>
                <table border="0" cellpadding="3" cellspacing="0" class="subproductsTable">
                    <tr>
                        <td class="headerCell" colspan="3">
                            <table border="0" cellpadding="3" cellspacing="0">
                                <tr>
                                    <td style="text-align: right">
                                        <asp:ImageButton ID="ibSelect" runat="server" CausesValidation="False" ImageUrl="/Common/Images/default/16/ok.png"
                                            ToolTip="Выбрать субпродукт" OnClientClick=<%# "return confirm('Выбрать субпродукт \"" + Eval("SUBPRODUCT_NAME") + "\"')" %>
                                            CommandArgument='<%# Eval("SUBPRODUCT_ID") %>' CommandName="Select" 
                                            meta:resourcekey="ibSelectResource1" />
                                    </td>
                                    <td>
                                        <asp:Label ID="SUBPRODUCT_NAME" runat="server" 
                                            Text='<%# Eval("SUBPRODUCT_NAME") %>' 
                                            meta:resourcekey="SUBPRODUCT_NAMEResource1" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td rowspan="10" class="imageCell">
                            <asp:Image ID="imgICOt" runat="server" Width="130" Height="130" ImageUrl='<%# Eval("ICO") %>' />
                                
                        </td>
                        <td class="textCell">
                            <asp:Label ID="SUMTitle" runat="server" Text="Допустимая сумма кредита :" 
                                meta:resourcekey="SUMTitleResource1" />
                        </td>
                        <td class="valueCell">
                            <asp:Label ID="SUM" runat="server" 
                                Text='<%# "від " + Eval("SUM_MIN", "{0:### ### ### ##0.00}") + " до " + Eval("SUM_MAX", "{0:### ### ### ##0.00}") %>' 
                                meta:resourcekey="SUMResource1" />
                        </td>
                    </tr>
                    <tr>
                        <td class="textCell">
                            <asp:Label ID="SUM_INITIALTitle" runat="server" 
                                Text="Процент первичного взноса :" 
                                meta:resourcekey="SUM_INITIALTitleResource1" />
                        </td>
                        <td class="valueCell">
                            <asp:Label ID="SUM_INITIAL" runat="server" 
                                Text='<%# "від " + Eval("SUM_INITIAL_MIN", "{0:### ### ### ##0.00}") + " до " + Eval("SUM_INITIAL_MAX", "{0:### ### ### ##0.00}") %>' 
                                meta:resourcekey="SUM_INITIALResource1" />
                        </td>
                    </tr>
                    <tr>
                        <td class="textCell">
                            <asp:Label ID="TERMTitle" runat="server" 
                                Text="Допустимый срок кредита (мес.) :" meta:resourcekey="TERMTitleResource1" />
                        </td>
                        <td class="valueCell">
                            <asp:Label ID="TERM" runat="server" 
                                Text='<%# "від " + Eval("TERM_MIN") + " до " + Eval("TERM_MAX") + " місяців" %>' 
                                meta:resourcekey="TERMResource1" />
                        </td>
                    </tr>
                    <tr>
                        <td class="textCell">
                            <asp:Label ID="CURRENCYTitle" runat="server" Text="Валюта :" 
                                meta:resourcekey="CURRENCYTitleResource1" />
                        </td>
                        <td class="valueCell">
                            <asp:Label ID="CURRENCY" runat="server" Text='<%# Eval("CURRENCY") %>' 
                                meta:resourcekey="CURRENCYResource1" />
                        </td>
                    </tr>
                    <tr>
                        <td class="textCell">
                            <asp:Label ID="INTEREST_RATETitle" runat="server" Text="Годовая % ставка :" 
                                meta:resourcekey="INTEREST_RATETitleResource1" />
                        </td>
                        <td class="valueCell">
                            <asp:Label ID="INTEREST_RATE" runat="server" 
                                Text='<%# "від " + Eval("INTEREST_RATE_MIN", "{0:##0.00}") + " до " + Eval("INTEREST_RATE_MAX", "{0:##0.00}") + "% у рік" %>' 
                                meta:resourcekey="INTEREST_RATEResource1" />
                        </td>
                    </tr>
                    <tr>
                        <td class="textCell">
                            <asp:Label ID="GARANTEESTitle" runat="server" Text="Обеспечение :" 
                                meta:resourcekey="GARANTEESTitleResource1" />
                        </td>
                        <td class="valueCell">
                            <asp:Label ID="GARANTEES" runat="server" Text='<%# Eval("GARANTEES") %>' 
                                meta:resourcekey="GARANTEESResource1" />
                        </td>
                    </tr>
                    <tr>
                        <td class="textCell2" colspan="2">
                            <asp:Label ID="DESCRIPTIONTitle" runat="server" Text="Описание" 
                                meta:resourcekey="DESCRIPTIONTitleResource1" />
                        </td>
                    </tr>
                    <tr>
                        <td class="valueCell" colspan="2">
                            <asp:Label ID="DESCRIPTION" runat="server" Text='<%# Eval("DESCRIPTION") %>' 
                                meta:resourcekey="DESCRIPTIONResource1" />
                        </td>
                    </tr>
                    </table>
            </ItemTemplate>
        </asp:DataList>
    </div>
</asp:Content>
