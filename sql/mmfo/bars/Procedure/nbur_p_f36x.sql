PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/NBUR_P_F36X.sql =========*** Run *** =
PROMPT ===================================================================================== 

PROMPT *** Create  procedure NBUR_P_F36X ***

CREATE OR REPLACE PROCEDURE NBUR_P_F36X (
                                           p_kod_filii  varchar2
                                           , p_report_date      date
                                           , p_form_id          number
                                           , p_scheme           varchar2 default 'C'
                                           , p_file_code        varchar2 default '#36'
                                      )
is
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION : Процедура формирования 36X в формате XML для Ощадного банку
% COPYRIGHT   : Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
%
% VERSION     :  v.18.001 24/10/2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
  ver_                     char(30)  := 'v.18.001    24.10.2018';

  c_title                  constant varchar2(200 char) := $$PLSQL_UNIT;
  c_date_fmt               constant varchar2(10 char) := 'dd.mm.yyyy'; --Формат преобразования даты в строку
  c_amt_fmt                constant varchar2(50 char) := 'FM9999999999990D0000';  --Формат преобразования числа в строку
  
  c_EKPOK1                 constant varchar2(6 char) := 'A36001'; 

  l_datez                  date := p_report_date + 1;
  l_nbuc                   varchar2(20 char);
  l_file_code              varchar2(2 char) := substr(p_file_code, 2, 2);
  l_type                   number;
  
  l_file_id       nbur_ref_files.id%type := nbur_files.GET_FILE_ID(p_file_code => p_file_code);
  l_version_id    nbur_lst_files.version_id%type;  
  
  l_date_z_end            date;
  l_b040_8                varchar2(8 char);
  
  --Exception
  e_ptsn_not_exsts exception;

  pragma exception_init( e_ptsn_not_exsts, -02149 );  
BEGIN
  logger.info (
                c_title
                || ' begin for'
                || ' date = ' || to_char(p_report_date, c_date_fmt)
                || ' kod_filii=' || p_kod_filii
                || ' form_id=' || p_form_id
                || ' p_scheme= ' || p_scheme
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

  --Очистка партиции для хранения детального протокола
  begin
    execute immediate 'alter table NBUR_LOG_F36X truncate subpartition for ( to_date('''
                      || to_char(p_report_date,'YYYYMMDD')||''',''YYYYMMDD''), ''' || p_kod_filii || ''' )';
  exception
    when e_ptsn_not_exsts then
      null;
  end;

  --Определяем версию файла для хранения детальеного протокола
  l_version_id := f_nbur_get_run_version(p_file_code => p_file_code
                                          , p_kf => p_kod_filii
                                          , p_report_date => p_report_date
                                        );

  logger.trace(c_title || ' Version_id is ' || l_version_id);
  
  l_date_z_end := trunc(p_report_date, 'mm');
  l_b040_8 := '00626804';
  
  -- детальний протокол
  INSERT INTO nbur_log_f36X (report_date, kf, version_id, nbuc, ekp, ku, b040, f021,
    k020, k021, q001_1, q001_2, q002, q003_2, q003_3, q007_1, q007_2, q007_3, q007_4,
    q007_5, k040, d070, f008, k112, f019, f020, r030, q023, q006, t070, t071,
    acc_id, acc_num, kv, cust_id, branch)
  SELECT p_report_date as REPORT_DATE,
          p_kod_filii as KF,
          l_version_id AS VERSION_ID,
          p_kod_filii as NBUC,
          c_EKPOK1 as EKP, 
          f_get_ku_by_nbuc(p_kod_filii) as KU, 
          b040, 
          (case when p22 < 0 then 5 else p22 end) as F021, k020, 
          substr(F_NBUR_GET_K020_BY_RNK(rnk), 1, 1) as k021, 
          p06 as Q001_1, p08 as Q001_2, p07 as Q002, 
          to_char(row_number() over (order by k020, p17, p16, to_date(doc_date, 'ddmmyyyy')), 'fm0000')  as Q003_2, 
          p17 as Q003_3, p16 as Q007_1, p21 as Q007_2, p23 as Q007_3, p24 as Q007_4, 
          to_date(doc_date, 'ddmmyyyy') as Q007_5, lpad(p09, 3, '0') as K040, 
          p01 as D070, p18 as F008, p02 as K112, nvl(p20, '9') as F019, p19 as F020, 
          lpad(p14, 3, '0') as R030, 
          l_b040_8 || b041 as Q023, p27 as Q006, p13 as T070, p15 as T071, 
          null as ACC_ID, null as ACC_NUM, p14 as KV, rnk as CUST_ID, BRANCH        
  from (select case when a.p15 is null or a.p22=3 then a.f_b041 else a.b041 end as b041, 
               case when a.p15 is null or a.p22=3 then a.f_k020 else a.k020 end as k020,
               case when a.p15 is null or a.p22=3 then a.f_p01 else a.p01 end as p01,
               decode(a.p22, 3, nvl(a.f_p02_old, a.f_p02), a.p02) as p02, 
               decode(a.p22, 3, nvl(a.f_p06_old, a.f_p06), a.p06) as p06,
               substr(decode(a.p22, 3, nvl(a.f_p07_old, a.f_p07), a.p07), 1, 135) as p07, 
               decode(a.p22, 3, nvl(a.f_p08_old, a.f_p08), a.p08) as p08,
               decode(a.p22, 3, a.f_p09, a.p09) as p09, 
               decode(a.p22, 3, 0, cim_mgr.val_convert(to_date(l_date_z_end-1), a.p15, a.p14, 980)) as p13,
               nvl2(a.p15, a.p14, a.f_p14) as p14, decode(a.p22, 3, 0, a.p15) as p15, 
               case when a.p15 is null or a.m_p22=3 then a.f_p16 else a.p16 end as p16,
               case when a.p15 is null or a.m_p22=3 then a.f_p17 else a.p17 end as p17,
               decode(a.p22, 1, a.p18, a.f_p18) as p18, decode(a.p22, 3, a.f_p19, a.p19) as p19, 
               nvl2(a.p15, decode(a.p22, 1, a.p20, a.f_p20), a.f_p20) as p20,
               case when a.p15 is null or a.m_p22=3 then a.f_p21 else nvl(a.f_p21,a.p21) end as p21, 
               a.p22, decode(a.p22, 2, l_date_z_end, null) as p23,
               decode(a.p22, 3, case when a.p15=0 then a.max_pdat else null end, null) as p24, 
               case when a.p27=0 then null else to_char(a.p27, 'fm999') end as p27, a.doc_date,
               case when a.p22=2 and a.f_p21<>a.p21 then a.p21 else null end as p21_new, a.b040, branch, rnk
         from
         ( select nvl(m.m_p22,
                      case when x.p15=0 or 
                                x.p21<add_months(l_date_z_end,-120) or 
                                x.p15 is null 
                             then 3
                           when x.f_b041 is null 
                             then 1
                           when x.f_p02 != e.k112 or 
                                x.f_p06 != k.nmk or 
                                x.f_p07 != nvl(x.adr, k.adr) or 
                                x.f_p08 != substr(b.benef_name,1,135) or
                                x.f_p09 != b.country_id or 
                                x.f_p15 != x.p15 or 
                                x.f_p19 != x.p19 
                             then 2 
                           else -1 
                      end) as p22,
                      x.b041, x.k020, x.p01, e.k112 as p02, x.f_p02, x.f_p02_old, k.nmk as p06 , 
                      x.f_p06, x.f_p06_old, nvl(x.adr, k.adr) as p07, x.f_p07, x.f_p07_old,
                      substr(b.benef_name,1,135) as p08, x.f_p08, x.f_p08_old, x.f_p09, x.p14, x.p15, 
                      to_char(b.country_id, 'fm000') as p09, x.p16, x.p17, x.p18, x.f_p18,
                      x.p19, x.f_p19, x.p20, x.f_p20, x.p21, x.max_pdat, x.contr_id, x.doc_date,
                      x.f_b041, x.f_k020, x.f_p01, x.f_p14, x.f_p16, x.f_p17, x.f_p21, x.f_p21_new, 
                      m.m_p22, x.p27, x.b040, x.branch, x.rnk
             from
             ( select x.*, 
                      (select substr(b.b040,9,12) from branch b where b.branch=x.branch) as b041,
                      (select b.b040 from branch b where b.branch=x.branch) as b040,
                      (select nvl2(zip, zip || ', ', '') || 
                              case when upper(domain) like '%МІСТО%' and upper(domain) like '%'||upper(locality)||'%' 
                                      then '' else nvl2(domain, domain || ', ', '') end ||
                              case when upper(region) like '%МІСТО%' and upper(region) like '%'||upper(locality)||'%' 
                                      then '' else nvl2(region, region || ', ', '') end ||
                              nvl2(locality, locality || ', ', '') || address
                         from customer_address a where a.type_id=1 and a.rnk=x.rnk) as adr,
                      nvl2(x.min_ddat, 
                           case when x.p21+1095<l_date_z_end then 4 else 0 end,
                           case when x.p21+1095<l_date_z_end then 1 else 2 end) as p19
                 from
                 ( select min(d.min_ddat) as min_ddat, max(d.max_pdat) as max_pdat, d.p01, d.p14, 
                          d.p21, sum(d.p15) as p15, max(d.p20) as p20,
                          c.branch, max(c.rnk) as rnk, c.benef_id, lpad(c.okpo,10,'0') as k020, 
                          c.num as p17, c.open_date as p16, min(t.subject_id)+1 as p18,
                          max(f.b041) as f_b041, max(f.p02) as f_p02, max(f.p06) as f_p06, 
                          max(f.p07) as f_p07, max(f.p08) as f_p08,
                          max(f.p09) as f_p09, max(f.p15) as f_p15, max(f.p18) as f_p18, 
                          max(f.p19) as f_p19, max(f.p20) as f_p20,
                          max(f.p02_old) as f_p02_old, max(f.p06_old) as f_p06_old, 
                          max(f.p07_old) as f_p07_old, max(f.p08_old) as f_p08_old,
                          max(d.contr_id) as contr_id, nvl(d.doc_date, f.doc_date) as doc_date, 
                          max(f.k020) as f_k020, max(f.p01) as f_p01,
                          max(f.p14) as f_p14, max(f.p16) as f_p16, max(f.p17) as f_p17,
                          max(f.p21) as f_p21, max(f.p21_new) as f_p21_new, max(t.p27_f531) as p27
                     from
                     ( select to_char(max(d.doc_date),'ddmmyyyy') as doc_date, max(d.contr_id) as contr_id, 
                              max(d.p14) as p14, max(d.p21) as p21,
                              decode(max(d.d_k), 0, 2, 1) as p01, max(d.p20) as p20, 
                              min(case when d.l_doc_date>last_day(d.p21) then d.l_doc_date else null end) as min_ddat,
                              max(l_create_date) as max_pdat, round( (1-nvl(sum(d.ls), 0)/max(d.s_vk))*max(d.s), 0) as p15
                         from
                         ( select d.p14, d.p21, d.p20, d.d_k, d.type_id, d.bound_id, d.contr_id, d.s, d.s_vk, d.doc_date, d.ls, d.l_create_date,
                                  decode(d.d_k, 0, nvl2(d.vmd_id, (select v.dat from customs_decl v join cim_vmd_bound b on v.cim_id=b.vmd_id where b.bound_id=d.vmd_id),
                                                                  (select v.allow_date from cim_acts v join cim_act_bound b on v.act_id=b.act_id where b.bound_id=d.act_id)),
                                                   nvl2(d.payment_id, (select v.vdat from oper v join cim_payments_bound b on v.ref=b.ref where b.bound_id=d.payment_id),
                                                                      (select v.val_date from cim_fantom_payments v join cim_fantoms_bound b on v.fantom_id=b.fantom_id where b.bound_id=d.fantom_id))
                                        ) as l_doc_date
                             from
                             ( select o.kv as p14, cim_mgr.get_control_date(0, 0, d.bound_id, d.pay_flag)+1 as p21, d.borg_reason as p20,
                                      0 as d_k, 0 as type_id, d.bound_id, d.contr_id, (d.s+d.comiss) as s, d.s_cv as s_vk, 
                                      NVL( (SELECT MAX (fdat) FROM opldok WHERE REF = o.REF ), o.vdat ) as doc_date,
                                      l.s as ls, l.create_date as l_create_date, l.payment_id, l.fantom_id, l.vmd_id, l.act_id
                                 from cim_payments_bound d JOIN oper o ON o.REF = d.REF
                                      left outer join cim_link l on l.delete_date is null and l.create_date<l_date_z_end  and l.payment_id=d.bound_id
                                where d.delete_date is null and
                                      d.contr_id is not null and contr_id != 0
                                  and d.branch like sys_context('bars_context', 'user_mfo_mask')
                               union all
                               select f.kv as p14, cim_mgr.get_control_date(0, f.payment_type, d.bound_id, d.pay_flag)+1 as p21, d.borg_reason as p20,
                                      0 as d_k, f.payment_type as type_id, d.bound_id, d.contr_id, (d.s+d.comiss) as s, d.s_cv as s_vk, f.val_date as doc_date,
                                      l.s as ls, l.create_date as l_create_date, l.payment_id, l.fantom_id, l.vmd_id, l.act_id
                                 from cim_fantoms_bound d JOIN cim_fantom_payments f ON f.fantom_id = d.fantom_id
                                      left outer join cim_link l on l.delete_date is null and l.create_date<l_date_z_end  and l.fantom_id=d.bound_id
                                where d.delete_date is null and
                                       f.payment_type in (1, 4) and d.contr_id is not null and contr_id != 0
                                  and d.branch like sys_context('bars_context', 'user_mfo_mask')
                               union all
                               select v.kv as p14, cim_mgr.get_control_date(1, 0, d.bound_id)+1 as p21, d.borg_reason as p20,
                                      1 as d_k, 0 as type_id, d.bound_id, d.contr_id, d.s_vt as s, d.s_vk, v.allow_dat as doc_date,
                                      l.s as ls, l.create_date as l_create_date, l.payment_id, l.fantom_id, l.vmd_id, l.act_id
                                 from cim_vmd_bound d join customs_decl v on v.cim_id=d.vmd_id
                                      left outer join cim_link l on l.delete_date is null and l.create_date<l_date_z_end  and l.vmd_id=d.bound_id
                                where d.delete_date is null
                                  and d.branch like sys_context('bars_context', 'user_mfo_mask')
                               union all
                               select v.kv as p14, cim_mgr.get_control_date(1, v.act_type, d.bound_id)+1 as p21, d.borg_reason as p20,
                                      1 as d_k, v.act_type as type_id, d.bound_id, d.contr_id, d.s_vt as s, d.s_vk, v.allow_date as doc_date,
                                      l.s as ls, l.create_date as l_create_date, l.payment_id, l.fantom_id, l.vmd_id, l.act_id
                                 from cim_act_bound d join cim_acts v on v.act_type in (1, 3, 4) and v.act_id=d.act_id
                                      left outer join cim_link l on l.delete_date is null and l.create_date<l_date_z_end  and l.act_id=d.bound_id
                                where d.delete_date is null
                                  and d.branch like sys_context('bars_context', 'user_mfo_mask') ) d ) d
                       group by d.d_k, d.type_id, d.bound_id ) d
                     join cim_contracts c on c.contr_type+1=d.p01 and c.contr_id=d.contr_id
                     join cim_contracts_trade t on t.contr_id=d.contr_id
                     full outer join v_cim_f36 f
                       on f.b041 != 0 and f.p01=d.p01 and f.p14=d.p14 and f.doc_date=d.doc_date and 
                          nvl(f.p21_new, f.p21)=d.p21 and f.k020=lpad(c.okpo,10,'0') and f.p16=c.open_date and 
                          f.p17=c.num and f.branch like sys_context('bars_context', 'user_mfo_mask')
                    where f.p22 is not null or d.p21>=l_date_z_end-3653 and d.p21<l_date_z_end and d.p15>0
                   group by c.benef_id, c.branch, c.okpo, c.num, c.open_date, d.p14, d.p21, d.p01, d.doc_date, 
                            f.p01, f.p14, f.p21, f.k020, f.p16, f.p17, f.doc_date) x ) x
             left outer join customer k on k.rnk=x.rnk
             left outer join cim_beneficiaries b on b.benef_id=x.benef_id
             left outer join kl_k110 e on e.d_close is null and e.k110=k.ved
             left outer join ( select 3 as m_p22 from dual union all select 1 as m_p22 from dual ) m
               on x.b041 != x.f_b041 and x.p15>0 and x.f_b041 is not null and x.p15 is not null ) a
              --where a.p22<=0 
              )
  order by b041, k020, p17, p08, p16, p21, p01; 

  logger.info (c_title || ' end for date = '||to_char(p_report_date, c_date_fmt));
END NBUR_P_F36X;
/
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/NBUR_P_F36X.sql =========*** End *** =
PROMPT ===================================================================================== 