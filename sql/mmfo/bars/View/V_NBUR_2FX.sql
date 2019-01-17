

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_NBUR_2FX.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_NBUR_2FX ***

  CREATE OR REPLACE FORCE VIEW BARS.V_NBUR_2FX ("REPORT_DATE", "KF", "VERSION_ID", "FIELD_CODE", "EKP", "D110", "K014", "K019", "K030", "K040", "K044", "KU", "R030", "T070_1", "T070_2", "T100") AS 
  select   p.REPORT_DATE
       , p.KF
       , p.VERSION_ID
       , null  as field_code
       , p.EKP
       , p.D110
       , p.K014
       , p.K019
       , p.K030
       , p.K040
       , p.K044
       , p.KU
       , p.R030
       , p.T070_1
       , p.T070_2
       , p.T100
from   (select   v.REPORT_DATE
               , v.KF
               , v.version_id
               , extractValue( COLUMN_VALUE, 'DATA/EKP'   ) as EKP
               , extractValue( COLUMN_VALUE, 'DATA/D110'  ) as D110
               , extractValue( COLUMN_VALUE, 'DATA/K014'  ) as K014
               , extractValue( COLUMN_VALUE, 'DATA/K019'  ) as K019
               , extractValue( COLUMN_VALUE, 'DATA/K030'  ) as K030
               , extractValue( COLUMN_VALUE, 'DATA/K040'  ) as K040
               , extractValue( COLUMN_VALUE, 'DATA/K044'  ) as K044
               , extractValue( COLUMN_VALUE, 'DATA/KU'    ) as KU
               , extractValue( COLUMN_VALUE, 'DATA/R030'  ) as R030
               , extractValue( COLUMN_VALUE, 'DATA/T070_1') as T070_1
               , extractValue( COLUMN_VALUE, 'DATA/T070_2') as T070_2
               , extractValue( COLUMN_VALUE, 'DATA/T100'  ) as T100
         from   NBUR_REF_FILES f
              , NBUR_LST_FILES v
              , table( XMLSequence( XMLType( v.FILE_BODY ).extract('/NBUSTATREPORT/DATA') ) ) t
         where  f.ID        = v.FILE_ID
                and f.FILE_CODE = '2FX'
                and f.FILE_FMT  = 'XML'
                and v.FILE_STATUS IN ( 'FINISHED', 'BLOCKED' )
       ) p
 order by 2
;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_NBUR_2FX.sql =========*** End *** ===
PROMPT ===================================================================================== 
