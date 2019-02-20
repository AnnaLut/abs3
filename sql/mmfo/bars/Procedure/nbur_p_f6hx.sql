
PROMPT ===================================================================================== 
PROMPT *** Run *** ======== Scripts /Sql/BARS/Procedure/NBUR_P_F6HX.sql =========*** Run ***
PROMPT ===================================================================================== 

CREATE OR REPLACE PROCEDURE BARS.NBUR_P_F6HX (p_kod_filii  varchar2
                                            , p_report_date      date
                                            , p_form_id          number
                                            , p_scheme           varchar2 default 'C'
                                            , p_file_code        varchar2 default '#6H')
 IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 DESCRIPTION :    Процедура формирования 6HX
 COPYRIGHT   :    Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.

 VERSION     :    v.18.003    19.02.2019(24.01.2019)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    параметры: p_report_date - отчетная дата
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
19.02.2019	F102 проставляємо згідно COBUMMFO-10962 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
  ver_              char(30)  := 'v.18.003  19.02.2019';

  c_title           constant varchar2(100 char) := $$PLSQL_UNIT || '.';

  l_nbuc          varchar2(20);
  l_type          number;
  l_datez         date := p_report_date + 1;
  l_file_code     varchar2(2) := substr(p_file_code, 2, 2);
  l_old_file_code varchar2(3) := '#D8';
  l_version       number;
  l_version_id    number;

  --Exception
  e_ptsn_not_exsts exception;

  pragma exception_init( e_ptsn_not_exsts, -02149 );
begin
  logger.info (c_title || ' begin for date = '||to_char(p_report_date, 'dd.mm.yyyy'));

  -- визначення початкових параметрів для формування файлу
  nbur_files.P_PROC_SET(p_kod_filii, p_file_code, p_scheme, l_datez, 1, l_file_code, l_nbuc, l_type);
  
  --Очистка партиции для хранения детального протокола
  begin
    execute immediate 'alter table NBUR_LOG_F6HX truncate subpartition for ( to_date('''
                      || to_char(p_report_date,'YYYYMMDD')||''',''YYYYMMDD''), ''' || p_kod_filii || ''' )';
  exception
    when e_ptsn_not_exsts then
      null;
  end;
  
  -- очікуємо формування старого файлу
--  nbur_waiting_form(p_kod_filii, p_report_date, l_old_file_code, c_title);
  
  select max(version_id)
  into l_version
  from v_nbur_#D8
  where report_date = p_report_date and
        kf = p_kod_filii;

  --Определяем версию файла для хранения детальеного протокола
  l_version_id := f_nbur_get_run_version(p_file_code => p_file_code
                                          , p_kf => p_kod_filii
                                          , p_report_date => p_report_date
                                        );


  -- вставляємо з протоколу старого файлу
  insert
    into NBUR_LOG_F6HX
       (REPORT_DATE, KF, NBUC, VERSION_ID, VERSION_D8, EKP, K020, K021, Q003_2, Q003_4, R030, 
       Q007_1, Q007_2, S210, S083, S080_1, S080_2, F074, F077, F078, F102,
       Q017, Q027, Q034, Q035, T070_2, T090, T100_1, T100_2, T100_3, 
       DESCRIPTION, ACC_ID, ACC_NUM, KV, CUST_ID, CUST_CODE, CUST_NAME,
       ND, AGRM_NUM, BEG_DT, END_DT, BRANCH)
  select p_report_date, p_kod_filii, nvl(trim(xd.nbuc), l_nbuc),l_version_id,xd.version_id, 
       xd.EKP, xd.K020, xd.K021, xd.Q003_2, xd.Q003_4, xd.R030, 
       xd.Q007_1, xd.Q007_2, xd.S210, vs.S083, xd.S080_1, xd.S080_2, xd.F074, xd.F077, xd.F078, 
       DECODE(f.seg_02, null, xd.F102, '111') F102, xd.Q017, xd.Q027, xd.Q034, xd.Q035, xd.T070_2, 
       xd.T090, xd.T100_1, xd.T100_2, xd.T100_3, 
       vd.DESCRIPTION, vd.ACC_ID, vd.ACC_NUM, vd.KV, vd.CUST_ID, vd.CUST_CODE, vd.CUST_NAME,
       vd.ND, vd.AGRM_NUM, vd.BEG_DT, vd.END_DT, vd.BRANCH
  from (select nbuc
             , version_id
             , 'A6H001' as EKP
             , LPAD(K020,10,'0')   as  K020
             , K021
             , Q003_2
             , Q003_4
             , R030
             , to_date(regexp_replace(trim(Q007_1),'(\d{2})(\d{2})(\d{4})','\1.\2.\3'),'dd.mm.yyyy') as Q007_1
             , to_date(regexp_replace(trim(Q007_2),'(\d{2})(\d{2})(\d{4})','\1.\2.\3'),'dd.mm.yyyy') as Q007_2
             , S210
             --, S083
             , DECODE(NVL(S080_1,'0'),'0','#',S080_1) as S080_1
             , DECODE(NVL(S080_2,'0'),'0','#',S080_2) as S080_2
             , (case 
                   when F074 in ('000','001','100') then F074 
                else '#' end) as F074
             , (case 
                   when F077 in ('000','591','592','593') then F077 
                else '#' end) as F077
             , (case 
                   when F078 in ('00000','00001','00010','00100','01000','10000') then F078 
                else '#' end) as F078
             , (case 
                   when UPPER(K021) in ('3','4','9','C','G') 
                     and LPAD(K020,10,'0') not in ('0004053915', '0037471933') then '111'
                else '#' end) as F102
             , Q017
             , Q027
             , Q034
             , Q035
             , NVL(T070_2,0)  as T070_2
             , NVL(T090,0)    as T090
             , rtrim(TO_CHAR(NVL(trim(T100_1),0),'fm0.9999'),'.') as T100_1
             , rtrim(TO_CHAR(NVL(trim(T100_2),0),'fm0.99'),'.') as T100_2
             , rtrim(TO_CHAR(NVL(trim(T100_3),0),'fm0.99'),'.') as T100_3
          from (select v.nbuc
                        , v.version_id
                        , v.seg_01 -- DDD ('111'=Q007_1,'112'=Q007_2,'161'=S210,'160'=S080_1,'164'=S080_2,'171'=F074,'174'=F077,'175'=F078,'172'=Q017,'173'=Q027,'170'=Q034,'179'=Q035,'128'=T070_2,'130'=T090,'163'=T100_1,'162'=T100_2,'150'=T100_3)
                        , v.seg_02  as  K020   -- ZZZZZZZZZZ (K020)
                        , v.seg_03  as  Q003_2 -- NNNN (Q003_2)
                        , v.seg_07  as  K021   -- A (K021)
                        , v.seg_05  as  R030
                       -- , v.seg_10  as  S083
                        , v.seg_06  as  Q003_4
                        , v.FIELD_VALUE
                 from V_NBUR_#D8 v
                where v.report_date = p_report_date 
                  and v.kf = p_kod_filii 
                  and v.seg_01 in ('111','112','161','160','164','171','174','175','172',
                                 '173','170','179','128','130','163','162','150' )
                 )
          pivot  ( 
                 max(FIELD_VALUE) for seg_01 in ( '111' as Q007_1, '112' as Q007_2, '161' as S210,   '160'  as S080_1,
                                                  '164' as S080_2, '171'  as F074,  '174' as F077,   '175'  as F078,
                                                  '172' as Q017,   '173'  as Q027,  '170' as Q034,   '179'  as Q035,
                                                  '128' as T070_2, '130'  as T090,  '163' as T100_1, '162'  as T100_2, 
                                                  '150' as T100_3 )
                 )
      ) xd --дані для XML 
      left join (select distinct SEG_02, SEG_03, SEG_06, SEG_05, DESCRIPTION, ACC_ID, ACC_NUM, KV,CUST_ID,CUST_CODE,CUST_NAME,ND,AGRM_NUM,BEG_DT,END_DT,BRANCH      
                    from V_NBUR_#D8_dtl
                   where report_date = p_report_date 
                    and kf = p_kod_filii 
                    and seg_01 in ('111','112','161','160','164','171','174','175','172',
                                   '173','170','179','128','130','163','162','150' )
                    ) vd -- дані для деталізаії
                    on (xd.K020=vd.SEG_02
                        and xd.Q003_2=vd.SEG_03
                        and xd.Q003_4=vd.SEG_06
                        and xd.R030=vd.SEG_05
                        )
      left join (select seg_02, seg_03, max(seg_10) S083
                    from V_NBUR_#D8
                   where report_date = p_report_date
                    and kf = p_kod_filii
                 group by seg_02, seg_03
                    ) vs -- дані для обчислення s083
                    on (xd.K020=vs.SEG_02
                        and xd.Q003_2=vs.SEG_03
                        )
      left join (select distinct SEG_02, SEG_03, SEG_06
                    from V_NBUR_#D8
                   where report_date = p_report_date
                    and kf = p_kod_filii
                    and seg_01 in ('121','122','123','124','125','126','127','131','132','133','134','118','119')
                    and (SUBSTR(seg_04,1,3) in ('351','354','355') or seg_04='3570')
                    ) f --  дані для обчислення F102
                    on (    xd.K020=f.SEG_02
                        and xd.Q003_2=f.SEG_03
                        and xd.Q003_4=f.SEG_06
                        );

    commit;

   logger.info(c_title || ' end for date = '||to_char(p_report_date, 'dd.mm.yyyy'));
end;
/


PROMPT ===================================================================================== 
PROMPT *** End *** ======== Scripts /Sql/BARS/Procedure/NBUR_P_F6HX.sql =========*** End ***
PROMPT ===================================================================================== 

