exec bc.home;

-- Действия необходимые  для подключения в NBUR xml-файла 4BX
declare

   kodf_   varchar2(2)   := '4B';    

begin

      delete from BARS.staff_klf00   where kodf =kodf_;
      delete from BARS.KL_F00$LOCAL  where kodf =kodf_;
      delete from BARS.KL_F00$GLOBAL where kodf =kodf_;

      Insert into KL_F00$GLOBAL (KODF, AA, A017, NN, PERIOD, PROCC, R, SEMANTIC, TYPE_ZNAP)
           Values ( kodf_, '03', 'C', '01', 'Q', '1', '1',
                    '4BX -Дотримання вимог достатності регул.капіталу та економ.нормативів', 'N' );
                     
        insert into kl_f00$LOCAL(POLICY_GROUP, BRANCH, KODF, A017, UUU, ZZZ, PATH_O, DATF, NOM, KF) 
        select POLICY_GROUP, branch, kodf_, a017, uuu, zzz, path_o, TO_DATE('01/01/2018','DD/MM/YYYY'), '1', kf
        from kl_f00$LOCAL
        where kodf='01' and a017 in ('C','G','D')
          and kf='300465';

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

declare
  r_file        nbur_ref_files%rowtype;
  l_file_id     nbur_ref_files.id%type;
  l_file_code   nbur_ref_files.file_code%type;
  l_proc_id     nbur_ref_procs.id%type;
begin

  l_file_code := '4BX';

  NBUR_FILES.SET_FILE
  ( p_file_id          => l_file_id
  , p_file_code        => '#4B'
  , p_scm_code         => 'C'
  , p_file_tp          => '1'                                     
  , p_file_nm          => '4BX -Дані про дотримання вимог щодо достатності регулятивного капіталу та економічних нормативів'
  , p_file_fmt         => 'XML'
  , p_scm_num          => '03'
  , p_unit_code        => '01'
  , p_period_tp        => 'Q'
  , p_location_code    => '1'
  , p_file_code_alt    => null
  , p_cnsl_tp          => null
  , p_val_tp_ind       => 'N'
  , p_view_nm          => 'V_NBUR_4BX'
  , p_f_turns          => 0
  );

  dbms_output.put_line( 'Created new file #' || to_char(l_file_id) );

    NBUR_FILES.SET_FILE_LOCAL
    ( p_kf        => '300465'
    , p_file_id   => l_file_id
    , p_file_path => 'C:\'
    , p_nbuc      => '300465'
    , p_e_address => 'ILP'
    );

  NBUR_FILES.SET_FILE_PROC
  ( p_proc_id => l_proc_id
   , p_file_id => l_file_id
   , p_proc_type => 'O'
   , p_proc_active => 'Y'
   , p_scheme => 'BARS'
   , p_proc_name => 'NBUR_P_F4BX_NC'
   , p_description => '4BX квартальний'
   , p_version => 'v.18.001'
   , p_date_start => date '2018-01-01'
   );

end;
/
commit;

-- опис для підготовки XML
begin
    delete from BARS.NBUR_REF_PREPARE_XML WHERE FILE_CODE = '#4B'; 

    Insert into NBUR_REF_PREPARE_XML
       (DATE_START, FILE_CODE, DESC_XML)
     Values
       (TO_DATE('01/01/2018 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), '#4B',
 'select EKP, F058, Q003_2, T070
    from nbur_log_f4BX 
   where report_date = :p_rpt_dt
     and kf = :p_kf ' );
    COMMIT;
end;
/

