

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/CORP_CLIENT.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view CORP_CLIENT ***

  CREATE OR REPLACE FORCE VIEW BARS.CORP_CLIENT ("RNK", "NMK", "KODK", "NAMEK") AS 
  (SELECT c.rnk, c.nmk, i.kod_cli, i.name_cli
      FROM rnkp_kod k, customer c, kod_cli i
     WHERE c.rnk = k.rnk AND i.kod_cli = k.kodk);

PROMPT *** Create  grants  CORP_CLIENT ***
grant SELECT                                                                 on CORP_CLIENT     to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CORP_CLIENT     to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CORP_CLIENT     to CORP_CLIENT;
grant SELECT                                                                 on CORP_CLIENT     to RPBN001;
grant SELECT                                                                 on CORP_CLIENT     to START1;
grant SELECT                                                                 on CORP_CLIENT     to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CORP_CLIENT     to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on CORP_CLIENT     to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/CORP_CLIENT.sql =========*** End *** ==
PROMPT ===================================================================================== 
