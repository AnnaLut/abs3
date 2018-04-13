<%@ Page Language="C#" AutoEventWireup="true" CodeFile="depositpoliticalinstability.aspx.cs" Inherits="deposit_depositpoliticalinstability" %>

<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="Bars" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Депозити розірвані у період політичної нестабільності</title>
    <link href="/common/css/default.css" type="text/css" rel="Stylesheet" />
    <link href="Styles.css" type="text/css" rel="stylesheet" />

    <script type="text/javascript" src="/Common/WebEdit/NumericEdit.js"></script>

    <script type="text/javascript" src="/Common/Script/BarsIe.js"></script>

    <style type="text/css">
        .auto-style1 {
            height: 30px;
        }
    </style>
</head>
<body bgcolor="#f0f0f0">
    <form id="formDepository" runat="server">
        <div class="pageTitle">
            <asp:Label ID="lbTitle" runat="server" Text="Пошук розірваного договору"></asp:Label>
        </div>
        <asp:Panel ID="panelSerchOld" runat="server" GroupingText="Параметри договору, що був розірваний" Style="margin-left: 10px;">
            <table id="tableSearchOld">
                <tr>
                    <td nowrap="nowrap">
                        <asp:Label ID="lbOldNum" runat="server" Text="№ договору" ToolTip="Номер договору"></asp:Label>
                    </td>
                    <td nowrap="nowrap">
                        <asp:TextBox ID="tbOldNum" runat="server"></asp:TextBox>
                    </td>
                    <td nowrap="nowrap">
                        <asp:TextBox ID="tbNewNum" runat="server" Visible="false"></asp:TextBox>
                    </td>
                    <td nowrap="nowrap">
                        <asp:Label ID="lbOldStartDate" runat="server" Text="Дата" ToolTip="Дата укладання договору"></asp:Label>
                    </td>
                    <td nowrap="nowrap">
                        <bars:DateEdit ID="deOldStartDate" runat="server"></bars:DateEdit>
                    </td>
                    <td nowrap="nowrap">
                        <bars:DateEdit ID="deNewStartDate" runat="server" Visible="false"></bars:DateEdit>
                    </td>
                    <td nowrap="nowrap">
                        <asp:Button ID="btOldSearh" runat="server" Text="Пошук" ToolTip="Пошук договору розірваного в час політичної нестабільності" CausesValidation="true" OnClick="btOldSearh_Click" />
                    </td>
                    <td nowrap="nowrap">
                        <asp:Button ID="btNewSearh" runat="server" Text="Пошук" Visible="false" ToolTip="Пошук нового договору" CausesValidation="true" OnClick="btNewSearh_Click" />
                    </td>
                    <td nowrap="nowrap">
                        <asp:Button ID="btNext" runat="server" Text="Далі" Visible="false" ToolTip="Перейти до пошуку нового договору" CausesValidation="true" OnClick="btNext_Click" />
                    </td>
                    <td nowrap="nowrap">
                        <asp:Button ID="btBunch" runat="server" Text="Зв`язати" Visible="false" ToolTip="Зв`язати договори між собою" CausesValidation="true" OnClick="btBunch_Click" />
                    </td>
                </tr>
            </table>
            <asp:Label ID="lbError" runat="server" ForeColor="Red" Text=""></asp:Label>
        </asp:Panel>
        <asp:Panel ID="pnlOldResults" runat="server" GroupingText="Данні договору, що був розірваний" Style="margin-left: 10px;" Visible="false">
            <table id="tableOldDP">
                <tr>
                    <td nowrap="nowrap">
                        <asp:Label ID="lbFio" runat="server" Text="ПІБ" ToolTip="Прізвище, Ім`я, Побатькові"></asp:Label>
                    </td>
                    <td nowrap="nowrap">
                        <asp:TextBox ID="tbFio" runat="server" ReadOnly="true"></asp:TextBox>
                    </td>
                    <td nowrap="nowrap">
                        <asp:Label ID="lbOldDep" runat="server" Text="№ договору" ToolTip="Номер договору розірваного в часи політичної нестабільності"></asp:Label>
                    </td>
                    <td nowrap="nowrap">
                        <asp:TextBox ID="tbOldDpnum" runat="server" ReadOnly="true"></asp:TextBox>
                    </td>

                </tr>
                <tr>
                    <td nowrap="nowrap">
                        <asp:Label ID="lbBirthDate" runat="server" Text="Дата народження" ToolTip="Дата народження клієнта"></asp:Label>
                    </td>
                    <td nowrap="nowrap">
                        <bars:DateEdit ID="deBirthDate" runat="server" ReadOnly="true"></bars:DateEdit>
                    </td>
                    <td nowrap="nowrap">
                        <asp:Label ID="lbOldDepDate" runat="server" Text="Дата укладання" ToolTip="Дата укладання договору"></asp:Label>
                    </td>
                    <td nowrap="nowrap">
                        <bars:DateEdit ID="deOldDepDate" runat="server" ReadOnly="true"></bars:DateEdit>
                    </td>
                </tr>
                <tr>
                    <td nowrap="nowrap">
                        <asp:Label ID="lbDoc" runat="server" Text="Документ" ToolTip="Документ, що засвідчує особу"></asp:Label>
                    </td>
                    <td nowrap="nowrap">
                        <asp:TextBox ID="tbDoc" runat="server" ReadOnly="true"></asp:TextBox>
                    </td>
                    <td nowrap="nowrap">
                        <asp:Label ID="lbOldDateEnd" runat="server" Text="Дата закінчення" ToolTip="Дата закінчення розірваного договору"></asp:Label>
                    </td>
                    <td nowrap="nowrap">
                        <bars:DateEdit ID="deOldDateEnd" runat="server" ReadOnly="true"></bars:DateEdit>
                    </td>
                </tr>
                <tr>
                    <td nowrap="nowrap">
                        <asp:Label ID="lbInn" runat="server" Text="ІНН"></asp:Label>
                    </td>
                    <td nowrap="nowrap">
                        <asp:TextBox ID="tbInn" runat="server" ReadOnly="true"></asp:TextBox>
                    </td>
                    <td nowrap="nowrap">
                        <asp:Label ID="lbTerminatedDate" runat="server" Text="Дата розірвання" ToolTip="Дата розірвання договору"></asp:Label>
                    </td>
                    <td nowrap="nowrap">
                        <bars:DateEdit ID="deTerminatedDate" runat="server" ReadOnly="true"></bars:DateEdit>
                    </td>
                </tr>
                <tr>
                    <td nowrap="nowrap"></td>
                    <td nowrap="nowrap"></td>
                    <td nowrap="nowrap">
                        <asp:Label ID="lbKv" runat="server" Text="Валюта" ToolTip="Валюта договору"></asp:Label>
                    </td>
                    <td nowrap="nowrap">
                        <asp:TextBox ID="tbKv" runat="server" ReadOnly="true"></asp:TextBox>
                    </td>


                </tr>
                <tr>
                    <td nowrap="nowrap"></td>
                    <td nowrap="nowrap"></td>
                    <td nowrap="nowrap">
                        <asp:Label ID="lbBalance" runat="server" Text="Залишок" ToolTip="Залишок на момент розірвання договору"></asp:Label>
                    </td>
                    <td nowrap="nowrap">
                        <bars:NumericEdit ID="nbBalance" runat="server" ReadOnly="true"></bars:NumericEdit>
                    </td>
                </tr>
                <tr>
                    <td nowrap="nowrap"></td>
                    <td nowrap="nowrap"></td>
                    <td nowrap="nowrap">
                        <asp:Label ID="lbPenalty" runat="server" Text="Сума штрафу" ToolTip="Сума штрафу за розірвання договору"></asp:Label>
                    </td>
                    <td nowrap="nowrap">
                        <bars:NumericEdit ID="nePenalty" runat="server" ReadOnly="true"></bars:NumericEdit>
                    </td>
                </tr>
            </table>
        </asp:Panel>
        <asp:Panel ID="panelNewResult" runat="server" GroupingText="Данні нового договору" Style="margin-left: 10px;" Visible="false">
            <table id="tableNew">
                <tr>
                    <td nowrap="nowrap">
                        <asp:Label ID="lbNewFio" runat="server" Text="ПІБ" ToolTip="Прізвище, Ім`я, Побатькові"></asp:Label>
                    </td>
                    <td nowrap="nowrap">
                        <asp:TextBox ID="tbNewFio" runat="server" ReadOnly="true"></asp:TextBox>
                    </td>
                    <td nowrap="nowrap">
                        <asp:Label ID="lbNewDPNum" runat="server" Text="№ договору" ToolTip="Номер договору розірваного в часи політичної нестабільності"></asp:Label>
                    </td>
                    <td nowrap="nowrap">
                        <asp:TextBox ID="tbNewDPNum" runat="server" ReadOnly="true"></asp:TextBox>
                    </td>

                </tr>
                <tr>
                    <td nowrap="nowrap">
                        <asp:Label ID="lbNewBirhtDate" runat="server" Text="Дата народження" ToolTip="Дата народження клієнта"></asp:Label>
                    </td>
                    <td nowrap="nowrap">
                        <bars:DateEdit ID="deNewBirthDate" runat="server" ReadOnly="true"></bars:DateEdit>
                    </td>
                    <td nowrap="nowrap">
                        <asp:Label ID="lbNewStartDAte" runat="server" Text="Дата укладання" ToolTip="Дата укладання договору"></asp:Label>
                    </td>
                    <td nowrap="nowrap">
                        <bars:DateEdit ID="deNewDPStartDate" runat="server" ReadOnly="true"></bars:DateEdit>
                    </td>
                </tr>
                <tr>
                    <td nowrap="nowrap">
                        <asp:Label ID="lbNewDoc" runat="server" Text="Документ" ToolTip="Документ, що засвідчує особу"></asp:Label>
                    </td>
                    <td nowrap="nowrap">
                        <asp:TextBox ID="tbNewDoc" runat="server" ReadOnly="true"></asp:TextBox>
                    </td>
                    <td nowrap="nowrap">
                        <asp:Label ID="lbNewEndDate" runat="server" Text="Дата закінчення" ToolTip="Дата закінчення розірваного договору"></asp:Label>
                    </td>
                    <td nowrap="nowrap">
                        <bars:DateEdit ID="deNewEndDate" runat="server" ReadOnly="true"></bars:DateEdit>
                    </td>
                </tr>
                <tr>
                    <td nowrap="nowrap">
                        <asp:Label ID="lbNewInn" runat="server" Text="ІНН"></asp:Label>
                    </td>
                    <td nowrap="nowrap">
                        <asp:TextBox ID="tbNewInn" runat="server" ReadOnly="true"></asp:TextBox>
                    </td>
                    <td nowrap="nowrap">
                        <asp:Label ID="lbNewKv" runat="server" Text="Валюта" ToolTip="Валюта договору"></asp:Label>
                    </td>
                    <td nowrap="nowrap">
                        <asp:TextBox ID="tbNewKv" runat="server" ReadOnly="true"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td nowrap="nowrap"></td>
                    <td nowrap="nowrap"></td>
                    <td nowrap="nowrap">
                        <asp:Label ID="lbDebit" runat="server" Text="Сума вкладу" ToolTip="Сума вкладу по новому договору"></asp:Label>
                    </td>
                    <td nowrap="nowrap">
                        <bars:NumericEdit ID="neNewBalance" runat="server" ReadOnly="true"></bars:NumericEdit>
                    </td>
                </tr>

            </table>
        </asp:Panel>
    </form>
</body>
</html>
