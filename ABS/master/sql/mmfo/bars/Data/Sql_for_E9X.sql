SET DEFINE OFF;
begin
    delete from NBUR_REF_PREPARE_XML where FILE_CODE = 'E9X';
    Insert into NBUR_REF_PREPARE_XML
       (FILE_CODE, DESC_XML, DATE_START)
     Values
       ('E9X', 'select 
                (case 
                 when ekp_3 = ''42'' or ekp_2=''1'' and ekp_9 =''804'' and ekp_11 in (''804'', ''000'') 
                      then ''AE9001''
                 when ekp_2=''1'' and ekp_9 <> ''804'' and ekp_11 in (''804'', ''000'') 
                      then ''AE9002''
                 when ekp_2=''1'' and ekp_3 <> ''42'' and ekp_9 =''804'' and ekp_11 <> ''804'' 
                      then ''AE9003''
                 when ekp_2=''2'' and ekp_9 <> ''804'' and ekp_11 =''804'' and d060_2 is not null 
                      then ''AE9004''
                 when ekp_2=''2'' and ekp_9!=''804'' and ekp_11 =''804'' 
                      then ''AE9005''
                 when ekp_2=''2'' and ekp_9 =''804'' and ekp_11!=''804'' and d060_2 is not null 
                      then ''AE9006''
                 when ekp_2=''2'' and ekp_9 =''804'' and ekp_11!=''804''   
                      then ''AE9007''
                 when ekp_2=''0''                                      
                      then ''AE9008''
                      else ''AE9000''
                 end) as ekp,
           ekp_3   as d060_1,
           ekp_6   as k020,
           ekp_5   as k021,
           ekp_4   as f001,
           ''#''     as f098,
           decode(ekp_8,''000'',''#'',ekp_8)             as r030,
           decode(ekp_9,''000'',''#'',ekp_9)             as k040_1,
           decode(ekp_10,''000'',''#'',ltrim(ekp_10,''0''))  as ku_1,
           decode(ekp_11,''000'',''#'',ekp_11)             as k040_2,
           decode(ekp_12,''000'',''#'',ltrim(ekp_12,''0''))  as ku_2,
           t071                as t071,
           t080                as t080,
           decode(d060_2, null,''#'', d060_2)  d060_2,
           q001
      from (select substr(ekp_2,1,1) ekp_2
                 , substr(ekp_2,2,2) ekp_3  -- код системи переказів
                 , substr(ekp_2,4,1) ekp_4
                 , substr(ekp_2,5,1) ekp_5
                 , substr(ekp_2,6,10) ekp_6  -- ekp_7 немає в коді ekp_2
                 , substr(ekp_2,16,3) ekp_8  -- код валюти
                 , substr(ekp_2,19,3) ekp_9  -- код країни відправника
                 , substr(ekp_2,22,3) ekp_10 -- код регіону відправника
                 , substr(ekp_2,25,3) ekp_11 -- код країни отримувача
                 , substr(ekp_2,28,3) ekp_12 -- код регіону отримувача
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
                             and  report_code = ''E9X''           --Код отчета
                       )
                        pivot
                       ( max(trim(field_value))
                            for ekp_1 in ( ''1'' as T071, ''3'' as T080,
                                           ''8'' as D060_2, ''9'' as Q001 )
                       )
                )', TO_DATE('01/01/2018 00:00:00', 'MM/DD/YYYY HH24:MI:SS'));
    COMMIT;
END;
/