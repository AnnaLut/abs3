

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_WCS_BIDS.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_WCS_BIDS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_WCS_BIDS ("BID_ID", "SUBPRODUCT_ID", "SUBPRODUCT_NAME", "SUBPRODUCT_DESC", "CRT_DATE", "RNK", "F", "I", "O", "FIO", "BDATE", "INN", "SUMM", "OWN_FUNDS", "TERM", "CREDIT_CURRENCY", "SINGLE_FEE", "MONTHLY_FEE", "INTEREST_RATE", "REPAYMENT_METHOD", "REPAYMENT_METHOD_TEXT", "REPAYMENT_DAY", "GARANTEES", "MGR_ID", "MGR_FIO", "BRANCH", "BRANCH_NAME", "BRANCH_HIERARCHY", "STATES", "INIT_PAYMENT_MTD") AS 
  SELECT b.id AS bid_id,
            b.subproduct_id,
            sbp.name AS subproduct_name,
            wcs_utl.get_mac_formated (b.id, 'MAC_SBP_DESCRIPTION')
               AS subproduct_desc,
            b.crt_date,
            b.rnk,
            wcs_utl.get_answ (b.id, 'CL_1') AS f,
            wcs_utl.get_answ (b.id, 'CL_2') AS i,
            wcs_utl.get_answ (b.id, 'CL_3') AS o,
               wcs_utl.get_answ (b.id, 'CL_1')
            || ' '
            || wcs_utl.get_answ (b.id, 'CL_2')
            || ' '
            || wcs_utl.get_answ (b.id, 'CL_3')
               AS fio,
            TO_DATE (wcs_utl.get_answ (b.id, 'CL_4')) AS bdate,
            wcs_utl.get_answ (b.id, 'CODE_002') AS inn,
            TO_NUMBER (wcs_utl.get_creditdata (b.id, 'CREDIT_SUM')) AS summ,
            TO_NUMBER (wcs_utl.get_creditdata (b.id, 'OWN_FUNDS')) AS own_funds,
            wcs_utl.get_creditdata (b.id, 'CREDIT_TERM') AS term,
            wcs_utl.get_creditdata (b.id, 'CREDIT_CURRENCY') AS credit_currency,
            TO_NUMBER (wcs_utl.get_creditdata (b.id, 'SINGLE_FEE'))
               AS single_fee,
            TO_NUMBER (wcs_utl.get_creditdata (b.id, 'MONTHLY_FEE'))
               AS monthly_fee,
            TO_NUMBER (wcs_utl.get_creditdata (b.id, 'INTEREST_RATE'))
               AS interest_rate,
            wcs_utl.get_creditdata (b.id, 'REPAYMENT_METHOD')
               AS repayment_method,
            wcs_utl.
             get_answ_list_text (
               b.id,
               wcs_utl.get_creditdata_qid (b.id, 'REPAYMENT_METHOD'))
               AS repayment_method_text,
            TO_NUMBER (wcs_utl.get_creditdata (b.id, 'REPAYMENT_DAY'))
               AS repayment_day,
            wcs_utl.get_bid_garantees (b.id) AS garantees,
            b.mgr_id,
            fio (sb.fio, 1) AS mgr_fio,
            b.branch,
            brc.name AS branch_name,
            CASE WHEN LENGTH (b.branch) = 1 THEN 'CA' ELSE 'RU' END
               AS branch_hierarchy,
            wcs_utl.get_bid_states (b.id) AS states,
            (SELECT pt.name || ' ('
                    || CASE pt.id
                          WHEN 'CURACC'
                          THEN
                             (SELECT MIN (a.nls)
                                FROM accounts a
                               WHERE a.acc =
                                        TO_NUMBER (
                                           wcs_utl.
                                            get_answ (b.id, 'PI_CURACC_ACCNO')))
                          WHEN 'PARTNER'
                          THEN
                             (SELECT MIN (p.name)
                                FROM wcs_partners p
                               WHERE p.id =
                                        TO_NUMBER (
                                           wcs_utl.
                                            get_answ (b.id, 'PI_PARTNER_ID')))
                          WHEN 'FREE'
                          THEN
                                'ÌÔÎ '
                             || wcs_utl.get_answ (b.id, 'PI_FREE_MFO')
                             || ', ðàõ. '
                             || wcs_utl.get_answ (b.id, 'PI_FREE_NLS')
                          WHEN 'CASH'
                          THEN
                             'â³ää³ëåííÿ '
                             || wcs_utl.get_answ (b.id, 'PI_CASH_BRANCH')
                          WHEN 'CARDACC'
                          THEN
                             (SELECT MIN (a.nls)
                                FROM accounts a
                               WHERE a.acc =
                                        TO_NUMBER (
                                           wcs_utl.
                                            get_answ (b.id, 'PI_CARDACC_ACCNO')))
                          ELSE
                             NULL
                       END
                    || ')'
               FROM wcs_payment_types pt
              WHERE wcs_utl.get_answ_bool (b.id, 'PI_' || pt.id || '_SELECTED') =
                       1
                    AND ROWNUM = 1)
               AS init_payment_mtd
       FROM wcs_bids b,
            wcs_subproducts sbp,
            staff$base sb,
            branch brc
      WHERE     b.subproduct_id = sbp.id
            AND b.mgr_id = sb.id
            AND b.branch = brc.branch
   ORDER BY b.id DESC
;

PROMPT *** Create  grants  V_WCS_BIDS ***
grant SELECT                                                                 on V_WCS_BIDS      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_WCS_BIDS      to WCS_SYNC_USER;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_WCS_BIDS.sql =========*** End *** ===
PROMPT ===================================================================================== 
