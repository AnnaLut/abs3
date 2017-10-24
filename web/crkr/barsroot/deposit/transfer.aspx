<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Transfer.aspx.cs" Inherits="Transfer" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Виплата</title>
    <link href="style/dpt.css" type="text/css" rel="stylesheet" />
    <script language="javascript" type="text/javascript" src="js/js.js?v1.2"></script>
    <script language="javascript" type="text/javascript" src="js/ck.js"></script>
    <script language="javascript" type="text/javascript" src="js/AccCk.js"></script>
    <script language="JavaScript" type="text/javascript" src="/Common/WebEdit/NumericEdit.js"></script>
</head>
<body>
    <form id="form1" runat="server">
    <input id="DT_R" runat="server" type="hidden" />
    <input id="ADRES" runat="server" type="hidden" />
    <input id="ATRT" runat="server" type="hidden" />
    <input id="PASPN" runat="server" type="hidden" />
    <input id="NMK" runat="server" type="hidden" />
    <input id="PASP" runat="server" type="hidden" />
    <input id="METAL" runat="server" type="hidden" />
    <table class="MainTable">
        <tr>
            <td align="center" colspan="3">
                <asp:Label ID="lbTitle" runat="server" CssClass="InfoHeader" Text="Виплата коштів з поточного рахунку" />
            </td>
        </tr>
        <tr>
            <td colspan="3">
                <table class="InnerTable">
                    <tr>
                        <td style="width: 30%">
                            <asp:Label ID="lbClient" runat="server" CssClass="InfoText" Text="Клієнт"></asp:Label>
                        </td>
                        <td style="width: 40%">
                            <asp:TextBox ID="textNMK" runat="server" CssClass="InfoText" ReadOnly="True" ToolTip="ПІБ клієнта"
                                TabIndex="11"></asp:TextBox>
                        </td>
                        <td style="width: 10%">
                            <asp:TextBox ID="textRNK" runat="server" CssClass="InfoText" ReadOnly="True" ToolTip="Реєстраційний номер клієнта"
                                TabIndex="12"></asp:TextBox>
                        </td>
                        <td style="width: 20%">
                            <asp:TextBox ID="textOKPO" runat="server" CssClass="InfoText" ReadOnly="True" ToolTip="Ідентифікаційний код клієнта"
                                TabIndex="13"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lbDptId" runat="server" CssClass="InfoText" Text="Договір №"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="textDPT_NUM" runat="server" CssClass="InfoText" ReadOnly="True"
                                ToolTip="№ депозитного договору" TabIndex="14"></asp:TextBox>
                        </td>
                        <td></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lbNLS" runat="server" Text="Рахунок" CssClass="InfoText" />
                        </td>
                        <td>
                            <asp:TextBox ID="textNLS" runat="server" CssClass="InfoText" ReadOnly="True" ToolTip="Рахунок"
                                TabIndex="15"></asp:TextBox>
                        </td>
                        <td>
                            <asp:TextBox ID="textKV" runat="server" CssClass="InfoText" ReadOnly="True" ToolTip="Валюта"
                                TabIndex="16"></asp:TextBox>
                        </td>
                        <td>
                            <asp:TextBox ID="textSUM" runat="server" CssClass="InfoText" ReadOnly="True" ToolTip="Залишок"
                                TabIndex="17"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                        </td>
                        <td>
                        </td>
                        <td>
                        </td>
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:RadioButton ID="rbMain" runat="server" CssClass="RadioText" TabIndex="1" AutoPostBack="True"
                                Checked="True" GroupName="ACC" Text="Основний рахунок" />
                        </td>
                        <td>
                            <asp:RadioButton ID="rbPercent" runat="server" CssClass="RadioText" TabIndex="1"
                                AutoPostBack="True" GroupName="ACC" Text="Відсотки" />
                        </td>
                        <td></td>
                        <td></td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td colspan="3">
                <table style='text-align: right' class="InnerTable" id="metalParameters" runat="server" visible="false">
                    <tr>
                        <td align="left">
                            <asp:Label ID="lbMetalsInfo" Text="Інформація про злитки" runat="server" CssClass="InfoLabel" />
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 100%">
                            <asp:GridView ID="gvBankMetals" CssClass="barsGridView" Width="600px" runat="server"
                                AutoGenerateColumns="False" DataSourceID="dsBankMetals" DataKeyNames="BAR_ID"
                                OnDataBound="gvBankMetals_DataBound">
                                <Columns>
                                    <asp:CommandField ShowSelectButton="True" SelectText="Вибрати" >
                                        <ItemStyle HorizontalAlign="Left" />
                                    </asp:CommandField>
                                    <asp:BoundField DataField="BAR_ID" HeaderText="*" SortExpression="BAR_ID" >
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="BARS_COUNT" HeaderText="Кількість<BR>злитків" SortExpression="BARS_COUNT"
                                        HtmlEncode="false" />
                                    <asp:BoundField DataField="BAR_NOMINAL" HeaderText="Номінал<BR>злитку" HtmlEncode="false" DataFormatString="{0:### ##0.0}" >
                                        <ItemStyle HorizontalAlign="Right" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="BAR_PROBA" HeaderText="Проба" SortExpression="BAR_PROBA" DataFormatString="{0:##0.0}" />
                                    <asp:BoundField DataField="INGOT_WEIGHT" HeaderText="Вага<BR>зилитку" SortExpression="INGOT_WEIGHT"
                                        HtmlEncode="false" />
                                </Columns>
                                <EmptyDataTemplate>                                    
                                    Дані відсутні
                                </EmptyDataTemplate>
                                <EmptyDataRowStyle HorizontalAlign="Center" />
                            </asp:GridView>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:FormView ID="fvBankMetals" runat="server" DataSourceID="dsBankMetals_Edit"
                                BorderStyle="Solid" BorderWidth="1px" Width="600px" 
                                OnItemInserted="fvBankMetals_ItemInserted"
                                OnItemUpdated="fvBankMetals_ItemUpdated"
                                OnItemDeleted="fvBankMetals_ItemDeleted"  >                                
                                <EditItemTemplate>
                                    <table style="width: 100%">
                                        <tr>
                                            <td style="width: 40%">
                                                <asp:Label ID="lbID" Text="ID: &nbsp;" runat="server" />
                                            </td>
                                            <td style="width: 20%">
                                                <asp:Label ID="IDLabel" runat="server" Text='<%# Bind("BAR_ID") %>' />
                                            </td>
                                            <td style="width: 40%">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="lbCount" Text="Кількість злитків: &nbsp;" runat="server" />
                                            </td>
                                            <td>
                                                <asp:TextBox ID="COUNT_U" runat="server" MaxLength="5" CssClass="InfoText" Text='<%# Bind("BARS_COUNT") %>' />
                                            </td>
                                            <td>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="COUNT_U"
                                                    ErrorMessage="Необхідно заповнити" Font-Names="Arial" Font-Size="8pt" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="lbNominal" Text="Номінал злитку: &nbsp;" runat="server" />
                                            </td>
                                            <td>
                                                <asp:TextBox ID="NOMINAL_I" runat="server" MaxLength="5" CssClass="InfoText" Text='<%# Bind("BAR_NOMINAL") %>' />
                                            </td>
                                            <td>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="NOMINAL_I"
                                                    ErrorMessage="Необхідно заповнити" Font-Names="Arial" Font-Size="8pt" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="lbProba" Text="Проба: &nbsp;" runat="server" />
                                            </td>
                                            <td align="left">
                                                <asp:TextBox ID="NaznTextBox" runat="server" Text='<%# Bind("BAR_PROBA") %>' 
                                                    Width="70px" style="text-align:right" />
                                            </td>
                                            <td>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="NaznTextBox"
                                                    ErrorMessage="Необхідно заповнити" Font-Names="Arial" Font-Size="8pt" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                &nbsp;
                                                <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True"
                                                    CommandName="Update" Text="Зберегти" />
                                                &nbsp;
                                                <asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" 
                                                    CommandName="Cancel" Text="Відмінити" />
                                                &nbsp;
                                            </td>
                                        </tr>
                                    </table>
                                </EditItemTemplate>
                                <InsertItemTemplate>
                                    <table style="width: 100%">
                                        <tr>
                                            <td style="width: 40%">
                                                *Кількість злитків: &nbsp;
                                            </td>
                                            <td align="left" style="width: 20%">
                                                <asp:TextBox ID="COUNT_I" runat="server" MaxLength="5" CssClass="InfoText" 
                                                    Text='<%# Bind("BARS_COUNT") %>' style="text-align:right" />
                                            </td>
                                            <td style="width: 40%">
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="COUNT_I"
                                                    ErrorMessage="Необхідно заповнити" Font-Names="Arial" Font-Size="8pt" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                *Номінал злитку: &nbsp;
                                            </td>
                                            <td align="left">
                                                <asp:TextBox ID="NOMINAL_I" runat="server" MaxLength="5" CssClass="InfoText"
                                                    Text='<%# Bind("BAR_NOMINAL") %>' style="text-align:right" />
                                            </td>
                                            <td>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="NOMINAL_I"
                                                    ErrorMessage="Необхідно заповнити" Font-Names="Arial" Font-Size="8pt"></asp:RequiredFieldValidator>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                *Проба: &nbsp;
                                            </td>
                                            <td align="left">
                                                <asp:TextBox ID="PROBA_I" runat="server" MaxLength="5" Width="70px"
                                                     Text='<%# Bind("BAR_PROBA") %>' style="text-align:right" OnPreRender="PROBA_I_PreRender" />
                                            </td>
                                            <td>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="PROBA_I"
                                                    ErrorMessage="Необхідно заповнити" Font-Names="Arial" Font-Size="8pt" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td></td>
                                            <td colspan="2">
                                                &nbsp;
                                                <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" 
                                                    CommandName="Insert" Text="Додати" />
                                                &nbsp;
                                                <asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False"
                                                    CommandName="Cancel" Text="Відмінити" />
                                                &nbsp;
                                            </td>
                                        </tr>
                                    </table>
                                </InsertItemTemplate>
                                <ItemTemplate>
                                    <table style="width: 100%">
                                        <tr>
                                            <td style="width: 40%">
                                                <asp:Label ID="lbID" Text="ID: &nbsp;" runat="server" />
                                            </td>
                                            <td style="width: 20%">
                                                <asp:Label ID="IDLabel" runat="server" Text='<%# Bind("BAR_ID") %>' />
                                            </td>
                                            <td style="width: 40%"></td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="lbCount" Text="Кількість злитків: &nbsp;" runat="server" />
                                            </td>
                                            <td>
                                                <asp:Label ID="SkLabel" runat="server" Text='<%# Bind("BARS_COUNT") %>' />
                                            </td>
                                            <td></td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="lbNominal" Text="Номінал злитку: &nbsp;" runat="server" />
                                            </td>
                                            <td>
                                                <asp:Label ID="SLabel" runat="server" Text='<%# Bind("BAR_NOMINAL") %>' />
                                            </td>
                                            <td></td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="lbProba" Text="Проба: &nbsp;" runat="server" />
                                            </td>
                                            <td>
                                                <asp:Label ID="NaznLabel" runat="server" Text='<%# Bind("BAR_PROBA") %>' />
                                            </td>
                                            <td></td>
                                        </tr>
                                        <tr>
                                            <td></td>
                                            <td align="right" colspan="2">
                                                &nbsp;
                                                <asp:LinkButton ID="EditButton" runat="server" CausesValidation="False" 
                                                    CommandName="Edit" Text="Редагувати" />
                                                &nbsp;
                                                <asp:LinkButton ID="DeleteButton" runat="server" CausesValidation="False"
                                                    CommandName="Delete" Text="Видалити" />
                                                &nbsp;
                                                <asp:LinkButton ID="NewButton" runat="server" CausesValidation="False"
                                                    CommandName="New" Text="Додати" />
                                                &nbsp;
                                            </td>
                                        </tr>
                                    </table>                                    
                                </ItemTemplate>
                                <EmptyDataTemplate>
                                    <asp:LinkButton ID="NewButton" runat="server" CausesValidation="False" CommandName="New"
                                        Text="Додати">
                                    </asp:LinkButton>
                                </EmptyDataTemplate>
                                <FooterTemplate>
                                    <table style="width: 100%" >
                                        <tr>
                                            <td style="width: 40%">
                                                <asp:Label ID="lbTotalNominal" Text="Загальний номінал злитків: &nbsp;" runat="server" />
                                            </td>
                                            <td style="width: 20%" align="left">
                                                <asp:TextBox ID="TOTAL_NOMINAL" runat="server" BackColor="LightGray" ReadOnly="true"
                                                    Text='<%# Convert.ToString(Bars.Metals.DepositMetals.Sum()) %>' 
                                                    Width="70px" style="text-align:right" />
                                            </td>
                                            <td style="width: 40%">
                                            </td>
                                        </tr>
                                    </table>
                                </FooterTemplate>
                                <FooterStyle  BorderStyle="Solid" BorderWidth="1px" BorderColor="LightGray" />
                            </asp:FormView>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:ObjectDataSource ID="dsBankMetals" runat="server" SelectMethod="SelectBars"
                                TypeName="Bars.Metals.DepositMetals" DataObjectTypeName="Bars.Metals.DepositMetals">
                                <DeleteParameters>
                                    <asp:Parameter Name="BAR_ID" Type="Int32" />
                                </DeleteParameters>
                                <UpdateParameters>
                                    <asp:Parameter Name="BAR_ID" Type="Int32" />
                                    <asp:Parameter Name="BARS_COUNT" Type="Int32" />
                                    <asp:Parameter Name="BAR_NOMINAL" Type="Decimal" />
                                    <asp:Parameter Name="BAR_PROBA" Type="Decimal" />
                                </UpdateParameters>
                                <InsertParameters>
                                    <asp:Parameter Name="BARS_COUNT" Type="Int32" />
                                    <asp:Parameter Name="BAR_NOMINAL" Type="Decimal" />
                                    <asp:Parameter Name="BAR_PROBA" Type="Decimal" />
                                </InsertParameters>
                            </asp:ObjectDataSource>
                            <asp:ObjectDataSource ID="dsBankMetals_Edit" runat="server" TypeName="Bars.Metals.DepositMetals"
                                InsertMethod="InsertBar" SelectMethod="SelectBar"
                                UpdateMethod="UpdateBar" DeleteMethod="DeleteBar" >
                                <DeleteParameters>
                                    <asp:Parameter Name="BAR_ID" Type="Int32" />
                                </DeleteParameters>
                                <UpdateParameters>
                                    <asp:Parameter Name="BAR_ID" Type="Int32" />
                                    <asp:Parameter Name="BARS_COUNT" Type="Int32" />
                                    <asp:Parameter Name="BAR_NOMINAL" Type="Decimal" />
                                    <asp:Parameter Name="BAR_PROBA" Type="Decimal" />
                                </UpdateParameters>
                                <InsertParameters>
                                    <asp:Parameter Name="BARS_COUNT" Type="Int32" />
                                    <asp:Parameter Name="BAR_NOMINAL" Type="Decimal" />
                                    <asp:ControlParameter Name="CURRENCY" Type="Int32" ControlID="KV" PropertyName="Value" />
                                    <asp:Parameter Name="BAR_PROBA" Type="Decimal" />
                                </InsertParameters>
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="gvBankMetals" Name="BAR_ID" PropertyName="SelectedValue"
                                        Type="Int32" />
                                </SelectParameters>
                            </asp:ObjectDataSource>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td colspan="3">
                <table class="InnerTable">
                    <tr>
                        <td style="width: 30%">
                            <asp:Label ID="lbTransfer" runat="server" CssClass="InfoText" Text="Сума виплати"></asp:Label>
                        </td>
                        <td style="width: 20%">
                            <asp:TextBox ID="Sum" runat="server" TabIndex="1" Style="text-align: right" 
                                MaxLength="12" CssClass="DateSum" />
                            <script type="text/javascript" language="javascript">
                                init_numedit("Sum", ("" == document.getElementById("Sum").value) ? (0) : (document.getElementById("Sum").value), 2);                                
                            </script>
                        </td>
                        <td style="width: 20%">
                            <input id="btPay" class="AcceptButton" type="button" onclick="if (CheckSum4Trans())Transfer()"
                                value="Виплатити" runat="server" tabindex="7" />
                            <asp:Button ID="btnPay" runat="server" Text="Виплата" tabindex="7" 
                                CssClass="AcceptButton" onclick="btnPay_Click" Visible="false"/>
                        </td>
                        <td style="width: 30%">
                            <asp:Button ID="btPrintReport" class="AcceptButton" runat="server" Text="Виписка"
                                OnClick="btPrintReport_Click" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lbCommission" runat="server" CssClass="InfoText" Text="Сума комісії"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="Commission" runat="server" TabIndex="1" Style="text-align: right"
                                MaxLength="12" ReadOnly="True" CssClass="DateSum" />
                            <script type="text/javascript" language="javascript">
                                init_numedit("Commission", ("" == document.getElementById("Commission").value) ? (0) : (document.getElementById("Commission").value), 2);
                            </script>
                        </td>
                        <td>
                            <input id="btPayCommission" class="AcceptButton" type="button" value="Оплатити комісію"
                                runat="server" onclick="TakeTransferComission()" tabindex="8" disabled="disabled" />
                        </td>
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="Label1" runat="server" CssClass="InfoText" Text="Заява на закриття" />
                        </td>
                        <td>
                            <asp:Button ID="btForm" runat="server" Text="Формувати" CssClass="AcceptButton" OnClick="btForm_Click" />
                        </td>
                        <td>
                            <asp:Button ID="btPrint" runat="server" Text="Друк заяви" CssClass="AcceptButton"
                                OnClick="btPrint_Click" />
                        </td>
                        <td>
                            <asp:Button ID="btClose" runat="server" Text="Закрити договір" CssClass="AcceptButton" 
                                OnClientClick = "if (!confirm('Закрити депозитний договір?')) return false;" OnClick="btClose_Click" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td colspan="3">
                <table class="InnerTable" id="tbTransferInfo" runat="server" visible="false">
                    <tr>
                        <td colspan="3" align="center">
                            <asp:Label ID="lbInfo" runat="server" CssClass="InfoText" Text="Параметри перехування суми"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 30%">
                            <asp:Label ID="lbReciever" runat="server" CssClass="InfoText" Text="Отримувач"></asp:Label>
                        </td>
                        <td style="width: 40%">
                            <asp:TextBox ID="textNMS_B" runat="server" CssClass="InfoText" ToolTip="ПІБ одержувача"
                                MaxLength="256" TabIndex="2"></asp:TextBox>
                        </td>
                        <td style="width: 30%">
                            <asp:TextBox ID="textOKPO_B" runat="server" CssClass="InfoText" ToolTip="Ідентифікаційний код отримувача"
                                MaxLength="10" TabIndex="3"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lbRecieverNLS" runat="server" CssClass="InfoText" Text="Рахунок для перерахування"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="textNLS_B" runat="server" CssClass="InfoText" ToolTip="Номер рахунку отримувача"
                                MaxLength="14" TabIndex="4"></asp:TextBox>
                        </td>
                        <td>
                            <asp:TextBox ID="textMFO_B" runat="server" CssClass="InfoText" ToolTip="МФО отримувача"
                                MaxLength="6" TabIndex="5"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lbNazn" runat="server" CssClass="InfoText" Text="Призначення платежу" />
                        </td>
                        <td colspan="2">
                            <asp:TextBox ID="textNAZN" runat="server" CssClass="InfoText" ToolTip="Призначення платежу"
                                TextMode="MultiLine" MaxLength="1024" TabIndex="6" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td colspan="3">
                <input id="SumGrams" runat="server" type="hidden" />
                <input id="DPT_ID" runat="server" type="hidden" />
                <input id="NLS" runat="server" type="hidden" />
                <input id="LCV" runat="server" type="hidden" />
                <input id="cash" runat="server" type="hidden" />
                <input id="KV" runat="server" type="hidden" />
                <input id="SMAIN" runat="server" type="hidden" />
                <input id="tt" runat="server" type="hidden" />
                <input id="tt_IN" runat="server" type="hidden" />
                <input id="tt_IN_K" runat="server" type="hidden" />
                <input id="tt_OUT" runat="server" type="hidden" />
                <input id="tt_OUT_K" runat="server" type="hidden" />
                <input id="Templates" runat="server" type="hidden" />
                <input id="maxSUM" runat="server" type="hidden" />
                <input id="ourMFO" runat="server" type="hidden" />
                <input id="dpf_oper" runat="server" type="hidden" />
                <input id="bpp_4_cent" runat="server" type="hidden" />
                <input id="before_pay" runat="server" type="hidden" />
                <input id="denom" runat="server" type="hidden" />
                <input id="SUM_nom" runat="server" type="hidden" />
                <input id="SUM_grams" runat="server" type="hidden" />
            </td>
        </tr>
        <tr>
            <td colspan="3">
                <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="True">
                </asp:ScriptManager>
            </td>
        </tr>
    </table>
    </form>
    <script language="javascript" type="text/javascript">
        if (typeof (Sys) !== 'undefined') Sys.Application.notifyScriptLoaded();
    </script>
    <script type="text/javascript" language="javascript">
        if (document.getElementById("textNMS_B"))
            document.getElementById("textNMS_B").attachEvent("onkeydown", doAlpha);
        if (document.getElementById("textOKPO_B"))
            document.getElementById("textOKPO_B").attachEvent("onkeydown", doNum);
        if (document.getElementById("textNLS_B"))
            document.getElementById("textNLS_B").attachEvent("onkeydown", doNumAlpha);
        if (document.getElementById("textMFO_B"))
            document.getElementById("textMFO_B").attachEvent("onkeydown", doNum);
        if (document.getElementById("textNAZN"))
            document.getElementById("textNAZN").attachEvent("onkeydown", doNumAlpha);
    </script>
    <script type="text/javascript">
        focusControl('Sum');
    </script>
</body>
</html>
