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
            font-family: Arial;
            font-size: 10pt;
            margin-left: 29px;
            text-align: right;
        }
        </style>
</asp:Content>
<asp:Content ID="CapacityBody" ContentPlaceHolderID="body" runat="Server">
    <table border="0" cellpadding="3" cellspacing="0">
        <tr>

            <td>
                <asp:Panel ID="pnlCusts" runat="server" GroupingText="Продуктове навантаження" BackColor="#DFDFDF">
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
                                <asp:TextBox ID="DEPOSIT_AMOUNT" runat="server" Enabled="false" TabIndex="1" ToolTip="Депозити"  CssClass="auto-style1"/>
                            </td>
                        </tr>
                        <tr>
                            <td runat="server">
                                <a href="#" onclick="redirectToMainFrame('/barsroot/barsweb/references/refbook.aspx?tabid=2812&mode=ro&force=1'); return false;">Кредити</a>
                            </td>
                            <td>
                                <asp:TextBox ID="CREDITS_AMOUNT" runat="server" MaxLength="15" Enabled="false" TabIndex="1" ToolTip="Кредити" CssClass="auto-style1"/>
                            </td>
                        </tr>
                        <tr>
                            <td runat="server"><a href="#" onclick="redirectToMainFrame('/barsroot/barsweb/references/refbook.aspx?tabid=2812&mode=ro&force=1'); return false;">Кредити БПК викор-ний</a>
                            </td>
                            <td>
                                <asp:TextBox ID="CARDCREDITS_AMOUNT" runat="server" MaxLength="15" Enabled="false" TabIndex="1" ToolTip="Кредити БПК викор-ний" CssClass="auto-style1"/>
                            </td>
                        </tr>
                        <tr>
                            <td runat="server"><a href="#" onclick="redirectToMainFrame('/barsroot/barsweb/references/refbook.aspx?tabid=2812&mode=ro&force=1'); return false;">Ліміт БПК встановлений</a>
                            </td>
                            <td>
                                <asp:TextBox ID="BPK_CREDITLINE_AMOUNT" runat="server" MaxLength="15" Enabled="false" TabIndex="1" ToolTip="Ліміт БПК встанов-ний" CssClass="auto-style1"/>
                            </td>
                        </tr>
                        <tr>
                            <td runat="server"><a href="#" onclick="redirectToMainFrame('/barsroot/barsweb/references/refbook.aspx?tabid=2812&mode=ro&force=1'); return false;">Кеш кредит</a>
                            </td>
                            <td>
                                <asp:TextBox ID="CASHLOANS_AMOUNT" runat="server" MaxLength="15" Enabled="false" TabIndex="1" ToolTip="Кеш кредит" CssClass="auto-style1"/>
                            </td>
                        </tr>
                        <tr>
                            <td runat="server"><a href="#" onclick="redirectToMainFrame('/barsroot/barsweb/references/refbook.aspx?tabid=2812&mode=ro&force=1'); return false;">Кредити на поруку</a>
                            </td>
                            <td>
                                <asp:TextBox ID="GARANT_CREDITS_AMOUNT" runat="server" MaxLength="15" Enabled="false" TabIndex="1" ToolTip="Кредити на поруку" CssClass="auto-style1"/>
                            </td>
                        </tr>
                        <tr>
                            <td runat="server"><a href="#" onclick="redirectToMainFrame('/barsroot/barsweb/references/refbook.aspx?tabid=2812&mode=ro&force=1'); return false;">Енергоефективність</a>
                            </td>
                            <td>
                                <asp:TextBox ID="ENERGYCREDITS_AMOUNT" runat="server" MaxLength="15" Enabled="false" TabIndex="1" ToolTip="Енергоефективність" CssClass="auto-style1"/>
                            </td>
                        </tr>
                        <tr>
                            <td runat="server"><a href="#" onclick="redirectToMainFrame('/barsroot/barsweb/dynform.aspx?form=bpkw4.frm.portfolio'); return false;">БПК не преміальна</a>
                            </td>
                            <td>
                                <asp:TextBox ID="CARDS_AMOUNT" runat="server" MaxLength="15" Enabled="false" TabIndex="1" ToolTip="БПК не преміальна" CssClass="auto-style1"/>
                            </td>
                        </tr>
                        <tr>
                            <td runat="server"><a href="#" onclick="redirectToMainFrame('/barsroot/deposit/depositsearch.aspx?action=show'); return false;">Поточні рахунки</a>
                            </td>
                            <td>
                                <asp:TextBox ID="ACCOUNTS_AMOUNT" runat="server" MaxLength="15" Enabled="false" TabIndex="1" ToolTip="Поточні рахунки" CssClass="auto-style1"/>
                            </td>
                        </tr>
						<tr>
                            <td runat="server"><a href="#" onclick="redirectToMainFrame('/barsroot/safe-deposit/safeportfolio.aspx'); return false;">Індивідуальні сейфи</a>    
                            </td>
                            <td>
                                <asp:TextBox ID="INDIVIDUAL_SAFES_AMOUNT" runat="server" MaxLength="15" Enabled="false" TabIndex="1" ToolTip="Індивідуальні сейфи" CssClass="auto-style1"/>
                            </td>
                        </tr>
                        <tr>
                            <td runat="server"><a href="https://oschadbank.ewa.ua/#/contracts" target="_blank">Страхування «Автоцивілка»</a>
                            </td>
                            <td>
                                <asp:TextBox ID="INSURANCE_AVTOCIVILKA_AMOUNT" runat="server" MaxLength="15" Enabled="false" TabIndex="1" ToolTip="Страхування «Автоцивілка»" CssClass="auto-style1"/>
                            </td>
                        </tr>
                        <tr>
                            <td runat="server"><a href="https://oschadbank.ewa.ua/#/contracts" target="_blank">Страхування «Автоцивілка+»</a>
                            </td>
                            <td>
                                <asp:TextBox ID="INSURANCE_AVTOCIVILKAPLUS_AMOUNT" runat="server" MaxLength="15" Enabled="False" TabIndex="1" ToolTip="Страхування «Автоцивілка+»" CssClass="auto-style1"/>
                            </td>
                        </tr>
                        <tr>
                            <td runat="server"><a href="https://oschadbank.ewa.ua/#/contracts" target="_blank">Страхування «Оберіг»</a>
                            </td>
                            <td>
                                <asp:TextBox ID="INSURANCE_OBERIG_AMOUNT" runat="server" MaxLength="15" Enabled="False" TabIndex="1" ToolTip="Страхування «Оберіг»" CssClass="auto-style1"/>
                            </td>
                        </tr>
                        <tr>
                            <td runat="server"><a href="https://oschadbank.ewa.ua/#/contracts" target="_blank">Страхування життя (Кеш)</a>
                            </td>
                            <td>
                                <asp:TextBox ID="INSURANCE_CASH_AMOUNT" runat="server" MaxLength="15" Enabled="False" TabIndex="1" ToolTip="Страхування життя (Кеш)»" CssClass="auto-style1"/>
                            </td>
                        </tr>
                        <tr>
                            <td runat="server"><a href="#" onclick="redirectToMainFrame('/barsroot/barsweb/dynform.aspx?form=bpkw4.frm.portfolio'); return false;">БПК Преміальна</a>
                            </td>
                            <td>
                                <asp:TextBox ID="CARD_CREDIT_PRIME" runat="server" Maxlength="15" Enabled="false" TabIndex="1" ToolTip="БПК Преміальна" CssClass="auto-style1"/>
                           </td>      
                       </tr>
                        <tr>
                            <td runat="server"><a href="#" onclick="redirectToMainFrame('/barsroot/clientproducts/dptclientsearch.aspx'); return false;">Мобільні заощадження</a>
                            </td>
                            <td>
                                <asp:TextBox ID="MOBILE_SAVING" runat="server" Maxlength="15" Enabled="false" TabIndex="1" ToolTip="Мобільні заощадження" CssClass="auto-style1"/>
                           </td>      
                       </tr>
                         <tr>
                            <%--<td runat="server"><a href="https://oschadbank.ewa.ua/#/contracts" target="_blank">Ощад 24/7 (інформац.активний)</a>--%>
                                <td runat="server"> <a>Ощад 24/7 (інформаційно активний)</a>
                            </td>
                            <td>
                                <asp:TextBox ID="OSHAD_ACTIVE" runat="server" Maxlength="15" Enabled="false" TabIndex="1" ToolTip="Ощад 24/7 (інформаційно активний)" CssClass="auto-style1"/>
                           </td> 
                       </tr>
                    </table>
                </asp:Panel>
            </td>
        </tr>
    </table>
</asp:Content>
