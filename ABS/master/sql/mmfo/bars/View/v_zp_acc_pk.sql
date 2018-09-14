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
   mfo,
   pass_serial,
   pass_num,
   pass_card,
   actual_date
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
          a.kf,
          case p.passp when 1 then p.ser else null end         as pass_serial,
          case p.passp when 1 then p.numdoc else null end      as pass_num,
          case p.passp when 7 then p.numdoc else null end      as pass_card,
          case p.passp when 7 then p.actual_date else null end as actual_date
     FROM bpk_proect b
          left join w4_product w on w.code = b.product_code and w.kf = b.kf
          left join zp_acc_pk z on z.id_bpk_proect = b.id
          inner join accounts a on a.acc = z.acc_pk
          inner join customer c on c.rnk = a.rnk
          inner join zp_deals d on d.id = z.id
          left join person p on p.rnk = c.rnk
/
grant select,delete,update,insert on bars.v_zp_acc_pk to bars_access_defrole;
/
