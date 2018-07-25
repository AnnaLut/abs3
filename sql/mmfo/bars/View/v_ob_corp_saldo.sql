CREATE OR REPLACE FORCE VIEW BARS.V_OB_CORP_SALDO
(
   SESS_ID,
   ACC,
   KF,
   FDAT,
   ORD,
   NAME,
   CORP_ID,
   CORPORATION_NAME,
   OKPO,
   KOD_USTAN,
   NLS,
   KOD_ANALYT,
   KV,
   OSTQ_IN,
   OBDBQ,
   OBKRQ,
   OSTQ_OUT,
   ALL_DOC,
   KILK_D,
   KILK_KR,
   IS_LAST
)
AS
   SELECT dat.sess_id,
          dat.acc,
          dat.kf,
          dat.fdat,
          r.ord,
          r.name,
          dat.corp_id,
          (select corporation_name from v_root_corporation cn where cn.external_id = dat.corp_id) as corporation_name,
          dat.okpo,
          dat.kod_ustan,
          dat.nls,
          dat.kod_analyt,
          dat.kv,
          (dat.ostq - dat.obkrq + dat.obdbq)/100 AS ostq_in,
          dat.obdbq/100 as obdbq,
          dat.obkrq/100 as obkrq,
          dat.ostq/100 AS ostq_out,
          (select count(*) 
       from ob_corp_data_doc d 
           where dat.ACC = d.acc 
           and dat.kf = d.kf 
           and dat.sess_id = d.sess_id) as all_doc,
   (select count(*) 
       from ob_corp_data_doc d 
           where dat.ACC = d.acc 
           and dat.kf = d.kf 
           and dat.sess_id = d.sess_id 
           and dk = 0) as kilk_d,
   (select count(*) 
       from ob_corp_data_doc d 
       where dat.ACC = d.acc 
           and dat.kf = d.kf 
           and dat.sess_id = d.sess_id 
           and dk = 1) as kilk_kr,
           dat.IS_LAST
          FROM OB_CORP_DATA_ACC dat
          LEFT JOIN clim_mfo r ON dat.KF = r.kf;
          /
          GRANT SELECT, FLASHBACK ON BARS.V_OB_CORP_SALDO TO BARS_ACCESS_DEFROLE;
          /
