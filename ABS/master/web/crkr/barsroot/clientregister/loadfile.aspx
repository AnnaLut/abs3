<%@ Page Language="C#" AutoEventWireup="true" CodeFile="loadfile.aspx.cs" Inherits="LoadFile" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Файл графического образа</title>
    <base target="_self" />
    <link rel="Stylesheet" type="text/css" href="/Common/CSS/AppCSS.css" />
    <script language="javascript" type="text/javascript" src="LoadFileScript.js"></script>
    <style type="text/css">
        img
        {        
            width: 100px;
        }
        td
        {
	        font-weight: bold;
	        font-size: 12pt;
	        vertical-align: middle;
	        font-family: Arial;
	        text-align: center;
        }    
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <table id="tblMain" border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td>Добавить новый образ</td>            
            </tr>
            <tr>
                <td style="border-bottom: black 2px solid; padding-bottom: 20px">
                    <asp:FileUpload ID="fuNew" runat="server" Width="500px" />
                    <asp:Button ID="btApplyNew" runat="server" Text="Принять" OnClick="btApplyNew_Click" />
                </td>            
            </tr>
            <tr>
                <td style="padding-top: 20px">
                    <asp:GridView ID="gvMain" runat="server" AutoGenerateColumns="False">
                        <Columns>
                            <asp:BoundField DataField="NO0" HeaderText="№" ReadOnly="True" ></asp:BoundField>
                            <asp:ImageField DataImageUrlField="IMG0" HeaderText="Образ"></asp:ImageField>
                            <asp:BoundField DataField="NO1" HeaderText="№" ReadOnly="True" ></asp:BoundField>
                            <asp:ImageField DataImageUrlField="IMG1" HeaderText="Образ"></asp:ImageField>
                            <asp:BoundField DataField="NO2" HeaderText="№" ReadOnly="True" ></asp:BoundField>
                            <asp:ImageField DataImageUrlField="IMG2" HeaderText="Образ"></asp:ImageField>
                            <asp:BoundField DataField="NO3" HeaderText="№" ReadOnly="True" ></asp:BoundField>
                            <asp:ImageField DataImageUrlField="IMG3" HeaderText="Образ"></asp:ImageField>
                        </Columns>
                    </asp:GridView>
                </td>            
            </tr>
        </table>
    </form>
</body>
</html>
