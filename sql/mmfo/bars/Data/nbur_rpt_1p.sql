declare
  r_file        nbur_ref_files%rowtype;
  l_file_id     nbur_ref_files.id%type;
  l_file_code   nbur_ref_files.file_code%type;
  l_proc_id     nbur_ref_procs.id%type;
begin

  l_file_code := '1PX';

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
   , p_proc_name => 'NBUR_P_F1PX_NC'
   , p_description => '(xml) '||r_file.FILE_NAME
   , p_version => '1.0'
   , p_date_start => date '2015-01-01'
   );

  --Удаляем все привязки к объектам, если они были
  NBUR_FILES.SET_OBJECT_DEPENDENCIES
  ( p_file_id => l_file_id
  , p_obj_id  => null
  , p_strt_dt => date '2015-01-01'
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
    delete from BARS.NBUR_REF_PREPARE_XML WHERE FILE_CODE = '1PX'; 
Insert into BARS.NBUR_REF_PREPARE_XML
   (FILE_CODE, DESC_XML, DATE_START)
 Values
   ('1PX', 'select p.EKP
   , p.K040_1
   , p.RCBNK_B010
   , p.RCBNK_NAME
   , p.K040_2
   , p.R030
   , p.R020
   , p.R040
   , p.T023
   , p.RCUKRU_GLB_2
   , coalesce(p.K018, ''#'') as K018
   , p.K020
   , p.Q001
   , p.RCUKRU_GLB_1
   , p.Q003_1
   , p.Q004
   , sum(p.T071) as T071
   , sum(p.T080) as T080
from NBUR_LOG_F1PX p
where report_date = :p_rpt_dt and
      kf = :p_kf
group by p.EKP
   , p.K040_1
   , p.RCBNK_B010
   , p.RCBNK_NAME
   , p.K040_2
   , p.R030
   , p.R020
   , p.R040
   , p.T023
   , p.RCUKRU_GLB_2
   , coalesce(p.K018, ''#'')
   , p.K020
   , p.Q001
   , p.RCUKRU_GLB_1
   , p.Q003_1
   , p.Q004', TO_DATE('01/01/2018 00:00:00', 'MM/DD/YYYY HH24:MI:SS'));
    COMMIT;
end;
/


