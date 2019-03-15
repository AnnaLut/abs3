
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/view/v_cf_deposit.sql =========*** Run *** =
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FORCE VIEW BARS.V_CF_DEPOSIT ("RNK", "DDNUM", "DDPROD", "DDBRANCH", "DDSTATUS", "DDADDOC", "DDCUR", "DDTAX", "DDSUM", "DDSTARTDATE", "DDLASTDATE", "DDFINISHDATE", "DDTERM", "DDPROLN", "DACCAMUAH", "DDACCAMOUNT") AS 
  SELECT c.rnk AS rnk,
          d.dpt_id AS DDNUM,
          d.product_code AS DDPROD,
          d.branch AS DDBRANCH,
          d.status AS DDSTATUS,
          (SELECT LISTAGG (a.AGRMNT_TYPE, ';')
                     WITHIN GROUP (ORDER BY a.AGRMNT_TYPE)
                     "DDADDDOC"
             FROM DPT_AGREEMENTS a
            WHERE a.DPT_ID = d.DPT_ID) DDADDOC,
          d.kv AS DDCUR,
          dpt_web.get_dptrate (d.acc,
                               d.kv,
                               d.LIMIT,
                               TRUNC (SYSDATE))
             AS DDTAX,
          d.LIMIT / 100 AS DDSUM,
          d.datz AS DDSTARTDATE,
          d.dat_begin AS DDLASTDATE,
          d.dat_end AS DDFINISHDATE,
          d.dat_end - d.dat_begin AS DDTERM,
          d.CNT_DUBL AS DDPROLN,
          fostq (d.acc, gl.bd) / 100 AS DACCAMUAH,
          fost (d.acc, gl.bd) / 100 AS DDACCAMOUNT
     FROM (SELECT d1.deposit_id dpt_id,
                  d1.nd,
                  d1.datz,
                  d1.acc acc,
                  d1.rnk,
                  d1.vidd,
                  d1.dat_begin,
                  d1.dat_end,
                  d1.LIMIT,
                  NVL (d1.status, 0) AS status,
                  d1.comments,
                  d1.mfo_p,
                  d1.nls_p,
                  SUBSTR (d1.name_p, 1, 38) nms_p,
                  d1.okpo_p,
                  d1.mfo_d,
                  d1.nls_d,
                  d1.nms_d,
                  d1.okpo_d,
                  d1.branch,
                  d1.wb,
                  dt.type_id AS product_code,
                  d1.kv,
                  NVL (d1.CNT_DUBL, 0) AS CNT_DUBL
             FROM dpt_deposit d1, dpt_vidd v, dpt_types dt
            WHERE d1.vidd = v.vidd AND v.type_cod = dt.type_code
           UNION ALL
           SELECT dc.deposit_id,
                  dc.nd,
                  dc.datz,
                  dc.acc,
                  dc.rnk,
                  dc.vidd,
                  dc.dat_begin,
                  dc.dat_end,
                  dc.LIMIT,
                  -1 AS status,
                  dc.comments,
                  dc.mfo_p,
                  dc.nls_p,
                  SUBSTR (dc.name_p, 1, 38),
                  dc.okpo_p,
                  dc.mfo_d,
                  dc.nls_d,
                  dc.nms_d,
                  dc.okpo_d,
                  dc.branch,
                  dc.wb,
                  dt.type_id AS product_code,
                  DC.KV,
                  NVL (DC.CNT_DUBL, 0) AS CNT_DUBL
             FROM dpt_deposit_clos dc, dpt_vidd v, dpt_types dt
            WHERE     dc.action_id IN (1, 2)
                  AND dc.vidd = v.vidd
                  AND v.type_cod = dt.type_code
                  AND NOT EXISTS
                         (SELECT 1
                            FROM dpt_deposit d
                           WHERE d.deposit_id = dc.deposit_id)) d,
          bars.customer c
    WHERE d.rnk = c.rnk
;
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/view/v_cf_deposit.sql =========*** End *** =
 PROMPT ===================================================================================== 
 