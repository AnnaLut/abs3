function getParamFromUrl(param,url)
{
 url = url.substring(url.indexOf('?')+1); 
 for(i = 0; i < url.split("&").length; i++)
 if(url.split("&")[i].split("=")[0] == param) return url.split("&")[i].split("=")[1]; 
 return "";
}
function ShowHideArchive()
{
    if (getParamFromUrl("archive", location.search)=="1") 
        location.replace("SetCurRatesBase.aspx?mode="+getParamFromUrl("mode", location.search));
    else 
        location.replace("SetCurRatesBase.aspx?mode="+getParamFromUrl("mode", location.search)+"&archive=1");
    return false;
}
