
PROMPT ===================================================================================== 
PROMPT *** Run *** ======== Scripts /Sql/BARS/Procedure/NBUR_P_F3MX.sql ======== *** Run ***
PROMPT ===================================================================================== 

CREATE OR REPLACE PROCEDURE BARS.NBUR_P_F3MX (p_kod_filii  varchar2
                                            , p_report_date      date
                                            , p_form_id          number
                                            , p_scheme           varchar2 default 'C'
                                            , p_file_code        varchar2 default '#3M')
 IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 DESCRIPTION :    Процедура формирования 3MX для схема "C"
 COPYRIGHT   :    Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.

 VERSION     :    v.18.004      01.11.2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    параметры: p_report_date - отчетная дата

    строится по данным #C9 и #E2
    блок 1 #C9 для всех:        nbur_p_fc9.sql
    блок 2 #E2 для 300465:      nbur_p_fe2.sql ( часть для 300465 )
    блок 3 #E2 кроме 300465     вызов p_fe2_nn.sql
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
  ver_              char(30)  := ' v.18.004  01.11.2018';

  c_title           constant varchar2(100 char) := $$PLSQL_UNIT || '.';

  l_nbuc          varchar2(20);
  l_type          number;
  l_datez         date := p_report_date + 1;
  l_file_code     varchar2(2) := substr(p_file_code, 2, 2);

    l_version       number;
    l_file_id_C9       number          := 16757;               -- #C9
    l_file_id_E2       number          := 16950;               -- #E2

    l_kurs_840      number := F_NBUR_RET_KURS (840, p_report_date);
    l_gr_sum_840    number          := 0;   -- гранична сума
    l_gr_sum_980    number          := 0;   -- гранична сума    
    l_sum_kom       number          := gl.p_icurval(840, 100000, p_report_date);
    l_ourOKPO       varchar2(20)    := LPAD (F_Get_Params ('OKPO', NULL), 8, '0');
    l_ourGLB        varchar2(20);
    l_koef          number          := 0.5;      -- коефіцієнт обов^язкового продажу

    l_last_q003     number          := 0;

  --Exception
  e_ptsn_not_exsts exception;

  pragma exception_init( e_ptsn_not_exsts, -02149 );

-----------------------------------------------------------------------------------------------------
begin
  logger.info (c_title || ' begin for date = '||to_char(p_report_date, 'dd.mm.yyyy')||ver_);

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

  --Определяем версию файла для хранения детального протокола (сели рабочей нет, то ставим -1)
  l_version := coalesce(f_nbur_get_run_version(
                                                p_file_code => p_file_code
                                                , p_kf => p_kod_filii
                                                , p_report_date => p_report_date
                                               )
                           , -1);
-------------------------------------------
--       l_version :=303;

    begin
        select max(decode(glb, 0, '0', lpad(to_char(glb), 3, '0')))
        into l_ourGLB
        from rcukru
        where mfo = p_kod_filii;
    exception
        when no_data_found then
            l_ourGLB := null;
    end;

-- блок 1 ------------------------------------------------------------- вставка данных #C9
--                                                                      nbur_p_fc9.sql
  insert
    into NBUR_LOG_F3MX
       (REPORT_DATE, KF, NBUC, VERSION_ID, EKP, 
        KU, T071, Q003_1, F091, R030, F090, K040, F089, K020, K021, Q001_1,
        B010, Q033, Q001_2, Q003_2, Q007_1, F027, F02D, Q006,
        DESCRIPTION, ACC_ID, ACC_NUM, KV, CUST_ID, REF, BRANCH)
            select   report_date, kf, nbuc, l_version
                   , 'A3M001'                   EKP
                   ,  f_get_ku_by_nbuc(nbuc)    KU
                   ,  T071
                   ,  Q003_1
                   ,  '6'                       F091
                   ,  R030
                   ,  F090
                   ,  substr(trim(k040),1,3)    K040
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
                   , (case
                         when branch is null and acc_num is not null
                            then nvl((select branch from accounts a
                                       where a.nls=acc_num and a.kv=kv),null)
                            else branch
                       end)             as branch
--                   ,  branch
             from (
                     select   report_date, kf
                            , (case when l_type = 0 then l_nbuc else nbuc end) nbuc
                            , P20                        T071
                            , NNN                        Q003_1
                            , P10                        R030
--                            , f_nbur_get_f090('C9', e.ref, t.f090a)    F090
                            , f_nbur_get_f090('C9', ref, P40)    F090
                            , P62                        K040
                            , f_nbur_get_k020_by_rnk(cust_id)            K020
                            , cust_name                  Q001_1
                            , null                       B010
                            , null                       Q033
                            , null                       Q001_2
                            , null                       Q003_2
                            , null                       Q007_1
                            , '#'                        F027
                            , '#'                        F02D
                            , P99                        Q006
                            , description
                            , acc_id
                            , acc_num
                            , kv 
                            , cust_id
                            , ref   
                            , branch
                        from(select report_date, kf, ref, kv, cust_id, cust_name, acc_id, acc_num,
                                  lpad((dense_rank() 
                                       over 
                                         (order by nbuc, (case when flag_kons = 0 then to_char(ref) else p10||(case when p31 = '006' then p31 else '0' end) end) )
                                       ), 3, '0') nnn,
                                  p10, 
                                  p20, 
                                  (case when flag_kons = 0 then (case when p31 = '0' and p31_add is not null then p31_add else p31 end) else (case when p31 = '006' then p31 else '0' end) end) p31, 
                                  (case when flag_kons = 0 then p35 else '0' end) p35, 
                                  (case when flag_kons = 0 then p42 else '00' end) p42, 
                                  (case when flag_kons = 0 then p40 else '00' end) p40, 
                                  (case when flag_kons = 0 then p62 else '000' end) p62,
                                  (case when flag_kons = 0 then p99 else 'консолідація' end) p99, 
                                  sum_840, k030, nbuc, branch, description
                     from (select *
                              from ( select /*+ ordered */
                                            t.report_date, t.kf, t.ref, t.kv,
                                            c.cust_id, c.cust_name, t.acc_id_cr acc_id, t.acc_num_cr acc_num, 
                                            lpad((dense_rank() over (order by c.cust_id, t.ref)), 3, '0') nnn,
                                            lpad(t.kv, 3, '0') P10,
                                            TO_CHAR (ROUND (t.bal, 0)) P20,
                                            (case 
                                              when t.kf = '300465' and
                                                 ( t.acc_num_db like '1500%' or
                                                   t.acc_num_db like '1600%') and
                                                   t.acc_num_cr in ('29091000580557','29092000040557',
                                                                    '29095000081557','29091927',
                                                                    '2909003101','29095000046547',
                                                                    '292460205','292490204','29096000541557',
                                                                    '37394501547','37391006','373990351') or
                                                   c.CUST_CODE = l_ourOKPO and 
                                                   decode(o.dk, 1, O.ID_B, o.ID_A) = l_ourOKPO and t.acc_num_cr not like '2924%'
                                              then '006'
                                              when t.acc_num_cr like '2924%'
                                              then nvl(f_nbur_get_okpo(t.ref), 
                                                       replace(replace(replace(decode(o.dk, 1, O.ID_B, o.ID_A), '0000000000', '0'), '000000000', '0'), 
                                                               l_ourOKPO, '006'))
                                              when decode(o.dk, 1, O.ID_B, o.ID_A) <> l_ourOKPO
                                              then replace(replace(decode(o.dk, 1, O.ID_B, o.ID_A), '0000000000', '0'), '000000000', '0')
                                              when c.k030 = '1' and length(trim(c.cust_code))<=8
                                              then lpad(trim(c.cust_code), 8,'0')
                                              when c.k030 = '1' and
                                                   lpad(trim(c.cust_code), 10,'0') in ('99999','999999999','00000','000000000','0000000000')
                                              then '0'
                                              when c.k030 = '1' and length(trim(c.cust_code)) > 8
                                              then lpad(trim(c.cust_code), 10,'0')
                                              when c.k030 = '2'
                                              then '0'
                                              else '0'
                                            end) as P31,
                                            (case when c.k030 = '2' then null else (select trim(ser||' '||numdoc) from person where rnk=c.cust_id) end) p31_add,
                                            c.K030 as P35,
                                            (case
                                              when trim(p.d1#C9) is not null
                                              then trim(p.d1#C9)
                                              else
                                                case
                                                  when t.kf = '300465' and
                                                      ((t.acc_num_db like '1500%' or
                                                        t.acc_num_db like '1600%') and
                                                        t.acc_num_cr in ('29091000580557','29092000040557','29095000081557',
                                                                '29091927','2909003101','29095000046547',
                                                                '292460205','292490204','29096000541557',
                                                                '373900354','373910357','373910360','373920363',
                                                                '373930353','373940356','373950359',
                                                                '373950362','37395358','373960352','37397906547',
                                                                '373980361','37398355','373990351','373990364',
                                                                '37391006' ))
                                                  then '29'
                                                  when t.kf = '300465' and
                                                     ( t.acc_num_db like '1500%' or t.acc_num_db like '1600%' ) and
                                                       t.acc_num_cr in ('37394501547')
                                                  then '09'
                                                  when t.KF = '300465' and
                                                       t.ACC_NUM_DB like '1500%' and
                                                       n.NLS Is Not Null -- проверка наличия счета ДТ в справочнике систем переводов 13.01.2017
                                                  then '29'
                                                  else
                                                    case
                                                      when trim(lower(o.nazn)) like '%в_ручка%' or
                                                           trim(lower(o.nazn)) like '%комерц_йний%переказ%' or
                                                           t.acc_num_db like '2909%' and t.acc_num_cr like '2603%'
                                                      then '01'
                                                      when trim(lower(o.nazn)) like '%конверс%' or
                                                           trim(lower(o.nazn)) like '%конвертац%'
                                                      then '28'
                                                      when trim(lower(o.nazn)) like '%prepayment%' or
                                                           trim(lower(o.nazn)) like '%грош%' or
                                                           trim(lower(o.nazn)) like '%соц_альний%переказ%' or
                                                           trim(lower(o.nazn)) like '%переказ%' and t.acc_num_cr like '2620%' or
                                                           t.acc_num_db like '2909%' and t.acc_num_cr like '2620%'
                                                      then '30'
                                                      else '09'
                                                    end
                                                end
                                            end) as P40,
                                            '00' as P42,
                                            (case when nvl(trim(w.value), '804') <> '804' 
                                                  then lpad(trim(w.value), 3, '0') 
                                                  else nvl(f_nbur_get_kod_g(t.ref, 1), '000') 
                                            end) P62,
                                            trim(p.DD#70)   as P99,
                                            gl.p_ncurval(840, t.bal_uah, t.report_date) sum_840,
                                            c.k030,
                                            a.nbuc,
                                            o.branch,
                                            'Відібрані по довіднику ' description,
                                            (case when t.bal_uah > l_gr_sum_980 then 0 else 1 end) flag_kons
                                       from NBUR_DM_TRANSACTIONS t
                                       join NBUR_REF_SEL_TRANS r
                                         on (t.acc_num_db like r.acc_num_db||'%' and t.ob22_db = nvl(r.ob22_db, t.ob22_db) and
                                             t.acc_num_cr like r.acc_num_cr||'%' and t.ob22_cr = nvl(r.ob22_cr, t.ob22_cr) and
                                             t.kf = nvl(r.mfo, t.kf) and
                                             nvl(r.pr_del, 0) = 0 )
                                       left outer
                                       join NBUR_DM_ADL_DOC_RPT_DTL p
                                         on ( p.report_date = p_report_date and
                                              p.kf          = p_kod_filii   and
                                              p.ref         = t.ref         )
                                       join OPER o
                                         on ( o.ref = t.ref )
                                       left outer join OPERW w
                                         on (o.ref = w.ref and
                                             w.tag = 'KOD_G')
                                       join NBUR_DM_ACCOUNTS a
                                         on ( a.report_date = p_report_date and
                                              a.kf          = p_kod_filii   and
                                              a.acc_id      = t.acc_id_cr  )
                                       join NBUR_DM_CUSTOMERS c
                                         on ( c.report_date = p_report_date and
                                              c.kf          = p_kod_filii   and
                                              c.cust_id     = t.cust_id_cr  )
                                       left outer
                                       join OTCN_TRANSIT_NLS n
                                         on ( n.NLS = t.ACC_NUM_CR )
                                      where t.report_date = p_report_date
                                        and t.kf = p_kod_filii 
                                        and t.kv <> 980 
                                        and r.file_id = l_file_id_C9
                                        and ( lower(trim(o.nazn)) not like 'конв%'
                                              or
                                              lower(trim(o.nazn)) like 'конв%' and t.R020_DB = '1500' and t.R020_CR IN ('1819', '3540') )
                                        and t.ref not in (select ref from NBUR_TMP_DEL_70 where kodf = l_file_code and datf = p_report_date)
                                        and not (T.R020_DB = '2603' and T.R020_CR = '2600')
                                        and not (T.R020_DB = '1600' and T.R020_CR = '1600')
                                        and o.tt not in ('АСВ', 'R01')
                                        and NOT ( t.R020_DB IN ('1500','1600') and 
                                                  t.R020_CR = '2909'           AND
                                                  t.ACC_NUM_CR NOT IN ('29096000541557','29095000046547','29095000081557'
                                                                      ,'29091000580557','2909003101',    '29092000040557'
                                                                      ,'29091927') 
                                                )
                                        and not (t.R020_DB = '3739' and t.R020_CR = '2909' and T.OB22_CR = '66') 
                                        and not (t.R020_DB = '1600' and t.ACC_NUM_CR = '18199')
                                        and not (t.R020_DB = '3739' and t.R020_CR = '2603' and w.ref is null and lower(o.nazn) not like '%комерц%переказ%')
                                        and not (t.R020_DB = '3720' and t.R020_CR = '2909' and lower(o.nazn) like '%перерах%за%анульован%переказ%')
                                        and ( not (r.acc_num_db in ('1500', '1502', '1600') and r.acc_num_cr = '3800')
                                              or
                                              r.acc_num_db in ('1500', '1502', '1600') and
                                              r.acc_num_cr = '3800' and
                                              ( o.dk = 0 and (o.nlsa like '60%' or o.nlsa like '610%' or o.nlsa like '611%' )
                                                or
                                                o.dk = 1 and (o.nlsb like '60%' or o.nlsb like '610%' or o.nlsb like '611%')
                                              ) and
                                              gl.p_icurval (o.kv, o.s, p_report_date) > l_sum_kom   
                                            )
                    -----------------------------------------------------------
                                union all
                    -----------------------------------------------------------
                                        select /*+ ordered */
                                            t.report_date, t.kf, t.ref, t.kv,
                                            c.cust_id, c.cust_name, t.acc_id_cr acc_id, t.acc_num_cr acc_num, 
                                            lpad((dense_rank() over (order by c.cust_id, t.ref)), 3, '0') nnn,
                                            lpad(t.kv, 3, '0') P10,
                                            TO_CHAR (ROUND (t.bal, 0)) P20,
                                            (case 
                                              when t.kf = '300465' and
                                                 ( t.acc_num_db like '1500%' or
                                                   t.acc_num_db like '1600%') and
                                                   t.acc_num_cr in ('29091000580557','29092000040557',
                                                                    '29095000081557','29091927',
                                                                    '2909003101','29095000046547',
                                                                    '292460205','292490204','29096000541557',
                                                                    '37394501547','37391006','373990351') or
                                                   c.CUST_CODE = l_ourOKPO and 
                                                   decode(o.dk, 1, O.ID_B, o.ID_A) = l_ourOKPO and t.acc_num_cr not like '2924%'
                                              then '006'
                                              when t.acc_num_cr like '2924%'
                                              then nvl(f_nbur_get_okpo(t.ref), 
                                                       replace(replace(replace(decode(o.dk, 1, O.ID_B, o.ID_A), '0000000000', '0'), '000000000', '0'), 
                                                               l_ourOKPO, '006'))
                                              when decode(o.dk, 1, O.ID_B, o.ID_A) <> l_ourOKPO
                                              then replace(replace(decode(o.dk, 1, O.ID_B, o.ID_A), '0000000000', '0'), '000000000', '0')
                                              when c.k030 = '1' and length(trim(c.cust_code))<=8
                                              then lpad(trim(c.cust_code), 8,'0')
                                              when c.k030 = '1' and
                                                   lpad(trim(c.cust_code), 10,'0') in ('99999','999999999','00000','000000000','0000000000')
                                              then '0'
                                              when c.k030 = '1' and length(trim(c.cust_code)) > 8
                                              then lpad(trim(c.cust_code), 10,'0')
                                              when c.k030 = '2'
                                              then '0'
                                              else '0'
                                            end) as P31,
                                            (case when c.k030 = '2' then null else (select trim(ser||' '||numdoc) from person where rnk=c.cust_id) end) p31_add,
                                            c.K030 as P35,
                                            (case
                                              when trim(p.d1#C9) is not null
                                              then trim(p.d1#C9)
                                              else
                                                case
                                                  when t.kf = '300465' and
                                                      ((t.acc_num_db like '1500%' or
                                                        t.acc_num_db like '1600%') and
                                                        t.acc_num_cr in ('29091000580557','29092000040557','29095000081557',
                                                                '29091927','2909003101','29095000046547',
                                                                '292460205','292490204','29096000541557',
                                                                '373900354','373910357','373910360','373920363',
                                                                '373930353','373940356','373950359',
                                                                '373950362','37395358','373960352','37397906547',
                                                                '373980361','37398355','373990351','373990364',
                                                                '37391006' ))
                                                  then '29'
                                                  when t.kf = '300465' and
                                                     ( t.acc_num_db like '1500%' or t.acc_num_db like '1600%' ) and
                                                       t.acc_num_cr in ('37394501547')
                                                  then '09'
                                                  when t.KF = '300465' and
                                                       t.ACC_NUM_DB like '1500%' and
                                                       n.NLS Is Not Null -- проверка наличия счета ДТ в справочнике систем переводов 13.01.2017
                                                  then '29'
                                                  else
                                                    case
                                                      when trim(lower(o.nazn)) like '%в_ручка%' or
                                                           trim(lower(o.nazn)) like '%комерц_йний%переказ%' or
                                                           t.acc_num_db like '2909%' and t.acc_num_cr like '2603%'
                                                      then '01'
                                                      when trim(lower(o.nazn)) like '%конверс%' or
                                                           trim(lower(o.nazn)) like '%конвертац%'
                                                      then '28'
                                                      when trim(lower(o.nazn)) like '%prepayment%' or
                                                           trim(lower(o.nazn)) like '%грош%' or
                                                           trim(lower(o.nazn)) like '%соц_альний%переказ%' or
                                                           trim(lower(o.nazn)) like '%переказ%' and t.acc_num_cr like '2620%' or
                                                           t.acc_num_db like '2909%' and t.acc_num_cr like '2620%'
                                                      then '30'
                                                      else '09'
                                                    end
                                                end
                                            end) as P40,
                                            '00' as P42,
                                            (case when nvl(trim(w.value), '804') <> '804' 
                                                  then lpad(trim(w.value), 3, '0') 
                                                  else nvl(f_nbur_get_kod_g(t.ref, 1), '000') 
                                            end) P62,
                                            trim(p.DD#70)  as P99,
                                            gl.p_ncurval(840, t.bal_uah, t.report_date) sum_840,
                                            c.k030,
                                            a.nbuc,
                                            o.branch,
                                            'Додані користувачем ' description,
                                            (case when t.bal_uah > l_gr_sum_980 then 0 else 1 end) flag_kons
                                       from NBUR_DM_TRANSACTIONS t
                                       join NBUR_TMP_INS_70 r
                                        on (t.report_date = r.datf and
                                            t.kf = r.kf and
                                            t.ref = r.ref and
                                            r.kodf = l_file_code)
                                       left outer
                                       join NBUR_DM_ADL_DOC_RPT_DTL p
                                         on ( p.report_date = p_report_date and
                                              p.kf          = p_kod_filii   and
                                              p.ref         = t.ref         )
                                       join OPER o
                                         on ( o.ref = t.ref )
                                       left outer join OPERW w
                                         on (o.ref = w.ref and
                                             w.tag = 'KOD_G')
                                       join NBUR_DM_ACCOUNTS a
                                         on ( a.report_date = p_report_date and
                                              a.kf          = p_kod_filii   and
                                              a.acc_id      = t.acc_id_cr  )
                                       join NBUR_DM_CUSTOMERS c
                                         on ( c.report_date = p_report_date and
                                              c.kf          = p_kod_filii   and
                                              c.cust_id     = t.cust_id_cr  )
                                       left outer
                                       join OTCN_TRANSIT_NLS n
                                         on ( n.NLS = t.ACC_NUM_CR )
                                      where t.report_date = p_report_date
                                        and t.kf = p_kod_filii 
                                        and t.kv <> 980 
                                        and ( lower(trim(o.nazn)) not like 'конв%'
                                              or
                                              lower(trim(o.nazn)) like 'конв%' and t.R020_DB = '1500' and t.R020_CR IN ('1819', '3540') )
                                        and t.ref not in (select ref from NBUR_TMP_DEL_70 where kodf = l_file_code and datf = p_report_date)
                                        and not (T.R020_DB = '2603' and T.R020_CR = '2600')
                                        and not (T.R020_DB = '1600' and T.R020_CR = '1600')
                                        and o.tt not in ('АСВ', 'R01')
                                        and NOT ( t.R020_DB IN ('1500','1600') and 
                                                  t.R020_CR = '2909'           AND
                                                  t.ACC_NUM_CR NOT IN ('29096000541557','29095000046547','29095000081557'
                                                                      ,'29091000580557','2909003101',    '29092000040557'
                                                                      ,'29091927') 
                                                )
                                        and not (t.R020_DB = '3739' and t.R020_CR = '2909' and T.OB22_CR = '66') 
                                        and not (t.R020_DB = '1600' and t.ACC_NUM_CR = '18199')
                                        and not (t.R020_DB = '3739' and t.R020_CR = '2603' and w.ref is null and lower(o.nazn) not like '%комерц%переказ%')
                                        and not (t.R020_DB = '3720' and t.R020_CR = '2909' and lower(o.nazn) like '%перерах%за%анульован%переказ%')
                       )
                    where (substr(acc_num, 1, 2) not in ('15','16') OR
                           substr(acc_num, 1, 2) in ('15','16') and k030 = '2') and
                           nvl(p62, '000') not in ('804','UKR')
                    ) )
         ) ;

    commit;

   -- додаємо в кінець вже заповненого файлу
    select to_number(nvl(max(Q003_1),'0'))
    into l_last_q003
    from nbur_log_f3mx
    WHERE     report_date = p_report_date
          AND kf = p_kod_filii;

-- блок 2 ------------------------------------------------------------- вставка данных #E2 для 300465
--                                                                      nbur_p_fe2.sql
    if p_kod_filii = '300465' then

          insert into NBUR_TMP_TRANS_1 (REPORT_DATE, KF, REF, TT, RNK, ACC, NLS, KV,
              P10, P20, P31, P40, P62, REFD,
              D1#E2, D6#E2, D7#E2, D8#E2, DA#E2, KOD_G, NB, NAZN, BAL_UAH,
              P32, P51, P52, P53, P54, P55)
          select REPORT_DATE, a.KF, REF, TT, CUST_ID, ACC_ID, ACC_NUM, a.KV,
              P10, P20, lpad(P31, 10, '0') p31, substr(trim(D1#E2),1,2) P40, P62, REFD,
              substr(trim(D1#E2),1,2), D6#E2, D7#E2, D8#E2, DA#E2, KOD_G, NB, NAZN, BAL_UAH,
              nvl((case when ltrim(p31, '0') = '6' then 'АТ "ОЩАДБАНК"'
                        when k030 = '2' and cust_type = 1 then (select max(name) from rc_bnk where b010 = p31)
                        when k030 = '2' then cust_name
                        when to_number(p31) <> 0 then (select max(nmkk) from customer where okpo = p31 and (date_off is null or date_off>p_report_date))
                        else null
               end), 'Назва клієнта ') p32,
              (case when instr(upper(DA#E2), 'VISA')>0 or instr(upper(DA#E2), 'MASTERCARD')>0 then 'б/н' else nvl(p51, 'N контр.') end) p51, 
              (case when instr(upper(DA#E2), 'VISA')>0 then '20021997' 
                    when instr(upper(DA#E2), 'MASTERCARD')>0 then '09041997' 
                    else nvl(to_char(to_date(p52, 'dd/mm/yyyy'), 'ddmmyyyy'), 'дата контр') 
              end) p52, 
              nvl((case when instr(upper(DA#E2), 'VISA')>0 then 'МПС VISA' 
                        when instr(upper(DA#E2), 'MASTERCARD')>0 then 'МПС MASTERCARD'
                        when p51 is not null and p52 is not null then (select max(substr(benef_name,1,135)) 
                                                                       from v_cim_all_contracts c 
                                                                       where p51 = c.num and 
                                                                             to_date(p52, 'dd/mm/yyyy') = c.open_date and
                                                                             c.status_id in (0, 4, 5, 6, 8) and
                                                                             c.okpo = p31 and
                                                                             c.kv = p10
                                                                             )
                        else null
              end), nvl(f_get_swift_benef(ref), 'Назва бенефіціара '))  p53, 
              nvl(p54, '00') p54, 
              p55
          from (select /*+ ordered */
                  unique t.report_date, t.kf, t.ref, t.tt,
                  c.cust_id, c.cust_name, c.k030, c.cust_type,
                  t.acc_id_db acc_id, t.acc_num_db acc_num, t.kv,
                  lpad((dense_rank() over (order by t.ref)), 3, '0') nnn,
                  lpad(t.kv, 3, '0') P10,
                  trim(TO_CHAR(t.bal)) P20,
                  (case when
                          t.kf = '300465' and
                          t.acc_num_cr like '1500%' and
                          (t.acc_num_db in ('29091000580557',
                                           '29092000040557',
                                           '29095000081557',
                                           '29095000046547',
                                           '29091927',
                                           '2909003101',
                                           '292460205',
                                           '292490204') OR
                           substr(t.acc_num_db,1,4) = '1502')
                              or
                           C.CUST_CODE = l_ourOKPO and
                           not (substr(t.acc_num_db,1,4) = '1919' and substr(t.acc_num_cr,1,4) = '1500') and
                           not (o.nlsa like '1600%' and o.nlsb like '1500%') and
                           decode(o.dk, 1, O.ID_A, o.ID_B) = l_ourOKPO
                              or
                           o.nlsa like '3548%' and o.nlsb like '1500%'
                              or
                           (trim(c.CUST_CODE) = l_ourOKPO or c.cust_type = '1' and c.k040 = '804') and
                           not(substr(t.acc_num_db,1,4) = '1919' and substr(t.acc_num_cr,1,4) = '1500' and t.tt <> 'NOS') and
                           decode(o.dk, 1, O.ID_A, o.ID_B) = l_ourOKPO
                      then l_ourGLB
                      when (c.k030 = '2' or C.K040 <> '804') and c.cust_type = 1 
                      then (select trim(alt_bic) from custbank where rnk = c.cust_id)
                      when substr(t.acc_num_db,1,4) = '1919' and substr(t.acc_num_cr,1,4) = '1500' and t.tt <> 'NOS' or
                           o.nlsa like '1600%' and o.nlsb like '1500%'
                      then '0'
                      when decode(o.dk, 1, O.ID_A, o.ID_B) <> l_ourOKPO
                      then replace(replace(decode(o.dk, 1, O.ID_A, o.ID_B), '0000000000', '0'), '000000000', '0')
                      else
                          (case when c.k030 = '2' or C.K040 <> '804'
                                  then lpad(trim(c.cust_code), 10, '0')
                                when c.k030 = '1' and length(trim(c.cust_code))<=8 and trim(c.cust_code)<>l_ourOKPO
                                  then lpad(trim(c.cust_code), 8,'0')
                                when c.k030 = '1' and
                                     lpad(trim(c.cust_code), 10,'0') in
                                      ('99999','999999999','00000','000000000','0000000000')
                                  then '0'
                                when c.k030 = '1' and length(trim(c.cust_code)) > 8 and trim(c.cust_code)<>l_ourOKPO
                                  then lpad(trim(c.cust_code), 10,'0')
                                else
                                  l_ourGLB
                          end)
                  end) P31,
                  (case when t.kf = '300465' then
                       (case when t.acc_num_cr like '1500%' and
                                  t.acc_num_db in ('29091000580557',
                                                   '29092000040557',
                                                   '29095000081557',
                                                   '29095000046547',
                                                   '29091927',
                                                   '2909003101',
                                                   '292460205',
                                                   '292490204')
                                 then '37'
                              when t.acc_num_cr like '1500%' and
                                   t.acc_num_db in ('37394501547')
                                  then '31'
                              when t.acc_num_db like '1600%' and
                                   t.acc_num_cr like '1500%'
                              then '31'
                              when instr(lower(o.nazn),'конверс') > 0 
                              then '28'
                            else
                                 (case when trim(p.d1#e2) is not null
                                       then trim(p.d1#e2)
                                       else '00'
                                 end)
                       end)
                  else
                      (case when trim(p.d1#e2) is not null
                            then trim(p.d1#e2)
                            when trim(p.d1#70) is null and
                                 trim(p.d1#e2) is null and
                                 trim(o.nazn) is not null
                            then
                               (case when instr(lower(o.nazn),'грош') > 0 or
                                          instr(lower(o.nazn),'комерц') > 0 or
                                          instr(lower(o.nazn),'соц_альний переказ') > 0 or
                                          instr(lower(o.nazn),'переказ') > 0 and t.acc_num_db like '2620%'
                                   then '38'
                                   else '00'
                               end)
                            else
                              (case when trim(p.d1#e2) is not null
                                  then nvl(substr(trim(p.d1#e2), 1, 2), '00')
                                  else nvl(substr(trim(p.d1#70), 1, 2), '00')
                               end)
                      end)
                  end) D1#E2,
                  nvl((case when substr(trim(p.KOD_G),1,1) in ('O','P','О','П')
                          then SUBSTR (trim(p.KOD_G), 2, 3)
                          else SUBSTR (trim(p.KOD_G), 1, 3)
                       end),
                       substr(nvl(p.D6#70, p.D6#E2),1,3)) D6#E2,
                  substr(trim(nvl(p.D9#70, p.D7#E2)),1,10) D7#E2,
                  substr(trim(nvl(p.DA#70, p.D8#E2)),1,70) D8#E2,
                  substr(nvl(trim(z.value), trim(p.DD#70)),1,70) DA#E2,
                  (case when c.k040 <> '804' and
                             not (o.nlsa like '3548%' and o.nlsb like '1500%')
                               or
                             substr(t.acc_num_db,1,4) = '1919' and substr(t.acc_num_cr,1,4) = '1500' and t.tt <> 'NOS'
                        then '2'
                        when o.nlsa like '3548%' and o.nlsb like '1500%'
                        then '1'
                        else c.k030
                  end) P62,
                  to_number(trim(f_dop(t.ref, 'NOS_R'))) refd,
                  (case when nvl(b.kodc,'000') <> '000' then b.kodc
                        else SUBSTR (trim(p.KOD_G), 1, 3)
                  end) kod_g,
                  substr(trim(u.nb), 1, 70) nb,
                  substr(o.nazn,1,70) nazn, t.bal_uah,
                  c.cust_name p32,
                  trim(p.D2#70) p51, 
                  (case when is_date(replace(trim(p.D3#70), '.', '/'), 'dd/mm/yyyy') = 1  then replace(trim(p.D3#70), '.', '/') else null end) p52,
                  lpad(trim(z1.value), 2, '0') p54, 
                  '2' p55
              from NBUR_DM_TRANSACTIONS t
              join NBUR_REF_SEL_TRANS r
              on (t.acc_num_db like r.acc_num_db||'%' and
                  t.acc_num_cr like r.acc_num_cr||'%' and
                  t.kf = nvl(r.mfo, t.kf) and
                  nvl(r.pr_del, 0) = 0 )
              left outer join NBUR_DM_ADL_DOC_RPT_DTL p
              on (t.report_date = p.report_date and
                  t.kf = p.kf and
                  t.ref = p.ref)
              join NBUR_DM_CUSTOMERS c
              on (t.report_date = c.report_date and
                  t.kf = c.kf and
                  t.cust_id_db = c.cust_id)
              left outer join rcukru u
              on (trim(c.cust_type) = trim(u.ikod))
              join oper o
              on (t.ref = o.ref)
              left outer join operw z
              on (t.ref = z.ref and z.tag = 'DA#E2')
              left outer join operw z1
              on (t.ref = z1.ref and z1.tag = '12_2C')
              left outer join bopcount b
              on (b.iso_countr = SUBSTR (trim(p.KOD_N), 1, 3))
              where t.report_date = p_report_date and
                  t.kf = p_kod_filii and
                  t.kv not in (959, 961, 962, 964, 980) and
                  r.file_id = l_file_id_E2 and
                  t.ref not in (select ref from NBUR_TMP_DEL_70 where kodf = l_file_code and datf = p_report_date) and
                  not (o.nlsa like '1500%' and o.nlsb like '1500%' or
                       ((o.nlsa like '1500%' or o.nlsb like '1500%') and nvl(f_get_swift_country(t.ref), 'ZZZ') = '804') or -- 15/08/2017 (Дубина О.)
                       o.nlsa like '1919%' and o.nlsb like '1600%' and lower(o.nazn) like '%конвер%' or
                       o.nlsa like '19198%' and o.nlsb like '1600%' or
                       o.nlsa like '1600%' and o.nlsb like '1500%'  and c.k040 = '804' or
                       t.acc_num_db like '1600%' and c.k040 = '804' or
                       o.kf = '300465' and o.mfoa <> o.mfob or
                       t.kf = '300465' and t.r020_db in ('2600', '2620') and t.r020_cr in ('1919','2909','3739') and t.ref <> 88702330401 or
                       o.nlsa like '1500%' and (o.nlsb like '7100%' or o.nlsb like '7500%') and
                       o.dk=0 and round(t.bal_uah / l_kurs_840, 0) < 100000
                  ) and
                  -- виключаємо взаєморозрахунки ПрАТ "УФГ" (15/08/2017 Дубина О.)
                  not ((nlsa = '26507301976' or nlsb = '26507301976') and
                        (lower(nazn) like '%vzaimoraschet%po%sistem%' or
                         lower(nazn) like '%взаєморозрахун%по%систем%' or
                         lower(nazn) like '%взаиморасчет%по%систем%'))
            ) a;
      
          -- додане користувачем у довідник
          insert into NBUR_TMP_TRANS_1 (REPORT_DATE, KF, REF, TT, RNK, ACC, NLS, KV,
              P10, P20, P31, P40, P62, REFD,
              D1#E2, D6#E2, D7#E2, D8#E2, DA#E2, KOD_G, NB, NAZN, BAL_UAH)
          select REPORT_DATE, KF, REF, TT, CUST_ID, ACC_ID, ACC_NUM, KV,
              P10, P20, P31, substr(trim(D1#E2),1,2) P40, P62, REFD,
              substr(trim(D1#E2),1,2), D6#E2, D7#E2, D8#E2, DA#E2, KOD_G, NB, NAZN, BAL_UAH
          from (select /*+ ordered */
                  unique t.report_date, t.kf, t.ref, t.tt,
                  c.cust_id, t.acc_id_db acc_id, t.acc_num_db acc_num, t.kv,
                  lpad((dense_rank() over (order by t.ref)), 3, '0') nnn,
                  lpad(t.kv, 3, '0') P10,
                  trim( TO_CHAR (t.bal )) P20,
                  (case when
                          t.kf = '300465' and
                          t.acc_num_cr like '1500%' and
                          (t.acc_num_db in ('29091000580557',
                                           '29092000040557',
                                           '29095000081557',
                                           '29095000046547',
                                           '29091927',
                                           '2909003101',
                                           '292460205',
                                           '292490204') OR
                           substr(t.acc_num_db,1,4) = '1502')
                              or
                           C.CUST_CODE = l_ourOKPO and
                           not (substr(t.acc_num_db,1,4) = '1919' and substr(t.acc_num_cr,1,4) = '1500') and
                           not (o.nlsa like '1600%' and o.nlsb like '1500%') and
                           decode(o.dk, 1, O.ID_A, o.ID_B) = l_ourOKPO
                              or
                           o.nlsa like '3548%' and o.nlsb like '1500%'
                              or
                           (trim(c.CUST_CODE) = l_ourOKPO or c.cust_type = '1' and c.k040 = '804') and
                           not(substr(t.acc_num_db,1,4) = '1919' and substr(t.acc_num_cr,1,4) = '1500' and t.tt <> 'NOS') and
                           decode(o.dk, 1, O.ID_A, o.ID_B) = l_ourOKPO
                      then l_ourGLB
                      when substr(t.acc_num_db,1,4) = '1919' and substr(t.acc_num_cr,1,4) = '1500' and t.tt <> 'NOS' or
                           o.nlsa like '1600%' and o.nlsb like '1500%'
                      then '0'
                      when decode(o.dk, 1, O.ID_A, o.ID_B) <> l_ourOKPO
                      then replace(replace(decode(o.dk, 1, O.ID_A, o.ID_B), '0000000000', '0'), '000000000', '0')
                      else
                          (case when c.k030 = '2' or C.K040 <> '804'
                                  then lpad(trim(c.cust_code), 10, '0')
                                when c.k030 = '1' and length(trim(c.cust_code))<=8 and trim(c.cust_code)<>l_ourOKPO
                                  then lpad(trim(c.cust_code), 8,'0')
                                when c.k030 = '1' and
                                     lpad(trim(c.cust_code), 10,'0') in
                                      ('99999','999999999','00000','000000000','0000000000')
                                  then '0'
                                when c.k030 = '1' and length(trim(c.cust_code)) > 8 and trim(c.cust_code)<>l_ourOKPO
                                  then lpad(trim(c.cust_code), 10,'0')
                                else
                                  l_ourGLB
                          end)
                  end) P31,
                  (case when t.kf = '300465' then
                       (case when t.acc_num_cr like '1500%' and
                                  t.acc_num_db in ('29091000580557',
                                                   '29092000040557',
                                                   '29095000081557',
                                                   '29095000046547',
                                                   '29091927',
                                                   '2909003101',
                                                   '292460205',
                                                   '292490204')
                                 then '37'
                              when t.acc_num_cr like '1500%' and
                                   t.acc_num_db in ('37394501547')
                                  then '31'
                              when t.acc_num_db like '1600%' and
                                   t.acc_num_cr like '1500%'
                              then
                                 '31'
                            else
                                 (case when trim(p.d1#e2) is not null
                                       then trim(p.d1#e2)
                                       else '00'
                                 end)
                       end)
                  else
                      (case when trim(p.d1#e2) is not null
                            then trim(p.d1#e2)
                            when trim(p.d1#70) is null and
                                 trim(p.d1#e2) is null and
                                 trim(o.nazn) is not null
                            then
                               (case when instr(lower(o.nazn),'грош') > 0 or
                                          instr(lower(o.nazn),'комерц') > 0 or
                                          instr(lower(o.nazn),'соц_альний переказ') > 0 or
                                          instr(lower(o.nazn),'переказ') > 0 and t.acc_num_db like '2620%'
                                   then '38'
                                   else '00'
                               end)
                            else
                              (case when trim(p.d1#e2) is not null
                                  then nvl(substr(trim(p.d1#e2), 1, 2), '00')
                                  else nvl(substr(trim(p.d1#70), 1, 2), '00')
                               end)
                      end)
                  end) D1#E2,
                  nvl((case when substr(trim(p.KOD_G),1,1) in ('O','P','О','П')
                          then SUBSTR (trim(p.KOD_G), 2, 3)
                          else SUBSTR (trim(p.KOD_G), 1, 3)
                       end),
                       substr(nvl(p.D6#70, p.D6#E2),1,3)) D6#E2,
                  substr(trim(nvl(p.D9#70, p.D7#E2)),1,10) D7#E2,
                  substr(trim(nvl(p.DA#70, p.D8#E2)),1,70) D8#E2,
                  substr(nvl(trim(z.value), trim(p.DD#70)),1,70) DA#E2,
                  (case when c.k040 <> '804' and
                             not (o.nlsa like '3548%' and o.nlsb like '1500%')
                               or
                             substr(t.acc_num_db,1,4) = '1919' and substr(t.acc_num_cr,1,4) = '1500' and t.tt <> 'NOS'
                        then '2'
                        when o.nlsa like '3548%' and o.nlsb like '1500%'
                        then '1'
                        else c.k030
                  end) P62,
                  to_number(trim(f_dop(t.ref, 'NOS_R'))) refd,
                  (case when nvl(b.kodc,'000') <> '000' then b.kodc
                        else SUBSTR (trim(p.KOD_G), 1, 3)
                  end) kod_g,
                  substr(trim(u.nb), 1, 70) nb,
                  substr(o.nazn,1,70) nazn, t.bal_uah
              from NBUR_DM_TRANSACTIONS t
                  join NBUR_TMP_INS_70 r
                  on (t.report_date = r.datf and
                      t.kf = r.kf and
                      t.ref = r.ref and
                      r.kodf = l_file_code)
              left outer join NBUR_DM_ADL_DOC_RPT_DTL p
              on (t.report_date = p.report_date and
                  t.kf = p.kf and
                  t.ref = p.ref)
              join NBUR_DM_CUSTOMERS c
              on (t.report_date = c.report_date and
                  t.kf = c.kf and
                  t.cust_id_db = c.cust_id)
              left outer join rcukru u
              on (trim(c.cust_type) = trim(u.ikod))
              join oper o
              on (t.ref = o.ref)
              left outer join operw z
              on (t.ref = z.ref and z.tag = 'DA#E2')
             left outer join bopcount b
              on (b.iso_countr = SUBSTR (trim(p.KOD_N), 1, 3))
              where t.report_date = p_report_date and
                  t.kf = p_kod_filii and
                  t.kv not in (959, 961, 962, 964, 980) and
---                  t.ref not in (select ref from nbur_detail_protocols where report_code = p_file_code and report_date = p_report_date) and
                  t.ref not in (select ref from nbur_log_f3mx where report_date =p_report_date and kf =p_kod_filii) and
                  not (o.nlsa like '1500%' and o.nlsb like '1500%' or
                       ((o.nlsa like '1500%' or o.nlsb like '1500%') and nvl(f_get_swift_country(t.ref), 'ZZZ') = '804') or -- 15/08/2017 (Дубина О.)
                       o.nlsa like '1919%' and o.nlsb like '1600%' and lower(o.nazn) like '%конвер%' or
                       o.nlsa like '19198%' and o.nlsb like '1600%' or
                       o.nlsa like '1600%' and o.nlsb like '1500%'  and c.k040 = '804' or
                       t.acc_num_db like '1600%' and c.k040 = '804' or
                       o.kf = '300465' and o.mfoa <> o.mfob or
                       t.kf = '300465' and t.r020_db in ('2600', '2620') and t.r020_cr in ('1919','2909','3739') and t.ref <> 88702330401 or
                       o.nlsa like '1500%' and (o.nlsb like '7100%' or o.nlsb like '7500%') and
                       o.dk=0 and round(t.bal_uah / l_kurs_840, 0) < 100000
                  ) and
                  -- виключаємо взаєморозрахунки ПрАТ "УФГ" (15/08/2017 Дубина О.)
                  not ((nlsa = '26507301976' or nlsb = '26507301976') and
                        (lower(nazn) like '%vzaimoraschet%po%sistem%' or
                         lower(nazn) like '%взаєморозрахун%по%систем%' or
                         lower(nazn) like '%взаиморасчет%по%систем%'))
            );
      
         delete 
         from NBUR_TMP_TRANS_1
         where ref in (select b.refl
                       from NBUR_TMP_TRANS_1 a, oper b
                       where a.ref = b.ref and
                             b.refl is not null);
         commit;
                 
  insert
    into NBUR_LOG_F3MX
       (REPORT_DATE, KF, NBUC, VERSION_ID, EKP, 
        KU, T071, Q003_1, F091, R030, F090, K040, F089, K020, K021, Q001_1,
        B010, Q033, Q001_2, Q003_2, Q007_1, F027, F02D, Q006,
        DESCRIPTION, ACC_ID, ACC_NUM, KV, CUST_ID, REF, BRANCH)
            select   report_date, kf, nbuc, l_version
                   , 'A3M001'                   EKP
                   ,  f_get_ku_by_nbuc(nbuc)    KU
                   ,  T071
                   ,  Q003_1
                   ,  '5'                       F091
                   ,  R030
                   ,  F090
                   ,  substr(trim(k040),1,3)    K040
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
                   ,  branch
             from (
                     select   t.report_date, t.kf
                            , (case when l_type = 0 then l_nbuc else t.nbuc end) nbuc
                            , t.P20                        T071
                            , t.NNN                        Q003_1
                            , t.P10                        R030
--                            , f_nbur_get_f090('E2', e.ref, t.f090a)    F090
                            , f_nbur_get_f090('E2', t.ref, t.P40)    F090
                            , t.P64                        K040
                            , f_nbur_get_k020_by_rnk(t.cust_id)            K020
                            , t.cust_name                  Q001_1
                            , t.P65                        B010
                            , t.P66                        Q033
                            , t.P53                        Q001_2
                            , t.P51                        Q003_2
                            , (case
                                  when    length(trim(t.P52))=8 
                                      and regexp_instr(trim(t.P52),'^[0-9]+$')>0
                                     then
                                        substr(t.P52,1,2)||'.'||substr(t.P52,3,2)||'.'||substr(t.P52,5,4)
                                  else
                                     substr(trim(t.P52),1,10)
                                end)                     Q007_1
                            , decode( t.P54, null, '#', t.P54 )    F027
                            , decode( df.field_value, null, '#', df.field_value )    F02D
--                            , '#'    F02D
                            , t.P61                      Q006
                            , t.description
                            , (case
                                  when t.acc_id is null and t.acc_num is not null
                                     then nvl((select acc from accounts a
                                                where a.nls=t.acc_num and a.kv=t.kv),null)
                                     else t.acc_id
                                end)                     acc_id
                            , t.acc_num
                            , t.kv 
                            , t.cust_id
                            , t.ref   
                            , t.branch
                       from (
               select report_date, kf, ref, kv, cust_id, cust_name, acc_id, acc_num,
                     lpad((dense_rank()
                           over
                             (order by nbuc, (case when flag_kons = 0 then to_char(ref) else p10||(case when p31 = '006' then p31 else '0' end) end) )
                           )+l_last_q003, 3, '0') nnn,
                     p10,
                     p20,
                     (case when flag_kons = 0 then (case when p31 = '0' and p31_add is not null then p31_add else p31 end) else (case when ltrim(p31, '0') = '6' then p31 else '0' end) end) p31, 
                     (case when flag_kons = 0 then p32 else '0' end) p32,
                     p40,
                     (case when flag_kons = 0 then p51 else '0' end) p51,
                     (case when flag_kons = 0 then p52 else '0' end) p52,
                     (case when flag_kons = 0 then p53 else '0' end) p53,
                     (case when flag_kons = 0 then p54 else '0' end) p54,
                     (case when flag_kons = 0 then p55 else '1' end) p55,
                     p62,
                     p64,
                     (case when flag_kons = 0 then p65 else '0' end) p65,
                     (case when flag_kons = 0 then p66 else '0' end) p66,
                     (case when flag_kons = 0 then p61 else 'комісія банку' end) p61,
                     nbuc, branch, description
        FROM (select z.report_date,
                   z.kf,
                   z.ref,
                   z.rnk cust_id, c.cust_name,
                   z.acc acc_id,
                   z.nls acc_num,
                   z.kv,
                   z.p10,
                   z.p20,
                   z.p31,
                   (select trim(ser||' '||numdoc) from person where rnk=z.rnk) p31_add,
                   z.p32,
                   z.p40,
                   z.p51,
                   z.p52,
                   z.p53,
                   z.p54,
                   z.p55,
                   nvl(lpad(nvl(nvl(trim(translate(z.kod_g, '0123456789OPОП', '0123456789')),
                                    substr(trim (z.D6#E2), 1, 70)),
                                f_get_swift_country(z.ref)), 3, '0'),
                       'код краiни у яку переказана валюта' ) p64,
                   nvl(nvl(f_get_swift_bank_code(z.ref),substr(trim (z.D7#E2), 1, 10)),
                       rpad(nvl(nvl(trim (z.D7#E2), z.kod_g), '0000000000'), 10, '0')) p65,
                   nvl(nvl(f_get_swift_bank_name(z.ref), nvl(z.nb, substr(trim (z.D8#E2), 1, 70))),
                       'назва банку' ) p66,
                  (case when p_kod_filii = '300465' then (case when DA#E2 is not null then DA#E2 else z.nazn end)
                        when z.d1#E2 = '20' then 'Участь у капіталі'
                        when z.d1#E2 = '21' then 'Імпорт товарів, робіт, послуг'
                        when z.d1#E2 = '23' then 'Погашення клієнтом кредиту від нерезидента (не банку)'
                        when z.d1#E2 = '24' then 'Погашення банком кредиту від банку-нерезидента'
                        when z.d1#E2 = '26' then 'Надання кредиту нерезиденту'
                        when z.d1#E2 = '27' then 'Розміщення депозиту в нерезидента'
                        when z.d1#E2 = '28' then 'Конвертація'
                        when z.d1#E2 = '29' then 'Інвестиції'
                        when z.d1#E2 = '30' then 'Повернення депозиту'
                        when z.d1#E2 = '31' then 'Перерахування з іншою метою'
                        when z.d1#E2 = '32' then 'Доходи від інвестицій'
                        when z.d1#E2 = '33' then 'Користування кредитами, депозитами'
                        when z.d1#E2 = '34' then 'Погашення клієнтом кредиту, отриманого від банку'
                        when z.d1#E2 = '35' then 'Погашення банком кредиту від нерезидента (не банку)'
                        when z.d1#E2 = '36' then 'Повернення ІВ резидентами (не виконання зобовязань)'
                        when z.d1#E2 = '37' then 'Розрахунки за платіжними системами'
                        when z.d1#E2 = '38' then 'Приватні перекази'
                        when z.d1#E2 = '39' then 'Роялті'
                        when z.d1#E2 = '40' then 'Утримання представництва'
                        when z.d1#E2 = '41' then 'Податки'
                        when z.d1#E2 = '42' then 'Державне фінансування'
                        when z.d1#E2 = '43' then 'Платежі за судовими рішеннями'
                        when z.d1#E2 = '44' then 'За операціями з купівлі банківських металів'
                        else nvl(z.d61#E2, z.nazn)
                     end) p61,
                  z.p62, null refd, z.nbuc, z.branch, 'Part 1 ' description,
                  (case when bal_uah > l_gr_sum_980  or ltrim(p31, '0') <> '6' then 0 else 1 end) flag_kons
            from (select a.report_date,
                    a.kf, a.ref, a.tt, a.rnk, a.acc, a.nls, a.kv,
                    a.p10, a.p20, a.p31, a.p40, a.refd,
                    (case when t.id_oper is not null then to_char(20+t.id_oper) else a.D1#E2 end) D1#E2,
                    nvl(t.bankcountry, nvl(a.D6#E2, a.kod_g)) D6#E2,
                    rpad(nvl(trim(a.D7#E2), trim(t.bank_code)), 10, '0') D7#E2,
                    nvl(t.benefbank, a.D8#E2) D8#E2,
                    (case when r.kol_61 > 3
                          then 'оплата за'||to_char(r.kol_61)||'-ма ВМД'
                          when r.kol_61 = 1
                          then k.DC#E2||lpad(r.DC#E2_max, 6,'0')
                          else r.DC1#E2
                     end) D61#E2,
                    a.nb, substr(a.nazn, 1, 70) nazn,
                    a.p32, a.p51, a.p52, a.p53, a.p54, a.p55,
                    a.p62, a.kod_g, a.DA#E2, b.nbuc, b.branch, a.bal_uah
                from NBUR_TMP_TRANS_1 a
                left outer join (select ref, pid,
                                        min(pid) id_min,
                                        max(id) id,
                                        count(*) cnt
                                 from contract_p
                                 group by ref, pid) p
                on (a.ref = p.ref)
                left outer join NBUR_DM_ACCOUNTS b
                on (b.report_date = p_report_date and
                    b.kf = p_kod_filii and
                    b.acc_id = a.acc)
                left outer join top_contracts t
                on (p.pid = t.pid)
                left outer join (select t.pid, t.id,
                                       max(trim(t.name)) DC#E2_max,
                                       count(*) kol_61,
                                       LISTAGG(lpad(trim(c.cnum_cst),9,'#')||'/'||
                                               substr(c.cnum_year,-1)||'/'||
                                               trim(t.name)||' '||
                                               to_char(t.datedoc,'ddmmyyyy'),
                                                ',')
                                       WITHIN GROUP (ORDER BY t.pid, t.id, t.name) DC1#E2
                                from tamozhdoc t, customs_decl c
                                  where trim(c.cnum_num)=trim(t.name)
                                group by t.pid, t.id) r
                on (p.pid = r.pid and
                    p.id = r.id)
                left outer join (select t.pid, t.id, trim(t.name) name,
                                        trim(c.f_okpo) okpo,
                                        to_char(t.datedoc,'ddmmyyyy') D4#E2,
                                        lpad(trim(c.cnum_cst),9,'#')||'/'||
                                        substr(c.cnum_year,-1)||'/' DC#E2
                                  from tamozhdoc t, customs_decl c
                                  where trim(c.cnum_num)=trim(t.name)) k
                on (r.pid = k.pid and
                    r.id = k.id and
                    r.DC#E2_max = k.name and
                    k.okpo = a.p31)
                where nvl(nvl(a.d6#E2, a.kod_g), 'ZZZ') not in ('804','UKR')
                    and not ((a.nls like '1919%' or
                              a.nls like '3739%' ) and
                              a.tt = 'NOS')  )  z  join nbur_dm_customers c on (z.rnk = c.cust_id)
              ------------------------------------------------------------------
                     union all
              ------------------------------------------------------------------
            select z.report_date,
                   z.kf,
                   z.ref,
                   z.rnk, z.cust_name,
                   z.acc,
                   z.nls,
                   z.kv,
                   z.p10,
                   z.p20,
                   z.p31,
                   (select trim(ser||' '||numdoc) from person where rnk=z.rnk) p31_add,
                   z.p32,
                   z.p40,
                   z.p51,
                   z.p52,
                   z.p53,
                   z.p54,
                   z.p55,
                   nvl(lpad(nvl(nvl(trim(translate(z.kod_g, '0123456789OPОП', '0123456789')),
                                    substr(trim (z.D6#E2), 1, 70)),
                                f_get_swift_country(z.ref)), 3, '0'),
                       'код краiни у яку переказана валюта' ) p64,
                   nvl(nvl(substr(trim (z.D7#E2), 1, 10),
                       f_get_swift_bank_code(z.ref)),
                       rpad(nvl(trim (z.D7#E2), z.kod_g), 10, '0')) p65,
                   nvl(nvl(nvl(z.nb, substr(trim (z.D8#E2), 1, 70)), f_get_swift_bank_name(z.ref)),
                       'назва банку' ) p66,
                  (case when p_kod_filii = '300465' then (case when DA#E2 is not null then DA#E2 else z.nazn end)
                        when z.d1#E2 = '20' then 'Участь у капіталі'
                        when z.d1#E2 = '21' then 'Імпорт товарів, робіт, послуг'
                        when z.d1#E2 = '23' then 'Погашення клієнтом кредиту від нерезидента (не банку)'
                        when z.d1#E2 = '24' then 'Погашення банком кредиту від банку-нерезидента'
                        when z.d1#E2 = '26' then 'Надання кредиту нерезиденту'
                        when z.d1#E2 = '27' then 'Розміщення депозиту в нерезидента'
                        when z.d1#E2 = '28' then 'Конвертація'
                        when z.d1#E2 = '29' then 'Інвестиції'
                        when z.d1#E2 = '30' then 'Повернення депозиту'
                        when z.d1#E2 = '31' then 'Перерахування з іншою метою'
                        when z.d1#E2 = '32' then 'Доходи від інвестицій'
                        when z.d1#E2 = '33' then 'Користування кредитами, депозитами'
                        when z.d1#E2 = '34' then 'Погашення клієнтом кредиту, отриманого від банку'
                        when z.d1#E2 = '35' then 'Погашення банком кредиту від нерезидента (не банку)'
                        when z.d1#E2 = '36' then 'Повернення ІВ резидентами (не виконання зобовязань)'
                        when z.d1#E2 = '37' then 'Розрахунки за платіжними системами'
                        when z.d1#E2 = '38' then 'Приватні перекази'
                        when z.d1#E2 = '39' then 'Роялті'
                        when z.d1#E2 = '40' then 'Утримання представництва'
                        when z.d1#E2 = '41' then 'Податки'
                        when z.d1#E2 = '42' then 'Державне фінансування'
                        when z.d1#E2 = '43' then 'Платежі за судовими рішеннями'
                        when z.d1#E2 = '44' then 'За операціями з купівлі банківських металів'
                        else z.nazn
                     end) p61,
                  z.p62, z.refd, z.nbuc, z.branch,
                  'Part 2 ' description,
                  (case when bal_uah > l_gr_sum_980  or ltrim(p31, '0') <> '6' then 0 else 1 end) flag_kons
            from (select a.report_date,
                        a.kf,
                        a.ref,
                        a.tt,
                        c.cust_id rnk, c.cust_name,
                        t1.ACC_ID_DB acc,
                        t1.ACC_NUM_DB nls,
                        a.kv,
                        a.p10,
                        a.p20,
                        (case when c.cust_id is not null and (c.k030 = '2' or c.k040 <> '804') and c.cust_type = 1 then (select trim(alt_bic) from custbank where rnk = c.cust_id) else a.p31 end) p31,
                        (case when c.cust_id is not null and (c.k030 = '2' and c.cust_type = 1) then (select max(r.name) from custbank b, rc_bnk r where b.rnk = c.cust_id and r.b010 = trim(b.alt_bic)) else a.p32 end) p32,
                        nvl(decode(f.kva, 980, '30', '28'), a.p40) p40,
                        a.P62,
                        a.D6#E2,
                        a.D7#E2,
                        a.D8#E2,
                        a.KOD_G,
                        a.NB,
                        substr(a.NAZN, 1, 70) nazn,
                        nvl(decode(f.kva, 980, '30', '28'), a.p40) d1#E2,
                        t1.ref refd, a.DA#E2, b.nbuc, b.branch, a.bal_uah,
                        a.p51, a.p52, a.p53, a.p54, a.p55
                    from NBUR_TMP_TRANS_1 a
                    left outer join oper x
                    on (x.vdat between p_report_date - 7 and p_report_date
                        and x.nlsb = a.nls
                        and x.kv = a.kv
                        and x.refl = a.ref)
                    left outer join NBUR_DM_TRANSACTIONS t1
                    on (x.ref = t1.ref and
                        t1.report_date = a.report_date and
                        t1.kf = a.kf)
                    left outer join fx_deal f
                    on (f.refb=x.ref)
                    left outer join NBUR_DM_CUSTOMERS c
                    on (c.report_date = p_report_date and
                        c.kf = p_kod_filii and
                        f.rnk = c.cust_id)
                    left outer join NBUR_DM_ACCOUNTS b
                    on (b.report_date = p_report_date and
                        b.kf = p_kod_filii and
                        b.acc_id = t1.ACC_ID_DB)
                    where nvl(nvl(a.d6#E2, a.kod_g), 'ZZZ') not in ('804','UKR')
                          and ((a.nls like '1919%' or
                                a.nls like '3739%' ) and
                                a.tt = 'NOS')
                          and nvl(t1.tt, '***') like 'FX%'
                          and decode(f.kva, 980, '30', '28')<>'30') z
              ------------------------------------------------------------------
                     union all
              ------------------------------------------------------------------
              select z.report_date,
                   z.kf,
                   z.ref,
                   z.rnk, z.cust_name, 
                   z.acc,
                   z.nls,
                   z.kv,
                   z.p10,
                   z.p20,
                   z.p31,
                   (select trim(ser||' '||numdoc) from person where rnk=z.rnk) p31_add,
                   z.p32,
                   z.p40,
                   z.p51,
                   z.p52,
                   z.p53,
                   z.p54,
                   z.p55,
                   nvl(lpad(nvl(nvl(trim(translate(z.kod_g, '0123456789OPОП', '0123456789')),
                                    substr(trim (z.D6#E2), 1, 70)),
                                f_get_swift_country(z.ref)), 3, '0'),
                       'код краiни у яку переказана валюта' ) p64,
                   nvl(nvl(substr(trim (z.D7#E2), 1, 10),
                       f_get_swift_bank_code(z.ref)),
                       rpad(nvl(trim (z.D7#E2), z.kod_g), 10, '0')) p65,
                   nvl(nvl(nvl(z.nb, substr(trim (z.D8#E2), 1, 70)), f_get_swift_bank_name(z.ref)),
                       'назва банку' ) p66,
                  (case when p_kod_filii = '300465' then (case when DA#E2 is not null then DA#E2 else z.nazn end)
                        when z.d1#E2 = '20' then 'Участь у капіталі'
                        when z.d1#E2 = '21' then 'Імпорт товарів, робіт, послуг'
                        when z.d1#E2 = '23' then 'Погашення клієнтом кредиту від нерезидента (не банку)'
                        when z.d1#E2 = '24' then 'Погашення банком кредиту від банку-нерезидента'
                        when z.d1#E2 = '26' then 'Надання кредиту нерезиденту'
                        when z.d1#E2 = '27' then 'Розміщення депозиту в нерезидента'
                        when z.d1#E2 = '28' then 'Конвертація'
                        when z.d1#E2 = '29' then 'Інвестиції'
                        when z.d1#E2 = '30' then 'Повернення депозиту'
                        when z.d1#E2 = '31' then 'Перерахування з іншою метою'
                        when z.d1#E2 = '32' then 'Доходи від інвестицій'
                        when z.d1#E2 = '33' then 'Користування кредитами, депозитами'
                        when z.d1#E2 = '34' then 'Погашення клієнтом кредиту, отриманого від банку'
                        when z.d1#E2 = '35' then 'Погашення банком кредиту від нерезидента (не банку)'
                        when z.d1#E2 = '36' then 'Повернення ІВ резидентами (не виконання зобовязань)'
                        when z.d1#E2 = '37' then 'Розрахунки за платіжними системами'
                        when z.d1#E2 = '38' then 'Приватні перекази'
                        when z.d1#E2 = '39' then 'Роялті'
                        when z.d1#E2 = '40' then 'Утримання представництва'
                        when z.d1#E2 = '41' then 'Податки'
                        when z.d1#E2 = '42' then 'Державне фінансування'
                        when z.d1#E2 = '43' then 'Платежі за судовими рішеннями'
                        when z.d1#E2 = '44' then 'За операціями з купівлі банківських металів'
                        else z.nazn
                     end) p61,
                  z.p62, z.refd, z.nbuc, z.branch, 'Part 3 ' description,
                  (case when bal_uah > l_gr_sum_980 or ltrim(p31, '0') <> '6' then 0 else 1 end) flag_kons
            from (select a.report_date,
                        a.kf,
                        a.ref,
                        a.tt,
                        nvl(c.cust_id, a.rnk) rnk,  c.cust_name,
                        nvl(t1.ACC_ID_DB, a.acc) acc,
                        nvl(t1.ACC_NUM_DB, a.nls) nls,
                        nvl(b.kv, a.kv) kv,
                        a.p10,
                        a.p20,
                        (case when c.cust_id is not null and (c.k030 = '2' or c.k040 <> '804') and c.cust_type = 1 then (select trim(alt_bic) from custbank where rnk = c.cust_id) else a.p31 end) p31,
                        (case when c.cust_id is not null and (c.k030 = '2' and c.cust_type = 1) then (select max(r.name) from custbank b, rc_bnk r where b.rnk = c.cust_id and r.b010 = trim(b.alt_bic)) else a.p32 end) p32,
                        nvl(a.p40, decode(f.kva, 980, '30', '28')) p40,
                        a.p62,
                        nvl(t.bankcountry, nvl(a.D6#E2, a.kod_g)) D6#E2,
                        rpad(nvl(trim(D7#E2), trim(t.bank_code)), 10, '0') D7#E2,
                        nvl(t.benefbank, a.D8#E2) D8#E2,
                        (case when r.kol_61 > 3
                              then 'оплата за'||to_char(r.kol_61)||'-ма ВМД'
                              when r.kol_61 = 1
                              then k.DC#E2||lpad(r.DC#E2_max, 6,'0')
                              else r.DC1#E2
                         end) D61#E2,
                        a.KOD_G,
                        a.NB,
                        a.NAZN,
                        nvl(a.p40, decode(f.kva, 980, '30', '28')) d1#E2,
                        x.ref refd, a.DA#E2, b.nbuc, b.branch, a.bal_uah,
                        a.p51, a.p52, a.p53, a.p54, a.p55
                    from NBUR_TMP_TRANS_1 a
                    left outer join oper x
                    on (x.vdat between p_report_date - 7 and p_report_date
                        and x.nlsb = a.nls
                        and x.kv = a.kv
                        and x.refl = a.ref)
                    left outer join NBUR_DM_TRANSACTIONS t1
                    on (x.ref = t1.ref and
                        t1.report_date = a.report_date and
                        t1.kf = a.kf)
                    left outer join (select ref, pid,
                                            min(pid) id_min,
                                            max(id) id,
                                            count(*) cnt
                                     from contract_p
                                     group by ref, pid) p
                    on (a.ref = p.ref)
                    left outer join top_contracts t
                    on (p.pid = t.pid)
                    left outer join (select t.pid, t.id,
                                           max(trim(t.name)) DC#E2_max,
                                           count(*) kol_61,
                                           LISTAGG(lpad(trim(c.cnum_cst),9,'#')||'/'||
                                                   substr(c.cnum_year,-1)||'/'||
                                                   trim(t.name)||' '||
                                                   to_char(t.datedoc,'ddmmyyyy'),
                                                    ',')
                                           WITHIN GROUP (ORDER BY t.pid, t.id, t.name) DC1#E2
                                    from tamozhdoc t, customs_decl c
                                      where trim(c.cnum_num)=trim(t.name)
                                    group by t.pid, t.id) r
                    on (p.pid = r.pid and
                        p.id = r.id)
                    left outer join (select t.pid, t.id, trim(t.name) name,
                                            trim(c.f_okpo) okpo,
                                            to_char(t.datedoc,'ddmmyyyy') D4#E2,
                                            lpad(trim(c.cnum_cst),9,'#')||'/'||
                                            substr(c.cnum_year,-1)||'/' DC#E2
                                      from tamozhdoc t, customs_decl c
                                      where trim(c.cnum_num)=trim(t.name)) k
                    on (r.pid = k.pid and
                        r.id = k.id and
                        r.DC#E2_max = k.name and
                        k.okpo = a.p31)
                    left outer join fx_deal f
                    on (f.refb=x.ref)
                    left outer join NBUR_DM_ACCOUNTS b
                    on (b.report_date = p_report_date and
                        b.kf = p_kod_filii and
                        b.acc_id = t1.ACC_ID_DB)
                    left outer join NBUR_DM_CUSTOMERS c
                    on (c.report_date = p_report_date and
                        c.kf = p_kod_filii and
                        c.cust_id = b.cust_id)
                    where nvl(nvl(a.d6#E2, a.kod_g), 'ZZZ') not in ('804','UKR')
                          and ((a.nls like '1919%' or
                                a.nls like '3739%' ) and
                                a.tt = 'NOS')
                          and nvl(t1.tt, '***') not like 'FX%') z) 
                   ) t , 
                   ( select field_value, cust_id, acc_num, kv  from  v_nbur_#2d_dtl
                      where report_date = p_report_date
                        and kf     = p_kod_filii
                        and seg_01 = '40' ) df
     where t.P61 not like '%комісія банку%'
                        and df.cust_id(+) = t.CUST_ID
                        and df.acc_num(+) = t.ACC_NUM
                        and df.kv(+)      = t.KV  
 );

    else
-- блок 3 ------------------------------------------------------------- вставка данных #E2 все кроме 300465
--                                                                      p_fe2_nn.sql

      p_fe2_nn (p_report_date, 'C');


  insert
    into NBUR_LOG_F3MX
       (REPORT_DATE, KF, NBUC, VERSION_ID, EKP, 
        KU, T071, Q003_1, F091, R030, F090, K040, F089, K020, K021, Q001_1,
        B010, Q033, Q001_2, Q003_2, Q007_1, F027, F02D, Q006,
        DESCRIPTION, ACC_ID, ACC_NUM, KV, CUST_ID, REF, BRANCH)
            select   p_report_date, p_kod_filii, r2.nbuc, l_version
                   , 'A3M001'                      EKP
                   ,  f_get_ku_by_nbuc(r2.nbuc)    KU
                   ,  T071||'00'                   T071
                   ,  lpad( to_char(to_number(r.nnn)+l_last_q003), 3, '0')  Q003_1
                   ,  '5'                       F091
                   ,  R030
                   , f_nbur_get_f090('E2', r2.ref, r.f090)    F090 
                   ,  substr(trim(k040),1,3)    K040
                   ,  F089
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
                   , decode( df.field_value, null, '#', df.field_value )    F02D
                   ,  Q006
                   ,  r2.comm            as description
                   , (case
                         when r2.acc is null and r.nls is not null
                            then nvl((select acc from accounts a
                                       where a.nls=r.nls and a.kv=r.kv),null)
                            else r2.acc
                       end)                     acc_id
                   ,  r.nls             as acc_num
                   ,  r.kv     
                   ,  r.rnk             as cust_id
                   ,  r2.ref   
                   , (case
                         when r2.tobo is null and r.nls is not null
                            then nvl((select branch from accounts a
                                       where a.nls=r.nls and a.kv=r.kv),null)
                            else r2.tobo
                       end)             as branch
             from ( select nls, kv, rnk, nnn,
                           R030, T071, K020a, Q001_1, F090, Q003_2, Q007_1, Q001_2,
                           F027, F089, Q006, REZ, K040, B010, Q033,
                           f_nbur_get_k020_by_rnk(rnk)  K020
                      from (  select nls, kv, rnk, znap, 
                                     substr(kodp,1,2) ekp_1, substr(kodp,3,3) nnn
                                from rnbu_trace
                           )
                            pivot
                           ( max(trim(znap)) 
                                for ekp_1 in ('10' as R030, '20' as T071, '31' as K020a, '32' as Q001_1,
                                              '40' as F090, '51' as Q003_2, '52' as Q007_1, '53' as Q001_2,
                                              '54' as F027, '55' as F089, '61' as Q006, '62' as REZ,
                                              '64' as K040, '65' as B010, '66' as Q033 ) )
                  ) r,
                  ( select comm, acc, nls, kv, rnk, ref, tobo, trim(nbuc) nbuc, kodp
                      from rnbu_trace
                     where kodp like '20%'
                  ) r2,
                  ( select field_value, cust_id, acc_num, kv  from  v_nbur_#2d_dtl
                     where report_date = p_report_date
                       and kf     = p_kod_filii
                       and seg_01 = '40' ) df
     where r.Q006 not like '%комісія банку%'
                        and df.cust_id(+) = r.rnk
                        and df.acc_num(+) = r.nls
                        and df.kv(+)      = r.kv
               and r.rnk = r2.rnk  and r.nls = r2.nls
               and r.kv = r2.kv    and r.nnn = substr(r2.kodp,3,3)
                ;

    end if;

   -- додаємо в кінець вже заповненого файлу
    select to_number(nvl(max(Q003_1),'0'))
    into l_last_q003
    from nbur_log_f3mx
    WHERE     report_date = p_report_date
          AND kf = p_kod_filii;

--------------------------------------------------------------------- Сума що підлягає обов"язковому продажу                    
   insert
    into NBUR_LOG_F3MX
       (REPORT_DATE, KF, NBUC, VERSION_ID, EKP, 
        KU, T071, Q003_1, F091, R030, F090, K040, F089, K020, K021, Q001_1,
        B010, Q033, Q001_2, Q003_2, Q007_1, F027, F02D, Q006,
        DESCRIPTION, ACC_ID, ACC_NUM, KV, CUST_ID, REF, BRANCH)
            select   report_date, kf, nbuc, l_version
                   , 'A3M001'                   EKP
                   ,  KU
                   ,  T071
                   ,  Q003_1
                   ,  F091
                   ,  R030
                   ,  F090
                   ,  substr(trim(k040),1,3)    K040
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
                   ,  branch
             from (
                     select   report_date, kf, nbuc, f_get_ku_by_nbuc(nbuc)     KU
                            , P20                        T071
                            , '6'                        F091
                            , NNN                        Q003_1
                            , P10                        R030
--                            , f_nbur_get_f090('C9', e.ref, t.f090a)    F090
                            , '999'                      F090
                            , P62                        K040
                            , P31                        K020
                            , null                       Q001_1
                            , null                       B010
                            , null                       Q033
                            , null                       Q001_2
                            , null                       Q003_2
                            , null                       Q007_1
                            , '#'                        F027
                            , '#'                        F02D
                            , P99                        Q006
                            , null  description
                            , 0 acc_id
                            , null acc_num
                            , kv 
                            , 0 cust_id
                            , 0 ref   
                            , '/'||p_kod_filii||'/'  branch
                        from ( 
        select report_date, kf, l_nbuc nbuc , kv,
               lpad( (dense_rank() over (order by kv))+l_last_q003, 3, '0') nnn,
               p10,
               to_char(p20) p20, p31, p35, p40, p42, p62, p99
          from ( select o.report_date, o.kf, o.kv, 
                        LPAD(o.kv, 3, '0') as p10,
                        nvl(round((sum(z.s2) / 0.5), 0), 0) p20,
                        '0'         p31,
                        '1'         p35,
                        '36'        p40,
                        '00'        P42,
                        '804'       p62,
                        'Сума що підлягає обов"язковому продажу' p99
                   from NBUR_DM_TRANSACTIONS o
                   left outer
                   join ZAYAVKA z
                     on ( z.refoper = o.ref and
                          z.dk      = 2 and 
                          z.obz     = 1 )
                  where o.report_date = p_report_date
                    and o.kf =p_kod_filii
                    and o.R020_CR = '2603' 
                    and o.kv <> 980
                  group by o.report_date, o.kf, o.kv, LPAD (o.kv, 3, '0') )
                    ) ) 
      where t071 !=0;

    -- вставка даних для функції довведення допреквізитів            
    DELETE FROM OTCN_TRACE_70 WHERE kodf = l_file_code and datf = p_report_date and kf = p_kod_filii;

    insert into OTCN_TRACE_70(KODF, DATF, USERID, NLS, KV, ODATE, KODP, ZNAP, NBUC, ISP, RNK, ACC, REF, COMM, ND, MDATE, TOBO)
    select l_file_code, p_report_date, USER_ID, ACC_NUM, KV, p_report_date,
           q003_1||colname  FIELD_CODE,
           value            FIELD_VALUE,
           NBUC, null ISP, CUST_ID, ACC_ID, REF, DESCRIPTION, null ND, null mdate, BRANCH
      FROM ( select ACC_NUM, KV,
                    EKP, to_char(KU) KU, to_char(T071) T071, Q003_1, F091, R030, F090, K040, F089, K020, K021,
                    Q001_1, B010, Q033, Q001_2, Q003_2, Q007_1, F027, F02D, Q006,
                    NBUC, CUST_ID, ACC_ID, REF, DESCRIPTION, BRANCH
               from nbur_log_f3mx
              WHERE report_date = p_report_date
                AND kf = p_kod_filii
                AND F089 ='2'
           )
           UNPIVOT (VALUE FOR colname IN  (EKP, KU, T071, F091, R030, F090, K040, F089, K020, K021,
                                      Q001_1, B010, Q033, Q001_2, Q003_2, Q007_1, F027, F02D, Q006  ));     

   logger.info(c_title || ' end for date = '||to_char(p_report_date, 'dd.mm.yyyy'));
end;
/


PROMPT ===================================================================================== 
PROMPT *** End *** ======== Scripts /Sql/BARS/Procedure/NBUR_P_F3MX.sql ======== *** End ***
PROMPT ===================================================================================== 

