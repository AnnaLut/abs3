

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/OPER_OPERW_KODDZ.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  view OPER_OPERW_KODDZ ***

  CREATE OR REPLACE FORCE VIEW BARS.OPER_OPERW_KODDZ ("BRANCH", "REF", "TT", "USERID", "NLSA", "NAM_A", "S", "KV", "DATD", "MFOB", "NLSB", "NAM_B", "ID_B", "NAZN", "KODDZ", "SUMDZ") AS 
  select o.branch, o.ref , o.tt  , o.userid, o.nlsa, o.nam_a, o.s/100 S, o.kv,
       o.datd  , o.mfob, o.nlsb, o.nam_b , o.id_b, o.nazn ,
       replace( replace (k.koddz, ',',''),'.','') KODDZ,
       nvl( (select to_number(value)
             from operw
             where tag = 'S_DZ'||k.TAG
               and ref = o.REF),
            o.s/100 ) SUMDZ
from
(select branch,ref,tt,userid,nlsa,nam_a,S,kv,datd,mfob,nlsb,nam_b,id_b,nazn
 from oper
 where sos=5
   and vdat >=NVL(TO_DATE(pul.get_mas_ini_val('sFdat1'),'dd.mm.yyyy'), gl.bd-7)
   and vdat <=NVL(TO_DATE(pul.get_mas_ini_val('sFdat2'),'dd.mm.yyyy'), gl.bd   )
   and exists (select 1 from operw where tag like 'K_DZ_' and ref=oper.REF)
  ) o,
 (select ref,substr(tag,-1) tag, value koddz from operw where tag like 'K_DZ_') k
where o.ref= k.ref ;

PROMPT *** Create  grants  OPER_OPERW_KODDZ ***
grant FLASHBACK,SELECT                                                       on OPER_OPERW_KODDZ to ABS_ADMIN;
grant FLASHBACK,SELECT                                                       on OPER_OPERW_KODDZ to BARS_ACCESS_DEFROLE;
grant FLASHBACK,SELECT                                                       on OPER_OPERW_KODDZ to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/OPER_OPERW_KODDZ.sql =========*** End *
PROMPT ===================================================================================== 
