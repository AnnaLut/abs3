<%@ Page Language="C#" MasterPageFile="~/clientregister/clientregister.master" AutoEventWireup="true"
    CodeFile="tab_custs_segments.aspx.cs" Inherits="clientregister_tab_custs_segments"
    Title="сегментація" %>

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

<asp:Content ID="SegmentsHead" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript" language="javascript" src="/Common/jquery/jquery.js"></script>
    <script type="text/javascript" language="javascript" src="/Common/jquery/jquery-ui.1.8.js"></script>
    <script type="text/javascript" language="javascript" src="/Common/jquery/jquery.alerts.js"></script>
    <script type="text/javascript" language="javascript" src="/Common/jquery/jquery.blockUI.js"></script>
    <script type="text/javascript" language="javascript" src="/Common/jquery/jquery.custom.js"></script>
    <script type="text/javascript">
        var jsres$core = {
            loading: "Загрузка...",
            close: "Закрыть"
        };

        function frameCustCapacity() {
            var _rnk = document.getElementById('ctl00_body_ClientRnk').value;
            // console.log(_rnk);
            var rnd = Math.random();
            core$IframeBox({ url: "/barsroot/clientregister/tab_custs_segments_capacity.aspx?rnk=" + _rnk, width: 420, height: 520, id: 'segmentform' });
        }
    </script>
</asp:Content>
<asp:Content ID="SegmentsBody" ContentPlaceHolderID="body" runat="Server">
    <table border="0">
        <tr>
            <td>
                <asp:Panel ID="pnlCustsSegments" runat="server" GroupingText="Загальна інформація">
                    <table>
                        <tr>
                            <td align="center"><b>Найменування</b>
                            </td>
                            <td align="center"><b>Значення</b>
                            </td>
                            <td align="center"><b>Дата встановлення</b>
                            </td>
                            <td align="center"><b>Діє до</b>
                            </td>
                        </tr>
                        <tr>
                            <td>Сегмент активності
                            </td>
                            <td>
                                <asp:TextBox ID="CUSTOMER_SEGMENT_ACTIVITY" runat="server" Enabled="false"
                                    TabIndex="1" CssClass="InfoText40" Style="margin-left: 29px" Width="250px" />
                            </td>
                            <td>
                                <asp:TextBox ID="CSA_DATE_START" runat="server"  Enabled="false"
                                    TabIndex="2" CssClass="InfoText40" Style="margin-left: 20px" Width="100px" />
                            </td>
                            <td>
                                <asp:TextBox ID="CSA_DATE_STOP" runat="server"  Enabled="false"
                                    TabIndex="3" CssClass="InfoText40" Style="margin-left: 20px" Width="100px" />
                            </td>
                        </tr>
                        <tr>
                            <td runat="server">Сегмент фінансовий
                            </td>
                            <td>
                                <asp:TextBox ID="CUSTOMER_SEGMENT_FINANCIAL" runat="server" Enabled="false"
                                    TabIndex="1" CssClass="InfoText40" Style="margin-left: 29px" Width="250px" />
                            </td>
                            <td>
                                <asp:TextBox ID="CSF_DATE_START" runat="server"  Enabled="false"
                                    TabIndex="2" CssClass="InfoText40" Style="margin-left: 20px" Width="100px" />
                            </td>
                            <td>
                                <asp:TextBox ID="CSF_DATE_STOP" runat="server"  Enabled="false"
                                    TabIndex="3" CssClass="InfoText40" Style="margin-left: 20px" Width="100px" />
                            </td>

                        </tr>
                        <tr>
                            <td runat="server">Сегмент поведінковий
                            </td>
                            <td>
                                <asp:TextBox ID="CUSTOMER_SEGMENT_BEHAVIOR" runat="server"  Enabled="false"
                                    TabIndex="1" CssClass="InfoText40" Style="margin-left: 29px" Width="250px" />
                            </td>
                            <td>
                                <asp:TextBox ID="CSB_DATE_START" runat="server"  Enabled="false"
                                    TabIndex="2" CssClass="InfoText40" Style="margin-left: 20px" Width="100px" />
                            </td>
                            <td>
                                <asp:TextBox ID="CSB_DATE_STOP" runat="server"  Enabled="false"
                                    TabIndex="3" CssClass="InfoText40" Style="margin-left: 20px" Width="100px" />
                            </td>

                        </tr>
                        <tr>
                            <td runat="server"><a href='#' onclick='frameCustCapacity();return false;'>Продуктове навантаження</a>
                            </td>
                            <td>
                                <asp:TextBox ID="CUSTOMER_SEGMENT_PRODUCTS_AMNT" runat="server"  Enabled="false"
                                    TabIndex="1" CssClass="InfoText40" Style="margin-left: 29px" Width="250px" />
                            </td>
                            <td>
                                <asp:TextBox ID="CSP_DATE_START" runat="server"  Enabled="false"
                                    TabIndex="2" CssClass="InfoText40" Style="margin-left: 20px" Width="100px" />
                            </td>
                            <td>
                                <a href='#' onclick='frameCustCapacity();return false;'>>>>></a>
                            </td>
                        </tr>
                        <tr>
                            <td runat="server">Кіл-ть розрахунків карткою в ТСП
                            </td>
                            <td>
                                <asp:TextBox ID="CUSTOMER_SEGMENT_TRANSACTIONS" runat="server"  Enabled="false"
                                    TabIndex="1" CssClass="InfoText40" Style="margin-left: 29px" Width="250px" />
                            </td>
                            <td>
                                <asp:TextBox ID="CST_DATE_START" runat="server"  Enabled="false"
                                    TabIndex="2" CssClass="InfoText40" Style="margin-left: 20px" Width="100px" />
                            </td>
                            <td>
                                <asp:TextBox ID="CST_DATE_STOP" runat="server"  Enabled="false"
                                    TabIndex="3" CssClass="InfoText40" Style="margin-left: 20px" Width="100px" />
                            </td>

                        </tr>
		                <tr>
                            <td runat="server">Кіл-ть операцій зняття готівки в АТМ
                            </td>
                            <td>
                                <asp:TextBox ID="CUSTOMER_SEGMENT_ATM" runat="server" Enabled="false"
                                    TabIndex="1" CssClass="InfoText40" Style="margin-left: 29px" Width="250px" />
                            </td>
                            <td>
                                <asp:TextBox ID="CSAT_DATE_START" runat="server" Enabled="false"
                                    TabIndex="2" CssClass="InfoText40" Style="margin-left: 20px" Width="100px" />
                            </td>
                        </tr>
                        <tr>
                            <td runat="server">Сума встановленого КЛ на БПК(грн)
                            </td>
                            <td>
                                <asp:TextBox ID="CS_BPK_CREDITLINE" runat="server" Enabled="false"
                                    TabIndex="1" CssClass="InfoText40" Style="margin-left: 29px" Width="250px" />
                            </td>
                            <td>
                                <asp:TextBox ID="CS_BPK_CREDITLINE_START" runat="server" Enabled="false"
                                    TabIndex="2" CssClass="InfoText40" Style="margin-left: 20px" Width="100px" />
                            </td>
                        </tr>
                        <tr>
                            <td runat="server">Сума наданого Кеш кредиту (грн)
                            </td>
                            <td>
                                <asp:TextBox ID="CS_CASHCREDIT_GIVEN" runat="server" Enabled="false"
                                    TabIndex="1" CssClass="InfoText40" Style="margin-left: 29px" Width="250px" />
                            </td>
                            <td>
                                <asp:TextBox ID="CS_CASHCREDIT_GIVEN_START" runat="server" Enabled="false"
                                    TabIndex="2" CssClass="InfoText40" Style="margin-left: 20px" Width="100px" />
                            </td>
                            <td>
                                <asp:TextBox ID="CS_CASHCREDIT_GIVEN_STOP" runat="server"  Enabled="false"
                                    TabIndex="3" CssClass="InfoText40" Style="margin-left: 20px" Width="100px" />
                            </td>
                        </tr>
                        <tr>
                            <td runat="server">Обслуговуюче відділення
                            </td>
                            <td>
                                <asp:TextBox ID="CUSTOMER_SEGMENT_TVBV" runat="server" Enabled="false"
                                    TabIndex="1" CssClass="InfoText40" Style="margin-left: 29px" Width="250px" />
                            </td>
                            <td>
                                <asp:TextBox ID="CUSTOMER_SEGMENT_TVBV_START" runat="server" Enabled="false"
                                    TabIndex="2" CssClass="InfoText40" Style="margin-left: 20px" Width="100px" />
                            </td>
                        </tr>
                        <tr>
                            <td runat="server">Код портфеля менеджера
                            </td>
                            <td>
                                <asp:TextBox ID="CUSTOMER_SEGMENT_KODM" runat="server" Enabled="false"
                                    TabIndex="1" CssClass="InfoText40" Style="margin-left: 29px" Width="250px" />
                            </td>
                            <td>
                                <asp:TextBox ID="CSK_DATE_START" runat="server" Enabled="false"
                                    TabIndex="2" CssClass="InfoText40" Style="margin-left: 20px" Width="100px" />
                            </td>
                        </tr>
                        <tr>
                            <td runat="server">ПІБ менеджера
                            </td>
                            <td>
                                <asp:TextBox ID="CUSTOMER_SEGMENT_MANAGER" runat="server" Enabled="false"
                                    TabIndex="1" CssClass="InfoText40" Style="margin-left: 29px" Width="250px" />
                            </td>
                            <td>
                                <asp:TextBox ID="CSM_DATE_START" runat="server" Enabled="false"
                                    TabIndex="2" CssClass="InfoText40" Style="margin-left: 20px" Width="100px" />
                            </td>
                        </tr>
                        <!--  <tr>
                            <td runat="server">Соціальний VIP
                            </td>
                            <td>
                                <asp:TextBox ID="CUSTOMER_VIP" runat="server" Enabled="false"
                                    ToolTip="" CssClass="InfoText40" Style="margin-left: 29px" Width="250px" />
                            </td>
                        </tr>-->
                    </table>
                </asp:Panel>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Panel ID="pnlSegmentsHistory" runat="server" GroupingText="Історія змін клієнта №">
                    <asp:TextBox ID="ClientRnk" meta:resourcekey="ClientRnk" runat="server" Visible="True"
                        TabIndex="32" MaxLength="10" ToolTip="RNK" CssClass="InfoText40" />
                    <asp:CheckBox ID="chkShowAll" runat="server" AutoPostBack="True" OnCheckedChanged="chkShowAll_CheckedChanged" Text="Отобразить все изменения" />
                    <table border="0" cellpadding="3" cellspacing="0">
                        <tr>
                            <td style="width: 300px; vertical-align: top">
                                <bars:BarsObjectDataSource ID="odsCustSegmentsHistory" runat="server" SelectMethod="SelectCustSegmentsHistory"
                                    TypeName="clientregister.VCustomerSegmentsHistory">
                                    <SelectParameters>
                                        <asp:QueryStringParameter Name="RNK" QueryStringField="RNK" Type="Decimal" />
                                        <asp:ControlParameter ControlID="chkShowAll" DefaultValue="False" Name="ShowAll" PropertyName="Checked" />
                                    </SelectParameters>
                                </bars:BarsObjectDataSource>
                                <bars:BarsGridViewEx ID="gv" runat="server" AutoGenerateColumns="False"
                                    DataSourceID="odsCustSegmentsHistory" DataKeyNames="RNK"
                                    AllowSorting="True" AllowPaging="True" PageSize="20" ShowFooter="True"
                                    ShowExportExcelButton="True" CaptionText="" ClearFilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_delete.png" CloseFilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_close.png" CssClass="barsGridView" DateMask="dd.MM.yyyy" EnableModelValidation="True" ExcelImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.export_excel.png" FilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_open.png" HoverRowCssClass="hoverRow" MetaFilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_open.png" MetaTableName="" RefreshImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.refresh.png">
                                    <NewRowStyle CssClass=""></NewRowStyle>
                                    <AlternatingRowStyle CssClass="alternateRow"></AlternatingRowStyle>
                                    <Columns>
                                        <asp:BoundField DataField="ATTRIBUTE_NAME" HeaderText="Найменування атрибуту" SortExpression="ATTRIBUTE_NAME" />
                                        <asp:BoundField DataField="ATTRIBUTE_VAL" HeaderText="Значення" SortExpression="ATTRIBUTE_VAL" />
                                        <asp:BoundField DataField="PREV_VAL_DATE_START" HeaderText="Дата початку дії" SortExpression="PREV_VAL_DATE_START" DataFormatString="{0:d}" />
                                        <asp:BoundField DataField="PREV_DATE_STOP" HeaderText="Дата завершення дії" SortExpression="PREV_DATE_STOP" DataFormatString="{0:d}" />
                                    </Columns>
                                    <EditRowStyle CssClass="editRow"></EditRowStyle>
                                    <FooterStyle CssClass="footerRow"></FooterStyle>
                                    <HeaderStyle CssClass="headerRow"></HeaderStyle>
                                    <PagerStyle CssClass="pagerRow"></PagerStyle>
                                    <RowStyle CssClass="normalRow" HorizontalAlign="Right"></RowStyle>
                                    <SelectedRowStyle CssClass="selectedRow"></SelectedRowStyle>
                                </bars:BarsGridViewEx>
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </td>
        </tr>
    </table>
</asp:Content>
