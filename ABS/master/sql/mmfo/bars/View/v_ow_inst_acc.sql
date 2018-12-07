CREATE OR REPLACE FORCE VIEW BARS.V_OW_INST_ACC
(
   CHAIN_IDT,
   ACC,
   NLS,
   KV,
   TIP,
   NMS,
   DAOS,
   OSTF,
   DOS,
   KOS,
   OSTC,
   DAZS
)
AS
   SELECT t.chain_idt,
          a.acc,
          a.nls,
          a.kv,
          a.tip,
          a.nms,
          a.daos,
          NVL (s.ostf, 0) / 100 AS ostf,
          NVL (s.dos, 0) / 100 AS dos,
          NVL (s.kos, 0) / 100 kos,
          NVL (a.ostc, 0) / 100 AS ostc,
          a.dazs
     FROM ow_inst_totals t
          JOIN w4_acc_inst i ON t.chain_idt = i.chain_idt
          JOIN accounts a ON i.acc = a.acc AND i.kf = a.kf
          join (select se.acc,
                       max(se.ostf) KEEP (DENSE_RANK FIRST ORDER BY se.fdat desc) as ostf,
                       sum(se.dos) as dos, 
                       sum(se.kos) as kos
                 from saldoa se
                 group by se.acc) s on s.acc = i.acc;
/
GRANT SELECT ON BARS.V_OW_INST_ACC TO BARS_ACCESS_DEFROLE;
/