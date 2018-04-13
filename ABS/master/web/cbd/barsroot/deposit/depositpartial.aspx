<%@ Page Language="C#" AutoEventWireup="true" CodeFile="depositpartial.aspx.cs" Inherits="deposit_depositpartial" %>

<%@ Register Assembly="Bars.Web.Controls" Namespace="Bars.Web.Controls" TagPrefix="cc1" %>

<%@ Register Assembly="Bars.DataComponents" Namespace="Bars.DataComponents" TagPrefix="Bars" %>
<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="Bars" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
	<title>Депозитний модуль: Розподіл депозиту</title>
	<link href="style/dpt.css" type="text/css" rel="stylesheet"/>
	<link href="/Common/css/barsgridview.css" type="text/css" rel="stylesheet"/>		
	<script type="text/javascript" language="javascript" src="js/js.js?v1.1"></script>
	<script type="text/javascript" language="javascript" src="js/ck.js"></script>
</head>
<body>
    <form id="form1" runat="server">
    <table class="MainTable">
        <tr>
            <td align="center">
                &nbsp;<asp:Label ID="lbTitle" runat="server" CssClass="InfoLabel" meta:resourcekey="lbTitle"
                    Text="Права на спадок  по депозиту № %s" />
            </td>            
        </tr>
        <tr>
            <td>
                <table class="InnerTable">
                    <tr>
                        <td style="width:25%">
                            <asp:Label ID="lbRNK" runat="server" CssClass="InfoText" Text="РНК спадкоємця"></asp:Label></td>
                        <td style="width:75%">
                            <asp:Label ID="lbFIO" runat="server" CssClass="InfoText" Text="ФІО спадкоємця"></asp:Label></td>
                    </tr>
                    <tr>
                        <td>
                            <input id="RNK" runat="server" class="InfoText95" type="text" readonly="readOnly" /></td>
                        <td>
                            <input id="FIO" runat="server" class="InfoText95" type="text" readonly="readOnly" /></td>
                    </tr>
                    <tr>
                        <td>
                            <input id="btRegisterNew" runat="server" class="AcceptButton" size="" type="button"
                                value="Реєструвати" disabled="disabled" tabindex="1" /></td>
                        <td>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td>
            </td>
        </tr>
        <tr>
                <td>
                    <Bars:BarsGridViewEx ID="gridInheritors" runat="server" AutoGenerateColumns="False" DataKeyNames="INHERIT_ID"
                        CssClass="barsGridView" DataSourceID="dsInheritors" DateMask="dd/MM/yyyy" OnRowDataBound="gridInheritors_RowDataBound"
                        OnRowCommand="gridInheritors_RowCommand" AutoGenerateNewButton="false" >
                        <Columns>
                            <asp:CommandField SelectText="Вибрати" ShowSelectButton="True">
                            </asp:CommandField>
                            <asp:BoundField DataField="INHERIT_ID" HeaderText="РНК спадкоємця" />
                            <asp:BoundField DataField="INHERIT_NAME" HeaderText="ПІБ спадкоємця" />
                            <asp:BoundField DataField="INHERIT_SHARE" HeaderText="Частка спадку">
                            </asp:BoundField>
                            <asp:BoundField DataField="INHERIT_DATE" HeaderText="Вступ в права">
                            </asp:BoundField>
                            <asp:BoundField DataField="CERTIF_NUM" HeaderText="№ свідоцтва про права">
                            </asp:BoundField>
                            <asp:BoundField DataField="CERTIF_DATE" HeaderText="Дата свідоцтва про права">
                            </asp:BoundField>
                            <asp:BoundField Visible="false" DataField="ATTR_INCOME" HeaderText="Код ознаки доходу">
                            </asp:BoundField>
                            <asp:BoundField Visible="false" DataField="NAME_INCOME" HeaderText="Ознака доходу">
                            </asp:BoundField>
                            <asp:BoundField Visible="false" DataField="TAX_DATE" HeaderText="Дата д-та сплати податку">
                            </asp:BoundField>
                            <asp:BoundField Visible="false" DataField="TAX_NUMBER" HeaderText="Номер д-та сплати податку">
                            </asp:BoundField>
                        </Columns>
                    </Bars:BarsGridViewEx>
                </td>
        </tr>                
        <tr>
            <td>
                <asp:FormView ID="fvInheritor" runat="server" DataSourceID="dsInheritor" 
                    DefaultMode="Insert" OnItemInserted="fvInheritor_ItemInserted"
                    OnItemUpdated="fvInheritor_ItemUpdated" Width="100%" 
                    onitemcommand="fvInheritor_ItemCommand">
                    <InsertItemTemplate>                
                        <table class="MainTable">
                            <tr>
                                <td style='width:30%'>
                                    <asp:Label ID="lb1" runat="server" Text="РНК спадкоємця"></asp:Label>
                                </td>
                                <td style='width:70%'>
                                    <asp:TextBox ID="INHERIT_ID" Text='<%# Bind("INHERIT_ID") %>' Width="95%" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="Label2" runat="server" Text="Частка спадку"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="INHERIT_SHARE" Text='<%# Bind("INHERIT_SHARE") %>' Width="95%" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="Label3" runat="server" Text="Вступ в права"></asp:Label>
                                </td>
                                <td>
                                    <cc1:DateEdit ID="INHERIT_DATE" Text='<%# Bind("INHERIT_DATE") %>' Width="200" runat="server"></cc1:DateEdit>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="Label4" runat="server" Text="№ свідоцтва про права"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="CERTIF_NUM" Text='<%# Bind("CERTIF_NUM") %>' Width="95%" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="Label5" runat="server" Text="Дата свідоцтва про права"></asp:Label>
                                </td>
                                <td>
                                    <cc1:DateEdit ID="CERTIF_DATE" Text='<%# Bind("CERTIF_DATE") %>' Width="200" runat="server"></cc1:DateEdit>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
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
                                <td style='width:30%'>
                                    <asp:Label ID="lb1" runat="server" Text="РНК спадкоємця"></asp:Label>
                                </td>
                                <td style='width:70%'>
                                    <asp:TextBox ID="INHERIT_ID" Text='<%# Bind("INHERIT_ID") %>' Width="95%" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="Label2" runat="server" Text="Частка спадку"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="INHERIT_SHARE" Text='<%# Bind("INHERIT_SHARE") %>' Width="95%" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="Label3" runat="server" Text="Вступ в права"></asp:Label>
                                </td>
                                <td>
                                    <cc1:DateEdit ID="INHERIT_DATE" Text='<%# Bind("INHERIT_DATE") %>' Width="200" runat="server"></cc1:DateEdit>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="Label4" runat="server" Text="№ свідоцтва про права"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="CERTIF_NUM" Text='<%# Bind("CERTIF_NUM") %>' Width="95%" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="Label5" runat="server" Text="Дата свідоцтва про права"></asp:Label>
                                </td>
                                <td>
                                    <cc1:DateEdit ID="CERTIF_DATE" Text='<%# Bind("CERTIF_DATE") %>' Width="200" runat="server"></cc1:DateEdit>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update"
                                        Text="Зберегти">
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
            <td>
                <input id="btFinish" runat="server" class="AcceptButton" size="" type="button"
                    value="Активувати" onserverclick="btFinish_ServerClick" disabled="disabled" tabindex="2" /></td>
        </tr>
        <tr>
            <td align="center">
            </td>
        </tr>
        <tr>
            <td>
                <table class="InnerTable">
                    <tr>
                        <td style="width:30%"><input id="btPercent" runat="server" class="AcceptButton" size="" type="button"
                                value="Виплата відсотків" onclick="InheritPercent()" disabled="disabled" tabindex="3" /></td>
                        <td style="width:30%"><input id="btReturn" runat="server" class="AcceptButton" size="" type="button"
                                value="Виплата по завершенні" onclick="InheritReturn()" disabled="disabled" tabindex="4" /></td>
                        <td style="width:40%">
                            <input id="btClose" runat="server" class="AcceptButton" size="" type="button"
                                value="Дострокове розторгнення" onclick="InheritClose()" disabled="disabled" tabindex="5" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td>
                <Bars:barssqldatasource ProviderName="barsroot.core" ID="dsInheritors" runat="server"
                    SelectCommand="select INHERIT_ID, INHERIT_NAME, INHERIT_SHARE, INHERIT_DATE, CERTIF_NUM, CERTIF_DATE from v_dpt_inheritors h where h.dpt_id = :DPT_ID ">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="dpt_id" Name="DPT_ID" PropertyName="Value" />
                    </SelectParameters>
                </Bars:barssqldatasource>
                <Bars:BarsSqlDataSourceEx ID="dsInheritor" runat="server" ProviderName="barsroot.core"
                    SelectCommand="select INHERIT_ID, INHERIT_NAME, INHERIT_SHARE, INHERIT_DATE, CERTIF_NUM, CERTIF_DATE from v_dpt_inheritors h where h.dpt_id = :DPT_ID and h.INHERIT_ID = :INHERIT_ID" 
                    InsertCommand="begin dpt_web.inherit_registration(:DPT_ID,:INHERIT_ID,:INHERIT_SHARE,:INHERIT_DATE,:CERTIF_NUM,:CERTIF_DATE); end;" 
                    UpdateCommand="begin dpt_web.inherit_registration(:DPT_ID,:INHERIT_ID,:INHERIT_SHARE,:INHERIT_DATE,:CERTIF_NUM,:CERTIF_DATE); end;" 
                    >
                    <SelectParameters>
                        <asp:ControlParameter ControlID="dpt_id" Name="DPT_ID" PropertyName="Value" />
                        <asp:ControlParameter ControlID="gridInheritors" Name="INHERIT_ID" PropertyName="SelectedValue" />
                    </SelectParameters>
                    <UpdateParameters>                            
                        <asp:ControlParameter ControlID="dpt_id" Name="DPT_ID" PropertyName="Value" />
                        <asp:Parameter Name="INHERIT_ID" Type="Decimal" />
                        <asp:Parameter Name="INHERIT_SHARE" Type="Decimal" />
                        <asp:Parameter Name="INHERIT_DATE" Type="DateTime" />
                        <asp:Parameter Name="CERTIF_NUM" Type="String" />
                        <asp:Parameter Name="CERTIF_DATE" Type="DateTime" />
                    </UpdateParameters>
                    <InsertParameters>                            
                        <asp:ControlParameter ControlID="dpt_id" Name="DPT_ID" PropertyName="Value" />
                        <asp:Parameter Name="INHERIT_ID" Type="Decimal" />
                        <asp:Parameter Name="INHERIT_SHARE" Type="Decimal" />
                        <asp:Parameter Name="INHERIT_DATE" Type="DateTime" />
                        <asp:Parameter Name="CERTIF_NUM" Type="String" />
                        <asp:Parameter Name="CERTIF_DATE" Type="DateTime" />
                    </InsertParameters>
                </Bars:BarsSqlDataSourceEx> 
            </td>
        </tr>
        <tr>
            <td>
                <input type="hidden"  runat="server" id="hidRNK" />
                <input type="hidden"  runat="server" id="hidFIO" />
                <input type="hidden"  runat="server" id="inherit_id" />                
                <input type="hidden"  runat="server" id="dpt_id" />                
                <input type="hidden"  runat="server" id="TT_R" />                
                <input type="hidden"  runat="server" id="TT_P" />                
                <input type="hidden"  runat="server" id="TT_C" />                
            </td>
        </tr>        
    </table>
    </form>
</body>
</html>
