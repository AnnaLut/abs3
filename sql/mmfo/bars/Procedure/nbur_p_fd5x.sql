CREATE OR REPLACE PROCEDURE BARS.NBUR_P_FD5X (
                                          p_kod_filii        varchar2
                                          , p_report_date    date
                                          , p_form_id        number
                                          , p_scheme           varchar2 default 'C'
                                          , p_file_code        varchar2 default 'D5X'
                                        )
is
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION : Процедура формирования D5X для Ощадного банку
% COPYRIGHT   : Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
%
% VERSION     :  v.1.001 05/09/2018 (28/08/2018)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
  ver_                   char(30)  := 'v.1.001  05/09/2018';
  c_title                constant varchar2(100 char) := $$PLSQL_UNIT || '. ';
  c_date_fmt             constant varchar2(10 char) := 'dd.mm.yyyy';
  c_old_file_code        constant varchar2(3 char) := '#D5';
  c_sleep_time           constant number := 30; --Время ожидания между тактами проверки

  l_nbuc                 varchar2(20);
  l_type                 number;
  l_datez                date := p_report_date + 1;
  l_file_code            varchar2(2) := substr(p_file_code, 2, 2);
  l_version_id           nbur_lst_files.version_id%type;
  l_next_mnth_frst_dt    date;
  l_ret                  number;
    
  c_XXXXXX               constant varchar2(6 char) := 'XXXXXX';
  
  --Exeption
  e_ptsn_not_exsts exception;

  pragma exception_init( e_ptsn_not_exsts, -02149 );
BEGIN
  logger.info (c_title || ' begin for date = '||to_char(p_report_date, 'dd.mm.yyyy'));

  -- определение начальных параметров (код области или МФО или подразделение)
  nbur_files.P_PROC_SET(p_kod_filii, p_file_code, p_scheme, l_datez, 1, l_file_code, l_nbuc, l_type);
  
  execute immediate 'truncate table NBUR_TMP_DESC_EKP';
  
  --Очистка партиции для хранения детального протокола
  begin
    execute immediate 'alter table NBUR_LOG_FD5X truncate subpartition for ( to_date('''
                      || to_char(p_report_date,'YYYYMMDD')||''',''YYYYMMDD''), ''' || p_kod_filii || ''' )';
  exception
    when e_ptsn_not_exsts then
      null;
  end;

  --Определяем версию файла для хранения детальеного протокола
  l_version_id := coalesce(
                            f_nbur_get_run_version(
                                                    p_file_code => p_file_code
                                                    , p_kf => p_kod_filii
                                                    , p_report_date => p_report_date
                                                  )
                            , -1
                          );
  logger.trace(c_title || ' Версия формируемого файла - ' || l_version_id);

  l_next_mnth_frst_dt := last_day(trunc(p_report_date)) + 1;
  logger.trace(c_title || 'Определена первая дата следующего месяца - ' || to_char(l_next_mnth_frst_dt, c_date_fmt));

  -- очікуємо формування старого файлу
  nbur_waiting_form(p_kod_filii, p_report_date, c_old_file_code, c_title);   
  
  -- наповнення довідника для визначення кодів показників
  l_ret := f_nbur_get_ekp_d5x(l_datez);
  
  --Теперь сохрянем полученные данные в детальном протоколе
  insert into nbur_log_fd5x(report_date, kf, nbuc, version_id, ekp, ku, t020, r020, r011, r013, r030, k040, 
                            k072, k111, k140, f074, s032, s080, s183, s190, s241, s260, f048, t070, description, 
                            acc_id, acc_num, kv, maturity_date, cust_id, ref, nd, branch)
      select
             p_report_date /*report_date*/
             , p_kod_filii /*kf*/
             , p_kod_filii /*nbuc*/
             , l_version_id /*version_id*/
             , nvl(p.ekp, c_XXXXXX) /*ekp*/
             , f_get_ku_by_nbuc(t.nbuc) /*ku*/
             , t.seg_2 /*t020*/
             , t.seg_3 /*r020*/
             , t.seg_4 /*r011*/
             , coalesce(trim(s.r013), '0') r013 /*r013*/
             , coalesce(t.seg_12, '#') /*r030*/
             , coalesce(t.seg_13, '#') /*k040*/
             , coalesce(t.seg_6, '#') /*k072*/
             , t.seg_5 /*k111*/
             , t.seg_7 /*k140*/
             , decode(r.kol24, '101', '100', '010', '000', nvl(r.kol24, '000')) /*f074*/
             , t.seg_11 /*s032*/
             , t.seg_14 /*s080*/
             , t.seg_8 /*s183*/
             , coalesce(t.seg_17, '#') /*s190*/
             , case
                 when ac.mdate is null then '1'
                 when ac.mdate - p_report_date < 365 and ac.mdate > p_report_date then '1'
                 when ac.mdate - p_report_date > 365 and ac.mdate > p_report_date then '2'
                 when ac.mdate < p_report_date then 'Z'                      
                 else '1'                     
               end  /*s241*/
             , t.seg_15 /*s260*/
             , case
                 when i.metr is null and not (substr(t.seg_2, 4, 1) in ('6', '8', '9') or t.seg_2 in ('1607', '2607', '2627', '2657', '3570')) then '0'
                 when i.metr in (7, 9) or -- для овердрафтів ЮО
                      trim(n.txt) = 'Так' -- для МБДК
                 then '2'
                 else '3'
               end /*f048*/
             , to_number(t.znap) /*t070*/
             , t.comm /*description*/
             , t.acc /*acc_id*/
             , t.nls /*acc_num*/
             , t.kv /*kv*/
             , t.mdate /*maturity_date*/
             , t.rnk /*cust_id*/
             , t.ref /*ref*/
             , t.nd /*nd*/
             , t.tobo /*branch*/
      from   (
               select acc_num as nls
                      , kv
                      , field_code as kodp
                      , field_value as znap
                      , nbuc
                      , cust_id as rnk
                      , acc_id as acc
                      , ref
                      , description as comm
                      , nd
                      , maturity_date as mdate
                      , branch as tobo
                      , d.seg_01 as seg_1 /*L*/
                      , d.seg_02 as seg_2 /*D*/
                      , d.seg_03 as seg_3 /*BBBB*/
                      , d.seg_04 as seg_4 /*Z*/
                      , d.seg_05 as seg_5 /*LL*/
                      , d.seg_06 as seg_6 /*OO*/
                      , d.seg_07 as seg_7/*O*/
                      , d.seg_08 as seg_8/*O*/
                      , d.seg_09 as seg_9/*R*/
                      , d.seg_10 as seg_10/*QQ*/
                      , d.seg_11 as seg_11/*?*/
                      , d.seg_12 as seg_12/*VVV*/
                      , d.seg_13 as seg_13/*MMM*/
                      , d.seg_14 as seg_14/*T*/
                      , d.seg_15 as seg_15/*AA*/
                      , d.seg_16 as seg_16/*N*/
                      , d.seg_17 as seg_17/*I*/
               from   v_nbur_#d5_dtl d
               where d.report_date = p_report_date and
                     d.kf = p_kod_filii and
                     (d.seg_01 = '1' and d.seg_02 in ('1', '2') and d.seg_16 = '2' -- залишки по рахунках 
                        or 
                      d.seg_01 = '1' and d.seg_02 in ('0') and d.seg_16 = '5' -- списання безнадійної заборгованості
                      ) 
             ) t
             join accounts ac 
             on (ac.kf = p_kod_filii and 
                 t.acc = ac.acc)
             left outer join int_accn i 
             on (i.kf = p_kod_filii and 
                 t.acc = i.acc)                 
             left outer join specparam s 
             on (s.kf = p_kod_filii and 
                 t.acc = s.acc)
             left outer join nd_txt n
             on (n.kf = p_kod_filii and 
                 n.nd = t.nd and
                 n.tag = 'FLR')
             left join (select r020, max(I010) I010
                          from   kl_r020
                          where  p_report_date between d_open and coalesce(d_close, date '4000-01-01')
                          group by
                                 r020
                       ) kl on (t.seg_3 = kl.r020)
             left join (select  t.acc
                                   , max(coalesce(trim(replace(replace(kol24, '[', ''), ']', '')), '#')) as kol24
                           from    rez_cr t
                           where   t.fdat = l_next_mnth_frst_dt
                           group by
                                   t.acc
                       ) r on (t.acc = r.acc)
             left join nbur_tmp_desc_ekp p
             on (p.I010 = kl.I010 and
                 p.t020 = t.seg_2 and
                 p.r020 = t.seg_3);

  logger.info(c_title || ' end for date = '||to_char(p_report_date, 'dd.mm.yyyy'));
END;
/