<%@ Page Language="C#" MasterPageFile="~/clientregister/clientregister.master" AutoEventWireup="true"
    CodeFile="tab_custs_segments_capacity.aspx.cs" Inherits="clientregister_tab_custs_segments_capacity"
     %>

<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="Bars" %>
<%@ Register TagPrefix="ajax" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit" %>

<%@ Register Src="../credit/usercontrols/TextBoxRefer.ascx" TagName="TextBoxRefer"
    TagPrefix="Bars" %>
<%@ Register Src="../credit/usercontrols/RBLFlag.ascx" TagName="RBLFlag" TagPrefix="Bars" %>
<%@ Register Src="../credit/usercontrols/TextBoxString.ascx" TagName="TextBoxString"
    TagPrefix="Bars" %>
<%@ Register Src="../credit/usercontrols/TextBoxDate.ascx" TagName="TextBoxDate"
    TagPrefix="Bars" %>
<%@ Register Src="../credit/usercontrols/TextBoxDecimal.ascx" TagName="TextBoxDecimal"
    TagPrefix="Bars" %>
<%@ Register Src="../credit/usercontrols/DDLList.ascx" TagName="DDLList" TagPrefix="Bars" %>
 
<asp:Content ID="CapacityHead" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript" language="javascript" src="/Common/Script/Localization.js"></script>
    <script type="text/javascript" language="javascript" src="/Common/Script/cross.js"></script>
    <script type="text/vbscript" language="vbscript" src="/Common/Script/Messages/base.vbs"></script>
    <script type="text/javascript" language="javascript" src="/Common/Script/Messages/base.js"></script>
    <script type="text/javascript" language="javascript" src="/Common/jquery/jquery.js"></script>
    <script type="text/javascript" language="javascript" src="/Common/jquery/jquery-ui.1.8.js"></script>
    <script type="text/javascript" language="javascript" src="/Common/jquery/jquery.alerts.js"></script>
    <script type="text/javascript" language="javascript" src="/Common/jquery/jquery.blockUI.js"></script>
    <script type="text/javascript" language="javascript" src="/Common/jquery/jquery.custom.js"></script>
    <link href="/Common/CSS/jquery/jquery.1.8.css?v1.1" type="text/css" rel="stylesheet" />
    <link href="/Common/CSS/jquery/custom.css?v1.1" type="text/css" rel="stylesheet" />
    <link href="/Common/CSS/BarsGridView.css?v1.1" type="text/css" rel="stylesheet" />
     <script type="text/javascript">
        var jsres$core = {
            loading: "Загрузка...",
            close: "Закрыть"
        };

        function CloseFrame() {
          //  window.parent.jQuery('#dialogFrame').dialog('close');
        }

        function redirectToMainFrame(url) {
            //var mainDocument = parent.parent.parent.parent
            var mainWindow = window.top;
            if (mainWindow && mainWindow.go)
                mainWindow.go(url);
            else {
                mainWindow.location.href = url;
            }
        }

     </script>
    <style type="text/css">
        .auto-style1 {
            height: 165px;
            width: 541px;
        }
        .auto-style2 {
            height: 216px;
            width: 541px;
        }
        </style>
</asp:Content>
<asp:Content ID="CapacityBody" ContentPlaceHolderID="body" runat="Server">
    <table border="0" cellpadding="3" cellspacing="0">
        <tr>

            <td class="auto-style2">
                <asp:Panel ID="pnlCusts" runat="server" GroupingText="Продуктове навантаження" Width="547px" Height="282px" BackColor="#DFDFDF">
                    <table class="InnerTable">
                        <tr>
                            <td runat="server" align="center">Найменування
                            </td>
                            <td runat="server" align="center">Значення
                            </td>
                            
                        </tr>
                        <tr>
                            <td runat="server"><a href="#" onclick="redirectToMainFrame('/barsroot/clientproducts/dptclientsearch.aspx'); return false;">Депозити</a>
                            </td>
                            <td>
                                <asp:TextBox ID="DEPOSIT_AMMOUNT" runat="server" Enabled="false"
                                    TabIndex="1" ToolTip="Депозити" CssClass="InfoText40" Style="margin-left: 29px" Width="250px" />
                            </td>
                            <td>
                                &nbsp;</td>
                            <td>
                                &nbsp;</td>

                        </tr>
                        <tr>
                            <td runat="server">
                                <a href="#" onclick="redirectToMainFrame('/barsroot/barsweb/references/refbook.aspx?tabid=2812&mode=ro&force=1'); return false;">Кредити</a>
                            </td>
                            <td>
                                <asp:TextBox ID="CREDITS_AMMOUNT" runat="server" MaxLength="15" Enabled="false"
                                    TabIndex="1" ToolTip="Кредити" CssClass="InfoText40" Style="margin-left: 29px" Width="250px" />
                            </td>
                            <td>
                                &nbsp;</td>
                            <td>
                                &nbsp;</td>

                        </tr>
                        <tr>
                            <td runat="server"><a href="#" onclick="redirectToMainFrame('/barsroot/barsweb/references/refbook.aspx?tabid=2812&mode=ro&force=1'); return false;">Кредити БПК</a>
                            </td>
                            <td>
                                <asp:TextBox ID="CARDCREDITS_AMMOUNT" runat="server" MaxLength="15" Enabled="false"
                                    TabIndex="1" ToolTip="Кредити БПК" CssClass="InfoText40" Style="margin-left: 29px" Width="250px" />
                            </td>
                            <td>
                                &nbsp;</td>
                            <td>
                                &nbsp;</td>
                        </tr>
                        <tr>
                            <td runat="server"><a href="#" onclick="redirectToMainFrame('/barsroot/barsweb/references/refbook.aspx?tabid=2812&mode=ro&force=1'); return false;">Кредити на поруку</a>
                            </td>
                            <td>
                                <asp:TextBox ID="GARANT_CREDITS_AMMOUNT" runat="server" MaxLength="15" Enabled="false"
                                    TabIndex="1" ToolTip="Кредити на поруку" CssClass="InfoText40" Style="margin-left: 29px" Width="250px" />
                            </td>
                            <td>
                                &nbsp;</td>
                            <td>
                                &nbsp;</td>
                        </tr>
                        <tr>
                            <td runat="server"><a href="#" onclick="redirectToMainFrame('/barsroot/barsweb/references/refbook.aspx?tabid=2812&mode=ro&force=1'); return false;">Енергоефективність</a>
                            </td>
                            <td>
                                <asp:TextBox ID="ENERGYCREDITS_AMMOUNT" runat="server" MaxLength="15" Enabled="false"
                                    TabIndex="1" ToolTip="Енергоефективність" CssClass="InfoText40" Style="margin-left: 29px" Width="250px" />
                            </td>
                            <td>
                                &nbsp;</td>
                            <td>
                                &nbsp;</td>
                        </tr>
                        <tr>
                            <td runat="server"><a href="#" onclick="redirectToMainFrame('/barsroot/barsweb/dynform.aspx?form=bpkw4.frm.portfolio'); return false;">БПК</a>
                            </td>
                            <td>
                                <asp:TextBox ID="CARDS_AMMOUNT" runat="server" MaxLength="15" Enabled="false"
                                    TabIndex="1" ToolTip="БПК" CssClass="InfoText40" Style="margin-left: 29px" Width="250px" />
                            </td>
                            <td>
                                &nbsp;</td>
                            <td>
                                &nbsp;</td>

                        </tr>
                        <tr>
                            <td runat="server"><a href="#" onclick="redirectToMainFrame('/barsroot/deposit/depositsearch.aspx?action=show'); return false;">Поточні рахунки</a>
                            </td>
                            <td>
                                <asp:TextBox ID="ACCOUNTS_AMMOUNT" runat="server" MaxLength="15" Enabled="false"
                                    TabIndex="1" ToolTip="Поточні рахунки" CssClass="InfoText40" Style="margin-left: 29px" Width="250px" />
                            </td>
                            <td>
                                &nbsp;</td>
                            <td>
                                &nbsp;</td>

                        </tr>
                        <tr>
                            <td runat="server">К-ть транзакцій
                            </td>
                            <td>
                                <asp:TextBox ID="TRANSFERS_AMMOUNT" runat="server" MaxLength="15" Enabled="false"
                                    TabIndex="1" ToolTip="К-ть транзакцій" CssClass="InfoText40" Style="margin-left: 29px" Width="250px" />
                            </td>
                            <td>
                                &nbsp;</td>
                            <td>
                           <%--     <asp:Button ID="btnClose" runat="server" Text="Ok" OnClientClick="CloseFrame();" />
                           --%> </td>

                        </tr>
                    </table>
                </asp:Panel>

            </td>

        </tr>

        <tr>
            <td class="auto-style1">
                &nbsp;</td>
        </tr>
    </table>
</asp:Content>
