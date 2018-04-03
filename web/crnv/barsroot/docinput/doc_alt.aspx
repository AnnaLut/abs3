<%@ Page Language="C#" AutoEventWireup="true" CodeFile="doc_alt.aspx.cs" Inherits="docinput_doc_alt" %>

<%@ Register Assembly="Bars.Web.Controls" Namespace="Bars.Web.Controls" TagPrefix="cc1" %>

<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="Bars" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Зарахування по альтернативних рахунках (АСВО)</title>
    <link href="Styles.css" type="text/css" rel="stylesheet"/>
	<link href="/Common/css/barsgridview.css" type="text/css" rel="stylesheet"/>
    <style type="text/css">
        .barsGridView td 
        {
	        white-space:normal !important;
        }
    </style>	
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <table style="width:100%;">
            <tr>
                <td colspan="4">
                    <input id="btPay" class="AcceptButton" type="button" runat="server" onserverclick="btPay_Click" 
                        value="Оплатити" />
                </td>
            </tr>
            <tr>
                <td colspan="4">
                    <Bars:BarsGridViewEx Width="100%" ID="gvAltDocs" runat="server" CssClass="barsGridView" 
                            AutoGenerateColumns="False" DataSourceID="dsDocAltList" DataKeyNames="ID" 
                            AllowPaging="True" AllowSorting="True" OnRowCommand="gvAltDocs_RowCommand" 
                            OnRowDataBound="gvAltDocs_RowDataBound">
                        <Columns>
                            <asp:CommandField SelectText="Вибрати" ShowSelectButton="True" >
                                <ItemStyle Width="5%" />
                            </asp:CommandField>
                            <asp:BoundField DataField="ID" HeaderText="№" SortExpression="ID" >
                                <ItemStyle Width="5%" />
                            </asp:BoundField>
                            <asp:BoundField DataField="ND" HeaderText="Номер мем. ордера" SortExpression="ND" >
                                <ItemStyle Width="5%" />
                            </asp:BoundField>                            
                            <asp:BoundField DataField="NLSA" HeaderText="Реальний рахунок ДЕБЕТ" SortExpression="NLSA" >
                                <ItemStyle Width="10%" />
                            </asp:BoundField>                            
                            <asp:BoundField DataField="NLSB_ALT" HeaderText="Рахунок (АСВО) КРЕДИТ" SortExpression="NLSB_ALT" >
                                <ItemStyle Width="10%" />
                            </asp:BoundField>
                            <asp:BoundField DataField="S" HeaderText="Сума" SortExpression="S" >
                                <ItemStyle HorizontalAlign="Right" Width="5%" />
                            </asp:BoundField>
                            <asp:BoundField DataField="NMSB" HeaderText="ПІБ по КРЕДИТУ" SortExpression="NMSB" >
                                <ItemStyle Width="10%" />
                            </asp:BoundField>
                            <asp:BoundField DataField="NAZN" HeaderText="Призначення платежу" SortExpression="NAZN" >
                                <ItemStyle Width="10%" />
                            </asp:BoundField>
                            <asp:BoundField DataField="NMSA" HeaderText="Назва по ДЕБЕТУ" SortExpression="NMSA" >
                                <ItemStyle Width="10%" />
                            </asp:BoundField>
                            <asp:BoundField DataField="NLSB" HeaderText="Реальний рахунок КРЕДИТ" SortExpression="NLSB" >
                                <ItemStyle Width="10%" />
                            </asp:BoundField>
                            <asp:BoundField DataField="SK_ZB" HeaderText="Поза- балансовий символ" SortExpression="SK_ZB" >
                                <ItemStyle Width="5%" />
                            </asp:BoundField>                            
                            <asp:BoundField DataField="NLS6" HeaderText="Рахунок комісії" SortExpression="NLS6" >
                                <ItemStyle Width="10%" />
                            </asp:BoundField>                            
                            <asp:BoundField DataField="IR" HeaderText="Ознака комісії" SortExpression="IR" >
                                <ItemStyle Width="5%" />
                            </asp:BoundField>                            
                        </Columns>
                        <PagerSettings PageButtonCount="10" />
                    </Bars:BarsGridViewEx>
                </td>
            </tr>
            <tr>
                <td colspan="4">
                </td>
            </tr>
            <tr>
                <td colspan="4">
                    <asp:FormView ID="fvDocAlt" runat="server" DataSourceID="dsDocAlt" 
                        DefaultMode="Insert" OnItemInserted="fvDocAlt_ItemInserted" 
                        OnItemDeleted="fvDocAlt_ItemDeleted" OnItemDeleting="fvDocAlt_ItemDeleting" 
                        OnItemUpdated="fvDocAlt_ItemUpdated" Width="100%" 
                        onitemcommand="fvDocAlt_ItemCommand">
                    <InsertItemTemplate>
                        <table class="MainTable">
                            <tr>
                                <td style="width:10%">
                                    <asp:Label ID="it_lbNumber" runat="server" Text="№"></asp:Label>
                                </td>
                                <td style="width:5%">
                                    <asp:Label ID="it_Label3" runat="server" Text="Номер мем. ордера"></asp:Label>
                                </td>
                                <td style="width:10%">
                                    <asp:Label ID="it_lbRealDebitNls" runat="server" Text="Реальний рахунок ДЕБЕТ"></asp:Label>
                                </td>
                                <td style="width:10%">
                                    <asp:Label ID="it_lbAsvoCreditNls" runat="server" Text="Рахунок (АСВО) КРЕДИТ"></asp:Label>
                                </td>
                                <td style="width:5%">
                                    <asp:Label ID="it_lbSum" runat="server" Text="Сума"></asp:Label>
                                </td>
                                <td style="width:10%">
                                    <asp:Label ID="it_lbCreditName" runat="server" Text="ПІБ по КРЕДИТУ"></asp:Label>
                                </td>
                                <td style="width:10%">
                                    <asp:Label ID="it_lbPaymentDetails" runat="server" Text="Призначення платежу"></asp:Label>
                                </td>
                                <td style="width:10%">
                                    <asp:Label ID="it_lbDebitName" runat="server" Text="Назва по ДЕБЕТУ"></asp:Label>
                                </td>
                                <td style="width:10%">
                                    <asp:Label ID="it_lbRealCreditNls" runat="server" Text="Реальний рахунок КРЕДИТ"></asp:Label>
                                </td>
                                <td style="width:5%">
                                    <asp:Label ID="it_lbSk_zb" runat="server" Text="Поза- балансовий символ"></asp:Label>
                                </td>
                                <td style="width:10%">
                                    <asp:Label ID="it_Label1" runat="server" Text="Рахунок комісії"></asp:Label>
                                </td>
                                <td style="width:5%">
                                    <asp:Label ID="it_Label2" runat="server" Text="Ознака комісії"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:TextBox ID="it_Number" Width="95%" Text='<%# Bind("ID") %>' ReadOnly="true" runat="server"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:TextBox ID="it_ND" Width="95%" Text='<%# Bind("ND") %>' runat="server"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:TextBox ID="it_RealDebitNls" Width="95%" Text='<%# Bind("NLSA") %>' runat="server"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:TextBox ID="it_AsvoCreditNls" Width="95%" Text='<%# Bind("NLSB_ALT") %>'  runat="server"></asp:TextBox>
                                </td>
                                <td>
                                    <cc1:NumericEdit ID="it_Sum" Width="95%" Value='<%# Bind("S") %>'  runat="server"></cc1:NumericEdit>
                                </td>
                                <td>
                                    <asp:TextBox ID="it_CreditName" Width="95%" Text='<%# Bind("NMSB") %>' ReadOnly="true"  runat="server"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:TextBox ID="it_PaymentsDetails" Width="95%" Text='<%# Bind("NAZN") %>'  runat="server"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:TextBox ID="it_DebitName" Width="95%" Text='<%# Bind("NMSA") %>' ReadOnly="true"  runat="server"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:TextBox ID="it_RealCreditNls" Width="95%" Text='<%# Bind("NLSB") %>' runat="server"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:TextBox ID="it_Sk_zb" Width="95%" Text='<%# Bind("SK_ZB") %>' runat="server"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:TextBox ID="it_NLS6" Width="95%" Text='<%# Bind("NLS6") %>' runat="server"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:TextBox ID="it_IR" Width="95%" Text='<%# Bind("IR") %>' runat="server"></asp:TextBox>
                                </td>                                                                
                            </tr>
                            <tr>
                                <td colspan="4">
                                </td>
                                <td>
                                </td>
                                <td>
                                </td>
                                <td>
                                </td>
                                <td>
                                </td>
                                <td>
                                </td>
                                <td>
                                </td>
                                <td>
                                <td>
                                </td>
                                <td>
                                </td>
                            </tr>                            
                            <tr>
                                <td colspan="9">
                                    <asp:LinkButton ID="it_InsertButton" runat="server" CausesValidation="True" CommandName="Insert"
                                        Text="Додати">
                                    </asp:LinkButton>
                                </td>
                            </tr>
                        </table>
                    </InsertItemTemplate>
                    <EditItemTemplate>
                        <table class="MainTable">
                            <tr>
                                <td style="width:10%">
                                    <asp:Label ID="et_lbNumber" runat="server" Text="№"></asp:Label>
                                </td>
                                <td style="width:5%">
                                    <asp:Label ID="et_Label3" runat="server" Text="Номер мем. ордера"></asp:Label>
                                </td>
                                <td style="width:10%">
                                    <asp:Label ID="et_lbRealDebitNls" runat="server" Text="Реальний рахунок ДЕБЕТ"></asp:Label>
                                </td>
                                <td style="width:10%">
                                    <asp:Label ID="et_lbAsvoCreditNls" runat="server" Text="Рахунок (АСВО) КРЕДИТ"></asp:Label>
                                </td>
                                <td style="width:5%">
                                    <asp:Label ID="et_lbSum" runat="server" Text="Сума"></asp:Label>
                                </td>
                                <td style="width:10%">
                                    <asp:Label ID="et_lbCreditName" runat="server" Text="ПІБ по КРЕДИТУ"></asp:Label>
                                </td>
                                <td style="width:10%">
                                    <asp:Label ID="et_lbPaymentDetails" runat="server" Text="Призначення платежу"></asp:Label>
                                </td>
                                <td style="width:10%">
                                    <asp:Label ID="et_lbDebitName" runat="server" Text="Назва по ДЕБЕТУ"></asp:Label>
                                </td>
                                <td style="width:10%">
                                    <asp:Label ID="et_lbRealCreditNls" runat="server" Text="Реальний рахунок КРЕДИТ"></asp:Label>
                                </td>
                                <td style="width:5%">
                                    <asp:Label ID="et_lbSk_zb" runat="server" Text="Поза- балансовий символ"></asp:Label>
                                </td>            
                                <td style="width:10%">
                                    <asp:Label ID="et_Label1" runat="server" Text="Рахунок комісії"></asp:Label>
                                </td>
                                <td style="width:5%">
                                    <asp:Label ID="et_Label2" runat="server" Text="Ознака комісії"></asp:Label>
                                </td>                                                    
                            </tr>
                            <tr>
                                <td>
                                    <asp:TextBox ID="et_Number" Text='<%# Bind("ID") %>' Width="95%" ReadOnly="true" runat="server"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:TextBox ID="et_ND" Width="95%" Text='<%# Bind("ND") %>' runat="server"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:TextBox ID="et_RealDebitNls"  Width="95%" Text='<%# Bind("NLSA") %>' runat="server"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:TextBox ID="et_AsvoCreditNls" Width="95%" Text='<%# Bind("NLSB_ALT") %>'  runat="server"></asp:TextBox>
                                </td>
                                <td>
                                    <cc1:NumericEdit ID="et_Sum" Width="95%" Value='<%# Bind("S") %>' runat="server"></cc1:NumericEdit>
                                </td>
                                <td>
                                    <asp:TextBox ID="et_CreditName" Width="95%" Text='<%# Bind("NMSB") %>' ReadOnly="true"  runat="server"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:TextBox ID="et_PaymentsDetails" Width="95%" Text='<%# Bind("NAZN") %>'  runat="server"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:TextBox ID="et_DebitName" Width="95%" Text='<%# Bind("NMSA") %>' ReadOnly="true"  runat="server"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:TextBox ID="et_RealCreditNls" Width="95%" Text='<%# Bind("NLSB") %>' runat="server"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:TextBox ID="et_Sk_zb" Width="95%" Text='<%# Bind("SK_ZB") %>' runat="server"></asp:TextBox>
                                </td>        
                                <td>
                                    <asp:TextBox ID="et_NLS6" Width="95%" Text='<%# Bind("NLS6") %>' runat="server"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:TextBox ID="et_IR" Width="95%" Text='<%# Bind("IR") %>' runat="server"></asp:TextBox>
                                </td>                                                                                                                        
                            </tr>
                            <tr>
                                <td colspan="4">
                                    <asp:DropDownList ID="et_ddPretenders" Width="95%" runat="server" 
                                        DataTextField="TEXT" DataValueField="ACC" DataSourceID="et_dsPretenders" 
                                        EnableViewState="False">
                                    </asp:DropDownList>                                    
                                </td>
                                <td>
                                </td>
                                <td>
                                </td>
                                <td>
                                </td>
                                <td>
                                </td>
                                <td>
                                </td>
                                <td>
                                    <Bars:BarsSqlDataSourceEx ID="et_dsPretenders" ProviderName="barsroot.core" runat="server"
                                        SelectCommand="select a.nls || ' ' || c.nmk as text, a.acc acc from accounts a, customer c where a.rnk = c.rnk and a.acc in (select column_value from table(select split(cep_acc)  from vpay_alt where id = :ID))" 
                                        OnDataBinding="et_dsPretenders_DataBinding" OnInit="et_dsPretenders_Init">
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="gvAltDocs" Name="ID" PropertyName="SelectedValue" />
                                        </SelectParameters>                                                                                                                                
                                    </Bars:BarsSqlDataSourceEx>
                                </td>
                                <td>
                                    <input type="hidden" runat="server" value = '<%# Bind("ID") %>' id="et_hACCS" /></td>
                                <td>
                                </td>
                                <td>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="10">
                                    <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update"
                                        Text="Зберегти">
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="DeleteButton" runat="server" CausesValidation="False" CommandName="Delete"
                                        Text="Видалити">                                        
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel"
                                        Text="Відмінити">
                                    </asp:LinkButton>                                    
                                </td>
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
                <td style="width:25%">                    
                </td>
                <td style="width:10%">
                    <asp:TextBox ID="textCount" style="text-align:right" runat="server" ReadOnly="True" Width="95%" ToolTip="Загальна кількість"></asp:TextBox></td>
                <td style="width:5%">
                    <asp:TextBox ID="textSum" style="text-align:right" runat="server" ReadOnly="True" Width="95%" ToolTip="Загальна сума"></asp:TextBox></td>
                <td style="width:55%">                    
                </td>    
            </tr>                                    
            <tr>
                <td colspan="4">
                    <Bars:BarsSqlDataSourceEx ID="dsDocAlt" runat="server" ProviderName="barsroot.core"
                        SelectCommand="select id, nlsa, nlsb_alt, nvl(s,0) s, nmsb, nazn, nmsa, nlsb, sk_zb, nls6, ir, nd, CEP_ACC from vpay_alt where id = :id" 
                        UpdateCommand="update vpay_alt set nd = :nd, nlsa = :nlsa, nlsb_alt = :nlsb_alt, s = :s, nmsb = decode (:acc,null,:nmsb,(select c.nmk from accounts a, customer c where a.acc = :acc and a.rnk = c.rnk)), nazn = decode (:acc,null,:nazn,null), nmsa  = :nmsa, nlsb  = decode (:acc,null,:nlsb,(select nls from accounts where acc = :acc)), sk_zb = :sk_zb, nls6 = :nls6, ir = :ir where id = :id" 
                        InsertCommand="insert into vpay_alt(id, nd, nlsa, nlsb_alt, s, nmsb, nazn, nmsa, nlsb, sk_zb, nls6, ir) values(:id, :nd, :nlsa, :nlsb_alt, :s, :nmsb, :nazn, :nmsa, :nlsb, :sk_zb, :nls6, :ir)" 
                        DeleteCommand="delete from">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="gvAltDocs" Name="ID" PropertyName="SelectedValue" />
                        </SelectParameters>
                        <UpdateParameters>                            
                            <asp:Parameter Name="nd" Type="String" />                            
                            <asp:Parameter Name="nlsa" Type="String" />
                            <asp:Parameter Name="nlsb_alt" Type="String" />
                            <asp:Parameter Name="s" Type="Decimal" />
                            <asp:ControlParameter ControlID="fvDocAlt$et_ddPretenders" Name="acc" PropertyName="SelectedValue" />
                            <asp:Parameter Name="nmsb" Type="String" />
                            <asp:ControlParameter ControlID="fvDocAlt$et_ddPretenders" Name="acc" PropertyName="SelectedValue" />
                            <asp:ControlParameter ControlID="fvDocAlt$et_ddPretenders" Name="acc" PropertyName="SelectedValue" />
                            <asp:Parameter Name="nazn" Type="String" />
                            <asp:Parameter Name="nmsa" Type="String" />
                            <asp:ControlParameter ControlID="fvDocAlt$et_ddPretenders" Name="acc" PropertyName="SelectedValue" />
                            <asp:Parameter Name="nlsb" Type="String" />
                            <asp:ControlParameter ControlID="fvDocAlt$et_ddPretenders" Name="acc" PropertyName="SelectedValue" />                            
                            <asp:Parameter Name="sk_zb" Type="Decimal" />
                            <asp:Parameter Name="nls6" Type="String" />
                            <asp:Parameter Name="ir" Type="Decimal" />
                            <asp:Parameter Name="id" Type="Decimal" />
                        </UpdateParameters>
                    </Bars:BarsSqlDataSourceEx>                
                    <Bars:BarsSqlDataSourceEx ID="dsDocAltList" runat="server" ProviderName="barsroot.core"  
                        SelectCommand="select id, sos, nlsa, nlsb_alt, replace(to_char(s ,'999,999,999,999,990.99'),',',' ') s, nmsb, nazn, nmsa, nlsb, sk_zb, nls6, ir, nd, cep_acc from vpay_alt order by id">
                    </Bars:BarsSqlDataSourceEx>
                </td>                
            </tr>
        </table>
    </div>
    </form>
</body>
</html>
