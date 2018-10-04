CREATE OR REPLACE PROCEDURE BARS.NBUR_P_F3MX (p_kod_filii  varchar2
                                            , p_report_date      date
                                            , p_form_id          number
                                            , p_scheme           varchar2 default 'C'
                                            , p_file_code        varchar2 default '3MX')
 IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 DESCRIPTION :    Процедура формирования 3MX для схема "C"
 COPYRIGHT   :    Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.

 VERSION     :    v.18.001      29.09.2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    параметры: p_report_date - отчетная дата
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
  ver_              char(30)  := 'v.18.001  29.09.2018';

  c_title           constant varchar2(100 char) := $$PLSQL_UNIT || '.';

  l_nbuc          varchar2(20);
  l_type          number;
  l_datez         date := p_report_date + 1;
  l_file_code     varchar2(2) := substr(p_file_code, 2, 2);
--  l_old_file_code varchar2(3) := '#C9';
  l_version_c9      number;
  l_version_e2      number;
  l_version         number;

  --Exception
  e_ptsn_not_exsts exception;

  pragma exception_init( e_ptsn_not_exsts, -02149 );
begin
  logger.info (c_title || ' begin for date = '||to_char(p_report_date, 'dd.mm.yyyy'));

  -- визначення початкових параметрів для формування файлу
  nbur_files.P_PROC_SET(p_kod_filii, p_file_code, p_scheme, l_datez, 1, l_file_code, l_nbuc, l_type);
  
  --Очистка партиции для хранения детального протокола
  begin
    execute immediate 'alter table NBUR_LOG_F3MX truncate subpartition for ( to_date('''
                      || to_char(p_report_date,'YYYYMMDD')||''',''YYYYMMDD''), ''' || p_kod_filii || ''' )';
  exception
    when e_ptsn_not_exsts then
      null;
  end;

  -- очікуємо формування старих файлiв
--  nbur_waiting_form(p_kod_filii, p_report_date, l_old_file_code, c_title);
----  nbur_waiting_form(p_kod_filii, p_report_date, '#C9', c_title);
----  nbur_waiting_form(p_kod_filii, p_report_date, '#E2', c_title);
--   ?? включати чи ні ->   nbur_waiting_form(p_kod_filii, p_report_date, '#2D', c_title);
  
   select max(version_id)                 -- остання версія файлу #C9
     into l_version_c9
     from v_nbur_#c9
    where report_date = p_report_date 
      and kf = p_kod_filii;

   select max(version_id)                 -- остання версія файлу #E2
     into l_version_e2
     from v_nbur_#e2
    where report_date = p_report_date 
      and kf = p_kod_filii;

    select max(VERSION_ID)                -- поточна версія файлу 3MX
      into l_version
      from NBUR_LST_FILES
     where FILE_ID     = p_form_id
       and REPORT_DATE = p_report_date
       and KF          = p_kod_filii
       and FILE_STATUS = 'RUNNING';

  -- вставляємо з протоколу старого файлу
  insert
    into NBUR_LOG_F3MX
       (REPORT_DATE, KF, NBUC, VERSION_ID, EKP, 
        KU, T071, Q003_1, F091, R030, F090, K040, F089, K020, K021, Q001_1,
        B010, Q033, Q001_2, Q003_2, Q007_1, F027, F02D, Q006,
        DESCRIPTION, ACC_ID, ACC_NUM, KV, CUST_ID, REF, BRANCH)
    SELECT p_report_date, p_kod_filii, nvl(trim(nbuc), l_nbuc), l_version, 
           EKP, KU, T071, Q003_1, F091, R030, F090, K040, F089, K020, K021,
           Q001_1, B010, Q033, Q001_2, Q003_2, Q007_1, F027, F02D, Q006,
           description,
           acc_id,
           acc_num,
           kv,
           cust_id,
           ref,
           branch
      from ( with nnn_new as (
                                select lpad(to_char(rownum),3,'0') q003_1, kodf, seg_02
                                  from (
                                       select 'C9' kodf, seg_02
                                         from v_nbur_#c9 d
                                        where d.report_date = p_report_date
                                          and d.kf = p_kod_filii
                                          and d.version_id = l_version_c9
                                        group by seg_02
                                       union all
                                       select 'E2' kodf, seg_02
                                         from v_nbur_#e2 d
                                        where d.report_date = p_report_date
                                          and d.kf = p_kod_filii
                                          and d.version_id = l_version_e2
                                        group by seg_02
                                       )
                             )
            select   'A3M001'                   EKP
                   ,  KU
                   ,  to_char(round(to_number(T071) * (F_Ret_Dig(r030, p_report_date) * 100),0))  T071
                   ,  nnn_new.q003_1            Q003_1
                   ,  F091
                   ,  R030
                   ,  F090
                   ,  K040
                   , (case when substr(k020,1,1)='0'  then '1'
                             else '2'
                       end)                     F089
                   , (case when substr(k020,1,1)='0'  then '0'
                             else lpad(substr(trim(k020),2),10,'0' )
                       end)                     K020
                   , (case when substr(k020,1,1)='0'  then '#'
                             else substr(k020,1,1)
                       end)                     K021
                   ,  Q001_1
                   ,  B010
                   ,  Q033
                   ,  Q001_2
                   ,  Q003_2
                   ,  Q007_1
                   ,  F027
                   ,  F02D
                   ,  Q006
                   ,  description
                   ,  acc_id
                   ,  acc_num
                   ,  kv     
                   ,  cust_id
                   ,  ref   
                   ,  branch, nbuc
              from (
                     select   f_get_ku_by_nbuc(t.nbuc)   KU
                            , t.t071                     T071
                            , '6'                        F091
                            , t.seg_02                   seg_02
                            , t.r030                     R030
                            , f_nbur_get_f090('C9', t.ref, t.f090a)    F090
                            , t.k040                     K040
                            , f_nbur_get_k020_by_rnk(t.cust_id)            K020
                            , t.q001_1                   Q001_1
                            , null                       B010
                            , null                       Q033
                            , null                       Q001_2
                            , null                       Q003_2
                            , null                       Q007_1
                            , '#'                        F027
                            , '#'                        F02D
                            , t.q006                     Q006
                            , t.description
                            , t.acc_id
                            , t.acc_num
                            , decode(t.kv, 0, to_number(t.r030), t.kv)  kv     
                            , t.cust_id
                            , t.ref   
                            , t.branch, t.nbuc
                     from   (
                                 select nbuc, seg_02, r030, t071, k040, q006, f090a,
                                        description, acc_id, acc_num, kv, cust_id, ref, q001_1, branch
                                   from (
                                          select nbuc, seg_01, seg_02, field_value,
                                                description, acc_id, acc_num, kv,
                                                cust_id, ref, cust_name q001_1, branch 
                                            from v_nbur_#c9_dtl d
                                           where d.report_date = p_report_date
                                             and d.kf = p_kod_filii 
                                             and d.seg_01 in ('10','20','40','62','99')
                                           union all
                                          select nbuc, seg_01, seg_02, field_value,
                                                null description, 0 acc_id, null acc_num, 0 kv,
                                                0 cust_id, 0 ref, ' ' q001_1, null branch 
                                            from v_nbur_#c9 d
                                           where d.report_date = p_report_date 
                                             and d.kf = p_kod_filii 
                                             and d.version_id = l_version_c9
                                             and d.seg_01 in ('10','20','40','62','99')
                                             and d.seg_02 in ( select seg_02  from v_nbur_#c9
                                                                 where report_date = p_report_date 
                                                                   and kf = p_kod_filii 
                                                                   and d.version_id = l_version_c9
                                                                   and seg_01 ='40'
                                                                   and field_value ='36' )
                                        )
                                         pivot
                                        ( max(trim(field_value))
                                            for seg_01 in ( '10' as r030, '20' as t071, '40' as f090a, 
                                                            '62' as k040, '99' as q006 )
                                        ) 
                            ) t
                    union all
                     select   f_get_ku_by_nbuc(t.nbuc)   KU
                            , t.t071                     T071
                            , '5'                        F091
                            , t.seg_02                   seg_02
                            , t.r030                     R030
                            , f_nbur_get_f090('E2', t.ref, t.f090a)    F090
                            , t.k040                     K040
                            , f_nbur_get_k020_by_rnk(t.cust_id)            K020
                            , t.q001_1                   Q001_1
                            , t.b010                     B010
                            , t.q033                     Q033
                            , t.q001_2                   Q001_2
                            , t.q003_2                   Q003_2
                            , t.q007_1                   Q007_1
                            , decode( t.f027, null, '#', t.f027 )
                                                         F027
                            , decode( d.field_value, null, '#', d.field_value )
                                                         F02D
                            , t.q006                     Q006
                            , t.description
                            , t.acc_id
                            , t.acc_num
                            , t.kv     
                            , t.cust_id
                            , t.ref   
                            , t.branch, t.nbuc
                     from   (
                           select nbuc, seg_02, r030, t071, k040, q006, f090a, k020a,
                                                b010, q033, q003_2, q007_1, q001_2, f027,
                                  description, acc_id, acc_num, kv, cust_id, ref, q001_1, branch
                             from (
                                    select nbuc, seg_01, seg_02, field_value,
                                          description, acc_id, acc_num, kv,
                                          cust_id, ref, cust_name q001_1, branch
                                      from v_nbur_#e2_dtl d
                                     where d.report_date = p_report_date and
                                           d.kf = p_kod_filii and
                                           d.seg_01 in ('10','20','40','64','61','31',
                                                        '65','66','51','52','53','54')
                                  )
                                   pivot
                                  ( max(trim(field_value))
                                      for seg_01 in ( '10' as r030, '20' as t071, '40' as f090a, 
                                                      '64' as k040, '61' as q006, '31' as k020a,
                                                      '65' as b010, '66' as q033, '51' as q003_2,
                                                      '52' as q007_1, '53' as q001_2, '54' as f027 )
                                  ) 
                            ) t
                     left outer join v_nbur_#2d_dtl d
                            on (    d.report_date = p_report_date
                                and d.kf = p_kod_filii
                                and d.ref = t.ref
                               and d.seg_01 ='40' )
                   ) u, nnn_new 
              where nnn_new.kodf='C9' and nnn_new.seg_02 =u.seg_02 and u.f091 ='6'
                 or nnn_new.kodf='E2' and nnn_new.seg_02 =u.seg_02 and u.f091 ='5'
           );

    commit;

   logger.info(c_title || ' end for date = '||to_char(p_report_date, 'dd.mm.yyyy'));
end;
/

