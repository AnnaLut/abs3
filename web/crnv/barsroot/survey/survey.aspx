<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Survey.aspx.cs" Inherits="Survey" EnableSessionState="True" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Анкетування</title>
    <link href="style/StyleSheet.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" language="javascript" src="js/base.js"></script>    
	<script type="text/javascript" language="javascript" src="js/ck.js"></script>    
	<script type="text/javascript" language="javascript" src="js/form.js"></script>
	<script type="text/javascript" language="javascript" src="js/survey.js"></script>	
    <script type="text/vbscript" language="vbscript" src="js/base.vbs"></script>
	<script type="text/javascript" language="javascript" src="/Common/WebEdit/RadInput.js"></script>	
	<style type="text/css">.webservice { BEHAVIOR: url(/Common/WebService/js/WebService.htc) }</style>
	<script type="text/javascript" language="javascript">var grp;var s_info;</script>
</head>
<body onload="LoadSurvey()">
    <form id="formSurvey" runat="server">
    <table id="tbSurvey" class="MainTable">
        <tr>
            <td align="center">
                <asp:Label ID="lbTitle" runat="server" CssClass="HeaderText" Font-Bold="True" Font-Italic="False"></asp:Label>
            </td>
        </tr>
        <tr>
            <td style="height: 82px">
                <table id="Quest" class="InnerTable" 
                    style="font-size: 12pt; font-family: Arial; text-decoration: none">
                    <tr>
                        <td style="width:5%"></td>
                        <td style="width:35%"></td>
                        <td style="width:50%"></td>
                        <td style="width:10%"></td>
                    </tr>
                    <tr>
                        <td colspan="4" align="left">
                            <asp:Label ID="grp_name" runat="server" CssClass="InfoText" Font-Bold="True" Font-Italic="True"></asp:Label>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td>
                <table class="InnerTable">
                    <tr>
                        <td style="width:50%">
                            <input id="btNext" type="button" value="Далі" class="NextButton" 
                            onclick="if (CkAns()) SubmitGroup()" style="visibility:hidden" />
                        </td>
                        <td style="width:50%">
                            <input id="btPrint" type="button" value="Роздрукувати" class="NextButton" 
                            onclick="PrintSurvey()" style="visibility:hidden"/>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <div class="webservice" id="webService" showProgress="true"/>
    </form>
</body>
</html>
