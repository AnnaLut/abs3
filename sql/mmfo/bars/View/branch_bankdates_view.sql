

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/BRANCH_BANKDATES_VIEW.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  view BRANCH_BANKDATES_VIEW ***

  CREATE OR REPLACE FORCE VIEW BARS.BRANCH_BANKDATES_VIEW ("KF", "NAME", "BDATE", "STAT") AS 
  SELECT a.kf, m.name, to_date(trim(a.val),'MM/DD/YYYY'),
         decode(trim(b.val), '1', 'Вікритий','Закритий')
    FROM params$base a, params$base b, branch_mfo m
   WHERE a.kf = b.kf
     AND trim(a.par) = 'BANKDATE'
     AND trim(b.par) = 'RRPDAY'
     AND a.kf = m.mfo
 ;

PROMPT *** Create  grants  BRANCH_BANKDATES_VIEW ***
grant SELECT                                                                 on BRANCH_BANKDATES_VIEW to BARSREADER_ROLE;
grant SELECT                                                                 on BRANCH_BANKDATES_VIEW to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on BRANCH_BANKDATES_VIEW to DPT_ADMIN;
grant SELECT                                                                 on BRANCH_BANKDATES_VIEW to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on BRANCH_BANKDATES_VIEW to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/BRANCH_BANKDATES_VIEW.sql =========*** 
PROMPT ===================================================================================== 
