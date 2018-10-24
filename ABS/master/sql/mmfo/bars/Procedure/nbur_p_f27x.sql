CREATE OR REPLACE PROCEDURE BARS.NBUR_P_F27X (p_kod_filii        varchar2,
                                             p_report_date      date,
                                             p_form_id          number,
                                             p_scheme           varchar2 default 'C',
                                             p_balance_type     varchar2 default 'S',
                                             p_file_code        varchar2 default '27X')
is
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION : Процедура формирования 27X для Ощадного банку
% COPYRIGHT   : Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
%
% VERSION     :  v.1.104  23/10/2018 (14/08/2018)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
  ver_          char(30)  := 'v.1.104  23/10/2018';
  c_title       varchar2(100 char) := $$PLSQL_UNIT || '.';

  l_nbuc        varchar2(20);
  l_type        number;
  l_datez       date := p_report_date + 1;
  l_file_code   varchar2(2) := substr(p_file_code, 2, 2);
  l_koef        number; --Коэффициент обязательной продажи валюты
BEGIN
    logger.info (c_title || 'begin for date = '||to_char(p_report_date, 'dd.mm.yyyy'));

    -- определение начальных параметров (код области или МФО или подразделение)
    nbur_files.P_PROC_SET(p_kod_filii, p_file_code, p_scheme, l_datez, 0, l_file_code, l_nbuc, l_type);

    --Коефициент обязательной продажи
    if p_report_date < date '2017-04-05'
    then 
      l_koef := 0.65;
    else 
      l_koef := 0.50;
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
        SELECT d.report_date
               , d.kf
               , p_file_code
               , to_char(f_get_ku_by_nbuc(d.kf)) as nbuc
               , substr(d.colname, 2, 1)
                 || d.nbs
                 || lpad(d.kv, 3, '0')
                 as field_code
               , abs(d.value) field_value
               , NULL description
               , d.acc_id
               , d.acc_num
               , d.kv
               , null maturity_date
               , d.cust_id
               , null ref
               , NULL nd
               , d.branch
        FROM (
               SELECT  s.report_date
                       , s.kf
                       , a.cust_id
                       , a.acc_id
                       , a.acc_num
                       , a.kv
                       , a.nbs
                       , s.dos as s5
                       , s.kos as s6
                       , a.nbuc
                       , a.branch
              FROM     NBUR_DM_BALANCES_DAILY s
                       , NBUR_DM_ACCOUNTS a
              WHERE    s.report_date = p_report_date
                       and s.kf = p_kod_filii
                       and s.acc_id = a.acc_id
                       and a.report_date = p_report_date
                       and a.kf = p_kod_filii
                       and a.nbs = '2603'
                       and a.kv  NOT IN (980,959,961,962,964)
                       and s.dos+s.kos <> 0
            )
            UNPIVOT (VALUE FOR colname IN  (s5, s6)) d
        WHERE abs(d.value) <> 0;
    EXCEPTION
      WHEN OTHERS THEN
          logger.error(c_title || ' error on step 1: ' || SQLERRM || ' for date = ' || TO_CHAR (p_report_date, 'dd.mm.yyyy'));
    END;

    BEGIN
      insert into nbur_detail_protocols (report_date, kf, report_code, nbuc, field_code, field_value, description, acc_id, acc_num, kv, maturity_date, cust_id, REF, nd, branch)
        SELECT d.report_date
               , d.kf
               , p_file_code
               , to_char(f_get_ku_by_nbuc(a.kf)) as nbuc
               , '7' || d.nbs || lpad(d.kv, 3, '0') field_code
               , d.sump field_value
               , NULL description
               , d.acc_id
               , d.acc_num
               , d.kv
               , null maturity_date
               , d.cust_id
               , d.ref
               , NULL nd
               , null branch
        FROM   (
                   select t.report_date
                          , t.kf
                          , t.cust_id_db as cust_id
                          , t.acc_id_db as acc_id
                          , t.acc_num_db as acc_num
                          , t.r020_db nbs
                          , t.kv
                          , t.bal as sump
                          , t.ref
                   from   NBUR_DM_TRANSACTIONS t
                          , NBUR_DM_ADL_DOC_RPT_DTL r
                          , oper o
                   where  t.report_date = p_report_date
                          and t.kf = p_kod_filii
                          and r.report_date(+) = p_report_date
                          and r.kf(+) = p_kod_filii
                          and t.ref = r.ref(+)
                          and t.ref = o.ref
                          and t.kv not in (980, 959, 961, 962, 964)
                          and t.acc_num_db like '2603%'
                          and t.acc_num_cr not like '25%'
                          and t.acc_num_cr not like '26%'
                          and (
                                t.acc_num_cr like '2900%'
                                and t.ob22_cr = '04'
                                or r.d020 = '01'
                                or LOWER(o.nazn) like '%обов%прод%'
                                or LOWER(o.nazn) like '%об%зател%продаж%'
                                or LOWER(o.nazn) like '%внутр_шн_й переказ%'
                         )
                   union all
                   select t.report_date
                          , t.kf
                          , t.cust_id_db as cust_id
                          , t.acc_id_db as acc_id
                          , t.acc_num_db as acc_num
                          , t.r020_db as nbs
                          , t.kv
                          , t.bal as sump
                          , t.ref
                   from   NBUR_DM_TRANSACTIONS t
                   where  t.report_date = p_report_date
                          and t.kf = p_kod_filii
                          and t.kv not in (980, 959, 961, 962, 964)
                          and
                              (
                                t.acc_num_db like '2909%'
                                and t.ob22_cr in ('55','56','75')
                                and t.acc_num_cr like '2900%'
                                and t.ob22_cr = '01'
                                or
                                t.acc_num_db like '1919%'
                                and t.ob22_cr = '02'
                                and t.acc_num_cr like '3800%'
                                and t.ob22_cr = '10'
                             )
               ) d
               join NBUR_DM_ACCOUNTS a on (a.report_date = p_report_date)
                                          and (a.kf = p_kod_filii)
                                          and (a.acc_id = d.acc_id);
    EXCEPTION
      WHEN OTHERS THEN
        logger.error (c_title || ' error on step 2: ' || SQLERRM|| ' for date = ' || TO_CHAR (p_report_date, 'dd.mm.yyyy'));
    END;

    begin
      --Формирование показателя "зарахування надходження в іноземній валюті, що є базою для розрахунку суми обов'язкового продажу"
      insert into nbur_detail_protocols (report_date, kf, report_code, nbuc, field_code, field_value, description, acc_id, acc_num, kv, maturity_date, cust_id, REF, nd, branch)
        SELECT d.report_date
               , d.kf
               , p_file_code
               , to_char(f_get_ku_by_nbuc(a.kf)) as nbuc
               , '8' || d.nbs || lpad(d.kv, 3, '0') field_code
               , d.bal field_value
               , NULL description
               , d.acc_id
               , d.acc_num
               , d.kv
               , null maturity_date
               , d.cust_id
               , d.ref
               , NULL nd
               , null branch
        from   (
                 select t.report_date
                        , t.kf
                        , t.r020_cr nbs
                        , t.acc_id_cr as acc_id
                        , t.acc_num_cr as acc_num
                        , t.kv
                        , t.cust_id_cr as cust_id
                        , t.ref as ref
                        , (case 
                                when abs(nvl(round((z.s2 / l_koef), 0), 0) - t.bal)<10 then t.bal
                                when z.s2 is not null then nvl(round((z.s2 / l_koef), 0), 0)
                                else 0 
                          end) bal
                 from   nbur_dm_transactions t
                        left join zayavka z on (t.ref = z.refoper)
                                               and (z.dk = 2)
                                               and (z.obz = 1)
                 where  t.report_date = p_report_date
                        and t.kf = p_kod_filii
                        and t.R020_CR = '2603'
                        and t.kv <> 980
               ) d
               join NBUR_DM_ACCOUNTS a on (a.report_date = p_report_date)
                                          and (a.kf = p_kod_filii)
                                          and (a.acc_id = d.acc_id);
    exception
      when others then
        logger.error(c_title || ' error on step 3: '  || sqlerrm || ' for date = ' || TO_CHAR (p_report_date, 'dd.mm.yyyy'));
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
         FROM (
                SELECT report_date
                       , kf
                       , report_code
                       , nbuc
                       , field_code
                       , SUM (field_value) as field_value
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

    logger.info (c_title || 'end for date = '||to_char(p_report_date, 'dd.mm.yyyy'));
END;
/

