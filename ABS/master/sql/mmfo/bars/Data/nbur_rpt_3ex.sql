Prompt create file 3E
exec bc.home;

DECLARE 
  l_file_id     nbur_ref_files.id%type;
  l_file_code	nbur_ref_files.file_code%type;
  l_proc_id     nbur_ref_procs.id%type;
  fld_lst       varchar2(350);
  l_sql         varchar2(1000);
  type          t_lst is table of varchar2(30);
  lst           t_lst;


BEGIN 
  l_file_id := nbur_files.GET_FILE_ID('#3E');

  NBUR_FILES.SET_FILE
  ( p_file_id          => l_file_id
  , p_file_code        => '#3E'
  , p_scm_code         => 'C'
  , p_file_tp          => '1'
  , p_file_nm          => '#3E - Дані про заставу за кредитами від НБУ'
  , p_file_fmt         => 'XML'
  , p_scm_num          => '03'
  , p_unit_code        => '01'
  , p_period_tp        => 'M'
  , p_location_code    => '1'
  , p_file_code_alt    => null
  , p_cnsl_tp          => 0
  , p_val_tp_ind       => 'C'
  , p_view_nm          => 'V_#3E'
  , p_f_turns          => 1
  );


  NBUR_FILES.SET_FILE_PROC
  ( p_proc_id => l_proc_id
   , p_file_id => l_file_id
   , p_proc_type => 'O'
   , p_proc_active => 'Y'
   , p_scheme => 'BARS'
   , p_proc_name => 'NBUR_F3EX'
   , p_description => '(xml) 3E XML-формат'
   , p_version => 'v.19.001'
   , p_date_start => date '2017-01-01'
   );

  delete NBUR_REF_FORM_STRU t where t.file_id = l_file_id;

  fld_lst := 'EKP,NN,Q003_1,Q003_2,Q007_1,S031,Q003_3,Q007_2,Q003_5,Q007_5,Q007_6,R030,T070_10,T071,T070_18,T070_19,
              K014,Q001_4,K020_2,S080_1,S080_2,T080,F093,F094,Q001_5,Q015_3,Q015_4,Q001_6,K020_3,T070_11,T070_20,
              F095,KU_2,Q002_4,Q002_5,Q002_6,F017_2,Q007_7,F018_2,Q007_8,F096,T070_12,T070_13,T070_14';

  l_sql := 'select regexp_substr(:fld_lst,''(\w+)(,|$)'', 1, rownum, ''m'', 1) as field_name '||chr(10)||
           '  from dual'||chr(10)||
           'connect by level <= regexp_count(:fld_lst, ''\w+(,|$)'',1,''m'')';

  execute immediate l_sql bulk collect into lst using fld_lst, fld_lst;

  for indx in lst.first..lst.last loop
        NBUR_FILES.SET_FILE_STC
        ( p_file_id       => l_file_id
        , p_seg_num       => indx
        , p_seg_nm        => lst(indx)
        , p_seg_rule      => lst(indx)
        , p_key_attr      => '1'
        , p_sort_attr     => indx
        , p_seg_code      => null
        );
  end loop;
  lst.delete;

  COMMIT; 
END; 
/

