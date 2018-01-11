

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/CCK_RESTR_V.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view CCK_RESTR_V ***

  CREATE OR REPLACE FORCE VIEW BARS.CCK_RESTR_V ("ND", "CC_ID", "RNK", "NMK", "SDATE", "WDATE", "VID_RESTR", "FDAT", "TXT", "SUMR", "FDAT_END", "PR_NO", "KND", "KDAT", "KVID") AS 
  SELECT cr.nd,
          cd.cc_id,
          c.rnk,
          c.nmk,
          cd.sdate,
          cd.wdate,
          cr.vid_restr,
          cr.fdat,
          cr.txt,
          cr.SUMR,
          cr.FDAT_END,
          cr.PR_NO,
          cr.nd knd,
          cr.fdat kdat,
          cr.vid_restr kvid
     FROM customer c,
          cc_deal cd,
          cc_add a,
          cck_restr cr
    WHERE cd.nd = cr.nd AND cd.rnk = c.rnk AND cd.nd = a.nd AND a.adds = 0
;

PROMPT *** Create  grants  CCK_RESTR_V ***
grant SELECT                                                                 on CCK_RESTR_V     to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CCK_RESTR_V     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CCK_RESTR_V     to RCC_DEAL;
grant SELECT                                                                 on CCK_RESTR_V     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/CCK_RESTR_V.sql =========*** End *** ==
PROMPT ===================================================================================== 
