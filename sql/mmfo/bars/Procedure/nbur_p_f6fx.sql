
PROMPT ===================================================================================== 
PROMPT *** Run *** ======== Scripts /Sql/BARS/Procedure/NBUR_P_F6FX.sql =========*** Run ***
PROMPT ===================================================================================== 

CREATE OR REPLACE PROCEDURE BARS.NBUR_P_F6FX (p_kod_filii  varchar2
                                            , p_report_date      date
                                            , p_form_id          number
                                            , p_scheme           varchar2 default 'C'
                                            , p_file_code        varchar2 default '#6F')
 IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 DESCRIPTION :    Процедура формирования 6FX
 COPYRIGHT   :    Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.

 VERSION     :    v.18.003  13.02.2018 (v.18.002    19.11.2018)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    параметры: p_report_date - отчетная дата
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
13.02.2018	виправлено помилки (мають попадати лише ті, що попадають в #D8)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
  ver_              char(30)  := 'v.18.003  13.02.2018';

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
    execute immediate 'alter table NBUR_LOG_F6FX truncate subpartition for ( to_date('''
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

  --Определяем версию файла для хранения детального протокола
  l_version_id := f_nbur_get_run_version(p_file_code => p_file_code
                                          , p_kf => p_kod_filii
                                          , p_report_date => p_report_date
                                        );

  -- вставляємо з протоколу старого файлу
  insert
    into NBUR_LOG_F6FX
       (REPORT_DATE, KF, NBUC, VERSION_ID, VERSION_D8, EKP,K020,K021,Q001,F084,K040,KU_1,
    K110,K074,K140,Q020,Q003_1,Q029, /*FLAG_XML,*/ DESCRIPTION,KV,CUST_ID,CUST_CODE,
    CUST_NAME,ND,AGRM_NUM,BEG_DT,END_DT,BRANCH)
  select p_report_date, p_kod_filii, nvl(trim(nbuc), l_nbuc), l_version_id, version_id
     , 'A6F001'             as  EKP
     , LPAD(seg_02,10,'0')  as  K020
     , seg_07               as  K021
     , Q001
     , (case F084 when '0' then  '#' else  F084 end)        as F084
     , K040
     , (case 
            when K040 <> 804                    then '#'
            when seg_07 in ('2','6','7','A','B') then '#'
            else nvl(ltrim(KU_1,'0'),'#')
        end) KU_1
     , K110
     , (case when K074 in ('1','2') then K074 else '#' end) as K074
     , K140
     , Q020
     , (case Q003_1 when '000' then null else Q003_1 end)   as Q003_1
     , Q029
--     , flag_xml
     , DESCRIPTION
     , KV
     , CUST_ID
     , CUST_CODE
     , CUST_NAME
     , ND
     , AGRM_NUM
     , BEG_DT
     , END_DT
     , BRANCH
  from (select v.nbuc
             , v.version_id
             , v.seg_01 -- DDD ('085'=F084, '050'=K040, '025'=K110, '055'=KU_1, '021'=K074, '041'=Q003_1, '019'=Q029, '010'=Q001, '060'=Q020)
             , v.seg_02 -- ZZZZZZZZZZ (K020)
             , v.seg_07 -- A (K021)
             , nvl(t1.k140, v.seg_11) as k140 -- O (K140)
             , v.FIELD_VALUE
             , v.DESCRIPTION
             , v.KV
             , v.CUST_ID
             , v.CUST_CODE
             , v.CUST_NAME
             , v.ND
             , v.AGRM_NUM
             , v.BEG_DT
             , v.END_DT
             , v.BRANCH
          from V_NBUR_#D8_dtl v
           left join ( select distinct seg_02 okpo, -- K140 візмемо з першого з показників де він <> 0
                              FIRST_VALUE(seg_11) over (partition by seg_02 order by seg_01) as K140
                         from V_NBUR_#D8_dtl
                        where report_date = p_report_date 
                          and kf = p_kod_filii
                          and seg_01 in ( '131','132','133','134','118','119', 
                                          '121','122','123','124','125','126','127' )
                          and seg_11 <> '0'
                         ) t1
                      on (v.seg_02 = t1.okpo)

         where v.report_date = p_report_date 
           and v.kf = p_kod_filii
           and v.seg_01 in ('085','050','025','055','021','041','019','010','060')
        )
 pivot (
       max(field_value)
       for seg_01 in ('085' as F084, '050' as K040, '025' as K110, 
                      '055' as KU_1, '021' as K074, '041' as Q003_1, 
                      '019' as Q029, '010' as Q001, '060' as Q020)
       );

    commit;
-- Розставимо флаг попадання в файл (FLAG_XML)

      declare
         type t_custid_tab is table of nbur_log_f6fx.cust_id%type index by pls_integer;
         custid_tab t_custid_tab;
      begin
      -- зберемо в колекцію CUST_ID, які попадають в #D8
            select distinct CUST_ID bulk collect into custid_tab
              from (select d.CUST_ID, a.FIELD_CODE 
                      from V_NBUR_#D8_dtl d
                      left join V_NBUR_#D8 a
                             on (d.REPORT_DATE=a.REPORT_DATE
                                   and d.KF=a.KF
                                   and d.VERSION_ID=a.VERSION_ID
                                   and d.FIELD_CODE=a.FIELD_CODE
                                   and d.FIELD_VALUE=a.FIELD_VALUE
                                 ) 
                     where d.REPORT_DATE = p_report_date 
                       and d.KF= p_kod_filii 
                       and d.seg_01 in ('010')
                    ) 
             where FIELD_CODE is not null;

      -- проставимо флаг
             forall indx in custid_tab.first..custid_tab.last
                  update nbur_log_f6fx 
                     set FLAG_XML = 1
                   where REPORT_DATE = p_report_date 
                     and KF= p_kod_filii 
                     and version_id = l_version_id 
                     and cust_id = custid_tab(indx);
      end;

    commit;

   logger.info(c_title || ' end for date = '||to_char(p_report_date, 'dd.mm.yyyy'));
end;
/


PROMPT ===================================================================================== 
PROMPT *** End *** ======== Scripts /Sql/BARS/Procedure/NBUR_P_F6FX.sql =========*** End ***
PROMPT ===================================================================================== 

