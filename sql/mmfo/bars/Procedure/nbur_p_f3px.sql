PROMPT ===================================================================================== 
PROMPT *** Run *** ======= Scripts /Sql/BARS/Procedure/NBUR_P_F3PX.sql ======= *** Run *** =
PROMPT ===================================================================================== 

CREATE OR REPLACE PROCEDURE NBUR_P_F3PX (
                                           p_report_date       date
                                           , p_kod_filii       varchar2
                                           , p_form_id         number 
                                         )
 IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :  Процедура формирования 3PX     (file_code #3P/35180)
% COPYRIGHT   :  Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
%
% VERSION     :  v.18.003   28.12.2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    параметры: p_report_date - отчетная дата
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
  l_file_vers        char(30)  := '  v.18.003   28.12.2018';
  c_title            constant varchar2(100 char) := $$PLSQL_UNIT || '. ';

  --Константы определяющие форматы данных
  c_date_fmt         constant varchar2(10 char) := 'dd.mm.yyyy';
  c_amount_fmt       constant varchar2(50 char) := 'FM99999999999990';
  
  c_old_file_code   constant varchar2(3 char) := '#1A';  

  --Типы данных
  type t_nbur_3px is
    table of nbur_log_f3px%rowtype index by binary_integer;

  --Эксепшн, когда нет партиции
  e_ptsn_not_exsts   exception;

  l_nbuc                  varchar2(20);
  l_cim_nbuc              varchar2(20);  --Параметр nbuc для файлов 35 и 6А
  l_type                  number;
  l_counter               number;
  l_version_id            number;
  l_rows_inserted         boolean;
  l_datez                 date := p_report_date + 1;
  p_file_code             varchar2(3) := '#3P';
  l_file_code             varchar2(2) := '3P';
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

  l_row                   nbur_log_f3px%rowtype;
  l_#35_rows              t_nbur_3px;
  l_#6A_rows              t_nbur_3px;

  --Процедура добавления параметра в коллекцию
  procedure add_indicator(
                           p_ekp               in nbur_log_f3px.ekp%type
                           , p_rrrrw           in varchar2
                           , p_t071            in nbur_log_f3px.t071%type

                           , p_indicator       in out nbur_log_f3px%rowtype
                           , p_rows_inserted   in out boolean
                           , p_counter         in out number
                           , p_rows            in out nocopy t_nbur_3px
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
                           p_ekp               in nbur_log_f3px.ekp%type
                           , p_t071            in nbur_log_f3px.t071%type
                           , p_s050            in nbur_log_f3px.s050%type
                           , p_f028            in nbur_log_f3px.f028%type

                           , p_indicator       in out nbur_log_f3px%rowtype
                           , p_rows_inserted   in out boolean
                           , p_counter         in out number
                           , p_rows            in out nocopy t_nbur_3px
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
                || ' kod_filii=' || p_kod_filii || l_file_vers
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
--  nbur_waiting_form(p_kod_filii, p_report_date, c_old_file_code, c_title);

  --Определяем последнюю рабочую дату в этом месяце
  select max(fdat)
     into
         l_mnth_last_work_dt
  from   fdat
  where  fdat between trunc(fdat, 'MM') and last_day(p_report_date);


  --Запускаем построение отчета только в том случае, если дата является последним рабочий днем месяца
  if p_report_date = l_mnth_last_work_dt
  then
      --Подготавливаем партицию для вставки данных
      begin
        execute immediate 'alter table NBUR_LOG_F3PX truncate subpartition for ( to_date('''
                          || to_char(p_report_date,'YYYYMMDD')||''',''YYYYMMDD''), ''' || p_kod_filii || ''' )';
      exception
        when e_ptsn_not_exsts then
          null;
      end;

      logger.trace(c_title || 'Subpartition truncated');

      --Вставка данных из данных формы 503
      BEGIN
        insert /*+ APPPEND */ 
        into nbur_log_f3px(report_date, kf, nbuc, version_id, ekp, ku,
            r030_1, r030_2, k020, k040, s050, s184, f009, f010, f011, f012, f014, f028,
            f036, f045, f047, f048, f050, f052, f054, f055, f070, q001_1, q001_2, q001_3,
            q001_4, q003_1, q003_2, q003_3, q006, q007_1, q007_2, q007_3, q007_4, q007_5,
            q007_6, q007_7, q007_8, q007_9, q009, q010_1, q010_2, q010_3, q011_1, q011_2,
            q012_1, q012_2, q013, q021, t071, description, nd, branch)
        select unique p_report_date as report_date, p_kod_filii as kf, branch as nbuc, 
            l_version_id as version_id, substr(ekp, 1,6) EKP, KU, 
            R030_1,
              (case
                  when substr(EKP, 1,6) ='A3P005' and r030_2 is null
                    then        r030_1
                  else          r030_2   
                end)         as  R030_2, 
            K020, K040,
            substr(ekp, 7,1) as  S050,
            S184,
            F009,
            F010,
            F011,
            F012,
            F014,
            substr(ekp, 8,1) as  F028,
            F036,
            trim(to_char(F045))    as  F045, 
            trim(to_char(F047))    as  F047, 
            trim(to_char(F048))    as  F048, 
            trim(to_char(F050))    as  F050, 
            trim(to_char(F052))    as  F052, 
            trim(to_char(F054))    as  F054, 
            trim(to_char(F055))    as  F055, 
            trim(to_char(F070))    as  F070, 
            Q001_1, Q001_2, Q001_3, Q001_4, Q003_1, Q003_2, Q003_3,  Q006, 
            Q007_1, Q007_2, Q007_3, Q007_4, Q007_5, Q007_6, Q007_7, Q007_8, Q007_9,
            Q009, Q010_1, Q010_2, Q010_3, Q011_1, Q011_2, Q012_1, Q012_2, Q013, Q021,
            value   as T071,     'F503' DESCRIPTION, ND, BRANCH
        from (SELECT c.CONTR_ID  as ND,
                   b.obl      as KU,
                   c.BRANCH,
                   c.KF,
                   lpad(trim(Z), 10, '0') as K020,
                   P0300 as K040,
                   PVAL  as R030_1,
                   P3300 as R030_2,
                   P1900 as S184,
                   F009  as F009,
                   F010  as F010,
                   F011  as F011,
                   F012  as F012,
                   F014  as F014,
                   F036  as F036,
                   M     as F045,
                   P0100 as F047,
                   P0400 as F048,
                   P9600 as F050,
                   P1400 as F052,
                   P1700 as F054,
                   P1500 as F055,
                   P3200 as F070,       
                   P1000 as Q001_1,
                   Q001_2,
                   P1300 as Q001_3,
                   Q001_4,
                   P0500 as Q003_1,
                   lpad(trim(c.R_AGREE_NO), 5, '0') as Q003_2,
                   T as Q003_3,
                   P9900 as Q006,
                   to_char(Q007_1, 'dd.mm.yyyy')   as Q007_1,
                   to_char(Q007_2, 'dd.mm.yyyy')   as Q007_2,
                   to_char(Q007_3, 'dd.mm.yyyy')   as Q007_3,
                   to_char(Q007_4, 'dd.mm.yyyy')   as Q007_4,
                   to_char(P0600,  'dd.mm.yyyy')   as Q007_5,
                   to_char(Q007_6, 'dd.mm.yyyy')   as Q007_6,
                   to_char(Q007_7, 'dd.mm.yyyy')   as Q007_7,
                   to_char(Q007_8, 'dd.mm.yyyy')   as Q007_8,
                   to_char(P1200,  'dd.mm.yyyy')   as Q007_9,
                   Q009,
                   Q010_1,
                   '0' as Q010_2,
                   '0000' as Q010_3,
                   Q011_1,
                   Q011_2,
                   trim(p0800_1||' '|| p0800_2||' '|| p0800_3) as Q012_1, 
                   null      as Q012_2,
                   trim(to_char(P0700, '9990.0000')) as Q013,
                   P0900 as Q021,
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
                   nvl(p2014,0) + nvl(p2021,0) - nvl(p2037,0) as P2044,
                   P9500
              FROM cim_f503 c
              join cim_contracts c1 on ( c1.contr_id = c.contr_id and
                                         c1.contr_type =2 )
              join cim_contracts_credit c2 on ( c2.contr_id = c.contr_id and
                                                c2.credit_type =0 )
              left outer join branch b
              on (c.branch = b.branch)
              WHERE c.branch LIKE '/'|| p_kod_filii ||'/%')
          unpivot (value for ekp in ( -- ПОКАЗНИКИ НА ПОЧАТОК ПЕРІОДУ
                                                    P2010 as 'A3P00111#',
                                                    P2011 as 'A3P00121#',
                                                    P2012 as 'A3P00122#',
                                                    P2013 as 'A3P00123#',
                                                    P2014 as 'A3P00124#',
                                                    -- Сума одержаного кредиту
                                                    p2016 as 'A3P00211#',
                                                    -- Планові платежі
--                                                    p2017 as 'A3P00311#',
--                                                    p2018 as 'A3P00312#',
--                                                    p2020 as 'A3P00313#',
--                                                    p2021 as 'A3P00314#',
                                                    -- Фактичні платежі
                                                    -- основний борг
                                                    p2022 as 'A3P00311#', -- планова
                                                    p2023 as 'A3P00331#', -- достроково
                                                    p2024 as 'A3P00321#', -- прострочка
                                                    -- відсотки
                                                    p2029 as 'A3P00312#', -- планова
                                                    p2030 as 'A3P00332#', -- достроково
                                                    p2031 as 'A3P00322#', -- прострочка
                                                    -- комісійні
                                                    p2036 as 'A3P00313#',
                                                    -- пеня
                                                    p2037 as 'A3P00314#',
                                                    -- РЕОРГАНІЗАЦІЯ
                                                    --
                                                    p2026 as 'A3P004211',
                                                    p2027 as 'A3P004212',
                                                    p2028 as 'A3P004213',
                                                    --
                                                    p2033 as 'A3P004221',
                                                    p2034 as 'A3P004222',
                                                    p2035 as 'A3P004223',
                                                    -- ПОКАЗНИКИ на звітну дату
                                                    P2041 as 'A3P00511#',
                                                    P2038 as 'A3P00521#',
                                                    P2042 as 'A3P00522#',
                                                    P2043 as 'A3P00523#',
                                                    P2044 as 'A3P00524#',
                                                    -- Процентна ставка
                                                    P9500 as 'A3P007#1#'
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
        into nbur_log_f3px(report_date, kf, nbuc, version_id, ekp, ku,
            r030_1, r030_2, k020, k040, s050, s184, f009, f010, f011, f012, f014, f028,
            f036, f045, f047, f048, f050, f052, f054, f055, f070, q001_1, q001_2, q001_3,
            q001_4, q003_1, q003_2, q003_3, q006, q007_1, q007_2, q007_3, q007_4, q007_5,
            q007_6, q007_7, q007_8, q007_9, q009, q010_1, q010_2, q010_3, q011_1, q011_2,
            q012_1, q012_2, q013, q021, t071, description, nd, branch)
--         select * from (
           with f504_data as (
              SELECT c.CONTR_ID  as ND,
                   b.obl      as KU,
                   c.BRANCH,
                   c.KF,
                   lpad(trim(c.Z), 10, '0') as K020,
                   c.P030  as K040,
                   c.PVAL  as R030_1,
                   c.P330  as R030_2,
                   (case d.indicator_id 
                        when 212 then '1'
                        when 213 then '1'
                        when 292 then '2'
                        when 293 then '2'
                        else '#'
                   end)        as S050,
                   c.P184  as S184,                        
                   f.F009  as F009,                        --c.F009   из формы 503
                   f.F010  as F010,                        --c.F010   из формы 503
                   f.F011  as F011,                        --c.F011   из формы 503
                   f.F012  as F012,                        --c.F012   из формы 503
                   f.F014  as F014,                        --c.F014   из формы 503
                   (case d.indicator_id 
                        when 212 then '1'
                        when 213 then '2'
                        when 292 then '1'
                        when 293 then '2'
                        else '#'
                   end)        as F028,
                   f.F036  as F036,                        --c.F036   из формы 503
                   c.M     as F045,
                   c.P010  as F047,
                   nvl(to_char(f.p0400), '#')   as F048,         -- из формы 503
                   c.P960  as F050,
                   c.P108  as F052,
                   c.P142  as F054,
                   c.P140  as F055,
                   nvl(to_char(f.p3200), '#')   as F070,         -- из формы 503
                   c.P101  as Q001_1,
                   f.Q001_2,                                     --c.Q001_2   из формы 503
                   c.P107  as Q001_3,
                   f.Q001_4,                                     --c.Q001_4   из формы 503
                   c.P050  as Q003_1,
                   lpad(trim(c.R_AGREE_NO), 5, '0') as Q003_2,
                   c.T     as Q003_3,
                   c.P999  as Q006,
                   to_char(f.Q007_1, 'dd.mm.yyyy')   as Q007_1,       --c.Q007_1   из формы 503
                   to_char(f.Q007_2, 'dd.mm.yyyy')   as Q007_2,       --c.Q007_2   из формы 503
                   to_char(f.Q007_3, 'dd.mm.yyyy')   as Q007_3,       --c.Q007_3   из формы 503
                   to_char(f.Q007_4, 'dd.mm.yyyy')   as Q007_4,       --c.Q007_4   из формы 503
                   to_char(c.P060,   'dd.mm.yyyy')   as Q007_5,
                   to_char(f.Q007_6, 'dd.mm.yyyy')   as Q007_6,       --c.Q007_6   из формы 503
                   to_char(f.Q007_7, 'dd.mm.yyyy')   as Q007_7,       --c.Q007_7   из формы 503
                   to_char(f.Q007_8, 'dd.mm.yyyy')   as Q007_8,       --c.Q007_8   из формы 503
                   to_char(c.P103,   'dd.mm.yyyy')   as Q007_9,
                   f.Q009,                                            --c.Q009     из формы 503
                   f.Q010_1,                                          --c.Q010_1   из формы 503
                   d.pmes    as Q010_2,
                   (case
                       when d.pyear = to_char(p_report_date, 'yyyy') and d.pmes = '0' 
                                   then '9999'
                        else            d.pyear
                     end)                            as Q010_3,
                   f.Q011_1,                                          --c.Q011_1   из формы 503
                   f.Q011_2,                                          --c.Q011_2   из формы 503
                   c.P080      as Q012_1, 
                   null        as Q012_2,
                   trim(to_char(c.P070, '9990.0000')) as Q013,
                   P090        as Q021,
                   P950,
                   d.val       as T071
              FROM cim_f504 c
              join cim_contracts c1 on ( c1.contr_id = c.contr_id and
                                         c1.contr_type =2 )
              join cim_contracts_credit c2 on ( c2.contr_id = c.contr_id and
                                                c2.credit_type =0 )
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
                                where (TO_CHAR (last_day(p_report_date), 'yyyymm') <= RRRR || decode(W,'A','10','B','11','C','12',lpad(W,2,'0'))
                                       OR W = '0' AND TO_CHAR (last_day(p_report_date), 'yyyy') <= RRRR
                                       OR RRRR IN ('8888', '9999')
                                       OR RRRR is null)) d
              on (d.f504_id = c.f504_id)
              left outer join cim_f503 f
                      on (     lpad(trim(f.Z), 10,'0') = lpad(trim(c.Z), 10,'0')
                           and f.r_agree_no = c.r_agree_no
                           and nvl(f.contr_id,-1) = nvl(c.contr_id,-1) )
              left outer join branch b
                      on (c.branch = b.branch)
              WHERE c.branch LIKE '/'|| p_kod_filii ||'/%'
                             )
        select unique p_report_date as report_date, p_kod_filii as kf, branch as nbuc, 
            l_version_id as version_id, 'A3P006'  as EKP, KU, 
            R030_1,
              (case
                  when r030_2 is null
                    then        r030_1
                  else          r030_2   
                end)         as  R030_2, 
            K020, K040,
            S050,
            S184,
            F009,
            F010,
            F011,
            F012,
            F014,
            F028,
            F036,
            trim(to_char(F045))    as  F045, 
            trim(to_char(F047))    as  F047, 
            trim(to_char(F048))    as  F048, 
            trim(to_char(F050))    as  F050, 
            trim(to_char(F052))    as  F052, 
            trim(to_char(F054))    as  F054, 
            trim(to_char(F055))    as  F055, 
            '#'                    as  F070, 
            Q001_1, Q001_2, Q001_3, Q001_4, Q003_1, Q003_2, Q003_3,  Q006, 
            Q007_1, Q007_2, Q007_3, Q007_4, Q007_5, Q007_6, Q007_7, Q007_8, Q007_9,
            Q009, Q010_1, Q010_2, Q010_3, Q011_1, Q011_2, Q012_1, Q012_2, Q013, Q021,
            T071,  'F504' DESCRIPTION, ND, BRANCH
        from f504_data 
       where t071 is not null
       union all
        select unique p_report_date as report_date, p_kod_filii as kf, branch as nbuc, 
            l_version_id as version_id, 'A3P007'  as EKP, KU, 
            R030_1,
              (case
                  when r030_2 is null
                    then        r030_1
                  else          r030_2   
                end)         as  R030_2, 
            K020, K040,
            S050,
            S184,
            F009,
            F010,
            F011,
            F012,
            F014,
            F028,
            F036,
            trim(to_char(F045))    as  F045, 
            trim(to_char(F047))    as  F047, 
            trim(to_char(F048))    as  F048, 
            trim(to_char(F050))    as  F050, 
            trim(to_char(F052))    as  F052, 
            trim(to_char(F054))    as  F054, 
            trim(to_char(F055))    as  F055, 
            '#'                    as  F070, 
            Q001_1, Q001_2, Q001_3, Q001_4, Q003_1, Q003_2, Q003_3,  Q006, 
            Q007_1, Q007_2, Q007_3, Q007_4, Q007_5, Q007_6, Q007_7, Q007_8, Q007_9,
            Q009, Q010_1,
            (case when F036 ='3'
                     then   Q010_2
                  else       '0' 
              end)      as  Q010_2,
            (case when F036 ='3'
                     then   Q010_3
                  else      '0000' 
              end)      as  Q010_3,
            Q011_1, Q011_2, Q012_1, Q012_2, Q013, Q021,
            P950  as T071,  'F504' DESCRIPTION, ND, BRANCH
        from f504_data  
       where p950 is not null ;

        logger.trace(c_title || 'From source #36 inserted ' || to_char(sql%rowcount) || ' records' );

        commit;
      EXCEPTION
        WHEN OTHERS  THEN
          logger.error(c_title || 'Error inserting rows from source #36: ' || SQLERRM);
      END;      
      
  else
    logger.info(c_title || 'Указанная дата не является последним рабочий днем месяца, поэтому не осуществялем запуск отчета!');
  end if;

  logger.info(c_title ||' end for date = '||to_char(p_report_date, 'dd.mm.yyyy'));
end;
/

PROMPT ===================================================================================== 
PROMPT *** End *** ======= Scripts /Sql/BARS/Procedure/NBUR_P_F3PX.sql ======= *** End *** =
PROMPT =====================================================================================
