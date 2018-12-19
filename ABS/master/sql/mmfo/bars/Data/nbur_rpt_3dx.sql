Prompt     create   file   3DX

exec bc.home;

declare
  r_file        nbur_ref_files%rowtype;
  l_file_id     nbur_ref_files.id%type;
  l_file_code   nbur_ref_files.file_code%type;
  l_proc_id     nbur_ref_procs.id%type;
  l_file_name   nbur_ref_files.file_name%type;
begin

  l_file_code := '3DX';
  l_file_name := '3DX Сума залишку наданого кредиту НБУ та сума майна переданого в заставу (крім майнових прав)';

  select *
    into r_file
    from NBUR_REF_FILES
   where FILE_CODE = '#'||substr(l_file_code,1,2);

  NBUR_FILES.SET_FILE
  ( p_file_id          => l_file_id
  , p_file_code        => l_file_code
  , p_scm_code         => r_file.SCHEME_CODE
  , p_file_tp          => r_file.FILE_TYPE
  , p_file_nm          => l_file_name
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
   , p_proc_name => 'NBUR_P_F3DX_NC'
   , p_description => '(xml) '||l_file_name
   , p_version => 'v.18.001'
   , p_date_start => date '2018-01-01'
   );

  NBUR_FILES.SET_OBJECT_DEPENDENCIES
  ( p_file_id => l_file_id
  , p_obj_id  => null
  , p_strt_dt => date '2018-01-01'
  );

  NBUR_FILES.SET_FILE_DEPENDENCIES
  ( p_file_id  => l_file_id
  , p_file_pid => r_file.ID
  );

end;
/
commit;

-- опис для підготовки XML
begin
    delete from BARS.NBUR_REF_PREPARE_XML WHERE FILE_CODE = '3DX'; 
    Insert into NBUR_REF_PREPARE_XML
       (FILE_CODE, DESC_XML, DATE_START, ATTR_NIL)
     Values
       ('3DX', 'select EKP, Q003_1, Q003_2, to_char(Q007_1,'''||'dd.mm.yyyy'||''') as Q007_1
, T070_1, T070_2, T070_3, T070_4, Q003_3, to_char(Q007_2,'''||'dd.mm.yyyy'||''') as Q007_2, S031
, T070_5, T090,   Q014,   Q001_1, Q015_1, Q015_2, Q001_2, K020_1, Q003_4, F017_1
, to_char(Q007_3,'''||'dd.mm.yyyy'||''') as Q007_3, F018_1, to_char(Q007_4,'''||'dd.mm.yyyy'||''') as Q007_4
, Q005,   T070_6, T070_7, T070_8, T070_9, IDKU_1, Q002_1, Q002_2, Q002_3, Q001_3
from nbur_log_f3DX 
where report_date = :p_rpt_dt
           and kf = :p_kf    
order by Q003_1,Q003_2,Q007_1,Q003_3,Q007_2,S031,Q001_1,K020_1,Q003_4', 
TO_DATE('01/01/2018 00:00:00', 'MM/DD/YYYY HH24:MI:SS'),
REGEXP_REPLACE('Q001_2,Q003_4,Q002_1,Q002_2,Q002_3,Q001_3', '(\s)+?','')
        );
    COMMIT;
end;
/