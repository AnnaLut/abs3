

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_WCS_SCORING_BAL.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_WCS_SCORING_BAL ***

  CREATE OR REPLACE FORCE VIEW BARS.V_WCS_SCORING_BAL ("BID_ID", "KPP", "KPP_C", "KPP_BAL", "KPP_BAL_C", "KPS", "KPS_BAL", "CHP", "CHP_BAL", "CHPS", "CHPS_BAL", "DP", "DP_BAL", "P4DP", "P4DP_BAL", "P4DS", "P4DS_BAL", "RB", "RB_BAL", "VN", "VN_BAL", "PR", "PR_BAL", "ZS", "ZS_BAL", "SM", "SM_BAL", "MP", "MP_BAL", "PJ", "PJ_BAL", "VPK", "VPK_BAL", "R", "R_BAL", "KZB", "KZB_BAL", "S1_BAL", "S2_BAL", "PVB_BAL", "MPK_BAL", "PRM_BAL") AS 
  SELECT b.id AS bid_id,
          TO_CHAR (NVL (ROUND (wcs_utl.get_score (b.id, s.id, 'KPP'), 2), 0),
                   '999990D99')
             AS KPP,
          TO_CHAR (NVL (ROUND (wcs_utl.get_score (b.id, s.id, 'KPP_C'), 2), 0),
                   '999990D99')
             AS KPP_C,
          TO_CHAR (NVL (wcs_utl.get_answ (b.id, 'KPP'), 0), '999990D99')
             AS KPP_bal,
          TO_CHAR (NVL (wcs_utl.get_answ (b.id, 'KPP_C'), 0), '999990D99')
             AS KPP_bal_C,
          TO_CHAR (NVL (ROUND (wcs_utl.get_score (b.id, s.id, 'KPS'), 2), 0),
                   '999990D99')
             AS KPS,
          TO_CHAR (NVL (wcs_utl.get_answ (b.id, 'KPS'), 0), '999990D99')
             AS KPS_bal,
          TO_CHAR (NVL (ROUND (wcs_utl.get_score (b.id, s.id, '4P'), 2), 0),
                   '999990D99')
             AS CHP,
          TO_CHAR (NVL (wcs_utl.get_answ (b.id, '4P'), 0), '999990D99')
             AS CHP_bal,
          TO_CHAR (NVL (ROUND (wcs_utl.get_score (b.id, s.id, '4PS'), 2), 0),
                   '999990D99')
             AS CHPS,
          TO_CHAR (NVL (wcs_utl.get_answ (b.id, '4PS'), 0), '999990D99')
             AS CHPS_bal,
          TO_CHAR (NVL (ROUND (wcs_utl.get_score (b.id, s.id, 'DP'), 2), 0),
                   '999990D99')
             AS DP,
          TO_CHAR (NVL (wcs_utl.get_answ (b.id, 'DP'), 0), '999990D99')
             AS DP_bal,
          TO_CHAR (
             NVL (ROUND (wcs_utl.get_score (b.id, s.id, 'P4DP'), 2), 0),
             '999990D99')
             AS P4DP,
          TO_CHAR (NVL (wcs_utl.get_answ (b.id, 'P4DP'), 0), '999990D99')
             AS P4DP_bal,
          TO_CHAR (
             NVL (ROUND (wcs_utl.get_score (b.id, s.id, 'P4DS'), 2), 0),
             '999990D99')
             AS P4DS,
          TO_CHAR (NVL (wcs_utl.get_answ (b.id, 'P4DS'), 0), '999990D99')
             AS P4DS_bal,
          TO_CHAR (NVL (ROUND (wcs_utl.get_score (b.id, s.id, 'RB'), 2), 0),
                   '999990D99')
             AS RB,
          TO_CHAR (NVL (wcs_utl.get_answ (b.id, 'RB'), 0), '999990D99')
             AS RB_bal,
          TO_CHAR (NVL (ROUND (wcs_utl.get_score (b.id, s.id, 'VN'), 2), 0),
                   '999990D99')
             AS VN,
          TO_CHAR (NVL (wcs_utl.get_answ (b.id, 'VN'), 0), '999990D99')
             AS VN_bal,
          TO_CHAR (NVL (ROUND (wcs_utl.get_score (b.id, s.id, 'PR'), 2), 0),
                   '999990D99')
             AS PR,
          TO_CHAR (NVL (wcs_utl.get_answ (b.id, 'PR'), 0), '999990D99')
             AS PR_bal,
          TO_CHAR (NVL (ROUND (wcs_utl.get_score (b.id, s.id, 'ZS'), 2), 0),
                   '999990D99')
             AS ZS,
          TO_CHAR (NVL (wcs_utl.get_answ (b.id, 'ZS'), 0), '999990D99')
             AS ZS_bal,
          TO_CHAR (NVL (ROUND (wcs_utl.get_score (b.id, s.id, 'SM'), 2), 0),
                   '999990D99')
             AS SM,
          TO_CHAR (NVL (wcs_utl.get_answ (b.id, 'SM'), 0), '999990D99')
             AS SM_bal,
          TO_CHAR (NVL (ROUND (wcs_utl.get_score (b.id, s.id, 'MP'), 2), 0),
                   '999990D99')
             AS MP,
          TO_CHAR (NVL (wcs_utl.get_answ (b.id, 'MP'), 0), '999990D99')
             AS MP_bal,
          TO_CHAR (NVL (ROUND (wcs_utl.get_score (b.id, s.id, 'PJ'), 2), 0),
                   '999990D99')
             AS PJ,
          TO_CHAR (NVL (wcs_utl.get_answ (b.id, 'PJ'), 0), '999990D99')
             AS PJ_bal,
          TO_CHAR (NVL (ROUND (wcs_utl.get_score (b.id, s.id, 'VPK'), 2), 0),
                   '999990D99')
             AS VPK,
          TO_CHAR (NVL (wcs_utl.get_answ (b.id, 'VPK'), 0), '999990D99')
             AS VPK_bal,
          TO_CHAR (NVL (ROUND (wcs_utl.get_score (b.id, s.id, 'R'), 2), 0),
                   '999990D99')
             AS R,
          TO_CHAR (NVL (wcs_utl.get_answ (b.id, 'R'), 0), '999990D99')
             AS R_bal,
          TO_CHAR (NVL (ROUND (wcs_utl.get_score (b.id, s.id, 'KZB'), 2), 0),
                   '999990D99')
             AS KZB,
          TO_CHAR (NVL (wcs_utl.get_answ (b.id, 'KZB'), 0), '999990D99')
             AS KZB_bal,
          TO_CHAR (NVL (ROUND (wcs_utl.get_answ (b.id, 'S'), 2), 0),
                   '999990D99')
             AS S1_bal,
          TO_CHAR (NVL (ROUND (wcs_utl.get_answ (b.id, 'S2'), 2), 0),
                   '999990D99')
             AS S2_bal,
          TO_CHAR (NVL (wcs_utl.get_answ (b.id, 'PVB'), 0), '999990D99')
             AS PVB_bal,
          TO_CHAR (NVL (ROUND (wcs_utl.get_answ (b.id, 'MPK'), 2), 0),
                   '999990D99')
             AS MPK_bal,
          TO_CHAR (NVL (ROUND (wcs_utl.get_answ (b.id, 'PRM'), 2), 0),
                   '999990D99')
             AS PRM_bal
     FROM wcs_bids b, wcs_subproduct_scoring ss, wcs_scorings s
    WHERE b.subproduct_id = ss.subproduct_id AND ss.scoring_id = s.id;

PROMPT *** Create  grants  V_WCS_SCORING_BAL ***
grant SELECT                                                                 on V_WCS_SCORING_BAL to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_WCS_SCORING_BAL.sql =========*** End 
PROMPT ===================================================================================== 
