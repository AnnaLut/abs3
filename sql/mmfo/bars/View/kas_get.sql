

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/KAS_GET.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** Create  view KAS_GET ***

  CREATE OR REPLACE FORCE VIEW BARS.KAS_GET ("BRANCH", "IDZ", "KV", "REFA", "DOKA", "S", "SVID", "GET_CASH") AS 
  SELECT k.branch, k.idz, o.kv, o.ref,
       make_url('/barsroot/documentview/default.aspx?ref='||o.REF,
                o.REF||'. Перегляд') DOKA,
       o.s/100,
       decode(k.VID, 1, '1.Готiвка' ,  2, '2.Вир.з БМ',
                     3, '3.Мон+Футл',  4, '4.Iншi,98*',  '???')  SVID,
make_docinput_url (
  decode (o.tt, '1KA','1KB', '9KA','9KB','###'),
  'Прийняти з дороги',
  'reqv_INK_M', (select value from operw where tag='INK_M' and ref=o.REF),
  'reqv_INK_N', (select value from operw where tag='INK_N' and ref=o.REF),
  'reqv_VA_KC', k.KODV,
  'Nls_B'     , k.NLSB,
  'Nls_A'     , o.NLSA,
  'Kv_A'      , k.KV,
  'SumC_t'    , o.s,
  'nazn'      , o.nazn,
  'dk'        , 0,
  'APROC'     , 'set role BARS_ACCESS_DEFROLE@begin kasz.GET_K('||k.idz||','||o.REF||');end;'
    )
from KAS_Z k, accounts a, oper o
where k.branch = sys_context('bars_context','user_branch')
  and a.kv=k.kv and a.nls = k.nlsb and  nvl(k.s,k.kol) >0
  and k.refb is null  and k.refa = o.ref   and o.sos=5  and k.sos=2
  ;

PROMPT *** Create  grants  KAS_GET ***
grant SELECT                                                                 on KAS_GET         to BARSREADER_ROLE;
grant FLASHBACK,SELECT                                                       on KAS_GET         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KAS_GET         to PYOD001;
grant SELECT                                                                 on KAS_GET         to UPLD;
grant FLASHBACK,SELECT                                                       on KAS_GET         to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/KAS_GET.sql =========*** End *** ======
PROMPT ===================================================================================== 
