window.attachEvent("onload",DrawHelp);

function DrawHelp(){
 if(document.getElementById('helplink') == null){
 	     document.body.insertBefore(document.createElement("<div id=helplink "+
 	     "style=\"z-index:1;position:absolute;left:expression((document.body.clientWidth + document.body.scrollLeft - helplink.clientWidth));top:0px;\"></div>"));
    document.getElementById('helplink').innerHTML ="<img title=\"Помощь\" onclick=\"GetHelp()\" src=\"/Common/Images/HELP.gif\">";
    //document.getElementById('helplink').innerHTML ="<a href=# onclick=\"GetHelp()\" >?</a>";
  } 
}

function GetHelp()
{
  var host = location.hostname;
  var href = location.href;
  var params = location.search;
  var str = href.substr(href.indexOf(host)+host.length+1);
  
  var app = str.split('/')[0]; 
  var page = str.split('/')[str.split('/').length-1].split('?')[0].split('.')[0];
  
  window.open('/'+app+'/Help/'+page+".htm"+params,"Help","height="+(window.screen.height-200)+",width="+(window.screen.width-10)+",resizable=yes,scrollbars=yes,status=no,toolbar=yes,menubar=no,location=no,left=0,top=20");
}	