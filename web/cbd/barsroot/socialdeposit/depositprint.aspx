<%@ Page language="c#" CodeFile="DepositPrint.aspx.cs" AutoEventWireup="false" Inherits="DepositPrint"  enableViewState="False"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<TITLE>Соціальні депозити: Друк</TITLE>
		<meta name="GENERATOR" Content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" Content="C#">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<script language="javascript">
		  function getURL()
		  {
		    window.frames["contents"].location.replace("DepositPrintContract.aspx"+location.search);    		    
    	    window.frames["header"].location.replace("PrintButton.aspx");  
		  }
		</script>
	</HEAD>
	<frameset id="mFrameSet" rows="60,*" cols="*" onload="getURL();" frameborder="yes">
		<frame frameBorder="0" name="header" width="100%" scrolling="no" noresize>
		<frame name="contents" frameBorder="0">
	</frameset>
</HTML>
