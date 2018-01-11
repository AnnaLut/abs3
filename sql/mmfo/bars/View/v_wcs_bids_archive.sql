

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_WCS_BIDS_ARCHIVE.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  view V_WCS_BIDS_ARCHIVE ***

  CREATE OR REPLACE FORCE VIEW BARS.V_WCS_BIDS_ARCHIVE ("BID_ID", "SUBPRODUCT_ID", "SUBPRODUCT_NAME", "CRT_DATE", "STATUS", "RNK", "F", "I", "O", "FIO", "BDATE", "INN", "WORK_MAIN_NAME", "WORK_MAIN_INN", "WORK_ADD_NAME", "WORK_ADD_INN", "PROPERTY_COST", "SUMM", "OWN_FUNDS", "TERM", "CREDIT_CURRENCY", "SINGLE_FEE", "MONTHLY_FEE", "INTEREST_RATE", "REPAYMENT_METHOD", "REPAYMENT_DAY", "GARANTEES", "GARANTEES_IDS", "MGR_ID", "MGR_FIO", "BRANCH", "BRANCH_NAME", "BRANCH_HIERARCHY", "STATES") AS 
  SELECT b.bid_id,
            b.subproduct_id,
            b.subproduct_name,
            b.crt_date,
            CASE
               WHEN wcs_utl.has_bid_state (b.bid_id, 'SYS_ERR') = 1
                    OR wcs_utl.has_bid_state (b.bid_id, 'APP_ERR') = 1
               THEN
                  'ERR'
               WHEN wcs_utl.has_bid_state (b.bid_id, 'NEW_DENY') = 1
               THEN
                  'DENY'
               WHEN wcs_utl.has_bid_state (b.bid_id, 'NEW_DONE') = 1
               THEN
                  'DONE'
               ELSE
                  'PROC'
            END
               AS status,
            b.rnk,
            b.f,
            b.i,
            b.o,
            b.fio,
            b.bdate,
            b.inn,
            wcs_utl.get_answ (b.bid_id, 'CL_25') AS work_main_name,
            wcs_utl.get_answ (b.bid_id, 'CL_0_9') AS work_main_inn,
            wcs_utl.get_answ (b.bid_id, 'CL_28') AS work_add_name,
            wcs_utl.get_answ (b.bid_id, 'CL_0_13') AS work_add_inn,
            TO_NUMBER (wcs_utl.get_creditdata (b.bid_id, 'PROPERTY_COST'))
               AS property_cost,
            b.summ,
            b.own_funds,
            b.term,
            b.credit_currency,
            b.single_fee,
            b.monthly_fee,
            b.interest_rate,
            b.repayment_method,
            b.repayment_day,
            b.garantees,
            (SELECT    ','
                    || g_gid
                    || ','
                    || vh_gid
                    || ','
                    || m_gid
                    || ','
                    || ml_gid
                    || ','
                    || d_gid
                    || ','
                    || p_gid
                    || ','
                    || v_gid
                       AS garantees
               FROM (  SELECT bg.bid_id, bg.garantee_id
                         FROM v_wcs_bid_garantees bg
                     GROUP BY bg.bid_id, bg.garantee_id) PIVOT (MAX (
                                                                   garantee_id) AS gid
                                                         FOR garantee_id
                                                         IN  ('GUARANTOR' AS g,
                                                             'VEHICLE' AS vh,
                                                             'MORTGAGE' AS m,
                                                             'MORTGAGE_LAND' AS ml,
                                                             'DEPOSIT' AS d,
                                                             'PRODUCT' AS p,
                                                             'VALUABLES' AS v))
              WHERE bid_id = b.bid_id)
               AS garantees_ids,
            b.mgr_id,
            b.mgr_fio,
            b.branch,
            b.branch_name,
            b.branch_hierarchy,
            b.states
       FROM v_wcs_bids b,
            wcs_subproducts sbp,
            staff$base sb,
            branch brc
      WHERE     b.subproduct_id = sbp.id
            AND b.mgr_id = sb.id
            AND b.branch = brc.branch
   ORDER BY b.bid_id DESC;

PROMPT *** Create  grants  V_WCS_BIDS_ARCHIVE ***
grant SELECT                                                                 on V_WCS_BIDS_ARCHIVE to BARSREADER_ROLE;
grant SELECT                                                                 on V_WCS_BIDS_ARCHIVE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_WCS_BIDS_ARCHIVE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_WCS_BIDS_ARCHIVE.sql =========*** End
PROMPT ===================================================================================== 
