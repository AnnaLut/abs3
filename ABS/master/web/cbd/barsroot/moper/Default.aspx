<%@ Page Language="C#" AutoEventWireup="true"  CodeFile="Default.aspx.cs" Inherits="_Default" Culture="auto" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Загрузка файла данных</title>
    <link href="CSS/AppCSS.css" rel="Stylesheet" type="text/css" />
    <script src="JScript/Aditional.js" language="javascript" type="text/javascript"></script>
    <script src="JScript/AppJS.js" language="javascript" type="text/javascript"></script>
	<script src="/Common/Script/Sign.js" language="javascript" type="text/javascript"></script>
</head>
<body>
    <form id="frm_Main" runat="server">
        <div>
            <table cellpadding="5" cellspacing="0" border="0" id="tbl_main">
                <tr style="height: 50px">
                    <td align="center" colspan="3" class="title" meta:resourcekey="Label_ImportFilaDocumentovTipaMoper" runat="server">Импорт файла документов типа MOPER</td>
                </tr>
                <tr id="td_MOperFileTitle" runat="server">
                    <td colspan="3"><asp:Label ID="lb_MOper" runat="server" Text="Файл типа MOPER" meta:resourcekey="lb_MOperResource1"></asp:Label></td>
                </tr>
                <tr id="td_MOperFile" runat="server">
                    <td>
                        <asp:FileUpload CssClass="input" ID="ed_MOperFile" runat="server" meta:resourcekey="ed_MOperFileResource1" Width="400px" />
                    </td>                
                    <td>
                        <asp:Button CssClass="input" ID="bt_MOperFileUpload" runat="server" Text="Загрузить" OnClick="bt_MOperFileUpload_Click" meta:resourcekey="bt_MOperFileUploadResource1" />
                    </td>
                    <td style="width: 100%"></td>
                </tr>
                <tr id="td_DataTable" runat="server">
                    <td colspan="3">
                        <asp:Label meta:resourcekey="lbCount" ID="lbCount" runat="server" Text="Количество документов:"></asp:Label>
                        <asp:Label ID="lbCountVal" runat="server" Text="0" Font-Bold="True"></asp:Label>
                        <div id="divFrame" style="height:500px;OVERFLOW:scroll;WIDTH:expression(document.body.clientWidth-12)" >
                            <asp:GridView ID="grd_Data" runat="server" AutoGenerateColumns="False" EmptyDataText=" " ToolTip="Документы для оплаты">
                                <Columns>
                                    <asp:BoundField DataField="REF" HeaderText="Референс" meta:resourcekey="BoundFieldResource1">
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="ND" HeaderText="№ Док" meta:resourcekey="BoundFieldResource2">
                                        <ItemStyle HorizontalAlign="Left" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="MFOA" HeaderText="МФО А" meta:resourcekey="BoundFieldResource3">
                                        <ItemStyle HorizontalAlign="Left" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="NLSA" HeaderText="Счет А" meta:resourcekey="BoundFieldResource4">
                                        <ItemStyle HorizontalAlign="Left" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="OKPOA" HeaderText="ОКПО А" meta:resourcekey="BoundFieldResource5">
                                        <ItemStyle HorizontalAlign="Left" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="S" DataFormatString="{0:###### ##0.00##}" HeaderText="Сумма"
                                        HtmlEncode="False" meta:resourcekey="BoundFieldResource11">
                                        <ItemStyle HorizontalAlign="Right" Wrap="False" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="MFOB" HeaderText="МФО Б" meta:resourcekey="BoundFieldResource7">
                                        <ItemStyle HorizontalAlign="Left" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="NLSB" HeaderText="Счет Б" meta:resourcekey="BoundFieldResource8">
                                        <ItemStyle HorizontalAlign="Left" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="OKPOB" HeaderText="ОКПО Б" meta:resourcekey="BoundFieldResource9">
                                        <ItemStyle HorizontalAlign="Left" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="NAMEB" HeaderText="Получатель" meta:resourcekey="BoundFieldResource10" HtmlEncode="False">
                                        <ItemStyle HorizontalAlign="Left" Wrap="False" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="NAMEA" HeaderText="Плательщик" meta:resourcekey="BoundFieldResource6" HtmlEncode="False">
                                        <ItemStyle HorizontalAlign="Left" Wrap="True" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="NAZN" HeaderText="Назначение" meta:resourcekey="BoundFieldResource12" HtmlEncode="False">
                                        <ItemStyle HorizontalAlign="Left" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="DK" HeaderText="Д/К" meta:resourcekey="BoundFieldResource13">
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="DATD" DataFormatString="{0:dd.MM.yyyy}" HeaderText="Дата док."
                                        HtmlEncode="False" meta:resourcekey="BoundFieldResource14">
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="VDAT" DataFormatString="{0:dd.MM.yyyy}" HeaderText="Дат. Вал."
                                        HtmlEncode="False" meta:resourcekey="BoundFieldResource15">
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="TT" HeaderText="Тип Оп." meta:resourcekey="BoundFieldResource16">
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="VOB" HeaderText="Вид Оп." meta:resourcekey="BoundFieldResource17">
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="FLI" >
                                        <ItemStyle CssClass="GridViewHiddenCol" />
                                        <HeaderStyle CssClass="GridViewHiddenCol" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="INPUTSIGNFLAG" >
                                        <ItemStyle CssClass="GridViewHiddenCol" />
                                        <HeaderStyle CssClass="GridViewHiddenCol" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="NOMINAL" >
                                        <ItemStyle CssClass="GridViewHiddenCol" />
                                        <HeaderStyle CssClass="GridViewHiddenCol" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="SEPBUF" ConvertEmptyStringToNull="False" HtmlEncode="False" >
                                        <ItemStyle CssClass="GridViewHiddenCol" />
                                        <HeaderStyle CssClass="GridViewHiddenCol" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="INTBUF" ConvertEmptyStringToNull="False" HtmlEncode="False" >
                                        <ItemStyle CssClass="GridViewHiddenCol" />
                                        <HeaderStyle CssClass="GridViewHiddenCol" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="PRTY" ConvertEmptyStringToNull="False" HtmlEncode="False" >
                                        <ItemStyle CssClass="GridViewHiddenCol" />
                                        <HeaderStyle CssClass="GridViewHiddenCol" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="KV" ConvertEmptyStringToNull="False" HtmlEncode="False" >
                                        <ItemStyle CssClass="GridViewHiddenCol" />
                                        <HeaderStyle CssClass="GridViewHiddenCol" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="SK" ConvertEmptyStringToNull="False" HtmlEncode="False" >
                                        <ItemStyle CssClass="GridViewHiddenCol" />
                                        <HeaderStyle CssClass="GridViewHiddenCol" />
                                    </asp:BoundField>
                                </Columns>
                                <HeaderStyle BackColor="Transparent" BorderColor="Black" BorderStyle="Solid" BorderWidth="1px"
                                    Font-Bold="True" ForeColor="White" Height="25px" HorizontalAlign="Center" VerticalAlign="Middle"
                                    Wrap="False" />
                            </asp:GridView>
                        </div>
                    </td>                
                </tr>
                <tr id="td_DataTableKeys" runat="server">
                    <td colspan="3">
                        <input type="button" id="bt_Pay" runat="server" value="Імпортувати" meta:resourcekey="Label_Oplatit" onclick="GetSigns();" onserverclick="bt_Pay_ServerClick" class="input" /></td>
                </tr>
                <tr id="td_Err" runat="server">
                    <td colspan="3" id="lb_Err" runat="server" style="font-size: 12pt; color: red; text-align: center;">
                    </td>                
                </tr>
            </table>
        </div>
        <table id="tbl_HiddenControls" style="visibility: hidden">
            <tr>
                <td><input id="AvtomatState"        value="0" type="hidden" runat="server" style="width: 1px" /></td>
                <td><input id="DBFFilePath"         value=" " type="hidden" runat="server" style="width: 1px" /></td>
                <td><input id="DBFFileFirstName"    value=" " type="hidden" runat="server" style="width: 1px" /></td>
                <td><input id="ScriptErrors"        value=" " type="hidden" runat="server" style="width: 1px" /></td>
            </tr>
            <tr>    
                <td><input id="SEPNUM"      value=" " type="hidden" runat="server" style="width: 1px" /></td>
                <td><input id="SIGNTYPE"    value=" " type="hidden" runat="server" style="width: 1px" /></td>
                <td><input id="SIGNLNG"     value=" " type="hidden" runat="server" style="width: 1px" /></td>
                <td><input id="DOCKEY"      value=" " type="hidden" runat="server" style="width: 1px" /></td>
                <td><input id="BDATE"       value=" " type="hidden" runat="server" style="width: 1px" /></td>
            </tr>
            <tr>    
                <td><input id="INTSIGN"     value=" " type="hidden" runat="server" style="width: 1px" /></td>
                <td><input id="REGNCODE"    value=" " type="hidden" runat="server" style="width: 1px" /></td>
                <td><input id="VISASIGN"     value=" " type="hidden" runat="server" style="width: 1px" /></td>
            </tr>
            <tr>    
                <td id="hid_Signs" runat="server"></td>
            </tr>
        </table>
    </form>
</body>
</html>
