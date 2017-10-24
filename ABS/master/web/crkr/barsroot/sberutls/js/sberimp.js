var xhr = new ActiveXObject("msxml2.xmlhttp");
var xmlDoc = new ActiveXObject("Msxml2.DOMDocument");
xmlDoc.async = false;
xmlDoc.resolveExternals = false;

var lastFocus = null;


function Count(text, long) {
    var maxlength = new Number(long);
    if (text.value.length > maxlength) {
        text.value = text.value.substring(0, maxlength);
        return false;
    }
}



function cDocVkrz(mfo, nls0) {
    if (mfo == '') return nls0;
    var nls = nls0.substring(0, 4) + '0' + nls0.substring(5, nls0.length);
    var m1 = '137130';
    var m2 = '37137137137137';
    var j = 0;
    for (var i = 0; i < mfo.length; i++)
    { j = j + parseInt(mfo.substring(i, i + 1)) * parseInt(m1.substring(i, i + 1)); }

    for (var i = 0; i < nls.length; i++)
    { j = j + parseInt(nls.substring(i, i + 1)) * parseInt(m2.substring(i, i + 1)); }

    return nls.substring(0, 4) +
          (((j + nls.length) * 7) % 10) +
          nls.substring(5, nls.length);
}

function setFocus(elem) {
    if (!elem.disabled && (lastFocus == null || elem.name == lastFocus.name)) {
        elem.focus();
        elem.select();
        lastFocus = elem;
    }
}
function nlsSelect(target, A_B, idA_controlId, namA_controlId, dk_controlId, tt_controlId, mfoa_controlId, mfob_controlId, kv_controlId) {
    if (event.keyCode != 123) return null;
    var evt = target.onblur;
    target.onblur = "";
    var mfoa = document.getElementById(mfoa_controlId).value;
    var mfob = document.getElementById(mfob_controlId).value;
    var dk = (mfoa != mfob && A_B == 2) ? -1 : document.getElementById(dk_controlId).value;
    var curMfo = A_B == 1 ? mfoa : mfob;
    var link = 'dialog.aspx?type=metatab_base&role=wr_doc_input&dk=' + dk + '&tt=' + document.getElementById(tt_controlId).value + '&mfo=' + curMfo + '&kv=' + document.getElementById(kv_controlId).value + '&nls=' + target.value;
    var result = window.showModalDialog(link, '', 'dialogHeight:560px; dialogWidth:750px');
    target.onblur = evt;
    if (result != null) {
        target.value = dk == -1 ? result[1] : result[0];
        document.getElementById(idA_controlId).value = dk == -1 ? result[3] : result[3];
        document.getElementById(namA_controlId).value = dk == -1 ? result[2] : (mfoa != mfob ? result[4] : result[2]);
    }

}
function trim(string)
{
    return string.replace(/(^\s+)|(\s+$)/g, "");
}
function skSelect(target, dk_control, nlsa_control, nlsb_control) {
    if (event.keyCode != 123) return null;
    var dk = document.getElementById(dk_control).value;
    var nlsa = document.getElementById(nlsa_control).value;
    var nlsb = document.getElementById(nlsb_control).value;

    var sql = '';
    /*if (nlsa.substring(0, 3) == '100' || nlsb.substring(0, 3) == '100') {
        if ((dk == '1' && nlsa.substring(0, 3) == '100') || (dk == '0' || nlsb.substring(0, 3) == '100'))
            sql = ' least(sk, 39) = sk and ';
        else
            sql = ' greatest(sk, 40) = sk and ';
    }*/

    var result = window.showModalDialog('dialog.aspx?type=metatab&tabname=sk&role=BASIC_INFO&tail=" ' + ' sk like \'' + target.value + '%\' and '+sql+' (d_close is null or d_close > gl.bd) order by sk"', "", "dialogWidth:600px;center:yes;edge:sunken;help:no;status:no;");
    if (result != null)
        document.getElementById('fv_SKTextBox_value').value = result[0];
}


function mfoSelect(target, nls_control) {
    if (event.keyCode != 123) return null;
    var result = window.showModalDialog('dialog.aspx?type=metatab&tabname=banks&role=BASIC_INFO&tail=" blk!=4 and mfo like \'' + target.value + '%\'"', "", "dialogWidth:600px;center:yes;edge:sunken;help:no;status:no;");
    if (result != null) {
        target.value = result[0];
        setFocus(document.getElementById(nls_control));
    }
}
function chkdoc() {
    
}
function chkNls(target, A_B, kv_controId, dk_controId, tt_controId, id_controlId, nam_controId, mfoa_controlId, mfob_controlId) {
    var mfo = '';
    var mfoa = document.getElementById(mfoa_controlId).value;
    var mfob = document.getElementById(mfob_controlId).value;
    var nls = target.value.replace('*', '').replace('%', '');
    var dk = document.getElementById(dk_controId).value;
    if (A_B == 1) 
        mfo = mfoa;
    else 
        mfo = mfob;
    if (nls == '') {
        lastFocus = null;
        return true;
    }
    if (nls != cDocVkrz(mfo, nls)) {
        setFocus(target);
        alert('Невiрний контрольний розряд рахунку (вiрний: ' + cDocVkrz(mfo, nls) + ')');
        return false;
    }
    /*сторону Б для межбанка не обрабатываем*/
    if (A_B == 2 && mfoa != mfob)
        return true;
        
    try {
        var parm =
                    "nls=" + nls +
                    "&kv=" + document.getElementById(kv_controId).value +
                    "&dk=" + (dk == "1" ? (A_B == 1 ? "0" : "1") : (A_B == 1 ? "1" : "0") ) +
                    "&tt=" + document.getElementById(tt_controId).value +
                    "&" + Math.random();
        xhr.open("GET", "cDocHand.aspx?" + parm, false);
        xhr.send();
        xmlDoc.loadXML(xhr.responseText);
        if (xmlDoc.parseError.errorCode != 0) {
            window.showModalDialog("dialog.aspx?type=err", "", "dialogWidth:750px;center:yes;edge:sunken;help:no;status:no;");
            return false;
        }
        if (xmlDoc.getElementsByTagName("ErrMessage").length != 0) {
            alert(xmlDoc.getElementsByTagName("ErrMessage").item(0).text);
            setFocus(target);
            return false;
        }
        lastFocus = null;
        document.getElementById(id_controlId).value = xmlDoc.getElementsByTagName("Okpo").item(0).text;
        document.getElementById(nam_controId).value = document.getElementById(mfoa_controlId).value != document.getElementById(mfob_controlId).value ? xmlDoc.getElementsByTagName("Nmk").item(0).text : xmlDoc.getElementsByTagName("Nms").item(0).text;
    } catch (e) {
        alert(e.description);
        return false;
    }
}
function chkMfo(target, mfoa_control, mfob_control, namb_control) {
    setNamBMode(mfoa_control, mfob_control, namb_control);
}
function chkSk(target, dk_control, nlsa_control, nlsb_control) {
    var dk = document.getElementById(dk_control).value;
    var nlsa = document.getElementById(nlsa_control).value;
    var nlsb = document.getElementById(nlsb_control).value;
    if (dk == '' || nlsa == '' || nlsb == '') return true;

    if (nlsa.substring(0, 3) != '100' && nlsb.substring(0, 3) != '100') { lastFocus = null; return true; }

    if (target.value >= 40 &&  ((dk == '1' && (nlsa.substring(0, 4) == '1001' || nlsa.substring(0, 4) == '1002' )) || 
                                (dk == '0' && (nlsb.substring(0, 4) == '1001' || nlsb.substring(0, 4) == '1002' ))
			       )
        ) {
        alert('Невірний символ кас.плану для надходження касси, повинен бути в діпазоні (1-39)');
        setFocus(target);
    }
    else
        if (target.value < 40 && ((dk == '0' && (nlsa.substring(0, 4) == '1001' || nlsa.substring(0, 4) == '1002' )) || 
	                          (dk == '1' && (nlsb.substring(0, 4) == '1001' || nlsb.substring(0, 4) == '1002' ))
		                 )
           ) {
        alert('Невірний символ кас.плану для видатку касси, повинен бути більшим за 39');
        setFocus(target);
    }
    else
        lastFocus = null;
}

function setNamBMode(mfoa_control, mfob_control, namb_control) {
    if (document.getElementById(mfoa_control).value == document.getElementById(mfob_control).value)
        document.getElementById(namb_control).onkeypress = readonlyStub;
    else
        document.getElementById(namb_control).onkeypress = null;

}

function readonlyStub(evt) {
    return false;
}