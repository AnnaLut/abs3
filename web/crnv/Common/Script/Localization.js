function LocalizedString(key)
{
    var element = document.getElementById(key);
    if (element==null) return "Message is not found!";
    return element.value;
}

function LocalizeHtmlTitle(bt)
{
    var bt1 = document.getElementById(bt);
    if (null!=bt1) {
    bt1.title=LocalizedString("for"+bt);
    }
}

function LocalizeHtmlValue(bt)
{
    var bt1 = document.getElementById(bt);
    if (null!=bt1) {
        bt1.value=LocalizedString("for"+bt);
    }
}

function getCurrentPageLanguage()
{
var el = document.getElementById("currentPageCulture");
    if (null!=el)
    {
        return el.value;
    }
    else
    {
        return "ru";
    }
}