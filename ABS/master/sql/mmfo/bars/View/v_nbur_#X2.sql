

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_NBUR_#X2.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_NBUR_#X2 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_NBUR_#X2 ("REPORT_DATE", "KF", "VERSION_ID", "NBUC", "FIELD_CODE", "SEG_01", "SEG_02", "SEG_03", "FIELD_VALUE") AS 
  select p.REPORT_DATE
     , p.KF
     , p.VERSION_ID
     , p.NBUC
     , p.FIELD_CODE
     , SUBSTR(p.FIELD_CODE,1,2) as SEG_01
     , SUBSTR(p.FIELD_CODE,3,4) as SEG_02
     , SUBSTR(p.FIELD_CODE,7,3) as SEG_03
     , p.FIELD_VALUE
  from NBUR_AGG_PROTOCOLS_ARCH p
  join NBUR_REF_FILES f
    on ( f.FILE_CODE = p.REPORT_CODE )
  join NBUR_LST_FILES v
    on ( v.REPORT_DATE = p.REPORT_DATE and
         v.KF          = p.KF          and
         v.VERSION_ID  = p.VERSION_ID  and
         v.FILE_ID     = f.ID )           
 where p.REPORT_CODE = '#X2'
   and v.FILE_STATUS IN ( 'FINISHED', 'BLOCKED' );
   
comment on table V_NBUR_#X2 is 'Файл #X2 - Дані про концетрацію ризиків за пасивними операціями банку';
comment on column V_NBUR_#X2.REPORT_DATE is 'Звiтна дата';
comment on column V_NBUR_#X2.KF is 'Фiлiя';
comment on column V_NBUR_#X2.VERSION_ID is 'Номер версії файлу';
comment on column V_NBUR_#X2.NBUC is 'Код МФО/області';
comment on column V_NBUR_#X2.FIELD_CODE    is 'Код показника';
comment on column V_NBUR_#X2.SEG_01   is 'Сегмент DD';
comment on column V_NBUR_#X2.SEG_02 is 'Сегмент NNNN';
comment on column V_NBUR_#X2.SEG_03 is 'Сегмент 000';
comment on column V_NBUR_#X2.FIELD_VALUE   is 'Значення показника';   

PROMPT *** Create  grants  V_NBUR_#X2 ***
grant SELECT                                                                 on V_NBUR_#X2      to BARSREADER_ROLE;
grant SELECT                                                                 on V_NBUR_#X2      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_NBUR_#X2      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_NBUR_#X2.sql =========*** End *** ===
PROMPT ===================================================================================== 
