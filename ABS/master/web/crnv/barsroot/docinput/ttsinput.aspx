<%@ Page Language="c#" Inherits="DocInput.TtsInput" EnableViewState="True" CodeFile="ttsinput.aspx.cs"
    CodeFileBaseClass="Bars.BarsPage" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html>
<head>
    <title>Перелік операцій</title>
    <script language="javascript" type="text/javascript">
        function getCookie(par) {
            var pageCookie = document.cookie;
            var pos = pageCookie.indexOf(par + '=');
            if (pos != -1) {
                var start = pos + par.length + 1;
                var end = pageCookie.indexOf(';', start);
                if (end == -1) end = pageCookie.length;
                var value = pageCookie.substring(start, end);
                value = unescape(value);
                return value;
            }
        }
        function sM(id) {
            var obj = document.getElementById('o_' + id);
            if (obj) {
                if (obj.className == 'mo') obj.className = 'mn';
                else obj.className = 'mo';
            }
        }
        function go(tt, id) {
            var date = new Date((new Date()).getTime() + 24 * 3600000);
            document.cookie = 'ttF=' + id + "; expires=" + date.toGMTString();
            location.replace('/barsroot/docinput/docinput.aspx?tt=' + tt);
        }
        function setFolder() {
            var id = getCookie("ttF");
            if (id) {
                sM(0);
                sM(id);
            }
        }
    </script>
    <link href="Styles.css" type="text/css" rel="stylesheet" />
</head>
<body bgcolor="#f0f0f0" onload="setFolder()">
    <table bgcolor="White" border="2" width="100%">
        <tr>
            <td>
                <asp:PlaceHolder ID="listTts" runat="server" EnableViewState="False"></asp:PlaceHolder>
            </td>
        </tr>
    </table>
</body>
</html>
