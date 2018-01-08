

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_BANK_MON_UPD.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_BANK_MON_UPD ***

  CREATE OR REPLACE FORCE VIEW BARS.V_BANK_MON_UPD ("KOD", "NAME_MON", "NOM_MON", "TYPE", "CENA_NBU", "CENA_NBU_OTP", "CASE", "RAZR", "BRANCH", "ACTION", "ISP", "BDATE", "SDATE", "IDUPD") AS 
  select m.kod, m.name_mon,m.nom_mon, m.type, m.cena_nbu,m.cena_nbu_otp,m.case,m.razr,
                   m.branch, a.name action, to_char(s.id)||' '||substr(s.fio,1,100) isp,m.bdate,m.sdate, m.idupd
              from bank_mon_upd m, bank_metals_action a,staff$base s
             where m.action_id =a.id
               and s.id= m.isp;

PROMPT *** Create  grants  V_BANK_MON_UPD ***
grant SELECT                                                                 on V_BANK_MON_UPD  to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_BANK_MON_UPD  to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_BANK_MON_UPD  to PYOD001;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_BANK_MON_UPD  to START1;
grant SELECT                                                                 on V_BANK_MON_UPD  to UPLD;
grant FLASHBACK,SELECT                                                       on V_BANK_MON_UPD  to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_BANK_MON_UPD.sql =========*** End ***
PROMPT ===================================================================================== 
