

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_E_DEAL_TARIF_ND.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_E_DEAL_TARIF_ND ***

  CREATE OR REPLACE FORCE VIEW BARS.V_E_DEAL_TARIF_ND ("OTM", "ID", "NAME", "DAT_BEG", "DAT_END", "DAYS", "N_SUMT", "N_SUMT1", "E_SUMT", "E_SUMT1", "DAT_LB", "DAT_LE", "S_POROG", "S_TAR_POR1", "S_TAR_POR2") AS 
  (select nvl (n.otm, 0) as otm,
           e.id,
           e.name,
           trunc(n.dat_beg) dat_beg,
           trunc(n.dat_end) dat_end,
           elt.rab_dni (
              greatest (trunc(n.dat_beg),
                        to_date ('01' || pul.get ('ADAT'), 'ddmmyyyy')),
              least (
                 nvl (trunc(n.dat_end),
                      last_day (to_date (pul.get ('ADAT'), 'mmyyyy'))),
                 last_day (to_date (pul.get ('ADAT'), 'mmyyyy'))))
              as days,
           n.sumt/100 as n_sumt,
           n.sumt1/100 as n_sumt1,
           e.sumt/100 as e_sumt,
           e.sumt1/100 as e_sumt1,
           n.dat_lb,
           n.dat_le,
           n.s_porog,
           n.s_tar_por1,
           n.s_tar_por2
      from e_tar_nd n, e_tarif e
     where n.id(+) = e.id and n.nd(+) = to_number (pul.get ('DEAL_ND')));

PROMPT *** Create  grants  V_E_DEAL_TARIF_ND ***
grant SELECT                                                                 on V_E_DEAL_TARIF_ND to BARSREADER_ROLE;
grant SELECT                                                                 on V_E_DEAL_TARIF_ND to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_E_DEAL_TARIF_ND to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_E_DEAL_TARIF_ND.sql =========*** End 
PROMPT ===================================================================================== 
