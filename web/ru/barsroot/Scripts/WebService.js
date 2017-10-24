﻿webService = function() {
  if (window.addEventListener) {
    window.addEventListener('resize', DoResize, false);
  } else if (window.attachEvent) {
    window.attachEvent('onresize', DoResize);
  } else {
    window.onresize = DoResize;
  }

  function DoResize() {
    if (_mProg == null || _mProg.parentElement == null)
      return;
    var top = element.document.body.offsetHeight / 2 - 15;
    var left = element.document.body.offsetWidth / 2 - 50;
    _mProg.style.top = top;
    _mProg.style.left = left;
  }

  var _nextId = 0;
  var _nextNsQ = 0;
  var _sdl = new Array();
  var _mProg = null;
  var _fVBon = false;
  var _aXmlHttp = new Array();
  var xsi99 = "http://www.w3.org/1999/XMLSchema-instance";
  var xsi01 = "http://www.w3.org/2001/XMLSchema-instance";
  var xsd01 = "http://www.w3.org/2001/XMLSchema";
  var xsd99 = "http://www.w3.org/1999/XMLSchema";
  var _st = {
    "negativeInteger": 0,
    "unsignedShort": 0,
    "unsignedByte": 0,
    "unsignedLong": 0,
    "unsignedInt": 0,
    "decimal": 0,
    "boolean": 0,
    "integer": 0,
    "double": 0,
    "float": 0,
    "short": 0,
    "byte": 0,
    "long": 0,
    "int": 0,
    "QName": 1,
    "string": 1,
    "normalizedString": 2,
    "timeInstant": 3,
    "dateTime": 3,
    "date": 4,
    "time": 5,
    "base64Binary": 6,
    "base64": 7
  };

  function ErrDetail(errCode, errString, errRaw) {
    this.code = errCode;
    this.string = errString;
    this.raw = errRaw;
  }

  var L_InProgress_Text = "In Progress";
  var L_InvalArg_Text = "Invalid argument";
  var L_NotReady_Text = "Service unavailable";
  var L_InvalRes_Text = "Invalid response";
  var L_UnsupFun_Text = "Function not found";
  var L_UnknownS_Text = "Unknown server error";
  var L_AcDenied_Text = "Access denied";
  var L_SoapUnav_Text = "Soap not available";
  var L_HtcInter_Text = "HTC internal error";
  var L_InvaPort_Text = "Invalid active port";
  var L_InvaHead_Text = "Invalid headers";
  var _errInvalArg = new ErrDetail("Client", L_InvalArg_Text, null);
  var _errNotReady = new ErrDetail("Client", L_NotReady_Text, null);
  var _errInvalRes = new ErrDetail("Server", L_InvalRes_Text, null);
  var _errUnsupFun = new ErrDetail("Client", L_UnsupFun_Text, null);
  var _errUnknownS = new ErrDetail("Server", L_UnknownS_Text, null);
  var _errAcDenied = new ErrDetail("Server", L_AcDenied_Text, null);
  var _errSoapUnav = new ErrDetail("Client", L_SoapUnav_Text, null);
  var _errHtcInter = new ErrDetail("Client", L_HtcInter_Text, null);
  var _errInvaPort = new ErrDetail("Client", L_InvaPort_Text, null);
  var _errInvaHead = new ErrDetail("Client", L_InvaHead_Text, null);
  var _aryError = new Array(
    _errInvalArg,
    _errNotReady,
    _errInvalRes,
    _errUnsupFun,
    _errUnknownS,
    _errAcDenied,
    _errSoapUnav,
    _errHtcInter,
    _errInvaPort,
    _errInvaHead
  );

  function postError(oCall, refError) {
    if (oCall.co != null && !oCall.co.async)
      return returnError(oCall, refError);
    var s = function() { returnError(oCall, refError); };
    setTimeout(s, 0);
    return oCall.id;
  }

  function returnError(oCall, refError) {
    hideProgress();
    var r = new Object();
    r.id = oCall.id;
    r.error = true;
    r.errorDetail = _aryError[refError];
    if (oCall.co != null && oCall.co.async == false) {
      return r;
    }
    var cb = oCall.cb;
    if (cb == null) {
      var evt = createEventObject();
      evt.result = r;
      try {
        eventResult.fire(evt);
      } catch(e) {
      }
      ;
    } else {
      try {
        cb(r);
      } catch(e) {
      }
      ;
    }
    return oCall.id;
  }

  function createCallOptions(fn, pn, cm, to, un, pw, hd, ep, pr) {
    var o = new Object();
    o.funcName = fn;
    o.portName = pn;
    o.async = cm;
    o.timeout = to;
    o.userName = un;
    o.password = pw;
    o.SOAPHeader = hd;
    o.endpoint = ep;
    o.params = pr;
    return o;
  }

  function createUseOptions(rc, sh) {
    var o = new Object();
    o.reuseConnection = rc == true;
    o.SOAPHeader = sh;
    return o;
  }

  function cloneObject(co) {
    var o = new Object();
    for (var x in co)
      o[x] = co[x];
    return o;
  }

  function ensureVBArray(d) {
    if (!_fVBon) {
      var s1 =
        "\nFunction VBGetArySize(a, d)\n"
          + "Dim x\n"
          + "Dim s\n"
          + "s=UBound(a, 1)\n"
          + "For x = 2 To d \n"
          + 's = s & "," & UBound(a, x)\n'
          + "Next\n"
          + "VBGetArySize=s\n"
          + "End Function\n";
      var o = element.document.createElement("script");
      o.language = "VBS";
      o.text = s1;
      element.document.body.appendChild(o);
      _fVBon = true;
    }
    var fn = "VBGetAryItem" + d;
    if (eval("typeof " + fn) != 'undefined')
      return;
    var a = new Array();
    for (var i = 0; i < d; i++)
      a[i] = 'p' + i;
    var sp = a.join(", ");
    var s2 = "\nFunction " + fn + "(a, " + sp + ")\n"
      + "x = VarType(a(" + sp + "))\n"
      + "If x=9 Or x=12 Then\n"
      + "Set " + fn + "=a(" + sp + ")\n"
      + "Else\n"
      + fn + "=a(" + sp + ")\n"
      + "End If\n"
      + "End Function\n";
    var o = element.document.createElement("script");
    o.language = "VBS";
    o.text = s2;
    element.document.body.appendChild(o);
  }

  var _b64 = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";

  function encb64hlp(a, k, s, iFrom, iTo, fStr) {
    var d = 0;
    for (var i = 0; i + iFrom <= iTo; i++)
      d |= (fStr ? s.charCodeAt(i + iFrom) : s[i + iFrom]) << (16 - 8 * i);
    for (var i = 0; i <= iTo - iFrom + 1; i++)
      a[k++] = _b64.charAt(d >>> (18 - i * 6) & 0x3f);
    return k;
  }

  function decb64hlp(a, ai, ca, iFrom, iTo) {
    var d = 0;
    var l = iTo - iFrom;
    for (var i = 0; i + iFrom <= iTo; i++)
      d |= ca[i + iFrom] << (18 - 6 * i);
    for (var i = 0; i < l; i++)
      a[ai + i] = (d >>> (16 - i * 8)) & 0xff;
    return ai + i;
  }

  function encb64(s) {
    var fStr = typeof(s) == "string";
    var i;
    var l = s.length;
    var a = new Array();
    var k = 0;
    for (i = 2; i < l; i = i + 3) {
      k = encb64hlp(a, k, s, i - 2, i, fStr);
      if ((i + 1) % 57 == 0)
        a[k++] = "\r\n";
    }
    var padd = l - i + 2;
    if (padd > 0) {
      k = encb64hlp(a, k, s, i - 2, l - 1, fStr);
      a[k] = (padd > 1) ? "=" : "==";
    }
    return a.join("");
  }

  var _b64rsc = "\n\r\t";

  function decb64(s, fStr) {
    var i, j = 0;
    var ip = s.indexOf('=');
    var l = ip >= 0 ? ip : s.length;
    var ca = new Array();
    for (i = 0; i < l; i++) {
      var c = s.charAt(i);
      if (_b64rsc.indexOf(c) >= 0)
        continue;
      ca[j++] = _b64.indexOf(c);
    }
    var l = j;
    var a = new Array();
    var ai = 0;
    for (i = 3; i < l; i = i + 4)
      ai = decb64hlp(a, ai, ca, i - 3, i);
    if (i - 4 < l)
      ai = decb64hlp(a, ai, ca, i - 3, l - 1);
    if (!fStr)
      return a;
    var r = '';
    try {
      r = String.fromCharCode.apply(element, a);
    } catch(E) {
      for (i = 0; i < a.length; i++)
        r += String.fromCharCode(a[i]);
    }
    return r;
  }

  function ensureWsdlUrl(szService) {
    if (szService.indexOf("://") > 0)
      return szService;
    var baseUrl = element.document.URL;
    var qi = baseUrl.lastIndexOf("?");
    var url2 = qi > 0 ? baseUrl.substr(0, qi) : baseUrl;
    return url2.substr(0, url2.lastIndexOf("/"))
      + "/" + szService + (szService.indexOf(".") >= 0 ? "" : ".asmx?wsdl");
  }

  function allocCall() {
    var o = new Object();
    o.fDone = false;
    o.next = null;
    o.id = _nextId;
    _nextId++;
    return o;
  }

  function fnShowProgress() {
    if (_mProg == null) {

      var top = element.document.body.offsetHeight / 2 - 15;
      var left = element.document.body.offsetWidth / 2 - 50;

      var s = '<div style="position: absolute; top:' + top + '; background:white; left:' + left + '; width:101; height:33;" >' +
        '' +
        '</div>';
      //var s = "<MARQUEE WIDTH=160 HEIGHT=20 BEHAVIOR=alternate SCROLLDELAY=1"
      //+ " STYLE='background:lightblue;position:absolute;top:0;left:0'>"
      //+ "</MARQUEE>";
      _mProg = element.document.createElement(s);
      _mProg.innerHTML = '<img src=/Common/Images/process.gif>';
    }
    _mProg.style.top = element.document.body.offsetHeight / 2 - 15;
    _mProg.style.left = element.document.body.offsetWidth / 2 - 50;
    if (_mProg.parentElement == null)
      element.document.body.insertAdjacentElement("beforeEnd", _mProg);
  }

  function isSimpleType(os, oschm, t) {
    return oschm == null || oschm.sTypes[t.type] != null;
  }

  function isPrimitive(os, t) {
    return os.ns[t.ns] == os.ns["xsd"];
  }

  function getWsdl() {
    var szService = null;
    for (var aService in _sdl) {
      if (_sdl[aService] == null)
        continue;
      var xmlisld = _sdl[aService]._oXml;
      if (xmlisld == null)
        continue;
      if (_sdl[aService].fPending
        && xmlisld.XMLDocument.readyState == 4) {
        _sdl[aService].fPending = false;
        szService = aService;
        break;
      }
    }
    if (szService == null)
      return;
    var oS = _sdl[szService];
    var fImportDone = loadImports(oS);
    if (fImportDone)
      processService(oS);
  }

  function processService(oS) {
    var xmlSdl = oS._oXml.documentElement;
    try {
      parseWsdl(oS, xmlSdl);
    } catch(e) {
      xmlSdl = null;
    }
    var evt = createEventObject();
    evt.serviceUrl = oS.url;
    evt.userName = oS._oXml.service;
    evt.serviceAvailable = xmlSdl != null;
    evt.WSDL = xmlSdl;
    oS._oXml.removeNode(true);
    oS._oXml = null;
    if (xmlSdl == null) {
      for (var nc = oS.nextCall; nc != null; nc = nc.next)
        returnError(nc, 1);
      _sdl[oS.url] = null;
      eventService.fire(evt);
      return;
    }
    eventService.fire(evt);
    if (oS.fSeq)
      return callNext(oS);
    while (oS.nextCall != null) {
      var nc = oS.nextCall;
      oS.nextCall = oS.nextCall.next;
      _invoke(nc);
    }
  }

  function onImportLoaded(oS) {
    for (var i = 0; i < oS.imports.length; i++) {
      if (oS.imports[i] == null
        || !oS.imports[i].fPending
        || oS.imports[i].XMLDocument.readyState != 4)
        continue;
      var oImp = oS.imports[i].documentElement;
      if (oImp == null)
        continue;
      oS.imports[i].fPending = false;
      oS.cImporting--;
      var xmlSdl = oS._oXml.documentElement;
      switch (oImp.baseName) {
      case "definitions":
        for (var j = 0; j < oImp.attributes.length; j++) {
          var oAtt = oImp.attributes.item(j);
          if (oAtt.name == "xmlns")
            continue;
          var ii = oAtt.name.indexOf("xmlns:");
          if (ii != 0)
            continue;
          var nsn = oAtt.name.substring(6, oAtt.name.length);
          if (oS.ns[nsn] != null)
            continue;
          oS.ns[nsn] = oAtt.value;
          oS.nsalias[oAtt.value] = nsn;
        }
        for (var j = oImp.childNodes.length - 1; j >= 0; j--)
          xmlSdl.appendChild(oImp.childNodes[j]);
        break;
      case "types":
      case "message":
      case "portType":
      case "binding":
      case "service":
        xmlSdl.appendChild(oImp);
        break;
      default:
        var nsq = getQualifier(xmlSdl.nodeName);
        nsq = nsq.length == 0 ? "" : (nsq + ":");
        var nt = oS._oXml.XMLDocument.createElement(nsq + "types");
        xmlSdl.appendChild(nt);
        nt.appendChild(oImp);
      }
      oS.imports[i].removeNode(true);
      oS.imports[i] = null;
      if (oS.cImporting == 0) {
        processService(oS);
        return;
      }
    }
  }

  function loadImports(oS) {
    var xmlSdl = oS._oXml.documentElement;
    if (xmlSdl == null)
      return true;
    var nsq = getQualifier(xmlSdl.nodeName);
    nsq = nsq.length == 0 ? "" : (nsq + ":");
    var nImp = xmlSdl.selectNodes(nsq + "import");
    if (nImp.length == 0)
      return true;
    oS.imports = new Array();
    oS.cImporting = 0;
    for (var i = 0; i < nImp.length; i++) {
      var oImp = window.document.createElement("XML");
      window.document.body.appendChild(oImp);
      oImp.fPending = true;
      oS.imports[i] = oImp;
      oImp.onreadystatechange = function() { onImportLoaded(oS) };
      var impUrl = getAttrib(nImp[i], "location");
      if (impUrl == null)
        continue;
      oS.cImporting++;
      oImp.src = impUrl;
    }
    return false;
  }

  function invokeNext(svcName) {
    var oS = _sdl[svcName];
    if (oS == null)
      return;
    var oC = oS.nextCall;
    if (oC == null)
      return null;
    oS.nextCall = oC.next;
    if (oS.nextCall == null)
      oS.lastCall = null;
    _invoke(oC);
  }

  function callNext(oS) {
    if (oS.fSeq)
      setTimeout(element.uniqueID + '.invokeNext("' + oS.url + '")', 0);
  }

  function getAttrib(o, sAName) {
    if (o.attributes == null)
      return null;
    var a = o.attributes.getNamedItem(sAName);
    if (a != null)
      return a.value;
    return null;
  }

  function getBaseName(str) {
    var a = str.split(":");
    if (a.length > 1)
      return a[1];
    return str;
  }

  function getQualifier(str) {
    var a = str.split(":");
    if (a.length > 1)
      return a[0];
    return '';
  }

  function getNextNsq(oS) {
    var nsq1;
    do {
      nsq1 = "mswsb" + _nextNsQ;
      _nextNsQ++;
    } while (oS.ns[nsq1] != null)
    return nsq1;
  }

  function getUniqueNsq(oS, o, litNsq) {
    if (litNsq == null)
      return litNsq;
    var nsuri = null;
    if (litNsq == '')
      nsuri = o.namespaceURI;
    else {
      var o1 = o;
      while (o1 != null) {
        nsuri = getAttrib(o1, 'xmlns:' + litNsq);
        if (nsuri != null)
          break;
        o1 = o1.parentNode;
      }
    }
    if (nsuri == null)
      return litNsq;
    var nsq1 = oS.nsalias[nsuri];
    if (nsq1 != null)
      return nsq1;
    litNsq = getNextNsq(oS);
    oS.ns[litNsq] = nsuri;
    oS.nsalias[nsuri] = litNsq;
    return litNsq;
  }

  function parseSimpleType(oS, oschm, o, ssffx) {
    var ns = getQualifier(o.tagName);
    var o1 = o.firstChild;
    if (o1 == null)
      return null;
    var sn = getAttrib(o, "name");
    if (sn == null)
      return null;
    sn = getBaseName(sn);
    var ot = new Object();
    ot.name = sn;
    switch (o1.baseName) {
    case 'restriction':
      var base = getAttrib(o1, "base");
      if (base == null) {
        ot.ns = "xsd";
        ot.type = "string";
      } else {
        ot.type = getBaseName(base);
        ot.ns = getQualifier(base);
      }
      oschm.sTypes[sn] = ot;
      break;
    case 'list':
    case 'union':
      ot.type = "string";
      ot.ns = "xsd";
      oschm.sTypes[sn] = ot;
      break;
    default:
      ot = null;
    }
    return ot;
  }

  function parseType(oS, oschm, o, ssffx) {
    if (o == null)
      return null;

    switch (o.baseName) {
    case "complexType":
      return parseComplexType(oS, oschm, o, ssffx);
    case "simpleType":
      return parseSimpleType(oS, oschm, o, ssffx);
    }
    return null;
  }

  function parseArrayType(at, sz) {
    var asa = sz.split("[");
    if (asa.length <= 1) {
      asa = sz.split(",");
      for (var i = 0; i < asa.length; i++) {
        var ii = parseInt(asa[i]);
        at[at.length] = isNaN(ii) ? null : ii;
      }
      return;
    }
    for (var i = 0; i < asa.length; i++)
      parseArrayType(at, asa[i]);
  }

  function parseComplexType(oS, oschm, o, ssffx) {
    var ns = getQualifier(o.tagName);

    if (!o.hasChildNodes())
      return null;
    var ot = null;
    for (var j = 0; j < o.childNodes.length; j++) {
      var o1 = o.childNodes[j];

      switch (o1.baseName) {
      case 'sequence':
      case 'all':
        var ao = o1.selectNodes(ns.length ? (ns + ':any') : 'any');
        if (ao.length != 0)
          continue;
        ao = o1.selectNodes(ns.length ? (ns + ':element') : 'element');
        if (ao.length == 0)
          continue;
        if (ot == null)
          ot = new Array();
        for (var i = 0; i < ao.length; i++) {
          var s = getAttrib(ao[i], "name");

          if (s == null) {
            var s = getAttrib(ao[i], "ref");

            if (s != null) {
              oS.refs[s] = ot;
            }
          } else
            ot[s] = parseElem(oS, oschm, ao[i], ssffx);
        }
        continue;
      case 'complexContent':
        var o2 = o1.firstChild;

        switch (o2.baseName) {
        case 'extension':
          var base = getAttrib(o2, "base");
          if (base == null)
            continue;
          var ab = base.split(":");
          var oBase = new Object();
          oBase.nsuri = ab.length > 1 ? oS.ns[ab[0]] : oschm.uri;
          oBase.base = ab.length > 1 ? ab[1] : ab[0];
          ot = parseComplexType(oS, oschm, o2, ssffx);
          oBase.type = getAttrib(o, "name");
          oBase.derivedType = ot;
          oBase.fExpanded = false;
          if (oBase.type != null)
            oS.exts[oBase.type] = oBase;
          else
            oS.exts[oS.exts.length] = oBase;
          continue;
        case 'restriction':
          return parseComplexType(oS, oschm, o2, ssffx);
        case 'all':
          return parseComplexType(oS, oschm, o1, ssffx);
        }
        continue;
      case 'attribute':
        var soapns = oS.ns[oS.qlt["soap"]];
        var wsdlns = oS.ns[oS.qlt["wsdl"]];
        var at = o1.attributes.getQualifiedItem("arrayType", wsdlns);

        if (at == null)
          at = o1.attributes.getQualifiedItem("arrayType", soapns);
        if (at == null) {

          if (ot == null) {
            ot = new Array();

          }
          ot[getAttrib(o1, "name")] = parseAttrib(o1);
          continue;
        }

        var tn = getBaseName(at.value);

        if (ot != null) {
          var oe = get1stAryItem(ot);
          oe.fArray = true;
          oe.sizeArray = new Array();
          parseArrayType(oe.sizeArray,
            tn.substring(tn.indexOf("[") + 1, tn.length));
          continue;
        }
        var oe = new Object();
        var a = tn.split("[");
        if (a.length < 2)
          continue;
        oe.ns = getQualifier(at.value);
        oe.ns = getUniqueNsq(oS, o1, oe.ns);
        oe.name = a[0];
        oe.fArray = true;
        oe.type = a[0];
        if (oe.type == "anyType" && oS.ns[oe.ns] == oS.ns["xsd"])
          oe.type = "string";
        oe.sizeArray = new Array();
        parseArrayType(oe.sizeArray,
          tn.substring(tn.indexOf("[") + 1, tn.length));
        ot = new Array();
        ot[a[0]] = oe;
        continue;
      }
    }
    return ot;
  }

  function parseAttrib(o) {
    var attrib = new Object();
    attrib.fAttrib = true;
    var st = getAttrib(o, "type");
    if (st != null) {
      var a = st.split(":");
      attrib.type = a.length > 1 ? a[1] : a[0];
      attrib.ns = a.length > 1 ? a[0] : null;
    }
    attrib.fixed = getAttrib(o, "fixed");
    attrib.name = getAttrib(o, "name");
    attrib.allowed = getAttrib(o, "use") != "prohibited";
    return attrib;
  }

  function parseElem(oS, oschm, o, ssffx) {
    var oe = new Object();
    oe.name = getAttrib(o, "name");
    var st = getAttrib(o, "type");
    if (st == null)
      st = getAttrib(o, "xsi:type");
    var minOccurs = getAttrib(o, "minOccurs");
    var maxOccurs = getAttrib(o, "maxOccurs");
    oe.fArray = (maxOccurs != null && maxOccurs != "1");
    if (st != null) {
      oe.type = getBaseName(st);
      oe.ns = getQualifier(st);
      if (oe.ns == '')
        oe.ns = oschm.qdef;
      if (oe.type == "anyType" && oS.ns[oe.ns] == oS.ns["xsd"])
        oe.type = "string";
      return oe;
    }
    oe.ns = oS.nsalias[oschm.uri];
    if (typeof ssffx != 'undefined')
      oe.type = ssffx + '_' + oe.name;
    else
      oe.type = oe.name;
    var ct = parseType(oS, oschm, o.firstChild, ssffx);
    oschm.types[oe.type] = ct;
    return oe;
  }

  function parseSoapHeader(oS, o) {
    var hdrInfo = new Object();
    hdrInfo.ns = getAttrib(o, "namespace");
    hdrInfo.es = getAttrib(o, "encodingStyle");
    var sUs = getAttrib(o, "use");
    hdrInfo.fLiteral = (sUs != null && sUs.toLowerCase() == 'literal');
    var smsg = getAttrib(o, "message");
    var amh = oS.msgs[getBaseName(smsg)];
    var spart = getAttrib(o, "part");
    hdrInfo.fRequired = getAttrib(o, "required") == "true";
    hdrInfo.type = amh.args[getBaseName(spart)];
    return hdrInfo;
  }

  function expBase(oS, a, t) {
    if (t.fExpanded)
      return;
    if (a[t.base] != null)
      expBase(oS, a, a[t.base]);
    t.fExpanded = true;
    var oSchm = oS.schemas[t.nsuri];
    var oSuper = oSchm.types[t.base];
    if (oSuper == null || t.derivedType == null)
      return;
    for (var x in oSuper)
      if (t.derivedType[x] == null)
        t.derivedType[x] = oSuper[x];
  }

  function parseSchemas(oS, nSchemas) {

    for (var j = 0; j < nSchemas.length; j++) {
      var schmUri = getAttrib(nSchemas[j], "targetNamespace");
      if (oS.schemas[schmUri] == null) {
        var oSchm = new Object();
        oSchm.uri = getAttrib(nSchemas[j], "targetNamespace");
        oSchm.efd = getAttrib(nSchemas[j], "elementFormDefault");
        oSchm.afd = getAttrib(nSchemas[j], "attributeFormDefault");
        var nsdef = nSchemas[j].namespaceURI;
        if (nsdef == null || nSchemas[j].prefix != '')
          nsdef = oSchm.uri;
        oSchm.qdef = oS.nsalias[nsdef];
        if (oSchm.qdef == null) {
          oSchm.qdef = "";
          oS.ns[oSchm.qdef] = nsdef;
          oS.nsalias[nsdef] = oSchm.qdef;
        }
        oSchm.service = oS.url;
        oSchm.elems = new Array();
        oSchm.types = new Array();
        oSchm.sTypes = new Array();
        oS.schemas[oSchm.uri] = oSchm;
      } else
        oSchm = oS.schemas[schmUri];
      var nElements = nSchemas[j].childNodes;
      for (var k = 0; k < nElements.length; k++) {
        var sn = getAttrib(nElements[k], "name");

        if (sn == null)
          continue;
        switch (nElements[k].baseName) {
        case 'element':
          oSchm.elems[sn] = parseElem(oS, oSchm, nElements[k], sn);
          break;
        case 'simpleType':
        case 'complexType':
          oSchm.types[sn] = parseType(oS, oSchm, nElements[k]);

          break;
        }
      }
    }
  }

  function parseWsdl(oS, xmlSdl) {
    if (xmlSdl == null)
      return false;
    var nsq = getQualifier(xmlSdl.nodeName);
    nsq = nsq.length == 0 ? "" : (nsq + ":");
    var nsqMsg = nsq;
    var nsqPort = nsq;
    var nsqBinding = nsq;
    var nsqService = nsq;
    var nsqTypes = nsq;
    var nMsgs = xmlSdl.selectNodes(nsq + "message");
    var nPort = xmlSdl.selectNodes(nsq + "portType");
    var nBinding = xmlSdl.selectNodes(nsq + "binding");
    var nService = xmlSdl.selectNodes(nsq + "service");
    var nTypes = xmlSdl.selectNodes(nsq + "types");
    if (nMsgs.length == 0) {
      nMsgs = xmlSdl.selectNodes("message");
      nsqMsg = "";
    }
    if (nPort.length == 0) {
      nPort = xmlSdl.selectNodes("portType");
      nsqPort = "";
    }
    if (nBinding.length == 0) {
      nBinding = xmlSdl.selectNodes("binding");
      nsqBinding = "";
    }
    if (nService.length == 0) {
      nService = xmlSdl.selectNodes("service");
      nsqService = "";
    }
    if (nTypes.length == 0) {
      nTypes = xmlSdl.selectNodes("types");
      nsqTypes = "";
    }
    var aMsgs = new Array();
    var aPort = new Array();
    var aBinding = new Array();
    oS.targetns = getAttrib(xmlSdl, "targetNamespace");
    oS.ns["xsd"] = "http://www.w3.org/2001/XMLSchema";
    oS.schemas = new Array();
    oS.msgs = aMsgs;
    oS.refs = new Array();
    oS.exts = new Array();
    for (var i = 0; i < xmlSdl.attributes.length; i++) {
      var oAtt = xmlSdl.attributes.item(i);
      if (oAtt.name == "xmlns")
        continue;
      var ii = oAtt.name.indexOf("xmlns:");
      if (ii != 0)
        continue;
      var nsn = oAtt.name.substring(6, oAtt.name.length);
      if (oS.ns[nsn] != null && nsn != "xsd")
        continue;
      oS.ns[nsn] = oAtt.value;
      oS.nsalias[oAtt.value] = nsn;
    }
    oS.qlt = new Array();
    oS.qlt["soapenc"] = "http://schemas.xmlsoap.org/soap/encoding/";
    oS.qlt["wsdl"] = "http://schemas.xmlsoap.org/wsdl/";
    oS.qlt["soap"] = "http://schemas.xmlsoap.org/wsdl/soap/";
    oS.qlt["SOAP-ENV"] = 'http://schemas.xmlsoap.org/soap/envelope/';
    for (var x in oS.qlt) {
      if (oS.nsalias[oS.qlt[x]] != null) {
        oS.qlt[x] = oS.nsalias[oS.qlt[x]];
        continue;
      }
      oS.ns[x] = oS.qlt[x];
      oS.nsalias[oS.qlt[x]] = x;
      oS.qlt[x] = x;
    }
    if (oS.ns["xsi"] == null)
      oS.ns["xsi"] = oS.ns["xsd"] == xsd99 ? xsi99 : xsi01;
    for (var i = 0; i < nTypes.length; i++)
      parseSchemas(oS, nTypes[i].childNodes);
    for (var x in oS.refs) {
      var q = getQualifier(x);
      var nsUri = oS.ns[q];
      var oschm = oS.schemas[nsUri];
      if (oschm == null)
        continue;
      var ot = oschm.elems[getBaseName(x)];
      oS.refs[x][ot.name] = ot;
    }
    for (var i in oS.exts)
      expBase(oS, oS.exts, oS.exts[i]);
    for (var i = 0; i < nMsgs.length; i++) {
      var sName = getAttrib(nMsgs[i], 'name');
      aMsgs[sName] = new Object();
      var ps = nMsgs[i].selectNodes(nsqMsg + "part");
      aMsgs[sName].args = new Array();
      for (var j = 0; j < ps.length; j++) {
        var ap = new Object();
        ap.name = getAttrib(ps[j], "name");
        ap.type = getAttrib(ps[j], "type");
        ap.elem = getAttrib(ps[j], "element");
        if (ap.elem != null) {
          ap.ns = getQualifier(ap.elem);
          ap.elem = getBaseName(ap.elem);
        }
        if (ap.type != null) {
          ap.ns = getQualifier(ap.type);
          ap.type = getBaseName(ap.type);
        }
        ap.ns = getUniqueNsq(oS, ps[j], ap.ns);
        if (ap.type == "anyType" && oS.ns[ap.ns] == oS.ns["xsd"])
          ap.type = "string";
        aMsgs[sName].args[ap.name] = ap;
      }
      aMsgs[sName].argl = ps.length;
    }
    for (var i = 0; i < nPort.length; i++) {
      var sName = getAttrib(nPort[i], "name");
      aPort[sName] = new Object();
      var nops = nPort[i].selectNodes(nsqPort + "operation");
      var oops = new Array();
      aPort[sName].ops = oops;
      for (var j = 0; j < nops.length; j++) {
        var sOpName = getAttrib(nops[j], "name");
        var nInputs = nops[j].selectNodes(nsqPort + "input");
        var mInput = null;
        if (nInputs.length > 0) {
          var s = getAttrib(nInputs[0], "message");
          var sMsgName = getBaseName(s);
          var sNS = getQualifier(s);
          if (oops[sOpName] == null)
            oops[sOpName] = new Array();
          var sin = getAttrib(nInputs[0], "name");
          if (sin != null)
            oops[sOpName][sin] = aMsgs[sMsgName];
          else
            oops[sOpName][sOpName] = aMsgs[sMsgName];
          if (aMsgs[sMsgName] == null)
            break;
          aMsgs[sMsgName].opname = sOpName;
          mInput = aMsgs[sMsgName];
          var firstArg = get1stAryItem(mInput.args);
          if (sin != null)
            sOpName = sin;
          mInput.fWrapped = mInput.argl == 1 && firstArg != null
            && (firstArg.type == sOpName
              || firstArg.elem == sOpName
              || "parameters" == firstArg.name.toLowerCase());
        }
        var nOutputs = nops[j].selectNodes(nsqPort + "output");
        if (nOutputs.length > 0) {
          var s = getAttrib(nOutputs[0], "message");
          var sMsgName = getBaseName(s);
          var sSoapName = aMsgs[sMsgName].soapName;
          if (sSoapName == null)
            aPort[sName].ops[sMsgName] = aMsgs[sMsgName];
          else {
            aPort[sName].ops[sSoapName] = aMsgs[sMsgName];
            aMsgs[sSoapName] = aMsgs[sMsgName];
          }
          if (mInput != null)
            mInput.response = aMsgs[sMsgName];
        }
        mInput.fOneWay = nOutputs.length == 0;
      }
    }
    for (var i = 0; i < nBinding.length; i++) {
      var osoapb = nBinding[i].selectNodes("soap:binding");
      if (osoapb == null || osoapb.length == 0)
        continue;
      var sStyle = getAttrib(osoapb[0], "style");
      var sName = getAttrib(nBinding[i], "name");
      aBinding[sName] = new Object();
      var stype = getBaseName(getAttrib(nBinding[i], "type"));
      aBinding[sName].msgs = aPort[stype].ops;
      var nops = nBinding[i].selectNodes(nsqBinding + "operation");
      for (var j = 0; j < nops.length; j++) {
        var sOpName = getAttrib(nops[j], "name");
        var input = nops[j].selectSingleNode(nsqBinding + "input");
        if (input == null)
          continue;
        var sin = getAttrib(input, "name");
        if (sin == null)
          sin = sOpName;
        var oM = aBinding[sName].msgs[sOpName][sin];
        if (oM == null)
          continue;
        var nsoapops = nops[j].selectNodes("soap:operation");
        if (nsoapops.length == 0)
          continue;
        var sOpStyle = getAttrib(nsoapops[0], "style");
        oM.soapAction = getAttrib(nsoapops[0], "soapAction");
        var nsoapbody = nops[j].selectNodes(nsqBinding + "input/soap:body");
        if (nsoapbody.length > 0) {
          oM.ns = getAttrib(nsoapbody[0], "namespace");
          oM.es = getAttrib(nsoapbody[0], "encodingStyle");
          var sUs = getAttrib(nsoapbody[0], "use");
          oM.fLiteral = (sUs != null && sUs.toLowerCase() == 'literal');
        }
        var nheadIn = nops[j].selectNodes(nsqBinding + "input/soap:header");
        oM.hdrsIn = new Array();
        for (var k = 0; k < nheadIn.length; k++)
          oM.hdrsIn[k] = parseSoapHeader(oS, nheadIn[k])
        var nheadOut = nops[j].selectNodes(nsqBinding + "output/soap:header");
        oM.hdrsOut = new Array();
        for (var k = 0; k < nheadOut.length; k++)
          oM.hdrsOut[k] = parseSoapHeader(oS, nheadOut[k])
        if (sOpStyle != null)
          oM.fRpc = sOpStyle.toLowerCase() == 'rpc';
        else
          oM.fRpc = (sStyle != null && sStyle.toLowerCase() == 'rpc');
      }
    }
    oS.soapPort = new Array();
    oS.headers = new Array();
    if (nService.length == 0) {
      oS.defPortName = "defaultPort";
      var aPort = new Object();
      oS.soapPort[oS.defPortName] = aPort;
      aPort.location = null;
      var firstBind = get1stAryItem(aBinding);
      aPort.msgs = firstBind == null ? (new Array()) : firstBind.msgs;
      return;
    }
    var nports = nService[0].selectNodes(nsqService + "port");
    for (var j = 0; j < nports.length; j++) {
      var oAddress = nports[j].selectNodes("soap:address");
      if (oAddress.length == 0)
        continue;
      var oSOAPHdr = nports[j].selectNodes("soap:header");
      for (var k = 0; k < oSOAPHdr.length; k++)
        oS.headers[k] = parseSoapHeader(oS, oSOAPHdr[k]);
      oPort = new Object();
      oPort.location = getAttrib(oAddress[0], "location");
      var b = aBinding[getBaseName(getAttrib(nports[j], "binding"))];
      if (b == null)
        continue
      oPort.msgs = b.msgs;
      var szname = getAttrib(nports[j], "name");
      oS.soapPort[szname] = oPort;
      if (oS.defPortName == null)
        oS.defPortName = szname;
    }
  }

  function ensureXmlHttp(fAsync, oS) {
    var oXmlHttp = null;
    var fCreate = fAsync ? oS.aXmlHttp == null : oS.sXmlHttp == null;
    if (!fCreate && oS.fSeq) {
      oXmlHttp = fAsync ? oS.aXmlHttp : oS.sXmlHttp;
      oXmlHttp.fFree = false;
      return oXmlHttp;
    }
    for (var i = 0; i < _aXmlHttp.length; i++)
      if (_aXmlHttp[i].fFree) {
        _aXmlHttp[i].fFree = false;
        oXmlHttp = _aXmlHttp[i];
        break;
      }
    if (oXmlHttp == null) {
      var xmlHttp;
      try {
        xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
      } catch(e) {
        return null;
      }
      var oXmlHttp = new Object();
      oXmlHttp.fFree = false;
      oXmlHttp.xmlHttp = xmlHttp;
      _aXmlHttp[_aXmlHttp.length] = oXmlHttp;
    }
    if (!oS.fSeq)
      return oXmlHttp;
    if (fAsync)
      oS.aXmlHttp = oXmlHttp;
    else
      oS.sXmlHttp = oXmlHttp;
    return oXmlHttp;
  }

  function encodeHeader(oS, oM, oCall) {
    var co = oCall.co;
    var sh = co.SOAPHeader == null ? oS.SOAPHeader : co.SOAPHeader;
    if (sh == null)
      return "";
    var ht = (oM.hdrsIn == null) ? oS.headers : oM.hdrsIn;
    var szHeader = "";
    if (typeof sh == 'string')
      szHeader = sh;
    else if (typeof sh == 'object' && sh.xml != null)
      szHeader = sh.xml;
    else if (ht.length != 0) {
      if (typeof(sh) == "unknown")
        sh = vbArrayToJs(sh, 1);
      oM1 = new Object();
      oM1.opname = null;
      oM1.ns = oM.ns;
      oM1.fRpc = oM.fRpc;
      oM1.fWrapped = false;
      for (var i = 0; i < ht.length; i++) {
        if (sh[i] == null) {
          if (ht[i].fRequired)
            return returnError(oCall, 9);
          continue;
        }
        oM1.fLiteral = ht[i].fLiteral;
        var ta = new Array();
        ta[ht[i].type.name] = ht[i].type;
        var va = new Array();
        va[0] = sh[i];
        szHeader += encodeArgs(oS, oM1, ta, va, 0, false);
      }
    }
    var soapenvns = oS.qlt["SOAP-ENV"];
    return '<' + soapenvns + ':Header>' + szHeader + "</" + soapenvns + ":Header>\n";
  }

  function _invoke(oCall) {

    var szS = oCall.service;
    var oS = _sdl[szS];
    var co = oCall.co;
    if (oS == null) {
      return postError(oCall, 1);
    }
    if (co.portName == null)
      co.portName = oS.defPortName;
    if (oS.soapPort[co.portName] == null) {
      callNext(oS);
      return returnError(oCall, 8);
    }
    var oXmlHttp = ensureXmlHttp(co.async, oS);
    if (oXmlHttp == null)
      return returnError(oCall, 6);
    var args = co.params == null ? oCall.args : co.params;
    var cb = oCall.cb;
    var j = cb == null ? 1 : 2;
    j = co.params == null ? j : 0;
    var oM = getMsg(szS, co, args, j);
    var szParams = null;
    if (oM != null) {
      szParams = encodeArgs(oS, oM, oM.args, args, j, co.params != null);
    }

    if (szParams == null) {
      callNext(oS);
      return returnError(oCall, 0);
    }
    oCall.oM = oM;
    if (showProgress == "true" || showProgress == true)
      fnShowProgress();
    var oP = oS.soapPort[co.portName];
    var loc = co.endpoint == null ? oP.location : co.endpoint;
    var e_l = element.document.location.href;
    var start_pos_s = e_l.indexOf('(S(');
    var session_id = "";
    if (start_pos_s > 0)
      session_id = e_l.substring(start_pos_s, 2 + e_l.indexOf('))', start_pos_s));
    var szPortNum = element.document.location.port;
    if (szPortNum.length > 0 && "80" != szPortNum) {
      var nAfterProtocolPos = loc.indexOf("://");
      if (nAfterProtocolPos > 0) {
        var nRootSlashPos = loc.indexOf("/", nAfterProtocolPos + 3);
        if (nRootSlashPos > 0) {
          var str_dochost = element.document.location.hostname.toString().toUpperCase();
          var str_svchost = loc.substring(nAfterProtocolPos + 3, nRootSlashPos).toUpperCase();
          loc = loc.substr(0, nAfterProtocolPos + 3) +
            element.document.location.host +
            loc.substr(nRootSlashPos);
        }
      }
    }
    //塞  ᨨ  cookieless session state
    if (session_id) {
      var parts = loc.split('/');
      parts[3] += '/' + session_id;
      loc = parts.join('/');
    }

    if (loc == null) {
      callNext(oS);
      return returnError(oCall, 8);
    }

    try {
      if (co.userName == null)
        oXmlHttp.xmlHttp.open("POST", loc, co.async);
      else
        oXmlHttp.xmlHttp.open("POST", loc, co.async,
          co.userName, co.password == null ? "" : co.password);
    } catch(e) {
      callNext(oS);
      return returnError(oCall, 5);
    }
    var szAction = oM.soapAction;
    if (szAction != null && szAction.length > 0)
      oXmlHttp.xmlHttp.setRequestHeader("SOAPAction", '"' + szAction + '"');
    oXmlHttp.xmlHttp.setRequestHeader("Content-Type",
      'text/xml; charset="UTF-8"');
    var sNS = ' xmlns=""';
    for (var ns in oS.ns) {
      var nsuri = oS.ns[ns];
      if (ns == "" || nsuri == "")
        continue;
      sNS += " xmlns:" + ns + '="' + nsuri + '"';
    }
    var szHeader = encodeHeader(oS, oM, oCall);
    var soapenvns = oS.qlt["SOAP-ENV"];
    var soapes = (oM.es == null ? '' : (' ' + soapenvns + ':encodingStyle="' + oM.es + '"'));
    var szPayload = "<?xml version='1.0' encoding='utf-8'?>\n<"
      + soapenvns + ":Envelope"
      + soapes
      + sNS + ">\n"
      + szHeader
      + '<' + soapenvns + ':Body>'
      + szParams + "</" + soapenvns + ":Body>\n"
      + "</" + soapenvns + ":Envelope>\n";
    if (co.async) {
      oCall.oXmlHttp = oXmlHttp;
      oXmlHttp.xmlHttp.onreadystatechange = function() { getResult(oCall); };

      try {
        oXmlHttp.xmlHttp.send(szPayload);
      } catch(e) {
        return postError(oCall, 5);
      }
      return oCall.id;
    }
    try {
      oXmlHttp.xmlHttp.send(szPayload);
    } catch(e) {
      return returnError(oCall, 5);
    }
    if (oXmlHttp.xmlHttp.responseXML.parseError.errorCode != 0) {
      _errUnknownS.raw = oXmlHttp.xmlHttp.responseText;
      return returnError(oCall, 4);
    }
    var r;
    try {
      r = processResult(oCall, oXmlHttp.xmlHttp.responseXML.documentElement);
    } catch(e) {
      return returnError(oCall, 7);
    }
    return r;
  }

  function callService(service, args) {
    var oC = allocCall();
    if (args.length < 1) {
      return postError(oC, 0);
    }
    var cb = null;
    var iM = 0;
    if (typeof args[0] == "function"
      || typeof args[0] == "object" && args[0].funcName == null) {
      iM = 1;
      cb = args[0];
    }
    var co;
    if (typeof args[iM] == 'string')
      co = createCallOptions(args[iM]);
    else
      co = cloneObject(args[iM]);
    oC.co = co;
    oC.cb = cb;
    oC.service = service;
    oC.args = args;
    if (co.async == null)
      co.async = true;
    if (co.funcName == null) {
      return postError(oC, 0);
    }
    var oS = _sdl[service];
    if (oS == null) {
      return postError(oC, 1);
    }
    if (co.async == false)
      return oS.fPending ? returnError(oC, 1) : _invoke(oC);
    if (oS.fSeq || oS.fPending) {
      if (oS.lastCall != null)
        oS.lastCall.next = oC;
      else
        oS.nextCall = oC;
      oS.lastCall = oC;
    }
    if (oS.fPending) {
      return oC.id;
    }
    if (!oS.fSeq)
      _invoke(oC);
    else if (oC == oS.nextCall && (oS.aXmlHttp == null || oS.aXmlHttp.fFree))
      invokeNext(service);
    return oC.id;
  }

  function useService(szService, userName, options) {
    if (szService == null || szService.length == 0
      || userName == null || userName.length == 0) {
      throw ("Invalid arguments");
      return;
    }
    var url = ensureWsdlUrl(szService);
    var oProp = getAttribute(userName);
    if (oProp == null) {
      oProp = window.document.createElement("<PUBLIC:PROPERTY NAME=" + userName + " />");
      _webservice.appendChild(oProp);
    }
    var oPropValue = new Object();
    setAttribute(userName, oPropValue);
    oPropValue.callService = function() { return callService(url, arguments) };
    if (_sdl[url] != null) {
      if (options != null) {
        _sdl[url].fSeq = options.reuseConnection == null
          ? false : options.reuseConnection;
        _sdl[url].SOAPHeader = options.SOAPHeader;
      }
      return;
    }
    var oXml = window.document.createElement("XML");
    window.document.body.appendChild(oXml);
    oS = new Object();
    oS.sXmlHttp = null;
    oS.aXmlHttp = null;
    oS.fPending = true;
    oS.nextCall = null;
    oS.lastCall = null;
    oS.url = url;
    oS._oXml = oXml;
    oS.ns = new Array();
    oS.nsalias = new Array();
    if (options != null) {
      oS.fSeq = options.reuseConnection;
      oS.SOAPHeader = options.SOAPHeader;
    }
    if (oS.fSeq == null)
      oS.fSeq = false;
    _sdl[url] = oS;
    oXml.service = userName;
    oXml.onreadystatechange = getWsdl;
    oXml.src = url;
    return;
  }

  function getMsg(service, co, args, argIdx) {
    var oM;
    var mn = co.funcName;
    var oS = _sdl[service];
    var sp = oS.soapPort[co.portName];
    if (sp == null)
      return null;
    oM = sp.msgs[mn];
    if (oM == null || oM.length == null) {
      return null;
    }
    var om1;
    for (om1 in oM) {
      if (co.params != null || oM[om1].args.length == args.length - argIdx) {
        oM = oM[om1];
        break;
      }
    }
    if (oM.length != null)
      oM = oM[om1];
    return oM;
  }

  function fixupDT(x) {
    return (x < 10) ? ("0" + x) : x;
  }

  function encTZ(d) {
    var tzo = d.getTimezoneOffset();
    return (tzo > 0 ? '-' : '+') + fixupDT(tzo / 60) + ':' + fixupDT(tzo % 60);
  }

  function encodePrimitive(os, argType, argVal) {
    var sz = '';
    switch (_st[argType]) {
    case 1:
      sz = argVal;
      break;
    case 2:
      sz = "<![CDATA[" + argVal + "]]>"; // <![CDATA[
      break;
    case 3:
      try {
        sz = argVal.getFullYear()
          + "-" + fixupDT(argVal.getMonth() + 1)
          + "-" + fixupDT(argVal.getDate())
          + "T" + fixupDT(argVal.getHours())
          + ":" + fixupDT(argVal.getMinutes())
          + ":" + fixupDT(argVal.getSeconds())
          + (argVal.getMilliseconds == null
            ? '' : ('.' + argVal.getMilliseconds()))
          + encTZ(argVal);
      } catch(e) {
        sz = argVal;
      }
      break;
    case 4:
      try {
        sz = argVal.getFullYear()
          + "-" + fixupDT(argVal.getMonth() + 1)
          + "-" + fixupDT(argVal.getDate())
          + encTZ(argVal);
      } catch(e) {
        sz = argVal;
      }
      break;
    case 5:
      try {
        sz = fixupDT(argVal.getHours())
          + ":" + fixupDT(argVal.getMinutes())
          + ":" + fixupDT(argVal.getSeconds())
          + (argVal.getMilliseconds == null
            ? '' : ('.' + argVal.getMilliseconds()))
          + encTZ(argVal);
      } catch(e) {
        sz = argVal;
      }
      break;
    case 6:
    case 7:
      sz = encb64(argVal);
      break;
    default:
      sz = argVal;
    }
    return sz;
  }

  function bldJsAry(a, as, d) {
    if (d == as.length - 1)
      return;
    for (var i = 0; i < as[d]; i++) {
      a[i] = new Array();
      bldJsAry(a[i], as, d + 1)
    }
  }

  function getNextIndexAry(a, ai) {
    var i;
    var l = a.length;
    if (ai.length == 0) {
      for (i = 0; i < l; i++)
        ai[i] = 0;
      return true;
    }
    for (i = l - 1; i >= 0; i--) {
      if (i == 0 && 1 + ai[0] > a[0] - 1)
        return false;
      var x = ai[i] + 1;
      if (x <= a[i] - 1) {
        ai[i] = x;
        return true;
      }
      ai[i] = 0;
    }
    return true;
  }

  function vbArrayToJs(a, d) {
    ensureVBArray(d);
    var szSize;
    try {
      szSize = VBGetArySize(a, d);
    } catch(e) {
      return new Array()
    }
    var aSize = szSize.toString().split(",");
    var aszIndex = new Array();
    var ajs = new Array();
    bldJsAry(ajs, aSize, 0);
    var ai = new Array();
    while (true == getNextIndexAry(aSize, ai)) {
      var s = "ajs[" + ai.join("][") + "]=VBGetAryItem" + d + "(a," + ai.join(",") + ");";
      try {
        eval(s);
      } catch(e) {
        break;
      }
    }
    return ajs;
  }

  function encodeArray(os, t, nt, v, d) {
    var sz = "";
    for (var i in v) {
      if (d == 1) {
        var ar = encodeVar(os, v[i], nt);
        xt = ' xsi:type="' + (t.ns == '' ? '' : (t.ns + ':')) + t.type + '"';
        sz += '\n<' + t.type + ar[1] + xt + '>' + ar[0] + '</' + t.type + '>';
      } else
        sz += encodeArray(os, t, nt, v[i], d - 1);
    }
    return sz;
  }

  function encodeVar(oS, v, t) {

    var ar = new Array("", "");
    if (v == null)
      return ar;
    var oschm = getSchema(oS, t);
    var ae = t.fArray ? t : getAryElem(os, oschm, t);
    if (ae != null) {
      if (typeof v != 'object' && typeof v != 'unknown')
        return ar;
      var nt = cloneObject(ae);
      nt.fArray = false;
      var sArr = ae.sizeArray;

      var k = 1;
      k = (sArr == null) ? 1 : sArr.length;
      if (typeof v == 'unknown')
        v = vbArrayToJs(v, k);
      ar[0] += encodeArray(oS, ae, nt, v, k);
      return ar;
    }

    if (isSimpleType(oS, oschm, t)) {
      ar[0] = encodePrimitive(oS, t.type, v);
      return ar;
    }
    var et = oschm.types[t.type];


    if (et == null) {
      try {
        var os = v.childNodes;

        for (var i = 0; i < os.length; i++) {
          ar[0] += os[i].xml;
        }
      } catch(e) {
        ar[0] += v;
      }
      return ar;
    }
    if (typeof v != 'object' || v.length > 0) {
      var et1 = get1stAryItem(et);

      if (et1 == null)
        return ar;
      return encodeVar(oS, v, et1)
    }

    for (var k in et) {
      if (et[k] == null)
        continue;
      if (v[k] == null) {
        if (!et[k].fAttrib)
          ar[0] += '\n<' + et[k].name + ' xsi:null="true"' + '/>\n';
        continue;
      }
      if (et[k].fAttrib) {
        ar[1] += encodeAttrib(oS, v[k], et[k]);
        continue;
      }
      var qt = "";
      var asi = "";
      var it = getAryElem(oS, getSchema(oS, et[k]), et[k]);
      var soapencns = oS.qlt["soapenc"];
      if (it != null) {
        asi = getArySizeInfo(it, v[k]);
        var ts = (isPrimitive(oS, it) || et[k].ns == "")
          ? "xsd:" : (et[k].ns + ":");
        asi = ' xsi:type="' + soapencns + ':Array" '
          + soapencns + ':arrayType="' + ts + it.type + '[' + asi + ']"';
      } else if (isPrimitive(oS, et[k]))
        qt = ' xsi:type="xsd:' + et[k].type + '"';
      var ark = encodeVar(oS, v[k], et[k]);
      ar[0] += '\n<' + et[k].name + qt + asi + ark[1] + '>'
        + ark[0] + '</' + et[k].name + '>';
    }
    return ar;
  }

  function getArySize(a) {
    var l = 0;
    for (var x in a)
      l++;
    return l;
  }

  function get1stAryItem(a) {
    for (var x in a)
      return a[x];
    return null;
  }

  function getAryItemFromIndex(a, index) {
    var i = 0;
    for (var x in a) {
      if (i == index)
        return a[x];
      i++;
    }
    return null;
  }

  function getSchema(os, t) {
    if (isPrimitive(os, t))
      return null;
    if (t.ns == null)
      return get1stAryItem(os.schemas);
    var nsUrl = os.ns[t.ns];
    var oschm = os.schemas[nsUrl];
    if (oschm != null || t.ns.length == 0)
      return oschm;

    for (var x in os.schemas)
      if (x.indexOf(nsUrl) == 0 && os.schemas[x].types[t.type] != null)
        return os.schemas[x];

    return null;
  }

  function getArySizeInfo(at, av) {
    var as = at.sizeArray;
    var k = 1;
    k = (as == null) ? 1 : as.length;
    var arr = av;
    if (typeof arr == 'unknown')
      arr = vbArrayToJs(arr, k);
    var sArr = getArySize(arr);
    if (as == null)
      return sArr;
    sArr = "";
    for (var j = 0;;) {
      var l2 = getArySize(arr);
      if (as[j] == null)
        sArr += l2;
      else
        sArr += Math.min(as[j], l2);
      j = j + 1;
      if (j == as.length)
        break;
      sArr += ",";
      if (l2 == 0)
        return null;
      arr = get1stAryItem(arr);
    }
    return sArr;
  }

  function encodeAttrib(oS, v, t) {
    if (t.type == null)
      return "";
    return " " + t.name + '="' + encodePrimitive(oS, t.type, v) + '"';
  }

  function serPart(oS, oM, a, v) {
    var sz = "";
    var szt = '';
    if (a.type != null && isPrimitive(oS, a))
      szt = ' xsi:type="xsd:' + a.type + '"';
    var oschm = getSchema(oS, a);
    var aryItem = a.fArray ? a : getAryElem(oS, oschm, a);
    var soapencns = oS.qlt["soapenc"];
    if (aryItem != null) {
      var sArr = getArySizeInfo(aryItem, v);
      var oschm = getSchema(oS, aryItem);
      if (oschm != null)
        aryItem.ns = oS.nsalias[oschm.uri];

      var ts = (isPrimitive(oS, aryItem) || aryItem.ns == "")
        ? "xsd:" : (aryItem.ns + ":");
      szt = ' xsi:type="' + soapencns + ':Array" '
        + soapencns + ':arrayType="' + ts + aryItem.type + '[' + sArr + ']"';
    } else
      szt = ' xsi:type="' + (a.ns == '' ? '' : (a.ns + ':')) + a.type + '"';
    et = (a.elem == null || oschm == null) ? a : oschm.elems[a.elem];
    var ar = encodeVar(oS, v, et);

    if (oM.fLiteral) {
      if (a.elem == null) {
        if (oM.fWrapped || oM.fRpc) {
          sz += '\n<' + a.name + ar[1] + '>' + ar[0];
          sz += '</' + a.name + '>';
        } else
          sz += ar[0];
      } else {
        var ns = ' xmlns="' + (a.ns == null ? oS.targetns : oS.ns[a.ns]) + '"';
        sz += '\n<' + a.elem + ns + ar[1] + '>' + ar[0];
        sz += '</' + a.elem + '>';
      }
    } else {
      if (a.type == null)
        a.type = a.elem;
      var stn = 'mswsb:' + (oM.fRpc ? et.name : et.type);
      stn = aryItem == null ? stn : (soapencns + ":Array");
      n = "";
      if (oM.fWrapped || oM.fRpc && oM.opname != null)
        stn = a.name;
      else if (aryItem == null)
        n = ' xmlns:mswsb="' + (a.ns == null ? oS.targetns : oS.ns[a.ns]) + '"';
      sz += '\n<' + stn + n + szt + ar[1] + '>' + ar[0];
      sz += '</' + stn + '>';
    }
    return sz;
  }

  function getWrap(aWrap, oS, oM, argv) {
    if (!oM.fRpc && !oM.fWrapped)
      return argv;
    var mn = oM.opname;
    var pns = oM.fLiteral ? "" : "mswsb:";
    var nsq1 = oM.ns;
    if (!oM.fRpc) {
      var firstArg = get1stAryItem(argv);
      var oschm = getSchema(oS, firstArg);
      if (firstArg.type != null) {
        argv = oschm.types[firstArg.type];
        mn = firstArg.type;
      } else {
        var e = oschm.elems[firstArg.elem];
        oschm = getSchema(oS, e);
        mn = null;
        if (oschm != null) {
          var et = oschm.types[e.type];
          if (et != null)
            argv = et;
          mn = firstArg.elem;
        }
      }
      nsq1 = oS.ns[firstArg.ns];
    }
    if (mn == null)
      return argv;
    var ns1 = nsq1 == null ? oS.targetns : nsq1;
    var nsd1 = ' xmlns' + (oM.fLiteral ? '' : ':mswsb') + '="' + ns1 + '"';
    aWrap[0] = '\n<' + pns + mn + nsd1 + (oM.fLiteral ? '' : ' xmlns=""');
    aWrap[1] = "</" + pns + mn + ">";
    return argv;
  }

  function encodeArgs(oS, oM, omargs, args, j, fParam) {

    var l = fParam ? 0 : args.length;
    var sz = '';
    var sa = '';
    var aWrap = new Array("", "");
    omargs = getWrap(aWrap, oS, oM, omargs);
    var i = j;

    for (var pn in omargs) {
      var a = omargs[pn];
      if (a.elem == null && a.type == null)
        return null;
      if (!fParam && i >= l)
        break;
      var argi = fParam ? args[pn] : args[i++];
      if (argi == null)
        continue;

      if (a.fAttrib)
        sa += encodeAttrib(oS, argi, a);
      else
        sz += serPart(oS, oM, a, argi);

    }
    return aWrap[0] + sa + (aWrap[0].length > 0 ? ">" : "") + sz + aWrap[1];
  }

  function returnResult(oCall, r) {
    hideProgress();
    if (oCall.co.async == false) {
      return r;
    }
    if (oCall.cb == null) {
      var evt = createEventObject();
      evt.result = r;
      try {
        eventResult.fire(evt);
      } catch(e) {
      }
      ;
    } else {
      try {
        oCall.cb(r);
      } catch(e) {
      }
      ;
    }
  }

  function decTZ(s) {
    var a = s.split(':');
    if (a.length == 0)
      return 0;
    var h = parseInt(a[0], 10);
    return (-h) * 60 + (a.length > 1 ? ((h > 0 ? -1 : 1) * parseInt(a[1], 10)) : 0);
  }

  function applyTZ(d, tzo) {
    d.setTime(d.getTime() + (tzo - d.getTimezoneOffset()) * 60000);
  }

  function decDate(d, s) {
    var a = s.split('-');
    if (a.length < 3)
      return;
    d.setYear(a[0]);
    d.setMonth(parseInt(a[1], 10) - 1);
    d.setDate(a[2]);
    var tzo = d.getTimezoneOffset();
    var tzi = s.indexOf('+');
    if (a.length >= 4)
      tzo = -decTZ(a[3]);
    else if (tzi > 0)
      tzo = decTZ(s.substring(tzi, s.length));
    else
      return;
    applyTZ(d, tzo);
  }

  function decTime(d, s) {
    var tzi = s.indexOf('+');
    if (tzi < 0)
      tzi = s.indexOf('-');
    var a = s.split(':');
    if (a.length < 3)
      return;
    d.setHours(a[0]);
    d.setMinutes(a[1]);
    d.setSeconds(parseInt(a[2], 10));
    var msec = a[2].split('.')[1];
    if (msec != null && d.setMilliseconds != null)
      d.setMilliseconds(parseInt(msec.substring(0, 3, 10)));
    applyTZ(d, tzi < 0 ? 0 : decTZ(s.substring(tzi, s.length)));
  }

  function decodePrimitive(os, st, o) {
    var r = o.hasChildNodes() ? o.firstChild.nodeValue : o.nodeValue;
    if (r == null) {
      if (_st[st] == null || _st[st] == 1)
        return '';
      return null;
    }
    switch (_st[st]) {
    case 0:
      try {
        r = eval(r);
      } catch(e) {
      }
      break;
    case 1:
      break;
    case 3:
    case 4:
      var aXmlDT = r.split("T");
      r = new Date();
      if (aXmlDT.length > 0) {
        decDate(r, aXmlDT[0]);
        if (aXmlDT.length > 1)
          decTime(r, aXmlDT[1]);
      }
      break;
    case 5:
      var s = r;
      r = new Date();
      decTime(r, s);
      break;
    case 6:
      r = decb64(r, false);
      break;
    case 7:
      r = decb64(r, true);
      break;
    default:
      break;
    }
    return r;
  }

  function getAryInfo(oS, o) {
    var oAt = o.attributes.getQualifiedItem("arrayType", oS.ns[oS.qlt["soapenc"]]);
    if (oAt == null)
      return null;
    var at = new Array();
    var asa = oAt.value.split("[");
    if (asa.length > 1)
      parseArrayType(at, asa[1]);
    else
      at[0] = o.childNodes.length;
    return at;
  }

  function decodeArray(c, a, s, d, o, os, osc, t, e, aNodes, fSimple) {
    for (var i = 0; i < s[d - 1]; i++) {
      if (d == s.length)
        a[i] = decodeAryItem(os, osc, t, e, o[c++], aNodes, fSimple);
      else {
        a[i] = new Array();
        c = decodeArray(c, a[i], s, d + 1, o, os, osc, t, e, aNodes, fSimple);
      }
    }
    return c;
  }

  function decodeAryItem(os, osc, t, e, v, aNodes, fSimple) {
    if (fSimple)
      return decodePrimitive(os, e.type, v);
    if (e.type == "anyType")
      return v;
    var sr = getAttrib(v, "href");
    if (sr != null && sr.charAt(0) == '#')
      v = aNodes[sr.substring(1, sr.length)];
    var e1 = getAryElem(os, osc, e);
    if (e1 == e || e1 == null)
      return decodeType(os, t, v, aNodes);
    else
      return decodeElem(os, e1, v, aNodes);
  }

  function getAryElem(os, oschm, e) {
    if (oschm == null)
      return null;
    var e1 = get1stAryItem(oschm.types[e.type]);
    return (e1 != null && e1.fArray) ? e1 : null;
  }

  function decodeElem(os, e, o, aNodes) {
    var oschm = getSchema(os, e);
    if (isSimpleType(os, oschm, e) && !e.fArray) {
      var stype = oschm == null ? e.type : oschm.sTypes[e.type];
      return decodePrimitive(os, stype, o);
    }
    var ae = e.fArray ? e : getAryElem(os, oschm, e)
    if (ae != null) {
      var ai = getAryInfo(os, o);
      var o2 = o.childNodes;
      if (ai == null) {
        ai = ae.sizeArray;
        if (ai == null) {
          ai = new Array();
          ai[0] = o2.length;
        }
      }
      if (ai.length == 1 && ai[0] == null)
        ai[0] = o2.length;
      oschm = getSchema(os, ae);
      var r = new Array();
      var fSimple = isSimpleType(os, oschm, ae);
      decodeArray(0, r, ai, 1, o2, os, oschm,
        fSimple ? null : oschm.types[ae.type], ae, aNodes, fSimple);
      return r;
    }
    if (oschm == null)
      return null;
    var t1 = oschm.types[e.type];
    if (t1 == null) {
      return o;
    }
    return decodeType(os, t1, o, aNodes);
  }

  function decodeType(os, ot, o, aNodes) {
    if (ot == null)
      return null;
    var j = -1;
    if (typeof ot.type == 'string')
      return decodeElem(os, ot, o, aNodes);
    var or = new Array();
    for (var sn in ot) {
      j++;
      t1 = ot[sn];
      if (t1.fAttrib == true) {
        var attrib = o.attributes.getNamedItem(sn);
        if (attrib != null)
          or[sn] = attrib.value;
        continue;
      }
      var o1 = o.selectSingleNode(sn);
      var fHasKids = o1 != null;
      if (o1 == null)
        o1 = getAryInfo(os, o) == null && o.hasChildNodes() ? o.childNodes[j] : o;
      if (o1 == null)
        continue;
      var st = t1.type;
      if (st == null) {
        var oschm = getSchema(os, t1);
        if (t1.elem == null || oschm == null)
          or[sn] = null;
        else
          or[sn] = decodeElem(os, oschm.elems[t1.elem], o1, aNodes);
        continue;
      }
      if (!o1.hasChildNodes()) {
        var sr = null;
        sr = getAttrib(o1, "href");
        if (sr != null && sr.charAt(0) == '#') {
          o1 = aNodes[sr.substring(1, sr.length)];
        } else if (isSimpleType(os, getSchema(os, t1), t1)) {
          or[sn] = decodePrimitive(os, st, o1);
          continue;
        } else if (!fHasKids) {
          or[sn] = null;
          continue;
        }
      }
      or[sn] = decodeElem(os, t1, o1, aNodes);
    }
    return or;
  }

  function processResult(oC, oResult) {
    var r = new Object();
    r.id = oC.id;
    r.error = true;
    if (oResult == null) {
      if (oC.oM.fOneWay)
        r.error = false;
      else
        r.errorDetail = _errUnknownS;
      return returnResult(oC, r);
    }
    var pf = oResult.prefix;
    var ns = pf == null || pf == "" ? "" : (pf + ":");
    var oS = _sdl[oC.service];
    if (oS == null || oS.fPending) {
      r.errorDetail = _errNotReady;
      return returnResult(oC, r);
    }
    var oHeader = oResult.selectSingleNode(ns + "Header");
    if (oHeader != null) {
      var ht = oC.oM.hdrsOut;
      var rh = new Array();
      var oHdrs = oHeader.childNodes;
      var nodesRef = new Array();
      for (var i = 0; i < oHdrs.length; i++) {
        if (ht[i] == null)
          break;
        var he = ht[i].type;
        if (he.elem != null) {
          he = getSchema(oS, he).elems[he.elem];
          rh[i] = decodeElem(oS, he, oHdrs[i], nodesRef);
        } else if (he.type != null) {
          he = getSchema(oS, he).types[he.type];
          rh[i] = decodeType(oS, he, oHdrs[i], nodesRef);
        }
      }
      if (ht.length == 1)
        r.SOAPHeader = rh[0];
      else
        r.SOAPHeader = rh;
    }
    var oBody = oResult.selectSingleNode(ns + "Body");
    if (oBody == null) {
      r.errorDetail = _errInvalRes;
      return returnResult(oC, r);
    }
    var aryFault = oBody.selectNodes(ns + "Fault");
    if (aryFault.length > 0) {
      r.errorDetail = new Object();
      var ac = aryFault[0].selectNodes(ns + "faultcode");
      if (ac.length == 0)
        ac = aryFault[0].selectNodes("faultcode");
      r.errorDetail.code = ac.length > 0 ? ac[0].firstChild.nodeValue : "Unknown";
      var as = aryFault[0].selectNodes(ns + "faultstring");
      if (as.length == 0)
        as = aryFault[0].selectNodes("faultstring");
      if (as.length > 0 && as[0].hasChildNodes())
        r.errorDetail.string = as[0].firstChild.nodeValue;
      else
        r.errorDetail.string = "";
      r.errorDetail.raw = oResult;
      return returnResult(oC, r);
    }
    r.error = false;
    r.raw = oResult;
    var args = oC.oM.response.args;
    var l = oC.oM.response.argl;
    if (args == null || l == 0) {
      r.value = null;
      return returnResult(oC, r);
    }
    var arg0 = get1stAryItem(args);
    var o = oC.oM.fRpc || oC.oM.fWrapped ? oBody.firstChild : oBody;
    if (o == null) {
      r.value = null;
      return returnResult(oC, r);
    }
    if (!oC.oM.fRpc && oC.oM.fWrapped) {
      var oschm = oS.schemas[oS.ns[arg0.ns]];
      if (oschm != null) {
        if (arg0.elem != null) {
          arg0 = oschm.elems[arg0.elem];
          if (isSimpleType(oS, getSchema(oS, arg0), arg0)) {
            args = new Array();
            args[arg0.name] = arg0;
          } else
            args = oschm.types[arg0.type];
        } else
          args = oschm.types[arg0.type];
      }
      l = getArySize(args);
    }
    var aryNwId = o.selectNodes("//*[@id]");
    var aNodes = new Array();
    for (var i = 0; i < aryNwId.length; i++) {
      aNodes[getAttrib(aryNwId[i], "id")] = aryNwId[i];
    }
    var ar = decodeType(oS, args, o, aNodes);
    if (l == 1) {
      for (var i in ar) {
        r.value = ar[i];
        break;
      }
    } else
      r.value = ar;
    return returnResult(oC, r);
  }

  function hideProgress() {
    if (_mProg == null || _mProg.parentElement == null)
      return;
    element.document.body.removeChild(_mProg);
  }

  function getResult(oC) {
    if (oC == null) return;
    var oS = _sdl[oC.service];
    var xmlHttp = oC.oXmlHttp.xmlHttp;
    if (xmlHttp == null || xmlHttp.readyState != 4) return;
    if (oC.fDone)
      return;
    oC.fDone = true;
    if (xmlHttp.responseXML.parseError.errorCode != 0) {
      _errUnknownS.raw = xmlHttp.responseText;
      returnError(oC, 4);
    } else {
      try {
        processResult(oC, xmlHttp.responseXML.documentElement);
      } catch(e) {
        returnError(oC, 7);
      }
    }
    oC.oXmlHttp.fFree = true;
    callNext(oS);
  }

  function getJsArrayItem(a) {
    var s = "a";
    for (var i = 1; i < arguments.length; i++)
      s += "[" + arguments[i] + "]";
    var ai = null;
    try {
      ai = eval(s)
    } catch(e) {
    }
    ;
    return ai;
  }

  function getJsArraySize(a) {
    return a.length;
  }

  function getJsArrayDimensions(a) {
    var x = a;
    var ai = new Array();
    var ia = 0;
    while (typeof(x) == "object" && x.length != null && x[x.length - 1] != null) {
      ai[ia++] = x.length;
      x = x[0];
    }
    return ai;
  }

  helperUtils = new Object();
  helperUtils.getJsArrayItem = getJsArrayItem;
  helperUtils.getJsArraySize = getJsArraySize;
  helperUtils.getJsArrayDimensions = getJsArrayDimensions;
}