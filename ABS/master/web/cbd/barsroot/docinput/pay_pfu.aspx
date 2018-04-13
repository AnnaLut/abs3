<%@ Page Language="C#" AutoEventWireup="true" CodeFile="pay_pfu.aspx.cs" Inherits="docinput_PFU" %>

<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="Bars" %>
<%@ Register Assembly="Bars.Web.Controls" Namespace="Bars.Web.Controls" TagPrefix="Bars" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="/barsroot/deposit/style/dpt.css" type="text/css" rel="stylesheet" />
    <link href="/barsroot/deposit/style/barsgridview.css" type="text/css" rel="stylesheet" />
    <link href="Styles.css" type="text/css" rel="stylesheet" />
    <script type="text/javascript" language="javascript">
        function AfterPageLoad() {
            document.getElementById('tbAccountNumber').readOnly = true;
            document.getElementById('tbAccountName').readOnly = true;
            document.getElementById('tbSymbol').readOnly = true;
        }
    </script>
</head>
<body onload="AfterPageLoad();">
    <form id="form1" runat="server">
    <div>
        <table class="MainTable">
            <tr>
                <td align="center">
                    <asp:Label ID="lbTitle" Text="Зарахування пенсії" CssClass="InfoHeader" runat="server" />
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Panel ID="pnAgency" runat="server" GroupingText="Парамерти зарахування">
                        <table class="InnerTable">
                            <tr>
                                <td>
                                </td>
                                <td style="width: 15%">
                                </td>
                                <td style="width: 35%">
                                </td>
                                <td>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 25%" align="right">
                                    <asp:Label ID="lbAgencyType" Text="Тип органу соцзахисту: &nbsp;" runat="server"
                                        CssClass="InfoLabel" />
                                </td>
                                <td colspan="2">
                                    <asp:DropDownList ID="listAgencyType" runat="server" CssClass="BaseDropDownList"
                                        DataValueField="TYPE_CODE" DataTextField="TYPE_NAME" TabIndex="1" AutoPostBack="True"
                                        OnSelectedIndexChanged="listAgencyType_SelectedIndexChanged" />
                                </td>
                                <td style="width: 25%"></td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:Label ID="lbAgency" Text="Орган соцзахисту: &nbsp;" runat="server" CssClass="InfoLabel" />
                                </td>
                                <td colspan="2">
                                    <asp:DropDownList ID="listAgency" runat="server" CssClass="BaseDropDownList" DataValueField="CREDIT_ACC"
                                        DataTextField="NAME" TabIndex="2" AutoPostBack="True" OnSelectedIndexChanged="listAgency_SelectedIndexChanged" />
                                </td>
                                <td>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:Label ID="lbAccount" Text="Номер рахунку: &nbsp;" runat="server" CssClass="InfoLabel" />
                                </td>
                                <td>
                                    <asp:TextBox ID="tbAccountNumber" runat="server" CssClass="InfoText" TabIndex="3"
                                        BackColor="LightGray" />
                                </td>
                                <td align="right">
                                    <asp:TextBox ID="tbAccountName" runat="server" CssClass="InfoText95" TabIndex="4"
                                        BackColor="LightGray" ToolTip="Назва рахунку" />
                                </td>
                                <td>
                                    <asp:HiddenField ID="tbAgencyCode" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:Label ID="lbWarrantNumber" Text="Номер мем.ордера: &nbsp;" runat="server" CssClass="InfoLabel" />
                                </td>
                                <td>
                                    <asp:TextBox ID="tbWarrantNumber" runat="server" TabIndex="5" CssClass="InfoDateSum" />
                                </td>
                                <td align="right" style="white-space: nowrap">
                                    <asp:Label ID="lbSymbol" Text="Позабалансовий символ: &nbsp;" runat="server" CssClass="InfoLabel" />
                                    <asp:TextBox ID="tbSymbol" runat="server" Style="text-align: center; width: 50px"
                                        BackColor="LightGray" />
                                </td>
                                <td></td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:Label ID="lbMonthYear" Text="Місяць зарахування: &nbsp;" runat="server" CssClass="InfoLabel" />
                                </td>
                                <td>
                                    <asp:DropDownList ID="listMonths" runat="server" CssClass="BaseDropDownList">
                                        <asp:ListItem Value="1"  Text="січень"   />
                                        <asp:ListItem Value="2"  Text="лютий"    />
                                        <asp:ListItem Value="3"  Text="березень" />
                                        <asp:ListItem Value="4"  Text="квітень"  />
                                        <asp:ListItem Value="5"  Text="травень"  />
                                        <asp:ListItem Value="6"  Text="червень"  />
                                        <asp:ListItem Value="7"  Text="липень"   />
                                        <asp:ListItem Value="8"  Text="серпень"  />
                                        <asp:ListItem Value="9"  Text="вересень" />
                                        <asp:ListItem Value="10" Text="жовтень"  />
                                        <asp:ListItem Value="11" Text="листопад" />
                                        <asp:ListItem Value="12" Text="грудень"  />
                                    </asp:DropDownList>
                                </td>
                                <td align="right" style="white-space:nowrap">
                                    <asp:Label ID="lbYear" Text="Рік зарахування: &nbsp;" runat="server" CssClass="InfoLabel" />
                                    <asp:TextBox ID="tbYear" runat="server" MaxLength="4" Style="text-align: center; width: 50px" />
                                </td>
                                <td></td>
                            </tr>
                        </table>
                    </asp:Panel>
                </td>
            </tr>
        </table>
        <table class="InnerTable">
            <tr>
                <td colspan="2">
                    <!-- OnDataBound="fmvDocument_DataBound" -->
                    <asp:FormView ID="fmvDocument" runat="server" DataSourceID="dsDocument" DefaultMode="Insert"
                        Width="100%" Caption="Реквізити для зарахування" CaptionAlign="Left"
                        BorderStyle="Solid" BorderWidth="1px" Visible="false"
                        OnItemInserting="fmvDocument_ItemInserting" OnItemInserted="fmvDocument_ItemInserted" 
                        OnItemUpdating="fmvDocument_ItemUpdating" OnItemUpdated="fmvDocument_ItemUpdated"
                        OnItemDeleting="fmvDocument_ItemDeleting" OnItemDeleted="fmvDocument_ItemDeleted"
                        OnItemCommand="fmvDocument_ItemCommand">
                        <InsertItemTemplate>
                            <table class="MainTable" cellpadding="3">
                                <tr>
                                    <td style="width: 7%">
                                    </td>
                                    <td style="width: 7%">
                                    </td>
                                    <td style="width: 7%">
                                    </td>
                                    <td style="width: 7%" align="center">
                                        <asp:Label ID="it_lbAsvoCreditNls" runat="server" Text="Номер рахунку (АСВО)"></asp:Label>
                                    </td>
                                    <td style="width: 12%" align="center">
                                        <asp:Label ID="it_lbRealCreditNls" runat="server" Text="Номер рахунку (реальний)"></asp:Label>
                                    </td>
                                    <td style="width: 20%" align="center">
                                        <asp:Label ID="it_lbCreditName" runat="server" Text="ПІБ отримувача"></asp:Label>
                                    </td>
                                    <td style="width: 10%" align="center">
                                        <asp:Label ID="it_lbSum" runat="server" Text="Сума зарахування"></asp:Label>
                                    </td>
                                    <td style="width: 30%">
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="3">
                                    </td>
                                    <td>
                                        <asp:TextBox ID="it_AsvoCreditNls" Width="99%" Text='<%# Bind("NLSB_ALT") %>' runat="server" />
                                    </td>
                                    <td>
                                        <asp:TextBox ID="it_RealCreditNls" Width="99%" Text='<%# Bind("NLSB") %>' runat="server" />
                                    </td>
                                    <td>
                                        <asp:TextBox ID="it_CreditName" Width="99%" Text='<%# Bind("NMSB") %>' runat="server" />
                                    </td>
                                    <td>
                                        <Bars:NumericEdit ID="it_Sum" Width="99%" Value='<%# Bind("S") %>' runat="server" />
                                    </td>
                                    <td>
                                        &nbsp;
                                        <asp:LinkButton ID="it_InsertButton" CommandName="Insert" Text="Додати" runat="server"
                                            CausesValidation="true" />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="4" align="right">
                                        <asp:Label ID="it_lbMessage" runat="server" CssClass="lblError" Text="Message" Visible="false" />
                                    </td>
                                    <td colspan="2">
                                        <asp:DropDownList ID="it_ddPretenders" Width="100%" runat="server" 
                                            Visible="false" DataValueField="NLS" DataTextField="NMS" 
                                            AutoPostBack="true" OnSelectedIndexChanged="Pretenders_SelectedIndexChanged"/>
                                    </td>
                                    <td colspan="2">
                                    </td>
                                </tr>
                            </table>
                        </InsertItemTemplate>
                        <EditItemTemplate>
                            <table class="MainTable" cellpadding="4">
                                <tr>
                                    <td style="width: 7%">
                                    </td>
                                    <td style="width: 7%">
                                    </td>
                                    <td style="width: 7%" align="center">
                                        <asp:Label ID="et_lbNumber" runat="server" Text="№" />
                                    </td>
                                    <td style="width: 7%" align="center">
                                        <asp:Label ID="et_lbAsvoCreditNls" runat="server" Text="Номер рахунку (АСВО)" />
                                    </td>
                                    <td style="width: 12%" align="center">
                                        <asp:Label ID="et_lbRealCreditNls" runat="server" Text="Номер рахунку (реальний)" />
                                    </td>
                                    <td style="width: 20%" align="center">
                                        <asp:Label ID="et_lbCreditName" runat="server" Text="ПІБ отримувача" />
                                    </td>
                                    <td style="width: 10%" align="center">
                                        <asp:Label ID="et_lbSum" runat="server" Text="Сума зарахування" />
                                    </td>
                                    <td style="width: 30%">
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                    </td>
                                    <td>
                                        <asp:TextBox ID="et_Number" Text='<%# Bind("ID") %>' Width="99%" runat="server" />
                                    </td>
                                    <td>
                                        <asp:TextBox ID="et_AsvoCreditNls" Text='<%# Bind("NLSB_ALT") %>' Width="99%" runat="server" />
                                    </td>
                                    <td>
                                        <asp:TextBox ID="et_RealCreditNls" Text='<%# Bind("NLSB") %>' Width="99%" runat="server" />
                                    </td>
                                    <td>
                                        <asp:TextBox ID="et_CreditName" Text='<%# Bind("NMSB") %>' Width="99%" ReadOnly="true"
                                            runat="server" />
                                    </td>
                                    <td>
                                        <Bars:NumericEdit ID="et_Sum" Value='<%# Bind("S") %>' Width="99%" runat="server" />
                                    </td>
                                    <td>
                                        &nbsp;
                                        <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update"
                                            Text="Зберегти">
                                        </asp:LinkButton>
                                        &nbsp;
                                        <asp:LinkButton ID="DeleteButton" runat="server" CausesValidation="False" CommandName="Delete"
                                            Text="Видалити">                                        
                                        </asp:LinkButton>
                                        &nbsp;
                                        <asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel"
                                            Text="Відмінити">
                                        </asp:LinkButton>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="4" align="right">
                                        <asp:Label ID="et_lbMessage" Text="Виберійть отримувача із списку: &nbsp;" runat="server" CssClass="lblError" />
                                    </td>
                                    <td colspan="2">
                                        <asp:DropDownList ID="et_ddPretenders" Width="100%" runat="server" 
                                            DataValueField="NLS" DataTextField="NMS" OnInit="et_ddPretenders_Init" 
                                            AutoPostBack="true" OnSelectedIndexChanged="Pretenders_SelectedIndexChanged"/>
                                    </td>
                                    <td colspan="2"></td>
                                </tr>
                            </table>
                        </EditItemTemplate>
                        <EmptyDataTemplate>
                            <asp:LinkButton ID="NewButton" runat="server" CausesValidation="False" CommandName="New"
                                Text="Створити">
                            </asp:LinkButton>
                        </EmptyDataTemplate>
                    </asp:FormView>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <Bars:BarsGridViewEx Width="100%" ID="gvDocumentsList" runat="server" CssClass="barsGridView"
                        AutoGenerateColumns="False" DataSourceID="dsDocumentsList" DataKeyNames="ID"
                        AllowPaging="True" AllowSorting="True" OnRowCommand="gvDocumentsList_RowCommand">
                        <Columns>
                            <asp:CommandField SelectText="Вибрати" ShowSelectButton="True">
                                <ItemStyle Width="7%" />
                            </asp:CommandField>
                            <asp:BoundField DataField="ID" HeaderText="№<BR>п/п" HtmlEncode="false">
                                <ItemStyle Width="7%" HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="ND" HeaderText="Номер<BR>меморіального<BR>ордера" HtmlEncode="false" >
                                <ItemStyle Width="7%" />
                            </asp:BoundField>
                            <asp:BoundField DataField="NLSB_ALT" HeaderText="Рахунок<BR>отримувача<BR>(АСВО)"
                                HtmlEncode="false">
                                <ItemStyle Width="7%" />
                            </asp:BoundField>
                            <asp:BoundField DataField="NLSB" HeaderText="Рахунок<BR>отримувача<BR>(реальний)"
                                HtmlEncode="false">
                                <ItemStyle Width="12%" />
                            </asp:BoundField>
                            <asp:BoundField DataField="NMSB" HeaderText="ПІБ<BR>отримувача" HtmlEncode="false">
                                <ItemStyle Width="20%" />
                            </asp:BoundField>
                            <asp:BoundField DataField="S" HeaderText="Сума" DataFormatString="{0:### ### ##0.00}">
                                <ItemStyle Width="10%" HorizontalAlign="Right" />
                            </asp:BoundField>
                            <asp:BoundField DataField="NAZN" HeaderText="Призначення платежу" HtmlEncode="false">
                                <ItemStyle Width="30%" />
                            </asp:BoundField>
                        </Columns>
                        <PagerSettings PageButtonCount="10" />
                    </Bars:BarsGridViewEx>
                    <Bars:BarsSqlDataSourceEx ID="dsDocumentsList" runat="server" ProviderName="barsroot.core">
                    </Bars:BarsSqlDataSourceEx>
                    <Bars:BarsSqlDataSourceEx ID="dsDocument" runat="server" ProviderName="barsroot.core"
                        SelectCommand="select id, nlsb_alt, nlsb, nmsb, (s/100) s from PAY_PFU where ID = :id"
                        UpdateCommand="update PAY_PFU set nd = :nd, nlsb_alt = :nlsb_alt, nlsb = :nlsb, nmsb = :nmsb, s = :s, nazn = :nazn where ID = :id"
                        InsertCommand="insert into PAY_PFU (nd, nlsa, nmsa, nlsb_alt, nlsb, nmsb, s, nazn, sk_zb) values(:nd, :nlsa, :nmsa, :nlsb_alt, :nlsb, :nmsb, :s, :nazn, :sk_zb)" >
                        <SelectParameters>
                            <asp:ControlParameter ControlID="gvDocumentsList" Name="id" PropertyName="SelectedValue" />
                        </SelectParameters>
                        <InsertParameters>
                            <asp:ControlParameter Name="nd" ControlID="tbWarrantNumber" PropertyName="Text" />
                            <asp:ControlParameter Name="nlsa" ControlID="tbAccountNumber" PropertyName="Text" />
                            <asp:ControlParameter Name="nmsa" ControlID="tbAccountName" PropertyName="Text" />
                            <asp:Parameter Name="nlsb_alt" Type="String" />
                            <asp:Parameter Name="nlsb" Type="String" />
                            <asp:Parameter Name="nmsb" Type="String" />
                            <asp:Parameter Name="s" Type="Decimal" />
                            <asp:Parameter Name="nazn" Type="String" />
                            <asp:ControlParameter Name="sk_zb" ControlID="tbSymbol" PropertyName="Text" />
                        </InsertParameters>
                        <UpdateParameters>
                            <asp:ControlParameter Name="nd" ControlID="tbWarrantNumber" PropertyName="Text" />
                            <asp:Parameter Name="nlsb_alt" Type="String" />
                            <asp:Parameter Name="nlsb" Type="String" />
                            <asp:Parameter Name="nmsb" Type="String" />
                            <asp:Parameter Name="s" Type="Decimal" />
                            <asp:Parameter Name="nazn" Type="String" />
                            <asp:Parameter Name="id" Type="Decimal" />
                        </UpdateParameters>
                        <DeleteParameters>
                            <asp:Parameter Name="id" Type="Decimal" />
                        </DeleteParameters>
                    </Bars:BarsSqlDataSourceEx>
                </td>
            </tr>
            <tr>
                <td>
                </td>
                <td align="right" style="white-space: nowrap">
                    <asp:Label ID="lbTotal" Text="Всього: &nbsp;" runat="server" CssClass="InfoLabel" />
                    <asp:TextBox ID="tbDocsCount" Style="text-align: center" runat="server" Width="60px"
                        ReadOnly="True" ToolTip="Кількість документів" />
                    <asp:TextBox ID="tbDocsSum" Style="text-align: center" runat="server" Width="100px"
                        ReadOnly="True" ToolTip="Загальна сума документів" />
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td style="width: 50%">
                </td>
                <td style="width: 50%" align="right">
                    <asp:Button ID="btnPay" runat="server" Text="Оплатити" CssClass="AcceptButton" 
                        onclick="btnPay_Click" />
                    &nbsp;
                </td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>
