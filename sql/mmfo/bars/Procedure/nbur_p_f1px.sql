CREATE OR REPLACE PROCEDURE NBUR_P_F1PX (
                                          p_kod_filii        varchar2
                                          , p_report_date    date
                                          , p_form_id        number
                                          , p_scheme         varchar2 default 'C'
                                          , p_file_code      varchar2 default '1PX'
                                        )
is
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION : ��������� ������������ 1PX ��� �������� �����
% COPYRIGHT   : Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
%
% VERSION     :  v.16.005 06/08/2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
  ver_          char(30)  := 'v.16.005  06/08/2018';
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
  c_title                constant varchar2(100 char) := $$PLSQL_UNIT || '.';
  cEKP                   constant varchar2(100 char) := 'A1P001';
  c_old_file_code        constant varchar2(3 char) := '#1P';
  c_sleep_time           constant number := 30;

  l_nbuc                 varchar2(20);
  l_type                 number;
  l_datez                date := p_report_date + 1;
  l_file_code            varchar2(2) := substr(p_file_code, 2, 2);

  l_version_id           number; --����� ������ �����
  l_old_file_code        varchar2(3) := '#1P';
  l_cnt                  number := 0;

  e_ptsn_not_exsts       exception;

  pragma exception_init( e_ptsn_not_exsts, -02149 );
BEGIN
  logger.info (c_title || ' begin for date = '||to_char(p_report_date, 'dd.mm.yyyy'));

  -- ����������� ��������� ���������� (��� ������� ��� ��� ��� �������������)
  nbur_files.P_PROC_SET(p_kod_filii, p_file_code, p_scheme, l_datez, 0, l_file_code, l_nbuc, l_type);

  --�������������� �������� ��� ������� ������
  begin
    execute immediate 'alter table NBUR_LOG_F1PX truncate subpartition for ( to_date('''
                      || to_char(p_report_date,'YYYYMMDD')||''',''YYYYMMDD''), ''' || p_kod_filii || ''' )';
  exception
    when e_ptsn_not_exsts then
      null;
  end;

  --���������� ������ ����� ��� �������� ����������� ��������� (���� ������� ���, �� ������ -1)
  l_version_id := coalesce(f_nbur_get_run_version(
                                                   p_file_code => p_file_code
                                                   , p_kf => p_kod_filii
                                                   , p_report_date => p_report_date
                                                 )
                           , -1);

  logger.trace(c_title || ' Version_id is ' || l_version_id);

  -- ������� ���������� ������� �����
  nbur_waiting_form(p_kod_filii, p_report_date, l_old_file_code, c_title);    
  
  -- ���������� �� ���������� � ��������� ���������� �� � ������������� ����� (��� ���������)
  select count(*)
  into l_cnt
  from v_nbur_#1p_dtl t
  where report_date = p_report_date and
        kf = p_kod_filii;
  
  if l_cnt > 0 then -- � ���������� ���������
      insert into nbur_log_f1px(report_date, kf, version_id, nbuc, ekp, k040_1, rcbnk_b010, rcbnk_name, 
            k040_2, r030, r020, r040, t023, rcukru_glb_2, k018, k020, q001, rcukru_glb_1, q003_1, q004, 
            t080, t071, description, acc_id, acc_num, kv, maturity_date, cust_id, ref, nd, branch)
        select p_report_date /*report_date*/
               , p_kod_filii /*kf*/
               , l_version_id /*version_id*/
               , nbuc /*nbuc*/
               , cEKP /*ekp*/
               , k040_1 /*k040_1*/
               , rcbnk_b010 /*rcbnk_b010*/
               , rcbnk_name /*rcbnk_name*/
               , k040_2 /*k040_2*/
               , r030 /*r030*/
               , r020 /*r020*/
               , r040 /*r040*/
               , t023 /*t023*/
               , rcukru_glb_2 /*rcukru_glb_2*/
               , k018 /*k018*/
               , k020 /*k020*/
               , q001 /*q001*/
               , rcukru_glb_1 /*rcukru_glb_1*/
               --��������� ������ ��� ������ � ��������������� � ���������� ���������
               , lpad(dense_rank() over (order by k040_1, rcbnk_b010, rcbnk_name, k040_2, r030, r020, r040, t023, rcukru_glb_2, k018, k020, q001, rcukru_glb_1, q004), 3, '0') as q003_1
               , q004 /*q004*/
               , case when t023 = 3 then 0 else 1 end/*t080*/
               , t071 /*t071*/
               , description /*description*/
               , acc_id /*acc_id*/
               , acc_num /*acc_num*/
               , kv /*kv*/
               , maturity_date /*maturity_date*/
               , cust_id /*cust_id*/
               , ref /*ref*/
               , nd /*nd*/
               , branch /*branch*/
        from    (
                  select
                         nbuc
                         , max(mmm) as K040_1
                         , max(hhhhhhhhhh) as RCBNK_B010
                         , max(case when dd = '10' then znap else null end) as  RCBNK_NAME
                         , max(www) as K040_2
                         , max(vvv) as R030
                         , max(bbbb) as R020
                         , max(xxxx) as R040
                         , max(e) as T023
                         , max(case when dd = '07' then znap else null end) as RCUKRU_GLB_2
                         , max(case when dd = '04' then znap else null end) as K018
                         , max(case when dd = '05' then znap else null end) as K020
                         , max(case when dd = '06' then znap else null end) as Q001
                         , max(case when dd = '03' then znap else null end) as  RCUKRU_GLB_1
                         , max(nnn) as Q003_1
                         , max(case when dd = '99' then znap else null end) as Q004
                         , max(case when dd = '71' then znap else null end) as T071

                         , o.comm as description
                         , o.acc_id as acc_id
                         , o.nls as acc_num
                         , o.kv as kv
                         , o.mdate as maturity_date
                         , o.rnk as cust_id
                         , o.ref as ref
                         , o.nd as nd
                         , o.branch
                  from   (
                            select t.seg_01 as dd
                                   , t.seg_02 as e
                                   , t.seg_03 as mmm
                                   , t.seg_04 as hhhhhhhhhh
                                   , t.seg_05 as bbbb
                                   , t.seg_06 as vvv
                                   , t.seg_07 as xxxx
                                   , t.seg_08 as www
                                   , t.seg_09 as nnn
                                   , t.field_code kodp
                                   , t.description comm
                                   , t.acc_num nls
                                   , t.kv
                                   , t.maturity_date mdate
                                   , t.cust_id rnk
                                   , t.ref
                                   , t.nd
                                   , t.branch
                                   , t.field_value znap
                                   , t.acc_id
                                   , t.nbuc
                            from v_nbur_#1p_dtl t
                            where report_date = p_report_date and
                                  kf = p_kod_filii
                         ) o
                  group by
                        substr(o.kodp, 3)
                         , o.comm
                         , o.acc_id
                         , o.nls
                         , o.kv
                         , o.mdate
                         , o.rnk
                         , o.ref
                         , o.nd
                         , o.branch
                         , o.nbuc
       );
  else
      insert into nbur_log_f1px(report_date, kf, version_id, nbuc, ekp, k040_1, rcbnk_b010, rcbnk_name, 
            k040_2, r030, r020, r040, t023, rcukru_glb_2, k018, k020, q001, rcukru_glb_1, q003_1, q004, 
            t080, t071, description, acc_id, acc_num, kv, maturity_date, cust_id, ref, nd, branch)
        select p_report_date /*report_date*/
               , p_kod_filii /*kf*/
               , l_version_id /*version_id*/
               , nbuc /*nbuc*/
               , cEKP /*ekp*/
               , k040_1 /*k040_1*/
               , rcbnk_b010 /*rcbnk_b010*/
               , rcbnk_name /*rcbnk_name*/
               , k040_2 /*k040_2*/
               , r030 /*r030*/
               , r020 /*r020*/
               , r040 /*r040*/
               , t023 /*t023*/
               , rcukru_glb_2 /*rcukru_glb_2*/
               , k018 /*k018*/
               , k020 /*k020*/
               , q001 /*q001*/
               , rcukru_glb_1 /*rcukru_glb_1*/
               --��������� ������ ��� ������ � ��������������� � ���������� ���������
               , lpad(dense_rank() over (order by k040_1, rcbnk_b010, rcbnk_name, k040_2, r030, r020, r040, t023, rcukru_glb_2, k018, k020, q001, rcukru_glb_1, q004), 3, '0') as q003_1
               , q004 /*q004*/
               , case when t023 = 3 then 0 else 1 end/*t080*/
               , t071 /*t071*/
               , description /*description*/
               , acc_id /*acc_id*/
               , acc_num /*acc_num*/
               , kv /*kv*/
               , maturity_date /*maturity_date*/
               , cust_id /*cust_id*/
               , ref /*ref*/
               , nd /*nd*/
               , branch /*branch*/
        from    (
                  select
                         nbuc
                         , max(mmm) as K040_1
                         , max(hhhhhhhhhh) as RCBNK_B010
                         , max(case when dd = '10' then znap else null end) as  RCBNK_NAME
                         , max(www) as K040_2
                         , max(vvv) as R030
                         , max(bbbb) as R020
                         , max(xxxx) as R040
                         , max(e) as T023
                         , max(case when dd = '07' then znap else null end) as RCUKRU_GLB_2
                         , max(case when dd = '04' then znap else null end) as K018
                         , max(case when dd = '05' then znap else null end) as K020
                         , max(case when dd = '06' then znap else null end) as Q001
                         , max(case when dd = '03' then znap else null end) as  RCUKRU_GLB_1
                         , max(nnn) as Q003_1
                         , max(case when dd = '99' then znap else null end) as Q004
                         , max(case when dd = '71' then znap else null end) as T071

                         , o.comm as description
                         , o.acc_id as acc_id
                         , o.nls as acc_num
                         , o.kv as kv
                         , o.mdate as maturity_date
                         , o.rnk as cust_id
                         , o.ref as ref
                         , o.nd as nd
                         , o.branch
                  from   (
                            select t.seg_01 as dd
                                   , t.seg_02 as e
                                   , t.seg_03 as mmm
                                   , t.seg_04 as hhhhhhhhhh
                                   , t.seg_05 as bbbb
                                   , t.seg_06 as vvv
                                   , t.seg_07 as xxxx
                                   , t.seg_08 as www
                                   , t.seg_09 as nnn
                                   , t.field_code kodp
                                   , null comm
                                   , null nls
                                   , null kv
                                   , null mdate
                                   , null rnk
                                   , null ref
                                   , null nd
                                   , null branch
                                   , t.field_value znap
                                   , null acc_id
                                   , t.nbuc
                            from v_nbur_#1p t
                            where report_date = p_report_date and
                                  kf = p_kod_filii
                         ) o
                  group by
                        substr(o.kodp, 3)
                         , o.comm
                         , o.acc_id
                         , o.nls
                         , o.kv
                         , o.mdate
                         , o.rnk
                         , o.ref
                         , o.nd
                         , o.branch
                         , o.nbuc
       );  
  end if;

  logger.info (c_title || ' end for date = '||to_char(p_report_date, 'dd.mm.yyyy'));
END;
/
