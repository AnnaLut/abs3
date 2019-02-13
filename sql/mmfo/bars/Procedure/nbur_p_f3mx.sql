
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

 VERSION     :    v.19.005      08.02.2019
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    параметры: p_report_date - отчетная дата

    строится по данным #C9 и #E2
    блок 1 #C9  для всех:         nbur_p_fc9.sql
    блок 2 #E2  для 300465:       nbur_p_fe2.sql ( часть для 300465 )
    блок 3 #E2  кроме 300465:     переработанный алгоритм из p_fe2_nn.sql
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
  ver_              char(30)  := ' v.19.005  08.02.2019';

  c_title           constant varchar2(100 char) := $$PLSQL_UNIT || '.';

  l_nbuc          varchar2(20);
  l_type          number;
  l_datez         date := p_report_date + 1;
  l_file_code     varchar2(2) := substr(p_file_code, 2, 2);

    l_version       number;
    l_file_id       number;

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
  nbur_files.P_PROC_SET(p_kod_filii, p_file_code, p_scheme, l_datez, 0, l_file_code, l_nbuc, l_type);
  
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

    begin
        select max(decode(glb, 0, '0', lpad(to_char(glb), 3, '0')))
        into l_ourGLB
        from rcukru
        where mfo = p_kod_filii;
    exception
        when no_data_found then
            l_ourGLB := null;
    end;

    select id  into l_file_id
       from nbur_ref_files
      where file_code =p_file_code;

-- блок 1 ------------------------------------------------------------- вставка данных #C9
--                                                                      nbur_p_fc9.sql
  insert
    into NBUR_LOG_F3MX
       (REPORT_DATE, KF, NBUC, VERSION_ID, EKP, 
        KU, T071, Q003_1, F091, R030, F090, K040, F089, K030, K020, K021, Q001_1,
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
                   , K030
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
                            , P35                        K030
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
                                  p35, 
                                  (case when flag_kons = 0 then p42 else '00' end) p42, 
                                  (case when flag_kons = 0 then p40 else '00' end) p40, 
                                  (case when flag_kons = 0 then p62 else '000' end) p62,
                                  (case when flag_kons = 0 then p99 else 'консолідація' end) p99, 
                                  sum_840, k030, nbuc, branch, description
                     from (select *
                              from ( select /*+ ordered */
                                            t.report_date, t.kf, t.ref, t.kv,
                                            c.rnk cust_id, c.nmk cust_name, t.acc_id_cr acc_id, t.acc_num_cr acc_num, 
                                            lpad((dense_rank() over (order by c.rnk, t.ref)), 3, '0') nnn,
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
                                                   c.okpo = l_ourOKPO and 
                                                   decode(o.dk, 1, O.ID_B, o.ID_A) = l_ourOKPO and t.acc_num_cr not like '2924%'
                                              then '006'
                                              when t.acc_num_cr like '2924%'
                                              then nvl(f_nbur_get_okpo(t.ref), 
                                                       replace(replace(replace(decode(o.dk, 1, O.ID_B, o.ID_A), '0000000000', '0'), '000000000', '0'), 
                                                               l_ourOKPO, '006'))
                                              when decode(o.dk, 1, O.ID_B, o.ID_A) <> l_ourOKPO
                                              then replace(replace(decode(o.dk, 1, O.ID_B, o.ID_A), '0000000000', '0'), '000000000', '0')
                                              when NVL(to_char(2 - MOD(c.CODCAGENT, 2)), '1') ='1' and length(trim(c.okpo))<=8   --c.k030
                                              then lpad(trim(c.okpo), 8,'0')
                                              when NVL(to_char(2 - MOD(c.CODCAGENT, 2)), '1') ='1' and   --c.k030
                                                   lpad(trim(c.okpo), 10,'0') in ('99999','999999999','00000','000000000','0000000000')
                                              then '0'
                                              when NVL(to_char(2 - MOD(c.CODCAGENT, 2)), '1') ='1' and length(trim(c.okpo)) > 8  --c.k030
                                              then lpad(trim(c.okpo), 10,'0')
                                              when NVL(to_char(2 - MOD(c.CODCAGENT, 2)), '1') ='2'   --c.k030
                                              then '0'
                                              else '0'
                                            end) as P31,
                                            (case when NVL(to_char(2 - MOD(c.CODCAGENT, 2)), '1') ='2' then null else (select trim(ser||' '||numdoc) from person where rnk=c.rnk) end) p31_add,
                                            NVL(to_char(2 - MOD(c.CODCAGENT, 2)), '1') as P35,    --c.k030
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
                                                           t.acc_num_db like '2909%' and t.acc_num_cr like '2603%' or
                                                           t.acc_num_db like '3720%' and t.acc_num_cr like '2603%'
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
                                            NVL(to_char(2 - MOD(c.CODCAGENT, 2)), '1') k030,        --c.k030,
                                            a.nbuc,
                                            o.branch,
                                            'Відібрані по довіднику ' description,
                                            (case when t.bal_uah > l_gr_sum_980 then 0 else 1 end) flag_kons
----------
                                       from ( select  q.report_date, q.kf, q.ref, q.kv, q.bal, q.bal_uah,
                                                      q.cust_id_db, q.r020_db, q.acc_id_db, q.acc_num_db, q.ob22_db,
                                                      (case
                                                          when  q.r020_cr ='2924' --and p_kod_filii !='300465'
                                                            then nvl( (select a.rnk
                                                                         from oper o, accounts a
                                                                        where o.ref = q.ref
                                                                          and a.kv = o.kv
                                                                          and a.nls = o.nlsb), q.cust_id_cr)
                                                          else q.cust_id_cr
                                                        end)          cust_id_cr,
                                                       q.r020_cr, q.acc_id_cr, q.acc_num_cr, q.ob22_cr,
                                                       r.acc_num_db acc_ref_db, r.acc_num_cr acc_ref_cr
                                                 from NBUR_DM_TRANSACTIONS q
                                                 join NBUR_REF_SEL_TRANS r
                                                   on (q.acc_num_db like r.acc_num_db||'%' and q.ob22_db = nvl(r.ob22_db, q.ob22_db) and
                                                       q.acc_num_cr like r.acc_num_cr||'%' and q.ob22_cr = nvl(r.ob22_cr, q.ob22_cr) and
                                                       q.kf = nvl(r.mfo, q.kf) )
                                                 where q.report_date = p_report_date
                                                   and q.kf = p_kod_filii 
                                                   and q.kv <> 980
                                                   and r.file_id =l_file_id
                                                   and r.pr_del =6
                                             union all
                                               select  q.report_date, q.kf, q.ref, q.kv, q.bal, q.bal_uah,
                                                       q.cust_id_db, q.r020_db, q.acc_id_db, q.acc_num_db, q.ob22_db,
                                                       q.cust_id_cr, q.r020_cr, q.acc_id_cr, q.acc_num_cr, q.ob22_cr,
                                                       '3720' acc_ref_db, '2603' acc_ref_cr
                                                  from NBUR_DM_TRANSACTIONS q
                                                 where q.report_date = p_report_date
                                                   and q.kf = p_kod_filii
                                                   and q.kv = 980
                                                   and q.acc_num_db like '3720%' and q.ob22_db ='04'
                                                   and q.acc_num_cr like '2603%'
                                            ) t
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
                                       join CUSTOMER c
                                         on ( c.kf      = p_kod_filii   and
                                              c.rnk     = t.cust_id_cr  )
                                       left outer
                                       join OTCN_TRANSIT_NLS n
                                         on ( n.NLS = t.ACC_NUM_CR )
                                      where ( lower(trim(o.nazn)) not like 'конв%'
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
                                        and ( not (t.acc_ref_db in ('1500', '1502', '1600') and t.acc_ref_cr = '3800')
                                              or
                                              t.acc_ref_db in ('1500', '1502', '1600') and
                                              t.acc_ref_cr = '3800' and
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

---------------                       обробка операцій  дт2909(1500) - кт3720
  insert
    into NBUR_LOG_F3MX
       (REPORT_DATE, KF, NBUC, VERSION_ID, EKP, 
        KU, T071, Q003_1, F091, R030, F090, K040, F089, K030, K020, K021, Q001_1,
        B010, Q033, Q001_2, Q003_2, Q007_1, F027, F02D, Q006,
        DESCRIPTION, KV, CUST_ID, REF)
            select    p_report_date  as report_date
                   ,  p_kod_filii    as kf
                   ,  p_kod_filii    as nbuc
                   ,  l_version      as version_id
                   , 'A3M001'                          as EKP
                   ,  f_get_ku_by_nbuc(p_kod_filii)    as KU
                   ,  T071
                   ,  lpad((dense_rank() over (order by R030, K040)) +l_last_q003, 3, '0')
                                                       as Q003_1
                   ,  '6'                     as F091
                   ,  R030
                   ,  '604'                   as F090
                   ,  K040
                   ,  '1'                     as F089
                   ,  '1'                     as K030
                   ,  '0'                     as K020
                   ,  '#'                     as K021
                   ,  null                    as Q001_1
                   ,  null                    as B010
                   ,  null                    as Q033
                   ,  null                    as Q001_2
                   ,  null                    as Q003_2
                   ,  null                    as Q007_1
                   ,  '#'                     as F027
                   ,  '#'                     as F02D
                   ,  'сума до з’ясування'    as Q006
                   ,  description
                   ,  kv     
                   ,  cust_id
                   ,  ref   
              from (
                    select   trim(TO_CHAR(t.bal))     as T071
                           ,  t.kv                    as R030
                           ,  f_nbur_get_kod_g(t.ref, 1)
                                                      as K040                      
                           ,  a.txt    as description
                           ,  t.kv     
                           ,  t.cust_id_db        as cust_id
                           ,  t.ref   
                     from nbur_dm_transactions t
                          join nbur_dm_transactions_arch a
                            on (    a.acc_id_cr = t.acc_id_db
                                and a.kv = t.kv
                                and a.bal = t.bal )
                    where  t.report_date = p_report_date
                      and  t.kf = p_kod_filii
                      and  t.r020_db ='2909' and t.ob22_db in ('82','56')
                      and  t.r020_cr ='3720' 
                      and  gl.p_icurval(t.kv, t.bal, p_report_date) <=15000000
                      and (a.report_date, a.kf, a.version_id) in
                                  (select report_date, kf, version_id
                                     from nbur_lst_objects
                                    where object_id = (select id from nbur_ref_objects
                                                        where object_name ='NBUR_DM_TRANSACTIONS' ) 
                                      and report_date between p_report_date-7 and p_report_date
                                      and kf = p_kod_filii
                                      and object_status in ('FINISHED', 'VALID'))
             );

   -- додаємо в кінець вже заповненого файлу
    select to_number(nvl(max(Q003_1),'0'))
    into l_last_q003
    from nbur_log_f3mx
    WHERE     report_date = p_report_date
          AND kf = p_kod_filii;

    commit;

-- блок 2 ------------------------------------------------------------- вставка данных #E2 для 300465
--                                                                      nbur_p_fe2.sql
    if p_kod_filii = '300465' then

          insert into NBUR_TMP_TRANS_1 (REPORT_DATE, KF, REF, TT, RNK, ACC, NLS, KV,
              P10, P20, P31, P40, P62, REFD,
              D1#2D, D1#E2, D6#E2, D7#E2, D8#E2, DA#E2, KOD_G, NB, NAZN, BAL_UAH,
              P32, P51, P52, P53, P54, P55)
          select REPORT_DATE, a.KF, REF, TT, CUST_ID, ACC_ID, ACC_NUM, a.KV,
              P10, P20, lpad(P31, 10, '0') p31, substr(trim(D1#E2),1,2) P40, P62, REFD,
              D1#2D,
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
                  nvl(substr(trim(p.d1#2d), 1, 2), '#')   D1#2D,
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
                  t.kf = nvl(r.mfo, t.kf) )
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
                  r.file_id = l_file_id and r.pr_del =5 and
                  t.ref not in (select ref from NBUR_TMP_DEL_70 where kodf = l_file_code and datf = p_report_date) and
                  not (o.nlsa like '1500%' and o.nlsb like '1500%' or
                       ((o.nlsa like '1500%' or o.nlsb like '1500%') and nvl(f_get_swift_country(t.ref), 'ZZZ') = '804') or -- 15/08/2017 (Дубина О.)
                       o.nlsa like '1919%' and o.nlsb like '1600%' and lower(o.nazn) like '%конвер%' or
                       o.nlsa like '19198%' and o.nlsb like '1600%' or
                       o.nlsa like '1600%' and o.nlsb like '1500%'  and c.k040 = '804' or
                       t.acc_num_db like '1600%' and c.k040 = '804' or
                       o.kf = '300465' and o.mfoa <> o.mfob or
                       t.kf = '300465' and t.r020_db in ('2600', '2620') and t.r020_cr in ('1919','2909','3739') and t.ref <> 88702330401 or
                       o.nlsa like '1500%' and (o.nlsb like '7100%' or o.nlsb like '750%') and
                       o.dk=0 --and round(t.bal_uah / l_kurs_840, 0) < 100000
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
              D1#2D, D1#E2, D6#E2, D7#E2, D8#E2, DA#E2, KOD_G, NB, NAZN, BAL_UAH)
          select REPORT_DATE, KF, REF, TT, CUST_ID, ACC_ID, ACC_NUM, KV,
              P10, P20, P31, D1#2D, substr(trim(D1#E2),1,2) P40, P62, REFD,
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
                  nvl(substr(trim(p.d1#2d), 1, 2), '#')   D1#2D,
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
        KU, T071, Q003_1, F091, R030, F090, K040, F089, K030, K020, K021, Q001_1,
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
                   ,  K030
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
                            , f_nbur_get_f090('E2', t.ref, t.P40)    F090
                            , t.P64                        K040
                            , t.P62                        K030
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
                            , decode( df.field_value, null, t.D1#2D, df.field_value )    F02D
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
                     nbuc, branch, description, D1#2D
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
                  z.p62, null refd, z.nbuc, z.branch, 'Part 1 ' description, z.D1#2D,
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
                    a.p62, a.kod_g, a.DA#E2, b.nbuc, b.branch, a.bal_uah, a.D1#2D
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
                  'Part 2 ' description, z.D1#2D,
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
                        a.p51, a.p52, a.p53, a.p54, a.p55, a.D1#2D
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
                  z.p62, z.refd, z.nbuc, z.branch, 'Part 3 ' description, z.D1#2D,
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
                        a.p51, a.p52, a.p53, a.p54, a.p55, a.D1#2D
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

   -- додаємо в кінець вже заповненого файлу
    select to_number(nvl(max(Q003_1),'0'))
    into l_last_q003
    from nbur_log_f3mx
    WHERE     report_date = p_report_date
          AND kf = p_kod_filii;

---------------                       обробка операцій ЦА  дт373911505 - кт1500  [кт3720 (РУ,ЦА) - дт373911505]
  insert
    into NBUR_LOG_F3MX
       (REPORT_DATE, KF, NBUC, VERSION_ID, EKP, 
        KU, T071, Q003_1, F091, R030, F090, K040, F089, K030, K020, K021, Q001_1,
        B010, Q033, Q001_2, Q003_2, Q007_1, F027, F02D, Q006,
        DESCRIPTION, KV, CUST_ID, REF)
            select    p_report_date  as report_date
                   ,  p_kod_filii    as kf
                   ,  p_kod_filii    as nbuc
                   ,  l_version      as version_id
                   , 'A3M001'                          as EKP
                   ,  f_get_ku_by_nbuc(p_kod_filii)    as KU
                   ,  lpad((dense_rank() over (order by R030, K040)), 3, '0')
                                                       as Q003_1
                   ,  T071
                   ,  '5'                     as F091
                   ,  R030
                   ,  '604'                   as F090
                   ,  K040
                   ,  '1'                     as F089
                   ,  '1'                     as K030
                   ,  '0'                     as K020
                   ,  '#'                     as K021
                   ,  null                    as Q001_1
                   ,  null                    as B010
                   ,  null                    as Q033
                   ,  null                    as Q001_2
                   ,  null                    as Q003_2
                   ,  null                    as Q007_1
                   ,  '#'                     as F027
                   ,  '#'                     as F02D
                   ,  'сума до з’ясування'    as Q006
                   ,  description
                   ,  kv     
                   ,  cust_id
                   ,  ref   
              from (
                    select   trim(TO_CHAR(t.bal))     as T071
                           ,  t.kv                    as R030
                           ,  substr(
                                   nvl(lpad(nvl(nvl(trim(translate(b.kod_g, '0123456789OPОП', '0123456789')),
                                                     substr(trim (b.D6#E2), 1, 70)),
                                                f_get_swift_country(b.ref)), 3, '0'),
                                          'код' ) 
                                    ,1,3)             as K040                      
                           ,  a.txt    as description
                           ,  t.kv     
                           ,  t.cust_id_db        as cust_id
                           ,  t.ref   
                     from nbur_dm_transactions t
                          join nbur_dm_transactions_arch a
                               on (    a.acc_id_cr = t.acc_id_db
                                   and a.kv = t.kv
                                   and a.bal = t.bal 
                                   and regexp_instr(a.txt,'^[ 3720| 2909]')>0 )
                     left join nbur_dm_adl_doc_rpt_dtl b
                               on (     b.ref = t.ref
                                   and  b.report_date =p_report_date
                                   and  b.kf = p_kod_filii )
                    where  t.report_date =p_report_date
                      and  t.kf = p_kod_filii
                      and  t.r020_db ='3739' and t.acc_num_db = '373911505'
                      and  t.r020_cr ='1500' 
                      and  gl.p_icurval(t.kv, t.bal, p_report_date) <=15000000
                      and (a.report_date, a.kf, a.version_id) in
                                  (select report_date, kf, version_id
                                     from nbur_lst_objects
                                    where object_id = (select id from nbur_ref_objects
                                                        where object_name ='NBUR_DM_TRANSACTIONS') 
                                      and report_date between p_report_date-7 and p_report_date
                                      and kf = p_kod_filii
                                      and object_status in ('FINISHED', 'VALID'))
              );

    else
-- блок 3 ------------------------------------------------------------- вставка данных #E2 все кроме 300465
--                                                 на основе алгоритма  p_fe2_nn.sql
      declare

           l_kodGLB      varchar2(3);           -- код главного банка

           l_ourMFO      varchar2(6);           -- 'наше' МФО
           l_ourKU       varchar2(2);           -- код области по МФО
           l_accKU       varchar2(2);           -- код области по счету операции
        
           l_grSUM      number     := 1000;       -- гранична сума для консолідаціі  =1000.00$
           l_grSUM_eq   number;
        
           l_q003       integer       := l_last_q003;
           l_k21_k20    varchar2(30);
           l_k020       varchar2(20);
           l_k021       varchar2(1);
           l_k030       varchar2(1);
           l_ku         varchar2(2);
           l_t071       number;
        
           l_f027       varchar2(2);
           l_f02d       varchar2(2);
           l_f089       varchar2(1);
           l_f090       varchar2(3);
           l_f090e2     varchar2(2);
           l_f091       varchar2(1);
           l_r030       varchar2(3);
           l_k040       varchar2(3);
           l_b010       varchar2(10);
        
           l_q001       varchar2(135);
           l_q0012      varchar2(135);
           l_q0032      varchar2(50);
           l_q006       varchar2(160);
           l_q0071      varchar2(10);
           l_q033       varchar2(60);
        
           l_s180       varchar(1);
           l_ob22       varchar(2);
        
           l_PID        number;             -- код контракта
           l_minID      number;             -- 'младший' субконтракт
           l_maxID      number;             -- 'старший' субконтракт
        
           l_kod_n      varchar2(4);
           l_ref        number;
           l_nlsd       varchar2(20);
           l_accd       number;
           l_ref_d      number;
           l_tt_d       varchar2(3);
           l_nlsd_d     varchar2(20);
           l_accd_d     number;
           formOk_      boolean;
           mbkOK_       boolean;
        
           l_rnk        number;
           l_rnka       number;
           l_okpo       varchar2(14);
           l_nmk        varchar2(70);
           l_codc       varchar2(1);
           l_tag_val    varchar2(135);
           l_transf     varchar2(30);
        
-------- для старых значений сегмента DD  связанных с ВМД
           d4#E2_      VARCHAR2 (70);            --DD=59   номер ВМД
           dc#E2_      VARCHAR2 (70);            --DD=59
           dc#E2_max   VARCHAR2 (70);
           dc1#E2_     VARCHAR2 (70);
           d61#E2_     VARCHAR2 (170);           --DD=61  сведения об операции
           d61_amt     number;                   

      begin

         -- свой МФО
         l_ourMFO := p_kod_filii;
      
-------------------------------------------------------------------------
-------- код главного банка
         begin
           select decode(glb, 0, '0', lpad(to_char(glb), 3, '0'))
             into l_kodGLB
             from rcukru
            where mfo = l_ourGLB
              and rownum=1;
         exception
           when no_data_found then
               l_kodGLB := null;
         end;
      
-------------------------------------------------------------------------
-------- код области по МФО для сегмента KU  (далее уточнение по счетам)
         begin
               select obl     into l_ourKU
                 from branch
                where branch = '/'||l_ourMFO||'/';
         exception
            when no_data_found
              then l_ourKU :='26';
         end;
      
         l_grSUM_eq := gl.p_icurval(840, l_grSUM, p_report_date);
      
        -- отбор проводок, удовлетворяющих условию:  надходження вiд нерезидентiв
           INSERT INTO OTCN_PROV_TEMP
                 (ko, rnk, REF, fdat, tt, accd, nlsd, kv, acck, nlsk, nazn, s_nom)
                  SELECT '3' ko, (case
                                     when  o.nbsd ='2924'
                                        then nvl( (select a.rnk
                                                     from accounts a
                                                    where a.nls = o.nlsa
                                                      and a.kv = o.kv), o.rnkd)
                                          else o.rnkd
                                   end)          rnk,
                           o.REF, fdat, tt, o.accd, o.nlsd, o.kv, o.acck,
                           o.nlsk, o.nazn, o.s * 100 s_nom
                  FROM provodki_otc o
                  WHERE o.kv != 980
                    and o.fdat between p_report_date - 10 and p_report_date + 1
                    and o.ref in (
                      select /*+ index(a, XIE_DAT_A_ARC_RRP) */ o.ref
                        from arc_rrp a, oper o
                        where trunc(a.dat_a) >= p_report_date
                          and trunc(a.dat_a) < p_report_date+5
                          and a.dk = 3
                          and a.nlsb like '2909%'
                          and a.nazn like '#E2;%'
                          and trim(a.d_rec) is not null
                          and a.d_rec like '%D' || to_char(p_report_date, 'yymmdd') || '%'
                          and substr(a.d_rec, 6+instr(a.d_rec, '#CREF:'),
                              instr(substr(a.d_rec, 6+instr(a.d_rec, '#CREF:')), '#')-1) = o.ref_a and
                              o.kv = a.kv and
                              o.s = a.s )
                    and lower(o.nazn) not like '%повернен%кошт%'
     union all
        SELECT '3' ko, 
               nvl((select a.rnk  from accounts a, provodki_otc p
                     where a.kv = 980 and a.acc = p.accd
                       and p.kv =980
                       and p.s = o.s
                       and p.acck = o.accd
                       and p.fdat between p_report_date -5
                                      and p_report_date
                       and rownum =1
                     ), o.rnkd) rnk,
               o.REF, fdat, tt, o.accd, o.nlsd, o.kv, o.acck,
               o.nlsk, o.nazn,
               o.s * 100 s_nom
          FROM provodki_otc o
         WHERE o.kv = 980
           and o.fdat = p_report_date
           and o.nbsd ='1919'  and  ob22d ='04'
           and o.nbsk ='3739' 
           and o.nlsb like '1600%' ;
      
         commit;
      
         delete  from OTCN_PROV_TEMP
          where ref in (
                  select ref
                    from OTCN_PROV_TEMP
                   group by ref
                  having count( * )>1 )
            and nlsd like '2924%' and nlsk like '3739%';
              
         delete  from OTCN_PROV_TEMP
          where ref in (select ref from NBUR_TMP_DEL_70 where kodf = '3M' and datf = p_report_date); 
      
          for k in ( select t.rnk, t.REF, t.fdat, t.tt, t.accd, t.nlsd, t.kv, t.acck, t.nlsk, t.nazn, t.s_nom,
                            c.okpo, c.nmk, c.codcagent, c.branch,
                            decode(substr(b.b040,9,1),'2',substr(b.b040,15,2),substr(b.b040,10,2)) nbuc
                       from otcn_prov_temp t,
                            customer c, tobo b
                      where t.rnk = c.rnk
                        and c.tobo = b.tobo
          ) loop
      
                formOk_ := true;
                mbkOk_ := false;
      
                l_ref     := k.ref;
                l_ref_d   := k.ref;
                l_accd    := k.accd;
                l_nlsd    := k.nlsd;
                l_rnk     := k.rnk;
                l_okpo    := k.okpo;
                l_codc    := k.codcagent;
                l_k030    := to_char(2-mod(l_codc,2));
      
                d4#E2_    := null;
                d61#E2_   := null;
                dc#E2_    := null;
                dc1#E2_   := '';
      
                l_ku := k.nbuc;
                l_t071 := k.s_nom;
                l_f089 := '2';
                l_f091 := '5';
                l_r030 := lpad(k.kv,3,'0');
      
                l_k21_k20 := f_nbur_get_k020_by_rnk( l_rnk );
                l_k021 := substr(l_k21_k20,1,1);
                l_k020 := lpad(trim(substr(l_k21_k20,2)),10,'0');
                l_q001 := k.nmk;
      
                l_k040  := f_nbur_get_kod_g(l_ref, 2);
                l_q033  := null;
                l_q0032 := null;
                l_q0071 := null;
                l_b010  := null;
                l_f090  := null;
                l_f090e2 := null;
      
                if l_k040 is null  or 
                   l_k040 is not null  and l_k040 not in ('804','UKR')  then
      
                      begin
                         select p.pid, min(p.id), max(p.id)
                           into l_PID, l_minID, l_maxID
                           from contract_p p
                          where p.ref = l_ref
                          group by p.pid;
      
                         select 20+t.id_oper, t.name, to_char(t.dateopen, 'dd.mm.yyyy'),
                                t.bankcountry, lpad(t.bank_code,10,'0'), t.benefbank
                            into l_f090e2, l_q0032, l_q0071,
                                 l_k040, l_b010, l_q033
                            from top_contracts t
                           where t.pid = l_PID;
      
                           begin
                              select max(trim(name)), count(*)
                                 into dc#E2_max, d61_amt 
                              from tamozhdoc
                              where pid = l_PID
                                and id = l_maxID;
      
                           exception
                              when no_data_found then
                                    BEGIN
                                       select max(trim(name)), count(*)
                                          into dc#E2_max, d61_amt 
                                       from tamozhdoc
                                       where pid = l_PID
                                         and id = l_minID;
             
                                       l_maxID := l_minID;
                                    exception
                                       when no_data_found then
                                             dc#E2_max := null;
                                    END;
                           end;
                           if dc#E2_max is not null then
      
                              begin
                                 select to_char(t.datedoc,'ddmmyyyy'),
                                        lpad(trim(c.cnum_cst),9,'#')||'/'||
                                        substr(c.cnum_year,-1)||'/'||
                                        lpad(dc#E2_max,6,'0')
                                    into d4#E2_, dc#E2_
                                 from tamozhdoc t, customs_decl c
                                 where t.pid = l_PID
                                   and t.id = l_maxID
                                   and trim(t.name) = trim(dc#E2_max)
                                   and trim(c.cnum_num) = trim(t.name)
                                   and trim(c.f_okpo) = trim(k.okpo) ;
                              exception
                                 when no_data_found then
                                           null;
                              end;
      
                              if d61_amt <= 3 then
                                 for u in (select name, to_char(datedoc,'ddmmyyyy') DATEDOC
                                             from tamozhdoc
                                            where pid = l_PID
                                              and id = L_maxID
                                              and trim(name) != trim(dc#E2_max) )
                                 loop
                                    select lpad(trim(c.cnum_cst),9,'#')||'/'||
                                           substr(c.cnum_year,-1)||'/'
                                      into dc1#E2_
                                      from customs_decl c
                                     where trim(c.cnum_num) = trim(u.name)
                                       and trim(c.f_okpo) = trim(k.okpo);
      
                                    d61#E2_ := d61#E2_||dc1#E2_||trim(u.name)||' '||
                                               u.datedoc||',';
      
                                 end loop;
                              else
                                 d61#E2_ := 'оплата за'||to_char(d61_amt)||'-ма ВМД';
                              end if;
                           end if;
      
                      exception
                         when no_data_found then     
                              null;                  --не найден контракт
                         when too_many_rows then     
                              null;                  --в одном платеже несколько контрактов
                      end;
------------------------------------------------------------------------------
                      if k.nlsd like '1919%' or k.nlsd like '3739%' then
                         -- если это подбор корсчета
                         if k.tt = 'NOS' then
                            -- то ищем связанную операцию, которая предшествовала NOS
                            l_ref_d := to_number(trim(f_dop(l_ref, 'NOS_R')));
      
                            if l_ref_d is null then
                               begin
                                  select ref     into l_ref_d
                                    from oper
                                   where vdat between to_date(p_report_date)-7 and p_report_date
                                     and nlsb = k.nlsd
                                     and kv = k.kv
                                     and refl in (l_ref);
                               exception
                                         when no_data_found then
                                  l_ref_d := null;
                               end;
                            end if;
      
                            -- если нашли предшествующую операцию, то выбираем рекизиты счетов
                            if l_ref_d is null then
                               begin
                                  select p.ref, p.tt, p.NLSD, p.accd
                                    into l_ref_d, l_tt_d, l_nlsd_d, l_accd_d
                                    from provodki_otc p
                                   where p.ref = l_ref 
                                     and p.acck = l_accd;
                               exception
                                         when no_data_found then
                                  l_ref_d := null;
                               end;
                            end if;
      
                            -- если нашли предшествующую операцию, то выбираем рекизиты клиентов
                            if l_ref_d is not null and l_ref_d != l_ref then
                               begin
                                  select c.rnk, trim(c.okpo), c.nmk, c.codcagent,
                                         p.tt, p.NLSD, p.accd
                                    into l_rnk, l_okpo, l_q001, l_codc, l_tt_d, l_nlsd_d, l_accd_d
                                  from provodki_otc p, cust_acc ca, customer c
                                  where p.ref = l_ref_d
                                    and p.acck = l_accd
                                    and p.accd =ca.acc  
                                    and ca.rnk = c.rnk;
      
                                  -- для банков по коду ОКПО из RCUKRU(IKOD)
                                  -- определяем код банка поле GLB
                                  if l_codc in (1, 2) then
                                     l_okpo := l_kodGLB;
                                  end if;
      
                               exception
                                  when no_data_found then
                                             null;
                               end;
                            end if;
      
                            if l_ref_d is not null then
                               -- если предшествующая операция - ФОРЕКС
                               if nvl(l_tt_d, '***') like 'FX%' then
                                  -- то инициатор проводки - сам банк, поэтому берем его код из RCUKRU
                                  l_okpo := l_kodGLB;
                                  l_codc := 1;
      
                                  BEGIN
                                     -- берем рекизиты из модуля ФОРЕКС   decode(kva, 980, '30', '28')
                                     select decode(kva, 980, '30', '28'), ntik, to_char(dat, 'dd.mm.yyyy')
                                        into l_f090e2, l_q0032, l_q0071
                                     from fx_deal
                                     where refb = l_ref_d;
                                  EXCEPTION WHEN NO_DATA_FOUND THEN
                                     null;
                                  END;
                                  if l_f090e2 = '30' then
                                      formOk_ := false;
                                  end if;
      
                               else
                                  -- если не ФОРЕКС, то возможно "поможет" модуль "Экпортно-Импортные контракты"
                                  begin
                                     select p.pid, min(p.id), max(p.id)
                                       into l_PID, l_minID, l_maxID
                                       from contract_p p
                                      where p.ref = l_ref_d
                                      group by p.pid;
      
                                     select 20+t.id_oper, t.name, to_char(t.dateopen, 'dd.mm.yyyy'),
                                            t.bankcountry, lpad(t.bank_code,10,'0'), t.benefbank
                                       into l_f090e2, l_q0032, l_q0071,
                                            l_k040, l_b010, l_q033
                                       from top_contracts t
                                      where t.pid = l_PID ;
      
                                     begin
                                        select max(trim(name)), count(*)
                                          into dc#E2_max, d61_amt 
                                          from tamozhdoc
                                         where pid = l_PID
                                           and id = l_maxID;
      
                                     exception
                                        when no_data_found then
                                              BEGIN
                                                 select max(trim(name)), count(*)
                                                    into dc#E2_max, d61_amt 
                                                 from tamozhdoc
                                                 where pid = l_PID
                                                   and id = l_minID;
                               
                                                 l_maxID := l_minID;
                                              exception
                                                 when no_data_found then
                                                       dc#E2_max := null;
                                              END;
                                     end;
                                     if dc#E2_max is not null then
                
                                        begin
                                           select to_char(t.datedoc,'ddmmyyyy'),
                                                  lpad(trim(c.cnum_cst),9,'#')||'/'||
                                                  substr(c.cnum_year,-1)||'/'||
                                                  lpad(dc#E2_max,6,'0')
                                              into d4#E2_, dc#E2_
                                           from tamozhdoc t, customs_decl c
                                           where t.pid = l_PID
                                             and t.id = l_maxID
                                             and trim(t.name) = trim(dc#E2_max)
                                             and trim(c.cnum_num) = trim(t.name)
                                             and trim(c.f_okpo) = trim(k.okpo) ;
                                        exception
                                           when no_data_found then
                                                     null;
                                        end;
                
                                        if d61_amt <= 3 then
                                           for u in (select name, to_char(datedoc,'ddmmyyyy') DATEDOC
                                                       from tamozhdoc
                                                      where pid = l_PID
                                                        and id = L_maxID
                                                        and trim(name) != trim(dc#E2_max) )
                                           loop
                                              select lpad(trim(c.cnum_cst),9,'#')||'/'||
                                                     substr(c.cnum_year,-1)||'/'
                                                into dc1#E2_
                                                from customs_decl c
                                               where trim(c.cnum_num) = trim(u.name)
                                                 and trim(c.f_okpo) = trim(k.okpo);
                
                                              d61#E2_ := d61#E2_||dc1#E2_||trim(u.name)||' '||
                                                         u.datedoc||',';
                
                                           end loop;
                                        else
                                           d61#E2_ := 'оплата за'||to_char(d61_amt)||'-ма ВМД';
                                        end if;
                                     end if;
      
                                  exception
                                            when no_data_found then
                                     null;
                                            when too_many_rows then
                                     null; 
                                  end;
                               end if;
                            else
                               l_ref_d := l_ref;
                            end if;
                         else
                            l_ref_d := l_ref;
                         end if;
                      end if;
------------------------------------------------------------------------------
                           -- по межбанку нужно проверять срок кредита
                      if substr(l_nlsd, 1,3) in ('151', '152', '161', '162') or
                         substr(l_nlsd_d, 1,3) in ('151', '152', '161', '162')
                      then
                         if l_nlsd_d is not null then
                            l_s180 := fs180(l_accd_d, '1', p_report_date);
                         else
                            l_s180 := fs180(l_accd, '1', p_report_date);
                         end if;
      
                         -- если срок кредита меньше месяца, то не берем его
                         if l_s180 in ('1', '2', '3', '4', '5') then
                            formOk_ := false;
                         else
                            mbkOK_ := true;
                         end if;
                      end if;
------------------------------------------------------------------------------
                      l_ob22 := '00';
                      if k.nlsk like '3739%' and l_nlsd like '2909%'
                      then
                         begin
                            select ob22d
                               into l_ob22
                            from provodki_otc
                            where fdat = k.fdat
                              and ref = l_ref;
                         exception
                            when no_data_found then
                                 l_ob22 := '00';
                         end;
                      end if;
      
                      if formOK_  then
      
                         l_q003 := l_q003+1;
--------код валюти  10   R030 :    l_r030
--------сума        20   T071 :    l_t071
      
                        BEGIN
                           select substr(trim(value),1,4)
                              into l_kod_n
                           from operw
                           where ref = l_ref
                             and tag='KOD_N';
      
                        EXCEPTION WHEN NO_DATA_FOUND THEN
                           l_kod_n := null;
                        END;
      
                         if k.nlsk like '3739%' and  l_nlsd like '3720%'
                         then
                            BEGIN
                               select max(c.rnk)
                                  into l_rnka
                               from operw w, person p, customer c
                               where w.ref = l_ref
                                 and w.tag like 'PASPN%'
                                 and upper(substr(w.value,1,2)) = p.ser
                                 and ( substr(w.value,3,6) = p.numdoc OR
                                       substr(w.value,4.6) = p.numdoc )
                                 and p.rnk = k.rnk ;
      
                               if l_rnka is not null and l_rnka !=0  then
                                l_k21_k20 := f_nbur_get_k020_by_rnk( l_rnka );
                                l_k021 := substr(l_k21_k20,1,1);
                                l_k020 := lpad(trim(substr(l_k21_k20,2)),10,'0');

                                   begin
                                       select to_char(2-mod(codcagent,2))  into l_k030
                                         from customer
                                        where rnk = l_rnka;
                                   exception 
                                      when others  then  null;
                                   end;
                               end if;
      
                            EXCEPTION WHEN NO_DATA_FOUND THEN
                               null;
                            END;
                         end if;
      
                         if k.nlsk like '3739%' and l_nlsd like '2909%' and l_ob22 = '35'
                         then
                              l_k020 := '0';
                              l_k021 := '#';
                              l_q001 := null;
                         end if;
      
--------  1- D1#E2    F090
                                BEGIN
                                   SELECT SUBSTR (trim(VALUE), 1, 70)
                                      INTO l_tag_val
                                   FROM operw
                                   WHERE REF = l_ref_d AND tag = 'D1#E2';
                                EXCEPTION
                                   WHEN NO_DATA_FOUND
                                      then l_tag_val := null;
                                END;
      
--------  проверка наличия счета ДТ в справочнике систем переводов 
                         if k.nlsk like '1500%'  and
                            ( l_nlsd like '3739%' or l_nlsd like '2924%' )
                         then
                              begin
                                 select t_system  into l_transf
                                   from otcn_transit_nls
                                  where nls = trim(l_nlsd);
                              exception
                                when others
                                   then l_transf :='';
                              end;
                              if trim(l_transf) is not null  then
                                    l_f090e2 := '37';
                              end if;
      
                         end if;
      
                         if l_tag_val is null  and  l_f090e2 is null  and  k.nazn is not null  then
      
                            if      instr(lower(k.nazn),'грош') >0
                                or  instr(lower(k.nazn),'комерц') >0
                                or  instr(lower(k.nazn),'соц_альний переказ') >0
                            then
                                l_f090e2 :='38';
                            end if;
      
                            if instr(lower(k.nazn),'переказ') >0  and  l_nlsd like '2620%'  then
                                l_f090e2 :='38';
                            end if;
      
                         end if;
      
                         if  not (l_tag_val is null and l_f090e2 is not null)  then
      
                              l_f090e2 := nvl( substr(l_tag_val,1,2),'00');
                              if l_f090e2 ='00' and l_kod_n ='8445'  then 
                                l_f090e2 :='30';
                              end if;
      
                         end if;
----------------
                         if l_k020 ='0000000000'  then  l_f090e2 :='00';  end if;
----------------

                         l_f090 := f_nbur_get_f090( 'E2', l_ref_d, l_f090e2 );
                         if l_f090 ='#'  then
                            l_f090 := f_nbur_get_f090( 'E2', l_ref, l_f090e2 );
                         end if;
--------  2- D2#70    Q003_2
                           if l_q0032 is null  then
      
                                BEGIN
                                   SELECT trim(SUBSTR (VALUE, 1, 70))
                                      INTO l_tag_val
                                   FROM operw
                                   WHERE REF = l_ref_d AND tag = 'D2#70';
                                EXCEPTION
                                   WHEN NO_DATA_FOUND
                                      then  BEGIN
                                               SELECT trim(SUBSTR (VALUE, 1, 70))
                                                  INTO l_tag_val
                                               FROM operw
                                               WHERE REF = l_ref_d AND tag = 'D2#E2';
                                            EXCEPTION
                                               WHEN NO_DATA_FOUND
                                                  then l_tag_val := null;
                                            END;
                                END;
      
                                l_q0032 := nvl(substr(l_tag_val,1,50),'N контр.');
                           end if;
      
--------  3- D3#70    Q007_1
                           if l_q0071 is null  then
      
                                BEGIN
                                   SELECT trim(SUBSTR (VALUE, 1, 70))
                                      INTO l_tag_val
                                   FROM operw
                                   WHERE REF = l_ref_d AND tag = 'D3#70';
                                EXCEPTION
                                   WHEN NO_DATA_FOUND
                                      then  BEGIN
                                               SELECT trim(SUBSTR (VALUE, 1, 70))
                                                  INTO l_tag_val
                                               FROM operw
                                               WHERE REF = l_ref_d AND tag = 'D3#E2';
                                            EXCEPTION
                                               WHEN NO_DATA_FOUND
                                                  then l_tag_val := null;
                                            END;
                                END;
      
                                l_q0071 := substr(regexp_replace( l_tag_val,'[/|.|-]' ,'' ),1,10);
                           end if;
                           if l_q0071 is null  then
                               l_q0071 := 'дата контр';
                           end if;
                           l_q0071 := trim(l_q0071);
--------  6- D6#70    K040
/*                                BEGIN
                                   SELECT trim(SUBSTR (VALUE, 1, 70))
                                      INTO l_tag_val
                                   FROM operw
                                   WHERE REF = l_ref_d AND tag = 'D6#70';
                                EXCEPTION
                                   WHEN NO_DATA_FOUND
                                      then  BEGIN
                                               SELECT trim(SUBSTR (VALUE, 1, 70))
                                                  INTO l_tag_val
                                               FROM operw
                                               WHERE REF = l_ref_d AND tag = 'D6#E2';
                                            EXCEPTION
                                               WHEN NO_DATA_FOUND
                                                  then  BEGIN
                                                           SELECT trim(SUBSTR (VALUE, 1, 70))
                                                              INTO l_tag_val
                                                           FROM operw
                                                           WHERE REF = l_ref_d AND tag = 'KOD_G';
                                                        EXCEPTION
                                                           WHEN NO_DATA_FOUND
                                                              then l_tag_val := null;
                                                        END;
                                            END;
                                END;
      
                                l_k040 := substr(l_tag_val,1,3);      */
      
--------  9- D9#70    B010
                           if l_b010 is null  then
      
                                BEGIN
                                   SELECT trim(SUBSTR (VALUE, 1, 70))
                                      INTO l_tag_val
                                   FROM operw
                                   WHERE REF = l_ref_d AND tag = 'D9#70';
                                EXCEPTION
                                   WHEN NO_DATA_FOUND
                                      then  BEGIN
                                               SELECT trim(SUBSTR (VALUE, 1, 70))
                                                  INTO l_tag_val
                                               FROM operw
                                               WHERE REF = l_ref_d AND tag = 'D7#E2';
                                            EXCEPTION
                                               WHEN NO_DATA_FOUND
                                                  then  BEGIN
                                                           SELECT trim(SUBSTR (VALUE, 1, 70))
                                                              INTO l_tag_val
                                                           FROM operw
                                                           WHERE REF = l_ref_d AND tag = 'KOD_B';
      
                                                           if l_tag_val is not null  then
                                                              begin
                                                                 select distinct r.glb  into l_tag_val
                                                                   from rcukru r
                                                                  where r.mfo in ( select distinct mfo
                                                                                      from forex_alien
                                                                                     where trim(kod_b) = l_tag_val
                                                                                       and rownum =1 );
                                                              exception
                                                                 when NO_DATA_FOUND
                                                                    then l_tag_val := null;
                                                              end;
                                                           end if;
      
                                                        EXCEPTION
                                                           WHEN NO_DATA_FOUND
                                                              then l_tag_val := null;
                                                        END;
                                            END;
                                END;
      
                                l_b010 := lpad(substr(l_tag_val,1,10),'10','0');
                                if l_b010 is null  then
                                    l_b010 := substr(trim(f_get_swift_bank_code(l_ref)) ,1,10);
                                end if;
                                if l_b010 is null  then
                                     l_b010 := l_k040||'0000000';
                                end if;
      
                           end if;
-------- 10- DA#70    Q033
                           if l_q033 is null  then
      
                                BEGIN
                                   SELECT trim(SUBSTR (VALUE, 1, 70))
                                      INTO l_tag_val
                                   FROM operw
                                   WHERE REF = l_ref_d AND tag = 'DA#70';
                                EXCEPTION
                                   WHEN NO_DATA_FOUND
                                      then  BEGIN
                                               SELECT trim(SUBSTR (VALUE, 1, 70))
                                                  INTO l_tag_val
                                               FROM operw
                                               WHERE REF = l_ref_d AND tag = 'D8#E2';
                                            EXCEPTION
                                               WHEN NO_DATA_FOUND
                                                  then  BEGIN
                                                           SELECT trim(SUBSTR (VALUE, 1, 70))
                                                              INTO l_tag_val
                                                           FROM operw
                                                           WHERE REF = l_ref_d AND tag = 'KOD_B';
      
                                                           if l_tag_val is not null  then
                                                              begin
                                                                 select distinct r.knb  into l_tag_val
                                                                   from rcukru r
                                                                  where r.mfo in ( select distinct mfo
                                                                                      from forex_alien
                                                                                     where trim(kod_b) = l_tag_val
                                                                                       and rownum =1 );
                                                              exception
                                                                 when NO_DATA_FOUND
                                                                    then l_tag_val := null;
                                                              end;
                                                           end if;
      
                                                        EXCEPTION
                                                           WHEN NO_DATA_FOUND
                                                              then l_tag_val := null;
                                                        END;
                                            END;
                                END;
      
                                l_q033 := substr(l_tag_val,1,60);
                                if l_q033 is null  then
                                    begin
                                       select nvl(name, 'назва банку')  into l_q033
                                         from rc_bnk
                                        where b010 = l_b010
                                          and rownum =1;
                                    exception
                                       when no_data_found
                                          then  l_q033 := 'назва банку';
                                    end;
                                end if;
                           end if;
-------- 13- DA#E2    Q006
                                BEGIN
                                   SELECT trim(SUBSTR (VALUE, 1, 70))
                                      INTO l_tag_val
                                   FROM operw
                                   WHERE REF = l_ref_d AND tag = 'DA#E2';
                                EXCEPTION
                                   WHEN NO_DATA_FOUND
                                      then  BEGIN
                                               SELECT trim(SUBSTR (VALUE, 1, 70))
                                                  INTO l_tag_val
                                               FROM operw
                                               WHERE REF = l_ref_d AND tag = 'DD#70';
                                            EXCEPTION
                                               WHEN NO_DATA_FOUND
                                                  then l_tag_val := null;
                                            END;
                                END;
      
                            l_q006 := l_tag_val;
                            if l_q006 is null and d61#E2_ is not null  then
                                 l_q006 := substr(d61#E2_,1,160);
                            end if;
      
                            if l_q006 is null  then
                                 l_q006 := substr(k.nazn,1,160);
                            end if;
      
                              case
                                 when l_f090e2 = '20' then l_q006 := 'Участь у капіталі';
                                 when l_f090e2 = '21' then l_q006 := 'Імпорт товарів, робіт, послуг';
                                 when l_f090e2 = '23' then l_q006 := 'Погашення клієнтом кредиту від нерезидента (не банку)';
                                 when l_f090e2 = '24' then l_q006 := 'Погашення банком кредиту від банку-нерезидента';
                                 when l_f090e2 = '25' then l_q006 := 'Імпорт товарів(продукції, робіт, послуг) без ввезення';
                                 when l_f090e2 = '26' then l_q006 := 'Надання кредиту нерезиденту';
                                 when l_f090e2 = '27' then l_q006 := 'Розміщення депозиту в нерезидента';
                                 when l_f090e2 = '28' then l_q006 := 'Конвертація';
                                 when l_f090e2 = '29' then l_q006 := 'Інвестиції';
                                 when l_f090e2 = '30' then l_q006 := 'Повернення депозиту';
                                 when l_f090e2 = '31' then l_q006 := 'Перерахування з іншою метою';
                                 when l_f090e2 = '32' then l_q006 := 'Доходи від інвестицій';
                                 when l_f090e2 = '33' then l_q006 := 'Користування кредитами, депозитами';
                                 when l_f090e2 = '34' then l_q006 := 'Погашення клієнтом кредиту, отриманого від банку';
                                 when l_f090e2 = '35' then l_q006 := 'Погашення банком кредиту від нерезидента (не банку)';
                                 when l_f090e2 = '36' then l_q006 := 'Повернення ІВ резидентами (не виконання зобовязань)';
                                 when l_f090e2 = '37' then l_q006 := 'Розрахунки по платіжних системах '||l_transf;
                                 when l_f090e2 = '38' then l_q006 := 'Приватні перекази';
                                 when l_f090e2 = '39' then l_q006 := 'Роялті';
                                 when l_f090e2 = '40' then l_q006 := 'Утримання представництва';
                                 when l_f090e2 = '41' then l_q006 := 'Податки';
                                 when l_f090e2 = '42' then l_q006 := 'Державне фінансування';
                                 when l_f090e2 = '43' then l_q006 := 'Платежі за судовими рішеннями';
                                 when l_f090e2 = '44' then l_q006 := 'За операціями з купівлі банківських металів';
                                 when l_f090e2 = '45' then l_q006 := 'Імпорт товарів(продукції, робіт, послуг) на умовах поперед.оплати';
                                 when l_f090e2 = '46' then l_q006 := 'Повернення дивідентів';
                                                           
                              else
                                 null;
                              end case;
                            if k.nlsk like '3739%' and l_nlsd like '2909%' and l_ob22 = '35'
                            then
                                 l_q006 := 'переказ без ідентифікації';
                            end if;
-------- 15- 59F    Q001_2
                            l_q0012 := null;
      
                                BEGIN
                                   SELECT SUBSTR (trim(VALUE), 1, 135)
                                      INTO l_tag_val
                                   FROM operw
                                   WHERE REF = l_ref_d AND tag ='59F';

                                EXCEPTION
                                   WHEN NO_DATA_FOUND
                                      then l_tag_val := null;
                                END;
      
                            if l_q0032 is not null and l_q0071 is not null  then
      
                                begin
                                     select substr(MAX(trim(benef_name)), 1,135)
                                       into l_q0012
                                       from V_CIM_ALL_CONTRACTS
                                      where upper(num) = upper(l_q0032)
                                        and open_date = to_date(l_q0071, 'ddmmyyyy')
                                        and status_id in (0, 1, 4, 5, 6, 8)
                                        and lpad(okpo, 10,'0') = l_k020
                                        and kv = k.kv;

                                exception
                                   when OTHERS then
                                       bars_audit.error( 'P_F3MX: cont_num_='||l_q0032||', cont_dat_='||l_q0071||chr(10)||sqlerrm );
                                       l_q0012 := null;
                                end;
      
                            end if;

                            if l_q0012 is null  then
                                l_q0012 := f_get_swift_benef(l_ref);
                            end if;
                            if l_q0012 is null  and  l_tag_val is null then
                                BEGIN
                                   select substr(n_val,instr(n_val,' ')+1,instr(n_val,' ',1,3)-instr(n_val,' '))
                                      into l_tag_val
                                      from (  select replace(trim(VALUE), chr(13)||chr(10), ' ') n_val
                                                from operw
                                               where ref =l_ref_d AND tag ='59' );

                                EXCEPTION
                                   WHEN NO_DATA_FOUND
                                      then l_tag_val := null;
                                END;
                            end if;
                            if l_q0012 is null  then
                                l_q0012 := nvl(l_tag_val, 'назва Бенефіціару');
                            end if;
      
-------- 16- 12_2C    F027
                                BEGIN
                                   SELECT SUBSTR (trim(VALUE), 1, 70)
                                      INTO l_tag_val
                                   FROM operw
                                   WHERE REF = l_ref_d AND tag = '12_2C';
                                EXCEPTION
                                   WHEN NO_DATA_FOUND
                                      then l_tag_val := null;
                                END;
                                l_f027 := nvl(substr(l_tag_val,1,2),'00');
      
-------- 17- F089 
/*                                BEGIN
                                   SELECT trim(SUBSTR (VALUE, 1, 70))
                                      INTO l_tag_val
                                   FROM operw
                                   WHERE REF = l_ref_d AND tag = 'F089';
                                EXCEPTION
                                   WHEN NO_DATA_FOUND
                                      then l_tag_val := null;
                                END;*/
-------- F02D
                            l_f02d := '#';
                                BEGIN
                                   SELECT SUBSTR (trim(VALUE), 1,2)
                                      INTO l_tag_val
                                   FROM operw
                                   WHERE REF = l_ref_d AND tag ='D1#2D';

                                EXCEPTION
                                   WHEN NO_DATA_FOUND
                                      then l_tag_val := null;
                                END;

                            if l_tag_val is null  then
                                BEGIN
                                   select trim(field_value)    into l_f02d
                                     from v_nbur_#2d_dtl
                                    where report_date = p_report_date
                                      and kf     = l_ourMFO
                                      and seg_01 = '40'
                                      and ref     = l_ref
                                      and cust_id = l_rnk
                                      and acc_num = l_nlsd
                                      and kv      = k.kv;
                                EXCEPTION
                                   WHEN NO_DATA_FOUND
                                      then l_f02d := '#';
                                END;
                            else
                               l_f02d := l_tag_val;
                            end if;

        insert
          into NBUR_LOG_F3MX
             ( REPORT_DATE, KF, VERSION_ID, EKP, 
               NBUC, KU, T071, Q003_1, F091, R030, F090, K040, F089, K030, K020, K021, Q001_1,
               B010, Q033, Q003_2, Q007_1, Q006, Q001_2, F027, F02D,
               REF, BRANCH, DESCRIPTION, ACC_ID, ACC_NUM, KV, CUST_ID)
            values (p_report_date, l_ourMFO, l_version, 'A3M001',
                   l_ku, l_ku, l_t071, lpad(l_q003,3,'0'), l_f091, l_r030, l_f090, l_k040, l_f089,
                   l_k030, l_k020, l_k021, l_q001, l_b010, l_q033, l_q0032,
                   (case
                       when    length(l_q0071)=8 
                           and regexp_instr(l_q0071,'^[0-9]+$')>0
                          then
                             substr(l_q0071,1,2)||'.'||substr(l_q0071,3,2)||'.'||substr(l_q0071,5,4)
                       else
                             substr(l_q0071,1,10)
                     end),          --Q007_1
                   l_q006, l_q0012, 
                   l_f027, l_f02d, l_ref, k.branch, l_ref_d, l_accd, l_nlsd, k.kv, l_rnk) ;
      
                      end if;
      
                end if;
      
          end loop;
      
          commit;

      end;

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
        KU, T071, Q003_1, F091, R030, F090, K040, F089, K030, K020, K021, Q001_1,
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
                   , K030
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
                            , P35                        K030
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
          from (      select report_date, kf, kv, p10, sum(bal)  p20,
                     '0'         p31,
                     '1'         p35,
                     '36'        p40,
                     '00'        P42,
                     '804'       p62,
                     'Сума що підлягає обов"язковому продажу' p99
                 from (    select t.report_date
                                  , t.kf
                                  , t.kv, LPAD(t.kv, 3, '0') as p10
                                  , (case 
                                          when abs(nvl(round((z.s2 / 0.5), 0), 0) - t.bal)<10 then t.bal
                                          when z.s2 is not null then nvl(round((z.s2 / 0.5), 0), 0)
                                          else 0 
                                    end) bal
                           from   nbur_dm_transactions t
                                  left join zayavka z on (t.ref = z.refoper)
                                                         and (z.dk = 2)
                                                         and (z.obz = 1)
                           where  t.report_date = p_report_date
                                  and t.kf = p_kod_filii
                                  and t.R020_CR = '2603'
                                  and t.kv <> 980
                         )
                  group by report_date, kf, kv, p10 )
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

