
PROMPT ===================================================================================== 
PROMPT *** Run *** ======== Scripts /Sql/BARS/Procedure/NBUR_P_F6IX.sql =========*** Run ***
PROMPT ===================================================================================== 

CREATE OR REPLACE PROCEDURE BARS.NBUR_P_F6IX (p_kod_filii  varchar2
                                            , p_report_date      date
                                            , p_form_id          number
                                            , p_scheme           varchar2 default 'C'
                                            , p_file_code        varchar2 default '#6I')
 IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 DESCRIPTION :    ��������� ������������ 6IX
 COPYRIGHT   :    Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.

 VERSION     :    v.18.001    27.11.2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    ���������: p_report_date - �������� ����
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
  ver_              char(30)  := 'v.18.001  27.11.2018';

  c_title           constant varchar2(100 char) := $$PLSQL_UNIT || '.';

  l_nbuc          varchar2(20);
  l_type          number;
  l_datez         date := p_report_date + 1;
  l_file_code     varchar2(2) := substr(p_file_code, 2, 2);
  l_old_file_code varchar2(3) := '#D8';
  l_version       number;
  l_version_id    number;
  l_ret           number;  

  --Exception
  e_ptsn_not_exsts exception;

  pragma exception_init( e_ptsn_not_exsts, -02149 );
begin
  logger.info (c_title || ' begin for date = '||to_char(p_report_date, 'dd.mm.yyyy'));

  -- ���������� ���������� ��������� ��� ���������� �����
  nbur_files.P_PROC_SET(p_kod_filii, p_file_code, p_scheme, l_datez, 1, l_file_code, l_nbuc, l_type);
  
  --������� �������� ��� �������� ���������� ���������
  begin
    execute immediate 'alter table NBUR_LOG_F6IX truncate subpartition for ( to_date('''
                      || to_char(p_report_date,'YYYYMMDD')||''',''YYYYMMDD''), ''' || p_kod_filii || ''' )';
  exception
    when e_ptsn_not_exsts then
      null;
  end;
  
  -- ������� ���������� ������� �����
--  nbur_waiting_form(p_kod_filii, p_report_date, l_old_file_code, c_title);
  
  select max(version_id)
  into l_version
  from v_nbur_#D8
  where report_date = p_report_date and
        kf = p_kod_filii;

  --���������� ������ ����� ��� �������� ���������� ���������
  l_version_id := f_nbur_get_run_version(p_file_code => p_file_code
                                          , p_kf => p_kod_filii
                                          , p_report_date => p_report_date
                                        );

  -- ���������� �������� ��� ���������� ���� ���������
  l_ret := f_nbur_get_ekp_6ix(l_datez);       

  -- ���������� � ��������� ������� �����
  insert
    into NBUR_LOG_F6IX
       (REPORT_DATE, KF, NBUC, VERSION_ID, VERSION_D8, 
	EKP, K020, K021, Q003_2, Q003_4, R030, R020, F081, S031, T070_DTL, T070,  
       	DESCRIPTION, ACC_ID, ACC_NUM, KV, CUST_ID, CUST_CODE, CUST_NAME,
       	ND, AGRM_NUM, BEG_DT, END_DT, BRANCH)
  select p_report_date, p_kod_filii, nvl(trim(nbuc), l_nbuc),l_version_id, version_id,
       EKP, K020, K021, Q003_2, Q003_4, R030, R020, F081, S031, 
       T070_DTL, T070, DESCRIPTION, ACC_ID, ACC_NUM, KV, CUST_ID, CUST_CODE, 
       CUST_NAME, ND, AGRM_NUM, BEG_DT, END_DT, BRANCH

 from  (select   v.nbuc
                , v.version_id
                , (case 
                        when v.seg_01=t.seg and t.EKP is not null then t.EKP 
                        when v.seg_01=t.seg and t.EKP is null then 'A6I001'  
                        when v.seg_01='126' then 'A6I002'  
                        when v.seg_01='131' then 'A6I003'  
                        when v.seg_01='123' then 'A6I004'  
                        when v.seg_01='127' then 'A6I005'  
                        when v.seg_01='134' then 'A6I006'  
                        when v.seg_01='132' then 'A6I007'  
                        when v.seg_01='122' then 'A6I008'  
                        when v.seg_01='124' then 'A6I009'  
                        when v.seg_01='125' then 'A6I010'  
                        when v.seg_01='118' then 'A6I011'  
                        when v.seg_01='119' then 'A6I012'  
                        when v.seg_01='133' then 'A6I013'  
                        when v.seg_01='081' then 'A6I014'  
                        when v.seg_01='084' then 'A6I015'  
                        when v.seg_01='083' then 'A6I016'
                        else 'not defined'
                        end ) as   EKP                                    
                , LPAD(v.seg_02,10,'0')  as    K020
                , v.seg_07               as    K021   
                , v.seg_03               as    Q003_2
                , v.seg_06               as    Q003_4
                , (case v.seg_05
                        when null       then '#'
                        when '000'      then '#'
                        else v.seg_05
                        end)  as  R030
                , (case v.seg_04
                        when null       then '#'
                        when '0000'     then '#'
                        else v.seg_04
                        end)  as  R020
                , (case 
                        when v.seg_08 in (1,2) then  v.seg_08
                        else '#'
                        end)  as  F081
                , ( case v.seg_09 when '00' then '#' else v.seg_09 end ) as S031
                , NVL(v.field_value,0)   as    T070_DTL -- �����, �� ������ � �����������
                , NVL(agg.FIELD_VALUE,0) as    T070     -- �����, �� ������ � XML-���� (use distinct for fill xml)
                , v.DESCRIPTION
                , v.ACC_ID
                , v.ACC_NUM
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
                 left join V_NBUR_#D8 agg -- � XML ������� ���� �, �� ��������� � #D8
                      on (v.REPORT_DATE=agg.REPORT_DATE
                            and v.KF=agg.KF
                            and v.VERSION_ID=agg.VERSION_ID
                            and v.FIELD_CODE=agg.FIELD_CODE
                          ) 
                 left join NBUR_TMP_DESC_EKP2 t
                      on (v.seg_04=t.r020
                            and v.seg_01=t.seg
                         )
          where v.report_date = p_report_date 
            and v.kf = p_kod_filii 
            and v.seg_01 in (121,126,131,123,127,134,132,122,124,125,118,119,133,081,084,083)
       );

    commit;

   logger.info(c_title || ' end for date = '||to_char(p_report_date, 'dd.mm.yyyy'));
end;
/


PROMPT ===================================================================================== 
PROMPT *** End *** ======== Scripts /Sql/BARS/Procedure/NBUR_P_F6IX.sql =========*** End ***
PROMPT ===================================================================================== 

