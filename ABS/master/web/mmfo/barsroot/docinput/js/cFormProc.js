function FillForm(doc,url_param)
{
//	var pairs = url_param.split("&");
//	for(var i=0; i<pairs.length; i++)
//	{
//		var pos = pairs[i].indexOf('=');
//			if( i == 0) continue;
//			if(-1 == pos) continue;
//			var name = pairs[i].substring(0,pos);
//			var reqname = "reqv_"+name;
//			var val = pairs[i].substring(pos+1);
//			if (doc.getElementById(name) != null)
//			    if (IsEmpty(doc.getElementById(name).value))
//				    doc.getElementById(name).value = val;
//			if (doc.getElementById(reqname) != null)
//			    if (IsEmpty(doc.getElementById(reqname).value))
//				    doc.getElementById(reqname).value = val;	    
//	}
 //Окно открыто не в фрейме	
 if(null==parent.frames[0]){
	doc.getElementById('btNewDoc').style.visibility = 'hidden';
 } 
}
function IsEmpty(val)
{
    return ( val == null || val == '' || val == ' ' );
}
function FillNlsB(doc)
{
	doc.getElementById("Kv_B").focus();
	doc.getElementById("DocN").focus();
}

function LocalizeHtmlTitles()
{
    LocalizeHtmlTitle("btPayIt");
    LocalizeHtmlTitle("btMenuPrint");
    LocalizeHtmlTitle("btNewDoc");
	LocalizeHtmlTitle("btPrintDoc");
	LocalizeHtmlTitle("btSameDoc");
	LocalizeHtmlTitle("btSaveAlien");
}