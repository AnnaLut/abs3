

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/NLK_AUTO.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure NLK_AUTO ***

  CREATE OR REPLACE PROCEDURE BARS.NLK_AUTO 
(p_TIP  accounts.tip%type,
 p_NBS  accounts.nbs%type,
 p_ob22 accounts.ob22%type) is

ref_    oper.REF%type     ;
tt_     oper.TT%type      := '024';
vob_    oper.VOB%type     := 6;
l_2620  accounts.NLS%type ;
l_isp   accounts.isp%type ;

/*
   15.03.2011 Авто-разбор:NL9/2909/56 -> К.2620 по SWIFT
              Исправлено ош по подбору счета 2620
*/

---------------------

FUNCTION NLS_2620 (p_KV  accounts.KV%type ,
                   p_RNK accounts.RNK%type,
                   p_F59 operW.value%type )
                  RETURN accounts.NLS%type  IS

  -- вычленение из свифтовки реального счета для зачисления
  l_F59  accounts.NLS%type ;
  l_2620 accounts.NLS%type := null;
  l_Tmp  accounts.NLS%type := ''  ;

  S1_ char(1);  i_  int := 1;
begin
  If p_F59 is null OR substr(p_F59,1,1) <> '/' then Return l_2620; end if;
  -----------------------------------------------------------------
  l_f59 := substr(p_F59,2 ,14);

  LOOP  EXIT WHEN i_ > 14 ;
    S1_ := substr(l_f59,i_,1);
    If S1_ in ('1','2','3','4','5','6','7','8','9','0') then l_Tmp:=l_Tmp||S1_;
           i_ := i_ + 1;
    else   i_ := 15 ;
    end if;
  end loop;
  ---------

  If length(l_Tmp) > 0 then

     begin
       select a.nls   into l_2620  from accounts a
       where a.kv=p_kv and a.rnk=p_rnk and a.dazs is null and a.nbs='2620' and l_Tmp=a.nls;
     EXCEPTION WHEN NO_DATA_FOUND THEN

       begin
          select a.nls   into l_2620 from accounts a
          where a.kv=p_kv and a.rnk=p_rnk and a.dazs is null and a.nbs='2620'
            and l_Tmp = a.nlsalt  and rownum=1;
       EXCEPTION WHEN NO_DATA_FOUND THEN null;
       end;

     end ;

  end if;

  return l_2620;

end NLS_2620;

-------------------------
begin
 If p_tip not like 'NL_' then RETURN; end if;
 --------------------------------------------
 l_isp := nvl(gl.auid,20094);
 If l_isp = 1 then l_isp := 20094; end if;
 -----------------------------------------

 for k in (select distinct
                  a.nls NLSA, a.kv, b.rnk, substr(a.nms,1,38) nmsA,o.nazn,
                  a.acc, n.ref1, b.nls NLSB, o.nd, substr(b.nms,1,38) nmsB,o.S,
                  w.value F59
           from nlk_ref n, oper o, operw w, accounts a, customer c, accounts b
           where a.nbs=p_NBS  and a.ob22=p_OB22 and a.tip = p_TIP
             and n.acc=a.acc
             and b.rnk= c.rnk and b.nbs='2620' and b.kv=a.kv
             and w.ref=o.ref  and w.tag = '59'
             and c.custtype=3 and c.nmkv is not null
             and w.value like '%'|| upper(c.nmkv) ||'%'
             and o.ref =n.ref1 and n.ref2 is null
              )
 loop

    begin
       select ref2 into ref_ from nlk_ref where acc=k.acc and ref1=k.ref1 and ref2 is null
       FOR UPDATE OF REF2 NOWAIT;
    exception  when others then  GOTO RecNext;
    end;

    l_2620 := NLS_2620 (k.KV,k.rnk,k.F59);

    --дополнительная проверка на счет (если он есть в свифтовке )
    if l_2620  = k.nlsb then
       gl.ref (REF_);
       gl.in_doc3(REF_, TT_, VOB_, k.nd,    SYSDATE ,gl.BDATE, 1, k.kv , k.S,
                  k.kv, k.S, null, gl.BDATE,gl.bdate,k.nmsa, k.nlsa, gl.aMfo,
                                                     k.nmsb, k.nlsb, gl.aMfo,
                  k.nazn,null,null,null,null,null, 1,null, l_isp );
       gl.payv( 0,REF_, gl.bDATE, TT_, 1, k.kv, k.nlsa, k.s, k.kv, k.nlsb,k.S );
       update nlk_ref set ref2 =REF_ where acc =k.acc and ref1=k.ref1;
    end if;

  <<RecNext>> null ;
  ------------------

 end loop;

end NLK_AUTO ;
/
show err;

PROMPT *** Create  grants  NLK_AUTO ***
grant EXECUTE                                                                on NLK_AUTO        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on NLK_AUTO        to PYOD001;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/NLK_AUTO.sql =========*** End *** 
PROMPT ===================================================================================== 
