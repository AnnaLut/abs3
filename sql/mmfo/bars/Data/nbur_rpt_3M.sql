exec bc.home;

Prompt     Create   #3M    for 3MX   in  KL_F00

declare

   kol_    number;
   kodf_   varchar2(2)   := '3M';        --#3M  в  kl_f00
   kodf_r  varchar2(2)   := 'E2';        --#E2  в  kl_f00

begin

      delete from BARS.staff_klf00   where kodf =kodf_;
      delete from BARS.KL_F00$LOCAL  where kodf =kodf_;
      delete from BARS.KL_F00$GLOBAL where kodf =kodf_;

    select count(*) 
     into kol_ 
    from kl_f00$GLOBAL 
    where kodf = kodf_r and a017 in ('C','G','D');

    if kol_ <> 0 then

         Insert into KL_F00$GLOBAL (KODF, AA, A017, NN, PERIOD, PROCC, R, SEMANTIC, KODF_EXT, F_PREF, PR_TOBO, TYPE_ZNAP)
             select   kodf_, AA, A017, '21', PERIOD, PROCC, R, '3MX -Дані про надходження та переказ безготівкової іноземної валюти',
                      KODF_EXT, F_PREF, PR_TOBO, TYPE_ZNAP
               from kl_f00$GLOBAL 
              where kodf =kodf_r and a017 in ('C','G','D');

          for f in (select kf from mv_kf)
          loop
              bc.subst_mfo(f.kf);
              
--              delete from kl_f00$LOCAL where kodf=kodf_;  
              
              insert into kl_f00$LOCAL(POLICY_GROUP, BRANCH, KODF, A017, UUU, ZZZ, PATH_O, DATF, NOM, KF) 
              select POLICY_GROUP, branch, kodf_, a017, uuu, zzz, path_o, TO_DATE('01/01/2018','DD/MM/YYYY'), '1', kf
              from kl_f00$LOCAL
              where kodf=kodf_r and a017 in ('C','G','D');
        
          end loop;

    end if;

    commit;
exception
    when others then
        if sqlcode = -2292 then
            null;
        else 
            raise;
        end if; 
end;
/

exec bc.home;

DECLARE 
  r_file1        nbur_ref_files%rowtype;
  r_file2        nbur_ref_files%rowtype;
  l_file_id     nbur_ref_files.id%type;
  l_file_code   nbur_ref_files.file_code%type;
  l_proc_id     nbur_ref_procs.id%type;

BEGIN 
  
  l_file_code := '#3M';

  select *
    into r_file1
    from NBUR_REF_FILES
   where FILE_CODE = '#E2';
  select *
    into r_file2
    from NBUR_REF_FILES
   where FILE_CODE = '#C9';

  NBUR_FILES.SET_FILE
  ( p_file_id          => l_file_id
  , p_file_code        => l_file_code
  , p_scm_code         => r_file1.SCHEME_CODE
  , p_file_tp          => r_file1.FILE_TYPE
  , p_file_nm          => '3MX -Дані про надходження та переказ безготівкової іноземної валюти'
  , p_file_fmt         => 'XML'
  , p_scm_num          => r_file1.SCHEME_NUMBER
  , p_unit_code        => '21'
  , p_period_tp        => r_file1.PERIOD_TYPE
  , p_location_code    => r_file1.LOCATION_CODE
  , p_file_code_alt    => null
  , p_cnsl_tp          => r_file1.CONSOLIDATION_TYPE
  , p_val_tp_ind       => r_file1.VALUE_TYPE_IND
  , p_view_nm          => 'V_NBUR_3MX'
  , p_f_turns          => r_file1.flag_turns
  );

    
  for k in ( select *  from NBUR_REF_FILES_LOCAL
             where FILE_ID = r_file1.ID
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
   , p_proc_name => 'NBUR_P_F3MX_NC'
   , p_description => '3M XML-формат'
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
  , p_file_pid => r_file1.ID
  );

  NBUR_FILES.SET_FILE_DEPENDENCIES
  ( p_file_id  => l_file_id
  , p_file_pid => r_file2.ID
  );

  COMMIT; 
END; 
/

-- опис для підготовки XML
begin

    delete from BARS.NBUR_REF_PREPARE_XML WHERE FILE_CODE = '#3M'; 

    Insert into NBUR_REF_PREPARE_XML
             ( FILE_CODE, DATE_START, DESC_XML )
     Values
             ( '#3M', TO_DATE('01/01/2018 00:00:00', 'MM/DD/YYYY HH24:MI:SS'),
'select EKP, KU, sum(T071) as T071, Q003_1, F091, R030, F090, K040, F089, K020, K021,
        Q001_1, B010, Q033, Q001_2, Q003_2, Q007_1, F027, F02D, Q006
    from nbur_log_f3MX t
    where report_date = :p_rpt_dt
      and kf = :p_kf
    group by EKP, KU, Q003_1, F091, R030, F090, K040, F089, K020, K021,
             Q001_1, B010, Q033, Q001_2, Q003_2, Q007_1, F027, F02D, Q006
    having sum(T071) <> 0
    order by 4' );

    COMMIT;
end;
/
