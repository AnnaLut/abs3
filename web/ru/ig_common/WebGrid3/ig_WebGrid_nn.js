/* 
Infragistics UltraWebGrid Script 
Version 3.0.20041.11
Copyright (c) 2001-2004 Infragistics, Inc. All Rights Reserved.
*/

if(window.addEventListener)
	window.addEventListener('keydown',igtbl_windowKeyDown,false);

function igtbl_button(gn,evnt)
{
	if(evnt.button==0)
	{
		if(evnt.detail!=0)
			return 0;
		var gs=igtbl_getGridById(gn);
		if(gs.Element.getAttribute("mouseDown"))
			return 0;
		else
			return -1;
	}
	else if(evnt.button==1)
		return 1;
	else if(evnt.button==2)
		return 2;
	return -1;
}

function igtbl_srcElement(evnt)
{
	var se;
	if(evnt.target)
		se=evnt.target;
	else if(evnt.srcElement)
		se=evnt.srcElement;
	while(se && !se.tagName)
		se=se.parentNode;
	return se;
}

function igtbl_styleName(sn)
{
	var r=sn.toLowerCase();
	var sa=r.split("-");
	for(var i=1;i<sa.length;i++)
		sa[i]=sa[i].charAt(0).toUpperCase()+sa[i].substr(1);
	r=sa.join("");
	return r;
}

function igtbl_changeStyle(gn,se,style)
{
	var rem=false;
	var rules=null;
	if(style==null)
	{
		style=se.getAttribute("newClass");
		if(!style)
			return;
		rem=true;
	}
	rules=new Array();
	var styles=style.split(' ');
	for(var k=0;k<styles.length;k++)
		for(var i=0;i<document.styleSheets.length;i++)
			for(var j=0;j<document.styleSheets[i].cssRules.length;j++)
				if(document.styleSheets[i].cssRules[j].selectorText=="."+styles[k])
				{
					rules[k]=document.styleSheets[i].cssRules[j];
					break;
				}
	if(rules.length==0)
	{
		delete rules;
		return;
	}
	if(!rem)
		se.setAttribute("newClass",style);
	else
		se.removeAttribute("newClass");
	var s="";
	for(var k=0;k<rules.length;k++)
		for(var i=0;i<rules[k].style.length;i++)
			if(rules[k].style.item(i)!="white-space")
			{
				if(!rem)
				{
					se.setAttribute(rules[k].style.item(i),se.style.getPropertyValue(rules[k].style.item(i)));
					eval("se.style."+igtbl_styleName(rules[k].style.item(i))+"='"+rules[k].style.getPropertyValue(rules[k].style.item(i))+"';");
				}
				else
					eval("se.style."+igtbl_styleName(rules[k].style.item(i))+"='"+se.getAttribute(rules[k].style.item(i))+"';");
			}
	delete rules;
}

function igtbl_initEvent(se)
{
	this.target=se;
}

function igtbl_adjustLeft(e)
{
	return 0;
}

function igtbl_adjustTop(e)
{
	return 0;
}

function igtbl_clientWidth(e)
{
	return e.offsetWidth;
}

function igtbl_clientHeight(e)
{
	return e.offsetHeight;
}

function igtbl_windowKeyDown(evnt)
{
	if(igtbl_lastActiveGrid!="" && evnt.keyCode!=13)
		if(igtbl_onKeyDown(evnt,igtbl_lastActiveGrid)==true)
		{
			evnt.stopPropagation();
			evnt.preventDefault();
		}
}

function igtbl_getInnerText(sourceElement)
{
	var res="";
	var str=sourceElement.innerHTML;
	for(var i=0;i<str.length;i++)
	{
		if(str.length-i>=6 && str.substr(i,6)=="&nbsp;")
		{
			res+=' ';
			i+=5;
		}
		else if(str.length-i>=6 && str.substr(i,6)=="&quot;")
		{
			res+='"';
			i+=5;
		}
		else if(str.length-i>=5 && str.substr(i,5)=="&amp;")
		{
			res+='&';
			i+=4;
		}
		else if(str.length-i>=4 && str.substr(i,4)=="&lt;")
		{
			res+='<';
			i+=3;
		}
		else if(str.length-i>=4 && str.substr(i,4)=="&gt;")
		{
			res+='>';
			i+=3;
		}
		else
			res+=str.charAt(i);
	}
	return res;
}

function igtbl_setInnerText(sourceElement,str)
{
	var res="";
	for(var i=0;i<str.length;i++)
	{
		switch(str.charAt(i))
		{
			case ' ':
				res+="&nbsp;";
				break;
			case '<':
				res+="&lt;";
				break;
			case '>':
				res+="&gt;";
				break;
			case '&':
				res+="&amp;";
				break;
			case '"':
				res+="&quot;";
				break;
			default:
				res+=str.charAt(i);
				break;
		}
	}
	sourceElement.innerHTML=res;
}

function igtbl_showColButton(gn,se)
{
	var b=igtbl_getElementById(gn+"_bt");
	if(!b)
		return;
	var gs=igtbl_getGridById(gn);
	var bandNo=se.parentNode.parentNode.parentNode.getAttribute("bandNo");
	var columnNo=igtbl_getColumnNo(gn,se);
	var column=gs.Bands[bandNo].Columns[columnNo];
	b.style.display="";
	b.style.left=igtbl_getLeftPos(se);
	b.style.top=igtbl_getTopPos(se);
	b.style.width=igtbl_clientWidth(se);
	b.style.height=igtbl_clientHeight(se);
	b.className=column.ButtonClass;
	if(se.innerHTML==igtbl_getNullText(gn,bandNo,columnNo))
		b.value=" ";
	else if(se.firstChild.tagName=="NOBR")
		b.value=igtbl_getInnerText(se.firstChild);
	else
		b.value=igtbl_getInnerText(se);
	b.setAttribute("srcElement",se.id);
	b.focus();
	if(gs.activeRect && (gs.ActiveCell!="" || gs.ActiveRow!=""))
		gs.activeRect.style.display="none";
}

function igtbl_getDocumentElement(elemID)
{
	return document.getElementById(elemID);
}

function igtbl_onScroll(gn)
{
	var gs=igtbl_getGridById(gn);
	if(!gs) return;
	igtbl_hideEdit(gn);
	gs.alignStatMargins();
	gs.endEditTemplate();
}
