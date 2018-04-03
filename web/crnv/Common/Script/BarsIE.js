// Скрипт для работы с BarsIE.dll
var barsie$version = "1,1,0,0";

window.attachEvent("onload", barsie$init);

function barsie$init()
{
    var str_object_barsie = '<object id="BarsPrint" '+
                            'classid="CLSID:0E21DB0E-5A6E-435B-885B-04D3D92AA3BE" '+
                            'style="border:0; width:0; height:0;"></object>';
    var elem = document.createElement(str_object_barsie);
    document.body.insertAdjacentElement('beforeEnd',elem); 
}

function barsie$print(filename)
{
    try
    {
       var ax = document.getElementById('BarsPrint');
       ax.CallDPrint(filename, "");
    }
    catch(e)
    {
        alert("Не вдалося завантажити активний копонент BarsIE. Зверніться до адміністратора.");
    }
}