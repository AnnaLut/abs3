

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_WCS_BID_PHASES_TIMELIMITS.sql =======
PROMPT ===================================================================================== 


PROMPT *** Create  view V_WCS_BID_PHASES_TIMELIMITS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_WCS_BID_PHASES_TIMELIMITS ("BID_ID", "CRT_DATE", "SUBPRODUCT_ID", "PRODUCT_ID", "FIO", "SUMM", "STATUS", "PHASE_NAME", "PHASE_START", "PHASE_TIME", "PHASE_END", "PHASE_BROKEN_LIMIT", "PROC_START", "PROC_TIME", "PROC_END", "PROC_BROKEN_LIMIT", "PROC_USER_ID", "PROC_USER_FIO", "PROC_USER_BRANCH", "PHASE_TOTAL_TIME") AS 
  SELECT b.bid_id,
            b.crt_date,
            (SELECT name
               FROM wcs_subproducts
              WHERE id = b.subproduct_id)
               AS subproduct_id,
            (SELECT p.name
               FROM wcs_subproducts s, wcs_products p
              WHERE s.product_id = p.id AND s.id = b.subproduct_id)
               AS product_id,
            b.f || ' ' || b.i || ' ' || b.o AS fio,
            b.summ,
            CASE
               WHEN    wcs_utl.has_bid_state (b.bid_id, 'SYS_ERR') = 1
                    OR wcs_utl.has_bid_state (b.bid_id, 'APP_ERR') = 1
               THEN
                  'Помилка'
               WHEN wcs_utl.has_bid_state (b.bid_id, 'NEW_DENY') = 1
               THEN
                  'Відмова'
               WHEN wcs_utl.has_bid_state (b.bid_id, 'NEW_DONE') = 1
               THEN
                  'Видано'
               ELSE
                  'В обробці'
            END
               AS status,
            ptl.name AS phase_name,
            bpt.phase_start,
            wcs_utl.get_formated_days_string (
               NVL (bpt.phase_end, SYSDATE) - bpt.phase_start)
               AS phase_time,
            bpt.phase_end,
            CASE
               WHEN (NVL (bpt.phase_end, SYSDATE) - bpt.phase_start) >
                       ptl.timelimit
               THEN
                  wcs_utl.get_formated_days_string (
                       (NVL (bpt.phase_end, SYSDATE) - bpt.phase_start)
                     - ptl.timelimit)
               ELSE
                  NULL
            END
               AS phase_broken_limit,
            bpt.proc_start,
            wcs_utl.get_formated_days_string (
               NVL (bpt.proc_end, SYSDATE) - bpt.proc_start)
               AS proc_time,
            bpt.proc_end,
            CASE
               WHEN (NVL (bpt.proc_end, SYSDATE) - bpt.proc_start) >
                       ptl.timelimit
               THEN
                  wcs_utl.get_formated_days_string (
                       (NVL (bpt.proc_end, SYSDATE) - bpt.proc_start)
                     - ptl.timelimit)
               ELSE
                  NULL
            END
               AS proc_broken_limit,
            bpt.proc_user_id,
            sb.fio AS proc_user_fio,
            sb.branch AS proc_user_branch,
            (SELECT DECODE (
                       t_done - t_start,
                       NULL, 'в процесі',
                       wcs_utl.get_formated_days_string (t_done - t_start))
               FROM (SELECT state_id, checkout_dat, bid_id
                       FROM wcs_bid_states_history
                      WHERE checkout_dat IS NOT NULL) PIVOT (MAX (checkout_dat)
                                                      FOR state_id
                                                      IN  ('NEW_START' AS t_start,
                                                          'NEW_DONE' AS t_done))
              WHERE bid_id = b.bid_id)
               AS phase_total_time
       FROM v_wcs_bids b,
            TABLE (wcs_utl.get_bid_phases_times (b.bid_id)) bpt,
            wcs_phases_timelimits ptl,
            staff$base sb
      WHERE     b.bid_id = bpt.bid_id
            AND bpt.phase_id = ptl.id
            AND bpt.proc_user_id = sb.id(+)
   ORDER BY b.crt_date DESC, b.bid_id DESC, ptl.phase_ord;

PROMPT *** Create  grants  V_WCS_BID_PHASES_TIMELIMITS ***
grant SELECT                                                                 on V_WCS_BID_PHASES_TIMELIMITS to BARSREADER_ROLE;
grant FLASHBACK,SELECT                                                       on V_WCS_BID_PHASES_TIMELIMITS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_WCS_BID_PHASES_TIMELIMITS to UPLD;
grant SELECT                                                                 on V_WCS_BID_PHASES_TIMELIMITS to WCS_SYNC_USER;
grant FLASHBACK,SELECT                                                       on V_WCS_BID_PHASES_TIMELIMITS to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_WCS_BID_PHASES_TIMELIMITS.sql =======
PROMPT ===================================================================================== 
