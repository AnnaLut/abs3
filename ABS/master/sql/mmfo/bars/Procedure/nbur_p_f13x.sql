CREATE OR REPLACE PROCEDURE NBUR_P_F13X (
                                          p_kod_filii        varchar2
                                          , p_report_date    date
                                          , p_form_id        number
                                          , p_scheme         varchar2 default 'C'
                                          , p_balance_type   varchar2 default 'S'
                                          , p_file_code        varchar2 default '13X'
                                        )
is
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION : ѕроцедура формировани€ 13X дл€ ќщадного банку
% COPYRIGHT   : Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
%
% VERSION     :  v.1.002  07/02/2019 (07.06.2018)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
  ver_            constant char(30)  := 'v.1.002  07.02.2019';
  c_title         constant varchar2(50 char) := $$PLSQL_UNIT || '.';
  c_int_file_code constant varchar2(3 char) := '@12';
  c_SK_ZB         constant varchar2(10 char) := 'SK_ZB';

  c_ekp_A13001    constant varchar2(6 char) := 'A13001';
  c_ekp_A13002    constant varchar2(6 char) := 'A13002';
  c_ekp_A13003    constant varchar2(6 char) := 'A13003';
  c_ekp_A13004    constant varchar2(6 char) := 'A13004';
  c_ekp_A13005    constant varchar2(6 char) := 'A13005';
  c_ekp_A13006    constant varchar2(6 char) := 'A13006';
  c_ekp_A13007    constant varchar2(6 char) := 'A13007';

  l_nbuc          varchar2(20);
  l_type          number;
  l_datez         date := p_report_date + 1;
  l_file_code     varchar2(2) := substr(p_file_code, 2, 2);
  l_date_beg      date := nbur_files.f_get_date (p_report_date, 2);
  l_date_beg2     date;
BEGIN
  logger.info (c_title || ' begin for date = '||to_char(p_report_date, 'dd.mm.yyyy'));

  -- определение начальных параметров (код области или ћ‘ќ или подразделение)
  nbur_files.P_PROC_SET(p_kod_filii, p_file_code, p_scheme, l_datez, 0, l_file_code, l_nbuc, l_type);
  
  -- в перший йм≥с€ць року може бути особлив≥сть, що файл в реший робочий день не формують 
  if to_char(trunc(p_report_date, 'mm'), 'ddmm') = '0101' then
     l_date_beg2 := nbur_calendar.f_get_next_bank_date(l_date_beg, 1);
  end if;

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
             , kf
             , p_file_code
             , (case when l_type = 0 then l_nbuc else a.nbuc end) nbuc
             , case
                when a.field_code in ('02', '05', '12', '14', '16', '17', '29', '30', '31', '32', '33', '37', '39') then c_ekp_A13001
                when a.field_code in ('40', '45', '46', '50', '53', '55', '56', '58', '59', '60', '61', '66', '67', '72') then c_ekp_A13002
              end
              || a.field_code
              || f_get_ku_by_nbuc(a.nbuc) as field_code
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
      from   nbur_detail_protocols_arch a
      where report_date between l_date_beg and p_report_date
            and kf = p_kod_filii
            and report_code = c_int_file_code
            and version_id = (
                               select l.version_id
                               from   nbur_lst_files l
                                      , nbur_ref_files r
                               where  l.report_date = a.report_date
                                      and l.kf = a.kf
                                      and l.file_status = 'FINISHED'
                                      and l.file_id = r.id
                                      and r.FILE_CODE = c_int_file_code
                             ) and
           field_code in (
                             '02', '05', '12', '14', '16', '17', '29', '30', '31', '32', '33', '37', '39', '40'
                             , '45', '46', '50', '53', '55' , '56', '58', '59', '60', '61', '66', '67', '72' 
                         );

    EXCEPTION
      when others then
        logger.info (c_title ||  ' Error on cash_symbol step : ' || dbms_utility.format_error_backtrace || ' for date = ' || TO_CHAR (p_report_date, 'dd.mm.yyyy'));
    END;

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
               , kf
               , p_file_code
               , (case when l_type = 0 then l_nbuc else a.nbuc end)
               , c_ekp_A13003
                 || a.field_code
                 || f_get_ku_by_nbuc(a.nbuc) as field_code
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
        from   nbur_detail_protocols_arch a
        where  report_date = l_date_beg
               and kf = p_kod_filii
               and report_code = c_int_file_code
               and version_id = (
                                  select l.version_id
                                  from   nbur_lst_files l
                                         , nbur_ref_files r
                                  where  l.report_date = a.report_date
                                         and l.kf = a.kf
                                         and l.file_status = 'FINISHED'
                                         and l.file_id = r.id
                                         and r.FILE_CODE = c_int_file_code
                                )
               and field_code in ('35');
        
        -- €кщо н≥чого не маЇ, то пробуЇмо другу дату (ле лише дл€ 1-го м≥с€ц€
        if sql%rowcount = 0 and l_date_beg2 is not null then
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
                   , kf
                   , p_file_code
                   , (case when l_type = 0 then l_nbuc else a.nbuc end)
                   , c_ekp_A13003
                     || a.field_code
                     || f_get_ku_by_nbuc(a.nbuc) as field_code
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
            from   nbur_detail_protocols_arch a
            where  report_date = l_date_beg2
                   and kf = p_kod_filii
                   and report_code = c_int_file_code
                   and version_id = (
                                      select l.version_id
                                      from   nbur_lst_files l
                                             , nbur_ref_files r
                                      where  l.report_date = a.report_date
                                             and l.kf = a.kf
                                             and l.file_status = 'FINISHED'
                                             and l.file_id = r.id
                                             and r.FILE_CODE = c_int_file_code
                                    )
                   and field_code in ('35');
        end if;  
        
    EXCEPTION
      when others then
        logger.info (c_title ||  ' Error on period begin balance insert : ' || dbms_utility.format_error_backtrace || ' for date = ' || TO_CHAR (p_report_date, 'dd.mm.yyyy'));
    END;

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
               , kf
               , p_file_code
               , (case when l_type = 0 then l_nbuc else a.nbuc end)
               , c_ekp_A13004
                 || a.field_code
                 || f_get_ku_by_nbuc(a.nbuc) as field_code
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
        from   nbur_detail_protocols_arch a
        where  report_date = p_report_date
               and kf = p_kod_filii
               and report_code = c_int_file_code
               and version_id = (
                                  select l.version_id
                                  from   nbur_lst_files l
                                         , nbur_ref_files r
                                  where  l.report_date = a.report_date
                                         and l.kf = a.kf
                                         and l.file_status = 'FINISHED'
                                         and l.file_id = r.id
                                         and r.FILE_CODE = c_int_file_code
                                 )
               and field_code in ('70');
    EXCEPTION
      when others then
        logger.info (c_title ||  ' Error on period end balance insert : ' || dbms_utility.format_error_backtrace || ' for date = ' || TO_CHAR (p_report_date, 'dd.mm.yyyy'));
    END;

    --формирование внебалансовых символов из табл. OTCN_F13_ZBSK
    begin
      insert into nbur_detail_protocols (
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
               , kf
               , p_file_code
               , (case when l_type = 0 then l_nbuc else ac.nbuc end)
               , case
                   when a.field_code in ('84', '86', '87', '88') then c_ekp_A13005
                   when a.field_code in ('93', '94', '95') then c_ekp_A13006
                   when a.field_code in ('97') then c_ekp_A13007
                 end                
                 || a.field_code
                 || to_char(to_number(ac.nbuc)) as field_code
               , a.field_value
               , a.description
               , a.acc_id
               , ac.acc_num
               , a.kv
               , ac.maturity_date
               , ac.cust_id
               , a.REF
               , null as nd
               , a.branch
        from   (                                
                  SELECT 
                         lpad(to_char(NVL(t.SK_ZB, 0)), 2, 0) as field_code
                         , to_char(t.s) as field_value
                         , c_SK_ZB as description
                         , (
                             case 
                               when substr(t.nlsd, 1, 3) not in ('262','263') 
                                    and t.nlsd not like '2909%' 
                                    and t.nlsd not like '1911%' 
                             then 
                               t.acck 
                             else 
                               t.accd 
                             end
                           ) as acc_id                         
                         , t.kv 
                         , t.ref                         
                         , t.tobo as branch
                  FROM   otcn_f13_zbsk t
                  WHERE  t.kf = p_kod_filii
                         and t.fdat between l_date_beg and p_report_date
                         and coalesce(t.sk_zb, 0) > 0
               ) a        
               join nbur_dm_accounts ac on (ac.kf = p_kod_filii)
                                           and (a.acc_id = ac.acc_id)
         where a.field_code in ('84', '86', '87', '88', '93', '94', '95', '97');
    exception
      when others then
        logger.info (c_title ||  ' Error on off balance insert : ' || dbms_utility.format_error_backtrace || ' for date = ' || TO_CHAR (p_report_date, 'dd.mm.yyyy'));        
    end;

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
      FROM   (
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
               GROUP BY
                      report_date
                      , kf
                      , report_code
                      , nbuc
                      , field_code
             );

    logger.info (c_title || ' end for date = '||to_char(p_report_date, 'dd.mm.yyyy'));

END NBUR_P_F13X;
/
