

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/NBUR_P_F2FX.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  procedure NBUR_P_F2FX ***

  CREATE OR REPLACE PROCEDURE BARS.NBUR_P_F2FX 
(
   p_kod_filii     in varchar2
 , p_report_date   in date
 , p_form_id       in number
 , p_scheme        in varchar2 default 'C'
 , p_file_code     in varchar2 default '2FX'
)
 IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 DESCRIPTION :    Процедура формирования 6BX
 COPYRIGHT   :    Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.

 VERSION     :    v.18.001    23.11.2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    параметры: p_report_date - отчетная дата
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
  ver_            char(30)  := ' v.18.001  23.11.2018';

  c_title         constant varchar2(100 char) := $$PLSQL_UNIT || '.';

  l_nbuc          varchar2(20);
  l_type          number;
  l_datez         date        := p_report_date + 1;
  l_file_code     varchar2(2) := substr(p_file_code, 2, 2);
  l_old_file_code varchar2(3) := '#2F';

  --Exception
  e_ptsn_not_exsts exception;

  pragma exception_init( e_ptsn_not_exsts, -02149 );
begin
  logger.info (c_title || ' begin for date = '||to_char(p_report_date, 'dd.mm.yyyy')||ver_);

  -- визначення початкових параметрів для формування файлу
  nbur_files.P_PROC_SET(p_kod_filii, p_file_code, p_scheme, l_datez, 1, l_file_code, l_nbuc, l_type);
  
  --Очистка партиции для хранения детального протокола
  begin
    pkg_ddl.p_subpartition_truncate('NBUR_LOG_F2FX', p_report_date, p_kod_filii);
  exception
    when e_ptsn_not_exsts then
      null;
  end;
  
  -- очікуємо формування старого файлу
  nbur_waiting_form(p_kod_filii, p_report_date, l_old_file_code, c_title);    

  -- вставляємо з протоколу старого файлу
  insert
    into NBUR_LOG_F2FX
       (REPORT_DATE, KF, NBUC, VERSION_ID, 
        EKP, D110, K014, K019, K030, K040, K044, 
        KU,
        R030, T070_1, T070_2, T100,
        DESCRIPTION, ACC_ID, ACC_NUM, KV, CUST_ID, REF, BRANCH)     
  select p_report_date, p_kod_filii, nvl(trim(nbuc), l_nbuc), version_id, 
         EKP, D110, K014, K019, K030, K040, K044, 
         decode(KU,'000','#',ltrim(KU,'0')) as KU,
         R030,
         -- calc T070_1, T070_2, T100         
         case
           when EKP# between 1  and 11 or 
                EKP# between 32 and 35    then 0
           when EKP# between 12 and 31 
            and K019 = '4'                then to_number(field_value)
           when EKP# between 12 and 31 
            and K019 in ('1','2','3')     then 0
           when EKP# between 12 and 31 
            and K019 = '0'
            and K030 = '0' 
            and KU   = '000'              then 0
         end                                        as T070_1,
         case
           when EKP# between 1  and 11 or 
                EKP# between 32 and 35    then 0
           when EKP# between 12 and 31 
            and K019 = '4'                then 0
           when EKP# between 12 and 31 
            and K019 in ('1','2','3')     then to_number(field_value)
           when EKP# between 12 and 31 
            and K019 = '0'
            and K030 = '0' 
            and KU   = '000'              then 0
         end                                        as T070_2,         
         case
           when EKP# between 1  and 11 or 
                EKP# between 32 and 35    then to_number(field_value)
           when EKP# between 12 and 31 
            and K019 = '4'                then 0
           when EKP# between 12 and 31 
            and K019 in ('1','2','3')     then 0
           when EKP# between 12 and 31 
            and K019 = '0'
            and K030 = '0' 
            and KU   = '000'              then to_number(field_value)
         end                                        as T100,
         description, acc_id, acc_num, kv, cust_id, ref, branch   
  from (select nbuc,
               version_id,
               EKP#,
               decode(EKP#,null, null,'A2F0'||lpad(to_char(EKP#),2,'0')) as  EKP,
               case 
                 when EKP# between 1  and 11 or 
                      EKP# between 32 and 35     then '#'
                 when EKP# between 12 and 31     then D110#
               end                                                   as D110,
               case 
                 when EKP# between 1  and 3  or
                      EKP# between 12 and 31     then K014#
                 when EKP# between 4  and 11 or
                      EKP# between 32 and 35     then '#'
               end                                                   as K014,
               case     
                 when EKP# between 1  and 3  or  
                      EKP# between 7  and 11 or
                      EKP# between 32 and 35     then '#'
                 when EKP# between 4  and 6  or
                      EKP# between 12 and 31     then K019#
               end                                                   as K019,
               case 
                 when EKP# between 1  and 11 or  
                      EKP# between 32 and 35     then '#'
                 when EKP# between 12 and 31     then K030#
               end                                                   as K030,         
               case 
                 when EKP# between 1  and 11 or  
                      EKP# between 32 and 35     then '#'
                 when EKP# between 12 and 31     then K040#
               end                                                   as K040,
               case 
                 when EKP# between 1  and 11 or  
                      EKP# between 32 and 35     then '#'
                 when EKP# between 12 and 31     then K044#
               end                                                   as K044,
               case 
                 when EKP# between 1  and 11 or 
                      EKP# between 21 and 22 or 
                      EKP# between 32 and 35     then '#'
                 when EKP# between 12 and 20 or 
                      EKP# between 23 and 31     then KU#
               end                                                   as KU,
               case 
                 when EKP# between 1  and 11 or  
                      EKP# between 32 and 35     then '#'
                 when EKP# between 12 and 31     then R030#
               end                                                  as R030
               , field_value 
               , description, acc_id, acc_num, kv, cust_id, ref, branch
      from (select v.nbuc
                 , v.version_id
                 ,  case when v.seg_01 = '3' and v.seg_02 ='109'                  then 01
                         when v.seg_01 = '3' and v.seg_02 ='110'                  then 02
                         when v.seg_01 = '3' and v.seg_02 ='111'                  then 03
                         when v.seg_01 = '3' and v.seg_02 ='101'                  then 04
                         when v.seg_01 = '3' and v.seg_02 ='102'                  then 05
                         when v.seg_01 = '3' and v.seg_02 ='103'                  then 06
                         when v.seg_01 = '3' and v.seg_02 ='104'                  then 07
                         when v.seg_01 = '3' and v.seg_02 ='105'                  then 08
                         when v.seg_01 = '3' and v.seg_02 ='106'                  then 09
                         when v.seg_01 = '3' and v.seg_02 ='107'                  then 10
                         when v.seg_01 = '3' and v.seg_02 ='108'                  then 11
                         when v.seg_01 = '1' and v.seg_02 ='215'                  then 12
                         when v.seg_01 = '1' and v.seg_02 ='216'                  then 13
                         when v.seg_01 = '1' and v.seg_02 ='202'                  then 14
                         when v.seg_01 = '1' and v.seg_02 ='203'                  then 15
                         when v.seg_01 = '1' and v.seg_02 ='204'                  then 16
                         when v.seg_01 = '1' and v.seg_02 ='205'                  then 17
                         when v.seg_01 = '1' and v.seg_02 ='206'                  then 18
                         when v.seg_01 = '1' and v.seg_02 ='207'                  then 19
                         when v.seg_01 = '1' and v.seg_02 ='208'                  then 20
                         when v.seg_01 = '1' and v.seg_02 ='209'                  then 21
                         when v.seg_01 = '1' and v.seg_02 ='210'                  then 22
                         when v.seg_01 = '1' and v.seg_02 ='211'                  then 23
                         when v.seg_01 = '1' and v.seg_02 ='217'                  then 24
                         when v.seg_01 = '1' and v.seg_02 ='218'                  then 25
                         when v.seg_01 = '1' and v.seg_02 ='212'                  then 26
                         when v.seg_01 = '1' and v.seg_02 ='219'                  then 27
                         when v.seg_01 = '1' and v.seg_02 ='220'                  then 28
                         when v.seg_01 = '1' and v.seg_02 ='213'                  then 29
                         when v.seg_01 = '1' and v.seg_02 ='214' and seg_10 = '2' then 30
                         when v.seg_01 = '1' and v.seg_02 ='214' and seg_10 = '1' then 31
                         when v.seg_01 = '3' and v.seg_02 ='301'                  then 32
                         when v.seg_01 = '3' and v.seg_02 ='302'                  then 33
                         when v.seg_01 = '3' and v.seg_02 ='303'                  then 34                 
                         when v.seg_01 = '3' and v.seg_02 ='304'                  then 35                 
                    end                  as EKP#
                 , v.seg_03                as K014#
                 , v.seg_04                as K030#
                 , v.seg_05                as K019#
                 , v.seg_06                as KU#
                 , v.seg_07                as K044#
                 , v.seg_08                as K040#
                 , v.seg_09                as R030#
                 , v.seg_10                as D110#
                 , v.field_value
                 , v.description 
                 , v.acc_id
                 , v.acc_num
                 , v.kv
                 , v.cust_id
                 , v.ref
                 , v.branch
            from (
                  select dt.nbuc, dt.version_id, dt.field_value, dt.description ,dt.acc_id ,dt.acc_num ,dt.kv ,dt.cust_id, dt.ref, dt.branch,
                         dt.seg_01, dt.seg_02, dt.seg_03, dt.seg_04, dt.seg_05, dt.seg_06, dt.seg_07, dt.seg_08, dt.seg_09, dt.seg_10
                  from v_nbur_#2f_dtl dt
                  where dt.report_date = p_report_date 
                    and dt.kf = p_kod_filii
                  union all -- итоговые суммы
                  select ag.nbuc, ag.version_id, ag.field_value, null ,null ,null ,null ,null, null, null,
                         ag.seg_01, ag.seg_02, ag.seg_03, ag.seg_04, ag.seg_05, ag.seg_06, ag.seg_07, ag.seg_08, ag.seg_09, ag.seg_10
                  from v_nbur_#2f ag
                  where ag.report_date = p_report_date 
                    and ag.kf = p_kod_filii
                    and ag.seg_02 in ('301', '302', '303', '304')
                 ) v
              
            ));

    commit;

   logger.info(c_title || ' end for date = '||to_char(p_report_date, 'dd.mm.yyyy'));
end;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/NBUR_P_F2FX.sql =========*** End *
PROMPT ===================================================================================== 
