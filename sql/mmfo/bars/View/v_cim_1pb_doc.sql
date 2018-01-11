

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CIM_1PB_DOC.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CIM_1PB_DOC ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CIM_1PB_DOC ("REF_CA", "KF", "REF_RU", "MFOA", "NLSA", "VDAT", "KV", "S", "NAZN", "KOD_N_CA", "KOD_N_RU", "KOD_N_RU_TXT", "DECLARATION", "CL_TYPE", "CL_IPN", "CL_NAME", "CHANGED", "MD", "OUR_IPN") AS 
  SELECT t.ref_ca,
          t.kf,
          t.ref_ru,
          t.mfoa,
          t.nlsa,
          t.vdat,
          t.kv,
          t.s,
          t.nazn_ru,
          case when F_OURMFO <> '300465' then t.kod_n_ca else w.VALUE end,
          t.kod_n_ru,
          r.transdesc,
             '|'
          || (SELECT transdesc
                FROM bopcode
               WHERE transcode = w.VALUE)
          || '|4|'
          || t.cl_type
          || '|'
          || t.cl_ipn
          || '|'
          || t.cl_name
             AS declaration,
          t.cl_type,
          t.cl_ipn,
          t.cl_name,
          t.changed,
          t.md,
          CASE
             WHEN t.cl_ipn IN
                     ('09303328',
                      '09305480',
                      '09334702',
                      '09311380',
                      '09312190',
                      '02760363',
                      '09336500',
                      '09323408',
                      '09304612',
                      '09325703',
                      '09326464',
                      '09328601',
                      '09331508',
                      '09333401',
                      '09337356',
                      '09338500',
                      '09351600',
                      '02766367',
                      '09315357',
                      '02767059',
                      '09353504',
                      '09356307',
                      '09322277',
                      '00032129')
             THEN
                1
             ELSE
                0
          END
             AS our_ipn
     FROM cim_1pb_ru_doc t
          LEFT OUTER JOIN operw w
             ON w.tag = 'KOD_N' AND w.REF = t.ref_ca
          LEFT OUTER JOIN bopcode r
             ON r.transcode = t.kod_n_ru AND t.kod_n_ru IS NOT NULL
    WHERE t.kf = F_OURMFO OR F_OURMFO = '300465' OR F_OURMFO IS NULL;

PROMPT *** Create  grants  V_CIM_1PB_DOC ***
grant SELECT,UPDATE                                                          on V_CIM_1PB_DOC   to BARS_ACCESS_DEFROLE;
grant SELECT,UPDATE                                                          on V_CIM_1PB_DOC   to CIM_ROLE;
grant SELECT                                                                 on V_CIM_1PB_DOC   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CIM_1PB_DOC.sql =========*** End *** 
PROMPT ===================================================================================== 
