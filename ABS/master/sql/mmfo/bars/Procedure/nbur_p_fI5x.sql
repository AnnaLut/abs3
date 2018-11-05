PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/NBUR_P_FI5X.sql =========*** Run *** =
PROMPT ===================================================================================== 

PROMPT *** Create  procedure NBUR_P_FI5X ***

CREATE OR REPLACE PROCEDURE NBUR_P_FI5X (
                                           p_kod_filii  varchar2
                                           , p_report_date      date
                                           , p_form_id          number
                                           , p_scheme           varchar2 default 'C'
                                           , p_file_code        varchar2 default 'I5X'
                                      )
is
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION : Процедура формирования I5X в формате XML для Ощадного банку
% COPYRIGHT   : Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
%
% VERSION     :  v.18.001 25/10/2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
  ver_                     char(30)  := 'v.18.001    25.10.2018';

  c_title                  constant varchar2(200 char) := $$PLSQL_UNIT;
  c_date_fmt               constant varchar2(10 char) := 'dd.mm.yyyy'; --Формат преобразования даты в строку
  c_amt_fmt                constant varchar2(50 char) := 'FM9999999999990D0000';  --Формат преобразования числа в строку
  c_old_file_code          constant varchar2(3 char) := '#D5';

  l_datez                  date := p_report_date + 1;
  l_nbuc                   varchar2(20 char);
  l_file_code              varchar2(2 char) := substr(p_file_code, 2, 2);
  l_type                   number;
  
  l_file_id       nbur_ref_files.id%type := nbur_files.GET_FILE_ID(p_file_code => p_file_code);
  l_version_id    nbur_lst_files.version_id%type;  
  
  l_next_mnth_frst_dt    date;
  l_ret                  number;

  c_ekp_tp2              constant varchar2(6 char) := 'AI54N6';
  c_XXXXXX               constant varchar2(6 char) := 'XXXXXX';
  
  --Exception
  e_ptsn_not_exsts exception;

  pragma exception_init( e_ptsn_not_exsts, -02149 );  
BEGIN
  logger.info (
                c_title
                || ' begin for'
                || ' date = ' || to_char(p_report_date, c_date_fmt)
                || ' kod_filii=' || p_kod_filii
                || ' form_id=' || p_form_id
                || ' p_scheme= ' || p_scheme
              );

  -- определение начальных параметров (код области или МФО или подразделение)
  nbur_files.P_PROC_SET(
                         p_kod_filii
                         , p_file_code
                         , p_scheme
                         , l_datez
                         , 0
                         , l_file_code
                         , l_nbuc
                         , l_type
                       );

  --Очистка партиции для хранения детального протокола
  begin
    execute immediate 'alter table NBUR_LOG_FI5X truncate subpartition for ( to_date('''
                      || to_char(p_report_date,'YYYYMMDD')||''',''YYYYMMDD''), ''' || p_kod_filii || ''' )';
  exception
    when e_ptsn_not_exsts then
      null;
  end;

  --Определяем версию файла для хранения детальеного протокола
  l_version_id := f_nbur_get_run_version(p_file_code => p_file_code
                                          , p_kf => p_kod_filii
                                          , p_report_date => p_report_date
                                        );

  logger.trace(c_title || ' Version_id is ' || l_version_id);
  
  -- очікуємо формування старого файлу
  nbur_waiting_form(p_kod_filii, p_report_date, c_old_file_code, c_title);  
  
      -- наповнення довідника для визначення кодів показників
  l_ret := f_nbur_get_ekp_xxx(p_file_code, l_datez);

  --Теперь сохрянем полученные данные в детальном протоколе
  insert into nbur_log_fi5x(report_date, kf, nbuc, version_id, ekp, ku, t020, r020, r011, r030, k040,
                            k072, k111, k140, f074, s032, s183, s241, s260, f048, t070, t090, 
                            acc_id, acc_num, kv, maturity_date, cust_id, nd, branch)
      select
             p_report_date /*report_date*/
             , p_kod_filii /*kf*/
         , p_kod_filii /*nbuc*/
         , l_version_id /*version_id*/
         , nvl((case when seg_2 = '6' then c_ekp_tp2 else p.ekp end), c_XXXXXX) /*ekp*/
         , f_get_ku_by_nbuc(t.nbuc) /*ku*/
         , t.seg_2 /*t020*/
         , t.seg_3 /*r020*/
         , t.seg_4 /*r011*/ 
         , coalesce(t.seg_12, '#') /*r030*/
         , coalesce(t.seg_13, '#') /*k040*/
         , coalesce(t.seg_6, '#') /*k072*/
         , t.seg_5 /*k111*/
         , t.seg_7 /*k140*/
         , (case when g.link_group is not null then '001'
                when r.kol24 = '101' then '100'
                when r.kol24 = '010' then '000'
                else nvl(r.kol24, '000')
            end) /*f074*/
         , t.seg_11 /*s032*/
         , t.seg_8 /*s183*/
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
         , max(to_number(t.T070)) /*t070*/
         , max(nvl(to_number(t.T090), 0)) /*t090*/
         , t.acc /*acc_id*/
         , t.nls /*acc_num*/
         , t.kv /*kv*/
         , t.mdate /*maturity_date*/
         , t.rnk /*cust_id*/
         , t.nd /*nd*/
         , t.tobo /*branch*/
  from   (select *
          from ( 
               select acc_num as nls
                      , kv
                      , field_code as kodp
                      , field_value as znap
                      , nbuc
                      , cust_id as rnk
                      , cust_code as okpo
                      , acc_id as acc
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
                     (d.seg_02 in ('1', '2') and d.seg_16 = '3' -- середні залишки по рахунках
                        or
                      d.seg_02 in ('6') and d.seg_16 = '4' -- визнані процентні доходи
                      )
                )
            pivot (max(znap) for seg_1 in ('1' as T070, '2' as T090)) 
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
                               , max(trim(replace(replace(kol24, '[', ''), ']', ''))) as kol24
                       from    rez_cr t
                       where   t.fdat = l_next_mnth_frst_dt
                       group by
                               t.acc
                   ) r on (t.acc = r.acc)
         left outer join d8_cust_link_groups g
         on (t.okpo = g.okpo or t.seg_9 = '2' and t.okpo = g.rnk)
         join nbur_tmp_desc_ekp p
         on (p.I010 = kl.I010 and
             p.t020 = t.seg_2 and
             p.r020 = t.seg_3 or t.seg_2 = '6')
         group by nvl((case when seg_2 = '6' then c_ekp_tp2 else p.ekp end), c_XXXXXX) /*ekp*/
         , f_get_ku_by_nbuc(t.nbuc) /*ku*/
         , t.seg_2 /*t020*/
         , t.seg_3 /*r020*/
         , t.seg_4 /*r011*/ 
         , coalesce(t.seg_12, '#') /*r030*/
         , coalesce(t.seg_13, '#') /*k040*/
         , coalesce(t.seg_6, '#') /*k072*/
         , t.seg_5 /*k111*/
         , t.seg_7 /*k140*/
         , (case when g.link_group is not null then '001'
                when r.kol24 = '101' then '100'
                when r.kol24 = '010' then '000'
                else nvl(r.kol24, '000')
            end) /*f074*/
         , t.seg_11 /*s032*/
         , t.seg_8 /*s183*/
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
         , t.acc /*acc_id*/
         , t.nls /*acc_num*/
         , t.kv /*kv*/
         , t.mdate /*maturity_date*/
         , t.rnk /*cust_id*/
         , t.nd /*nd*/
         , t.tobo /*branch*/
         ;

  logger.info (c_title || ' end for date = '||to_char(p_report_date, c_date_fmt));
END NBUR_P_FI5X;
/
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/NBUR_P_FI5X.sql =========*** End *** =
PROMPT ===================================================================================== 