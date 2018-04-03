var wb_string = '<OBJECT ID="wb" WIDTH=300 HEIGHT=151 CLASSID="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2" VIEWASTEXT>'+
          '<PARAM NAME="ExtentX" VALUE="7938">'+
          '<PARAM NAME="ExtentY" VALUE="3986">'+
          '<PARAM NAME="ViewMode" VALUE="0">'+
          '<PARAM NAME="Offline" VALUE="0">'+
  	      '<PARAM NAME="Silent" VALUE="0">'+
          '<PARAM NAME="RegisterAsBrowser" VALUE="0">'+
          '<PARAM NAME="RegisterAsDropTarget" VALUE="1">'+
          '<PARAM NAME="AutoArrange" VALUE="0">'+
          '<PARAM NAME="NoClientEdge" VALUE="0">'+
          '<PARAM NAME="AlignLeft" VALUE="0">'+
          '<PARAM NAME="NoWebView" VALUE="0">'+
          '<PARAM NAME="HideFileNames" VALUE="0">'+
          '<PARAM NAME="SingleClick" VALUE="0">'+
          '<PARAM NAME="SingleSelection" VALUE="0">'+
          '<PARAM NAME="NoFolders" VALUE="0">'+
          '<PARAM NAME="Transparent" VALUE="0">'+
          '<PARAM NAME="ViewID" VALUE="{0057D0E0-3573-11CF-AE69-08002B2E1262}">'+
		  '</OBJECT>';

window.onload = function()
{
	document.title = "ѕечать документа('Enter' - немедленна€ печать,'+' - параметры печати) ";
	var elem = document.createElement(wb_string);
	document.body.insertAdjacentElement("beforeEnd",elem);
	
	setTimeout('tryInitialize()',1);
}

function tryInitialize()
{
	try{
        document.getElementById("BarsPrint").Save();
	}
	catch(e)
	{
	    try {document.body.removeChild(document.getElementById("BarsPrint"));}
	    catch(e){}
            
	    try { document.getElementById("wb").ExecWB(3,1); }
	    catch(e)
	    {	        
		    document.body.removeChild(document.getElementById("wb"));
		    document.getElementById("btSet").style.visibility = "hidden";
		    document.getElementById("btView").style.visibility = "hidden";
		    document.getElementById("msg").innerText = "«апрещено выполнение елементов ActiveX";	        
	    }
	}	
	if(location.href.indexOf("print_now") != -1) 
		setTimeout('PrintPage()',1); 
}

document.onkeydown = function()
{
	if(location.href.indexOf("print_now") == -1){
		
		switch(event.keyCode)
		{
			case 13: PrintPage();break;
			case 107: SetupPage();break;
			case 109: PreviewPage();break;
			case 27: window.close();break;
		}	
	}
}
function PrintPage()
{
	document.title = "";
    try {
        if (document.getElementById("BarsPrint"))
            document.getElementById("BarsPrint").PrintPageBase();
	    else if (document.getElementById("wb"))
		    document.getElementById("wb").ExecWB(6, 2);
	    else
            window.print();            
    }
    catch(ex)
    {
        try { document.getElementById("wb").ExecWB(6, 2); }
        catch(e){window.print();}
    }
    
	window.close();
}
function SetupPage()
{
    try{ document.getElementById("BarsPrint").SetupPage();}
    catch(e) {document.getElementById("wb").ExecWB(8, -1);}
}
function PreviewPage()
{
    window.moveTo(0, 0);
    window.resizeTo(window.screen.width, window.screen.height);
    
    try{ document.getElementById("BarsPrint").PreviewPage();}
    catch(e) {document.getElementById("wb").ExecWB(7, 1);}
    
    window.moveTo(window.screen.width/2 - 180, window.screen.height/2-100);
    window.resizeTo(350,200);  	
}