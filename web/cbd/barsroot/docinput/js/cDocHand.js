var xhr = new ActiveXObject("msxml2.xmlhttp");
var xmlDoc = new ActiveXObject("Msxml2.DOMDocument");
xmlDoc.async = false;
xmlDoc.resolveExternals = false;

function cDocHand(n, form, noreload) {
    try {
        var parm;
        var isSwt = document.getElementById("reqv_f") && document.getElementById("reqv_f").value == "MT 103";
        var flagEnhCheck = (ModuleSettings && ModuleSettings.Documents && ModuleSettings.Documents.EnhanceSwiftCheck == true);
        var isGetPerson = ",MUJ,MUU".indexOf(document.getElementById("__TT").value) >= 0;
        if (n == 8) { parm = "kv1=" + form.Kv_A.value + "&kv2=980&dat=20" + form.__VDATE.value + "&" + Math.random(); }
        else if (n == 7) { parm = "kv=" + form.Kv_A.value + "&nls=" + form.Nls_A.value + "&mfo=" + form.Mfo_A.value + "&" + Math.random(); }
        else if (n == 6) { parm = "kv=" + form.Kv_B.value + "&nls=" + form.Nls_B.value + "&mfo=" + form.Mfo_B.value + "&" + Math.random(); }
        else if (n == 5) { parm = "kv1=" + form.Kv_A.value + "&kv2=" + form.Kv_B.value + "&dat=20" + form.__VDATE.value + "&" + Math.random(); }
        else if (n == 4) { parm = "sk=" + form.Sk.value; }
        else if (n == 3) { parm = "ref=" + form.__DOCREF.value + "&date=" + (new Date()).getTime(); }
        else if (n == 2) { if ("" == form.Mfo_B.value) return true; parm = "mfo=" + form.Mfo_B.value + "&" + Math.random(); }
        else if (n == 1) {
            var dk_b = (0 != form.__DK.value) ? (1) : (0);
            var nosaldo = "";
            if (document.getElementById("__FLAGS").value.substr(27, 1) == "1")
                nosaldo = "&nosaldo=1";

            var flagPerson = "";
            if (isGetPerson) 
                flagPerson = "getperson=1&";

            parm = "nls=" + form.Nls_B.value + "&kv=" + form.Kv_B.value + "&dk=" + dk_b + "&tt=" + form.__TT.value + nosaldo + "&n=1&" + flagPerson + Math.random();
        }
        else if (n == 0) {
            var dk_a = (1 != form.__DK.value) ? (1) : (0);
            var nosaldo = "";
            if (document.getElementById("__FLAGS").value.substr(26, 1) == "1")
                nosaldo = "&nosaldo=1";

            // SWIFT - подтягиваем автоматом 50К поле
            var swiftFlag = "";
            if (isSwt) {
                swiftFlag = "isswt=1&";
                if (flagEnhCheck && document.getElementById("reqv_57A")) {
                    document.getElementById("reqv_57A").parentNode.parentNode.style.display = (form.Kv_A.value == "643")?("none"):("");
                }
                // если есть реквизит и счет
                if (document.getElementById("reqv_PASPN") && ( form.Nls_A.value.substr(0, 4) == "2620" || form.Nls_A.value.substr(0, 4) == "2625")) 
                    swiftFlag += "getperson=1&";
            }

            parm = "nls=" + form.Nls_A.value + "&kv=" + form.Kv_A.value + "&dk=" + dk_a + "&tt=" + form.__TT.value + nosaldo + "&n=0&" + swiftFlag + Math.random();
        }
        xhr.open("GET", "cDocHand.aspx?" + parm, false);
        xhr.send();
        xmlDoc.loadXML(xhr.responseText);
        if (xmlDoc.parseError.errorCode != 0) {
            window.showModalDialog("dialog.aspx?type=err&r="+Math.random(), "", "dialogWidth:800px;center:yes;edge:sunken;help:no;status:no;");
            return false;
        }

        if (xmlDoc.getElementsByTagName("ErrMessage").length != 0) {
            if (n == 1) {
                //27 flag - Не перевіряти наявність контррахунку
                if (document.getElementById("__FLAGS").value.substr(27, 1) == "1") {
                    cDocHand(6, form);
                    return true;
                }
                if (form.__TT.value.substr(0, 2) == 'АД') return true;

                if (!form.Kv_B.readOnly) form.Kv_B.value = "";
                else if (!form.Nls_B.readOnly) form.Nls_B.value = "";
            }
            else if (n == 0) {
                //26 flag - Не перевіряти наявність контррахунку
                if (document.getElementById("__FLAGS").value.substr(26, 1) == "1") {
                    cDocHand(7, form);
                    return true;
                }
                if (!form.Kv_A.readOnly) form.Kv_A.value = "";
                else if (!form.Nls_A.readOnly) form.Nls_A.value = "";
            }
            else if (n == 6 || n == 7)
                return true;
            else if (n == 2)
                form.Mfo_B.focus();
            alert(xmlDoc.getElementsByTagName("ErrMessage").item(0).text);
            return false;
        }

        if (n == 0) {
            if (!noreload) {
                form.Nam_A.value = xmlDoc.getElementsByTagName("Nms").item(0).text;
                form.Id_A.value = xmlDoc.getElementsByTagName("Okpo").item(0).text;
                form.__DIGA.value = xmlDoc.getElementsByTagName("Dig").item(0).text;
            }
            if (xmlDoc.getElementsByTagName("Ostc").item(0))
                form.__OSTC.value = xmlDoc.getElementsByTagName("Ostc").item(0).text;
            else
                form.__OSTC.value = "";
            if (xmlDoc.getElementsByTagName("Ostb").item(0))
                form.__OSTB.value = xmlDoc.getElementsByTagName("Ostb").item(0).text;
            else
                form.__OSTB.value = "";
            if (xmlDoc.getElementsByTagName("Pap").item(0))
                form.__PAP.value = xmlDoc.getElementsByTagName("Pap").item(0).text;
            else
                form.__PAP.value = "";
            InitSumFields();
            fnFillOst();
            if (isSwt) {
                var elem50K = document.getElementById("reqv_50K");
                if (elem50K && flagEnhCheck) {
                    elem50K.value = "/" + form.Nls_A.value + "\n\r";
                    elem50K.value += form.Nam_A.value + "\n\r";
                    var address = (xmlDoc.getElementsByTagName("Address").item(0)) ? (xmlDoc.getElementsByTagName("Address").item(0).text) : ("");
                    var localty = (xmlDoc.getElementsByTagName("Locality").item(0)) ? (xmlDoc.getElementsByTagName("Locality").item(0).text) : ("");
                    var country = (xmlDoc.getElementsByTagName("CountryName").item(0)) ? (xmlDoc.getElementsByTagName("CountryName").item(0).text) : ("");
                    var line = address + " " + localty + " " + country;
                    if (line.length >= 34)
                        line = line.substr(0, 34) + "\n\r" + line.substr(34);
                    elem50K.value += line+ "\n\r";
                    elem50K.value += form.Id_A.value;
                }
                if (document.getElementById("reqv_PASPN") && (form.Nls_A.value.substr(0, 4) == "2620" || form.Nls_A.value.substr(0, 4) == "2625"))
                    getPersonData(xmlDoc);
            }
        } else if (n == 1) {
            form.Nam_B.value = xmlDoc.getElementsByTagName("Nms").item(0).text;
            form.Id_B.value = xmlDoc.getElementsByTagName("Okpo").item(0).text;
            form.__DIGB.value = xmlDoc.getElementsByTagName("Dig").item(0).text;
            InitSumFields();
            if (isGetPerson) {
                getPersonData(xmlDoc);
            }
        } else if (n == 2) {
            form.Bank_B.value = xmlDoc.getElementsByTagName("Nb").item(0).text;
            form.Nls_B.fireEvent("onblur");
        } else if (n == 3) {
            form.__DOCREF.value = xmlDoc.getElementsByTagName("Ref").item(0).text;
        } else if (n == 4) {
            if (form.Nazn.value == null || form.Nazn.value == "")
                form.Nazn.value = xmlDoc.getElementsByTagName("Skname").item(0).text;
        } else if (n == 5) {
            if (form.__FLAGS.value.substring(59, 60) == "1") {
                if (0 == eval(form.__DK.value) || 2 == eval(form.__DK.value)) {
                    SetValue("CrossRat", xmlDoc.getElementsByTagName("RatS").item(0).text.replace(",", "."));
                } else {
                    SetValue("CrossRat", xmlDoc.getElementsByTagName("RatB").item(0).text.replace(",", "."));
                }
            } else {
                SetValue("CrossRat", xmlDoc.getElementsByTagName("RatO").item(0).text.replace(",", "."));
            }
            if (form.reqv_KURS)
                form.reqv_KURS.value = GetValue("CrossRat");
            CRat_Blur();
        } else if (n == 6) {
            form.Id_B.value = xmlDoc.getElementsByTagName("Okpo").item(0).text;
            form.Nam_B.value = xmlDoc.getElementsByTagName("Nms").item(0).text;
        } else if (n == 7) {
            form.Id_A.value = xmlDoc.getElementsByTagName("Okpo").item(0).text;
            form.Nam_A.value = xmlDoc.getElementsByTagName("Nms").item(0).text;
        } else if (n == 8) {
            SetValue("CrossRat", xmlDoc.getElementsByTagName("RatO").item(0).text.replace(",", "."));
        }

    } catch (e) { alert(e.description); return false; }
    return true;
}

function fillAndDisableReq(reqName, fieldName, fieldName2) {
    var elem = document.getElementById(reqName);
    if (elem && xmlDoc.getElementsByTagName(fieldName).item(0)) {
        elem.value = xmlDoc.getElementsByTagName(fieldName).item(0).text;
        if (fieldName2) elem.value += " " + xmlDoc.getElementsByTagName(fieldName2).item(0).text;
        if (elem.value) {
            elem.disabled = true;
            elem.onkeydown = null;
            elem.onfocusin = null;
        }
        elem = document.getElementById("ref_" + reqName);
        if (elem) elem.disabled = true;
    }
}

function getPersonData(xmlDoc) {
    fillAndDisableReq("reqv_NAMET", "DocTypeName");
    fillAndDisableReq("reqv_PASPN", "DocSerial", "DocNumber");
    fillAndDisableReq("reqv_ATRT", "DocIssue");
    fillAndDisableReq("reqv_REZID", "PersonRezId");
    //fillAndDisableReq("reqv_D6#70", "Country");
    fillAndDisableReq("reqv_FIO", "PersonFullName");
    fillAndDisableReq("part_FIO_SURNAME", "PersonSurname");
    fillAndDisableReq("part_FIO_NAME", "PersonName");
    fillAndDisableReq("part_FIO_PATR", "PersonPatr");
}

/// 4 - sk
/// 0 - nls
function cDocHand_link(form, n, ctrl, ctrl_nms) {
    try {
        if (n == 4) {
            parm = "sk=" + ctrl.value;
        }
        else if (n == 0) {
            var dk_b = (1 != form.__DK.value) ? (1) : (0);
            parm = "nls=" + ctrl.value + "&kv=" + form.Kv_A.value + "&dk=" + dk_b + "&tt=" + form.__TT.value + "&" + Math.random();
        }

        xhr.open("GET", "cDocHand.aspx?" + parm, false);
        xhr.send();
        xmlDoc.loadXML(xhr.responseText);

        if (xmlDoc.parseError.errorCode != 0) {
            window.showModalDialog("dialog.aspx?type=err", "", "dialogWidth:800px;center:yes;edge:sunken;help:no;status:no;");
            return false;
        }

        if (xmlDoc.getElementsByTagName("ErrMessage").length != 0) {
            ctrl.value = "";
            alert(xmlDoc.getElementsByTagName("ErrMessage").item(0).text);
            return false;
        }

        if (n == 0) {
            ctrl_nms.value = xmlDoc.getElementsByTagName("Nms").item(0).text;
        }
        else if (n == 4) {
            if (!ctrl_nms.value)
                ctrl_nms.value = xmlDoc.getElementsByTagName("Skname").item(0).text;
        }
    }
    catch (e) {
        alert(e.description);
        return false;
    }
    return true;
}
