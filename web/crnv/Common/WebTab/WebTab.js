var activeTab = "Tab0"; 

function fnInitTab(name_obj,array_tabs,height_tab,func)
{
  var inner_button = "";
  var inner_ifframe = "";
  var inner_begin = "<table cellspacing=0 cellpadding=0 border=0 width='100%' height='"+height_tab+"'><tr><td><table cellspacing=0 cellpadding=0 border=0 width='100%'><tr valign='center'>";
  var inner_mdl = "<td style='cursor:default;' width='90%'>&nbsp;</td></tr></table></td></tr><tr><td width='100%' height='100%' style='padding:3 0 0 3;'>";
  var inner_end = "</td></tr></table>";
  var funcOnChange = "";
  var tab_class;
  var tab_style;
  var count = 0;
  if(func != null) funcOnChange = "onfocus='"+func+"(this)'"
  for(key in array_tabs){
    if(count == 0){
		inner_ifframe += "<iframe id=Tab"+count+" src='"+array_tabs[key]+"' width='100%' height='100%'></iframe>";
		tab_class = "tabActive";
	}	
    else {
        inner_ifframe += "<iframe id=Tab"+count+" src='"+array_tabs[key]+"' width='100%' height='100%' style='DISPLAY:none "+tab_style+"'></iframe>";
        tab_class = "tabDeactive";
    }    
    if(array_tabs[key] == 'blank.html') tab_style = "style='visibility=hidden'";else tab_style = "";
	inner_button += "<td nowrap align='center' class="+tab_class+" "+funcOnChange+" onclick='goPage(this)' "+tab_style+" id=bTab"+count+">"+key+"</td>";	
    count++;
 }
 document.getElementById(name_obj).innerHTML = inner_begin+inner_button+inner_mdl+inner_ifframe+inner_end;
}
function goPage(obj)
{
  var name = obj.id.substr(1);
  document.getElementById("b"+name).className = "tabActive";
  document.getElementById(name).style.display = "block";
  if(name != activeTab){
    document.getElementById(activeTab).style.display = "none";
    document.getElementById("b"+activeTab).className = "tabDeactive";
  }  
  activeTab = name;
}