<%@ Control Language="C#" AutoEventWireup="true" CodeFile="uc_portfolio.ascx.cs" Inherits="uc_portfolio" %>
<%@ Register Assembly="Bars.Web.Controls" Namespace="Bars.Web.Controls" TagPrefix="cc1" %>
<%@ Register Assembly="WebChart" Namespace="WebChart" TagPrefix="Web" %>
<script type="text/javascript" language="javascript">
function changeStyle() {
    var _div = document.getElementById('full_name');
    if (_div.className == "mo")
    {
	    _div.className = "mn";
	    document.getElementById('btShowMenu').value = "-";
	    document.getElementById('btShowMenu').title = LocalizedString('forbtShowFullName');
    }
    else if (_div.className == "mn")
    {
	    _div.className = "mo";
	    document.getElementById('btShowMenu').value = "+";
	    document.getElementById('btShowMenu').title = LocalizedString('forbtShowFullName2');;
    }
}
</script>
<table id="tblPortfolio" runat="server" style="width:200px;height:100px">
    <tr>
        <td style="width:20%" align="right">
            <asp:Label ID="lbPer" runat="server" Text="Портфель за период" Font-Size="10pt" meta:resourcekey="lbPerResource1"></asp:Label>
        </td>
        <td style="width:10%" align="center">
            <asp:Label ID="lbStart" runat="server" Text="с" Font-Size="8pt" meta:resourcekey="lbStartResource1"></asp:Label>
        </td>
        <td style="width:20%" align="center">
            <cc1:dateedit id="dtStart" runat="server" Date="" MaxDate="2099-12-31" meta:resourcekey="dtStartResource1" MinDate="" TabIndex="2" Text="01/01/0001 00:00:00"></cc1:dateedit>
        </td>
        <td style="width:10%" align="center">
            </td>
        <td style="width:40%" align="center">
            </td>
    </tr>
    <tr>
        <td align="right" style="width: 20%">
            <cc1:ImageTextButton ID="btRefresh" runat="server" ButtonStyle="Image" ImageUrl="\Common\Images\default\16\refresh.png" EnabledAfter="0" meta:resourcekey="btRefreshResource1" OnClick="btRefresh_Click" TabIndex="1" />
        </td>
        <td align="center" style="width: 10%">
            <asp:Label ID="lbEnd" runat="server" Text="по" Font-Size="8pt" meta:resourcekey="lbEndResource1"></asp:Label></td>
        <td align="center" style="width: 20%">
            <cc1:dateedit id="dtFinish" runat="server" Date="" MaxDate="2099-12-31" meta:resourcekey="dtFinishResource1" MinDate="" TabIndex="3" Text="01/01/0001 00:00:00"></cc1:dateedit></td>
        <td align="center" style="width: 10%">
            <input id="btShowMenu" onclick="changeStyle()" tabindex="4"
                title="Показать меню" type="button" value="-" /></td>
        <td align="center" style="width: 20%">
            </td>
    </tr>
    <tr>
        <td style="width:60%" colspan="4">
            <Web:ChartControl ID="cPortfolio" runat="server" BorderStyle="Outset" BorderWidth="5px" meta:resourcekey="cPortfolioResource1" YCustomEnd="0" YCustomStart="0" YValuesInterval="0">
                <YAxisFont StringFormat="Far,Near,Character,LineLimit" />
                <XTitle StringFormat="Center,Near,Character,LineLimit" />
                <ChartTitle StringFormat="Center,Near,Character,LineLimit" />
                <XAxisFont StringFormat="Center,Near,Character,LineLimit" />
                <Background Color="LightSteelBlue" />
                <YTitle StringFormat="Center,Near,Character,LineLimit" />
            </Web:ChartControl>        
        </td>
        <td style="width:40%">
            <div id="div_menu">
                <table style="width:100%; height:100%">
                    <tr>
                        <td colspan="2">
            <asp:DropDownList ID="listType" runat="server" Width="100%" TabIndex="19" meta:resourcekey="listTypeResource1">
                <asp:ListItem Selected="True" Value="0" meta:resourcekey="ListItemResource1">линейчатый график</asp:ListItem>
                <asp:ListItem Value="1" meta:resourcekey="ListItemResource2">столбчатая диаграмма</asp:ListItem>
                <asp:ListItem Value="2" meta:resourcekey="ListItemResource3">гладкий линейчатый график</asp:ListItem>
                <asp:ListItem Value="3" meta:resourcekey="ListItemResource4">сумированная столбчатая диаграмма</asp:ListItem>
                <asp:ListItem Value="4" meta:resourcekey="ListItemResource5">комбинированная гистограмма</asp:ListItem>
                <asp:ListItem Value="5" meta:resourcekey="ListItemResource6">диаграмма рассеивания</asp:ListItem>
                <asp:ListItem Value="6" meta:resourcekey="ListItemResource7">сумированная комбинированная гистограмма</asp:ListItem>
                <asp:ListItem Value="7" meta:resourcekey="ListItemResource8">секторная диаграмма</asp:ListItem>
            </asp:DropDownList></td>
                    </tr>
                    <tr>
                        <td style="width:50%"><asp:CheckBox ID="ckDPTSAL1" runat="server" Font-Size="8pt" Text="Сумма вкладов на начало" Width="100%" Checked="True" meta:resourcekey="ckDPTSAL1Resource1" TabIndex="20" /></td>    
                        <td style="width:50%"><asp:CheckBox ID="ckDPTSAL2" runat="server" Font-Size="8pt" Text="Сумма вкладов на конец" Width="100%" meta:resourcekey="ckDPTSAL2Resource1" TabIndex="21" /></td>                
                    </tr>
                    <tr>
                        <td><asp:CheckBox ID="ckDOSD" runat="server" Font-Size="8pt" Text="Сумма ДТ оборотов по вкладам" Width="100%" meta:resourcekey="ckDOSDResource1" TabIndex="22" /></td>
                        <td><asp:CheckBox ID="ckKOSD" runat="server" Font-Size="8pt" Text="Сумма КТ оборотов по вкладам" Width="100%" meta:resourcekey="ckKOSDResource1" TabIndex="23" /></td>
                    </tr>   
                    <tr>
                        <td><asp:CheckBox ID="ckPERSAL1" runat="server" Font-Size="8pt" Text="Сумма % на начало" Width="100%" meta:resourcekey="ckPERSAL1Resource1" TabIndex="24" /></td>
                        <td><asp:CheckBox ID="ckPERSAL2" runat="server" Font-Size="8pt" Text="Сумма % на конец" Width="100%" meta:resourcekey="ckPERSAL2Resource1" TabIndex="25" /></td>
                    </tr>   
                    <tr>
                        <td><asp:CheckBox ID="ckDOSP" runat="server" Font-Size="8pt" Text="Сумма ДТ оборотов по %" Width="100%" meta:resourcekey="ckDOSPResource1" TabIndex="26" /></td>
                        <td><asp:CheckBox ID="ckKOSP" runat="server" Font-Size="8pt" Text="Сумма КТ оборотов по %" Width="100%" meta:resourcekey="ckKOSPResource1" TabIndex="27" /></td>
                    </tr>   
                    <tr>
                        <td><asp:CheckBox ID="ckRAT1" runat="server" Font-Size="8pt" Text="Средневзвешенная % ставка на начало" Width="100%" meta:resourcekey="ckRAT1Resource1" TabIndex="28" /></td>
                        <td><asp:CheckBox ID="ckRAT2" runat="server" Font-Size="8pt" Text="Средневзвешенная % ставка на конец" Width="100%" meta:resourcekey="ckRAT2Resource1" TabIndex="29" /></td>
                    </tr>   
                    <tr>
                        <td><asp:CheckBox ID="ckACC1" runat="server" Font-Size="8pt" Text="К-во счетов на начало" Width="100%" meta:resourcekey="ckACC1Resource1" TabIndex="30" /></td>
                        <td><asp:CheckBox ID="ckACC2" runat="server" Font-Size="8pt" Text="К-во счетов на конец" Width="100%" meta:resourcekey="ckACC2Resource1" TabIndex="31" /></td>
                    </tr>   
                    <tr>
                        <td><asp:CheckBox ID="ckACCO" runat="server" Font-Size="8pt" Text="Открыто счетов" Width="100%" meta:resourcekey="ckACCOResource1" TabIndex="32" /></td>
                        <td><asp:CheckBox ID="ckACCC" runat="server" Font-Size="8pt" Text="Закрыто счетов" Width="100%" meta:resourcekey="ckACCCResource1" TabIndex="33" /></td>
                    </tr>   
                </table>
            </div>
        </td>
    </tr>
    <tr>
        <td colspan="7">
            <table width="100%">
                <tr>
                    <td style="width:12%" align="left">
                        <asp:RadioButton ID="rTobo" runat="server" Checked="True" GroupName="X" Text="Отделение" Font-Size="8pt" meta:resourcekey="rToboResource1" TabIndex="50" /></td>
                    <td style="width:12%" align="left">
                        <asp:RadioButton ID="rKV" runat="server" GroupName="X" Text="Валюта" Font-Size="8pt" meta:resourcekey="rKVResource1" TabIndex="51" /></td>
                    <td style="width:12%" align="left">
                        <asp:RadioButton ID="rVidd" runat="server" GroupName="X" Text="Вид" Font-Size="8pt" meta:resourcekey="rViddResource1" TabIndex="52" /></td>
                    <td style="width:12%" align="left">
                        <asp:RadioButton ID="rIsp" runat="server" GroupName="X" Text="Исп." Font-Size="8pt" meta:resourcekey="rIspResource1" TabIndex="53" /></td>
                    <td style="width:12%" align="left"><asp:RadioButton ID="rNBS" runat="server" GroupName="X" Text="Бал. счет" Font-Size="8pt" meta:resourcekey="rNBSResource1" TabIndex="54" /></td>
                    <td style="width:20%" align="center"></td>
                    <td style="width:20%" align="center"></td>                        
                </tr>
            </table>
        </td>
    </tr>
</table>
