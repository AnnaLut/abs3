<%@ Page language="c#" Inherits="bars.web.applist"  enableViewState="False" CodeFile="applist.aspx.cs" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>applist</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="C#" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
        <link href="head.css" rel="stylesheet" type="text/css" />
		<script language="javascript">
			  var last_select_app = null;	
			  var blockArms = false;
		      function subMenu(id,img)
		      {
					var obj = document.getElementById(id);
		            if(obj.style.display == 'none'){
						obj.style.display = '';			
						img.src="images/uparrows.gif";
		            }
		            else {
						obj.style.display = 'none';
						img.src="images/downarrows.gif";
					}	
		      }
		      function go(url)
		      {
		        if(blockArms){
		            alert("Дочекайтесь завантаження попердньо вибраної функції.");
		            return;
		        }
		        parent.visit_urls = new Array();
		        if(parent.frames['header'].last_top_app)
					parent.frames['header'].last_top_app.className = "";
		        if(null != last_select_app)
					last_select_app.className = "menuItem";
				last_select_app = event.srcElement;
				last_select_app.className = "menuItemSelected"; 	
		        parent.frames['main'].location.replace(url);
		        blockArms = true;
		        //Очищаем состояние всех фильтров
		        parent.frames['header'].document.getElementById("global_obj").value = null;
		      }
		</script>
	</HEAD>
	<body class="applistBody" rightMargin="0">
		<form id="Form1" method="post" runat="server">
		<div class="menu"><asp:PlaceHolder id="listApp" runat="server" EnableViewState="False"></asp:PlaceHolder></div>
		</form>
	</body>
</HTML>
