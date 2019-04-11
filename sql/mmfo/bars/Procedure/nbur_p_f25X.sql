
PROMPT ===================================================================================== 
PROMPT *** Run *** ======== Scripts /Sql/BARS/Procedure/NBUR_P_F25X.sql =========*** Run ***
PROMPT ===================================================================================== 

CREATE OR REPLACE PROCEDURE NBUR_P_F25X (p_kod_filii  varchar2
                                            , p_report_date      date
                                            , p_form_id          number
                                            , p_scheme           varchar2 default 'C'
                                            , p_file_code        varchar2 default '25X')
 IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 DESCRIPTION :    Процедура формирования 25X
 COPYRIGHT   :    Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.

 VERSION     :    v.19.001    04.04.2019
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    параметры: p_report_date - отчетная дата
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
  ver_              char(30)  := 'v.19.001    04.04.2019';

  c_title           constant varchar2(100 char) := $$PLSQL_UNIT || '.';

  l_nbuc          varchar2(20);
  l_type          number;
  l_datez         date := p_report_date + 1;
  l_file_code     varchar2(2) := substr(p_file_code, 2, 2);
  l_old_file_code varchar2(3) := '#25';
  l_version       number;

  --Exception
  e_ptsn_not_exsts exception;

  pragma exception_init( e_ptsn_not_exsts, -02149 );
begin
  logger.info (c_title || ' begin for date = '||to_char(p_report_date, 'dd.mm.yyyy'));

  -- визначення початкових параметрів для формування файлу
  nbur_files.P_PROC_SET(p_kod_filii, p_file_code, p_scheme, l_datez, 1, l_file_code, l_nbuc, l_type);

  --Очистка партиции для хранения детального протокола
  begin
    execute immediate 'alter table NBUR_LOG_F25X truncate subpartition for ( to_date('''
                      || to_char(p_report_date,'YYYYMMDD')||''',''YYYYMMDD''), ''' || p_kod_filii || ''' )';
  exception
    when e_ptsn_not_exsts then
      null;
  end;

  -- очікуємо формування старого файлу
  nbur_waiting_form(p_kod_filii, p_report_date, l_old_file_code, c_title);

  select max(version_id)
  into l_version
  from v_nbur_#25
  where report_date = p_report_date and
        kf = p_kod_filii;

  -- вставляємо з протоколу старого файлу 
     insert
       into NBUR_LOG_F25X
           (REPORT_DATE, KF, VERSION_ID, NBUC,
            EKP, KU, R020, T020, R030, K040,T070, T071,
            DESCRIPTION, ACC_ID, ACC_NUM, KV, CUST_ID,CUST_CODE,CUST_NAME, BRANCH)
    select  report_date
           ,kf
           ,version_id
           ,nvl(trim(nbuc), l_nbuc)
           ,EKP
           ,KU
           ,R020
           ,T020
           ,R030
           ,K040
           ,SUM(T070) as T070
           ,SUM(case R030
                     when '980' then T070
                     else T071
                 end) as T071
           ,DESCRIPTION
           ,ACC_ID
           ,ACC_NUM
           ,KV
           ,CUST_ID
           ,CUST_CODE
           ,CUST_NAME
           ,BRANCH
      from (select  d.report_date
                   ,d.kf
                   ,d.version_id
                   ,d.NBUC
                   ,'A25'||br.I010||'0'    as EKP
                   ,f_get_ku_by_nbuc(nbuc) as KU
                   ,substr(d.SEG_01,1,1)   as T020
                   ,substr(d.SEG_01,2,1)   as TREST
                   ,d.SEG_02 		   as R020
                   ,d.SEG_03 		   as R030
                   ,lpad(trim(c.country), 3, '0') as K040
                   ,d.FIELD_VALUE
                   ,d.DESCRIPTION
                   ,d.ACC_ID
                   ,d.ACC_NUM
                   ,d.KV
                   ,c.RNK  as CUST_ID
                   ,c.okpo as CUST_CODE
                   ,c.nmk  as CUST_NAME
                   ,d.BRANCH
              from V_NBUR_#25_dtl d
              join (select unique t.I010, t.r020
                      from KL_R020 t
                     where t.i010 in ('F2','F3','F4','F5','F7','F8','N1','N6','N7','N9')
                       and d_open <= p_report_date
                       and (d_close is null or d_close >= p_report_date)
                   ) br
                 on br.r020 = d.seg_02
               join (select a.kf, a.acc, k.rnk, k.nmk, k.okpo, k.country
                       from customer k, accounts a
                     where k.rnk = a.rnk
                    ) c
                 on (c.kf = d.KF
                     and c.ACC = d.ACC_ID)
              where d.report_date = p_report_date
                and d.kf = p_kod_filii
            ) v
     pivot (
            max(v.FIELD_VALUE)
            for TREST in ('0' as T070, '1' as T071)
           )
     group by report_date,kf,version_id,NBUC,EKP,KU,R020,T020,R030,K040,DESCRIPTION,ACC_ID,ACC_NUM,KV,CUST_ID,CUST_CODE,CUST_NAME,BRANCH;
    commit;

   logger.info(c_title || ' end for date = '||to_char(p_report_date, 'dd.mm.yyyy'));
end;
/

PROMPT ===================================================================================== 
PROMPT *** End *** ======== Scripts /Sql/BARS/Procedure/NBUR_P_F25X.sql =========*** End ***
PROMPT ===================================================================================== 

