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
          var ico = document.getElementById('i_' + id);
            if (obj) {
              if (obj.className == 'mo') {
                obj.className = 'mn';
                ico.src = '/Common/Images/default/16/folder-open.gif';
              } else {
                obj.className = 'mo';
                ico.src = '/Common/Images/default/16/folder.gif';
              }
            }
        }
        function go(tt, id) {
            var date = new Date((new Date()).getTime() + 24 * 3600000);
            document.cookie = 'ttF=' + id + "; expires=" + date.toGMTString();
            document.location.href ='/barsroot/docinput/docinput.aspx?tt=' + tt;
        }
        function setFolder() {
            var id = getCookie("ttF");
            if (id) {
                sM(0);
                sM(id);
            }
        }
    </script>
  <style>
    body { font-size: 14px; font-family: "Segoe UI",Arial,Tahoma,Verdana; }
    table.tree .tree-item {
      padding: 2px;color: #395b8d;cursor: pointer;
      font-size: 14px;
    }
    table.tree .tree-item:hover,
    table.tree li span.ms:hover {
       background-color:#ededed ;
    }
    table.tree li {
      list-style-type: none;
    }
    table.tree li span.ms {
      padding: 3px; font-size: 13px;cursor:pointer;
    }

    .mo {DISPLAY: none; MARGIN-LEFT: 15px}
    .mn {DISPLAY: block;MARGIN-LEFT: 15px} 

    .pageTitle {
    font-weight: bold;
    font-size: 12pt;
    margin-top: 10px;
    color: #315173;
    border-bottom: solid 1px #94ABD9;
}

  </style>
</head>
<body onload="setFolder()">
  <div class="pageTitle">
    <span id="lbPageTitle">Список операцій</span>
  </div>
    <table class="tree" border="0" width="100%">
        <tr>
            <td>
                <asp:PlaceHolder ID="listTts" runat="server" EnableViewState="False"></asp:PlaceHolder>
            </td>
        </tr>
    </table>
</body>
</html>
