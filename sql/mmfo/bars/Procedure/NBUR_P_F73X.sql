PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/NBUR_P_F73X.sql =========*** Run *** =
PROMPT ===================================================================================== 

PROMPT *** Create  procedure NBUR_P_F73X ***

CREATE OR REPLACE PROCEDURE NBUR_P_F73X (
                                         p_kod_filii  varchar2
                                         , p_report_date      date
                                         , p_form_id          number
                                         , p_scheme           varchar2 default 'C'
                                         , p_balance_type     varchar2 default 'S'
                                         , p_file_code        varchar2 default '73X'
                                      )
is
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION : Процедура формирования 73X в формате XML для Ощадного банку
% COPYRIGHT   : Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
%
% VERSION     :  v.18.001  27.03.2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
  ver_               char(30)  := 'v.18.001  04.04.2018';

  c_title            constant varchar2(200 char) := $$PLSQL_UNIT;


  l_nbuc                varchar2(20 char);
  l_type                number;
  l_datez               date := p_report_date + 1;
  l_file_code           varchar2(2 char) := substr(p_file_code, 2, 2);

  l_start_date          date;
BEGIN
  logger.info (
                c_title
                || ' begin for'
                || ' date = ' || to_char(p_report_date, 'dd.mm.yyyy')
                || ' kod_filii=' || p_kod_filii
                || ' form_id=' || p_form_id
                || ' p_scheme= ' || p_scheme
              );

  --Опредеялем дату начала охвата как последний рабочий день предыдущего месяца
  l_start_date := calc_pdat(dat_ => trunc(p_report_date, 'MM'));

  logger.info(
               c_title
               || ' selecting from date='
               || to_char(l_start_date, 'dd.mm.yyyy')
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
 
  insert into nbur_detail_protocols (
                                          report_date
                                          , kf
                                          , report_code
                                          , nbuc
                                          , field_code
                                          , field_value
                                          , description
                                          , acc_id
                                          , acc_num
                                          , kv
                                          , maturity_date
                                          , cust_id
                                          , REF
                                          , nd
                                          , branch
                                    )
    select p_report_date
           , z.kf
           , p_file_code
           , z.nbuc
           , case
                 (
                          case
                            when z.r020_db = '1002' and z.r020_cr in ('2620', '2630', '2635') and z.kf = '322498' and z.d020 = '232'
                          then 
                            '231'
                            
                            when z.r020_db in ('2620', '2630', '2635') and z.r020_cr in ('1002') and z.kf = '322498' and z.d020 = '342'
                          then
                            '341' 
                            
                            when z.r020_db in ('2620', '2630', '2635') and substr(z.r020_cr, 1, 3) in ('100') and lower(z.comm) like 'поверн%'
                          then
                            '341'
                            
                            when z.r020_db in ('2620', '2630', '2635') and substr(z.r020_cr, 1, 3) in ('100') and z.kf = '300465' and (lower(z.comm) like '%claim%' or lower(z.comm) like '%переказ%') 
                          then 
                            '342'
                            
                            when z.r020_db = '1001' and z.r020_cr in ('3800') and z.d020 = '250'
                          then
                            '261'                     
                            
                            when z.r020_db in ('1002') and z.r020_cr in ('3800') and z.d020 in ('250', '262')
                          then
                            '261'                                          
                            
                            when z.r020_db in ('1003') and z.r020_cr in ('3800') and z.d020 in ('250')
                          then
                            '262'                                           
                            
                            when z.r020_db in ('1001', '1002', '1101', '1102') and z.r020_cr in ('3800') and z.d020 in ('000') 
                          then
                                        case
                                          when z.tt in ('BAK', 'TIK')
                                               or z.cnt_bak > 0
                                               or (
                                                    ccy_id in (959, 961, 962, 964)
                                                    and (
                                                          lower(z.comm) like '%отримано%' or
                                                          lower(z.comm) like '%прийнято монети%' or
                                                          lower(z.comm) like '%прийнято з гоу%' or
                                                          lower(z.comm) like '%прийом%оу%'
                                                        )                                  
                                                  )
                                        then 
                                          '000'
                                        else
                                          '261'                      
                                        end
                            
                            when z.r020_db in ('1003') and z.r020_cr in ('3800') and z.d020 in ('000')
                          then
                            '262'     
                            
                            when z.r020_db in ('3800') and z.r020_cr in ('1001', '1002') and z.d020 in ('350')                      
                          then
                            '361'
                            
                            when z.r020_db in ('3800') and z.r020_cr in ('1003') and z.d020 in ('350')                      
                          then
                            '362'                      
                          
                            when z.r020_db in ('3800') and z.r020_cr in ('1001', '1002', '1101', '1102') and z.d020 in ('000') and lower(z.comm) not like 'вида%' and lower(z.comm) not like 'переда%'
                          then
                                        case
                                          when z.tt = 'BAK'
                                               or z.cnt_bak > 0
                                        then
                                          '000'
                                        else
                                          '361'
                                        end
                            
                            when z.r020_db in ('3800') and z.r020_cr in ('1001', '1002', '1101', '1102') and (lower(z.comm) like 'видан%' or lower(z.comm) like 'передан%' or lower(z.comm) like 'видача%' or lower(z.comm) like '%врегул%' or lower(z.comm) like '%відправ%')
                            then
                              '000'
                              
                            when z.r020_db in ('3907') and z.r020_cr in ('1001', '1002') and z.tt = '189' and lower(z.comm) like '%підкріпл%'
                          then
                            '000'
                            
                            when z.r020_db in ('3800') and z.r020_cr in ('1003') and z.d020 in ('000')
                          then
                            '362'
                            
                            when substr(z.r020_db, 1, 3) in ('100', '110') and z.r020_cr not in ('1007', '1107', '3800') and z.d020 in ('000')
                          then
                            '000'
                            
                            when z.r020_db not in ('1007', '1107', '3800') and substr(z.r020_cr, 1, 3) in ('100', '110') and z.d020 in ('000')
                          then
                            '000'                    
                            
                            when substr(z.r020_db, 1, 3) in ('100', '110') and z.d020 not in ('280') and to_number(z.d020) < 300
                          then
                            z.d020 
                            
                            when substr(z.r020_cr, 1, 3) in ('100', '110') and z.d020 not in ('380') and to_number(z.d020) > 300                      
                          then
                            z.d020 
                            
                            when substr(z.r020_db, 1, 3) in ('100', '110')
                          then
                                        case
                                          when z.kf = '300465' and z.d020 in ('310') then '270'
                                          
                                          when z.r020_cr in ('3800') and z.d020 = '348' then '248'
                                          when z.r020_cr in ('3800') and z.d020 = '342' then '242'
                                          when z.r020_cr in ('3800') and z.d020 = '361' then '361'
                                          when z.r020_cr in ('3800') and z.d020 = '362' then '362'
                                          when z.r020_cr in ('3800') and z.d020 = '363' then '363'
                                          when z.r020_cr in ('3800') and z.d020 = '370' then '370'
                                          when to_number(z.d020) > 300 then '200' 
                                        end
                               
                            
                            when substr(z.r020_cr, 1, 3) in ('100', '110')                        
                          then
                                          case
                                            when z.r020_db in ('3800') and z.d020 = '248' then '342'
                                            when z.r020_db in ('3800') and z.d020 = '261' then '361'
                                            when z.r020_db in ('3800') and z.d020 = '262' then '361'
                                            when z.r020_db in ('3800') and z.d020 = '263' then '363'
                                            when z.r020_db in ('3800') and z.d020 = '270' then '370'
                                            when z.d020 not in ('280') and to_number(z.d020) < 300 then '300'
                                          end
                          end                                  
                         )
               when '210' then 'A73001'
               when '221' then 'A73002'
               when '222' then 'A73003'
               when '223' then 'A73004'
               when '224' then 'A73005'
               when '220' then 'A73006'
               when '231' then 'A73007'
               when '232' then 'A73008'
               when '233' then 'A73009'
               when '234' then 'A73010'
               when '246' then 'A73011'
               when '247' then 'A73012'
               when '261' then 'A73013'
               when '262' then 'A73014'
               when '263' then 'A73015'
               when '270' then 'A73016'
               when '310' then 'A73017'
               when '321' then 'A73018'
               when '322' then 'A73019'
               when '323' then 'A73020'
               when '324' then 'A73021'
               when '325' then 'A73022'
               when '341' then 'A73023'
               when '342' then 'A73024'
               when '344' then 'A73025'
               when '343' then 'A73026'
               when '346' then 'A73027'
               when '347' then 'A73028'
               when '361' then 'A73029'
               when '362' then 'A73030'
               when '363' then 'A73031'
               when '370' then 'A73032'
               when '510' then 'A73033'
               when '520' then 'A73034'
               when '610' then 'A73035'
               when '620' then 'A73036'
               when '248' then 'A73037'
               when '348' then 'A73038'                         
             else
               'XXXXXX'
             end
             || lpad(Ccy_Id, '3', '0')
           , z.bal * F_NBUR_Ret_Dig(Ccy_Id, p_report_date)
           , z.comm
           , z.acc_id
           , z.acc_num
           , z.ccy_id
           , null as maturity_date
           , z.cust_id
           , z.REF
           , null as nd
           , z.branch
    from   (
              select 
                      t.report_date
                      , t.kf
                      , t.ref
                      , t.tt
                      , t.ccy_id
                      , t.bal
                      , t.r020_db
                      , t.r020_cr
                      , NVL(substr(nvl(w2.d020, w1.d020), 1, 3), '000') as d020
                      , DECODE (t.tt, p.tt, p.nazn, DECODE (t.tt, 'PO3', p.nazn, t1.NAME)) as comm
                      , p.sos
                      , t.cnt_bak  
                      , ac.branch 
                      , t.cust_id
                      , t.acc_num
                      , t.acc_id
                      , t.nbuc
              from    (
                        select
                          t.*
                          , (case when t.r020_db like '100%' then to_number(t.Nbuc_Cr) else to_number(t.Nbuc_Db) end) as nbuc
                          , (case when t.r020_db like '100%' then t.Acc_Id_Cr else t.Acc_Id_Db end) as acc_id
                          , (case when t.r020_db like '100%' then t.Acc_Num_Cr else t.Acc_Num_Db end) as acc_num
                          , (case when t.r020_db like '100%' then t.Cust_Id_Cr else t.Cust_Id_Db end) as cust_id                              
                          , sum(case when t.tt = 'BAK' then 1 else 0 end) over (partition by t.ref) CNT_BAK
                        from   NBUR_DM_TRANSACTIONS_CNSL t
                        where  (1 = 1)
                               and t.report_date between l_start_date and p_report_date  --Дата отчета
                               and t.kf = p_kod_filii        --Код филиала
                               --Условия отбора
                               and t.ccy_id != 980 --Только валютные проводки
                               and (
                                     (
                                       t.r020_db in ('1000', '1001', '1002', '1003', '1004', '1005', '1006', '1008', '1009')
                                       and t.r020_cr not in ('1007')
                                     )
                                     or
                                     (
                                       t.r020_cr in ('1000', '1001', '1002', '1003', '1004', '1005', '1006', '1008', '1009')
                                       and t.r020_db not in ('1007')
                                     )
                                     or
                                     (
                                       t.r020_db in ('1100', '1101', '1102', '1103', '1104', '1105', '1106', '1108', '1109')
                                       and t.r020_cr not in ('1107')
                                     )
                                     or
                                     (
                                       t.r020_cr in ('1100', '1101', '1102', '1103', '1104', '1105', '1106', '1108', '1109')
                                       and t.r020_cr not in ('1107')
                                     )
                                   )
                               and not (t.r020_db like '100%' and t.r020_cr like '100%')
                               and not (t.r020_db like '110%' and t.r020_cr like '110%')
                       ) t
                       join oper p on (t.kf = p.kf)
                                      and (t.ref = p.ref)
                       left join (
                                   select ref
                                          , tag
                                          , trim(substr(value, 1, 3)) d020
                                   from   operw
                                 ) w1 on (t.ref = w1.ref and w1.tag = 'D#73')
                       left join (
                                   select ref
                                          , tag
                                          , trim(substr(value, 1, 3)) d020
                                   from   operw
                                 ) w2 on (t.ref = w2.ref and w2.tag = '73' || t.tt)
                       left join tts t1 on (t.tt = t1.tt)    
                       left join nbur_dm_accounts ac on (t.kf = ac.kf)
                                                        and (t.acc_id = ac.acc_id)                                                                  
              where (p.sos = 5)
                    and (t.bal > 0)
      ) z;

    logger.info(c_title || ' data inserted into nbur_detail_protocols');

    -- формирование показателей файла  в  nbur_agg_protocols
    INSERT INTO nbur_agg_protocols (
                                     report_date
                                     , kf
                                     , report_code
                                     , nbuc
                                     , field_code
                                     , field_value
                                   )
       SELECT report_date
              , kf
              , report_code
              , nbuc
              , field_code
              , to_char(field_value)
         FROM (
                SELECT report_date
                       , kf
                       , report_code
                       , nbuc
                       , field_code
                       , SUM (field_value) field_value
                FROM   nbur_detail_protocols
                WHERE  report_date = p_report_date
                       AND report_code = p_file_code
                       AND kf = p_kod_filii
                       and field_code not like 'XXXXXX%' --Из отчета выбросим неопознаные коды операций
                GROUP BY
                       report_date
                       , kf
                       , report_code
                       , nbuc
                       , field_code
             );

  logger.info(c_title || ' into nbur_aggregate_protocol inserted ' || to_char(sql%rowcount) || ' rows');

  logger.info ('NBUR_P_F73X end for date = '||to_char(p_report_date, 'dd.mm.yyyy'));
END NBUR_P_F73X;
/
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/NBUR_P_F73X.sql =========*** End *** =
PROMPT ===================================================================================== 