PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/NBUR_P_F3DX.sql =========*** Run *** =
PROMPT ===================================================================================== 

PROMPT *** Create  procedure NBUR_P_F3DX ***

CREATE OR REPLACE PROCEDURE NBUR_P_F3DX (
                                           p_kod_filii  varchar2
                                           , p_report_date      date
                                           , p_form_id          number
                                           , p_scheme           varchar2 default 'C'
                                           , p_file_code        varchar2 default '3DX'
                                      )
is
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION : Процедура формирования 3DX в формате XML для Ощадного банку
% COPYRIGHT   : Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
%
% VERSION     :  v.18.001 12/12/2018 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
  ver_                     char(30)  := 'v.18.001    12/12/2018';

  c_title                  constant varchar2(200 char) := $$PLSQL_UNIT;
  c_date_fmt               constant varchar2(10 char) := 'dd.mm.yyyy'; --Формат преобразования даты в строку
  
  l_datez                  date := p_report_date + 1;
  l_nbuc                   varchar2(20 char);
  l_file_code              varchar2(2 char) := substr(p_file_code, 2, 2);
  l_type                   number;
  
  c_old_file_code          constant varchar2(3 char) := '#3D';

  l_file_id       nbur_ref_files.id%type := nbur_files.GET_FILE_ID(p_file_code => p_file_code);
  l_version_id    nbur_lst_files.version_id%type;  
  
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
    execute immediate 'alter table NBUR_LOG_F3DX truncate subpartition for ( to_date('''
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

  -- очікуємо формування старого файлу
  nbur_waiting_form(p_kod_filii, p_report_date, c_old_file_code, c_title);
  
  -- детальний протокол
  insert into nbur_log_f3DX
      (REPORT_DATE, KF, VERSION_ID, NBUC, EKP, Q003_1, Q003_2, Q007_1, T070_1, T070_2, T070_3, T070_4, Q003_3, Q007_2, S031
        , T070_5, T090,   Q014,   Q001_1, Q015_1, Q015_2, Q001_2, K020_1, Q003_4, F017_1
        , Q007_3, F018_1, Q007_4, Q005,   T070_6, T070_7, T070_8, T070_9, IDKU_1, Q002_1
        , Q002_2, Q002_3, Q001_3)
select  p_report_date, p_kod_filii, version_id, nvl(trim(nbuc), l_nbuc),
          EKP, Q003_1, Q003_2, Q007_1, T070_1, T070_2, T070_3, T070_4, Q003_3, Q007_2, S031
        , T070_5, T090,   Q014,   Q001_1, Q015_1, Q015_2, Q001_2, K020_1, Q003_4, F017_1
        , Q007_3, F018_1, Q007_4, Q005,   T070_6, T070_7, T070_8, T070_9, IDKU_1, Q002_1
        , Q002_2, Q002_3, Q001_3
  from ( 
          with data_3dx as 
          (
          select    version_id, nbuc
                  , Q003_1, Q003_2, Q007_1, T070_1, T070_2, T070_3, T070_4, Q003_3, Q007_2, S031
                  , T070_5, T090,   Q014,   Q001_1, Q015_1, Q015_2, Q001_2, K020_1, Q003_4, F017_1
                  , Q007_3, F018_1, Q007_4, Q005,   T070_6, T070_7, T070_8, T070_9, IDKU_1, Q002_1
                  , Q002_2, Q002_3, Q001_3
           from (select    v.version_id
                         , v.nbuc
                         , seg_01           -- DDD
                         , seg_02 as Q003_1 -- NNNNN
                         , seg_03 as S031   -- OO
                         , v.field_value
                    from v_nbur_#3D v
                   where v.report_date = p_report_date 
                     and v.kf = p_kod_filii 
                )
          pivot (
                 max(field_value)
                 for seg_01 in ('102' as Q003_2, '103' as Q007_1, '104' as T070_1, '105' as T070_2, '106' as T070_3, 
                                '107' as T070_4, '108' as Q003_3, '109' as Q007_2, '111' as T070_5, '112' as T090,
                                '113' as Q014,   '207' as Q001_1, '208' as Q015_1, '209' as Q015_2, '210' as Q001_2, 
                                '211' as K020_1, '212' as Q003_4, '213' as F017_1, '214' as Q007_3, '215' as F018_1, 
                                '216' as Q007_4, '217' as Q005,   '218' as T070_6, '219' as T070_7, '220' as T070_8, 
                                '221' as T070_9, '222' as IDKU_1,   '223' as Q002_1, '224' as Q002_2, '225' as Q002_3,
                                '226' as Q001_3)
                 )
          ) --end with
            select    k.version_id                 as    version_id
                    , k.nbuc                       as    nbuc
		    , 'A3D001'                     as    EKP
                    , k.Q003_1                     as    Q003_1
                    , k.Q003_2                     as    Q003_2
                    , to_date(k.Q007_1,'ddmmyyyy') as    Q007_1
                    , NVL(k.T070_1,0)              as    T070_1
                    , NVL(k.T070_2,0)              as    T070_2
                    , NVL(k.T070_3,0)              as    T070_3
                    , NVL(k.T070_4,0)              as    T070_4
                    , z.Q003_3                     as    Q003_3
                    , to_date(z.Q007_2,'ddmmyyyy') as     Q007_2
                    , (case 
                           when z.S031 in ('11','14','18','19','20','21','23','24','25','28','29','30','31','33','35','36','37','38','39','
                                             40','41','42','43','44','45','50','51','53','55','56','57','58','59','61','62','63','66','67','
                                             68','69','70','71','72','90') then z.S031
                           else '#'
                       end)                        as     S031
                    , NVL(z.T070_5,0)              as     T070_5
                    , NVL(z.T090,0)                as     T090
                    , z.Q014                       as     Q014
                    , z.Q001_1                     as     Q001_1
                    , z.Q015_1                     as     Q015_1
                    , z.Q015_2                     as     Q015_2
                    , z.Q001_2                     as     Q001_2
                    , LPAD(z.K020_1,10,'0')        as     K020_1
                    , z.Q003_4                     as     Q003_4
                    , (case 
                           when z.F017_1 in ('1','2')
                           then z.F017_1
                           else '#'
                      end)                         as     F017_1
                    , to_date(z.Q007_3,'ddmmyyyy') as     Q007_3
                    , (case 
                           when z.F018_1 in ('1','2')
                           then z.F018_1
                           else '#'
                      end)                         as     F018_1
                    , to_date(z.Q007_4,'ddmmyyyy') as     Q007_4
                    , NVL(z.Q005,0)                as     Q005
                    , NVL(z.T070_6,0)              as     T070_6
                    , NVL(z.T070_7,0)              as     T070_7
                    , NVL(z.T070_8,0)              as     T070_8
                    , NVL(z.T070_9,0)              as     T070_9
                    , LTRIM(z.IDKU_1,'0')          as     IDKU_1
                    , z.Q002_1                     as     Q002_1
                    , z.Q002_2                     as     Q002_2
                    , z.Q002_3                     as     Q002_3
                    , z.Q001_3                     as     Q001_3
              from data_3dx k, data_3dx z
             where k.Q003_1 =  z.Q003_1
               and k.S031   =  '00'
               and z.S031   <> '00'
     ); 


  logger.info (c_title || ' end for date = '||to_char(p_report_date, c_date_fmt));
END NBUR_P_F3DX;
/
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/NBUR_P_F3DX.sql =========*** End *** =
PROMPT ===================================================================================== 