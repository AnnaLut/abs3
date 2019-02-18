

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_EDS_CRT_LOG.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_EDS_CRT_LOG ***

  CREATE OR REPLACE FORCE VIEW BARS.V_EDS_CRT_LOG ("ID", "DECL_ID", "CRT_DATE", "STATE", "C_STATE", "OKPO", "BIRTH_DATE", "CUST_NAME", "DOC_TYPE", "DOC_SERIAL", "DOC_NUMBER", "DATE_FROM", "DATE_TO", "COMM", "DONEBY", "DONEBY_FIO", "BRANCH", "ADD_DATE", "ADD_FIO", "FIO", "KF") AS 
  SELECT 
   e.ID, 
   e.DECL_ID, 
   e.CRT_DATE, 
   e.STATE,
   s.name as c_state, 
   e.OKPO,
   e.BIRTH_DATE, 
   e.CUST_NAME, 
   e.DOC_TYPE, 
   e.DOC_SERIAL, 
   e.DOC_NUMBER, 
   e.DATE_FROM, 
   e.DATE_TO, 
   e.COMM, 
   e.DONEBY,
   e.DONEBY_FIO, 
   e.BRANCH, 
   p.ADD_DATE, 
   p.ADD_ID as ADD_FIO,
   b.fio,  
   substr(e.BRANCH, 2, 6) as KF
FROM BARS.EDS_DECL e
JOIN BARS.EDS_DECLS_POLICY p on e.id = p.id
left join EDS_CRT_LOG_STATE s on e.state = s.id
left join STAFF$BASE b on p.add_id = b.id
where p.add_id = user_id;

PROMPT *** Create  grants  V_EDS_CRT_LOG ***
grant SELECT                                                                 on V_EDS_CRT_LOG   to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_EDS_CRT_LOG.sql =========*** End *** 
PROMPT ===================================================================================== 

