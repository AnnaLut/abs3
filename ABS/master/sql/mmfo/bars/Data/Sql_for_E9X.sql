SET DEFINE OFF;
begin
    delete from NBUR_REF_PREPARE_XML where FILE_CODE = 'E9X';
    Insert into NBUR_REF_PREPARE_XML
       (FILE_CODE, DESC_XML, DATE_START)
     Values
       ('E9X', 'select ekp, d060_1, k020, k021, f001, f098, r030,
               k040_1, ku_1, k040_2, ku_2, 
               sum(t071) as t071, sum(t080) as t080, 
               d060_2, q001
          from nbur_log_fe9x
          where  report_date = :p_rpt_dt         --Дата отчета
            and  kf = :p_kf                      --Филиал
          group by ekp, d060_1, k020, k021, f001, f098, r030,
               k040_1, ku_1, k040_2, ku_2, d060_2, q001', TO_DATE('01/01/2018 00:00:00', 'MM/DD/YYYY HH24:MI:SS'));
    COMMIT;
END;
/