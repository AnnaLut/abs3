<%@ Page Language="c#" CodeFile="showhistory.aspx.cs" AutoEventWireup="false" Inherits="CustomerList.ShowHistory" EnableViewState="False" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html>
<head>
    <title>Історія рахунку</title>
    <meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
    <meta content="C#" name="CODE_LANGUAGE">
    <meta content="JavaScript" name="vs_defaultClientScript">
    <meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
    <link href="Styles.css" type="text/css" rel="stylesheet">
    <link href="/Common/WebGrid/Grid.css" type="text/css" rel="stylesheet">
    <script language="JavaScript" src="/Common/WebGrid/Grid2005.js"></script>

    <script type="text/javascript" language="javascript" src="/Common/jquery/jquery.js"></script>
    <script type="text/javascript" language="javascript" src="/Common/jquery/jquery-ui.1.8.js"></script>
    <script type="text/javascript" language="javascript" src="/Common/jquery/jquery.alerts.js"></script>
    <script type="text/javascript" language="javascript" src="/Common/jquery/jquery.blockUI.js"></script>
    <script type="text/javascript" language="javascript" src="/Common/jquery/jquery.custom.js"></script>

    <script language="javascript" src="Scripts/AccHistory.js?v1.4"></script>
    <script language="JavaScript" src="Scripts/Common.js?v.1.23"></script>
    <script language="javascript" src="/Common/Script/Localization.js"></script>
    <script language="javascript" src="/Common/WebEdit/RadInput.js"></script>
    <script language="javascript">
        function GetStart() {
            InitAccHist();
            if (document.all.hPrintFlag.value != '1') {
                document.all.btPrintHtml.style.visibility = "hidden";
                document.all.btPrintRtf.style.visibility = "hidden";
            }
            document.getElementById("ed_strDt_TextBox").focus();
        }
        function keyPressInEdit(evnt) {
            if (evnt.keyCode == 13) {
                bt_AcceptDates_click();
            }
        }
    </script>

    <style type="text/css">
        .Grid {
            background-color: #fff;
            margin: 5px 0 10px 0;
            border: solid 1px #525252;
            border-collapse: collapse;
            font-family: Calibri;
            color: #474747;
            width: 100%;
        }

            .Grid td {
                padding: 2px;
                text-align: right;
                border: solid 1px #c1c1c1;
            }

            .Grid th {
                padding: 4px 2px;
                /*width:150px;*/
                color: #fff;
                background: gray;
                border-left: solid 1px #525252;
                font-size: 0.9em;
            }

            .Grid .alt {
                background: #fcfcfc
            }

            .Grid .pgr {
                background: #363670
            }

                .Grid .pgr table {
                    margin: 3px 0;
                }

                .Grid .pgr td {
                    border-width: 0;
                    padding: 0 6px;
                    border-left: solid 1px #666;
                    font-weight: bold;
                    color: #fff;
                    line-height: 12px;
                }

                .Grid .pgr a {
                    color: Gray;
                    text-decoration: none;
                }

                    .Grid .pgr a:hover {
                        color: #000;
                        text-decoration: none;
                    }
    </style>
    <style>
        .selected {
            background: #bdf;
        }
    </style>



</head>
<body onload="GetStart()">
    <form id="Form1" method="post" runat="server">
        <table cellspacing="0" cellpadding="0" width="100%">
            <tr>
                <td style="height: 42px">
                    <table width="100%">
                        <tr>
                            <td align="center">
                                <div class="SmallTitleText" id="Title" style="display: inline" runat="server"></div>
                            </td>
                            <td nowrap width="1">
                                <img id="btPrintHtml" title="Печать выписки по счету за период(html формат)" style='visibility: hidden' onclick="printExtract(0)"
                                    src="/Common/Images/Print.gif"></td>
                            <td nowrap width="1">
                                <img id="btPrintRtf" title="Печать выписки по счету за период(rtf формат)" style='visibility: hidden' onclick="printExtract(1)"
                                    src="/Common/Images/word_2005.gif"></td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td style="border-top: black 2px solid; padding-bottom: 2px; padding-top: 2px; border-bottom: black 2px solid">
                    <table cellspacing="0" cellpadding="0" width="100%">
                        <tr>
                            <td class="BodyCell" runat="server" meta:resourcekey="tdFrom" width="20" style="height: 24px">С :
                            </td>
                            <td onkeypress="keyPressInEdit(event)" width="102" style="height: 24px">
                                <input id="ed_strDt" type="hidden"><input id="ed_strDt_Value" type="hidden" name="ed_strDt"><asp:TextBox ID="ed_strDt_TextBox" Style="text-align: center" TabIndex="2" runat="server" Width="100px"
                                    EnableViewState="False" BorderStyle="Solid" BorderWidth="1px" BorderColor="Black"></asp:TextBox>
                            <td class="BodyCell" runat="server" meta:resourcekey="tdTill" style="width: 20px; height: 24px;">По :
                            </td>
                            <td onkeypress="keyPressInEdit(event)" width="102" style="height: 24px">
                                <input id="ed_endDt" type="hidden"><input id="ed_endDt_Value" type="hidden" name="ed_endDt"><asp:TextBox ID="ed_endDt_TextBox" Style="text-align: center" TabIndex="1" runat="server" Width="100px"
                                    EnableViewState="False" BorderStyle="Solid" BorderWidth="1px" BorderColor="Black"></asp:TextBox>
                            <td style="padding-left: 4px; height: 24px;">
                                <%--<input onkeypress="keyPressInEdit(event)" 
                                        id="bt_AcceptDates" 
                                        meta:resourcekey="bt_AcceptDates" 
                                        style="COLOR: darkred" 
                                        onclick="bt_AcceptDates_click()"
										runat="server" 
                                        tabIndex="3" 
                                        type="button" 
                                        value="Принять">--%>
                                <asp:Button ID="btnAcceptDates"
                                    runat="server"
                                    Text="Застосувати"
                                    OnClientClick="bt_AcceptDates_click()"
                                    OnClick="btnAcceptDates_Click" />

                                <asp:Button ID="btnExcel"
                                    runat="server"
                                    Text="Excel"
                                    OnClick="btnExcel_Click" />

                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td style="padding-top: 2px">
                    <div class="webservice" id="webService" showprogress="true"></div>
                </td>
            </tr>
        </table>
        <input type="hidden" id="hPrintFlag" runat="server" />
        <input runat="server" type="hidden" id="currentPageCulture" meta:resourcekey="currentPageCulture" value="ru" />
        <input runat="server" type="hidden" id="wgPageSizeText" meta:resourcekey="wgPageSizeText" value="Cтрок на странице:" />
        <input runat="server" type="hidden" id="wgPrevPage" meta:resourcekey="wgPrevPage" value="Предыдущая страница" />
        <input runat="server" type="hidden" id="wgNextPage" meta:resourcekey="wgNextPage" value="Следующая страница" />
        <input runat="server" type="hidden" id="wgRowsInTable" meta:resourcekey="wgRowsInTable" value="Количество строк в таблице" />
        <input runat="server" type="hidden" id="wgAscending" meta:resourcekey="wgAscending" value="По возрастанию" />
        <input runat="server" type="hidden" id="wgDescending" meta:resourcekey="wgDescending" value="По убыванию" />
        <input runat="server" type="hidden" id="wgSave" meta:resourcekey="wgSave" value="Сохранить" />
        <input runat="server" type="hidden" id="wgCancel" meta:resourcekey="wgCancel" value="Отмена" />
        <input runat="server" type="hidden" id="wgSetFilter" meta:resourcekey="wgSetFilter" value="Установить фильтр" />
        <input type="hidden" id="wgFilter" value="Фильтр" />
        <input type="hidden" id="wgAttribute" value="Атрибут" />
        <input type="hidden" id="wgOperator" value="Оператор" />
        <input type="hidden" id="wgLike" value="похож" />
        <input type="hidden" id="wgNotLike" value="не похож" />
        <input type="hidden" id="wgIsNull" value="пустой" />
        <input type="hidden" id="wgIsNotNull" value="не пустой" />
        <input type="hidden" id="wgOneOf" value="один из" />
        <input type="hidden" id="wgNotOneOf" value="ни один из" />
        <input type="hidden" id="wgValue" value="Значение" />
        <input type="hidden" id="wgApply" value="Применить" />
        <input type="hidden" id="wgFilterCancel" value="Отменить" />
        <input type="hidden" id="wgCurrentFilter" value="Текущий фильтр:" />
        <input type="hidden" id="wgDeleteRow" value="Удалить строку" />
        <input type="hidden" id="wgDeleteAll" value="Удалить все" />
        <input runat="server" type="hidden" id="forbtPrintHtml" meta:resourcekey="forbtPrintHtml" value="Печать выписки по счету за период(html формат)" />
        <input runat="server" type="hidden" id="forbtPrintRtf" meta:resourcekey="forbtPrintRtf" value="Печать выписки по счету за период(rtf формат)" />
        <asp:HiddenField runat="server" ID="nls_name" />

        <div style="display: block; margin: 10px 0px 0px 0px">
        </div>

        <div style="margin: 10px 0px 0px 0px">
            <asp:ScriptManager ID="ScriptManager1"
                runat="server"
                EnablePageMethods="true"
                EnableScriptGlobalization="false"
                EnableScriptLocalization="True">
            </asp:ScriptManager>
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <asp:GridView ID="gvTable" runat="server" AutoGenerateColumns="false"
                        CssClass="Grid"
                        AlternatingRowStyle-CssClass="alt"
                        PagerStyle-CssClass="pgr" Caption="">
                        <Columns>
                            <%--<asp:BoundField DataField="acc" HeaderText="Ід. рахунку"
                                  SortExpression="acc" />

                                <asp:BoundField DataField="dig" HeaderText="dig"
                                  SortExpression="dig" />--%>

                            <asp:BoundField DataField="CH_FDAT" HeaderText=""
                                SortExpression="CH_FDAT" HeaderStyle-Width="17%" />
                            <asp:TemplateField HeaderText="Вхідн. залиш." SortExpression="CH_OSTF" HeaderStyle-Width="22%">
                                <ItemTemplate>
                                    <asp:Label ID="Label1" runat="server"
                                        Text='<%# String.Format("{0:C2}",Convert.ToDecimal(DataBinder.Eval
                                                        (Container.DataItem, "CH_OSTF"))).Replace(",", " ").Replace("£","")%>'>
                                    </asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Дебет" SortExpression="CH_DOS" HeaderStyle-Width="18%">
                                <ItemTemplate>
                                    <asp:Label ID="Label1" runat="server"
                                        Text='<%# String.Format("{0:C2}",Convert.ToDecimal(DataBinder.Eval
                                                        (Container.DataItem, "CH_DOS"))).Replace(",", " ").Replace("£","")%>'>
                                    </asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Кредит" SortExpression="CH_KOS" HeaderStyle-Width="19%">
                                <ItemTemplate>
                                    <asp:Label ID="Label1" runat="server"
                                        Text='<%# String.Format("{0:C2}",Convert.ToDecimal(DataBinder.Eval
                                                        (Container.DataItem, "CH_KOS"))).Replace(",", " ").Replace("£","")%>'>
                                    </asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Вихідн. залиш." SortExpression="IX" HeaderStyle-Width="24%">
                                <ItemTemplate>
                                    <asp:Label ID="Label1" runat="server"
                                        Text='<%# String.Format("{0:C2}",Convert.ToDecimal(DataBinder.Eval
                                                        (Container.DataItem, "IX"))).Replace(",", " ").Replace("£","")%>'>
                                    </asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="btnAcceptDates" EventName="Click" />
                </Triggers>
            </asp:UpdatePanel>
        </div>

    </form>
</body>
</html>
