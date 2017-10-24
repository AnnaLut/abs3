

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/S5_PROC.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  procedure S5_PROC ***

  CREATE OR REPLACE PROCEDURE BARS.S5_PROC 
( MODE_ int,
  nls_3739 varchar2,
  nls_9910 varchar2,
  mfo_     varchar2) is

 TT_  oper.TT%type := '013'; dk_  int; s_ number; ref_ number; nTmp_ int;
 nms_ accounts.NMS%type    ; nls_ accounts.NMS%type; nlsG_ varchar2(15);

begin
 tuda;
 for k in (select to_char(nls) NLS, i_va KV, ish, ish_v, rowid RI
           from s5_saldo
           where ish<>0
--             and substr(nls,1,1) in ('1','2','3','4','5','6','7','9')
           and substr(nls,1,1) in ('1','2','3','4','5','6','7')
--and substr(to_char(nls),1,2) >='96'
             and to_char(nls) not like '3900%'
             and to_char(nls)  not like '9910%'
           )
 loop
   S_:=0;
   if    k.kv = 980 and k.ish   < 0 then dk_:= 0; s_:= - k.ish  ;
   elsIf k.kv = 980 and k.ish   > 0 then dk_:= 1; s_:=   k.ish  ;
   elsIf k.kv <>980 and k.ish_v < 0 then dk_:= 0; s_:= - k.ish_V;
   elsIf k.kv <>980 and k.ish_v > 0 then dk_:= 1; s_:=   k.ish_V;
   end if;

   If k.nls like '9%' then nlsg_:= nls_9910 ;
   else                    nlsg_:= nls_3739 ;
   end if;

   If s_>0 then
   logger.info ('STA - 1 k.nls='|| k.nls || ' k.KV=' || k.KV);
   
      begin
        select a.nls, substr(a.nms,1,38) into NLS_, nms_
        from s6_saldo s, accounts a
        where s.i_va=k.KV and s.nls_alt=MFO_||'\'||k.nls and a.kv  =k.KV
          and a.nls like substr(s.nls,1,4)||'_'|| substr(s.nls,5,9)
          and a.dazs is  null;

        select 1 into nTmp_ from accounts where  nls=nlsg_ and kv=k.kv;

      EXCEPTION WHEN NO_DATA_FOUND THEN goto recnext;
                WHEN too_many_rows THEN goto recnext;
      end;

      GL.REF (REF_);
      GL.IN_DOC3( REF_,tt_, 6, REF_, SYSDATE,    GL.BDATE, dk_,
          k.kv, S_,k.kv, S_, 39,GL.BDATE,GL.BDATE,
          'Котл.рах.', NLSG_, gl.AMFO,  nms_, NLS_, gl.AMFO,
          'Розгорнення рах. '||MFO_||'\'||k.NLS,
          NULL,null,null,null, null,0,null,null);
      GL.PAYV(0,REF_,GL.BDATE,TT_,dk_,k.kv,NLSg_,S_,k.kv,NLS_,S_);
      update s5_saldo set ish=0, ish_V=0, nls_bars= NLS_ where rowid=k.RI;
      gl.pay(2, REF_, gl.bdate);

   end if;

   <<recnext>> null;
   end loop;

end s5_proc; 
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/S5_PROC.sql =========*** End *** =
PROMPT ===================================================================================== 
