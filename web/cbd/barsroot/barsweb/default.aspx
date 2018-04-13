<%@ Page %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<HEAD>
		<TITLE>АБС "БАРС"</TITLE>
		<meta name="keywords" content="UNITY-BARS,BANK,Banking Automated Regional Systems">
		<META http-equiv="Content-Type" content="text/html; charset="windows-1251">
		<meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1">
		<meta name="ProgId" content="VisualStudio.HTML">
		<meta name="Originator" content="Microsoft Visual Studio .NET 7.1">
	</HEAD>
	<script language="javascript">
		var visit_urls = new Array();
		var isHist = false;
		function getCookie(par)
		{
		    var pageCookie = document.cookie;
		    var pos = pageCookie.indexOf(par + '=');
            if(pos != -1 )
		    { 	
	    	    var start = pos + par.length + 1;
	    	    var end = pageCookie.indexOf(';',start);
	    	    if(end == -1) end = pageCookie.length;
	            var value = pageCookie.substring(start, end);
	            value = unescape(value);
	            return value;
	        }
		}

		function Save()
		{
		  var page = parent.frames['main'].location.pathname; 
		  parent.frames['contents'].blockArms = false;
		  if(page.indexOf("loginpage.aspx") > 0)
		  {
		    location.reload();
		  }
		  if(visit_urls[visit_urls.length-1] != parent.frames['main'].location.href && page.indexOf("barsweb/blank.htm") < 0 && page.indexOf("loginpage.aspx") < 0)
		  {
			visit_urls.push(parent.frames['main'].location.href);
			var login = getCookie('userLogin');
			var cookieName = 'lastUrl' + login;
			document.cookie = cookieName + '=' + parent.frames['main'].location.href;
		  }
		  isHist = false;
		}
		function setWelcomePage()
		{
		  window.history.forward(-1);
		  if(parent.frames['main'].location.pathname.indexOf("barsweb/blank.htm") < 0) return;
		  var login = getCookie('userLogin');
		  var cookieName = 'lastUrl' + login;
		  var lastUrl = getCookie(cookieName);
		  if(lastUrl && lastUrl.indexOf("barsweb/blank.htm") == -1 && lastUrl.indexOf("loginpage.aspx") == -1)
	       	parent.frames['main'].location.replace(lastUrl);
		  else
		   	parent.frames['main'].location.replace("welcome.aspx");
		}
		function removeCookie()
		{
		  var d = new Date();
          document.cookie = ".BARS_AUTH=;expires=" + d.toGMTString() + ";" + ";";
		}
	</script>
	<frameset rows="79,100%" onload="setWelcomePage()"  framespacing="0" >
		<frame frameBorder="0" name="header" src="head.aspx" scrolling="no" noResize />
		<frameset cols="180,100%" id="masterFrameset" framespacing="2"  >
			<frame name="contents" src="applist.aspx" frameborder="0" scrolling="auto" />
			<frame name="main" src="blank.htm" frameborder="0" onload="Save()"  />
		</frameset>
	</frameset>
</html>
