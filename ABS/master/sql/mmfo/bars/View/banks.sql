

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/BANKS.sql =========*** Run *** ========
PROMPT ===================================================================================== 


PROMPT *** Create  view BANKS ***

  CREATE OR REPLACE FORCE VIEW BARS.BANKS ("MFO", "SAB", "NB", "FMI", "FMO", "KODG", "PM", "KODN", "BLK", "MFOP", "MFOU", "SSP", "NMO") AS 
  select b.mfo, b.sab, b.nb, s.fmi, s.fmo, b.kodg, s.pm, s.kodn, b.blk,
          s.mfop, b.mfou, b.ssp, b.nmo
     from banks$base b, banks$settings s
    where b.mfo = s.mfo and s.kf = sys_context ('bars_context', 'user_mfo')
   union all
   select b.mfo, b.sab, b.nb, null, null, b.kodg, null, null, b.blk,
          substr (sys_context ('bars_context', 'user_mfop'), 1, 12), b.mfou,
          b.ssp, b.nmo
     from banks$base b
    where b.mfo not in (select mfo
                          from banks$settings
                         where kf = sys_context ('bars_context', 'user_mfo'))
 ;

PROMPT *** Create  grants  BANKS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on BANKS           to BANKS;
grant DELETE,INSERT,SELECT,UPDATE                                            on BANKS           to BANKS_V;
grant FLASHBACK,REFERENCES,SELECT                                            on BANKS           to BARSAQ with grant option;
grant REFERENCES,SELECT                                                      on BANKS           to BARSAQ_ADM with grant option;
grant SELECT                                                                 on BANKS           to BARSUPL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on BANKS           to BARS_ACCESS_DEFROLE;
grant DEBUG,DELETE,FLASHBACK,INSERT,MERGE VIEW,ON COMMIT REFRESH,QUERY REWRITE,REFERENCES,SELECT,UPDATE on BANKS           to FINMON;
grant DELETE,INSERT,SELECT,UPDATE                                            on BANKS           to INSPECTOR;
grant SELECT                                                                 on BANKS           to RPBN002;
grant DELETE,INSERT,SELECT,UPDATE                                            on BANKS           to SEP_ROLE;
grant SELECT                                                                 on BANKS           to SETLIM01;
grant SELECT                                                                 on BANKS           to START1;
grant UPDATE                                                                 on BANKS           to TECH007;
grant INSERT,SELECT,UPDATE                                                   on BANKS           to TECH020;
grant SELECT,UPDATE                                                          on BANKS           to TOSS;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on BANKS           to WR_ALL_RIGHTS;
grant SELECT                                                                 on BANKS           to WR_CREDIT;
grant SELECT                                                                 on BANKS           to WR_CUSTREG;
grant SELECT                                                                 on BANKS           to WR_VERIFDOC;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/BANKS.sql =========*** End *** ========
PROMPT ===================================================================================== 
