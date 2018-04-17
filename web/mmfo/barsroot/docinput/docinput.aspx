<%@ Page Language="c#" meta:resourcekey="PageResource" Inherits="DocInput.DocInputPage"
    EnableViewState="False" CodeFile="docinput.aspx.cs" CodeFileBaseClass="Bars.BarsPage" %>

<%@ Register Assembly="Bars.Web.Controls" Namespace="Bars.Web.Controls" TagPrefix="cc1" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta content="True" name="vs_snapToGrid" />
    <meta content="True" name="vs_showGrid" />
    <meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR" />
    <meta content="C#" name="CODE_LANGUAGE" />
    <meta content="JavaScript" name="vs_defaultClientScript" />
    <meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema" />
    <link href="Styles.css" type="text/css" rel="stylesheet" />
    <script type="text/javascript" src="/Common/Script/cross.js?v1.0"></script>
    <script type="text/javascript" src="/Common/Script/BarsIe.js?v1.0"></script>
    <script type="text/javascript" src="/Common/Script/Localization.js"></script>
    <script type="text/javascript" src="/Common/WebEdit/NumericEdit.js?v1.0"></script>
    <script type="text/javascript" src="/Common/Script/SignBuf.js?v1.0"></script>
    <script type="text/javascript" src="/barsroot/Scripts/jquery/jquery.min.js"></script>
	<script type="text/javascript" src="/barsroot/Scripts/jquery/jquery.iecors.js"></script>
    <script type="text/javascript" src="/barsroot/Scripts/json3.min.js"></script>
    <script type="text/javascript" src="/Common/WebEdit/RadInput.js?v.10"></script>
    <script type="text/javascript">
        function chkErrMessage(str) {
            if (str.length != "") alert(str);
        }
        function AddListener4Enter() {
            AddListeners("VobList,DocN,Kv_A,Nls_A,Nam_A,Id_A,Mfo_B,Kv_B,Nls_B,Nam_B,Id_B,Sk,CrossRat,SumA,SumB,SumC,DocD_TextBox,Nazn,DatV_TextBox,DatV2_TextBox,Drecs,DrecsTop",
		    'onkeydown', TreatEnterAsTab);
            AddListeners("DocN,Kv_A,Nls_A,Nam_A,Id_A,Mfo_B,Kv_B,Nls_B,Nam_B,Id_B,Sk,CrossRat,SumA,SumB,SumC,DocD_TextBox,DatV_TextBox,DatV2_TextBox,Drecs,DrecsTop",
		    'onfocus', SelectElem);
            AddListeners("Nam_A,Nam_B,Nazn", 'onkeydown', GetBankName);
        }
        function SelectElem() {
            event.srcElement.select();
        }
        function backToFolders() {
            location.replace("/barsroot/docinput/ttsinput.aspx");
        }
        function getNls() {
            event.srcElement.value = document.getElementById('Nls_A').value;
            document.getElementById(event.srcElement.id.replace('NlsTextBox', 'NlsNameTextBox')).value = document.getElementById('Nam_A').value;
        }
        function getSum4CheckTT() {
            if (document.getElementById('<%=sum_check.ClientID%>').value);
            init_numedit("SumC", document.getElementById('<%=sum_check.ClientID%>').value, 2);
        }
        function attach_nls_event(client_id) {
            if (document.getElementById(client_id))
                document.getElementById(client_id).attachEvent("onload", getNls());
        }
        function hideColumn() {
            if (document.getElementById('<%=gvLinkedDocs.ClientID%>')) {
                rows = document.getElementById('<%=gvLinkedDocs.ClientID%>').rows;
                for (i = 0; i < rows.length; i++) {
                    rows[i].cells[0].style.display = "none";
                }
            }
        }

        var el = ""; 

        function checkHotKeys() {
            if (event.keyCode == 123 /*F12*/ || event.keyCode == 122 /*F11*/) {
                event.keyCode = 0;
                event.returnValue = false;
                el = event.srcElement.id;
                setTimeout(function () {
                    var textBoxes = { Nls_A: "Nam_A", Nls_B: "Nam_B", Nazn: "Nazn" };
                    var textBox = textBoxes[el];
                    fnCheckCustomer(textBox);
                }, 3000)
            }
        }

        //функція «співпадіння» щодо виявлення належності клієнта до публічних діячів, осіб близьких або пов’язаними з публічними особами при відкритті РНК клієнту
        function fnCheckCustomer(textbox) {
            //"Nam_A"
            var nmk = document.getElementById(textbox); 

            if (nmk !== null && nmk.value != null && nmk.value !== undefined) {
                $.ajax({
                    type: "POST",
                    url: "/barsroot/clientregister/defaultWebService.asmx/GetPublicFlagCust",
                    data: JSON.stringify({ rnk: null, namels: nmk.value }),
                    error: function (jqXHR, textStatus, errorThrown) {
                        alert("Помилка: " + errorThrown);
                    },
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        var flag = response.d.Flag;
                        if (flag != 0 && flag != -111 /*"-111" - exception*/) {
                            var message = "Увага! Виявлено збіг з переліком публічних діячів № в переліку = " + flag + ", (" + nmk.value + "). \nЗверніться до підрозділу фінансового моніторингу!";
                            alert(message);
                        }
                    }
                });
            }
        }

    </script>
    <script type="text/javascript">
        // скажем обычным контролам трактовать Enter как Tab
        CrossAddEventListener(window, 'onload', AddListener4Enter);
    </script>
</head>
<body bottommargin="5" bgcolor="#f0f0f0" leftmargin="5" topmargin="5" rightmargin="5" onkeydown="checkHotKeys()">
    <form id="DocInputForm" style="width: 100%; height: 100%" runat="server">           
        <table style="width: 580px; height: 552px" border="2">
            <tr valign="top">
                <td nowrap style="vertical-align: top">
                    <img class="outset" id="btNewDoc" title="Перейти к другой операции" onclick="backToFolders()"
                        runat="server" height="16" src="/Common/Images/RECYCLE.gif" align="top">
                    <img class="outset" id="btSameDoc" title="Начать ввод нового документа" style="visibility: hidden"
                        src="/Common/Images/INSERT.gif" align="top">
                    <img class="outset" id="btPrintDoc" title="Напечатать документ" style="visibility: hidden"
                        src="/Common/Images/PRINT.gif" align="top"><img class="solid" id="btMenuPrint" title="Меню печати"
                            style="visibility: hidden" src="/Common/Images/sort_desc.gif" width="12" align="top">
                    <asp:ImageButton ID="btFile" meta:resourcekey="btFile" Height="16" Width="16" Style="visibility: hidden"
                        runat="server" ToolTip="Открыть файл тикета" ImageUrl="/Common/Images/ref_edit.gif"
                        BorderStyle="Outset" BorderWidth="4px"></asp:ImageButton><img class="outset" id="btSaveAlien"
                            title="Сохранить в справочнике" style="visibility: hidden" onclick="fnSaveAlien()"
                            src="/Common/Images/SAVE.gif" align="top" height="16"><img align="top" height="16"
                                width="16" class="outset" id="btBuhModel" title="Показати банківські проводки"
                                style="visibility: hidden" src="/Common/Images/look.gif">&nbsp;&nbsp;<input type="text"
                                    id="OutRef" value="" title="Референс документу" style="vertical-align: top; visibility: hidden; background-color=#f0f0f0; width: 130px"
                                    readonly="readonly" /><img class="outset"
                                        align="top" id="btDuplicate" title="Продублювати документ" style="visibility: hidden"
                                        onclick="DublicateDoc()" src="/Common/Images/COPY.gif" />
                    <span style="width: 220px; text-align: right; vertical-align: top">
                        <asp:TextBox ID="tbZn" runat="server" Width="30px" BackColor="#E0E0E0" ReadOnly="True"
                            Style="text-align: center" Font-Names="Verdana" Font-Bold="True"></asp:TextBox>
                        <asp:TextBox ID="tbOst" runat="server" Width="140px" BackColor="#E0E0E0" ReadOnly="True"
                            Style="text-align: right" Font-Names="Arial"></asp:TextBox>
                    </span>
                    <img class="solid" id="bf12" style="visibility: hidden; vertical-align: top" src="/Common/Images/HELP.gif"
                        onclick="pushF12()">
                </td>
            </tr>
            <tr id="trOptions" style="visibility: hidden; position: absolute">
                <td style="padding-left: 54px">
                    <input runat="server" id="cbPrintTrnModel" onclick="setCookie('prnModelDocInp', ((this.checked) ? (1) : (0)))" style="width: auto; border-width: 0;" type="checkbox" title="Друкувати бух. модель по документу" /><label for="cbPrintTrnModel" style="white-space: nowrap; font-family: Verdana; font-size: 10pt;" title="Друкувати бух. модель по документу">друк бух. моделі</label>&nbsp;
                    <asp:ImageButton runat="server" ID="btFR_PDF" ToolTip="Друк тікету у форматі PDF" ImageUrl="/Common/Images/default/24/pdf-icon.png" Style="visibility: hidden ;margin-bottom:-5px" />
                </td>
            </tr>
            <tr>
                <td align="left">
                    <asp:Label ID="LabelTTName" runat="server" Font-Bold="True" EnableViewState="False"
                        Font-Names="Arial" Font-Size="12pt">Наименование операции</asp:Label>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <table id="DrecsTop" cellspacing="0" cellpadding="0" width="568" border="1" runat="server">
                        <tr>
                            <td></td>
                            <td></td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    <table border="0">
                        <tr>
                            <td style="width: 225px">
                                <asp:DropDownList ID="VobList" TabIndex="1" Width="280px" runat="server">
                                </asp:DropDownList>
                            </td>
                            <td style="width: 40px" align="right">
                                <asp:Label ID="LabelDokNum" EnableViewState="False" Width="21px" Font-Names="Arial"
                                    Font-Size="12pt" runat="server">№</asp:Label>
                            </td>
                            <td style="width: 106px">
                                <asp:TextBox ID="DocN" meta:resourcekey="DocN" TabIndex="1" EnableViewState="False"
                                    Width="100px" runat="server" MaxLength="10" ToolTip="Номер документа"></asp:TextBox>
                            </td>
                            <td align="center">
                                <asp:Label ID="LabelDocDate" meta:resourcekey="LabelDocDate" EnableViewState="False"
                                    Font-Names="Arial" Font-Size="12pt" runat="server">від</asp:Label>
                            </td>
                            <td align="center">
                                <input id="DocD" type="hidden"><input id="DocD_Value" type="hidden" name="DocD"><asp:TextBox
                                    ID="DocD_TextBox" meta:resourcekey="DocD" Style="text-align: center" TabIndex="2"
                                    runat="server" ToolTip="Дата документа" EnableViewState="False" Width="90px"
                                    MaxLength="15"></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td id="tdDebet" runat="server" style="width: 568px; height: 90px">
                    <table id="SideA" runat="server" style="width: 568px; height: 85px" border="1">
                        <tr>
                            <td style="height: 23px" colspan="3">
                                <asp:Label ID="LabelNameA" runat="server" EnableViewState="False" Width="200px" Font-Names="Arial"
                                    Font-Size="12pt" Font-Italic="True">Плательщик</asp:Label>
                            </td>
                            <td style="height: 23px" align="right" colspan="1">
                                <asp:Label ID="LabelDKA" runat="server" Font-Bold="True" EnableViewState="False"
                                    Font-Names="Arial" Font-Size="12pt" ForeColor="Black">ДЕБЕТ</asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:TextBox ID="Id_A" TabIndex="6" runat="server" ToolTip="ОКПО" EnableViewState="False"
                                    Width="81" MaxLength="14" Height="22px"></asp:TextBox>
                            </td>
                            <td>
                                <asp:TextBox ID="Nam_A" TabIndex="5" runat="server" ToolTip="Наименование счета"
                                    EnableViewState="False" Width="298" MaxLength="38" Height="22px"></asp:TextBox>
                            </td>
                            <td align="center">
                                <asp:TextBox ID="Kv_A" TabIndex="3" runat="server" ToolTip="Код валюты" EnableViewState="False"
                                    Width="40px" MaxLength="3" Height="22px"></asp:TextBox>
                            </td>
                            <td style="width: 92px">
                                <asp:TextBox ID="Nls_A" TabIndex="4" runat="server" ToolTip="Счет" EnableViewState="False"
                                    Width="105px" MaxLength="15" Height="22px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" style="height: 28px">
                                <asp:TextBox ID="Bank_A" runat="server" ToolTip="Наименование банка" BorderStyle="None"
                                    EnableViewState="False" Width="386px" Height="22px" ReadOnly="true" BackColor="Transparent"></asp:TextBox>
                            </td>
                            <td style="height: 28px"></td>
                            <td style="width: 108px; height: 28px;">
                                <asp:TextBox ID="Mfo_A" runat="server" ToolTip="МФО банка" BorderStyle="None" EnableViewState="False"
                                    Width="105px" Height="22px" ReadOnly="True" BackColor="Transparent"></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    <table id="Amm" style="width: 568px" border="0">
                        <tr>
                            <td style="width: 150px"></td>
                            <td>
                                <table id="tabSums" runat="server">
                                    <tr id="trSumA" runat="server">
                                        <td style="white-space: nowrap">
                                            <asp:Label ID="LabelSumA" runat="server" Text="Сума " Width="45px" Font-Names="Arial"
                                                Font-Size="11pt"></asp:Label>
                                            <asp:Label ID="LabelSumALcv" runat="server" Text="" Width="30px" Font-Names="Arial"
                                                Font-Size="11pt" Font-Bold="true"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="SumA" meta:resourcekey="SumA" Style="text-align: right" TabIndex="60"
                                                runat="server" ToolTip="Сумма ДЕБЕТ" EnableViewState="False" Width="150px" MaxLength="17"
                                                Height="22px"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="LabelSumС" runat="server" Text="Сума " Width="90px" Font-Names="Arial"
                                                Font-Size="11pt"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="SumC" meta:resourcekey="SumC" Style="text-align: right" TabIndex="62"
                                                runat="server" ToolTip="Сумма платежа" EnableViewState="False" Width="150px"
                                                MaxLength="17" Height="22px"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr id="trSumB" runat="server">
                                        <td style="white-space: nowrap">
                                            <asp:Label ID="LabelSumB" runat="server" Text="Сума " Width="45px" Font-Names="Arial"
                                                Font-Size="11pt"></asp:Label>
                                            <asp:Label ID="LabelSumBLcv" runat="server" Text="" Width="30px" Font-Names="Arial"
                                                Font-Size="11pt" Font-Bold="true"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="SumB" meta:resourcekey="SumB" Style="text-align: right" TabIndex="63"
                                                runat="server" ToolTip="Сумма КРЕДИТ" EnableViewState="False" Width="150px" MaxLength="17"
                                                Height="22px"></asp:TextBox>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td style="width: 130px" align="center" width="130" valign="top">
                                <asp:Label meta:resourcekey="lbNominal" ID="lbNominal" runat="server" Font-Names="Arial"
                                    Font-Size="11pt" Text="Номинал:" Visible="False" Height="23px"></asp:Label>&nbsp;
                            <asp:TextBox ID="CrossRat" meta:resourcekey="CrossRat" Style="text-align: right"
                                TabIndex="61" runat="server" ToolTip="Крос курс" EnableViewState="False" Width="100px"
                                MaxLength="15" Height="22px"></asp:TextBox>
                            </td>
                            <td width="20">
                                <input id="btPayIt" style="width: 40px; height: 40px" tabindex="1000" type="button"
                                    value="OK" runat="server" title="Оплатить">
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td id="tdKredit" runat="server" style="width: 568px; height: 85px">
                    <table id="SideB" runat="server" style="width: 568px" border="1">
                        <tr>
                            <td colspan="3">
                                <asp:Label ID="LabelNameB" runat="server" EnableViewState="False" Width="200px" Font-Names="Arial"
                                    Font-Size="12pt" Font-Italic="True">Получатель</asp:Label>
                            </td>
                            <td align="right" colspan="1">
                                <asp:Label ID="LabelDKB" runat="server" Font-Bold="True" EnableViewState="False"
                                    Font-Names="Arial" Font-Size="12pt" ForeColor="Black">КРЕДИТ</asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:TextBox ID="Id_B" TabIndex="11" runat="server" ToolTip="ОКПО" EnableViewState="False"
                                    Width="81px" MaxLength="14" Height="22px"></asp:TextBox>
                            </td>
                            <td>
                                <asp:TextBox ID="Nam_B" TabIndex="10" runat="server" ToolTip="Наименование счета"
                                    EnableViewState="False" Width="298px" MaxLength="38" Height="22px"></asp:TextBox>
                            </td>
                            <td align="center">
                                <asp:TextBox ID="Kv_B" TabIndex="8" runat="server" ToolTip="Код валюты" EnableViewState="False"
                                    Width="40px" MaxLength="3" Height="22px"></asp:TextBox>
                            </td>
                            <td>
                                <asp:TextBox ID="Nls_B" TabIndex="9" runat="server" ToolTip="Счет" EnableViewState="False"
                                    Width="105px" MaxLength="15" Height="22px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <asp:TextBox ID="Bank_B" runat="server" ToolTip="Наименование банка" BorderStyle="None"
                                    EnableViewState="False" Width="386px" Height="22px" ReadOnly="True" BackColor="Transparent"></asp:TextBox>
                            </td>
                            <td align="right">
                                <asp:TextBox ID="Sk" meta:resourcekey="Sk" TabIndex="12" ToolTip="Символ КасПлана"
                                    EnableViewState="False" Width="25px" runat="server" MaxLength="2"></asp:TextBox>
                            </td>
                            <td nowrap>
                                <asp:TextBox ID="Mfo_B" TabIndex="7" runat="server" ToolTip="МФО банка" EnableViewState="False"
                                    Width="105px" Height="22px"></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr id="trSubAccount" style="display: none">
                <td>
                    <table cellspacing="1" cellpadding="1" width="568" border="1">
                        <tr>
                            <td align="right">Субрахунок:
                            </td>
                            <td style="width: 110px">
                                <input type="text" id="tbSubAccount" title="Субрахунок" style="width: 105px" runat="server" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    <table id="Details" cellspacing="1" cellpadding="1" width="568" border="1" runat="server">
                        <tr>
                            <td nowrap colspan="2">
                                <asp:Label ID="LabelNarrative" meta:resourcekey="LabelNarrative" runat="server"
                                    Font-Names="Arial" Font-Size="12pt" Font-Italic="True">Назначение платежа</asp:Label>
                                <asp:Label
                                    ID="lbHint" meta:resourcekey="lbHint" runat="server"
                                    Font-Names="Verdana" Font-Size="7pt" ForeColor="Maroon">(клик правой клавишей - умолчательное значение)</asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <asp:TextBox ID="Nazn" meta:resourcekey="Nazn" TabIndex="64" runat="server" ToolTip="Назначение  платежа"
                                    EnableViewState="False" Width="558px" onchange="textMaxLength(this, '160');"
                                    onKeyUp="textMaxLength(this, '160');" MaxLength="160" Height="58px" TextMode="MultiLine"
                                    Rows="2"></asp:TextBox>
                            </td>
                        </tr>
                        <tr id="rowDatVal">
                            <td align="center">
                                <asp:Label ID="lbDatVal" meta:resourcekey="lbDatVal" runat="server" EnableViewState="False"
                                    Font-Names="Arial" Font-Size="10pt" Font-Italic="True" Visible="False">Дата вал.</asp:Label>
                                <input id="DatV" type="hidden"><input id="DatV_Value" type="hidden" name="DatV"><asp:TextBox
                                    ID="DatV_TextBox" meta:resourcekey="DatV" Style="text-align: center" TabIndex="54"
                                    runat="server" ToolTip="Дата валютирования" EnableViewState="False" Width="100px"
                                    MaxLength="15" Visible="False"></asp:TextBox>
                            </td>
                            <td align="center">
                                <asp:Label ID="lbDatVal2" meta:resourcekey="lbDatVal2" runat="server" EnableViewState="False"
                                    Font-Names="Arial" Font-Size="10pt" Font-Italic="True" Visible="False">Дата вал. 2</asp:Label>
                                <input id="DatV2" type="hidden"><input id="DatV2_Value" type="hidden" name="DatV"><asp:TextBox
                                    ID="DatV2_TextBox" meta:resourcekey="DatV2" Style="text-align: center" TabIndex="55"
                                    runat="server" ToolTip="Дата валютирования" EnableViewState="False" Width="100px"
                                    MaxLength="15" Visible="False"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:CheckBox runat="server" Text="СТП" ID="cbPriority" Font-Bold="True" Font-Names="Arial"
                                    Font-Size="10pt" meta:resourcekey="cbPriority" Visible="false" />
                            </td>
                            <td>
                                <asp:Label ID="lbFixValues" Visible="false" meta:resourcekey="lbFixValues" runat="server"
                                    Font-Bold="True" Font-Names="Arial" Font-Size="10pt" ForeColor="Red"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 158px" colspan="2">
                                <table id="Drecs" cellspacing="0" cellpadding="0" width="568" border="1" runat="server">
                                    <tr>
                                        <td style="height: 20px"></td>
                                        <td style="height: 20px"></td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:CheckBox runat="server" Text="Наслідувати атрибути платежу для наступних операцій" ID="cbKeepAttribute" Font-Names="Arial" Visible="false" />
                </td>
            </tr>
            <tr>
                <td>
                    <div id="linked_docs" runat="server" style="visibility: hidden">
                        <asp:ScriptManager ID="ScriptManager1" runat="server">
                        </asp:ScriptManager>
                        <asp:UpdatePanel ID="up" runat="server">
                            <ContentTemplate>
                                <asp:GridView ID="gvLinkedDocs" runat="server" AutoGenerateColumns="False" DataSourceID="dsLinkedDocs"
                                    DataKeyNames="ID" Width="580px" OnDataBound="gvLinkedDocs_DataBound">
                                    <Columns>
                                        <asp:CommandField ShowSelectButton="True" SelectText="Вибрати" />
                                        <asp:BoundField DataField="ID" HeaderText="*" SortExpression="ID" />
                                        <asp:BoundField DataField="Sk" HeaderText="СК" SortExpression="Sk" />
                                        <asp:BoundField DataField="S" HeaderText="Сума" SortExpression="S" />
                                        <asp:BoundField DataField="Nazn" HeaderText="Призначення" SortExpression="Nazn" />
                                        <asp:BoundField DataField="Nls" HeaderText="Рахунок" SortExpression="Nls" />
                                        <asp:BoundField DataField="NlsName" HeaderText="Назва рахуноку" SortExpression="NlsName" />
                                    </Columns>
                                    <EmptyDataTemplate>
                                    </EmptyDataTemplate>
                                </asp:GridView>
                                <asp:FormView ID="fvLinkedDocs" runat="server" DataSourceID="dsLinkedDocs_Edit" Width="580px">
                                    <ItemTemplate>
                                        <table style="width: 100%">
                                            <tr>
                                                <td style="width: 40%">ID:
                                                </td>
                                                <td style="width: 60%">
                                                    <asp:Label ID="IDLabel" runat="server" Text='<%# Bind("ID") %>'></asp:Label><br />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="width: 40%">СК:
                                                </td>
                                                <td style="width: 60%">
                                                    <asp:Label ID="SkLabel" runat="server" Text='<%# Bind("Sk") %>'></asp:Label><br />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="width: 40%">Сума:
                                                </td>
                                                <td style="width: 60%">
                                                    <asp:Label ID="SLabel" runat="server" Text='<%# Bind("S") %>'></asp:Label><br />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="width: 40%">Призначення:
                                                </td>
                                                <td style="width: 60%">
                                                    <asp:Label ID="NaznLabel" runat="server" Text='<%# Bind("Nazn") %>'></asp:Label><br />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="width: 40%">Рахунок:
                                                </td>
                                                <td style="width: 60%">
                                                    <asp:Label ID="NlsLabel" runat="server" Text='<%# Bind("Nls") %>'></asp:Label><br />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="width: 40%">Назва рахунку:
                                                </td>
                                                <td style="width: 60%">
                                                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("NlsName") %>'></asp:Label><br />
                                                </td>
                                            </tr>
                                        </table>
                                        <asp:LinkButton ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit"
                                            Text="Редагувати">
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="DeleteButton" runat="server" CausesValidation="False" CommandName="Delete"
                                            Text="Видалити">
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="NewButton" runat="server" CausesValidation="False" CommandName="New"
                                            Text="Додати">
                                        </asp:LinkButton>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <table style="width: 100%">
                                            <tr>
                                                <td style="width: 30%">ID:
                                                </td>
                                                <td style="width: 30%">
                                                    <asp:Label ID="IDLabel" runat="server" Text='<%# Bind("ID") %>'></asp:Label><br />
                                                </td>
                                                <td style="width: 40%"></td>
                                            </tr>
                                            <tr>
                                                <td>СК:
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="SkTextBox" runat="server" onblur="chkCashSymbol_link(document.getElementById(event.srcElement.id.replace('SkTextBox','NaznTextBox')));"
                                                        onfocusin="ShowF12();init_numPlus(event.srcElement.id);AddListeners(event.srcElement.id,'onkeydown', TreatEnterAsTab);"
                                                        onfocusout="HideF12()" onkeydown="selectCashSymbol_link(document.getElementById(event.srcElement.id.replace('SkTextBox','NaznTextBox')))"
                                                        Text='<%# Bind("Sk") %>'>
                                                    </asp:TextBox>
                                                </td>
                                                <td>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="SkTextBox"
                                                        ErrorMessage="Необхідно заповнити" Font-Names="Arial" Font-Size="8pt"></asp:RequiredFieldValidator>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Сума:
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="STextBox" runat="server" onblur="checkSumLength(event);" onfocusin="init_numedit(event.srcElement.id,(''==event.srcElement.value)?(0):(event.srcElement.value),2);AddListeners(event.srcElement.id,'onkeydown', TreatEnterAsTab);"
                                                        Style="text-align: right" Text='<%# Bind("S") %>'>
                                                    </asp:TextBox>
                                                <td>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="STextBox"
                                                        ErrorMessage="Необхідно заповнити" Font-Names="Arial" Font-Size="8pt"></asp:RequiredFieldValidator>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Призначення:
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="NaznTextBox" runat="server" onfocusin="AddListeners(event.srcElement.id,'onkeydown', TreatEnterAsTab);"
                                                        Text='<%# Bind("Nazn") %>'>
                                                    </asp:TextBox>
                                                </td>
                                                <td>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="NaznTextBox"
                                                        ErrorMessage="Необхідно заповнити" Font-Names="Arial" Font-Size="8pt"></asp:RequiredFieldValidator>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Рахунок:
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="NlsTextBox" runat="server" name="NlsTextBox" onfocusin="ShowF12();init_numPlus(event.srcElement.id);getNls();AddListeners(event.srcElement.id,'onkeydown', TreatEnterAsTab);"
                                                        onfocusout="HideF12();getNls()" onblur="chkAccount_link(form,event.srcElement,document.getElementById(event.srcElement.id.replace('NlsTextBox','NlsNameTextBox')));getNls()"
                                                        onkeydown="selectAccounts_link(event, event.srcElement, 1, event.srcElement.id, event.srcElement.id.replace('NlsTextBox','NlsNameTextBox'), 1)"
                                                        Text='<%# Bind("Nls") %>'>
                                                    </asp:TextBox>
                                                </td>
                                                <td>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="NlsTextBox"
                                                        ErrorMessage="Необхідно заповнити" Font-Names="Arial" Font-Size="8pt"></asp:RequiredFieldValidator>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Назва рахунку:
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="NlsNameTextBox" runat="server" name="NlsNameTextBox" onblur="getNls();"
                                                        onfocusin="AddListeners(event.srcElement.id,'onkeydown', TreatEnterAsTab);" Text='<%# Bind("NlsName") %>'>
                                                    </asp:TextBox>
                                                </td>
                                                <td>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="NlsNameTextBox"
                                                        ErrorMessage="Необхідно заповнити" Font-Names="Arial" Font-Size="8pt"></asp:RequiredFieldValidator>
                                                </td>
                                            </tr>
                                        </table>
                                        <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update"
                                            Text="Зберегти">
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel"
                                            Text="Відмінити">
                                        </asp:LinkButton>
                                    </EditItemTemplate>
                                    <InsertItemTemplate>
                                        <table style="width: 100%">
                                            <tr>
                                                <td style="width: 30%">*СК:
                                                </td>
                                                <td style="width: 30%">
                                                    <asp:TextBox ID="SkTextBox" runat="server" onblur="chkCashSymbol_link(document.getElementById(event.srcElement.id.replace('SkTextBox','NaznTextBox')))"
                                                        onfocusin="ShowF12();init_numPlus(event.srcElement.id);AddListeners(event.srcElement.id,'onkeydown', TreatEnterAsTab);"
                                                        onfocusout="HideF12()" onkeydown="selectCashSymbol_link(document.getElementById(event.srcElement.id.replace('SkTextBox','NaznTextBox')))"
                                                        Text='<%# Bind("Sk") %>'>
                                                    </asp:TextBox>
                                                </td>
                                                <td style="width: 40%">
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="SkTextBox"
                                                        ErrorMessage="Необхідно заповнити" Font-Names="Arial" Font-Size="8pt"></asp:RequiredFieldValidator>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>*Сума:
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="STextBox" runat="server" onblur="checkSumLength(event);" onfocusin="init_numedit(event.srcElement.id,(''==event.srcElement.value)?(0):(event.srcElement.value),2);AddListeners(event.srcElement.id,'onkeydown', TreatEnterAsTab);"
                                                        Style="text-align: right" Text='<%# Bind("S") %>'>
                                                    </asp:TextBox>
                                                <td>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="STextBox"
                                                        ErrorMessage="Необхідно заповнити" Font-Names="Arial" Font-Size="8pt"></asp:RequiredFieldValidator>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>*Призначення:
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="NaznTextBox" runat="server" onfocusin="AddListeners(event.srcElement.id,'onkeydown', TreatEnterAsTab);"
                                                        Text='<%# Bind("Nazn") %>'>
                                                    </asp:TextBox>
                                                </td>
                                                <td>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="NaznTextBox"
                                                        ErrorMessage="Необхідно заповнити" Font-Names="Arial" Font-Size="8pt"></asp:RequiredFieldValidator>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>*Рахунок:
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="NlsTextBox" runat="server" onfocusin="ShowF12();init_numPlus(event.srcElement.id);getNls();AddListeners(event.srcElement.id,'onkeydown', TreatEnterAsTab);"
                                                        onfocusout="HideF12();getNls();" onblur="chkAccount_link(form,event.srcElement,document.getElementById(event.srcElement.id.replace('NlsTextBox','NlsNameTextBox')));getNls();"
                                                        onkeydown="selectAccounts_link(event, event.srcElement, 1, event.srcElement.id, event.srcElement.id.replace('NlsTextBox','NlsNameTextBox'), 1)"
                                                        Text='<%# Bind("Nls") %>'>
                                                    </asp:TextBox>
                                                </td>
                                                <td>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ControlToValidate="NlsTextBox"
                                                        ErrorMessage="Необхідно заповнити" Font-Names="Arial" Font-Size="8pt"></asp:RequiredFieldValidator>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>*Назва рахунку:
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="NlsNameTextBox" runat="server" name="NlsNameTextBox" onfocusin="AddListeners(event.srcElement.id,'onkeydown', TreatEnterAsTab);"
                                                        onblur="getNls();" Text='<%# Bind("NlsName") %>'>
                                                    </asp:TextBox>
                                                </td>
                                                <td>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ControlToValidate="NlsNameTextBox"
                                                        ErrorMessage="Необхідно заповнити" Font-Names="Arial" Font-Size="8pt"></asp:RequiredFieldValidator>
                                                </td>
                                            </tr>
                                        </table>
                                        <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert"
                                            Text="Додати">
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel"
                                            Text="Відмінити">
                                        </asp:LinkButton>
                                    </InsertItemTemplate>
                                    <EmptyDataTemplate>
                                        <asp:LinkButton ID="NewButton" runat="server" CausesValidation="False" CommandName="New"
                                            Text="Додати">
                                        </asp:LinkButton>
                                    </EmptyDataTemplate>
                                </asp:FormView>
                                <input id="sum_check" type="hidden" runat="server" />
                            </ContentTemplate>
                        </asp:UpdatePanel>
                        <asp:ObjectDataSource ID="dsLinkedDocs" runat="server" SelectMethod="SelectDocs"
                            TypeName="Bars.LinkDocs.LinkedDocs" DeleteMethod="DeleteDoc" InsertMethod="InsertDoc"
                            UpdateMethod="UpdateDoc">
                            <DeleteParameters>
                                <asp:Parameter Name="ID" Type="Int32" />
                            </DeleteParameters>
                            <UpdateParameters>
                                <asp:Parameter Name="ID" Type="Int32" />
                                <asp:Parameter Name="Sk" Type="Decimal" />
                                <asp:Parameter Name="S" Type="String" />
                                <asp:Parameter Name="Nazn" Type="String" />
                                <asp:Parameter Name="Nls" Type="String" />
                                <asp:Parameter Name="NlsName" Type="String" />
                            </UpdateParameters>
                            <InsertParameters>
                                <asp:Parameter Name="Sk" Type="Decimal" />
                                <asp:Parameter Name="S" Type="String" />
                                <asp:Parameter Name="Nazn" Type="String" />
                                <asp:Parameter Name="Nls" Type="String" />
                                <asp:Parameter Name="NlsName" Type="String" />
                            </InsertParameters>
                        </asp:ObjectDataSource>
                        <asp:ObjectDataSource ID="dsLinkedDocs_Edit" runat="server" DeleteMethod="DeleteDoc"
                            InsertMethod="InsertDoc" SelectMethod="SelectDoc" TypeName="Bars.LinkDocs.LinkedDocs"
                            UpdateMethod="UpdateDoc">
                            <DeleteParameters>
                                <asp:Parameter Name="ID" Type="Int32" />
                            </DeleteParameters>
                            <UpdateParameters>
                                <asp:Parameter Name="ID" Type="Int32" />
                                <asp:Parameter Name="Sk" Type="Decimal" />
                                <asp:Parameter Name="S" Type="String" />
                                <asp:Parameter Name="Nazn" Type="String" />
                                <asp:Parameter Name="Nls" Type="String" />
                                <asp:Parameter Name="NlsName" Type="String" />
                            </UpdateParameters>
                            <InsertParameters>
                                <asp:Parameter Name="Sk" Type="Decimal" />
                                <asp:Parameter Name="S" Type="String" />
                                <asp:Parameter Name="Nazn" Type="String" />
                                <asp:Parameter Name="Nls" Type="String" />
                                <asp:Parameter Name="NlsName" Type="String" />
                            </InsertParameters>
                            <SelectParameters>
                                <asp:ControlParameter ControlID="gvLinkedDocs" Name="ID" PropertyName="SelectedValue"
                                    Type="Int32" />
                            </SelectParameters>
                        </asp:ObjectDataSource>
                        <input id="h_nls" type="hidden" runat="server" />
                        <input id="h_nms" type="hidden" runat="server" />
                    </div>
                </td>
            </tr>
        </table>
        <table style="display: none; visibility: hidden;">
            <tr>
                <td>
                    <input id="Mand_Drecs_ids" type="hidden" runat="server" />
                </td>
                <td>
                    <input id="Drecs_ids" type="hidden" runat="server" />
                </td>
                <td>
                    <input id="__BDATE" type="hidden" runat="server" />
                    <input id="__RNK_A" type="hidden" runat="server" />
                    <input id="__RNK_B" type="hidden" runat="server" />
                    <input id="__IS_NEED_CHECK_TT" type="hidden" runat="server" />
                </td>
                <td>
                    <input id="__BDATEF" type="hidden" runat="server" />
                </td>
                <td>
                    <input id="__WARNPAY" type="hidden" runat="server" />
                    <input id="__DEPUP" type="hidden" runat="server" />
                    <input id="__SIGN_MIXED_MODE" type="hidden" runat="server" />
                    <input id="__USER_SIGN_TYPE" type="hidden" runat="server" />
                    <input id="__USER_KEYID" type="hidden" runat="server" />
                    <input id="__USER_KEYHASH" type="hidden" runat="server" />
                    <input id="__CRYPTO_USE_VEGA2" type="hidden" runat="server" />
                    <input id="__CRYPTO_CA_KEY" type="hidden" runat="server" />
                </td>
            </tr>
            <tr>
                <td>
                    <input id="__fixValues" type="hidden" value="0" runat="server" />
                </td>
                <td>
                    <input id="__IS_QDOC" type="hidden" runat="server" />
                </td>
                <td>
                    <input id="__QDOC_DATP" type="hidden" runat="server" />
                </td>
                <td>
                    <input id="__DATP" type="hidden" runat="server" />
                </td>
                <td>
                    <input id="__VOB2SEP2" type="hidden" runat="server" />
                </td>
            </tr>
            <tr>
                <td>
                    <input id="__ERRMESS" type="hidden" runat="server" />
                </td>
                <td>
                    <input id="__DOCSIGN" type="hidden" runat="server" />
                </td>
                <td>
                    <input id="__DOCSIGN_INT" type="hidden" runat="server" />
                </td>
                <td>
                    <input id="__ND" type="hidden" runat="server" />
                </td>
                <td>
                    <input id="Drec" type="hidden" runat="server" />
                </td>
            </tr>
            <tr>
                <td>
                    <input id="__DOCKEY" type="hidden" runat="server" />
                </td>
                <td>
                    <input id="__DOCREF" type="hidden" runat="server" />
                    <input id="__FR_TMPL" type="hidden" runat="server" />
                    <input id="__FR_BM" type="hidden" runat="server" />
                </td>
                <td>
                    <input id="__NAZN" type="hidden" runat="server" />
                </td>
                <td>
                    <input id="__VOBCONFIRM" type="hidden" runat="server" />
                </td>
                <td>
                    <input id="NaznK" type="hidden" runat="server" />
                </td>
            </tr>
            <tr>
                <td>
                    <input id="__INTSIGN" type="hidden" runat="server" />
                </td>
                <td>
                    <input id="__TT" type="hidden" runat="server" />
                </td>
                <td>
                    <input id="__DIGB" type="hidden" runat="server" />
                </td>
                <td>
                    <input id="__TICTOFILE" type="hidden" runat="server" />
                </td>
                <td>
                    <input id="NaznS" type="hidden" runat="server" />
                </td>
            </tr>
            <tr>
                <td>
                    <input id="__VISASIGN" type="hidden" runat="server" />
                </td>
                <td>
                    <input id="__SIGNTYPE" type="hidden" runat="server" />
                </td>
                <td>
                    <input id="__SEPNUM" type="hidden" runat="server" />
                </td>
                <td>
                    <input id="__VOB2SEP" type="hidden" runat="server" />
                </td>
                <td>
                    <input id="__VDATE" type="hidden" runat="server" />
                </td>
            </tr>
            <tr>
                <td>
                    <input id="__OURMFO" type="hidden" runat="server" />
                </td>
                <td>
                    <input id="__OSTB" type="hidden" runat="server" />
                </td>
                <td>
                    <input id="__SIGNCC" type="hidden" runat="server" />
                </td>
                <td>
                    <input id="__DK" type="hidden" runat="server" />
                </td>
                <td>
                    <input id="Bis" type="hidden" value="0" runat="server" />
                </td>
            </tr>
            <tr>
                <td>
                    <input id="__DIGA" type="hidden" runat="server" />
                </td>
                <td>
                    <input id="__PAP" type="hidden" runat="server" />
                </td>
                <td>
                    <input id="__REGNCODE" type="hidden" runat="server" />
                </td>
                <td>
                    <input id="__FLAGS" type="hidden" runat="server" />
                </td>
            </tr>
            <tr>
                <td>
                    <input id="__BARSAXVER" type="hidden" runat="server" />
                    <input id="__VALIDATE_MODE" type="hidden" runat="server" />
                </td>
                <td>
                    <input id="__OSTC" type="hidden" runat="server" />
                </td>
                <td>
                    <input id="__CERTNAME" type="hidden" runat="server" />
                </td>
                <td>
                    <input id="__BANKNAME" type="hidden" runat="server" />
                    <input id="__BANKOKPO" type="hidden" runat="server" />
                </td>
                <td>
                    <input id="__ISSWI" type="hidden" runat="server" />
                    <input id="__SWINAZN" type="hidden" runat="server" />
                    <input id="__SWIOB22_2909" type="hidden" runat="server" />
                    <input id="__SWIOB22_2809" type="hidden" runat="server" />
                    <input id="__SWIOB22_KOM" type="hidden" runat="server" />
                </td>
            </tr>
            <tr>
                <td>
                    <input id="Message1" meta:resourcekey="Message1" type="hidden" runat="server" value="Неверный контрольный разряд!" />
                </td>
                <td>
                    <input id="Message2" meta:resourcekey="Message2" type="hidden" runat="server" value="Данные успешно сохранены в справочнике!" />
                </td>
                <td>
                    <input id="Message3" meta:resourcekey="Message3" type="hidden" runat="server" value="Документ успешно принят!" />
                </td>
                <td>
                    <input id="Message4" meta:resourcekey="Message4" type="hidden" runat="server" value="Референс " />
                </td>
            </tr>
            <tr>
                <td>
                    <input id="Message5" meta:resourcekey="Message5" type="hidden" runat="server" value="Невозможно вычислить назначение по умолчанию!" />
                </td>
                <td>
                    <input id="Message6" meta:resourcekey="Message6" type="hidden" runat="server" value="Невозможно вычислить формулу!" />
                </td>
                <td>
                    <input id="Message7" meta:resourcekey="Message7" type="hidden" runat="server" value="Счет не найден " />
                </td>
                <td>
                    <input id="Message8" meta:resourcekey="Message8" type="hidden" runat="server" value="Вы действительно хотите ввести документ с тикетом " />
                </td>
            </tr>
            <tr>
                <td>
                    <input id="Message9" meta:resourcekey="Message9" type="hidden" runat="server" value="Сумма документа превышает остаток на счете. Продолжить?" />
                </td>
                <td>
                    <input id="Message10" meta:resourcekey="Message10" type="hidden" runat="server" value="Меньше " />
                </td>
                <td>
                    <input id="Message11" meta:resourcekey="Message11" type="hidden" runat="server" value=" символов." />
                </td>
                <td>
                    <input id="Message12" meta:resourcekey="Message12" type="hidden" runat="server" value="Значение должно быть числовым." />
                </td>
            </tr>
            <tr>
                <td>
                    <input id="Message13" meta:resourcekey="Message13" type="hidden" runat="server" value="Ошибка контрольного разряда ОКПО." />
                </td>
                <td>
                    <input id="Message14" meta:resourcekey="Message14" type="hidden" runat="server" value="Ошибка суммы." />
                </td>
                <td>
                    <input id="Message15" meta:resourcekey="Message15" type="hidden" runat="server" value="Необходимо заполнить дополнительный реквизит!" />
                </td>
                <td>
                    <input id="Message16" meta:resourcekey="Message16" type="hidden" runat="server" value="Недопустимое значение реквизита " />
                </td>
            </tr>
            <tr>
                <td>
                    <input id="Message17" meta:resourcekey="Message17" type="hidden" runat="server" value="Неккоректно заполнены поля счетов и кодов валют." />
                </td>
                <td>
                    <input id="Message18" meta:resourcekey="Message18" type="hidden" runat="server" value="Символ касплана должен быть числовым!" />
                </td>
                <td>
                    <input id="Message19" meta:resourcekey="Message19" type="hidden" runat="server" value="Недопустимый символ касплана!" />
                </td>
                <td>
                    <input id="Message20" meta:resourcekey="Message20" type="hidden" runat="server" value="Не обнаружено необходимых для цифровой подписи компонентов. \n После установки предложенных компонент повторите оплату." />
                </td>
            </tr>
            <tr>
                <td>
                    <input id="Message21" meta:resourcekey="Message21" type="hidden" runat="server" value="Система безопасности НЕ инициализирована.\nВозможно не установлены все необходимые компоненты. Показать окно загрузки компонент?" />
                </td>
                <td>
                    <input id="Message22" meta:resourcekey="Message22" type="hidden" runat="server" value="Ошибки при наложении ЭЦП" />
                </td>
                <td>
                    <input id="Message23" meta:resourcekey="Message23" type="hidden" runat="server" value="Невозможно создать элемент ActiveX для определения версии Windows Installer." />
                </td>
                <td>
                    <input id="Message24" meta:resourcekey="Message24" type="hidden" runat="server" value="Назначение платежа больше 160 знаков(текущая длина " />
                </td>
            </tr>
            <tr>
                <td>
                    <input id="Message25" meta:resourcekey="Message25" type="hidden" runat="server" value="Сумма платежа должна быть меньше 15 символов(без запятой). " />
                </td>
                <td>
                    <input id="Message26" meta:resourcekey="Message26" type="hidden" runat="server" value="Первичный документ полностью совпадает с информационным запросом. Удалить информационный запрос?" />
                </td>
                <td>
                    <input id="Message27" meta:resourcekey="Message27" type="hidden" runat="server" value="Сформировать информационный запрос, уточняющий ОКПО(код) получателя?" />
                </td>
                <td>
                    <input id="Message28" meta:resourcekey="Message28" type="hidden" runat="server" value="Сформировать информационный запрос, уточняющий СЧЕТ получателя?" />
                </td>
            </tr>
            <tr>
                <td>
                    <input id="Message29" meta:resourcekey="Message29" type="hidden" runat="server" value="Отредактировано более одного реквизита. Сформировать информационный запрос на возврат документа?" />
                </td>
                <td>
                    <input id="Message30" meta:resourcekey="Message30" type="hidden" runat="server" value="Ошибка определения доп.реквизита СЭП" />
                </td>
                <td>
                    <input id="forbtPayIt" meta:resourcekey="forbtPayIt" type="hidden" runat="server"
                        value="Оплатить" />
                </td>
                <td>
                    <input id="forbtMenuPrint" meta:resourcekey="forbtMenuPrint" type="hidden" runat="server"
                        value="Меню печати" />
                </td>
            </tr>
            <tr>
                <td>
                    <input id="forbtNewDoc" meta:resourcekey="forbtNewDoc" type="hidden" runat="server"
                        value="Перейти к другой операции" />
                </td>
                <td>
                    <input id="forbtPrintDoc" meta:resourcekey="forbtPrintDoc" type="hidden" runat="server"
                        value="Напечатать документ" />
                </td>
                <td>
                    <input id="forbtSameDoc" meta:resourcekey="forbtSameDoc" type="hidden" runat="server"
                        value="Начать ввод нового документа" />
                </td>
                <td>
                    <input id="forbtSaveAlien" meta:resourcekey="forbtSaveAlien" type="hidden" runat="server"
                        value="Сохранить в справочнике" />
                </td>
            </tr>
            <tr>
                <td>
                    <input id="qDocsNaznOkpo" type="hidden" runat="server" />
                </td>
                <td>
                    <input id="qDocsNaznNls" type="hidden" runat="server" />
                </td>
                <td>
                    <input id="qDocsNaznReturn" type="hidden" runat="server" />
                </td>
                <td>
                    <input id="qDocsTT_dk2" type="hidden" runat="server" />
                </td>
            </tr>
            <tr>
                <td>
                    <input id="qDocsTT_dk3" type="hidden" runat="server" />
                </td>
                <td>
                    <input id="Message31" meta:resourcekey="Message31" type="hidden" runat="server" value="Не найден код валюты " />
                </td>
                <td>
                    <input id="Message32" meta:resourcekey="Message32" type="hidden" runat="server" value="Дата должна быть в пределах 10 дней от банковской." />
                </td>
                <td>
                    <input id="Message33" meta:resourcekey="Message33" type="hidden" runat="server" value="Дата валютирования отличается от текущей. Продолжить?" />
                </td>
                <td>
                    <input id="Message34" meta:resourcekey="Message34" type="hidden" runat="server" value="Необходимо внести изменения либо в ОКПО, либо в номер счета"/>
                </td>
            </tr>
            <tr>
            </tr>
            <tr>
            </tr>
        </table>
    <input type="hidden" id="__Nls_B" runat="server"/>
    <input type="hidden" id="__Id_B" runat="server"/>
    </form>
    <script type="text/javascript">
        AddListeners("SumA", 'onblur', SumA_Blur);
        AddListeners("SumB", 'onblur', SumB_Blur);
        AddListeners("SumC", 'onblur', SumC_Blur);
        //AddListeners("CrossRat",'onblur', CRat_Blur);
    </script>
    <div id="dF12" meta:resourcekey="dF12" runat="server" style="border-right: black 1px solid; border-top: black 1px solid; display: block; z-index: 101; background: #f7f6f6; left: 0px; visibility: hidden; padding-bottom: 0px; border-left: black 1px solid; padding-top: 0px; border-bottom: black 1px solid; position: absolute; top: 0px">
        F12-Справочник
    </div>
    <div class="webservice" id="webService" showprogress="true">
    </div>
</body>
</html>
