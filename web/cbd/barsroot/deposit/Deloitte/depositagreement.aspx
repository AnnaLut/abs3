<%@ Page Language="c#" CodeFile="DepositAgreement.aspx.cs" AutoEventWireup="true" Inherits="DepositAgreement2" %>

<%@ Register TagPrefix="ajax" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit" %>
<%@ Register Src="~/UserControls/EADoc.ascx" TagName="EADoc" TagPrefix="uc" %>
<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI.WebControls" TagPrefix="asp" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Депозитний модуль: Формування додаткових угод</title>
    <link href="/barsroot/deposit/style/dpt.css" type="text/css" rel="stylesheet" />
    <script type="text/javascript" language="javascript" src="/Common/Script/Localization.js"></script>
    <script type="text/javascript" language="javascript" src="/barsroot/deposit/js/js.js"></script>
    <script type="text/javascript" language="javascript" src="/barsroot/deposit/js/ck.js"></script>
    <style type="text/css">
            .tbl .td_caption {
                text-align: center;
                padding-bottom: 10px;
            }

            .tbl .td_title {
                width: 250px;
            }

            .tbl .td_separator {
                padding-top: 10px;
                padding-bottom: 10px;
                vertical-align: central;
                text-align: center;
            }

                .tbl .td_separator hr {
                    color: #B1B1B1;
                    height: 1px;
                    width: 100%;
                }
        /* Таблица */
        .tbl_style1 {
            font-family: Arial;
            font-size: 10pt;
            width: 100%;
        }

            .tbl_style1 th {
                text-align: center;
                font-weight: bold;
                background-color: grey;
                border: 1px solid grey;
                padding: 5px;
            }

            .tbl_style1 .caption {
                background-color: white;
                font-style: italic;
                font-weight: bold;
                text-align: left;
                border-left: 1px solid grey;
                border-right: 1px solid grey;
                border-bottom: 1px solid grey;
                padding: 10px;
            }

            .tbl_style1 td {
                border-right: 1px solid grey;
                border-bottom: 1px solid grey;
                padding: 3px;
            }

            .tbl_style1 tfoot td {
            }

            .tbl_style1 td.command_first {
                border-left: 1px solid grey;
                border-right: 1px solid grey;
                border-bottom: 1px solid grey;
                text-align: center;
                width: 40px;
            }

            .tbl_style1 td.command {
                border-right: 1px solid grey;
                border-bottom: 1px solid grey;
                text-align: center;
                width: 40px;
            }

            .tbl_style1 tbody tr.edit {
                color: #039;
                border: 1px dashed #69c;
                background-image: url(/common/images/skin/pattern.png);
                background-repeat: repeat;
            }

            .tbl_style1 tbody tr.new {
                color: #039;
                border: 1px dashed #69c;
                background-image: url(/common/images/skin/pattern.png);
                background-repeat: repeat;
            }
    </style>
</head>
<body>
    <form id="Form1" method="post" runat="server">
        <ajax:ToolkitScriptManager ID="sm" runat="server" EnablePageMethods="true">
        </ajax:ToolkitScriptManager>
        <table border="0" class="tbl">
            <tr>
                <td style="text-align: center">
                    <table border="0">
                        <tr>
                            <td>
                                <asp:Label ID="lbTitle" runat="server" CssClass="InfoLabel" Text="Додаткові угоди, дії, шаблони по депозитному договору №"></asp:Label></td>
                            <td>
                                <asp:TextBox ID="textDptNum" runat="server" Enabled="false" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td class="td_separator">
                    <asp:Label ID="lbNewDopAgr" CssClass="InfoLabel" runat="server">Нові:</asp:Label>
                </td>
            </tr>
            <tr>
                <td>
                    <table class="tbl_style1" border="0" cellpadding="0" cellspacing="0">
                        <asp:SqlDataSource ID="sdsAA1" runat="server" ProviderName="barsroot.core"></asp:SqlDataSource>
                        <asp:ListView ID="lvAA1" runat="server" DataSourceID="sdsAA1" DataKeyNames="TYPE_ID,TYPE_NAME" OnItemCommand="lvAA_ItemCommand">
                            <LayoutTemplate>
                                <thead>
                                    <tr>
                                        <th>&nbsp;</th>
                                        <th>
                                            <asp:Label ID="ID" runat="server" Text="Флаг" />
                                        </th>
                                        <th>
                                            <asp:Label ID="NAME" runat="server" Text="Найменування" />
                                        </th>
                                        <th>
                                            <asp:Label ID="DESCRIPTION" runat="server" Text="Опис" />
                                        </th>
                                    </tr>
                                    <tr>
                                        <th class="caption" colspan="4">
                                            <asp:Label ID="Caption" runat="server" Text="Додаткові угоди" />
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr runat="server" id="itemPlaceholder">
                                    </tr>
                                </tbody>
                            </LayoutTemplate>
                            <ItemTemplate>
                                <tr id="tr" runat="server">
                                    <td class="command_first">
                                        <asp:LinkButton ID="lbCreate" runat="server" CausesValidation="False" CommandName="Create" 
                                        Text="Створити" Enabled='<%# CommandEnabled() %>' />
                                    </td>
                                    <td style="text-align: center">
                                        <asp:Label ID="ID" runat="server" Text='<%# Eval("TYPE_ID") %>'></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="NAME" runat="server" Text='<%# Eval("TYPE_NAME") %>'></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="DESCRIPTION" runat="server" Text='<%# Eval("TYPE_DESCRIPTION") %>'></asp:Label>
                                    </td>
                                </tr>
                            </ItemTemplate>
                        </asp:ListView>
                        <asp:SqlDataSource ID="sdsAA2" runat="server" ProviderName="barsroot.core"></asp:SqlDataSource>
                        <asp:ListView ID="lvAA2" runat="server" DataSourceID="sdsAA2" DataKeyNames="TYPE_ID,TYPE_NAME" OnItemCommand="lvAA_ItemCommand">
                            <LayoutTemplate>
                                <thead>
                                    <tr>
                                        <th class="caption" colspan="4">
                                            <asp:Label ID="Caption" runat="server" Text="Дії" />
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr runat="server" id="itemPlaceholder">
                                    </tr>
                                </tbody>
                            </LayoutTemplate>
                            <ItemTemplate>
                                <tr id="tr" runat="server">
                                    <td class="command_first">
                                        <asp:LinkButton ID="lbCreate" runat="server" CausesValidation="False" CommandName="Create"
                                             Text="Виконати" Enabled='<%# CommandEnabled() %>' />
                                    </td>
                                    <td style="text-align: center">
                                        <asp:Label ID="ID" runat="server" Text='<%# Eval("TYPE_ID") %>'></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="NAME" runat="server" Text='<%# Eval("TYPE_NAME") %>'></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="DESCRIPTION" runat="server" Text='<%# Eval("TYPE_DESCRIPTION") %>'></asp:Label>
                                    </td>
                                </tr>
                            </ItemTemplate>
                        </asp:ListView>
                        <asp:SqlDataSource ID="sdsAA3" runat="server" ProviderName="barsroot.core"></asp:SqlDataSource>
                        <asp:ListView ID="lvAA3" runat="server" DataSourceID="sdsAA3" DataKeyNames="TYPE_ID,TYPE_NAME" OnItemCommand="lvAA_ItemCommand">
                            <LayoutTemplate>
                                <thead>
                                    <tr>
                                        <th class="caption" colspan="4">
                                            <asp:Label ID="Caption" runat="server" Text="Шаблони" />
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr runat="server" id="itemPlaceholder">
                                    </tr>
                                </tbody>
                            </LayoutTemplate>
                            <ItemTemplate>
                                <tr id="tr" runat="server">
                                    <td class="command_first">
                                        <asp:LinkButton ID="lbCreate" runat="server" CausesValidation="False" CommandName="Create"
                                            Text="Створити" Enabled='<%# CommandEnabled() %>' />
                                    </td>
                                    <td style="text-align: center">
                                        <asp:Label ID="ID" runat="server" Text='<%# Eval("TYPE_ID") %>'></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="NAME" runat="server" Text='<%# Eval("TYPE_NAME") %>'></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="DESCRIPTION" runat="server" Text='<%# Eval("TYPE_DESCRIPTION") %>'></asp:Label>
                                    </td>
                                </tr>
                            </ItemTemplate>
                        </asp:ListView>
                    </table>
                </td>
            </tr>
            <tr>
                <td class="td_separator">
                    <asp:Label ID="lbCurDopAgr" CssClass="InfoLabel" runat="server">Діючі:</asp:Label>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:SqlDataSource ID="sdsCA" runat="server" ProviderName="barsroot.core"></asp:SqlDataSource>
                    <asp:ListView ID="lvCA" runat="server" DataSourceID="sdsCA" DataKeyNames="AGR_UID,AGR_ID,ADDS,TEMPLATE, TEMPLATE_ID, EASTRUCTID, DPT_ID, RNK " OnItemCommand="lvCA_ItemCommand">
                        <LayoutTemplate>
                            <table class="tbl_style1" border="0" cellpadding="0" cellspacing="0">
                                <thead>
                                    <tr>
                                        <th>&nbsp;</th>
                                        <th>
                                            <asp:Label ID="ADDS" runat="server" Text="№" />
                                        </th>
                                        <th>
                                            <asp:Label ID="VERSION" runat="server" Text="Версія" />
                                        </th>
                                        <th>
                                            <asp:Label ID="AGR_NAME" runat="server" Text="Назва" />
                                        </th>
                                        <th>
                                            <asp:Label ID="NMK" runat="server" Text="3-тя особа" />
                                        </th>
                                        <th>
                                            <asp:Label ID="COMM" runat="server" Text="Статус" />
                                        </th>
                                         <th>
                                            <asp:Label ID="PRINT" runat="server" Text="Повторний друк" />
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr runat="server" id="itemPlaceholder">
                                    </tr>
                                </tbody>
                            </table>
                        </LayoutTemplate>
                        <ItemTemplate>
                            <tr id="tr" runat="server">
                                <td class="command">
                                    <asp:LinkButton ID="lbStorno" runat="server" OnClientClick="if (!confirm('Сторнувати?')) return false; " CausesValidation="False" CommandName="Storno" Text="Сторнувати" 
                                        Enabled='<%# (Convert.ToInt16(Eval("STATUS")) != -1 && CommandEnabled()) %>'/>
                                </td>
                                <td style="text-align: center">
                                    <asp:Label ID="ADDS" runat="server" Text='<%# Eval("ADDS") %>'></asp:Label>
                                </td>
                                <td style="text-align: center">
                                    <asp:Label ID="VERSION" runat="server" Text='<%# Eval("VERSION", "{0:d}") %>'></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="AGR_NAME" runat="server" Text='<%# Eval("AGR_NAME") %>'></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="NMK" runat="server" Text='<%# Eval("NMK") != DBNull.Value ? (String)Eval("NMK") : "&"+"nbsp;" %>'></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="COMM" runat="server" Text='<%# Eval("COMM") %>'></asp:Label>
                                </td>
                                <td>
                                    <uc:EADoc ID="EADDocPrint" runat="server" Enabled="true"
                                        CausesValidation="true" ValidationGroup="Params"
                                        AgrID = '<%# Convert.ToInt32(Eval("DPT_ID")) %>'  
                                        EAStructID='<%# Convert.ToInt32(Eval("EASTRUCTID")) %>' 
                                        TemplateID ='<%# (String)Eval("TEMPLATE_ID") %>' 
                                        RNK ='<%# Convert.ToInt32(Eval("RNK")) %>' 
                                        AgrUID  ='<%# Convert.ToInt32(Eval("AGR_UID")) %>' />
                                </td>
                            </tr>
                        </ItemTemplate>
                    </asp:ListView>
                </td>
            </tr>
            <tr>
                <td align="right">
                    <asp:Button ID="btnBack" runat="server" Text="Назад" CssClass="AcceptButton" OnClick="btnBack_Click" />
                </td>
            </tr>
        </table>
        <!-- #include virtual="/barsroot/deposit/Inc/DepositCk.inc"-->
        <!-- #include virtual="/barsroot/deposit/Inc/DepositJs.inc"-->
    </form>
</body>
</html>
