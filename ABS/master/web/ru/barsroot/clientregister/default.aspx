<%@ Page language="c#" Inherits="clientregister._default" EnableSessionState="True" enableViewState="False" enableViewStateMac="False" CodeFile="default.aspx.cs" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>Регистрация клиента</title>
		<meta name="GENERATOR" Content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" Content="C#">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
	</HEAD>
	<body onload="funckBodyOnLoad();">
        <style>
            .selTypeClient
            {
                border:1px solid #808080;width:200px;text-align:left;padding:10px 10px 0 10px;font-weight:800;
            }
            .selTypeClient div
            {
                margin:0 0 10px 0; 
            }
                /*++++++++стили для кнопок+++++++++++*/
            .inpButton
            {
                padding: 5px 0 5px 0;
                border: 1px solid #aed0ea;
                background-color: #d7ebf9;
                font-weight: 800;
                color: #0070a3;
                display: block;
                width: 100px;
                font-size: 12px;
            }
            .inpButton:hover
            {
                border: 1px solid #74b2e2;
                background-color: #eef6fc;
            }
            .inpButton:active
            {
                border: 1px solid #74b2e2;
                background-color: #48b0e5;
                color: #fff;
            }

        </style>
        <script>
            
            var clientType = 'person';
            var clientRezId='1';
            var clientSPD= '0';
            function tipeClientClick(clT, clSPD) {
                clientType = clT;
                clientSPD = clSPD;
            }
            function tipeClientRezIdClick(clRID) {
                clientRezId = clRID;
            }
            function inpButtonSubmitClick() {
                location.replace('registration.aspx?client=' + clientType + '&spd=' + clientSPD + '&rezid=' + clientRezId);
            }

            function getParamFromUrl(param, url) {
                url = url.substring(url.indexOf('?') + 1);
                for (i = 0; i < url.split("&").length; i++)
                    if (url.split("&")[i].split("=")[0] == param) return url.split("&")[i].split("=")[1];
                return "";
            }

            function funckBodyOnLoad() {
                var urlcltype = getParamFromUrl('client', document.location.href);
                switch (urlcltype)
                {
                    case 'person':
                        document.getElementById('divRadioUO').style.display = 'none';
                        document.getElementById('divRadioBank').style.display = 'none';
                        break;
                    case 'corp':
                        clientType = 'corp';
                        document.getElementById('RadioUO').checked = true;
                        
                        document.getElementById('divRadioFO').style.display = 'none';
                        document.getElementById('divRadioFOSPD').style.display = 'none';
                        document.getElementById('divRadioBank').style.display = 'none';
                        break;
                    case 'bank':
                        clientType = 'bank';
                        document.getElementById('RadioBank').checked = true;
                        
                        document.getElementById('divRadioFO').style.display = 'none';
                        document.getElementById('divRadioFOSPD').style.display = 'none';
                        document.getElementById('divRadioUO').style.display = 'none';
                        break;
                    case 'all':
                        break;
                    default:
                        break;
                }
            }

        </script>
		<form id="Form1" method="post" runat="server">
			<TABLE id="tb_main" height="100%" cellSpacing="1" cellPadding="1" width="100%" border="0">
				<TR>
					<TD align="center" style="PADDING-TOP: 15%" vAlign="top">
                <div class="selTypeClient">
                    <div id="divRadioFO" onclick="tipeClientClick('person','0');">
                        <input checked="checked" name="tipeClient" id="RadioFO" value="1" type="radio" />
                        <label for="RadioFO">Фізична особа</label>
                    </div>
                    <div id="divRadioFOSPD" onclick="tipeClientClick('person','1');">
                        <input name="tipeClient" id="RadioFOSPD" value="2" type="radio" />
                        <label for="RadioFOSPD">Фізична особа - СПД</label>
                    </div>
                    <div id="divRadioUO" onclick="tipeClientClick('corp','0');">
                        <input name="tipeClient" id="RadioUO" value="2" type="radio" />
                        <label for="RadioUO">Юридична особа</label>
                    </div>
                    <div id="divRadioBank" onclick="tipeClientClick('bank','0');">
                        <input name="tipeClient" id="RadioBank" value="2" type="radio" />
                        <label for="RadioBank">Банк</label>
                    </div>
                    <div style="border-bottom:1px solid #808080"></div>
                    <div onclick="tipeClientRezIdClick('1');">
                        <input checked="checked" name="tipeClientRezId" id="RadioRez" value="1" type="radio" />
                        <label for="RadioRez">Резидент</label>
                    </div>
                    <div onclick="tipeClientRezIdClick('2');">
                        <input name="tipeClientRezId" id="RadioNoRez" value="2" type="radio" />
                        <label for="RadioNoRez">Нерезидент</label>
                    </div>
                    <div style="border-bottom:1px solid #808080"></div>
                    <div style="text-align:center;">
                        <input onclick="inpButtonSubmitClick();" class="inpButton" type="button" value="Реєстрація">
                    </div>
                </div>
					</TD>
				</TR>
			</TABLE>
		</form>
	</body>
</HTML>
