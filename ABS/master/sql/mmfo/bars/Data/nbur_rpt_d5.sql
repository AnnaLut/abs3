declare
  r_file        nbur_ref_files%rowtype;
  l_file_id     nbur_ref_files.id%type;
  l_file_code   nbur_ref_files.file_code%type;
  l_proc_id     nbur_ref_procs.id%type;
begin

  l_file_code := 'D5X';

  select *
    into r_file
    from NBUR_REF_FILES
   where FILE_CODE = '#'||substr(l_file_code,1,2);

  NBUR_FILES.SET_FILE
  ( p_file_id          => l_file_id
  , p_file_code        => l_file_code
  , p_scm_code         => r_file.SCHEME_CODE
  , p_file_tp          => r_file.FILE_TYPE
  , p_file_nm          => '(xml) '||r_file.FILE_NAME
  , p_file_fmt         => 'XML'
  , p_scm_num          => r_file.SCHEME_NUMBER
  , p_unit_code        => r_file.UNIT_CODE
  , p_period_tp        => r_file.PERIOD_TYPE
  , p_location_code    => r_file.LOCATION_CODE
  , p_file_code_alt    => null
  , p_cnsl_tp          => r_file.CONSOLIDATION_TYPE
  , p_val_tp_ind       => r_file.VALUE_TYPE_IND
  , p_view_nm          => 'V_NBUR_'||l_file_code
  , p_f_turns          => r_file.flag_turns
  );

  dbms_output.put_line( 'Created new file #' || to_char(l_file_id) );

  for l in ( select *
               from NBUR_REF_FILES_LOCAL
              where FILE_ID = r_file.ID 
           )
  loop
    NBUR_FILES.SET_FILE_LOCAL
    ( p_kf        => l.KF
    , p_file_id   => l_file_id
    , p_file_path => l.FILE_PATH
    , p_nbuc      => l.NBUC
    , p_e_address => l.E_ADDRESS
    );
  end loop;

  NBUR_FILES.SET_FILE_PROC
  ( p_proc_id => l_proc_id
   , p_file_id => l_file_id
   , p_proc_type => 'O'
   , p_proc_active => 'Y'
   , p_scheme => 'BARS'
   , p_proc_name => 'NBUR_P_FD5X_NC'
   , p_description => '(xml) '||r_file.FILE_NAME
   , p_version => '1.0'
   , p_date_start => date '2015-01-01'
   );

  --Удалим все ранее привязанные к отчету объекты, если такие были
  NBUR_FILES.SET_OBJECT_DEPENDENCIES
  ( 
    p_file_id => l_file_id
    , p_obj_id => null
    , p_strt_dt => date '2015-01-01'
  );

  NBUR_FILES.SET_FILE_DEPENDENCIES
  ( p_file_id  => l_file_id
  , p_file_pid => r_file.ID
  );

end;
/
commit;

SET DEFINE OFF;

-- опис для підготовки XML
delete from BARS.NBUR_REF_PREPARE_XML WHERE FILE_CODE = 'D5X'; 
Insert into BARS.NBUR_REF_PREPARE_XML
   (FILE_CODE, DESC_XML, DATE_START)
 Values
   ('D5X', 'select
      EKP
      , KU
      , T020
      , R020
      , R011
      , R013
      , R030
      , K040
      , K072
      , K111
      , K140
      , F074
      , S032
      , S080
      , S183
      , S190
      , S241
      , S260
      , F048
      , sum(T070) as T070
from    nbur_log_fd5x
where   report_date = :p_rpt_dt and 
      kf = :p_kf and
      ekp <> ''XXXXXX''               
group by
      EKP
      , KU
      , T020
      , R020
      , R011
      , R013
      , R030
      , K040
      , K072
      , K111
      , K140
      , F074
      , S032
      , S080
      , S183
      , S190
      , S241
      , S260
      , F048
having sum(T070) <> 0', TO_DATE('01/01/2018 00:00:00', 'MM/DD/YYYY HH24:MI:SS'));

-- опис показників 
delete from BARS.NBUR_REF_EKP_R020 where FILE_CODE = 'D5X';
Insert into BARS.NBUR_REF_EKP_R020
   (EKP, DSC, DESC_R020, DATE_START)
 Values
   ('AD51F4', 'Сума залишків за кредитами ', 'I010 (F4);
T020 (1, 2); 
R020 (1520, 1521, 1522, 1524, 1526, 1528, 1532, 1533, 1535, 1536, 1538, 1542, 1543, 1545, 1546, 1548, 2010, 2016, 2018, 2020, 2026, 2028, 2030, 2036, 2038, 2040, 2041, 2042, 2043, 2044, 2045, 2046, 2048, 2060, 2063, 2066, 2068, 2071, 2076, 2078, 2083, 2086, 2088, 2103, 2106, 2108, 2113, 2116, 2118, 2123, 2126, 2128, 2133, 2136, 2138, 2140, 2141, 2142, 2143, 2146, 2148, 2203, 2206, 2208, 2211, 2216, 2218, 2220, 2226, 2228, 2233, 2236, 2238, 2240, 2241, 2242, 2243, 2246, 2248, 2301, 2303, 2306, 2307, 2308, 2310, 2311, 2316, 2317, 2318, 2320, 2321, 2326, 2327, 2328, 2330, 2331, 2336, 2337, 2338, 2340, 2341, 2346, 2347, 2348, 2351, 2353, 2356, 2357, 2358, 2360, 2361, 2362, 2363, 2366, 2367, 2368, 2370, 2371, 2372, 2373, 2376, 2377, 2378, 2380, 2381, 2382, 2383, 2386, 2387, 2388, 2390, 2391, 2392, 2393, 2394, 2395, 2396, 2397, 2398, 2401, 2403, 2406, 2407, 2408, 2410, 2411, 2416, 2417, 2418, 2420, 2421, 2426, 2427, 2428, 2431, 2433, 2436, 2437, 2438, 2450, 2451, 2452, 2453, 2456, 2457, 2458, 3560, 3566, 3568)', TO_DATE('01/01/2018 00:00:00', 'MM/DD/YYYY HH24:MI:SS'));
Insert into BARS.NBUR_REF_EKP_R020
   (EKP, DSC, DESC_R020, DATE_START)
 Values
   ('AD51F2', 'Сума залишків за кредитами овердрафт', 'I010 (F2, F4);
T020 (1); 
R020 (1600, 1607, 2600, 2605, 2607, 2620, 2625, 2627, 2650, 2655, 2657)', TO_DATE('01/01/2018 00:00:00', 'MM/DD/YYYY HH24:MI:SS'));
Insert into BARS.NBUR_REF_EKP_R020
   (EKP, DSC, DESC_R020, DATE_START)
 Values
   ('AD52F2', 'Сума залишків за розміщеними депозитами', 'I010 (F2, F4);
T020 (1); 
R020 (1500, 1502, 1508, 1510, 1513, 1516, 1518)
', TO_DATE('01/01/2018 00:00:00', 'MM/DD/YYYY HH24:MI:SS'));
Insert into BARS.NBUR_REF_EKP_R020
   (EKP, DSC, DESC_R020, DATE_START)
 Values
   ('AD51F8', 'Сума залишків  за резервами під заборгованість за кредитами, гарантіями та зобов''язаннями', 'I010 (F8);
T020 (2);
R020 (1509, 1519, 1529, 1549, 1609, 2019, 2029, 2039, 2049, 2069, 2079, 2089, 2109, 2119, 2129, 2139, 2149, 2209, 2219, 2229, 2239, 2249, 2309, 2319, 2329, 2339, 2349, 2359, 2369, 2379, 2409, 2419, 2429, 2439, 2609, 2629, 2659, 3569, 3690, 3692)', TO_DATE('01/01/2018 00:00:00', 'MM/DD/YYYY HH24:MI:SS'));
Insert into BARS.NBUR_REF_EKP_R020
   (EKP, DSC, DESC_R020, DATE_START)
 Values
   ('AD51N9', 'Сума залишків за позабалансовими рахунками (гарантії, акцепти, інші зобов''язання, що надані банкам)', 'I010 (N9);
T020 (1, 2);
R020 (9000, 9001, 9002, 9003, 9100, 9122, 9129)', TO_DATE('01/01/2018 00:00:00', 'MM/DD/YYYY HH24:MI:SS'));
Insert into BARS.NBUR_REF_EKP_R020
   (EKP, DSC, DESC_R020, DATE_START)
 Values
   ('AD52F8', 'Сума списання безнадійної заборгованості за рахунок спеціального резерву', 'I010 (F8);
T020 (5);
R020 (1529, 1549, 1609, 2019, 2029, 2039, 2049, 2069, 2079, 2089, 2109, 2119, 2129, 2139, 2149, 2209, 2219, 2229, 2239, 2249, 2309, 2319, 2329, 2339, 2349, 2359, 2369, 2379, 2409, 2419, 2429, 2439, 2609, 2629, 2659, 3569)', TO_DATE('01/01/2018 00:00:00', 'MM/DD/YYYY HH24:MI:SS'));
COMMIT;
