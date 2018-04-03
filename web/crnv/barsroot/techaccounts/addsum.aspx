<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AddSum.aspx.cs" Inherits="AddSum" %>

<%@ Register Assembly="Bars.DataComponents, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c"
    Namespace="Bars.DataComponents" TagPrefix="Bars" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Поповнення технічного рахунку</title>
    <link href="style/style.css" type="text/css" rel="stylesheet" />
    <script language="javascript" type="text/javascript" src="script/JScript.js"></script>                
    <script language="JavaScript" type="text/javascript" src="/Common/WebEdit/NumericEdit.js"></script>	        
</head>
<body>
    <form id="form1" runat="server">
        <table class="MainTable">
            <tr>
                <td colspan="3" align="center" style="height: 25px">
                    <asp:Label ID="lbTitle" runat="server" Text="Поповнення технічного рахунку %" CssClass="InfoHeader"></asp:Label>
                </td>
            </tr>
            <tr>
                <td colspan="3">
                    <Bars:barssqldatasource ProviderName="barsroot.core" ID="dsTechAccCredit" runat="server">
                    </Bars:barssqldatasource>
                </td>
            </tr>
            <tr>
                <td colspan="3">
                <table class="InnerTable">
                    <tr>
                        <td style="width: 30%">
                            <asp:Label ID="lbClient" runat="server" CssClass="InfoText" Text="Клієнт"></asp:Label></td>
                        <td style="width: 40%">
                            <asp:TextBox ID="textNMK" runat="server" CssClass="InfoText" ReadOnly="True" ToolTip="ПІБ клієнта" TabIndex="5"></asp:TextBox></td>
                        <td style="width: 10%">
                            <asp:TextBox ID="textRNK" runat="server" CssClass="InfoText" ReadOnly="True" ToolTip="Реєстраційний номер клієнта" TabIndex="6"></asp:TextBox></td>
                        <td style="width: 20%">
                            <asp:TextBox ID="textOKPO" runat="server" CssClass="InfoText" ReadOnly="True" ToolTip="Ідентифікаційний код клієнта" TabIndex="7"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lbDptId" runat="server" CssClass="InfoText" Text="Депозит"></asp:Label></td>
                        <td>
                            <asp:TextBox ID="textDPT_ID" runat="server" CssClass="InfoText" ReadOnly="True" ToolTip="№ депозитного договору" TabIndex="8"></asp:TextBox></td>
                        <td>
                        </td>
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lbNLS" runat="server" Text="Технічний рахунок" CssClass="InfoText"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="textNLS" runat="server" CssClass="InfoText" ReadOnly="True" ToolTip="Рахунок" TabIndex="9"></asp:TextBox>
                        </td>
                        <td>
                            <asp:TextBox ID="textKV" runat="server" CssClass="InfoText" ReadOnly="True" ToolTip="Валюта" TabIndex="10"></asp:TextBox>
                        </td>
                        <td>
                            <asp:TextBox ID="textSUM" runat="server" CssClass="InfoText" ReadOnly="True" ToolTip="Залишок" TabIndex="11"></asp:TextBox>
                        </td>                                                                        
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lbDat" runat="server" CssClass="InfoText" Text="Дата відкриття рахунку"></asp:Label></td>
                        <td>
                            <asp:TextBox ID="textDAT" runat="server" ReadOnly="true" CssClass="InfoText" TabIndex="12"></asp:TextBox></td>
                        <td>
                        </td>
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4">
                            <table id="SumTable" runat="server" class="InnerTable">
                                <tr>
                                    <td style="width: 30%;">
                                        <asp:Label ID="lbSum" runat="server" CssClass="InfoText" Text="Сума"></asp:Label></td>
                                    <td style="width: 40%;">
                                        <asp:TextBox ID="Sum" runat="server" TabIndex="1" style="text-align: right" MaxLength="12" CssClass="DateSum"></asp:TextBox>
                                        <script type="text/javascript" language="javascript">
                                            init_numedit("Sum",(""==document.getElementById("Sum").value)?(0):(document.getElementById("Sum").value),2);                                
                                        </script>
                                    </td>
                                    <td style="width: 10%;"></td>
                                    <td style="width: 20%;"></td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
                </td>
            </tr>
            <tr>
                <td colspan="3">
                    <Bars:BarsGridView ID="gridTechAccCredit" runat="server" CssClass="BaseGrid" DataSourceID="dsTechAccCredit" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DateMask="dd/MM/yyyy" OnRowDataBound="gridTechAccCredit_RowDataBound" TabIndex="4">
                        <PagerSettings PageButtonCount="5" />
                        <Columns>
                            <asp:BoundField DataField="REF" HeaderText="*" HtmlEncode="False" SortExpression="REF">
                                <itemstyle horizontalalign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="DREF" HeaderText="Референс" HtmlEncode="False" SortExpression="DREF" />
                            <asp:BoundField DataField="NLS" HeaderText="Номер рахунку" HtmlEncode="False" SortExpression="NLS">
                                <itemstyle horizontalalign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="SUM" HeaderText="Сума" HtmlEncode="False" SortExpression="SUM" DataFormatString="{0:### ### ### ##0.00}">
                                <itemstyle horizontalalign="Right" />
                            </asp:BoundField>
                            <asp:BoundField DataField="LCV" HeaderText="Валюта" HtmlEncode="False" SortExpression="LCV">
                                <itemstyle horizontalalign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="DAT" HeaderText="Дата" HtmlEncode="False" SortExpression="DAT">
                                <itemstyle horizontalalign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="NAZN" HeaderText="Призначення" HtmlEncode="False" SortExpression="NAZN">
                                <itemstyle horizontalalign="Left" />
                            </asp:BoundField>
                        </Columns>
                    </Bars:BarsGridView>
                </td>
            </tr>
            <tr>
                <td style="width:30%">
                    <input id="btAddPayment" type="button" value="Поповнити" 
                        class="AcceptButton" runat="server" onclick="if (ckSum4Add())AddPayment()" tabindex="2"/>
                </td>
                <td style="width:30%">
                </td>
                <td style="width:40%">
                </td>
            </tr>       
            <tr>
                <td>
                    <input id="btCommission" type="button" value="Комісія" class="AcceptButton" 
                        runat="server" onclick="TakeAddCommission()" disabled="disabled" tabindex="3" />
                </td>
                <td><input id="REF" runat="server" type="hidden" /></td>
                <td>
                </td>
            </tr>
            <tr>
                <td>
                    <input id="PASP" runat="server" type="hidden" /><input id="NMK" runat="server" type="hidden" />
                    <input id="PASPN" runat="server" type="hidden" /><input id="ATRT" runat="server" type="hidden" />                    
                    <input id="ADRES" runat="server" type="hidden" /><input id="DT_R" runat="server" type="hidden" />
                    <input id="RNK" runat="server" type="hidden" />
                </td>
                <td>
                    <input id="DPT_ID" runat="server" type="hidden" /><input id="NLS" runat="server" type="hidden" />
                    <input id="LCV" runat="server" type="hidden" /><input id="cash" runat="server" type="hidden" />                
                    <input id="KV" runat="server" type="hidden" /><input id="SMAIN" runat="server" type="hidden" />
                </td>
                <td>
                    <input id="tt" runat="server" type="hidden" /><input id="tt_K_N" runat="server" type="hidden" />
                    <input id="tt_K_F" runat="server" type="hidden" /><input id="tt_K" runat="server" type="hidden" />                    
                    <input id="after_pay_proc" runat="server" type="hidden" /><input id="after_pay_role" runat="server" type="hidden" />
                </td>
            </tr>     
        </table>
    </form>
    <script type="text/javascript">
       var oldonload = window.onload;
       window.onload = function() 
       {
           if (oldonload)   oldonload();
           focusControl('Sum');
       }       
    </script>
</body>
</html>
