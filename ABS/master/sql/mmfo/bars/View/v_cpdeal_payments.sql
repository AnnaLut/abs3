

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CPDEAL_PAYMENTS.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CPDEAL_PAYMENTS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CPDEAL_PAYMENTS ("CP_REF", "FDAT", "OP_REF", "TT", "DK", "ACC", "NLS", "ACCTYPE", "S", "SQ", "SOS", "TXT", "STMT") AS 
  SELECT t.cp_ref,
       fdat,
       op_ref,
       tt,
       dk,
       ACC,
       nls,
       CA.CP_ACCTYPE,
       s,
       sq,
       sos,
       txt,
       STMT
  FROM (  SELECT cp.cp_ref,
                 cp.op_ref,
                 op.*,
                 a.nls
            FROM cp_payments cp, opldok op, accounts a
           WHERE op.REF = cp.op_ref
             AND a.acc = op.acc
             and op.sos >= 0
        ORDER BY cp.cp_ref, op.REF) t
       LEFT JOIN cp_accounts ca ON t.ACC = CA.CP_ACC AND ca.cp_ref = t.cp_ref
order by 1,2;

PROMPT *** Create  grants  V_CPDEAL_PAYMENTS ***
grant SELECT                                                                 on V_CPDEAL_PAYMENTS to BARSREADER_ROLE;
grant DEBUG,DELETE,FLASHBACK,INSERT,MERGE VIEW,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on V_CPDEAL_PAYMENTS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CPDEAL_PAYMENTS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CPDEAL_PAYMENTS.sql =========*** End 
PROMPT ===================================================================================== 
