

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_SOCIALDPTTYPES.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  view V_SOCIALDPTTYPES ***

  CREATE OR REPLACE FORCE VIEW BARS.V_SOCIALDPTTYPES ("AGNTYPE_ID", "AGNTYPE_NAME", "TYPE_ID", "TYPE_NAME", "ACC_TYPE", "DPT_VIDD", "MASK_NUMBER", "KV_ID", "KV_NAME", "FL_INT", "RATE") AS 
  SELECT a.type_id, a.type_name, d.type_id, d.NAME, d.acc_type, d.dpt_vidd,
          d.mask_number, v.kv, t.NAME,
          DECODE (v.bsd, v.bsn, DECODE (v.br_id, 0, 0, 1), 1),
          getbrat (bankdate, v.br_id, v.kv, 0)
     FROM social_agency_dpttypes ad,
          social_agency_type a,
          social_dpt_types d,
          dpt_vidd v,
          tabval t
    WHERE a.type_id = ad.agntype
      AND ad.dpttype = d.type_id
      AND d.dpt_vidd = v.vidd
      AND d.activity = 1
      AND t.kv = v.kv 
 ;

PROMPT *** Create  grants  V_SOCIALDPTTYPES ***
grant SELECT                                                                 on V_SOCIALDPTTYPES to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_SOCIALDPTTYPES to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_SOCIALDPTTYPES to BARS_CONNECT;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_SOCIALDPTTYPES to DPT_ROLE;
grant SELECT                                                                 on V_SOCIALDPTTYPES to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_SOCIALDPTTYPES to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on V_SOCIALDPTTYPES to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_SOCIALDPTTYPES.sql =========*** End *
PROMPT ===================================================================================== 
