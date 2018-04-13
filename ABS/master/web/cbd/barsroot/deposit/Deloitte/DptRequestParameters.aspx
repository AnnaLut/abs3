<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DptRequestParameters.aspx.cs" Inherits="deposit_DptRequestParameters" %>

<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="bars" %>
<%@ Register Assembly="Bars.Web.Controls" Namespace="Bars.Web.Controls" TagPrefix="bwc" %>
<%@ Register Src="~/UserControls/EADocsView.ascx" TagPrefix="bars" TagName="EADocsView" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Депозитний модуль: Ообробка запитів на доступ</title>
    <link href="/barsroot/deposit/style/dpt.css" type="text/css" rel="stylesheet" />
    <base target="_self" />
    <!-- JavaScript -->
    <script type="text/javascript" language="javascript" src="/barsroot/deposit/js/js.js"></script>
    <script type="text/javascript" language="javascript">
        function EnableEditRequest() {
            document.getElementById('tbCertifNum').disabled = false;
            document.getElementById('dtCertifDate').disabled = false;
            document.getElementById('dtDateStart').disabled = false;

            if (document.getElementById('dtDateFinish'))
            {
                document.getElementById('dtDateFinish').disabled = false;
            }

            document.getElementById('btRequestAllowed').disabled = true;
            document.getElementById('btRequestModify').disabled = true;
            document.getElementById('btRequestRejected').disabled = true;
            document.getElementById('btRequestSaveChanges').disabled = false;
        }
        //
        function AfterPageLoad()
        {
            document.getElementById('dtClienBirthday').disabled = true;
            document.getElementById('tbCertifNum').disabled = true;
            document.getElementById('dtCertifDate').disabled = true;
            document.getElementById('dtDateStart').disabled = true;

            if (document.getElementById('dtDateFinish')) 
            {
                document.getElementById('dtDateFinish').disabled = true;
            }
        }
	</script>
</head>
<!-- body onload="AfterPageLoad();" -->
<body>
    <form id="RequestParameters" runat="server">
    <Bars:BarsSqlDataSourceEx ID="dsReqDetails" runat="server" ProviderName="barsroot.core" />

    <div>
    <table class="MainTable" width="100%">
        <tr>
            <td align="center" colspan="4">
                <asp:label id="lbPageTitle" runat="server" text="Обробка запитів на доступ" CssClass="InfoHeader" />
            </td>
        </tr>
        <tr>
            <td colspan="4">
            <asp:Panel ID="Panel1" runat="server" GroupingText="Клієнт">
                <table id="Table1" runat="server" class="InnerTable" width="100%">
                    <tr>
                        <td align="right" style="width:25%">
                            <asp:Label ID="lbClientName" runat="server" Text="ПІБ клієнта: " CssClass="InfoLabel" style="text-align:right" meta:resourcekey="lbClientName" />
                        </td>
                        <td align="left" colspan="2">
                            <asp:TextBox ID="textClientName" meta:resourcekey="textClientName" TabIndex="1" width="98%"
                                runat="server" ToolTip="Назва клієнта" ReadOnly="True" CssClass="InfoText" />
                        </td>
                        <td align="left" colspan="2">
                            <asp:TextBox ID="textTrusteeType" meta:resourcekey="textTrusteeType" TabIndex="2" width="98%"
                            runat="server" ToolTip="Тип клієнта третьої особи" ReadOnly="True" CssClass="InfoText"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            <asp:Label ID="lbClienCode" runat="server" Text="ІПН клієнта: " CssClass="InfoLabel" style="text-align:right" meta:resourcekey="lbClienCode" />
                        </td>
                        <td align="left" style="width:20%">
                            <asp:TextBox ID="textClientCode" meta:resourcekey="textClientCode" TabIndex="3" width="60%"
                            runat="server" ToolTip="Індивідуальний податковий номер клієнта" ReadOnly="True" CssClass="InfoText"></asp:TextBox>
                        </td>
                        <td align="right" style="width:25%">
                            <asp:Label ID="lbClienBirthday" runat="server" text="Дата народження клієнта: " CssClass="InfoLabel" meta:resourcekey="lbClienBirthday" />
                        </td>
                        <td style="width:12%">
                            <bwc:DateEdit ID="dtClienBirthday" Width="80px" runat="server" TabIndex="4" ToolTip="Дата народження клієнта"/>
                        </td>
                        <td align="right" style="width:18%">
                            <asp:Button ID="btClientCard" runat="server" Text="Картка Клієнта" 
                                ToolTip="Перегляд картки клієнта третьої особи" Width="140px" CausesValidation="false"
                                onclick="btClientCard_Click" />
                            <!-- onclientclick="showClient(); return false;" -->
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            </td>
        </tr>
        <tr>
            <td colspan="4">
            <asp:Panel ID="pnRequestParams" runat="server" GroupingText="Параметри запиту">
                <table ID="tbRequestParams" runat="server" class="InnerTable" width="100%">
                    <tr>
                        <td colspan="2" align="center" >
                            <asp:RadioButton ID="rbClientCard" Text="&nbsp; Запит на доступ до Картки Клієнта" 
                                runat="server" GroupName="RequestType" />
                        </td>
                        <td colspan="2" align="center" >
                            <asp:RadioButton ID="rbContracts" Text="&nbsp; Запит на доступ до Депозитів" 
                                runat="server" GroupName="RequestType" />
                        </td>
                    </tr>
                    <tr>
                        <td align="right" style="width:30%">
                            <asp:Label ID="lbRequestID" runat="server" CssClass="InfoText" Text="Ідентифікатор запиту:&nbsp;">
                            </asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="tbRequestID" ReadOnly="true" Width="98%" runat="server" CssClass="InfoText"
                                ToolTip="Ідентифікатор запиту на доступ" Font-Bold="true" BackColor="LightGoldenrodYellow"
                                style="text-align:center" />
                        </td>
                        <td></td>
                        <td align="right">
                            <bars:EADocsView runat="server" ID="EADocsView" EAStructID="146" Visible="false" />&nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td align="right" style="width:25%">
                            <asp:Label ID="lbCertifNum" runat="server" CssClass="InfoText" Text="Номер нотаріального документу:&nbsp;">
                            </asp:Label>
                        </td>
                        <td  style="width:20%">
                            <asp:TextBox ID="tbCertifNum" runat="server" MaxLength="50"  meta:resourcekey="textClientName"
                            tabIndex="5" ToolTip="Серія та номер документу" Width="150px" CssClass="InfoText" />
                        </td>
                        <td align="right" style="width:25%">
                            <asp:Label ID="lbCertifDate" runat="server" CssClass="InfoText" Text="Дата нотаріального документу:&nbsp;"></asp:Label>
                        </td>
                        <td style="width:30%">
                            <bwc:DateEdit ID="dtCertifDate" runat="server" Width="90px" tabIndex="6" MinDate="01/01/1950" />
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            <asp:Label ID="lbRequestDates" runat="server" Text="Термін дії: з &nbsp;" CssClass="InfoText" ></asp:Label>
                        </td>
                        <td>
                            <bwc:DateEdit ID="dtDateStart" runat="server" Width="90px" TabIndex="8" MinDate="01/01/2010" />
                        </td>
                        <td align="right">
                            <asp:Label ID="lbDateFinish" runat="server" CssClass="InfoText" Text="Дата завершення: &nbsp;" />
                        </td>
                        <td>
                            <bwc:DateEdit ID="dtDateFinish" runat="server" Width="90px" TabIndex="9" MinDate="01/01/2010"/>
                        </td>
                    </tr>
                    <tr>
                        <td align="center" colspan="4">
                            <asp:ListView ID="lvReqDetails" DataSourceID="dsReqDetails" runat="server"
                                DataKeyNames="CONTRACT_ID" OnLayoutCreated="OnLayoutCreated" >
                                <LayoutTemplate>
                                    <table class="tbl_style1" width="99%" border="1">
                                        <thead>
                                            <tr>
                                                <th align="center" colspan="7">
                                                    <asp:Label ID="lbReqDetails" runat="server" Text="Деталі запиту" CssClass="InfoText"
                                                        Font-Size="Medium" Font-Bold="true"/>
                                                </th>
                                            </tr>
                                            <tr>
                                                <th>
                                                    <asp:label id="lbDepositNumber" Text="Номер<BR>договору" runat="server" CssClass="InfoText" />
                                                </th>
                                                <th>
                                                    <asp:label id="lbEADocs" Text="Документи ЕА" runat="server" CssClass="InfoText" />
                                                </th>
                                                <th runat="server" id="colAmount">
                                                    <asp:Label ID="lbAmount" runat="server" Text="Частка спадку<BR>Сума доручення" CssClass="InfoText" />
                                                </th>
                                                <th runat="server" id="colPrint">
                                                    <asp:Label ID="lbPrint" runat="server" Text="Отримання<BR>виписок" CssClass="InfoText" />
                                                </th>
                                                <th runat="server" id="colMoney">
                                                    <asp:Label ID="lbMoney" runat="server" Text="Отримання<BR>депозиту" CssClass="InfoText" />
                                                </th>
                                                <th runat="server" id="colEarly">
                                                    <asp:Label ID="lbEarly" runat="server" Text="Дострокове<BR>розірвання" CssClass="InfoText" />
                                                </th>
                                                <th runat="server" id="colAgreements">
                                                    <asp:Label ID="lbAgreements" runat="server" Text="Укладання<BR>дод.угод" CssClass="InfoText" />
                                                </th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <asp:PlaceHolder runat="server" ID="itemPlaceholder" />
                                            </tr>
                                        </tbody>
                                    </table>
                                </LayoutTemplate>
                                <ItemTemplate>
                                    <tr>
                                        <td align="center">
                                            <asp:LinkButton id="lbtShowDepositCard" runat="server" Enabled='<%# !IsEdit %>' CssClass="InfoText"
                                                Text='<%# Eval("CONTRACT_ID") %>' ToolTip="Перегляд картки депозитного договору"
                                                CommandName="ShowDepositCard" OnCommand="lbtShowDepositCard_Command" 
                                                CommandArgument='<%# Eval("CONTRACT_ID") %>' CausesValidation="false" />
                                        </td>
                                        <td align="center">
                                            <bars:EADocsView runat="server" ID="EADocsView" EAStructID="22" 
                                                AgrID='<%# Convert.ToInt64(Eval("CONTRACT_ID")) %>' 
                                                RNK='<%# Convert.ToInt64(Eval("CONTRACT_RNK")) %>'/>
                                        </td>
                                        <td align="center" runat="server" id="colAmount">
                                            <bwc:NumericEdit ID="nmAmount" runat="server" Width="120px" Enabled='<%# IsEdit %>'
                                                Text='<%# Bind("AMOUNT") %>' Presiction='<%# (TrusteeTypeCode.Value == "H" ? 4 : 2) %>'
                                                Visible='<%# (TrusteeTypeCode.Value == "V" ? false : true) %>' />
                                        </td>
                                        <td align="center" runat="server" id="colPrint">
                                            <asp:CheckBox ID="cbPrint" runat="server" Enabled='<%# IsEdit %>'
                                                Checked='<%# Convert.ToBoolean(Eval("FL_REPORT")) %>' 
                                                Visible='<%# (TrusteeTypeCode.Value == "T" ? true : false) %>' />
                                        </td>
                                        <td align="center" runat="server" id="TabColMoney">
                                            <asp:CheckBox ID="cbMoney" runat="server" Enabled='<%# IsEdit %>'
                                                Checked='<%# Convert.ToBoolean(Eval("FL_MONEY")) %>' 
                                                Visible='<%# (TrusteeTypeCode.Value == "T" ? true : false) %>' />
                                        </td>
                                        <td align="center" runat="server" id="TabColEarly" >
                                            <asp:CheckBox ID="cbEarlyTermination" runat="server" Enabled='<%# IsEdit %>'
                                                Checked='<%# Convert.ToBoolean(Eval("FL_EARLY")) %>' 
                                                Visible='<%# (TrusteeTypeCode.Value == "T" ? true : false) %>' />
                                        </td>
                                        <td align="center" runat="server" id="TabColAgreements" >
                                            <asp:CheckBox ID="cbAgreements" runat="server" Enabled='<%# IsEdit %>'
                                                Checked='<%# Convert.ToBoolean(Eval("FL_AGREEMENTS")) %>' 
                                                Visible='<%# (TrusteeTypeCode.Value == "T" ? true : false) %>' />
                                        </td>
                                    </tr>
                                </ItemTemplate>
                            </asp:ListView>
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            </td>
        </tr>
        <tr>
            <td align="right" style="width:25%">
                <asp:Label ID="lbRequestAllowed" Text="Причини відмови (коментар): &nbsp;" CssClass="InfoText" runat="server" />
            </td>
            <td colspan="2">
                <asp:TextBox ID="tbRequestComment" runat="server" MaxLength="128" TextMode="MultiLine" Height="99%" Width="99%"/>
            </td>
            <td align="left" style="width:25%" >
                <asp:RequiredFieldValidator ID="RequestCommentValidator" ControlToValidate="tbRequestComment" 
                    Text="&nbsp;Не вказна причина відмови!" runat="server" EnableClientScript="true" SetFocusOnError="true" />
            </td>
        </tr>
        <tr>
            <td align="right">
                <asp:Label ID="lbDateProc" Text="Запит оброблено: &nbsp;" CssClass="InfoText" runat="server" Visible="false"/>
            </td>
            <td align="left" >
                <asp:TextBox ID="tbDateProc" runat="server" CssClass="InfoText" ReadOnly="true"
                    Visible="false" Width="140px"/>
            </td>
            <td align="right">
                <asp:Label ID="lbReqStatus" Text="Статус запиту: &nbsp;" CssClass="InfoText" runat="server" Visible="false"/>
            </td>
            <td>
                <asp:TextBox ID="tbReqStatus" runat="server" CssClass="InfoText" ReadOnly="true"
                    Visible="false" Width="90%"/>
            </td>
        </tr>
        <tr>
            <td align="right">
                <asp:Label ID="lbUserName" Text="ПІБ користувача: &nbsp;" CssClass="InfoText" runat="server" Visible="false"/>
            </td>
            <td colspan="2">
                <asp:TextBox ID="tbUserName" CssClass="InfoText" runat="server" ReadOnly="true" Visible="false" />
            </td>
            <td></td>
        </tr>
        <tr>
            <td style="width:25%" align="center">
                <asp:Button ID="btRequestAllowed" Text="Надати доступ" runat="server" meta:resourcekey="btRequestAllowed"
                     onclick="btRequestAllowed_Click" CausesValidation="False" CssClass="AcceptButton" />
            </td>
            <td style="width:25%" align="center">
                <asp:Button ID="btRequestModify" Text="Редагувати запит" runat="server" meta:resourcekey="btRequestModify"
                    CausesValidation="False" CssClass="AcceptButton" 
                    onclick="btRequestModify_Click"/>
            </td>
            <td style="width:25%" align="center">
                <asp:Button ID="btRequestSaveChanges" Text="Зберегти зміни" runat="server" meta:resourcekey="btRequestSaveChanges"
                    CausesValidation="False" CssClass="AcceptButton" 
                    onclick="btRequestSaveChanges_Click" />
            </td>
            <td style="width:25%" align="center">
                <asp:Button ID="btRequestRejected" Text="Відмовити у доступі" runat="server" meta:resourcekey="btRequestRejected"
                    CausesValidation="true" CssClass="AcceptButton" 
                    onclick="btRequestRejected_Click"/>
            </td>
        </tr>
        <tr>
            <td>
                <asp:HiddenField ID="rnk" runat="server" />
            </td>
            <td>
                <asp:HiddenField ID="TrusteeTypeCode" runat="server" />
            </td>
            <td></td>
            <td></td>
        </tr>
    </table>
    </div>
    </form>
</body>
</html>
