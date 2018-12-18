Prompt     create   file   6HX
exec bc.home;

DECLARE 
  r_file        nbur_ref_files%rowtype;
  l_file_id     nbur_ref_files.id%type;
  l_file_code   nbur_ref_files.file_code%type;
  l_proc_id     nbur_ref_procs.id%type;

BEGIN 
  
  l_file_code := '6HX';

  select *
    into r_file
    from NBUR_REF_FILES
   where FILE_CODE = '#D8';

  NBUR_FILES.SET_FILE
  ( p_file_id          => l_file_id
  , p_file_code        => l_file_code
  , p_scm_code         => r_file.SCHEME_CODE
  , p_file_tp          => r_file.FILE_TYPE
  , p_file_nm          => '(xml) 6HX Дані за валютами та траншами за активними операціями з контрагентами/пов’язаними з банком особами'
  , p_file_fmt         => 'XML'
  , p_scm_num          => r_file.SCHEME_NUMBER
  , p_unit_code        => r_file.UNIT_CODE
  , p_period_tp        => r_file.PERIOD_TYPE
  , p_location_code    => r_file.LOCATION_CODE
  , p_file_code_alt    => null
  , p_cnsl_tp          => r_file.CONSOLIDATION_TYPE
  , p_val_tp_ind       => r_file.VALUE_TYPE_IND
  , p_view_nm          => 'V_NBUR_6HX'
  , p_f_turns          => r_file.flag_turns
  );

   dbms_output.put_line( 'l_file_id_1='||l_file_id );
 
  if l_file_id is not null then
        update NBUR_REF_FILES
           set file_code = '#6H'
         where id = l_file_id;
   end if;
   commit;

   l_file_code := '#6H';

   -- додамо в таблицю KL_F00$GLOBAL, щоб було видно у ВЕБ в переліку файлів на формування
   NBUR_FILES.SET_FILE
     ( p_file_id          => l_file_id
     , p_file_code        => l_file_code
     , p_scm_code         => r_file.SCHEME_CODE
     , p_file_tp          => r_file.FILE_TYPE
     , p_file_nm          => '(xml) 6HX Дані за валютами та траншами за активними операціями з контрагентами/пов’язаними з банком особами'
     , p_file_fmt         => 'XML'
     , p_scm_num          => r_file.SCHEME_NUMBER
     , p_unit_code        => r_file.UNIT_CODE
     , p_period_tp        => r_file.PERIOD_TYPE
     , p_location_code    => r_file.LOCATION_CODE
     , p_file_code_alt    => null
     , p_cnsl_tp          => r_file.CONSOLIDATION_TYPE
     , p_val_tp_ind       => r_file.VALUE_TYPE_IND
     , p_view_nm          => 'V_NBUR_6HX'
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
   , p_proc_name => 'NBUR_P_F6HX_NC'
   , p_description => '(xml) 6H XML-формат'
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
    delete from BARS.NBUR_REF_PREPARE_XML WHERE FILE_CODE = '#6H'; 
    Insert into NBUR_REF_PREPARE_XML
       ( DATE_START, FILE_CODE, DESC_XML, ATTR_NIL )
     Values
       (TO_DATE('01/01/2018 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), '#6H',
'select distinct EKP, K020, K021, Q003_2, Q003_4, R030,
	to_char(Q007_1,'''||'dd.mm.yyyy'||''') as Q007_1,
	to_char(Q007_2,'''||'dd.mm.yyyy'||''') as Q007_2, 
	S210, S083, S080_1, S080_2, F074, F077, F078, F102, Q017, Q027, Q034, Q035, 
	T070_2, T090, T100_1, T100_2, T100_3
    from nbur_log_f6HX t
    where  report_date = :p_rpt_dt and
           kf = :p_kf
    order by K020, Q003_2, Q003_4, R030',
    REGEXP_REPLACE('Q007_2,Q017,Q027,Q034,Q035', '(\s)+?','') 
       );

    COMMIT;
end;
/
