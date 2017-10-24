

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_FIN_REZ_CCK.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_FIN_REZ_CCK ***

  CREATE OR REPLACE PROCEDURE BARS.P_FIN_REZ_CCK 
(p_mode int,    -- =2 ЮЛ, = 3 ФЛ, =1 Банки
 p_kor  int,      -- =10 - кол-во дней корр.пров.
 DAT1_ date,      -- дата "С"
 DAT2_ date      -- дата "По"
 ) Is

 -- Фiнансовi результати по КП
 ----------------------
 dd   cc_deal%rowtype ;
 aa   accounts%rowtype;
 ----------------------
 a_NAME1 varchar2(17) ;
 kor_   int   := p_kor;
 n1_ number           ;
 n2_ number           ;
 oo   oper%rowtype    ;
 ----------------------
begin
  a_NAME1 := 'F' || to_char ( DAT1_, 'YYYYMMDD' ) || to_char ( DAT2_, 'YYYYMMDD' ) ;

    EXECUTE IMMEDIATE 'TRUNCATE TABLE  CCK_AN_TMP '  ;

-- корр за декабрь
If to_char(DAT2_,'MM') = '12' then    kor_ := 20 ;
else                                  kor_ := 10 ;
end if;

for k in (select a.NBS, a.ob22, o.fdat, o.dk, o.s, o.ref, a.nls, o.stmt
          from opldok o, accounts a
          where o.tt not in ('PVP','REV' )  and o.tt not like 'ZG_'   and a.acc=o.acc
            and a.nbs > '5999' and a.nbs < '8000'
            and o.fdat >= DAT1_    and o.fdat <= (DAT2_+ kor_)
          )
loop
   select * into oo from oper where ref = k.ref;
   If oo.vob in (96,99) then -- это коррект прошлого периода
      If oo.vdat < DAT1_ then  goto NextRec;
      end if;
   else -- это обычные будущего периода
      If k.fdat > DAT2_ then   goto NextRec;
      end if;
   end if;

   -- надо определить ND, кому принадлежат эти дох/расх !!!!!

   -- Берем контр-счет из проводки
   select a.acc,  a.nbs,  a.KV
   into  aa.acc, aa.nbs, aa.kv
   from opldok o, accounts a
   where o.ref = k.ref and o.stmt = k.stmt and o.dk = 1-k.dk and a.acc=o.acc;

   If aa.nbs = '3801' then
      -- Мультивал.операция, значит, Берем контр-счет из документа
     begin
       --проверим по стороне A
       select a.acc,  a.kv
       into  aa.acc, aa.kv
       from accounts a
       where kv = oo.kv  and nls = oo.nlsa and nls != k.nls and oo.mfoa = gl.amfo ;
     exception when no_data_found then
       begin
         --проверим по стороне Б
         select a.acc,  a.kv
         into  aa.acc, aa.kv
         from accounts a
         where kv = oo.kv2 and nls = oo.nlsb and nls != k.nls and oo.mfob = gl.amfo ;
       exception when no_data_found then goto NextRec;
       end;
     end;
   end if;

   -- найти КД
   begin
     If    p_mode = 2 then
        select d.* into dd from cc_deal d, nd_acc n where d.nd = n.nd and n.acc = aa.acc and d.vidd in (1,2,3) and rownum=1;
     elsIf p_mode = 2 then
        select d.* into dd from cc_deal d, nd_acc n where d.nd = n.nd and n.acc = aa.acc and d.vidd in (11,12,13) and rownum=1;
     elsIf p_mode = 1 then
        select d.* into dd from cc_deal d, nd_acc n where d.nd = n.nd and n.acc = aa.acc and d.vidd>=1500 and rownum=1;
     end if;
   exception when no_data_found then goto NextRec;
   end;

--  select d.* into dd from cc_deal d, nd_acc n where d.nd = n.nd and n.acc = aa.acc and d.vidd in (11,12,13) ;

   If k.dk=0 then n1_ := k.S ; n2_ := 0   ;
   else           n1_ := 0   ; n2_ := k.s ;
   end if;

   update CCK_AN_TMP set n1 = n1 + n1_, n2 = n2 + n2_ where nd = dd.ND and nls = k.nbs||k.ob22 ;
   if SQL%rowcount = 0 then

      If dd.vidd  in (3,13) then -- только для мультивал КД
         select kv into aa.kv from nd_acc n, accounts a where n.nd = dd.nd and n.acc= a.acc and a.tip='LIM';
      end if;

      if dd.sos >=15 then dd.sos := 1;
      else                dd.sos := 0;
      end if ;

      insert into CCK_AN_TMP ( nd, n1, n2, NAME1, reg, kv, nls,  branch, nlsalt, UV, PRS, PR, n5, cc_id, SROK ) values
        (dd.ND, n1_, n2_, a_NAME1, dd.rnk, aa.kv, k.nbs||k.ob22, dd.branch, substr(dd.prod,1,15),
         dd.fin23, dd.obs23, dd.kat23, dd.k23, dd.cc_id, dd.sos);

   end if;

 <<NextRec>> NULL;

end loop;
----------------------
commit;

end p_fin_rez_ccK;
/
show err;

PROMPT *** Create  grants  P_FIN_REZ_CCK ***
grant EXECUTE                                                                on P_FIN_REZ_CCK   to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_FIN_REZ_CCK   to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_FIN_REZ_CCK.sql =========*** End
PROMPT ===================================================================================== 
