CREATE OR REPLACE PROCEDURE NBUR_P_F12X (
                                             p_kod_filii        varchar2
                                             , p_report_date    date
                                             , p_form_id        number
                                             , p_scheme         varchar2 default 'C'
                                             , p_balance_type   varchar2 default 'S'
                                             , p_file_code      varchar2 default '12X'
                                        )
is
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION : Процедура формирования 12X для Ощадного банку
% COPYRIGHT   : Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
%
% VERSION     :  v.1.000  06.06.2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
  ver_                 char(30)  := 'v.1.000  06.06.2018';
  c_title              constant varchar2(100 char) := $$PLSQL_UNIT || '.';
  c_int_file_code      constant varchar2(3 char) := '@12';
  c_ekp_A12001         constant varchar2(6 char) := 'A12001';
  c_ekp_A12002         constant varchar2(6 char) := 'A12002';
  c_ekp_A12003         constant varchar2(6 char) := 'A12003';
  c_ekp_A12004         constant varchar2(6 char) := 'A12004';

  l_nbuc               varchar2(20);
  l_type               number;
  l_datez              date := p_report_date + 1;
  l_file_code          varchar2(2) := substr(p_file_code, 2, 2);
  l_date_beg           date := nbur_files.f_get_date (p_report_date, 1);
BEGIN
    logger.info (c_title || ' begin for date = '||to_char(p_report_date, 'dd.mm.yyyy'));

    -- определение начальных параметров (код области или МФО или подразделение)
    nbur_files.P_PROC_SET(p_kod_filii, p_file_code, p_scheme, l_datez, 0, l_file_code, l_nbuc, l_type);

    BEGIN
       --Вставка данных из внутреннего файла
       INSERT INTO nbur_detail_protocols (
                                           report_date
                                           , kf
                                           , report_code
                                           , nbuc
                                           , field_code
                                           , field_value
                                           , description
                                           , acc_id
                                           , acc_num
                                           , kv
                                           , maturity_date
                                           , cust_id
                                           , REF
                                           , nd
                                           , branch
                                         )
        select
              p_report_date
              , a.kf
              , p_file_code
              , (case when l_type = 0 then l_nbuc else a.nbuc end) nbuc
              ,
              case
                when a.field_code in ('02', '05', '12', '14', '16', '17', '29', '30', '31', '32', '33', '37', '39') then c_ekp_A12001
                when a.field_code in ('40', '45', '46', '50', '53', '55', '56', '58', '59', '60', '61', '66', '67', '72') then c_ekp_A12002
              end
              || a.field_code
              || f_get_ku_by_nbuc(a.nbuc) as field_code
              , a.field_value
              , a.description
              , a.acc_id
              , a.acc_num
              , a.kv
              , a.maturity_date
              , a.cust_id
              , a.REF
              , a.nd
              , a.branch
        from  nbur_detail_protocols_arch a
        where a.report_date between l_date_beg and p_report_date
              and a.kf = p_kod_filii
              and a.report_code = c_int_file_code
              and a.version_id = (
                                   select l.version_id
                                   from   nbur_lst_files l
                                          , nbur_ref_files r
                                   where l.report_date = a.report_date
                                         and l.kf = a.kf
                                         and l.file_status = 'FINISHED'
                                         and l.file_id = r.id
                                         and r.FILE_CODE = c_int_file_code
                               )
              and a.field_code in (
                                     '02', '05', '12', '14', '16', '17', '29', '30', '31', '32', '33', '37'
                                     , '39', '40', '45', '46', '50', '53', '55', '56', '58', '59', '60', '61', '66', '67', '72'
                         );

    EXCEPTION
      WHEN OTHERS THEN
        logger.info (c_title ||  ' Error on cash_symbol step : ' || dbms_utility.format_error_backtrace || ' for date = ' || TO_CHAR (p_report_date, 'dd.mm.yyyy'));
    END;

    --Залишок операційної каси на початок звітного періоду
    BEGIN
      INSERT INTO nbur_detail_protocols (
                                            report_date
                                            , kf
                                            , report_code
                                            , nbuc
                                            , field_code
                                            , field_value
                                            , description
                                            , acc_id
                                            , acc_num
                                            , kv
                                            , maturity_date
                                            , cust_id
                                            , REF
                                            , nd
                                            , branch
                                        )
        select p_report_date
               , a.kf
               , p_file_code
               , a.nbuc
               , c_ekp_A12003
                 || a.field_code
                 || f_get_ku_by_nbuc(a.nbuc) as  field_code
               , a.field_value
               , a.description
               , a.acc_id
               , a.acc_num
               , a.kv
               , a.maturity_date
               , a.cust_id
               , a.REF
               , a.nd
               , a.branch
        from   nbur_detail_protocols_arch a
        where  a.report_date = l_date_beg
               and a.kf = p_kod_filii
               and a.report_code = c_int_file_code
               and a.version_id = (
                                    select max(l.version_id)
                                    from   nbur_lst_files l
                                           , nbur_ref_files r
                                    where  l.report_date = a.report_date
                                           and l.kf = a.kf
                                           and l.file_status in ('FINISHED', 'INVALID')
                                           and l.file_id = r.id
                                           and r.FILE_CODE = c_int_file_code
                                )
               and a.field_code in ('35');
    EXCEPTION
      WHEN OTHERS THEN
        logger.info (c_title ||  ' Error on period begin step : ' || dbms_utility.format_error_backtrace || ' for date = ' || TO_CHAR (p_report_date, 'dd.mm.yyyy'));
    END;

    --Залишок операційної каси  на кінець звітного періоду
    BEGIN
      INSERT INTO nbur_detail_protocols (
                                           report_date
                                           , kf
                                           , report_code
                                           , nbuc
                                           , field_code
                                           , field_value
                                           , description
                                           , acc_id
                                           , acc_num
                                           , kv
                                           , maturity_date
                                           , cust_id
                                           , REF
                                           , nd
                                           , branch
                                        )
        select p_report_date
               , a.kf
               , p_file_code
               , a.nbuc
               , c_ekp_A12004
                 || a.field_code
                 || f_get_ku_by_nbuc(a.nbuc) as field_code
               , a.field_value
               , a.description
               , a.acc_id
               , a.acc_num
               , a.kv
               , a.maturity_date
               , a.cust_id
               , a.REF
               , a.nd
               , a.branch
        from   nbur_detail_protocols_arch a
        where  a.report_date = p_report_date
               and a.kf = p_kod_filii
               and a.report_code = c_int_file_code
               and a.version_id = (
                                  select max(l.version_id)
                                  from   nbur_lst_files l
                                         , nbur_ref_files r
                                  where  l.report_date = a.report_date
                                         and l.kf = a.kf
                                         and l.file_status in ('FINISHED', 'INVALID')
                                         and l.file_id = r.id
                                         and r.FILE_CODE = c_int_file_code
                               )
               and a.field_code in ('70');
    EXCEPTION
      WHEN OTHERS THEN
        logger.info (c_title ||  ' Error on period end step : ' || dbms_utility.format_error_backtrace || ' for date = ' || TO_CHAR (p_report_date, 'dd.mm.yyyy'));
    END;

    commit;

    -- формирование показателей файла  в  nbur_agg_protocols
    INSERT INTO nbur_agg_protocols (
                                     report_date
                                     , kf
                                     , report_code
                                     , nbuc
                                     , field_code
                                     , field_value
                                   )
       SELECT report_date
              , kf
              , report_code
              , nbuc
              , field_code
              , field_value
         FROM (
                 SELECT report_date
                        , kf
                        , report_code
                        , nbuc
                        , field_code
                        , SUM (field_value) field_value
                 FROM   nbur_detail_protocols
                 WHERE  report_date = p_report_date
                        AND report_code = p_file_code
                        AND kf = p_kod_filii
               GROUP BY report_date
                        , kf
                        , report_code
                        , nbuc
                        , field_code
              );

    logger.info (c_title || ' end for date = '||to_char(p_report_date, 'dd.mm.yyyy'));

END NBUR_P_F12X;
/
