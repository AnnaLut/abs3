CREATE OR REPLACE FORCE VIEW BARS.V_OB_CORP_SALDO_DOCS
as
                  SELECT 
                  a.sess_id,
                  a.fdat,
                  a.kf,
                  a.acc,
                  d.ref,
                  r.ord,
                  r.name,
                  A.corp_id,
                  (select corporation_name from ob_corporation c where a.corp_id = c.id and c.parent_id is null) as corp_name,
                  CASE
                     WHEN d.dk = 0 THEN d.okpoa
                     WHEN d.dk = 1 THEN d.okpob
                     ELSE '0'
                  END
                     AS okpo,
                  a.kod_ustan,
                  a.nls,
                  a.kod_analyt,
                  a.kv,
                  d.s/100 as s,
                  d.sq/100 as sq,
                  d.nd,
                  d.vob,
                  TO_CHAR (d.postdat, 'dd.mm.yyyy') AS d_doc,
                  TO_CHAR (d.postdat, 'hh24miss') AS t_doc,
                  d.postdat,
                  CASE
                     WHEN d.dk = 0 THEN '��'
                     WHEN d.dk = 1 THEN '��'
                     ELSE '0'
                  END
                     AS dk,
                  d.mfoa,
                  d.nlsa,
                  d.kva,
                  d.okpoa,
                  d.nama,
                  d.mfob,
                  d.nlsb,
                  d.kvb,
                  d.okpob,
                  d.namb,
                  d.tt,
                  d.nazn,
                  a.is_last
             FROM ob_corp_data_acc a
             join ob_corp_data_doc d on a.sess_id = d.sess_id 
                                     and a.kf = d.kf 
                                     and a.acc = d.acc
                  LEFT JOIN clim_mfo r ON d.KF = r.kf;
/
  GRANT SELECT ON BARS.V_OB_CORP_SALDO_DOCS TO CORP_CLIENT;
  GRANT SELECT ON BARS.V_OB_CORP_SALDO_DOCS TO BARS_ACCESS_DEFROLE;
/