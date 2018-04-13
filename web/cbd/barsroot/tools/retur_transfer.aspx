<%@ Page Language="C#" AutoEventWireup="true" CodeFile="retur_transfer.aspx.cs" Inherits="tools_retur_transfer" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Анулювання грошового переказу</title>
    <style type="text/css">
        .style1
        {
            width: 120Px;
            height: 27px;
        }
        .style2
        {
            height: 27px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server" style="width: 800px">
    <%--  <asp:Label runat="server" ID="l_title" Text="Анулювання грошового переказу"></asp:Label>--%>
    <%--    <br />
    <br />--%>
    <div style="width: 800px">
        <asp:Panel ID="Pn_1" runat="server" Width="800Px" GroupingText="Відміна виплати системного переказу"
            BackColor="#E1E8F0">
            <table style="width: 100%">
                <tr>
                    <td style="width: 20%">
                        <asp:Label runat="server" ID="l_ref" Text="Референс" ToolTip="Референс виплаченого переказу"
                            Enabled="False"></asp:Label>
                    </td>
                    <td style="width: 50%">
                        <asp:TextBox runat="server" ID="Tb_Ref" ToolTip="Референс виплаченого переказу"></asp:TextBox>
                        <asp:ImageButton runat="server" ID="Bt_Search" ImageUrl="/Common\Images\default\16\refresh.png"
                            ToolTip="Пошук виплаченого грошового переказу" BorderStyle="Double" CausesValidation="true"
                            OnClick="Bt_Search_Click" />
                        <asp:RegularExpressionValidator runat="server" ID="Tb_Ref_valid" Display="Dynamic"
                            ControlToValidate="Tb_Ref" ValidationExpression=">(^(\ |\-)(0|([1-9][0-9]*))([0-9])?$)|(^(0{0,1}|([1-9][0-9]*))([0-9])?$)"
                            SetFocusOnError="true" ToolTip="Не вірний номер референса">Невірний номер</asp:RegularExpressionValidator>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label runat="server" ID="Lb_kom" Text="Комісія банку" Visible="false" Enabled="False"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox runat="server" ID="Lb_kom1" Visible="false" ToolTip="Комісія Банку до повернення"></asp:TextBox>
                        <asp:RegularExpressionValidator runat="server" ID="Lb_kom1_valid" Display="Dynamic"
                            ControlToValidate="Lb_kom1" ValidationExpression=">(^(\ |\-)(0|([1-9][0-9]*))([\.\,][0-9]{0,2})?$)|(^(0{0,1}|([1-9][0-9]*))([\.\,][0-9]{0,2})?$)"
                            SetFocusOnError="true" ToolTip="Не вірний формат суми">Помилка</asp:RegularExpressionValidator>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label runat="server" ID="Lb_reason" Text="Причина повернення" Visible="false"
                            Enabled="False"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox runat="server" ID="Tb_reason" Width="450Px" Height="30px" MaxLength="150"
                            TextMode="MultiLine" Visible="false" ToolTip="Причина повернення переказу"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                    <asp:Label runat="server" ID="Lb_GLBD" Visible="false"></asp:Label>
                    </td>
                    <td>
                        <asp:Button runat="server" ID="Bt_Ret_Pay" Text="Повернути переказ" Visible="false"
                            OnClick="Bt_Ret_Pay_Click" />
                        <asp:HyperLink ID="LinRef2" runat="server" Target="_blank" Font-Size="Medium" Visible="false"
                                ToolTip="Переглянути документ">[LinREF]</asp:HyperLink>
                    </td>
                </tr>
            </table>
            <%--                   </td>
                    <td style="width: 50%">--%>
            <asp:Label runat="server" ID="Lb_err" Visible="false"></asp:Label>
            <br />
            <br />
            <asp:Panel runat="server" ID="Pn_ref" GroupingText="Інформація про виплачений переказ"
                Visible="false">
                <table style="width: 100%">
                    <tr>
                        <td style="width: 30%">
                            <asp:Label runat="server" ID="Lb_linRef" Visible="False" Text="Референс документа  "
                                Enabled="False"></asp:Label>
                        </td>
                        <td style="width: 100%">
                            <asp:HyperLink ID="LinREF" runat="server" Target="_blank" Font-Size="Medium" Visible="false"
                                ToolTip="Переглянути документ">[LinREF]</asp:HyperLink>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label runat="server" ID="Lb_pdat" Text="Дата документа" Enabled="False"></asp:Label>
                        </td>
                        <td>
                            <asp:Label runat="server" ID="Lb_pdat1"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label runat="server" ID="Lb_nlsa" Text="Рахунок видачі" Enabled="False"></asp:Label>
                        </td>
                        <td>
                            <asp:Label runat="server" ID="Lb_nlsa1"></asp:Label>
                            <asp:Label runat="server" ID="Lb_nlsa2"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label runat="server" ID="Lb_Sum" Text="Сума переказу" Enabled="False"></asp:Label>
                        </td>
                        <td>
                            <asp:Label runat="server" ID="Lb_SumN"></asp:Label>
                            <asp:Label runat="server" ID="Lb_Kv"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label runat="server" ID="Lb_nazn" Text="Призначення платежу" Enabled="False"></asp:Label>
                        </td>
                        <td>
                            <asp:Label runat="server" ID="Lb_Nazn1"></asp:Label>
                        </td>
                    </tr>                
                    
                    <tr>
                        <td>
                            <asp:Label runat="server" ID="Lb_fio" Text="ФІО" Enabled="False"></asp:Label>
                        </td>
                        <td>
                            <asp:Label runat="server" ID="Lb_fio1"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label runat="server" ID="Lb_tdok" Text="Тип документа" Enabled="False"></asp:Label>
                        </td>
                        <td>
                            <asp:Label runat="server" ID="Lb_tdok1"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        
                        <td>
                            <asp:Label runat="server" ID="Lb_paspn" Text="Серія та № документа" Enabled="False"></asp:Label>
                        </td>
                        <td>
                            <asp:Label runat="server" ID="Lb_paspn1"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label runat="server" ID="Lb_ATRT" Text="Ким і коли виданий" Enabled="False"></asp:Label>
                        </td>
                        <td>
                            <asp:Label runat="server" ID="Lb_ATRT1"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label runat="server" ID="Lb_ADRES" Text="Адреса" Enabled="False"></asp:Label>
                        </td>
                        <td>
                            <asp:Label runat="server" ID="Lb_ADRES1"></asp:Label>
                        </td>
                    </tr>
                </table>
            </asp:Panel>
        </asp:Panel>
    </div>
    </form>
</body>
</html>
