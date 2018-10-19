CREATE OR REPLACE PROCEDURE BARS.nbur_p_f4px (
                                           p_kod_filii          varchar2
                                           , p_report_date      date
                                           , p_form_id          number
                                           , p_scheme           varchar2 default 'C'
                                           , p_file_code        varchar2 default '#4P'
                                        )
is
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION : Процедура формирования 4PX для Ощадного банку
% COPYRIGHT   : Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
%
% VERSION     :  v.1.003 10/10/2018 (03/09/2018)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
  ver_               char(30)  := 'v.1.003  10/10/2018';
  c_title            constant varchar2(100 char) := $$PLSQL_UNIT || '. ';

  --Константы определяющие форматы данных
  c_date_fmt         constant varchar2(10 char) := 'dd.mm.yyyy';
  c_amount_fmt       constant varchar2(50 char) := 'FM99999999999990';
  
  c_old_file_code   constant varchar2(3 char) := '#1A';  

  --Типы данных
  type t_nbur_4px is
    table of nbur_log_f4px%rowtype index by binary_integer;

  --Эксепшн, когда нет партиции
  e_ptsn_not_exsts   exception;

  l_nbuc                  varchar2(20);
  l_cim_nbuc              varchar2(20);  --Параметр nbuc для файлов 35 и 6А
  l_type                  number;
  l_counter               number;
  l_version_id            number;
  l_rows_inserted         boolean;
  l_datez                 date := p_report_date + 1;
  l_file_code             varchar2(2) := substr(p_file_code, 2, 2);
  l_mnth_last_work_dt     date;

  l_2025                  number;
  l_2039                  number;
  l_2040                  number;
  l_2041                  number;
  l_2043                  number;
  l_2044                  number;
  l_2045                  number;

  l_indicators_503        cim_reports.t_indicators_f503;
  l_indicators_504        cim_reports.t_indicators_f504;

  l_row                   nbur_log_f4px%rowtype;
  l_#35_rows              t_nbur_4px;
  l_#6A_rows              t_nbur_4px;

  --Процедура добавления параметра в коллекцию
  procedure add_indicator(
                           p_ekp               in nbur_log_f4px.ekp%type
                           , p_rrrrw           in varchar2
                           , p_t071            in nbur_log_f4px.t071%type

                           , p_indicator       in out nbur_log_f4px%rowtype
                           , p_rows_inserted   in out boolean
                           , p_counter         in out number
                           , p_rows            in out nocopy t_nbur_4px
                         )
  is
  begin
    if (nvl(p_t071, 0) <> 0)
    then
      p_indicator.ekp := p_ekp;
      p_indicator.q010_1 := substr(p_rrrrw, 5, 4);
      p_indicator.q010_2 := substr(p_rrrrw, 1, 4);
      p_indicator.t071 := p_t071;

      p_rows_inserted := true;
      p_counter := p_counter + 1;
      p_rows(p_counter) := p_indicator;
    end if;
  end add_indicator;

  --Процедура добавления параметра в коллекцию
  procedure add_indicator(
                           p_ekp               in nbur_log_f4px.ekp%type
                           , p_t071            in nbur_log_f4px.t071%type
                           , p_s050            in nbur_log_f4px.s050%type
                           , p_f028            in nbur_log_f4px.f028%type

                           , p_indicator       in out nbur_log_f4px%rowtype
                           , p_rows_inserted   in out boolean
                           , p_counter         in out number
                           , p_rows            in out nocopy t_nbur_4px
                         )
  is
  begin
    --Условия вставки записи
    if (nvl(p_t071, 0) <> 0)
    then
      p_indicator.ekp := p_ekp;
      p_indicator.t071 := p_t071;
      p_indicator.s050 := p_s050;
      p_indicator.f028 := p_f028;

      p_rows_inserted := true;
      p_counter := p_counter + 1;
      p_rows(p_counter) := p_indicator;
    end if;
  end add_indicator;

  pragma exception_init( e_ptsn_not_exsts, -02149 );
BEGIN
  logger.info(
                c_title
                || ' begin for date = ' || to_char(p_report_date, 'dd.mm.yyyy')
                || ' kod_filii=' || p_kod_filii
                || ' form_id=' || p_form_id
                || ' scheme=' || p_scheme
             );

  -- Определение параметров построения отчета
  nbur_files.P_PROC_SET(
                           p_kf => p_kod_filii
                           , p_file_code => p_file_code
                           , p_scheme => p_scheme
                           , p_datz => l_datez
                           , p_type_spr => 0
                           , p_file_spr => l_file_code
                           , o_nbuc => l_nbuc
                           , o_type => l_type
                         );

  --Определяем версию под которую будем писать, чтобы связать агрегированный и детальный протокол
  l_version_id := coalesce(
                            f_nbur_get_run_version(
                                                    p_file_code => p_file_code
                                                    , p_kf => p_kod_filii
                                                    , p_report_date => p_report_date
                                                  )
                            , -1
                          );

  -- очікуємо формування старого файлу
  nbur_waiting_form(p_kod_filii, p_report_date, c_old_file_code, c_title);

  --Определяем полседнюю рабочую дату в этом месяце
  select max(fdat)
     into
         l_mnth_last_work_dt
  from   fdat
  where  fdat between trunc(fdat, 'MM') and last_day(p_report_date);

  --Запускаем построение отчета только в том случае, если дата является последним рабочий днем месяца
  if p_report_date = l_mnth_last_work_dt
  then
      --Параметр nbuc для файлов #35 и #6А
      select
             nvl(trim(b040), lpad('X', 20, 'X'))
        into
             l_cim_nbuc
      from   branch
      where  branch='/' || p_kod_filii || '/';

      --Подготавливаем партицию для вставки данных
      begin
        execute immediate 'alter table NBUR_LOG_F4PX truncate subpartition for ( to_date('''
                          || to_char(p_report_date,'YYYYMMDD')||''',''YYYYMMDD''), ''' || p_kod_filii || ''' )';
      exception
        when e_ptsn_not_exsts then
          null;
      end;

      logger.trace(c_title || 'Subpartition truncated');

      --Вставка данных из данных файла #1A
      BEGIN
        insert /*+ APPPEND */ 
        into nbur_log_f4px(report_date, kf, nbuc, version_id, b040, ekp, r020, r030_1, r030_2, 
            k040, s050, s184, f028, f045, f046, f047, f048, f049, f050, f052, f053, f054, f055, f056, f057, f070, k020, 
            q001_1, q001_2, q003_1, q003_2, q003_3, q006, q007_1, q007_2, q007_3, q010_1, q010_2, q012, q013, q021, q022, 
            t071, description, acc_id, acc_num, kv, maturity_date, cust_id, ref, nd, branch)
        select   p_report_date as report_date
                   , p_kod_filii as kf
                   , nbuc
                   , l_version_id
                   , substr(nbuc, 3) as b040
                   , (case when seg_01 = '31' then 'A4P007' else 'A4P006' end) as ekp
                   , (case when seg_03 in ('100', '230', '262', '271', '272', '273', '279', '311', '312', '320', '330', '341', '342', '350', '361', '362') 
                           then '#' 
                           else substr(acc_num, 1, 4) 
                      end) as r020
                   , seg_02 as r030_1
                   , (case when seg_03 in ('230', '262', '271', '272', '273', '279', '330', '362')
                           then '#' 
                           else seg_02
                      end) as r030_2
                   , (case when seg_03 in ('230', '262', '271', '272', '273', '279', '330', '362')
                           then '#' 
                           else lpad(c.country, 3, '0') 
                      end) as k040
                   , (case when seg_01 = '21' then '2' else '1' end) as s050
                   , nvl(k.s184, '#') as s184
                   , (case
                          when substr(acc_num, 1, 4) like '___8' and 
                               substr(acc_num, 1, 4) <> '3548' then '2'
                          when seg_03 in ('410', '421', '422', '430', '440', '450') then '0'
                          else '1'
                      end) as f028
                   , (case when seg_03 in ('230', '262', '271', '272', '273', '279', '330', '362')
                           then '#' 
                           else '2'
                      end) as f045
                   , '2' as f046
                   , '#' as f047
                   , '3' as f048
                   , '1' as f049
                   , '#' as f050
                   , '#' as f052
                   , '#' as f053
                   , '#' as f054
                   , '#' as f055
                   , '#' as f056
                   , seg_03 as f057
                   , '0' as f070
                   , (case when seg_03 in ('230', '262', '271', '272', '273', '279', '330', '362')
                           then '0000000000' 
                           else lpad(c.okpo, 10, '0')
                      end) as k020
                   , (case when seg_03 in ('230', '262', '271', '272', '273', '279', '330', '362')
                           then null
                           else c.nmk
                      end) as q001_1
                   , null as q001_2
                   , null as q003_1
                   , '00000' as q003_2
                   , '0' as q003_3
                   , null as q006
                   , null as q007_1
                   , null as q007_2
                   , null as q007_3
                   , seg_06 as q010_1
                   , seg_05 as q010_2
                   , null as q012
                   , null as q013
                   , null as q021
                   , null as q022
                   , field_value as t071
                   , '#1A' as description
                   , acc_id
                   , acc_num
                   , kv
                   , maturity_date
                   , cust_id
                   , null as ref
                   , t.nd
                   , t.branch
            from v_nbur_#1a_dtl t
            join customer c
            on (t.kf = c.kf and t.cust_id = c.rnk)
            left outer join specparam s 
            on (t.kf = s.kf and t.acc_id = s.acc)
            left outer join kl_s180 k 
            on (nvl(trim(s.s180), '0') = k.s180 
                and lnnvl(k.data_o <= p_report_date)
                and lnnvl(k.data_c > p_report_date))
            where t.report_date = p_report_date
              and t.kf = p_kod_filii   
              and t.seg_01 in ('11', '21', '31')
              and t.seg_03 not in ('410', '421', '422', '430', '440', '450');

        logger.trace(c_title || 'From source #1A inserted ' || to_char(sql%rowcount) || ' records' );

        commit;
      EXCEPTION
        WHEN OTHERS  THEN
          logger.error(c_title || 'Error inserting rows from source #1A: ' || SQLERRM);
      END;

      --Вставка данных из данных формы 503
      BEGIN
        insert /*+ APPPEND */ 
        into nbur_log_f4px(report_date, kf, nbuc, version_id, b040, ekp, r020, 
            r030_1, r030_2, k040, s050, s184, f028, f045, f046, f047, f048, f049, 
            f050, f052, f053, f054, f055, f056, f057, f070, k020, q001_1, q001_2, 
            q003_1, q003_2, q003_3, q006, q007_1, q007_2, q007_3, q010_1, q010_2, 
            q012, q013, q021, q022, t071, description, nd, branch)
        select unique p_report_date as report_date, p_kod_filii as kf, branch as nbuc, 
            l_version_id as version_id, B040, substr(ekp, 1, 6) EKP, R020, R030_1, R030_2, 
            K040, substr(ekp, 7, 1) S050, S184, substr(ekp, 8, 1) as F028, F045, 
            F046, F047, F048, F049, F050, 
            F052, F053, F054, F055, F056, F057, F070, 
            K020, Q001_1, Q001_2, Q003_1, Q003_2, Q003_3,  Q006, 
            to_char(Q007_1, 'dd.mm.yyyy') as Q007_1, to_char(Q007_2, 'dd.mm.yyyy') as Q007_2, 
            to_char(Q007_3, 'dd.mm.yyyy') as Q007_3, Q010_1, Q010_2, Q012, Q013, Q021, Q022, value as T071,
            'F503' DESCRIPTION, ND, BRANCH
        from (SELECT CONTR_ID,
                   c.BRANCH,
                   KF,
                   P1000 as Q001_1,
                   lpad(trim(Z), 10, '0') as K020,
                   P0100 as F047,
                   P1300 as Q001_2,
                   P0300 as K040,
                   P1400 as F052,
                   P1900 as S184,
                   PVAL as R030_1,
                   P1500 as F055,
                   M as F045,
                   nvl(P9800, '#') as f049,
                   P1700 as F054,
                   P0200 as R020,
                   lpad(trim(R_AGREE_NO), 5, '0') as Q003_2,
                   P1200 as Q007_2,
                   P1800 as F056,
                   T as Q003_3,
                   to_char(P9500, '90.000') as Q022,
                   P9600 as F050,
                   P3100 as Q007_3,
                   P9900 as Q006,
                   P0400 as F048,
                   trim(p0800_1||' '|| p0800_2||' '|| p0800_3) as Q012, 
                   trim(to_char(P0700, '9990.0000')) as Q013,
                   P0900 as Q021,
                   P0500 as Q003_1,
                   P0600 as Q007_1,
                   P3000 as F046,
                   P3200 as F070,       
                   P3300 as R030_2,
                   (case
                      when trim(F057) is not null then trim(F057)
                      when p1400 = '6' and P1900 = '1' then '211'
                      when p1400 = '6' and P1900 = '2' then '241'
                      when p1400 = '1' and P1900 = '1' then '212'
                      when p1400 = '1' and P1900 = '2' then '242'
                      when p1400 = '2' and P1900 = '1' then '311'
                      when p1400 = '2' and P1900 = '2' then '341'
                      when p1400 = '5' and P1900 = '1' then '312'
                      when p1400 = '5' and P1900 = '2' then '342'
                      when p1400 in ('4','7','8') and P1900 = '1' then '320'
                      when p1400 in ('4','7','8') and P1900 = '2' then '350'
                      when P1900 = '1' then '320'
                      when P1900 = '2' then '350'
                      else '000'
                   end) f057,
                   P1600 as F053,
                   '0' as Q010_1,
                   '0000' as Q010_2,
                   CONTR_ID as nd, 
                   nvl2(b.b040, substr(b.b040, length(b.b040)-11, 12), 'XXXXXXXXXXXX') as b040,
                   P2010,
                   P2011,
                   P2012,
                   P2013,
                   P2014,
                   P2016,
                   P2017,
                   P2018,
                   P2020,
                   P2021,
                   P2022,
                   P2023,
                   P2024,
                   P2025,
                   P2026,
                   P2027,
                   P2028,
                   P2029,
                   P2030,
                   P2031,
                   P2032,
                   P2033,
                   P2034,
                   P2035,
                   P2036,
                   P2037,
                   P2038,
                   nvl(p2010,0)+nvl(p2016,0)-nvl(p2022,0)-nvl(p2025,0) as P2041,
                   P2042,
                   nvl(p2013,0) + nvl(p2020,0) - nvl(p2036,0) as P2043,
                   nvl(p2014,0) + nvl(p2021,0) - nvl(p2037,0) as P2044
              FROM cim_f503 c
              left outer join branch b
              on (c.branch = b.branch)
              WHERE c.branch LIKE '/'|| p_kod_filii ||'/%')
          unpivot (value for ekp in ( -- ПОКАЗНИКИ НА ПОЧАТОК ПЕРІОДУ
                                                    P2010 as 'A4P00111#',
                                                    P2011 as 'A4P00121#',
                                                    P2012 as 'A4P00122#',
                                                    P2013 as 'A4P00123#',
                                                    P2014 as 'A4P00124#',
                                                    -- Сума одержаного кредиту
                                                    p2016 as 'A4P00211#',
                                                    -- Планові платежі
                                                    p2017 as 'A4P00311#',
                                                    p2018 as 'A4P00312#',
                                                    p2020 as 'A4P00313#',
                                                    p2021 as 'A4P00314#',
                                                    -- Фактичні платежі
                                                    -- основний борг
                                                    p2022 as 'A4P00411#', -- планова
                                                    p2023 as 'A4P00431#', -- достроково
                                                    p2024 as 'A4P00421#', -- прострочка
                                                    -- відсотки
                                                    p2029 as 'A4P00412#', -- планова
                                                    p2030 as 'A4P00432#', -- достроково
                                                    p2031 as 'A4P00422#', -- прострочка
                                                    -- комісійні
                                                    p2036 as 'A4P00413#',
                                                    -- пеня
                                                    p2037 as 'A4P00414#',
                                                    -- РЕОРГАНІЗАЦІЯ
                                                    --
                                                    p2026 as 'A4P005211',
                                                    p2027 as 'A4P005212',
                                                    p2028 as 'A4P005213',
                                                    --
                                                    p2033 as 'A4P005221',
                                                    p2034 as 'A4P005222',
                                                    p2035 as 'A4P005223',
                                                    -- ПОКАЗНИКИ на звітну дату
                                                    P2041 as 'A4P00611#',
                                                    P2038 as 'A4P00621#',
                                                    P2042 as 'A4P00622#',
                                                    P2043 as 'A4P00623#',
                                                    P2044 as 'A4P00624#'
                                                    ) );

        logger.trace(c_title || 'From source #6A inserted ' || to_char(sql%rowcount) || ' records' );

        commit;
      EXCEPTION
        WHEN OTHERS  THEN
          logger.error(c_title || 'Error inserting rows from source #6A: ' || SQLERRM);
      END;      
      
      --Вставка данных из данных формы 504
      BEGIN
        insert /*+ APPPEND */ 
        into nbur_log_f4px(report_date, kf, nbuc, version_id, b040, ekp, r020, 
            r030_1, r030_2, k040, s050, s184, f028, f045, f046, f047, f048, f049, 
            f050, f052, f053, f054, f055, f056, f057, f070, k020, q001_1, q001_2, 
            q003_1, q003_2, q003_3, q006, q007_1, q007_2, q007_3, q010_1, q010_2, 
            q012, q013, q021, q022, t071, description, nd, branch)
        select unique p_report_date as report_date, p_kod_filii as kf, branch as nbuc, 
            l_version_id as version_id, 
            B040, EKP, R020, R030_1, R030_2, 
            K040, S050, S184, F028, F045, 
            F046, F047, F048, F049, F050, 
            F052, F053, F054, F055, F056, F057, F070, 
            K020, Q001_1, Q001_2, Q003_1, Q003_2, Q003_3,  Q006, to_char(Q007_1, 'dd.mm.yyyy') as Q007_1, 
            to_char(Q007_2, 'dd.mm.yyyy') as Q007_2,  to_char(Q007_3, 'dd.mm.yyyy') as Q007_3, 
            Q010_1, Q010_2, Q012, Q013, Q021, Q022, T071,
            'F504' DESCRIPTION, ND, BRANCH
        from (SELECT CONTR_ID,
                   c.BRANCH,
                   KF,
                   'A4P007' as EKP,
                   P101 as Q001_1,
                   lpad(trim(Z), 10, '0') as K020,
                   P010 as F047,
                   P107 as Q001_2,
                   P030 as K040,
                   P108 as F052,
                   P184 as S184,
                   PVAL as R030_1,
                   P140 as F055,
                   M as F045,
                   '#' as f049,
                   P142 as F054,
                   P020 as R020,
                   R_AGREE_NO as Q003_2,
                   P103 as Q007_2,
                   P143 as F056,
                   T as Q003_3,
                   to_char(P950, '90.000') as Q022,
                   P960 as F050,
                   P310 as Q007_3,
                   P999 as Q006,
                   null as F048,
                   p080 as Q012, 
                   trim(to_char(P070, '9990.0000')) as Q013,
                   P090 as Q021,
                   P050 as Q003_1,
                   P060 as Q007_1,
                   null as F046,
                   '#' as F070,       
                   P330 as R030_2,
                   (case
                      when trim(F057) is not null then trim(F057)
                      when P108 = '6' and P184 = '1' then '211'
                      when P108 = '6' and P184 = '2' then '241'
                      when P108 = '1' and P184 = '1' then '212'
                      when P108 = '1' and P184 = '2' then '242'
                      when P108 = '2' and P184 = '1' then '311'
                      when P108 = '2' and P184 = '2' then '341'
                      when P108 = '5' and P184 = '1' then '312'
                      when P108 = '5' and P184 = '2' then '342'
                      when P108 in ('4','7','8') and P184 = '1' then '320'
                      when P108 in ('4','7','8') and P184 = '2' then '350'
                      when P184 = '1' then '320'
                      when P184 = '2' then '350'
                      else '000'
                   end) f057,
                   P141 as F053,
                   d.pmes as Q010_1,
                   d.pyear as Q010_2,
                   CONTR_ID as nd, 
                   nvl2(b.b040, substr(b.b040, length(b.b040)-11, 12), 'XXXXXXXXXXXX') as b040,
                   d.val as T071,
                   (case d.indicator_id 
                        when 212 then '1'
                        when 213 then '1'
                        when 292 then '2'
                        when 293 then '2'
                        else '#'
                   end) as S050,
                   (case d.indicator_id 
                        when 212 then '1'
                        when 213 then '2'
                        when 292 then '1'
                        when 293 then '2'
                        else '#'
                   end) as F028
              FROM cim_f504 c
              left outer join (select F504_ID, INDICATOR_ID, RRRR, W, VAL, 
                                    (CASE
                                       WHEN RRRR IN ('9999', '8888')
                                       THEN
                                          RRRR
                                       ELSE
                                          (CASE
                                              WHEN TO_NUMBER (RRRR)
                                                   - TO_NUMBER (
                                                        TO_CHAR (last_day(p_report_date)+1, 'yyyy')) > 9
                                              THEN
                                                 '8888'
                                              ELSE
                                                 nvl(RRRR, TO_CHAR (last_day(p_report_date), 'yyyy'))
                                           END)
                                    END) pyear,
                                   (CASE
                                       WHEN RRRR IN ('9999', '8888')
                                            OR TO_NUMBER (RRRR)
                                               - TO_NUMBER (TO_CHAR (last_day(p_report_date), 'yyyy')) < 2
                                       THEN
                                          W
                                       ELSE
                                          '0'
                                    END) pmes
                                from (    
                                    select F504_ID, INDICATOR_ID, RRRR, W, VAL
                                    from cim_f504_detail2 d1
                                    where indicator_id in (212, 213)
                                    union all 
                                    select F504_ID, INDICATOR_ID, RRRR, W, VAL
                                    from cim_f504_detail d1
                                    where indicator_id in (292, 293))
                                where (TO_CHAR (last_day(p_report_date), 'yyyymm') <= RRRR || LPAD (W, 2, '0')
                                       OR W = '0' AND TO_CHAR (last_day(p_report_date), 'yyyy') <= RRRR
                                       OR RRRR IN ('8888', '9999')
                                       OR RRRR is null)) d
              on (d.f504_id = c.f504_id)
              left outer join branch b
              on (c.branch = b.branch)
              WHERE c.branch LIKE '/'|| p_kod_filii ||'/%')
        where t071 is not null;

        logger.trace(c_title || 'From source #35 inserted ' || to_char(sql%rowcount) || ' records' );

        commit;
      EXCEPTION
        WHEN OTHERS  THEN
          logger.error(c_title || 'Error inserting rows from source #35: ' || SQLERRM);
      END;      
  else
    logger.info(c_title || 'Указанная дата не является последним рабочий днем месяца, поэтому не осуществялем запуск отчета!');
  end if;

  logger.info(c_title ||' end for date = '||to_char(p_report_date, 'dd.mm.yyyy'));
END;
/