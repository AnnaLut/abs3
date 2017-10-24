

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CIM_2909_DOC.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CIM_2909_DOC ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CIM_2909_DOC ("REF_CA", "REF", "VDAT", "MFOA", "NLSA", "NAM_A", "MFOB", "NLSB", "NAM_B", "KV", "S", "NAZN", "KF", "KOD_N", "DECLARATION", "CL_TYPE", "CL_IPN", "CL_NAME", "OUR_IPN", "CHANGED", "KOD_N_CA") AS 
  select a.ref_ca, a.ref_ru, a.vdat, a.mfoa, a.nlsa, a.nam_a, o.mfob, o.nlsb, o.nam_b, a.kv, a.s, o.nazn, o.kf, a.kod_n_ru,
       '|'||nvl(w.transdesc, ' ')||'|4|'||decode(c.custtype, 2, 'U', 3, case when c.sed='91' then 'S' else 'F' end)||'|'||c.okpo||'|'||decode(c.custtype, 2, c.nmkk, '') as declaration,
       decode(c.custtype, 2, 'U', 3, case when c.sed='91' then 'S' else 'F' end) as cl_type, c.okpo, decode(c.custtype, 2, c.nmkk, '') as cl_name,
       case when c.okpo in ('09303328','09305480','09334702','09311380','09312190','02760363','09336500','09323408','09304612','09325703','09326464','09328601','09331508','09333401',
                            '09337356','09338500','09351600','02766367','09315357','02767059','09353504','09356307','09322277','00032129') then 1 else 0 end as our_ipn, a.changed, a.kod_n_ca
  from cim_1pb_2909_doc_tmp d
       join cim_1pb_ru_doc a on a.ref=d.ref
       left outer join oper o on o.ref=a.ref_ru
       left outer join bopcode w on w.transcode=a.kod_n_ru
       left outer join accounts r on r.kv=o.kv and r.nls=o.nlsb
       left outer join customer c on c.rnk=r.rnk;

PROMPT *** Create  grants  V_CIM_2909_DOC ***
grant SELECT,UPDATE                                                          on V_CIM_2909_DOC  to BARS_ACCESS_DEFROLE;
grant SELECT,UPDATE                                                          on V_CIM_2909_DOC  to CIM_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CIM_2909_DOC.sql =========*** End ***
PROMPT ===================================================================================== 
