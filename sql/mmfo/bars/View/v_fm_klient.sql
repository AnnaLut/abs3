

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_FM_KLIENT.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view V_FM_KLIENT ***

  CREATE OR REPLACE FORCE VIEW BARS.V_FM_KLIENT ("RNK", "NMK", "CUSTTYPE", "KOD", "DAT", "REL_RNK", "REL_NAME", "REL_KOD", "COMM") AS 
  select c.rnk,
       c.nmk,
       c.custtype,
       k.kod,
       k.dat,
       k.rel_rnk,
       (select t.nmk from customer t where t.rnk = k.rel_rnk and k.rel_intext = 1
       union all
       select ce.name from customer_extern ce where ce.id = k.rel_rnk and k.rel_intext = 0) as rel_name,
       case when rel_rnk is not null then k.kod else null end as rel_kod,
       case when k.rel_intext = 1 then 'пов''язана особа (клієнт банку)' when k.rel_intext = 0 then 'пов''язана особа (НЕ клієнт банку)' else 'клієнт' end as comm
  from fm_klient k, customer c
 where k.rnk = c.rnk
;

PROMPT *** Create  grants  V_FM_KLIENT ***
grant SELECT                                                                 on V_FM_KLIENT     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_FM_KLIENT     to FINMON01;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_FM_KLIENT.sql =========*** End *** ==
PROMPT ===================================================================================== 
