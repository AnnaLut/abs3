

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_#3E.sql =========*** Run *** ========
PROMPT ===================================================================================== 


PROMPT *** Create  view V_#3E ***

  CREATE OR REPLACE FORCE VIEW BARS.V_#3E ("REPORT_DATE", "KF", "VERSION_ID", "F017_2", "F018_2", "IDK014", "IDR030", "IDS031", "K020_2", "KU_2", "Q001_4", "Q001_5", "Q001_6", "Q002_4", "Q002_5", "Q002_6", "Q003_1", "Q003_2", "Q003_3", "Q003_5", "Q007_1", "Q007_2", "Q007_5", "Q007_6", "Q007_7", "Q007_8", "Q015_3", "Q015_4", "Q020_3", "S080_1", "S080_2", "T070_10", "T070_11", "T070_12", "T070_13", "T070_14", "T070_15", "T070_16", "T070_17", "T071") AS 
  select v.REPORT_DATE
     , v.KF
     , v.VERSION_ID
     , extractValue( COLUMN_VALUE, 'DATA/F017_2'  ) as F017_2
     , extractValue( COLUMN_VALUE, 'DATA/F018_2'  ) as F018_2
     , extractValue( COLUMN_VALUE, 'DATA/IDK014'  ) as IDK014
     , extractValue( COLUMN_VALUE, 'DATA/IDR030'  ) as IDR030
     , extractValue( COLUMN_VALUE, 'DATA/IDS031'  ) as IDS031
     , extractValue( COLUMN_VALUE, 'DATA/K020_2'  ) as K020_2
     , extractValue( COLUMN_VALUE, 'DATA/KU_2'    ) as KU_2
     , extractValue( COLUMN_VALUE, 'DATA/Q001_4'  ) as Q001_4
     , extractValue( COLUMN_VALUE, 'DATA/Q001_5'  ) as Q001_5
     , extractValue( COLUMN_VALUE, 'DATA/Q001_6'  ) as Q001_6
     , extractValue( COLUMN_VALUE, 'DATA/Q002_4'  ) as Q002_4
     , extractValue( COLUMN_VALUE, 'DATA/Q002_5'  ) as Q002_5
     , extractValue( COLUMN_VALUE, 'DATA/Q002_6'  ) as Q002_6
     , extractValue( COLUMN_VALUE, 'DATA/Q003_1'  ) as Q003_1
     , extractValue( COLUMN_VALUE, 'DATA/Q003_2'  ) as Q003_2
     , extractValue( COLUMN_VALUE, 'DATA/Q003_3'  ) as Q003_3
     , extractValue( COLUMN_VALUE, 'DATA/Q003_5'  ) as Q003_5
     , extractValue( COLUMN_VALUE, 'DATA/Q007_1'  ) as Q007_1
     , extractValue( COLUMN_VALUE, 'DATA/Q007_2'  ) as Q007_2
     , extractValue( COLUMN_VALUE, 'DATA/Q007_5'  ) as Q007_5
     , extractValue( COLUMN_VALUE, 'DATA/Q007_6'  ) as Q007_6
     , extractValue( COLUMN_VALUE, 'DATA/Q007_7'  ) as Q007_7
     , extractValue( COLUMN_VALUE, 'DATA/Q007_8'  ) as Q007_8
     , extractValue( COLUMN_VALUE, 'DATA/Q015_3'  ) as Q015_3
     , extractValue( COLUMN_VALUE, 'DATA/Q015_4'  ) as Q015_4
     , extractValue( COLUMN_VALUE, 'DATA/Q020_3'  ) as Q020_3
     , extractValue( COLUMN_VALUE, 'DATA/S080_1'  ) as S080_1
     , extractValue( COLUMN_VALUE, 'DATA/S080_2'  ) as S080_2
     , extractValue( COLUMN_VALUE, 'DATA/T070_10' ) as T070_10
     , extractValue( COLUMN_VALUE, 'DATA/T070_11' ) as T070_11
     , extractValue( COLUMN_VALUE, 'DATA/T070_12' ) as T070_12
     , extractValue( COLUMN_VALUE, 'DATA/T070_13' ) as T070_13
     , extractValue( COLUMN_VALUE, 'DATA/T070_14' ) as T070_14
     , extractValue( COLUMN_VALUE, 'DATA/T070_15' ) as T070_15
     , extractValue( COLUMN_VALUE, 'DATA/T070_16' ) as T070_16
     , extractValue( COLUMN_VALUE, 'DATA/T070_17' ) as T070_17
     , extractValue( COLUMN_VALUE, 'DATA/T071'    ) as T071
  from NBUR_REF_FILES f
     , NBUR_LST_FILES v
     , table( XMLSequence( XMLType( v.FILE_BODY ).extract('/NBUSTATREPORT/DATA') ) ) t
 where f.ID        = v.FILE_ID
   and f.FILE_CODE = '#3E'
   and f.FILE_FMT  = 'XML'
   and v.FILE_STATUS IN ( 'FINISHED', 'BLOCKED' )
;

PROMPT *** Create  grants  V_#3E ***
grant SELECT                                                                 on V_#3E           to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_#3E.sql =========*** End *** ========
PROMPT ===================================================================================== 
