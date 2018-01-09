function DatePickerGregorianCalendar()
{
}
DatePickerGregorianCalendar.prototype.o1e= function (O1e)
{
    var l1e=O1e.getFullYear();
    return (((l1e%4==0) && (l1e%100!=0)) || (l1e%400==0))?366: 355;
};
DatePickerGregorianCalendar.prototype.i1e=[31,28,31,30,31,30,31,31,30,31,30,31];
DatePickerGregorianCalendar.prototype.O1a= function (O1e)
{
    if (this.o1e(O1e)==366 && O1e.getMonth()==1)
    {
        return 29;
    }
    return this.i1e[O1e.getMonth()];
};;
function RadDateInput(Q,P)
{
    var S=window[Q];
    if (S!=null && typeof(S.Dispose)=="\146unc\x74\x69on")
    {
        S.Dispose();
    }
    this.EmptyMessage="";
    this.AllowEmpty= false;
    this.RangeValidation= false;
    this.i10=RadDateInput.I10();
    this.o11=RadDateInput.I10();
    this.o11.setFullYear(1,0,1);
    this.O11=RadDateInput.I10();
    this.O11.setFullYear(9999,11,31);
    this.l11=RadDateInput.I10();
    this.i11=RadDateInput.I10();
    this.I11=new DatePickerGregorianCalendar();
    this.R(Q,P);
    this.o12= false;
    this.O12=null;
    var l12=this ;
this.i12= function ()
{
    if (!l12.field)
    {
        return;
    }
    var I12=l12.o13();
    l12.O13(I12);
    l12.l13();
    l12.o12= true;
    l12.i13();
    l12.o12= false;
    l12.Visualise();
};
if (this.field.addEventListener)
{
    this.field.addEventListener("blur",this.i12, false);
    this.field.form.addEventListener("submit",this.i12, false);
}
else
{
    this.field.attachEvent("on\x62\x6cur",this.i12);
    this.field.form.attachEvent("ons\x75\x62mit",this.i12);
}
}
RadDateInput.I10= function ()
{
    var I13=new Date();
    I13.setHours(0,0,0,0);
    return I13;
};
RadDateInput.prototype=new RadMaskedTextBox();
RadDateInput.prototype.SetMaxDate= function (o14)
{
    this.i11=RadDateInput.O14(o14);
};
RadDateInput.prototype.GetMaxDate= function ()
{
    return RadDateInput.l14(this.i11);
};
RadDateInput.prototype.GetMinDate= function ()
{
    return RadDateInput.l14(this.l11);
};
RadDateInput.prototype.oc= function ()
{
    return this.i10.getTime()!=this.I1.getTime();
};
RadDateInput.prototype.SetMinDate= function (o14)
{
    this.l11=RadDateInput.O14(o14);
};
RadDateInput.prototype.Clear= function ()
{
    this.SetDate(RadDateInput.l14(this.l11));
};
RadDateInput.prototype.Oa= function (ob)
{
    if (!this.m)
    {
        if (this.Ob() && this.AllowEmpty)
        {
            this.field.value=this.GetPrompt();
        }
        else
        {
        	if(this.field.value != "")
            	this.field.value=ob;
        }
    }
    else
    {
        if (this.l4)
        {
            this.field.value=this.ib();
        }
        else if (this.HideOnBlur && this.Ob())
        {
            this.field.value=this.lb();
        }
        else
        {
            if (this.AllowEmpty && this.Ob())
            {
                this.field.value=this.GetPrompt();
            }
            else
            {
            	if(this.field.value != "")
               	  this.field.value=ob;
            }
        }
    }
};
RadDateInput.O14= function (value)
{
    var N=value.split(/\x2f|\x3a|\x20/);
    var I13=RadDateInput.I10();
    I13.setFullYear(N[2],N[0]-1,N[1]);
    I13.setHours(N[3],N[4],N[5]);
    return I13;
};
RadDateInput.i14=
{
    I14: 0,FullYear: 1,o15: 2,O15: 3,l15: 4,i15: 5,I15: 6,o16: 7,O16: 8,l16: 9
};
RadDateInput.prototype.la= function ()
{
    if (this.Ob())
    {
        this.L.value="";
    }
    else
    {
        this.L.value=this.i10.getFullYear()+"\x2d"+(this.i10.getMonth()+1)+"\x2d"+this.i10.getDate()+" "+this.i10.getHours()+":"+this.i10.getMinutes()+":"+this.i10.getSeconds();
    }
};
RadDateInput.prototype.ia= function ()
{
    if (this.Ob())
    {
        this.l.value="";
    }
    else
    {
        this.l.value=this.i10.getFullYear()+"\x2d"+(this.i10.getMonth()+1)+"-"+this.i10.getDate();
    }
};
RadDateInput.prototype.il= function (i4,K,ll)
{
    if (this.o12 || this.H)
    {
        return;
    }
    this.o12= true;
    var i16=this.i10;
    var I12=this.o13();
    if (i4.I16)
    {
        i4.I16(i16,I12);
    }
    this.O13(I12);
    if (!this.RangeValidation)
    {
        this.o17();
    }
    this.o12= false;
};
RadDateInput.prototype.SetDate= function (I12)
{
    this.o12= true;
    this.O13(I12);
    this.o17();
    this.Visualise();
    this.o12= false;
};
RadDateInput.prototype.O13= function (o14)
{
    this.i16=RadDateInput.l14(this.i10);
    this.i10=o14;
    if (!this.RangeValidation)
    {
        this.l13();
    }
    else
    {
        this.O17();
    }
};
RadDateInput.prototype.l13= function ()
{
    this.i10.setTime(Math.min(this.i11.getTime(),this.i10.getTime()));
    this.i10.setTime(Math.max(this.l11.getTime(),this.i10.getTime()));
};
RadDateInput.prototype.O17= function ()
{
    this.i10.setTime(Math.min(this.O11.getTime(),this.i10.getTime()));
    this.i10.setTime(Math.max(this.o11.getTime(),this.i10.getTime()));
};
RadDateInput.prototype.Ia= function ()
{
    if (typeof(this.OnClientDateChanged)=="\146\x75nct\x69\x6fn")
    {
        this.OnClientDateChanged(this,
        {
            OldDate: this.i16,NewDate: this.i10
        }
        );
    }
    else if (typeof(window[this.OnClientDateChanged])=="\x66\x75nction")
    {
        window[this.OnClientDateChanged](this,
        {
            OldDate: this.i16,NewDate: this.i10
        }
        );
    }
    if (this.O12!=null)
    {
        this.O12(this,
        {
            OldDate: this.i16,NewDate: this.i10
        }
        );
    }
};
RadDateInput.prototype.GetDate= function ()
{
    return RadDateInput.l14(this.i10);
};
RadDateInput.l14= function (l17)
{
    var i17=RadDateInput.I10();
    i17.setTime(l17.getTime());
    return i17;
};
RadDateInput.prototype.Initialize= function ()
{
    var I12=this.o13();
    this.O13(I12);
    RadMaskedTextBox.prototype.Initialize.apply(this );
};
RadDateInput.prototype.InitializePartTypes= function (I17,o18)
{
    var O18=RadDateInput.l18();
    for (var i=0; i<I17.length; i++)
    {
        for (var j=0; j<I17[i].length; j++)
        {
            for (var i18 in O18[i])
            {
                this.N[I17[i][j]][i18]=O18[i][i18];
            }
        }
    }
    if (o18.length)
    {
        for (var i=0; i<o18.length; i++)
        {
            for (var j=0; j<o18[i].length; j++)
            {
                for (var i18 in O18[i])
                {
                    this.l4[o18[i][j]][i18]=O18[i][i18];
                }
            }
        }
    }
    var I12=this.o13();
    this.O13(I12);
    this.o17();
};
RadDateInput.prototype.o17= function ()
{
    for (var i=0; i<this.N.length; i++)
    {
        var i4=this.N[i];
        if (i4.I18)
        {
            i4.I18(this.i10);
        }
    }
};
RadDateInput.prototype.o19= function ()
{
    for (var i=0; i<this.l4.length; i++)
    {
        var i4=this.l4[i];
        if (i4.I18)
        {
            i4.I18(this.i10);
        }
    }
};
RadDateInput.prototype.i13= function ()
{
    for (var i=0; i<this.N.length; i++)
    {
        var i4=this.N[i];
        if (i4.O19)
        {
            i4.O19(this.i10);
        }
        else if (i4.I18)
        {
            i4.I18(this.i10);
        }
    }
};
RadDateInput.prototype.i1= function ()
{
    this.I1=RadDateInput.l14(this.i10);
};
RadDateInput.prototype.Ib= function ()
{
    var d=this ;
setTimeout( function ()
{
    d.SetDate(d.I1);
    d.Visualise();
}
,10);
};
RadDateInput.prototype.o13= function ()
{
    var l19=this.GetDate();
    var i19=[l19.getFullYear(),l19.getMonth(),l19.getDate(),l19.getHours(),l19.getMinutes(),l19.getSeconds(),-1,-1];
    for (var i=0; i<this.N.length; i++)
    {
        var i4=this.N[i];
        if (i4.I19)
        {
            i4.I19(i19);
        }
    }
    var o1a=RadDateInput.I10();
    o1a.setFullYear(i19[0],i19[1]);
    i19[2]=Math.min(i19[2],this.I11.O1a(o1a));
    l19.setFullYear(i19[0],i19[1],i19[2]);
    if (i19[6]!=-1 && i19[7]!=-1)
    {
        if (i19[7])
        {
            i19[6]=parseInt(i19[6])+12;
        }
        l19.setHours(i19[6],i19[4],i19[5]);
    }
    else
    {
        l19.setHours(i19[3],i19[4],i19[5]);
    }
    return l19;
};
RadDateInput.prototype.lb= function ()
{
    return this.EmptyMessage;
};
RadDateInput.prototype.ib= function ()
{
    this.o19();
    return this.i9(this.l4);
};
RadDateInput.prototype.Ob= function ()
{
    return this.l1a(this.i10,this.l11) || this.l1a(this.i10,this.o11);
};
RadDateInput.prototype.l1a= function (i1a,I1a)
{
    return i1a.getTime()==I1a.getTime();
};
RadDateInput.l18= function ()
{
    if (this.o1b==null)
    {
        this.o1b=[RadDateInputMixins.I14,RadDateInputMixins.FullYear,RadDateInputMixins.o15,RadDateInputMixins.O15,RadDateInputMixins.l15,RadDateInputMixins.i15,RadDateInputMixins.I15,RadDateInputMixins.o16,RadDateInputMixins.O16,RadDateInputMixins.l16];
    }
    return this.o1b;
};
RadDateInput.prototype.AttachCalendar= function (O1b)
{
    if (window[O1b] && !window[O1b].tagName)
    {
        this.RadCalendar=window[O1b];
        this.O12=RadDateInput.l1b;
        if (this.RadCalendar.RadDateInput)
        {
            return true;
        }
        this.RadCalendar.RadDateInput=this ;
        this.RadCalendar.OnDateSelected=RadDateInput.i1b;
        this.I1b();
        return true;
    }
    return false;
};
RadDateInput.prototype.SetCalendar= function (O1b)
{
    var d=this ;
var o1c= function ()
{
    var l9=d.AttachCalendar(O1b);
    if (l9== false)
    {
        alert("\x43\x61\x6enot fi\x6e\x64 Rad\x43alend\x61\x72 wi\x74\150\x20ID \x3d "+O1b);
    }
};
if (window.attachEvent)
{
    window.attachEvent("onl\x6f\x61d",o1c);
}
else if (window.addEventListener)
{
    window.addEventListener("\154oa\x64",o1c, false);
}
};
RadDateInput.prototype.I1b= function ()
{
    var i10=this.GetDate();
    var I12=new Array();
    I12[0]=i10.getFullYear();
    I12[1]=i10.getMonth()+1;
    I12[2]=i10.getDate();
    var O1c=this.RadCalendar.OnDateSelected;
    this.RadCalendar.OnDateSelected=null;
    var navigate= true;
    var l1c=this.i1c;
    if (l1c)
    {
        navigate=I12[0]!=l1c[0] || I12[1]!=l1c[1];
        this.RadCalendar.UnselectDate(this.i1c, false);
    }
    if (this.AllowEmpty && this.Ob())
    {
        if (this.i1c)
        {
            this.RadCalendar.UnselectDate(this.i1c, false);
        }
    }
    else
    {
        if (this.RadCalendar.SelectDate(I12,navigate)== false)
        {
            var i16=RadDateInput.I10();
            i16.setFullYear(l1c[0],l1c[1]-1,l1c[2]);
            var I1c=this.O12;
            this.O12=null;
            this.SetDate(i16);
            this.O12=I1c;
        }
        else
        {
            this.i1c=I12;
        }
    }
    this.RadCalendar.OnDateSelected=O1c;
};
RadDateInput.l1b= function (o1d,O1d)
{
    o1d.I1b();
};
RadDateInput.i1b= function (O1d)
{
    var i10=RadDateInput.I10();
    var l1c=O1d.Date;
    i10.setFullYear(l1c[0],l1c[1]-1,l1c[2]);
    var O1c=this.RadDateInput.O12;
    this.RadDateInput.i1c=l1c;
    this.RadDateInput.O12=null;
    this.RadDateInput.SetDate(i10);
    this.RadDateInput.i13();
    this.RadDateInput.O12=O1c;
};
function l1d(i1d)
{
    var I1d=document.getElementById("Tr\x61cer");
    if (!I1d)
    {
        I1d=document.createElement("div");
        I1d.id="Tracer";
        document.body.appendChild(I1d);
    }
    I1d.innerHTML+="&quot\x3b"+i1d+"\x26quot;<b\x72\x20/>";
};
function RadDateInputMixins()
{
}
RadDateInputMixins.I14=
{
    I19:function (i19)
    {
        var value=this.GetValue().toString();
        if (value.length==1)value="0"+value;
        i19[0]="20"+value;
    }
    ,I18:function (O1e)
    {
        this.value=O1e.getFullYear().toString().substr(2);
    }
};
RadDateInputMixins.FullYear=
{
    I19:function (i19)
    {
        i19[0]=this.GetValue();
    }
    ,I18:function (O1e)
    {
        this.value=O1e.getFullYear().toString();
    }
};
RadDateInputMixins.o15=
{
    I19:function (i19)
    {
        i19[1]=this.or?this.Iu(): this.GetValue()-1;
    }
    ,O19:function (O1e)
    {
        if (this.or)
        {
            this.is(O1e.getMonth());
        }
        else
        {
            this.value=O1e.getMonth()+1;
        }
    }
    ,I18:function (O1e)
    {
        if (this.or)
        {
            this.is(O1e.getMonth());
        }
        else
        {
            this.value=O1e.getMonth()+1;
        }
    }
    ,I16:function (i16,I12)
    {
        if (this.iq==0)
        {
            return;
        }
        var W=this.iq*12;
        var value=this.or?this.Iu(): this.GetValue()-1;
        I12.setMonth(value+W);
    }
};
RadDateInputMixins.O15=
{
    I19:function (i19)
    {
        i19[2]=this.GetValue();
    }
    ,O19:function (O1e)
    {
        this.value=O1e.getDate();
        this.ix=this.A.I11.O1a(O1e);
    }
    ,I18:function (O1e)
    {
        this.value=O1e.getDate();
        this.ix=this.A.I11.O1a(O1e);
    }
    ,I16:function (i16,I12)
    {
        if (this.iq==0)
        {
            return;
        }
        var W=this.iq==1?this.ix: -this.ix;
        I12.setDate(this.value+W);
    }
};
RadDateInputMixins.l15=
{
    I19:function (i19)
    {
    }
    ,I18:function (O1e)
    {
        this.is(O1e.getDay());
    }
    ,I16:function (i16,I12)
    {
        var move=i16.getDay()-this.Iu()-(this.iq*7);
        I12.setDate(I12.getDate()-move);
    }
};
RadDateInputMixins.i15=
{
    I19:function (i19)
    {
        i19[6]=11-this.Iu();
    }
    ,I18:function (O1e)
    {
        this.is(11-(O1e.getHours()%12));
    }
    ,I16:function (i16,I12)
    {
        var W=this.iq*12;
        I12.setHours(I12.getHours()-W);
    }
};
RadDateInputMixins.I15=
{
    I19:function (i19)
    {
        i19[3]=this.GetValue();
    }
    ,I18:function (O1e)
    {
        this.value=O1e.getHours();
    }
    ,I16:function (i16,I12)
    {
        var W=this.iq*24;
        I12.setHours(I12.getHours()+W);
    }
};
RadDateInputMixins.o16=
{
    I19:function (i19)
    {
        i19[7]=this.Iu();
    }
    ,I18:function (O1e)
    {
        this.is(O1e.getHours()>=12?1: 0);
    }
};
RadDateInputMixins.O16=
{
    I19:function (i19)
    {
        i19[4]=this.GetValue();
    }
    ,I18:function (O1e)
    {
        this.value=O1e.getMinutes();
    }
    ,I16:function (i16,I12)
    {
        var W=this.iq*60;
        I12.setMinutes(I12.getMinutes()+W);
    }
};
RadDateInputMixins.l16=
{
    I19:function (i19)
    {
        i19[5]=this.GetValue();
    }
    ,I18:function (O1e)
    {
        this.value=O1e.getSeconds();
    }
    ,I16:function (i16,I12)
    {
        var W=this.iq*60;
        I12.setSeconds(I12.getSeconds()+W);
    }
};;
function RadDigitMaskPart()
{
};
RadDigitMaskPart.prototype=new RadMaskPart();
RadDigitMaskPart.prototype.GetValue= function ()
{
    return this.value.toString();
};
RadDigitMaskPart.prototype.Z= function ()
{
    return true;
};
RadDigitMaskPart.prototype.o= function ()
{
    if (this.value.toString()=="")
    {
        return this.PromptChar;
    }
    return this.value.toString();
};
RadDigitMaskPart.prototype.w= function (value,W)
{
    if (isNaN(parseInt(value)))
    {
        this.A.Im(this,this.GetValue(),value);
        return false;
    }
    return true;
};
RadDigitMaskPart.prototype.SetValue= function (value,W)
{
    if (value=="" || value==this.PromptChar || value==" ")
    {
        this.value="";
        return true;
    }
    if (this.w(value,W))
    {
        this.value=parseInt(value);
    }
    return true;
};;
function RadEnumerationMaskPart(Io)
{
    this.oq(Io);
    this.Oq=-1;
    this.lq=0;
    this.iq=0;
    this.Iq();
};
RadEnumerationMaskPart.prototype=new RadMaskPart();
RadEnumerationMaskPart.prototype.oq= function (Io)
{
    this.length=0;
    this.or=Io;
    this.Or=[];
    for (var i=0; i<this.or.length; i++)
    {
        this.length=Math.max(this.length,this.or[i].length);
        this.Or[this.or[i]]=i;
    }
};
RadEnumerationMaskPart.prototype.w= function ()
{
    return true;
};
RadEnumerationMaskPart.prototype.o4= function (A)
{
    this.A=A;
    this.lr(A.AllowEmptyEnumerations);
};
RadEnumerationMaskPart.prototype.lr= function (ir)
{
    if (ir)
    {
        this.value="";
        this.selectedIndex=-1;
    }
    else
    {
        this.value=this.or[0];
        this.selectedIndex=0;
    }
};
RadEnumerationMaskPart.prototype.Iq= function ()
{
    this.Ir=[];
    for (i=0; i<this.length; i++)
    {
        this.Ir[i]="";
    }
    this.os= true;
};
RadEnumerationMaskPart.prototype.Z= function ()
{
    return true;
};
RadEnumerationMaskPart.prototype.ShowHint= function (Os)
{
    var d=this ;
    for (var i=0; i<this.or.length; i++)
    {
        var ls=document.createElement("a");
        ls.index=i;
ls.onclick= function ()
{
    d.is(this.index);
    d.A.Visualise();
    return false;
};
ls.innerHTML=this.or[i];
ls.href="j\x61\x76\x61script\x3a\x76oid\x28\060\x29";
Os.appendChild(ls);
}
return true;
};
RadEnumerationMaskPart.prototype.Is= function ()
{
    this.ot=0;
};
RadEnumerationMaskPart.prototype.Ot= function ()
{
    this.lq++;
};
RadEnumerationMaskPart.prototype.lt= function (value,W)
{
    if (this.Oq==W)
    {
        if (this.Ir[W]==value)
        {
            this.Ot();
        }
        else
        {
            this.Iq();
        }
    }
    else
    {
        this.Is();
    }
    this.Oq=W;
    this.Ir[W]=value;
};
RadEnumerationMaskPart.prototype.it= function ()
{
    if (this.A.AllowEmptyEnumerations)
    {
        this.is(-1);
    }
};
RadEnumerationMaskPart.prototype.SetValue= function (value,W)
{
    W-=this.W;
    this.lt(value,W);
    var It=new CompletionList(this.or,this.PromptChar);
    var ou=It.Ou(this.Ir,W);
    if (ou.length>0)
    {
        var lu=this.Or[ou[this.lq%ou.length]];
        this.is(lu);
    }
    else
    {
        this.it();
        return false;
    }
    return true;
};
RadEnumerationMaskPart.prototype.o= function ()
{
    var iu=this.value;
    while (iu.length<this.length)
    {
        iu+=this.PromptChar;
    }
    return iu;
};
RadEnumerationMaskPart.prototype.I= function ()
{
    return this.length;
};
RadEnumerationMaskPart.prototype.Iu= function ()
{
    return this.selectedIndex;
};
RadEnumerationMaskPart.prototype.is= function (index,ov)
{
    var K=this.value;
    if (this.A.AllowEmptyEnumerations)
    {
        if (index<-1)
        {
            index=this.or.length+index+1;
            this.iq=-1;
        }
        else if (index>=this.or.length)
        {
            index=index-this.or.length-1;
            this.iq=1;
        }
    }
    else
    {
        if (index<0)
        {
            index=this.or.length+index;
            this.iq=-1;
        }
        else if (index>=this.or.length)
        {
            index=index-this.or.length;
            this.iq=1;
        }
    }
    this.selectedIndex=index;
    this.value=index==-1?"": this.or[index];
    if (typeof(ov)!="undefin\x65d")
    {
        if (ov)
        {
            this.A.Il(this,K,this.value);
        }
        else
        {
            this.A.om(this,K,this.value);
        }
    }
    this.A.il(this,K,this.value);
    this.iq=0;
};
RadEnumerationMaskPart.prototype.Ih= function (e)
{
    this.A.i8();
    var Ov=new MaskedEventWrap(e,this.A.field);
    if (Ov.oo())
    {
        this.is(this.selectedIndex+1, false);
        this.A.Visualise();
        this.A.I6(Ov);
        return true;
    }
    else if (Ov.In())
    {
        this.is(this.selectedIndex-1, true);
        this.A.Visualise();
        this.A.I6(Ov);
        return true;
    }
};
RadEnumerationMaskPart.prototype.lh= function (e)
{
    this.A.i8();
    var Ov=new MaskedEventWrap(e,this.A.field);
    this.is(this.selectedIndex-e.wheelDelta/120);
    this.A.Visualise();
    this.A.I6(Ov);
    return false;
};
function CompletionList(options,lv)
{
    this.options=options;
    this.lv=lv;
};
CompletionList.prototype.Ou= function (iv,W)
{
    var ou=this.options;
    for (var Iv=0; Iv<=W; Iv++)
    {
        var I7=iv[Iv].toLowerCase();
        ou=this.ow(ou,Iv,I7);
    }
    return ou;
};
CompletionList.prototype.ow= function (ou,Ow,lw)
{
    var iw=[];
    for (var Iw=0; Iw<ou.length; Iw++)
    {
        var ox=ou[Iw];
        var Ox=ox.charAt(Ow).toLowerCase();
        if (this.lx(lw,Ox))
        {
            iw[iw.length]=ox;
        }
    }
    return iw;
};
CompletionList.prototype.lx= function (I7,Ox)
{
    return I7==this.lv || I7==" " || I7==Ox;
};;
function RadFreeMaskPart()
{
};
RadFreeMaskPart.prototype=new RadMaskPart();
RadFreeMaskPart.prototype.Z= function ()
{
    return true;
};
RadFreeMaskPart.prototype.o= function ()
{
    if (this.value.toString()=="")
    {
        return this.PromptChar;
    }
    return this.value;
};
RadFreeMaskPart.prototype.SetValue= function (value,W)
{
    this.value=value;
    return true;
};;
function RadInputHint(parent,P)
{
    this.I1e=parent;
    this.P=P;
}
RadInputHint.prototype.Show= function (Oh,oj)
{
    if (Oh)
    {
        var o1f=this.O1f(this.I1e.field);
        this.Container=document.createElement("d\x69v");
        if (Oh.ShowHint(this.Container))
        {
            this.Container.className="\x48int_"+this.P;
            document.body.appendChild(this.Container);
            this.Container.style.position="absolute";
            if (oj)
            {
                this.Container.style.left=oj.left+this.l1f()+"\x70x";
                this.Container.style.top=o1f.Y+o1f.Height+"\x70x";
            }
            else
            {
                this.Container.style.left=o1f.X+"\x70\170";
                this.Container.style.top=o1f.Y+o1f.Height+"\x70\x78";
            }
            this.i1f();
            this.I1e.Om(this );
        }
        else
        {
            this.Container=null;
        }
    }
};
RadInputHint.prototype.I1f= function ()
{
    if (this.o1g)
    {
        this.o1g.style.visibility="\x68idden";
    }
};
RadInputHint.prototype.i1f= function ()
{
    if (window.opera)
    {
        return;
    }
    if (!this.o1g)
    {
        this.o1g=document.createElement("\x49FRAME");
        this.o1g.src="\x6aavascr\x69\x70t:f\x61\154s\x65;";
        this.o1g.frameBorder=0;
        this.o1g.id=this.Container.parentNode.id+"Over\x6c\x61y";
        this.o1g.style.position="\x61bsolu\x74\x65";
        this.o1g.style.visibility="hidden";
        this.o1g.style.border="1px solid \x72\x65d";
        this.o1g.style.filter="\x70rogid\x3a\x44XIma\x67\x65Tra\x6e\163f\x6f\x72m.M\x69\143r\x6fsoft\x2eAlpha\x28\163t\x79\154e\x3d0,opa\x63ity=0\x29";
        this.o1g.O1g= false;
        this.Container.parentNode.insertBefore(this.o1g,this.Container);
    }
    var o1f=this.O1f(this.Container);
    this.o1g.style.cssText=this.Container.style.cssText;
    this.o1g.style.left=o1f.X+"px";
    this.o1g.style.top=o1f.Y+"px";
    this.o1g.style.width=o1f.Width+"\x70x";
    this.o1g.style.height=o1f.Height+"\x70x";
    this.o1g.style.visibility="visible";
};
RadInputHint.prototype.l1g= function (node)
{
    var x=0;
    var i1g=node;
    while (i1g.parentNode && i1g.parentNode.tagName!="BODY")
    {
        if (typeof(i1g.parentNode.scrollLeft)=="\x6eumbe\x72")
        {
            x+=i1g.parentNode.scrollLeft;
        }
        i1g=i1g.parentNode;
    }
    return x;
};
RadInputHint.prototype.I1g= function (node)
{
    var y=0;
    var i1g=node;
    while (i1g.parentNode && i1g.parentNode.tagName!="\x42ODY")
    {
        if (typeof(i1g.parentNode.scrollTop)=="\156um\x62\x65r")
        {
            y+=i1g.parentNode.scrollTop;
        }
        i1g=i1g.parentNode;
    }
    return y;
};
RadInputHint.prototype.l1f= function ()
{
    var width=0;
    if (typeof(document.body.scrollLeft)=="\x6eumber")
    {
        width+=document.body.scrollLeft;
    }
    if (typeof(document.documentElement.scrollLeft)=="number")
    {
        width+=document.documentElement.scrollLeft;
    }
    return width;
};
RadInputHint.prototype.o1h= function ()
{
    var height=0;
    if (typeof(document.body.scrollTop)=="numb\x65\x72")
    {
        height+=document.body.scrollTop;
    }
    if (typeof(document.documentElement.scrollTop)=="num\x62\x65r")
    {
        height+=document.documentElement.scrollTop;
    }
    return height;
};
RadInputHint.prototype.O1h= function (node)
{
    var x=0;
    var i1g=node;
    while (i1g.offsetParent && i1g.offsetParent.tagName!="\x42ODY")
    {
        if (typeof(i1g.offsetParent.scrollLeft)=="nu\x6d\x62er")
        {
            x+=i1g.offsetParent.scrollLeft;
        }
        i1g=i1g.offsetParent;
    }
    return x;
};
RadInputHint.prototype.l1h= function (node)
{
    var y=0;
    var i1g=node;
    while (i1g.offsetParent && i1g.offsetParent.tagName!="\x42ODY")
    {
        if (typeof(i1g.offsetParent.scrollTop)=="nu\x6d\x62er")
        {
            y+=i1g.offsetParent.scrollTop;
        }
        i1g=i1g.offsetParent;
    }
    return y;
};
RadInputHint.prototype.Hide= function ()
{
    if (this.Container)
    {
        this.I1f();
        this.Container.parentNode.removeChild(this.Container);
        this.Container=null;
    }
};
RadInputHint.prototype.O1f= function (i1h)
{
    var width=i1h.offsetWidth;
    var height=i1h.offsetHeight;
    var x=0;
    var y=0;
    var node=i1h;
    while (node.offsetParent)
    {
        x+=node.offsetLeft;
        y+=node.offsetTop;
        node=node.offsetParent;
    }
    var offsetX=0;
    var offsetY=0;
    if (window.opera)
    {
        x-=this.O1h(i1h);
        y-=this.l1h(i1h);
    }
    else
    {
        x-=this.l1g(i1h);
        y-=this.I1g(i1h);
    }
    return {X:x,Y:y,Width:width,Height:height } ;
};;
function RadLiteralMaskPart(O)
{
    this.O=O;
};
RadLiteralMaskPart.prototype=new RadMaskPart();
RadLiteralMaskPart.prototype.o= function ()
{
    return this.O;
};
RadLiteralMaskPart.prototype.I= function ()
{
    if (this.A.U)
    {
        return this.O.length-(this.O.split("\015\x0a").length-1);
    }
    return this.O.length;
};
RadLiteralMaskPart.prototype.GetValue= function ()
{
    return "";
};
RadLiteralMaskPart.prototype.Z= function ()
{
    if (this.z!=null)
    {
        return this.z.Z();
    }
};
RadLiteralMaskPart.prototype.SetValue= function (value,W)
{
    W-=this.W;
    return value==this.O.charAt(W) || !value;
};
RadLiteralMaskPart.prototype.w= function (value,W)
{
    W-=this.W;
    if (value==this.O.charAt(W))return true;
    if (!value)return true;
    if (this.z!=null)
    {
        return this.z.w(value,W+this.I());
    }
};;
function RadLowerMaskPart()
{
};
RadLowerMaskPart.prototype=new RadMaskPart();
RadLowerMaskPart.prototype.w= function (value,W)
{
    if (!RadMaskPart.Ip(value))
    {
        this.A.Im(this,this.GetValue(),value);
        return false;
    }
    return true;
};
RadLowerMaskPart.prototype.o= function ()
{
    if (this.value.toString()=="")
    {
        return this.PromptChar;
    }
    return this.value.toString();
};
RadLowerMaskPart.prototype.SetValue= function (value,W)
{
    if (value=="")
    {
        this.value="";
        return true;
    }
    if (RadMaskPart.Ip(value))
    {
        this.value=value.toLowerCase();
    }
    else
    {
        this.A.Im(this,this.GetValue(),value);
    }
    return true;
};;
if (typeof(window.RadInputNamespace)=="u\x6e\x64efined")
{
    window.RadInputNamespace=new Object();
};
if (typeof(window.RadControlsNamespace)=="\x75\x6edefi\x6e\x65d")
{
    window.RadControlsNamespace=new Object();
};
RadControlsNamespace.AppendStyleSheet= function (V,v,T)
{
    if (!T)
    {
        return;
    }
    if (!V)
    {
        document.write("\x3c"+"\x6cink"+"\x20rel=\047\x73tyl\x65\163he\x65t\047\x20type\x3d\x27tex\x74\057\x63ss\047\x20hr\x65\146=\x27"+T+"\047\x20/>");
    }
    else
    {
        var t=document.createElement("\x4cI\x4e\x4b");
        t.rel="\x73tyleshe\x65\x74";
        t.type="t\x65\x78t/css";
        t.href=T;
        document.getElementById(v+"\x53tyleSheetHol\x64\145r").appendChild(t);
    }
};
function RadMaskedTextBox()
{
    var v=arguments[0];
    var S=window[v];
    if (S!=null && typeof(S.Dispose)=="\x66unction")
    {
        S.Dispose();
    }
    if (arguments.length)
    {
        this.R(arguments[0],arguments[1]);
    }
};
RadMaskedTextBox.prototype.r= function (target)
{
    return (target.attachEvent && !window.opera && !window.netscape);
};
RadMaskedTextBox.prototype.R= function (Q,P)
{
    this.PromptChar="\x5f";
    this.DisplayPromptChar="\x5f";
    this.ReadOnly= false;
    this.DisplayFormatPosition=0;
    this.HideOnBlur= false;
    this.ResetCaretOnFocus= false;
    this.EmptyMessage="";
    this.AutoPostBack= false;
    this.AllowEmptyEnumerations= false;
    this.ShowHint= false;
    this.RoundNumericRanges= true;
    this.FocusOnStartup= false;
    this.N=[];
    this.n=[];
    this.M=[];
    this.value="";
    this.m= true;
    this.L=document.getElementById(Q+"_Value");
    this.l=document.getElementById(Q+"_TextBox");
    this.field=document.getElementById(Q);
    this.Enabled=this.field.disabled=="di\x73\x61bled"? true : false;
    this.field.K=this.field.value;
    this.ID=Q;
    this.k=null;
    this.length=0;
    this.J=0;
    this.H= false;
    this.h="";
    this.Hint=new RadInputHint(this,P);
    this.G=this.field.tagName.toLowerCase()=="\x74ex\x74\x61rea";
    this.F=navigator.userAgent.indexOf("Safari")>-1;
    this.U=navigator.userAgent.indexOf("Gec\x6b\x6f")>-1;
    this.D();
    if (this.r(window))
    {
        var d=this ;
this.C= function ()
{
    d.Dispose();
};
window.attachEvent("onunloa\x64",this.C);
}
if (P)
{
this.field.c="\x4fver_"+P;
this.field.B="\x46ocus_"+P;
this.field.o0=this.field.className?this.field.className: "De\x66\x61ult_"+P;
this.field.O0="\x45rror_"+P;
this.field.className=this.field.o0;
}
else
{
var l0=this.field.className;
this.field.c=l0;
this.field.B=l0;
this.field.o0=l0;
this.field.O0=l0;
}
this.field.i0= false;
this.I0();
};
RadMaskedTextBox.prototype.Dispose= function ()
{
    try
    {
        for (var o1 in this.field)
        {
            if (typeof(this.field[o1])=="\x66unction")
            {
                try
                {
                    this.field[o1]=null;
                }
                catch (e)
                {
                }
            }
        }
        if (this.r(window))
        {
            for (var o1 in this.O1)
            {
                this.field.detachEvent(o1,this.O1[o1]);
            }
            window.detachEvent("\x6fnunload",this.C);
            this.C=null;
        }
        this.L=null;
        this.l=null;
        this.field=null;
        this.Hint=null;
    }
    catch (e)
    {
    }
};
RadMaskedTextBox.prototype.I0= function ()
{
    var l1=this.field;
    if (l1.previousSibling && l1.previousSibling.tagName.toLowerCase()=="labe\x6c" && l1.style.position=="absol\x75\x74e")
    {
        l1.style.position="st\x61\x74ic";
        var parent=l1.parentNode;
        parent.style.position="absolu\x74\x65";
        parent.style.top=this.field.style.top;
        parent.style.left=this.field.style.left;
    }
};
RadMaskedTextBox.prototype.Initialize= function ()
{
    this.Visualise();
    if (this.FocusOnStartup)
    {
        this.Focus();
    }
    this.i1();
};
RadMaskedTextBox.prototype.Enable= function ()
{
    this.field.disabled="";
    this.Enabled= true;
};
RadMaskedTextBox.prototype.Disable= function ()
{
    this.field.disabled="disab\x6c\x65d";
    this.Enabled= false;
};
RadMaskedTextBox.prototype.i1= function ()
{
    this.I1=this.field.value;
};
RadMaskedTextBox.prototype.Focus= function ()
{
    this.field.focus();
    this.field.selectionStart=this.field.selectionEnd=0;
};
RadMaskedTextBox.prototype.o2= function (index)
{
    return this.n[index];
};
RadMaskedTextBox.prototype.O2= function (className)
{
    this.field.l2=className;
    if (this.field.disabled)
    {
        this.field.className=this.field.l2;
    }
};
RadMaskedTextBox.prototype.i2= function (className)
{
    this.field.B=className;
};
RadMaskedTextBox.prototype.I2= function (className)
{
    this.field.O0=className;
};
RadMaskedTextBox.prototype.o3= function (className)
{
    this.field.c=className;
};
RadMaskedTextBox.prototype.O3= function (N,l3)
{
    var i3;
    var I3=[];
    var length=0;
    for (var j=0; j<N.length; j++)
    {
        i3=N[j];
        i3.PromptChar=l3;
        i3.o4(this );
        i3.index=this.N.length;
        I3[I3.length]=i3;
        if (I3.length>1)
        {
            I3[I3.length-2].z=i3;
        }
        i3.z=null;
        var O4=i3.I();
        i3.W=length;
        length+=O4;
    }
    return I3;
};
RadMaskedTextBox.prototype.SetMask= function ()
{
    this.N=this.O3(arguments,this.PromptChar);
    for (var i=0; i<this.N.length; i++)
    {
        var O4=this.N[i].I();
        for (var j=this.length; j<this.length+O4; j++)
        {
            this.n[j]=this.N[i];
        }
        this.length+=O4;
    }
};
RadMaskedTextBox.prototype.SetDisplayMask= function ()
{
    this.l4=this.O3(arguments,this.DisplayPromptChar);
    for (var i=0; i<this.l4.length; i++)
    {
        var i4=this.l4[i];
        var O4=i4.I();
        if (i4.O)
        {
            continue;
        }
        for (var j=this.J; j<this.J+O4; j++)
        {
            this.M[j]=this.l4[i];
        }
        this.J+=O4;
    }
};
RadMaskedTextBox.prototype.SetValue= function (value)
{
    this.H= true;
    this.I4(value,0,this.length);
    this.H= false;
    this.Visualise();
};
RadMaskedTextBox.prototype.o5= function (e)
{
    var O5=this.l5(this.k.i5,e.i5);
    e.selectionStart=O5[0];
    e.selectionEnd=O5[0];
    this.k.selectionStart=O5[1];
    this.k.selectionEnd=O5[2];
};
RadMaskedTextBox.prototype.I5= function (e)
{
    if (this.ReadOnly)
    {
        this.Visualise();
        return false;
    }
    if (this.k==null)return;
    var i,j;
    if (this.F)
    {
    	this.o5(e);
    }
    if (this.k.i5.length>e.i5.length)
    {
        if (e.selectionStart==this.field.value.length)
        {	
            this.n[this.n.length-1].SetValue("",this.n.length-1);
        }
        if (this.k.selectionEnd>e.selectionStart)
        {
            i=this.k.selectionEnd;
            while (i-->e.selectionStart)
            {
                this.n[i].SetValue("",i);
            }
        }
        else
        {
            i=this.k.selectionEnd+1;
            while (i-->e.selectionStart)
            {
                this.n[i].SetValue("",i);
                e.selectionEnd++;
            }
        }
    }
    var o6=this.k.selectionStart;
    var O6=Math.min(e.selectionStart,this.length);
    var l6=e.i5.substr(o6,O6-o6);
    var i6=this.I4(l6,o6,O6);
    e.selectionEnd+=i6;
    this.I6(e);
};
RadMaskedTextBox.prototype.o7= function (n,O7,value,l7,i7)
{
    var I7;
    var i=0;
    var j=l7;
    var o8=0;
    value=value.toString();
    while (i<i7-l7 && j<O7)
    {
        I7=value.charAt(i);
        if (I7==this.PromptChar)
        {
            I7="";
        }
        if (n[j].SetValue(I7,j))
        {
            i++;
        }
        else
        {
            o8++;
        }
        j++;
    }
    return o8;
};
RadMaskedTextBox.prototype.O8= function (value,l7,i7)
{
    this.o7(this.M,this.J,value,l7,i7);
};
RadMaskedTextBox.prototype.I4= function (value,l7,i7)
{
    var i6=this.o7(this.n,this.length,value,l7,i7);
    this.Visualise();
    return i6;
};
RadMaskedTextBox.prototype.l8= function (position)
{
    if (!this.field.i0)return;
    this.i8();
    if (document.all && !window.opera)
    {
        this.field.select();
        I8=document.selection.createRange();
        var o9=this.field.value.substr(0,position).split("\x0d\x0a").length-1;
        I8.move("\x63ha\x72\x61cter",position-o9);
        I8.select();
    }
    else
    {
        this.field.selectionStart=position;
        this.field.selectionEnd=position;
    }
};
RadMaskedTextBox.prototype.I6= function (O9)
{
    this.l8(O9.selectionEnd);
};
RadMaskedTextBox.prototype.GetValue= function ()
{
    var l9=[];
    for (var i=0; i<this.N.length; i++)
    {
        l9[i]=this.N[i].GetValue();
    }
    return l9.join("");
};
RadMaskedTextBox.prototype.GetValueWithLiterals= function ()
{
    var l9=[];
    for (var i=0; i<this.N.length; i++)
    {
        l9[i]=this.N[i].O || this.N[i].GetValue();
    }
    return l9.join("");
};
RadMaskedTextBox.prototype.i9= function (N)
{
    var l9=[];
    for (var i=0; i<N.length; i++)
    {
        l9[i]=N[i].o();
    }
    return l9.join("");
};
RadMaskedTextBox.prototype.I9= function ()
{
    return this.i9(this.N);
};
RadMaskedTextBox.prototype.GetPrompt= function ()
{
    var oa=new RegExp("\056","\x67");
    var l9=[];
    for (var i=0; i<this.N.length; i++)
    {
        l9[i]=this.N[i].O || this.N[i].o().replace(oa,this.PromptChar);
    }
    return l9.join("");
};
RadMaskedTextBox.prototype.Visualise= function ()
{
    var i5=this.I9();
    var value=this.GetValue();
    if(this.field.value == ""){
    	value = "";
    	this.h = "";
    }
    this.H= true;
    var K=this.h;
    this.Oa(i5);
    this.value=value;
    this.la();
    this.ia();
    this.H= false;
    this.h=this.field.value;
    if (K!=this.field.value)
    {
        this.Ia(null,K,this.field.value);
    }
};
RadMaskedTextBox.prototype.Oa= function (ob)
{
    if (this.m)
    {
        if (this.HideOnBlur && this.Ob())
        {
            this.field.value=this.lb();
        }
        else if (this.l4 && this.l4.length)
        {
            this.field.value=this.ib();
        }
        else
        {
            this.field.value=ob;
        }
    }
    else
    {
        this.field.value=ob;
    }
};
RadMaskedTextBox.prototype.la= function ()
{
    this.L.value=this.I9();
};
RadMaskedTextBox.prototype.ia= function ()
{
    if (this.Ob())
    {
        this.l.value="";
    }
    else
    {
        this.l.value=this.GetValueWithLiterals();
    }
};
RadMaskedTextBox.prototype.Ib= function ()
{
    this.SetValue(this.I1);
    this.Visualise();
};
RadMaskedTextBox.prototype.oc= function ()
{
    return this.field.value!=this.field.K;
};
RadMaskedTextBox.prototype.D= function ()
{
    var Oc=this ;
    var field=this.field;
    field.Oc=Oc;
field.lc= function ()
{
    if (document.createEventObject)
    {
        if (event)
        {
            var ic=document.createEventObject(event);
        }
        else
        {
            var ic=document.createEventObject();
        }
        ic.propertyName="\x76\x61\x6cue";
        this.fireEvent("\x6f\x6eprope\x72\x74ych\x61\x6eg\x65",ic);
    }
};
if (this.r(window))
{
field.form.attachEvent("onreset", function ()
{
    Oc.Ib();
}
);
}
else
{
field.form.addEventListener("re\x73\x65t", function ()
{
    Oc.Ib();
}
, false);
}
var Ic= function ()
{
    field.lc();
    return Oc.OnKeyDown(event);
};
var od= function ()
{
    event.cancelBubble= true;
    return Oc.Od(event);
};
var onMouseDown= function (e)
{
    field.lc();
    field.Oc.ld(e);
};
var onMouseOut= function ()
{
    if (!field.i0)
    {
        field.className=field.o0;
    }
};
var onMouseOver= function ()
{
    field.lc();
    if (!field.i0)
    {
        field.className=field.c;
    }
};
var onFocus= function (e)
{
    if(field.value == ""){
		field.value = "0";
    }
	field.i0= true;
    field.className=field.B;
    field.Oc.oe();
    field.lc();
    field.Oc.ld(e);
};
var onMouseUp= function (e)
{
    field.lc();
    field.Oc.Oe(e);
    field.Oc.ld(e);
    field.Oc.DisplayHint();
};
var le= function ()
{
    if (Oc.ReadOnly)
    {
        return false;
    }
    if (field.selectionStart==field.value.length)
    {
        return false;
    }
setTimeout( function ()
{
    field.lc();
}
,1);
};
var onKeyUp= function ()
{
    field.lc();
    field.Oc.DisplayHint();
};
var onBlur= function ()
{
    field.i0= false;
    field.className=field.o0;
    field.Oc.ie();
    var Ie=field.Oc;
window.setTimeout( function ()
{
    if (Ie.Hint)
    {
        Ie.Hint.Hide();
    }
}
,200);
if (field.Oc.AutoPostBack && Oc.oc())
{
    eval(Oc.AutoPostBackCode);
}
field.K=field.value;
};
var d=this ;
d.O1=
{
};
var of= function (name,Oc)
{
    if (d.r(field))
    {
        d.O1["on"+name]=Oc;
        field.attachEvent("\x6f\x6e"+name,Oc);
    }
    else if (field.addEventListener)
    {
        field.addEventListener(name,Oc, false);
    }
};
of("\x6beyup",onKeyUp);
of("focus",onFocus);
of("mousedow\x6e",onMouseDown);
of("mou\x73\x65over",onMouseOver);
of("\155\x6f\x75seout",onMouseOut);
of("mouseup",onMouseUp);
of("\x62lur",onBlur);
if (d.r(field))
{
    field.attachEvent("\x6fnkeydo\x77\x6e",Ic);
    field.attachEvent("on\x6b\x65ypress",od);
    field.attachEvent("onpaste",le);
field.attachEvent("o\x6e\x70roperty\x63\x68ang\x65", function ()
{
    Oc.Of();
}
);
field.attachEvent("onmo\x75\x73ewhee\x6c", function ()
{
    return field.Oc.If(event);
}
);
}
else
{
var og= function (e)
{
    if (!Oc.OnKeyDown(e))
    {
        e.preventDefault();
    }
};
var Og= function (e)
{
    if (!Oc.Od(e))
    {
        e.preventDefault();
    }
};
var lg= function (e)
{
    Oc.Oe(e);
};

}
if (window.opera)
{
var ig= function ()
{
    return Oc.Oe(
    {
    }
    );
};
setInterval(ig,10);
}
};
RadMaskedTextBox.prototype.lb= function ()
{
    return this.EmptyMessage;
};
RadMaskedTextBox.prototype.ib= function ()
{
    var value=this.value;
    while (value.length<this.J)
    {
        if (this.DisplayFormatPosition)
        {
            value=this.PromptChar+value;
        }
        else
        {
            value+=this.PromptChar;
        }
    }
    this.O8(value,0,this.J);
    return this.i9(this.l4);
};
RadMaskedTextBox.prototype.Ob= function ()
{
    return this.value=="";
};
RadMaskedTextBox.prototype.ie= function ()
{
    this.m= true;
    this.Visualise();
};
RadMaskedTextBox.prototype.oe= function ()
{
    this.m= false;
    if ((this.HideOnBlur && this.Ob()) || this.l4)
    {
        this.Visualise();
        this.field.select();
    }
    if (this.ResetCaretOnFocus)
    {
        this.Ig();
    }
};
RadMaskedTextBox.prototype.Ig= function ()
{
    this.l8(0);
};
RadMaskedTextBox.prototype.Of= function ()
{	
    if (this.H)return;
    if (event.propertyName=="valu\x65")
    {
        var e=event;
        var Oc=this ;
var oh= function ()
{
    Oc.Oe(e);
};
this.i8();
if (this.field.selectionStart>0 || this.field.selectionEnd>0)
{
    oh();
}
else
{
    setTimeout(oh,1);
}
}
};
RadMaskedTextBox.prototype.If= function (e)
{
    if (this.ReadOnly)
    {
        return false;
    }
    this.i8();
    var Oh=this.n[this.field.selectionStart];
    if (Oh==null)
    {
        return true;
    }
    return Oh.lh(e);
};
RadMaskedTextBox.prototype.OnKeyDown= function (e)
{
    if (!e)e=window.event;
    var keyCode=e.which?e.which:e.keyCode;
    if (this.ih(e) && keyCode!=46)
    {
        return true;
    }
    var Oh=this.n[this.field.selectionStart];
    if (this.ReadOnly && (keyCode==46 || keyCode==8 || keyCode==38 || keyCode==40))
    {
        return false;
    }
    if (keyCode==13)
    {
        return true;
    }
    if (Oh==null && keyCode!=8)
    {
        return true;
    }
    if (Oh!=null)
    {
        if (Oh.Ih(e))
        {
            return false;
        }
    }
    var selectionEnd=this.field.selectionEnd;
    var oi= false;
    if (keyCode==46 && this.ih(e))
    {
    	this.L.value = "";
    	this.l.value = "";
    	this.field.value = "";
    	
    	
	    
    	return true;
    }
    if ((keyCode==46) && selectionEnd<this.field.value.length && !window.opera)
    {
        Oh.SetValue("",this.field.selectionStart);
        selectionEnd++;
        oi= true;
    }
    else if (keyCode==8 && selectionEnd && !window.opera)
    {
        this.n[this.field.selectionStart-1].SetValue("",this.field.selectionStart-1);
        selectionEnd--;
        oi= true;
    }
    if (oi)
    {
        return this.Oi(e,selectionEnd);
    }
    this.ii(e);
    return true;
};
RadMaskedTextBox.prototype.Od= function (e)
{
    if (this.ReadOnly)
    {
        return false;
    }
    if (!e)e=window.event;
    if (this.ih(e))
    {
        e.cancelBubble= false;
        return true;
    }
    var Oh=this.n[this.field.selectionStart];
    if (Oh==null)
    {
        e.cancelBubble= false;
        return true;
    }
    if (this.U || window.opera)
    {
        if (e.which==8)
        {
            return false;
        }
        if (!e.which)
        {
            this.ii(e);
            return true;
        }
    }
    var selectionEnd=this.field.selectionEnd;
    var keyCode=e.which?e.which:e.keyCode;
    if (keyCode==13)
    {
        e.cancelBubble= false;
        return true;
    }
    var O=String.fromCharCode(keyCode);
    if (Oh.w(O))
    {
        while (selectionEnd<this.field.value.length)
        {
            if (this.n[selectionEnd].SetValue(O,selectionEnd))
            {
                selectionEnd++;
                break;
            }
            selectionEnd++;
        }
    }
    return this.Oi(e,selectionEnd);
};
RadMaskedTextBox.prototype.Oi= function (e,selectionEnd)
{
    this.Visualise();
    var O9=new MaskedEventWrap(this.field,e);
    O9.selectionEnd=selectionEnd;
    this.I6(O9);
    return false;
};
RadMaskedTextBox.prototype.ih= function (e)
{
    this.i8();
    if (this.field.selectionStart!=this.field.selectionEnd)
    {
        this.ii(e);
        return true;
    }
    if (e.ctrlKey || e.altKey || this.F)
    {
        this.ii(e);
        return true;
    }
    return false;
};
RadMaskedTextBox.prototype.Oe= function (e)
{
    if (this.H)
    {
        return true;
    }
    if (!e)e=window.event;
    this.i8();
    var Ii=new MaskedEventWrap(e,this.field);
    if (Ii.i5!=this.h)
    {
        this.I5(Ii);
    }
    return true;
};
RadMaskedTextBox.prototype.ld= function (e)
{
    if (this.H)
    {
        return true;
    }
    if (!e)e=window.event;
    this.ii(e);
    return true;
};
RadMaskedTextBox.prototype.DisplayHint= function ()
{
    if (!this.ShowHint)return;
    this.i8();
    var Oh=this.n[this.field.selectionStart];
    this.Hint.Hide();
    var oj=null;
    if (document.selection)
    {
        var Oj=document.selection.createRange();
        if (Oj.getBoundingClientRect)
        {
            oj=Oj.getBoundingClientRect();
        }
    }
    this.Hint.Show(Oh,oj);
};
RadMaskedTextBox.prototype.ii= function (e)
{
    this.i8();
    this.k=new MaskedEventWrap(e,this.field);
};
RadMaskedTextBox.prototype.i8= function ()
{
    if (document.selection && !window.opera)
    {
        var lj=document.selection.createRange();
        if (lj.parentElement()!=this.field)return;
        var s=lj.duplicate();
        if (this.G)
        {
            s.moveToElementText(this.field);
        }
        else
        {
            s.move("\x63\x68\x61racte\x72",-this.field.value.length);
        }
        s.setEndPoint("EndToStart",lj);
        this.field.selectionStart=s.text.length;
        this.field.selectionEnd=this.field.selectionStart+lj.text.length;
        if (this.G)
        {
        }
    }
};
RadMaskedTextBox.prototype.l5= function (ij,Ij)
{
    var i;
    var ok,Ok,lk;
    i=0;
    while (ij.charAt(i)==Ij.charAt(i) && i<ij.length)
    {
        i++;
    }
    Ok=i;
    ij=ij.substr(Ok).split("").reverse().join("");
    Ij=Ij.substr(Ok).split("").reverse().join("");
    i=0;
    while (ij.charAt(i)==Ij.charAt(i) && i<ij.length)
    {
        i++;
    }
    ok=Ok+Ij.length-i;
    lk=ij.length-i+Ok;
    return [ok,Ok,lk];
};
function RadInputEventArgs()
{
}
RadMaskedTextBox.prototype.ik= function (Ik,i3,K,ll)
{
    if (typeof(Ik)=="function")
    {
        Ik(this,
        {
            CurrentPart:i3,OldValue:K,NewValue:ll
        }
        );
    }
    else if (typeof(window[Ik])=="\x66u\x6e\x63tion")
    {
        window[Ik](this,
        {
            CurrentPart:i3,OldValue:K,NewValue:ll
        }
        );
    }
    else if (Ik)
    {
        throw new Error("No suc\x68\x20func\x74\x69on:\x20"+Ik);
    }
};
RadMaskedTextBox.prototype.il= function (i3,K,ll)
{
    this.ik(this.OnClientEnumerationChanged,i3,K,ll);
};
RadMaskedTextBox.prototype.Il= function (i3,K,ll)
{
    this.ik(this.OnClientMoveUp,i3,K,ll);
};
RadMaskedTextBox.prototype.om= function (i3,K,ll)
{
    this.ik(this.OnClientMoveDown,i3,K,ll);
};
RadMaskedTextBox.prototype.Ia= function (i3,K,ll)
{
    this.ik(this.OnClientValueChanged,i3,K,ll);
};
RadMaskedTextBox.prototype.Om= function (i3)
{
    this.ik(this.OnClientShowHint,i3,this.field.value,this.field.value);
};
RadMaskedTextBox.prototype.Im= function (i3,K,ll)
{
    this.ik(this.OnClientError,i3,K,ll);
    var On=this.field.B;
    this.field.className=this.field.O0;
    var A=this ;
var restore= function ()
{
    if (A.field.className==A.field.O0)A.field.className=On;
};
setTimeout(restore,100);
};
function MaskedEventWrap(e,field)
{
    this.event=e;
    this.selectionStart=field.selectionStart;
    this.selectionEnd=field.selectionEnd;
    this.i5=field.value;
};
MaskedEventWrap.prototype.In= function ()
{
    return this.event.keyCode==38;
};
MaskedEventWrap.prototype.oo= function ()
{
    return this.event.keyCode==40;
};
function rdmskd()
{
    return new RadDigitMaskPart();
};
function rdmskl(Oo)
{
    return new RadLiteralMaskPart(Oo);
};
function rdmske(Io)
{
    return new RadEnumerationMaskPart(Io);
};
function rdmskr(op,Op,lp,ip)
{
    return new RadNumericRangeMaskPart(op,Op,lp,ip);
};
function rdmsku()
{
    return new RadUpperMaskPart();
};
function rdmsklw()
{
    return new RadLowerMaskPart();
};
function rdmskp()
{
    return new RadPasswordMaskPart();
};
function rdmskf()
{
    return new RadFreeMaskPart();
};;
function RadMaskPart()
{
    this.value="";
    this.index=-1;
    this.type=-1;
    this.PromptChar="_";
};
RadMaskPart.prototype.Ih= function (ic)
{
    return false;
};
RadMaskPart.prototype.lh= function (I1h)
{
    return true;
};
RadMaskPart.prototype.o4= function (A)
{
    this.A=A;
};
RadMaskPart.prototype.GetValue= function ()
{
    return this.value.toString();
};
RadMaskPart.prototype.o= function ()
{
    return "";
};
RadMaskPart.prototype.SetValue= function (value,W)
{
    return true;
};
RadMaskPart.prototype.w= function (value,W)
{
    return true;
};
RadMaskPart.prototype.Z= function ()
{
    return false;
};
RadMaskPart.prototype.ShowHint= function (Os)
{
    return false;
};
RadMaskPart.prototype.I= function ()
{
    return 1;
};
RadMaskPart.Ip= function (o1i)
{
	return o1i.match(/[^\x5d\x5b\x09\x0a\x0d\x0c\x0b\x21-\x40\x7c\x5e\x5f\x60\x7b-\xbf]{1}/)!=null; 
};;
function RadNumericRangeMaskPart(op,Op,lp,ip)
{
    this.ix=Op;
    this.Ix=op;
    this.length=Math.max(this.Ix.toString().length,this.ix.toString().length);
    this.lp=lp;
    this.ip=ip;
    this.oy=this.Ix<0 || this.ix<0;
    this.value=op;
    this.iq=0;
};
RadNumericRangeMaskPart.prototype=new RadMaskPart();
RadNumericRangeMaskPart.prototype.o4= function (A)
{
    this.A=A;
    this.o();
};
RadNumericRangeMaskPart.prototype.Z= function ()
{
    return true;
};
RadNumericRangeMaskPart.prototype.w= function (value,W)
{
    if ((value=="-" || value=="+") && this.Ix<0)
    {
        return true;
    }
    if (isNaN(parseInt(value)))
    {
        this.A.Im(this,this.GetValue(),value);
        return false;
    }
    return true;
};
RadNumericRangeMaskPart.prototype.Oy= function (value,W)
{
    return this.ly.substr(0,W)+value.toString()+this.ly.substr(W+1,this.ly.length);
};
RadNumericRangeMaskPart.prototype.iy= function (value)
{
    var Iy=this.lp?"": "0";
    while (value.indexOf(this.PromptChar)>-1)
    {
        value=value.replace(this.PromptChar,Iy);
    }
    return value;
};
RadNumericRangeMaskPart.prototype.SetValue= function (value,W)
{
    if (value=="")
    {
        value=0;
    }
    if (isNaN(parseInt(value)) && value!="\x2b" && value!="-")
    {
        return true;
    }
    W-=this.W;
    var oz=this.Oy(value,W);
    oz=this.iy(oz);
    if (oz.indexOf("\x2d")!=-1 && oz.indexOf("-")>0)
    {
        oz=oz.replace("\x2d","0");
    }
    if (isNaN(parseInt(oz)))oz=0;
    if (this.A.RoundNumericRanges)
    {
        oz=Math.min(this.ix,oz);
        oz=Math.max(this.Ix,oz);
        this.Oz(oz);
    }
    else
    {
        if (oz<=this.ix && oz>=this.Ix)
        {
            this.Oz(oz);
            this.o();
        }
        else
        {
            return false;
        }
    }
    this.o();
    return true;
};
RadNumericRangeMaskPart.prototype.Oz= function (value)
{
    var K=this.value;
    this.value=value;
    this.A.il(this,K,value);
    if (K>value)
    {
        this.A.om(this,K,value);
    }
    else
    {
        this.A.Il(this,K,value);
    }
    this.iq=0;
};
RadNumericRangeMaskPart.prototype.o= function ()
{
    var lz="";
    var iz=Math.abs(this.value).toString();
    if (this.lp)
    {
        if (this.value<0)
        {
            lz+=this.PromptChar;
        }
        lz+=iz;
        while (lz.length<this.length)
        {
            lz+=this.A.PromptChar;
        }
    }
    else
    {
        var Iz=this.ip?"\060": this.A.PromptChar;
        if (this.value<0)
        {
            iz="-"+iz;
        }
        while (lz.length<this.length-iz.length)
        {
            lz+=Iz;
        }
        lz+=iz;
    }
    this.ly=lz;
    return lz;
};
RadNumericRangeMaskPart.prototype.I= function ()
{
    return this.length;
};
RadNumericRangeMaskPart.prototype.Ih= function (e)
{
    return;
    this.A.i8();
    var Ov=new MaskedEventWrap(e,this.A.field);
    if (Ov.oo())
    {
        this.o10();
        this.A.I6(Ov);
        return true;
    }
    else if (Ov.In())
    {
        this.O10();
        this.A.I6(Ov);
        return true;
    }
};
RadNumericRangeMaskPart.prototype.O10= function ()
{
    var l10=this.value;
    l10++;
    if (l10>this.ix)
    {
        l10=this.Ix;
        this.iq=1;
    }
    this.Oz(l10);
    this.A.Visualise();
};
RadNumericRangeMaskPart.prototype.o10= function ()
{
    var l10=this.value;
    l10--;
    if (l10<this.Ix)
    {
        l10=this.ix;
        this.iq=-1;
    }
    this.Oz(l10);
    this.A.Visualise();
};
RadNumericRangeMaskPart.prototype.lh= function (e)
{
    var l10=this.value;
    l10=parseInt(l10)+parseInt(e.wheelDelta/120);
    var Ov=new MaskedEventWrap(e,this.A.field);
    if (l10<this.Ix)
    {
        l10=this.ix-(this.Ix-l10-1);
        this.iq=-1;
    }
    if (l10>this.ix)
    {
        l10=this.Ix+(l10-this.ix-1);
        this.iq=1;
    }
    this.Oz(l10);
    this.A.Visualise();
    this.A.I6(Ov);
    return false;
};;
function RadPasswordMaskPart()
{
};
RadPasswordMaskPart.prototype=new RadMaskPart();
RadPasswordMaskPart.prototype.Z= function ()
{
    return true;
};
RadPasswordMaskPart.prototype.o= function ()
{
    if (this.value.toString()=="")
    {
        return this.PromptChar;
    }
    return "\x2a";
};
RadPasswordMaskPart.prototype.SetValue= function (value,W)
{
    this.value=value;
    return true;
};;
function RadUpperMaskPart()
{
};
RadUpperMaskPart.prototype=new RadMaskPart();
RadUpperMaskPart.prototype.w= function (value,W)
{
    if (!RadMaskPart.Ip(value))
    {
        this.A.Im(this,this.GetValue(),value);
        return false;
    }
    return true;
};
RadUpperMaskPart.prototype.o= function ()
{
    if (this.value.toString()=="")
    {
        return this.PromptChar;
    }
    return this.value.toString();
};
RadUpperMaskPart.prototype.SetValue= function (value,W)
{
    if (value=="")
    {
        this.value="";
        return true;
    }
    if (RadMaskPart.Ip(value))
    {
        this.value=value.toUpperCase();
    }
    else
    {
        this.A.Im(this,this.GetValue(),value);
    }
    return true;
};;
