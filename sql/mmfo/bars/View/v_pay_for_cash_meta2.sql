

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_PAY_FOR_CASH_META2.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  view V_PAY_FOR_CASH_META2 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_PAY_FOR_CASH_META2 ("ID", "FIO", "FIO1", "PASP", "PASPN", "ATRT", "DOVIR", "NLS") AS 
  select id,
          fio1 || '*' || pasp || '*' || paspn || '*' || atrt || '*' || dovir fio,
          fio1,
          pasp,
          paspn,
          atrt,
          dovir,
          nls
     from (  select id,
                    max (decode (tag, 'FIO', val, '')) fio1,
                    max (decode (tag, 'PASP', val, '')) pasp,
                    max (decode (tag, 'PASPN', val, '')) paspn,
                    max (decode (tag, 'ATRT', val, '')) atrt,
                    max (decode (tag, 'DOVIR', val, '')) dovir,
                    max (decode (tag, 'NLS  ', val, '')) nls
               from podotc
           group by id
             having max (decode (tag, 'NLS', val, '')) =
                       pul.get_mas_ini_val ('P_NLS'));

PROMPT *** Create  grants  V_PAY_FOR_CASH_META2 ***
grant SELECT                                                                 on V_PAY_FOR_CASH_META2 to BARSREADER_ROLE;
grant SELECT                                                                 on V_PAY_FOR_CASH_META2 to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_PAY_FOR_CASH_META2 to START1;
grant SELECT                                                                 on V_PAY_FOR_CASH_META2 to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_PAY_FOR_CASH_META2.sql =========*** E
PROMPT ===================================================================================== 
