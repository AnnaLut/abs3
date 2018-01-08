

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_NBUR_REF_XSD.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_NBUR_REF_XSD ***

  CREATE OR REPLACE FORCE VIEW BARS.V_NBUR_REF_XSD ("FILE_ID", "FILE_CODE", "FILE_NAME", "SCHEMA_DATE", "CHANGE_DATE", "XSD") AS 
  select f.ID, f.FILE_CODE, f.FILE_NAME, r.SCM_DT, r.CHG_DT
      , 't'||lower(SubStr(f.FILE_CODE,2,2))||'x.xsd'
  from NBUR_REF_FILES f
  left outer
  join NBUR_REF_XSD r
    on ( r.FILE_ID = f.ID )
 where f.FILE_TYPE = 1
   and f.FILE_FMT = 'XML'
;

PROMPT *** Create  grants  V_NBUR_REF_XSD ***
grant SELECT                                                                 on V_NBUR_REF_XSD  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_NBUR_REF_XSD  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_NBUR_REF_XSD.sql =========*** End ***
PROMPT ===================================================================================== 
