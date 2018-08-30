SET DEFINE OFF;
delete from BARS.NBUR_REF_PREPARE_XML 
where FILE_CODE in ('#3K', '#4P', '#6E', '02X', '12X', '13X', '1PX', '25X', '27X', '2KX', 
	'39X', '3AX', '48X', '73X', '81X', 'A7X', 'C5X', 'D4X', 'E8X', 'E9X', 'F1X');
	
Insert into BARS.NBUR_REF_PREPARE_XML
   (FILE_CODE, DESC_XML, DATE_START)
 Values
   ('#3K', 'select /* XML_RPT_3K */ ''A3K001'' as EKP
         , ekp_2                as Q003_1
         , F091                 as F091
         , R030                 as R030
         , T071                 as T071
         , K020                 as K020
         , K021                 as K021
         , Q001                 as Q001
         , Q024                 as Q024
         , D100                 as D100
         , S180                 as S180
         , F089                 as F089
         , F092                 as F092
         , Q003                 as Q003_2
         , Q007                 as Q007_1
         , Q006                 as Q006
  from ( select *
from ( select substr(kodp,5,3) ekp_2,
            substr(kodp,1,4) ekp_1, znap 
       from tmp_nbu
      where kodf = ''3K''
        and datf = :p_rpt_dt
        and kf = :p_kf
  )
   pivot
  ( max(trim(znap))
    for ekp_1 in ( ''F091'' as F091, ''R030'' as R030, ''T071'' as T071,
                   ''K020'' as K020, ''K021'' as K021, ''Q001'' as Q001,
                   ''Q024'' as Q024, ''D100'' as D100, ''S180'' as S180,
                   ''F089'' as F089, ''F092'' as F092, 
                   ''Q003'' as Q003, ''Q007'' as Q007, ''Q006'' as Q006 )
  ) )', TO_DATE('01/01/2018 00:00:00', 'MM/DD/YYYY HH24:MI:SS'));
  
Insert into BARS.NBUR_REF_PREPARE_XML
   (FILE_CODE, DESC_XML, DATE_START)
 Values
   ('#4P', 'select
      EKP
      , B040
      , R020
      , R030_1
      , R030_2
      , K040
      , S050
      , S184
      , F028
      , F045
      , F046
      , F047
      , F048
      , F049
      , F050
      , F052
      , F053
      , F054
      , F055
      , F056
      , F057
      , F070
      , K020
      , Q001_1
      , Q001_2
      , Q003_1
      , Q003_2
      , Q003_3
      , Q006
      , Q007_1
      , Q007_2
      , Q007_3
      , Q010_1
      , Q010_2
      , Q012
      , Q013
      , Q021
      , Q022
      , T071
from   nbur_log_f4px
where  report_date = :p_rpt_dt
      and kf = :p_kf', TO_DATE('01/01/2018 00:00:00', 'MM/DD/YYYY HH24:MI:SS'));
	  
Insert into BARS.NBUR_REF_PREPARE_XML
   (FILE_CODE, DESC_XML, DATE_START)
 Values
   ('#6E', 'select substr(t.FIELD_CODE, 1, 6) as EKP
      , substr(t.field_code, 7, 3) as R030
      , FIELD_VALUE as T100
from   NBUR_AGG_PROTOCOLS t
where  report_date = :p_rpt_dt
      and kf = :p_kf
      and report_code = ''#6E''
order by FIELD_CODE', TO_DATE('01/01/2018 00:00:00', 'MM/DD/YYYY HH24:MI:SS'));

Insert into BARS.NBUR_REF_PREPARE_XML
   (FILE_CODE, DESC_XML, DATE_START)
 Values
   ('02X', 'select EKP, KU, R020, T020, R030, K040
    , sum( T070 ) as T070
    , sum( T071 ) as T071
from NBUR_LOG_F02X
where REPORT_DATE = :p_rpt_dt
  and KF = :p_kf
group by EKP, KU, R020, T020, R030, K040', TO_DATE('01/01/2018 00:00:00', 'MM/DD/YYYY HH24:MI:SS'));

Insert into BARS.NBUR_REF_PREPARE_XML
   (FILE_CODE, DESC_XML, DATE_START)
 Values
   ('12X', 'select substr(field_code, 1, 6) as EKP --Реєстр показників
      , substr(field_code, 9, 2) as KU --Символи касових оборотів                  
      , substr(field_code, 7, 2) as D010 --Територія
      , field_value as T070 --Сума у нац.валюті
from   nbur_agg_protocols
where report_date = :p_rpt_dt
  and kf = :p_kf
  and report_code = ''12X''', TO_DATE('01/01/2018 00:00:00', 'MM/DD/YYYY HH24:MI:SS'));
  
Insert into BARS.NBUR_REF_PREPARE_XML
   (FILE_CODE, DESC_XML, DATE_START)
 Values
   ('13X', 'select 
      substr(field_code, 1, 6) as EKP --Реєстр показників
      , substr(field_code, 9, 2) as KU --Символи касових оборотів                  
      , substr(field_code, 7, 2) as D010 --Територія
      , field_value as T070 --Сума у нац.валюті
from   nbur_agg_protocols
where report_date = :p_rpt_dt
  and kf = :p_kf
  and report_code = ''13X''', TO_DATE('01/01/2018 00:00:00', 'MM/DD/YYYY HH24:MI:SS'));
  
Insert into BARS.NBUR_REF_PREPARE_XML
   (FILE_CODE, DESC_XML, DATE_START)
 Values
   ('1PX', 'select ''A1P001'' EKP
   , p.K040_1
   , p.RCBNK_B010
   , p.RCBNK_NAME
   , p.K040_2
   , p.R030
   , p.R020
   , p.R040
   , p.T023
   , p.RCUKRU_GLB_2
   , coalesce(p.K018, ''#'') as K018
   , p.K020
   , p.Q001
   , p.RCUKRU_GLB_1
   , p.Q003_1
   , p.Q004
   , case when t023 = 3 then 0 else 1 end T080
   , p.T071
from (select *
     from   (select t.seg_01 as dd
               , t.seg_02 as T023
               , t.seg_03 as K040_1
               , t.seg_04 as RCBNK_B010
               , t.seg_05 as R020
               , t.seg_06 as R030
               , t.seg_07 as R040
               , t.seg_08 as K040_2
               , t.seg_09 as Q003_1
               , trim(t.field_value) znap
               , t.nbuc
        from v_nbur_#1p t
        where report_date = :p_rpt_dt and
              kf = :p_kf) o
    pivot (max(znap) for dd in (''03'' as RCUKRU_GLB_1, 
                                ''04'' as K018, 
                                ''05'' as K020, 
                                ''06'' as Q001, 
                                ''07'' as RCUKRU_GLB_2, 
                                ''10'' as RCBNK_NAME, 
                                ''71'' as T071, 
                                ''99'' as Q004)
        )
   ) p', TO_DATE('01/01/2018 00:00:00', 'MM/DD/YYYY HH24:MI:SS'));
   
-- Insert into BARS.NBUR_REF_PREPARE_XML
   -- (FILE_CODE, DESC_XML, DATE_START)
 -- Values
   -- ('25X', 'select EKP, KU, R020, T020, R030, K040
    -- , sum( T070 ) as T070
    -- , sum( T071 ) as T071
-- from NBUR_LOG_F25X
-- where REPORT_DATE = :p_rpt_dt
  -- and KF = :p_kf
-- group by EKP, KU, R020, T020, R030, K040', TO_DATE('01/01/2018 00:00:00', 'MM/DD/YYYY HH24:MI:SS'));

Insert into BARS.NBUR_REF_PREPARE_XML
   (FILE_CODE, DESC_XML, DATE_START)
 Values
   ('27X', 'select ''A27001'' as EKP                     --Код показателя
       , t.nbuc as KU                      --Код области
       , substr(field_code, 2, 4) as R020  --Балансовый счета
       , substr(field_code, 6, 3) as R030  --Валюта
       , substr(field_code, 1, 1) as F091  --Код операції
       , field_value as T071               --Значение параметра
from   nbur_agg_protocols t
where  report_date = :p_rpt_dt              
       and kf = :p_kf                       
       and report_code = ''27X''              ', TO_DATE('01/01/2018 00:00:00', 'MM/DD/YYYY HH24:MI:SS'));
	   
Insert into BARS.NBUR_REF_PREPARE_XML
   (FILE_CODE, DESC_XML, DATE_START)
 Values
   ('2KX', 'select ''A2K001'' as EKP
       , Q003_1
       , Q001_1
       , Q002
       , K020_1
       , K021_1
       , Q003_2
       , Q003_3
       , Q030
       , Q006
       , F086
       , Q003_4
       , R030_1
       , Q007_1
       , Q007_2
       , Q031_1
       , T070_1
       , T070_2 
       , F088
       , Q007_3
       , Q003_5
       , Q001_2
       , K020_2
       , K021_2
       , Q001_3
       , T070_3
       , R030_2
       , Q032
       , Q031_2
from   (
          select substr(field_code, 1, 10) as zzzzzzzzzz
                 , substr(field_code, 11, 4) as nnnn
                 , substr(field_code, 15) as field_code
                 , field_value
          from   nbur_detail_protocols
          where  report_date = :p_rpt_dt
                 and kf = :p_kf
                 and report_code = ''2KX''
       )
pivot (max(field_value) for field_code in (
                                           ''Q003_1'' as Q003_1
                                           , ''Q001_1'' as Q001_1
                                           , ''Q002'' as Q002
                                           , ''K020_1'' as K020_1
                                           , ''K021_1'' as K021_1
                                           , ''Q003_2'' as Q003_2
                                           , ''Q003_3'' as Q003_3
                                           , ''Q030'' as Q030
                                           , ''Q006'' as Q006
                                           , ''F086'' as F086
                                           , ''Q003_4'' as Q003_4
                                           , ''R030_1'' as R030_1
                                           , ''Q007_1'' as Q007_1
                                           , ''Q007_2'' as Q007_2
                                           , ''Q031_1'' as Q031_1
                                           , ''T070_1'' as T070_1
                                           , ''T070_2'' as T070_2 
                                           , ''F088'' as F088
                                           , ''Q007_3'' as Q007_3
                                           , ''Q003_5'' as Q003_5
                                           , ''Q001_2'' as Q001_2
                                           , ''K020_2'' as K020_2
                                           , ''K021_2'' as K021_2
                                           , ''Q001_3'' as Q001_3
                                           , ''T070_3'' as T070_3
                                           , ''R030_2'' as R030_2
                                           , ''Q032'' as Q032
                                           , ''Q031_2'' as Q031_2
))', TO_DATE('01/01/2018 00:00:00', 'MM/DD/YYYY HH24:MI:SS'));

Insert into BARS.NBUR_REF_PREPARE_XML
   (FILE_CODE, DESC_XML, DATE_START)
 Values
   ('39X', 'select substr(t.FIELD_CODE, 2, 6) as EKP
    , t.nbuc as KU
    , substr(t.field_code, 8, 3) as R030
    , max(case when substr(field_code, 1, 1) = ''1'' then field_value end) as T071
    , max(case when substr(field_code, 1, 1) = ''4'' then field_value end) as T075
from NBUR_AGG_PROTOCOLS t
where report_date = :p_rpt_dt
  and kf = :p_kf
  and report_code = ''39X''
group by t.nbuc
     , substr(t.FIELD_CODE, 2, 6)
     , substr(t.field_code, 8, 3)', TO_DATE('01/01/2018 00:00:00', 'MM/DD/YYYY HH24:MI:SS'));
	 
Insert into BARS.NBUR_REF_PREPARE_XML
   (FILE_CODE, DESC_XML, DATE_START)
 Values
   ('3AX', 'select 
      EKP
      , KU
      , T020
      , R020
      , R011
      , R030
      , K030
      , S180
      , D020
      , sum(T070) as  T070
      , Round(sum(T070 * round(t090, 4)) / sum(T070), 4) as T090
from   nbur_log_f3ax
where  report_date = :p_rpt_dt
       and kf = :p_kf
group by      
      EKP
      , KU
      , T020
      , R020
      , R011
      , R030
      , K030
      , S180
      , D020', TO_DATE('01/01/2018 00:00:00', 'MM/DD/YYYY HH24:MI:SS'));
	  
Insert into BARS.NBUR_REF_PREPARE_XML
   (FILE_CODE, DESC_XML, DATE_START)
 Values
   ('48X', 'select 
    ekp
    , q003
    , q001
    , q002
    , q008
    , q029
    , k020
    , k021
    , k040
    , k110
    , t070
    , t080
    , t090_1
    , t090_2
    , t090_3
from  nbur_log_f48x
where report_date = :p_rpt_dt
    and kf = :p_kf', TO_DATE('01/01/2018 00:00:00', 'MM/DD/YYYY HH24:MI:SS'));
	
Insert into BARS.NBUR_REF_PREPARE_XML
   (FILE_CODE, DESC_XML, DATE_START)
 Values
   ('73X', 'select substr(field_code, 1, 6) as EKP  -- Код показателя
    , t.nbuc as KU                     -- Код области
    , substr(field_code, 7, 3) as R030 -- Валюта
    , field_value as T100              -- Значение параметра
from NBUR_AGG_PROTOCOLS t
where report_date = :p_rpt_dt           -- Дата отчета
  and kf = :p_kf                        -- Филиал
  and report_code = ''73X''', TO_DATE('01/01/2018 00:00:00', 'MM/DD/YYYY HH24:MI:SS'));
  
-- Insert into BARS.NBUR_REF_PREPARE_XML
   -- (FILE_CODE, DESC_XML, DATE_START)
 -- Values
   -- ('81X', 'select EKP, KU, R020, T020, R030, K040
    -- , sum( T070 ) as T070
    -- , sum( T071 ) as T071
-- from NBUR_LOG_F81X
-- where REPORT_DATE = :p_rpt_dt
  -- and KF = :p_kf
-- group by EKP, KU, R020, T020, R030, K040', TO_DATE('01/01/2018 00:00:00', 'MM/DD/YYYY HH24:MI:SS'));

Insert into BARS.NBUR_REF_PREPARE_XML
   (FILE_CODE, DESC_XML, DATE_START)
 Values
   ('A7X', 'select EKP
       , T020
       , R020
       , R011
       , R013
       , R030
       , K030
       , S181
       , S190
       , S240   
       , abs(sum(T070)) as T070
from   nbur_log_fa7x
where  report_date = :p_rpt_dt
       and kf = :p_kf
group by 
       EKP      
       , T020
       , R020
       , R011
       , R013
       , R030
       , K030
       , S181
       , S190
       , S240     
having sum(T070) <> 0', TO_DATE('01/01/2018 00:00:00', 'MM/DD/YYYY HH24:MI:SS'));

Insert into BARS.NBUR_REF_PREPARE_XML
   (FILE_CODE, DESC_XML, DATE_START)
 Values
   ('C5X', 'select 
   ekp
   , a012
   , t020
   , r020
   , r011
   , r013
   , r030_1
   , r030_2
   , r017
   , k077
   , s245
   , s580
   , sum(t070) as t070
from  nbur_log_fc5x t
where report_date = :p_rpt_dt
  and kf = :p_kf
group by
   ekp
   , a012
   , t020
   , r020
   , r011
   , r013
   , r030_1
   , r030_2
   , r017
   , k077
   , s245
   , s580
having sum(t070) <> 0', TO_DATE('01/01/2018 00:00:00', 'MM/DD/YYYY HH24:MI:SS'));

Insert into BARS.NBUR_REF_PREPARE_XML
   (FILE_CODE, DESC_XML, DATE_START)
 Values
   ('D4X', 'select ekp
       , r030
       , f025
       , b010
       , q006
       , sum(t071) as t071
from   nbur_log_fd4x
where  report_date = :p_rpt_dt
       and kf = :p_kf
       and ekp <> ''XXXXXX'' --Берем только замапленные значения
group by
       ekp
       , r030
       , f025
       , b010
       , q006       
having sum(t071) <> 0', TO_DATE('01/01/2018 00:00:00', 'MM/DD/YYYY HH24:MI:SS'));

Insert into BARS.NBUR_REF_PREPARE_XML
   (FILE_CODE, DESC_XML, DATE_START)
 Values
   ('E8X', 'select ''AE8001'' as EKP
    , K020
    , Q003_1
    , Q001
    , Q029
    , K074
    , K110
    , K040
    , KU_1
    , Q020
    , K014
    , Q003_2
    , Q007_1
    , Q007_2
    , T070_1
    , T070_2
    , T070_3
    , T070_4
    , T090 
    , R030
    , R020 
    , K021  
    , Q003_12    
from   (
  select *
  from   (select 
                  substr(field_code, 1, 10) as nnnn     
                   , substr(field_code, 11) as  field_code
                   , field_value
            from   nbur_detail_protocols
            where  report_date = :p_rpt_dt
                   and kf = :p_kf
                   and report_code = ''E8X''                                       
         )
  pivot (max(field_value) for field_code in (
                                              ''Q001'' as Q001
                                              , ''K020'' as K020
                                              , ''Q003_1'' as Q003_1
                                              , ''Q029'' as Q029
                                              , ''K074'' as K074
                                              , ''K110'' as K110
                                              , ''K040'' as K040
                                              , ''KU_1'' as KU_1
                                              , ''Q020'' as Q020
                                              , ''K014'' as K014
                                              , ''Q003_2'' as Q003_2
                                              , ''Q007_1'' as Q007_1
                                              , ''Q007_2'' as Q007_2
                                              , ''T070_1'' as T070_1
                                              , ''T070_2'' as T070_2
                                              , ''T070_3'' as T070_3
                                              , ''T070_4'' as T070_4
                                              , ''T090'' as T090 
                                              , ''R030'' as R030
                                              , ''R020'' as R020 
                                              , ''K021'' as K021  
                                              , ''Q003_12'' as Q003_12                                                          
                                            ))
)', TO_DATE('01/01/2018 00:00:00', 'MM/DD/YYYY HH24:MI:SS'));

Insert into BARS.NBUR_REF_PREPARE_XML
   (FILE_CODE, DESC_XML, DATE_START)
 Values
   ('E9X', 'select (case when ekp_2=''1'' and ekp_8 =''804'' and ekp_10 in (''804'', ''#'') then ''AE9001''
             when ekp_2=''1'' and ekp_8!=''804'' and ekp_10 in (''804'', ''#'') then ''AE9002''
             when ekp_2=''1'' and ekp_8 =''804'' and ekp_10!=''804''   then ''AE9003''
             when ekp_2=''2'' and ekp_8!=''804'' and ekp_10 =''804''
                            and d060_2 is not null               then ''AE9004''
             when ekp_2=''2'' and ekp_8!=''804'' and ekp_10 =''804''   then ''AE9005''
             when ekp_2=''2'' and ekp_8 =''804'' and ekp_10!=''804''
                            and d060_2 is not null               then ''AE9006''
             when ekp_2=''2'' and ekp_8 =''804'' and ekp_10!=''804''   then ''AE9007''
             when ekp_2=''0''                                      then ''AE9008''
             else ''AE9000''
         end)  as ekp,
       ekp_3   as d060_1,
       ekp_6   as k020,
       ekp_5   as k021,
       ekp_4   as f001,
       ''#''     as f098,
       decode(ekp_7,''000'',''#'',ekp_7)             as r030,
       decode(ekp_8,''000'',''#'',ekp_8)             as k040_1,
       decode(ekp_9,''000'',''#'',ltrim(ekp_9,''0''))  as ku_1,
       decode(ekp_10,''000'',''#'',ekp_10)             as k040_2,
       decode(ekp_11,''000'',''#'',ltrim(ekp_11,''0''))  as ku_2,
       t071                as t071,
       t080                as t080,
       decode(d060_2, null,''#'', d060_2)  d060_2,
       q001
  from (select substr(ekp_2,1,1) ekp_2
             , substr(ekp_2,2,2) ekp_3
             , substr(ekp_2,4,1) ekp_4
             , substr(ekp_2,5,1) ekp_5
             , substr(ekp_2,6,10) ekp_6
             , substr(ekp_2,16,3) ekp_7
             , substr(ekp_2,19,3) ekp_8
             , substr(ekp_2,22,3) ekp_9
             , substr(ekp_2,25,3) ekp_10
             , substr(ekp_2,28,3) ekp_11
             , nvl(t071,0)   t071
             , nvl(t080,0)   t080
             , d060_2
             , q001
              from ( SELECT    substr(field_code,1,1) ekp_1
                             , substr(field_code,2) ekp_2
                             , field_value
                        from  nbur_agg_protocols
                       where  report_date = :p_rpt_dt         --Дата отчета
                         and  kf = :p_kf                      --Филиал
                         and  report_code = ''E9X''             --Код отчета
                   )
                    pivot
                   ( max(trim(field_value))
                        for ekp_1 in ( ''1'' as T071, ''3'' as T080,
                                       ''8'' as D060_2, ''9'' as Q001 )
                   )
            )', TO_DATE('01/01/2018 00:00:00', 'MM/DD/YYYY HH24:MI:SS'));
			
Insert into BARS.NBUR_REF_PREPARE_XML
   (FILE_CODE, DESC_XML, DATE_START)
 Values
   ('F1X', 'select substr(field_code, 1, 6) as EKP    --Код показателя
       , f_get_ku_by_nbuc(t.nbuc) as KU   --Код области
       , substr(field_code, 7, 1) as K030 --Резидентность
       , substr(field_code, 8, 3) as R030 --Валюта
       , substr(field_code, 11, 3) as K040 --Код страны
       , field_value as T071         --Значение параметра
from   nbur_agg_protocols t
where  report_date = :p_rpt_dt           --Дата отчета
       and kf = :p_kf                    --Филиал
       and report_code = ''F1X''', TO_DATE('01/01/2018 00:00:00', 'MM/DD/YYYY HH24:MI:SS'));
COMMIT;
