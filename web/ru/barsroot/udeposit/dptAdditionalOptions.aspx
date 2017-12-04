<%@ Page Language="C#" CodeFile="dptAdditionalOptions.aspx.cs" Inherits="barsroot.udeposit.DptAdditionalOptions" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Додаткові параметри депозиту</title>
    <link href="Styles.css" type="text/css" rel="stylesheet" />
    <script type="text/javascript" language="JavaScript" src="Scripts/DptAdditionalOptions.js?v1.0.2"></script>
    <script type="text/javascript" language="JavaScript" src="Scripts/Common.js?v1.1"></script>
    <script type="text/javascript" src="/barsroot/Scripts/jquery/jquery.min.js"></script>
    <script type="text/javascript" src="/barsroot/Scripts/bars/bars.ui.js"></script>
</head>
<body>
    <form id="dptAdditionalOptionsForm" runat="server">
        <table>
            <tr>
                <td>
                    <asp:Panel ID="pnConfidant" runat="server" GroupingText="Довірена особа">
                        <table width="100%">
                            <tr>
                                <td align="right">
                                    <span class="BarsLabel" id="lbConfidantName">Назва:</span>
                                </td>
                                <td colspan="2">
                                    <input id="tbConfidantName" class="BarsTextBoxRO" readonly="readonly" style="width: 99%" 
                                        title="Назва довіреної особи" type="text" />
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <span class="BarsLabel" id="lbConfidantPosition">Посада:</span>
                                </td>
                                <td class="auto-style1">
                                    <input id="tbConfidantPosition" class="BarsTextBoxRO" readonly="readonly" style="width: 500px" 
                                        title="Посада довіреної особи" type="text" />
                                </td>
                                <td rowspan="2" align="center" valign="middle">
                                    <button type="button" id="btConfidant" style="height: 45px; width: 45px"
                                        onclick="fnConfidant()" title="Вибір довіреної особи клієнта">
                                        <img src="/Common/Images/CUSTPERS.gif" alt="Confidant"/>
                                    </button>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <span class="BarsLabel" id="lbConfidantDoc">Документ:</span>
                                </td>
                                <td>
                                    <input id="tbConfidantDoc" class="BarsTextBoxRO" readonly="readonly" style="width:500px" 
                                        title="Реквізити документу довіреної особи" type="text" />
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                </td>
            </tr>
            <tr>
                <td>
                    <div style="overflow: auto; vertical-align: top">
                        <table id="tbAddOptions" style="font-size: 8pt; border-color:black;
                            width: 100%; cursor: pointer; font-family: Verdana; border-collapse: collapse;
                            background-color: white" bordercolor="black" cellspacing="0" cellpadding="2" border="1">
                            <caption class="BarsLabel">Додаткові параметри договору</caption>
                            <thead>
                                <tr style="font-weight: bold; font-size: 8pt; color: white; font-family: Verdana;
                                    background-color: gray" align="center">
                                    <th width="459px">
                                        <span id="spHeaderName" class="BarsLabel">Назва додаткового параметру</span>
                                    </th>
                                    <th align="center" colspan="2">
                                        <span id="spHeaderValue" class="BarsLabel">Значення</span>
                                    </th>
                                </tr>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Panel ID="pnComments" runat="server" GroupingText="Коментар">
                       <table>
                           <tr>
                               <td>
                                   <asp:TextBox ID="tbComments" runat="server" Width="648px" ToolTip="Коментар" Rows="3"
                                       TextMode="MultiLine" BackColor="Info" TabIndex="100" MaxLength="128" />
                               </td>
                           </tr>
                       </table>
                   </asp:Panel>
                </td>
            </tr>
            <tr>
                <td>
                    <table width="99%">
                        <tr>
                            <td align="center" valign="middle">
                                <input id="btSave" name="btSave" type="button" style="width: 200px; color:green; font-weight:bold"
                                    tabindex="3" onclick="fnSave()" value="Зберегти" title="Зберегти зміни та вийти" />
                            </td>
                            <td align="center" valign="middle">
                                <input id="btCancel" name="btCancel" type="button" style="width: 200px; color:red; font-weight: bold"
                                    tabindex="4" onclick="fnCancel()" value="Відмінити" title="Вийти без збереження змін" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <div class="webservice" id="webService" showprogress="true">
        </div>
    </form>
</body>
</html>
