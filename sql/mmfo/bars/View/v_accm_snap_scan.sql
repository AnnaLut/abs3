

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_ACCM_SNAP_SCAN.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  view V_ACCM_SNAP_SCAN ***

  CREATE OR REPLACE FORCE VIEW BARS.V_ACCM_SNAP_SCAN ("SCAN_ID", "FDAT", "TABLE_NAME", "SCAN_SCN", "SCAN_DATE", "THRESHOLD_SCN", "THRESHOLD_DATEINFO", "MOD_ACC", "MOD_NLS", "MOD_KV", "MOD_SCN", "MOD_DATEINFO", "QUERY_CONDITION") AS 
  select s.scan_id,
       s.fdat,
       s.table_name,
       s.scan_scn,
       s.scan_date,
       s.threshold_scn,
       s.threshold_dateinfo,
       s.mod_acc,
       a.nls as mod_nls,
       a.kv as mod_kv,
       s.mod_scn,
       s.mod_dateinfo,
       s.query_condition
  from accm_snap_scan s, accounts a
 where s.mod_acc = a.acc;

PROMPT *** Create  grants  V_ACCM_SNAP_SCAN ***
grant SELECT                                                                 on V_ACCM_SNAP_SCAN to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_ACCM_SNAP_SCAN to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_ACCM_SNAP_SCAN.sql =========*** End *
PROMPT ===================================================================================== 
