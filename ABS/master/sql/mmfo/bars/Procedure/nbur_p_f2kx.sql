PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/NBUR_P_F2KX.sql =========*** Run *** =
PROMPT ===================================================================================== 

PROMPT *** Create  procedure NBUR_P_F2KX ***


CREATE OR REPLACE PROCEDURE NBUR_P_F2KX (
                                           p_kod_filii        varchar2
                                           , p_report_date      date
                                           , p_form_id          number
                                           , p_scheme           varchar2 default 'C'
                                           , p_balance_type     varchar2 default 'S'
                                           , p_file_code        varchar2 default '2KX'
                                         )
is
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION : ��������� ������������ 2KX ��� �������� �����
% COPYRIGHT   : Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
%
% VERSION     :  v.16.004  14/16/2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
  ver_            char(30)  := 'v.27.004  27/04/2018';

  c_prefix        constant varchar2(100 char) := 'NBUR_P_F2KX';
  �_date_fmt      constant varchar2(10 char) := 'dd.mm.yyyy';

  l_nbuc          varchar2(20);
  l_type          number;
  l_datez         date := p_report_date + 1;
  l_file_code     varchar2(2) := substr(p_file_code, 2, 2);
  l_start_dt      date := trunc(p_report_date, 'MM'); --���� ������ ������ ��� ������ ��������
BEGIN
  logger.info (
                c_prefix
                || ' begin for date = ' || to_char(p_report_date, 'dd.mm.yyyy')
                || ' date_start=' || to_char(l_start_dt, 'dd.mm.yyyy')
              );

  -- ����������� ��������� ���������� (��� ������� ��� ��� ��� �������������)
  nbur_files.P_PROC_SET(p_kod_filii, p_file_code, p_scheme, l_datez, 0, l_file_code, l_nbuc, l_type);

  begin
    INSERT INTO nbur_detail_protocols(
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
        select
               p_report_date as report_date
               , p_kod_filii as kf
               , p_file_code as report_code
               , p_kod_filii as nbuc
               , segm_z || nnnn || field_code as field_code
               , field_value
               , null as description
               , acc_id
               , acc_num
               , kv
               , null as maturity_date
               , cust_id
               , ref
               , null as nd
               , null as branch
        from   (
                select tr.cust_id, tr.acc_id, tr.acc_num, tr.ref, tr.Q003_1 as nnnn, tr.K020_1 as segm_z, tr.R030_1 as kv                       
                       , tr.Q001_1, tr.Q002, tr.Q003_2, tr.Q003_3, tr.Q030, tr.K020_1, tr.K021_1, tr.Q006, tr.F086, tr.Q003_4
                       , tr.R030_1, tr.Q007_1, tr.Q007_2, tr.Q031_1, tr.T070_1, tr.T070_2, tr.F088, tr.Q007_3, tr.Q003_5, tr.Q001_2
                       , tr.K020_2, tr.K021_2, tr.Q001_3, tr.T070_3, tr.R030_2, tr.Q032, tr.Q031_1 as Q031_2, tr.Q003_1
                from   (               
                          select cust.cust_id
                                 , acc.acc_id
                                 , acc.acc_num  
                                 , tr.ref                                
                                 --��������� �������          
                                 , cust.cust_name as Q001_1
                                 , cust.cust_adr as Q002
                                 , cust.rnbor as Q003_2
                                 , coalesce(cust.rnbou, '����� �����') as Q003_3
                                 , coalesce(cust.rnbos, '����� �����') as Q030
                                 , case
                                     when cust.k070 like '13%'  then 'G'
                                     when cust.k070 in ('ZZZZZ', 'YYYYY') then 'D'
                                     when cust.cust_type = 3 and cust.k030 ='1' then '2' --������� ��������
                                   else
                                     '1'
                                   end as K021_1
                                 , lpad(cust.cust_code, 10, '0') as K020_1                 
                                 --��������� �����          
                                 , substr(trim(p.value), 1, 70) as Q006
                                 , case when acc.close_date is not null then '2' else '1' end as F086
                                 , acc.acc_num as Q003_4
                                 , lpad(acc.kv, 3, '0') as R030_1
                                 , to_char(acc.open_date, �_date_fmt) as Q007_1
                                 , to_char(acc.close_date, �_date_fmt) as Q007_2
                                 , case when (nvl(acc.BLC_CODE_DB,0) + nvl(acc.BLC_CODE_CR, 0)) <> 0 then '02' else '99' end as Q031_1
                                 , nvl(to_char(round(fostq(acc.acc_id, to_date(cust.rnbod, �_date_fmt)))), '0') as T070_1
                                 , nvl(to_char(round(fostq(acc.acc_id, p_report_date))), '0') as T070_2
                                 --��������� ��������       
                                 , (
                                     case 
                                       when tr.ref is null then '5' --���� ������ ��� �������� �� ����
                                       when acc.acc_id = tr.acc_id_db then '1' 
                                     else 
                                       '2' 
                                     end
                                   ) as F088
                                 , to_char(tr.operation_date, �_date_fmt) as Q007_3       
                                 , (case when acc.acc_id = tr.acc_id_db then tr.acc_num_cr else tr.acc_num_cr end) as Q003_5
                                 , substr(case when acc.acc_id = tr.acc_id_db then tr.cust_name_cr else tr.cust_name_db end, 1, 70) as Q001_2
                                 , lpad(case when acc.acc_id = tr.acc_id_db then tr.cust_okpo_cr else tr.cust_okpo_db end, 10, '0') as K020_2                
                                 , substr(case when acc.acc_id = tr.acc_id_db then tr.bank_name_db else tr.bank_name_cr end, 1, 70) as Q001_3
                                 , nvl(to_char(tr.bal_uah), '0') as T070_3
                                 , case
                                     when tr.ref is null then '#' --���� ������ ��� �������� �� ����
                                   else
                                     lpad(tr.kv, 3, '0')
                                   end as R030_2
                                 , tr.purpose_of_payment as Q032
                                 , case    
                                     when tr.ref is null then '#'  --���� ������ ��� �������� �� ����
                                     when pay_cust.cust_code is not null then   
                                                                           case
                                                                             when pay_cust.k070 like '13%' then 'G'
                                                                             when pay_cust.k070 in ('ZZZZZ', 'YYYYY') then 'D'
                                                                             when pay_cust.cust_type = 3 then
                                                                                                              case
                                                                                                                when regexp_instr(pay_cust.cust_code, '[^[:digit:]]') = 0 then '2'
                                                                                                              else
                                                                                                                '6'
                                                                                                              end
                                                                           else
                                                                             '1'
                                                                           end
                                   else
                                     case
                                       when length(trim(Decode(acc.acc_id, tr.acc_id_db, tr.cust_okpo_cr, tr.cust_okpo_db))) = 10 then 
                                            case 
                                              when regexp_instr(Decode(acc.acc_id, tr.acc_id_db, tr.cust_okpo_cr, tr.cust_okpo_db), '[^[:digit:]]') = 0 then '2'
                                            else  
                                              '6'
                                            end
                                     else
                                       '1'
                                     end
                                   end  as K021_2  
                                 , lpad(to_char(row_number() over (partition by lpad(cust.cust_code, 10, '0') order by acc.acc_id, tr.ref)), 4, '0') as Q003_1                                   
                          from   (
                                    select
                                           cust.cust_code, max(cust.k070) as k070, max(cust.cust_name) as cust_name, max(cust.cust_adr) as cust_adr
                                           , max(cust.cust_id) as cust_id, max(cust.cust_type) as cust_type, max(cust.k030) as k030, max(re.rnbor) rnbor
                                           , max(re.rnbou) rnbou, max(re.rnbos) rnbos, max(re.rnbod) rnbod
                                    from   (
                                             select *
                                             from (
                                                    select u.rnk
                                                           , u.tag
                                                           , case
                                                               when u.tag = 'RNBOD' then
                                                                                         case
                                                                                           when f_valid_date(u.value, 'dd/mm/yyyy') = 1 then to_char(to_date(u.value, 'dd/mm/yyyy'), �_date_fmt)
                                                                                           when f_valid_date(u.value, 'dd.mm.yyyy') = 1 then to_char(to_date(u.value, 'dd.mm.yyyy'), �_date_fmt)
                                                                                         else
                                                                                           null
                                                                                         end
                                                             else
                                                               substr(trim(u.value), 1, 20)
                                                             end as value
                                                    from   customerw u
                                                    where  exists (
                                                                    select 1
                                                                    from   customerw p
                                                                    where  p.tag = 'RNBOS'
                                                                           and instr(p.value, '01') + instr(p.value, '02') + instr(p.value, '03') + instr(p.value, '04') + instr(p.value,'05') + instr(p.value,'99') > 0
                                                                           and p.rnk = u.rnk
                                                                  )
                                                            and u.tag in ('RNBOR', 'RNBOU', 'RNBOS', 'RNBOD')
                                                  )
                                             pivot (max(trim(value)) for tag in ('RNBOR' as RNBOR, 'RNBOU' as RNBOU, 'RNBOS' as RNBOS, 'RNBOD' as RNBOD))
                                           ) re
                                           join nbur_dm_customers cust on (cust.kf = p_kod_filii)
                                                                          and (cust.cust_id = re.rnk)
                                                                                              
                                    where  1 = 1                            
                                           and trim(re.rnbor) is not null
                                           and trim(re.rnbod) is not null
                                           and (cust.close_date is null)
                                    group by
                                           cust.cust_code                                
                                 ) cust
                                 left join nbur_dm_accounts acc on (
                                                                     acc.kf = p_kod_filii
                                                                     and cust.cust_id = acc.cust_id
                                                                     and acc.nbs in (
                                                                                      '2512', '2513', '2520', '2523', '2525', '2530', '2541', '2542',
                                                                                      '2544', '2545', '2546', '2550', '2551', '2553', '2555', '2556',
                                                                                      '2560', '2561', '2562', '2565', '2600', '2604', '2605', '2610',
                                                                                      '2615', '2620', '2625', '2630', '2635', '2650', '2651', '2652',
                                                                                      '2655', '3320', '3330', '3340'
                                                                                    )
                                                                     and (
                                                                           acc.close_date is null
                                                                           or (
                                                                                acc.close_date is not null
                                                                                and acc.close_date >= to_date(cust.rnbod, �_date_fmt)
                                                                              )
                                                                         )                                                
                                                                   )
                                left join accountsw p on (
                                                           p.acc = acc.acc_id
                                                           and p.tag = '#2K_PRIM'
                                                         )
                                left join table(F_GET_ACC_TRANSACTION(acc.acc_id, l_start_dt, p_report_date)) tr on (tr.sos < 0) 
                                                                                                                    and (tr.r020_cr not like '65%')
                                left join (
                                            select *
                                            from   (
                                                     select cust_code, k070, cust_type, k030
                                                            , row_number() over (partition by cust_code order by cust.open_date desc) rn
                                                     from   nbur_dm_customers cust 
                                                     where  (cust.kf = p_kod_filii)
                                                   )
                                            where rn = 1
                                          ) pay_cust on (pay_cust.cust_code = decode(acc.acc_id, tr.acc_id_db, tr.cust_okpo_cr, tr.cust_okpo_db))
                       ) tr
        )
        unpivot (field_value for field_code in (
                                                   T070_1, T070_2, T070_3, Q003_1, Q001_1, Q002, K020_1, K021_1, Q003_2
                                                   , Q003_3, Q030, Q006, F086, Q003_4, R030_1, Q007_1, Q007_2, Q031_1, F088
                                                   , Q007_3, Q003_5, Q001_2, K020_2, K021_2, Q001_3, R030_2, Q032, Q031_2                                                   
                                              )
                );
  exception
    when others then
      logger.trace(c_prefix || ' error insert data ' || sqlerrm);
  end;

  logger.info (c_prefix || ' end for date = ' || to_char(p_report_date, 'dd.mm.yyyy'));
END;
/
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/NBUR_P_F2KX.sql =========*** End *** =
PROMPT ===================================================================================== 