CREATE OR REPLACE PROCEDURE NBUR_P_FD4X (
                                          p_kod_filii        varchar2
                                          , p_report_date    date
                                          , p_form_id        number
                                          , p_scheme           varchar2 default 'C'
                                          , p_file_code        varchar2 default 'D4X'
                                        )
is
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION : Процедура формирования D4X для Ощадного банку
% COPYRIGHT   : Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
%
% VERSION     :  v.1.000  26/06/2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
  ver_              char(30)  := 'v.1.000  26/06/2018';
  c_title           constant varchar2(100 char) := $$PLSQL_UNIT || '.';  
  c_AD4001          constant varchar2(100 char) := 'AD4001';
  c_AD4002          constant varchar2(100 char) := 'AD4002';

  l_nbuc          varchar2(20);
  l_type          number;
  l_datez         date := p_report_date + 1;
  l_file_code     varchar2(2) := substr(p_file_code, 2, 2);
  l_version_id    nbur_lst_files.version_id%type;
  l_start_date    date;--Дата начала охвата

  --Exception
  e_ptsn_not_exsts exception;

  pragma exception_init( e_ptsn_not_exsts, -02149 );
BEGIN
  logger.info (c_title || ' begin for date = '||to_char(p_report_date, 'dd.mm.yyyy'));

  -- определение начальных параметров (код области или МФО или подразделение)
  nbur_files.P_PROC_SET(p_kod_filii, p_file_code, p_scheme, l_datez, 1, l_file_code, l_nbuc, l_type);

  l_start_date := trunc(p_report_date, 'MM');

  --Очистка партиции для хранения детального протокола
  begin
    execute immediate 'alter table NBUR_LOG_FD4X truncate subpartition for ( to_date('''
                      || to_char(p_report_date,'YYYYMMDD')||''',''YYYYMMDD''), ''' || p_kod_filii || ''' )';
  exception
    when e_ptsn_not_exsts then
      null;
  end;

  --Определяем версию файла для последующей связи детального и агрегированного протокола
  l_version_id := coalesce(
                            f_nbur_get_run_version(
                                                    p_file_code => p_file_code
                                                    , p_kf => p_kod_filii
                                                    , p_report_date => p_report_date
                                                  )
                            , -1
                          );

  logger.trace(c_title || ' Version_id is ' || l_version_id);

  insert into nbur_log_fd4x(report_date, kf, nbuc, version_id, ekp, r030, f025, b010, q006, t071, description, acc_id, acc_num, kv, maturity_date, cust_id, ref, nd, branch)
     select 
            p_report_date /*report_date*/
            , p_kod_filii /*kf*/
            , p_kod_filii /*nbuc*/
            , l_version_id /*version_id*/
            , case
                when dd in ('11', '12', '13', '14', '15', '16', '17', '18', '19', '20', '32', '34') then c_AD4001
                when dd in ('21', '22', '23', '24', '25', '26', '27', '28', '29', '30', '31', '33', '35') then c_AD4002
              else
                'XXXXXX'
              end /*ekp*/
            , lpad(kv, 3, '0') /*r030*/
            , dd /*f025*/
            , kb /*b010*/
            , null /*q006*/
            , bal /*t071*/ 
            , ' ' /*description*/
            , acc_id /*acc_id*/
            , acc_num /*acc_num*/
            , kv /*kv*/
            , null /*maturity_date*/
            , CUST_ID /*cust_id*/
            , REF /*ref*/
            , null /*nd*/
            , branch /*branch*/
      from   (  
                select  cust_id, tr.acc_id, tr.acc_num, tr.ref, tr.kv, tr.bal, tr.branch
                        , case
                            when tr.acc_id = tr.acc_id_db and tr.r020_cr like '3739%' and tr.dd = '00' then '31'
                            when tr.acc_id = tr.acc_id_cr and tr.r020_db like '3739%' and tr.dd = '00' then '13'                        
                          else
                            dd
                          end as dd                           
                        , case
                            when alt_bic is null or alt_bic = ' ' then '0000000000'
                          else
                            SUBSTR(TO_CHAR(10000000000 + TO_NUMBER(alt_bic)), 2, 10)
                          end as kb
                from  (
                          select cust.cust_id, ac.acc_id, ac.acc_num, ac.kv, cb.alt_bic, tr.ref, tr.bal, tr.bal_uah, ac.branch, tr.acc_id_db, tr.r020_db, tr.acc_id_cr, tr.r020_cr, tr.operation_date, ac.kf, tr.fdate
                                 , NVL(substr(w.value, 1, 2), '00') as dd
                          from   nbur_dm_customers cust
                                 join custbank cb  on (cust.cust_id = cb.rnk)
                                 join nbur_dm_accounts ac on (cust.kf = ac.kf)
                                                             and (cust.cust_id = ac.cust_id)                                   
                                 join table(F_GET_ACC_TRANSACTION(ac.acc_id, l_start_date, p_report_date)) tr on (1 = 1)   
                                 left join operw w on (tr.ref = w.ref) 
                                                      and (w.tag like 'D#40%')                                                          
                          where  cust.kf = p_kod_filii
                                 and cust.k030 = 2
                                 and ac.nbs in (
                                                 select r020 
                                                 from   kl_f3_29 
                                                 where  kf = 'D4'
                                               ) 
                                 and tr.sos = 5
                                 and tr.bal <> 0                                                                           
                        ) tr      
                  where   not exists(
                                            select null
                                            from   v_nbur_dm_transactions t
                                            where  t.kf = tr.kf
                                                   and t.ref = tr.ref                              
                                                   and (
                                                         (
                                                           t.bal = tr.bal and 
                                                           (
                                                             (t.R020_DB = '1608' and t.r020_cr = '1600') 
                                                             OR (t.r020_db = '1600' and t.r020_cr = '6110')
                                                           )
                                                         ) 
                                                         OR  
                                                         (
                                                           t.bal = GL.P_ICURVAL(tr.kv, tr.bal, tr.fdate) 
                                                           and t.R020_DB = '3801' and t.r020_cr = '6110'
                                                         )
                                                       )
                                    )    
      );

  logger.info(c_title || ' end for date = '||to_char(p_report_date, 'dd.mm.yyyy'));
END;
/
