CREATE OR REPLACE FORCE VIEW BARS.V_ZP_ACC_PK
(
   ACC,
   RNK,
   ID,
   ID_BPK_PROECT,
   DEAL_ID,
   OKPO,
   NMK,
   NLS,
   KV,
   CODE,
   NAME,
   OST,
   STATUS,
   mfo
)
AS
   SELECT a.acc,
          c.rnk,
          z.id,
          z.id_bpk_proect,
          d.deal_id,
          c.okpo,
          c.nmk,
          a.nls,
          a.kv,
          w.code,
          w.name,
          a.ostc / 100 ost,
          z.status,
          a.kf
     FROM bpk_proect b,
          w4_product w,
          zp_acc_pk z,
          accounts a,
          customer c,
          zp_deals d
    WHERE     b.product_code = w.code(+)
          AND z.id_bpk_proect = b.id(+)
          AND a.acc = z.acc_pk
          AND c.rnk = a.rnk
          AND d.id = z.id
          AND b.kf = w.kf(+);
/
grant select,delete,update,insert on bars.v_zp_acc_pk to bars_access_defrole;
/