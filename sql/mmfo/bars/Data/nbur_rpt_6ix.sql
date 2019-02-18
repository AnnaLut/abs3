Prompt     create   file   6IX
exec bc.home;

DECLARE 
  r_file        nbur_ref_files%rowtype;
  l_file_id     nbur_ref_files.id%type;
  l_file_code   nbur_ref_files.file_code%type;
  l_proc_id     nbur_ref_procs.id%type;

BEGIN 
  
  l_file_code := '6IX';

  select *
    into r_file
    from NBUR_REF_FILES
   where FILE_CODE = '#D8';

  NBUR_FILES.SET_FILE
  ( p_file_id          => l_file_id
  , p_file_code        => l_file_code
  , p_scm_code         => r_file.SCHEME_CODE
  , p_file_tp          => r_file.FILE_TYPE
  , p_file_nm          => '(xml) 6IX Данi про концентрацію ризиків за активними операціями банку з контрагентами і ПО (Дані за рахунками та забезпечення)'
  , p_file_fmt         => 'XML'
  , p_scm_num          => r_file.SCHEME_NUMBER
  , p_unit_code        => r_file.UNIT_CODE
  , p_period_tp        => r_file.PERIOD_TYPE
  , p_location_code    => r_file.LOCATION_CODE
  , p_file_code_alt    => null
  , p_cnsl_tp          => r_file.CONSOLIDATION_TYPE
  , p_val_tp_ind       => r_file.VALUE_TYPE_IND
  , p_view_nm          => 'V_NBUR_6IX'
  , p_f_turns          => r_file.flag_turns
  );

   dbms_output.put_line( 'l_file_id_1='||l_file_id );
 
  if l_file_id is not null then
        update NBUR_REF_FILES
           set file_code = '#6I'
         where id = l_file_id;
   end if;
   commit;

   l_file_code := '#6I';

   -- додамо в таблицю KL_F00$GLOBAL, щоб було видно у ВЕБ в переліку файлів на формування
   NBUR_FILES.SET_FILE
     ( p_file_id          => l_file_id
     , p_file_code        => l_file_code
     , p_scm_code         => r_file.SCHEME_CODE
     , p_file_tp          => r_file.FILE_TYPE
     , p_file_nm          => '(xml) Данi про концентрацію ризиків за активними операціями банку з контрагентами і ПО (Дані за рахунками та забезпечення)'
     , p_file_fmt         => 'XML'
     , p_scm_num          => r_file.SCHEME_NUMBER
     , p_unit_code        => r_file.UNIT_CODE
     , p_period_tp        => r_file.PERIOD_TYPE
     , p_location_code    => r_file.LOCATION_CODE
     , p_file_code_alt    => null
     , p_cnsl_tp          => r_file.CONSOLIDATION_TYPE
     , p_val_tp_ind       => r_file.VALUE_TYPE_IND
     , p_view_nm          => 'V_NBUR_6IX'
     , p_f_turns          => r_file.flag_turns
     );

  dbms_output.put_line( 'l_file_id_2='||l_file_id );
  
  for k in ( select *  from NBUR_REF_FILES_LOCAL
             where FILE_ID = r_file.ID
  ) loop 
      NBUR_FILES.SET_FILE_LOCAL
      ( p_kf        => k.KF
      , p_file_id   => l_file_id
      , p_file_path => k.FILE_PATH
      , p_nbuc      => k.NBUC
      , p_e_address => k.E_ADDRESS
      );
  end loop;
  
  NBUR_FILES.SET_FILE_PROC
  ( p_proc_id => l_proc_id
   , p_file_id => l_file_id
   , p_proc_type => 'O'
   , p_proc_active => 'Y'
   , p_scheme => 'BARS'
   , p_proc_name => 'NBUR_P_F6IX_NC'
   , p_description => '(xml) 6I XML-формат'
   , p_version => 'v.18.001'
   , p_date_start => date '2018-01-01'
   );

  NBUR_FILES.SET_OBJECT_DEPENDENCIES
  ( p_file_id => l_file_id
  , p_obj_id  => null
  , p_strt_dt => date '2018-01-01'
  );

/* --наразі не встановлюємо      
  NBUR_FILES.SET_FILE_DEPENDENCIES
  ( p_file_id  => l_file_id
  , p_file_pid => r_file.ID
  );
*/
  COMMIT; 
END; 
/

-- опис для підготовки XML
begin
    delete from BARS.NBUR_REF_PREPARE_XML WHERE FILE_CODE = '#6I'; 
    Insert into NBUR_REF_PREPARE_XML
       ( DATE_START, FILE_CODE, DESC_XML, ATTR_NIL )
     Values
       (TO_DATE('01/01/2018 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), '#6I',
'select EKP, K020, K021, Q003_2, Q003_4, R030, R020, F081, S031, SUM(T070) as T070
 from (select distinct EKP, K020, K021, Q003_2, Q003_4, R030, R020, F081, S031, T070
         from nbur_log_f6IX t
        where report_date = :p_rpt_dt 
          and kf = :p_kf
       )
 group by EKP, K020, K021, Q003_2, Q003_4, R030, R020, F081, S031
 order by K020, EKP, Q003_2, Q003_4, R030, R020, F081, S031',
    null
       );

    COMMIT;
end;
/

-- опис показників 6IX NBUR_REF_EKP2                                                           
begin
    delete from BARS.NBUR_REF_EKP2 WHERE FILE_CODE = '6IX'; 
--
    Insert into BARS.NBUR_REF_EKP2
       (EKP, DSC, DESC_EKP)
     Values
       ('A6I001', 'Сума наданих банком фінансових зобов’язань за активними операціями з контрагентами/повьязаними з банком особами',
    'DDD(121);  
    R020 (1403, 1404, 1413, 1414, 1423, 1424, 1500, 1502, 1510, 1513, 1520, 1521, 1522, 1524, 
    1532, 1533, 1542, 1543, 1600, 1811, 1819, 2010, 2020, 2030, 2040, 2041, 2042, 2043, 2044, 
    2045, 2060, 2063, 2071, 2083, 2103, 2113, 2123, 2133, 2140, 2141, 2142, 2143, 2203, 2211, 
    2220, 2233, 2240, 2241, 2242, 2243, 2301, 2303, 2310, 2311, 2320, 2321, 2330, 2331, 2340, 
    2341, 2351, 2353, 2360, 2361, 2362, 2363, 2370, 2371, 2372, 2373, 2380, 2381, 2382, 2383, 
    2390, 2391, 2392, 2393, 2394, 2395, 2401, 2403, 2410, 2411, 2420, 2421, 2431, 2433, 2450, 
    2451, 2452, 2453, 2600, 2605, 2620, 2625, 2650, 2655, 2800, 2801, 2805, 2806, 2809, 3002, 
    3003, 3005, 3010, 3011, 3012, 3013, 3014, 3040, 3041, 3042, 3043, 3044, 3049, 3102, 3103, 
    3105, 3110, 3111, 3112, 3113, 3114, 3140, 3141, 3142, 3143, 3144, 3210, 3211, 3212, 3213, 
    3214, 3412, 3413, 3415, 3422, 3423, 3425, 3510, 3511, 3519, 3540, 3541, 3542, 3548, 3550, 
    3551, 3552, 3559, 3560, 3570, 3578)');
--
    Insert into BARS.NBUR_REF_EKP2
       (EKP, DSC, DESC_EKP)
     Values
       ('A6I011', 'Сума наданих банком фінансових зобов’язань за активними операціями з контрагентами/пов’язаними з банком особами',
    'DDD(121);  
    R020 (9200, 9201, 9202, 9203, 9204, 9206, 9207, 9208, 9300, 9321, 9324, 9328, 9221, 
          9224, 9228, 9350, 9351, 9352, 9353, 9354, 9356, 9357, 9358, 9359)');
--
    Insert into BARS.NBUR_REF_EKP2
       (EKP, DSC, DESC_EKP)
     Values
       ('A6I012', 'Сума наданих банком фінансових зобов’язань, які є ризиковими та безвідкличними, за активними операціями з контрагентами/пов’язаними з банком особами',
    'DDD(121);  
    R020 (9200, 9201, 9202, 9203, 9204, 9206, 9207, 9208, 9300, 9321, 9324, 9328, 9221, 
          9224, 9228, 9350, 9351, 9352, 9353, 9354, 9356, 9357, 9358, 9359)');
--
    COMMIT;
end;
/
