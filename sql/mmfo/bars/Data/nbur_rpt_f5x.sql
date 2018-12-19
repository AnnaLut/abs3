exec bc.home;

-- Действия необходимые  для подключения в NBUR xml-файла F5X
declare

   kodf_   varchar2(2)   := 'F5';    

begin

      delete from BARS.staff_klf00   where kodf =kodf_;
      delete from BARS.KL_F00$LOCAL  where kodf =kodf_;
      delete from BARS.KL_F00$GLOBAL where kodf =kodf_;

      Insert into KL_F00$GLOBAL (KODF, AA, A017, NN, PERIOD, PROCC, R, SEMANTIC, TYPE_ZNAP)
           Values ( kodf_, '03', 'C', '01', 'P', '1', '1',
                    'F5X -Дані про збитки банку через cумнівні операції з платіжн.картками', 'N' );
 
--        insert into kl_f00$LOCAL(POLICY_GROUP, BRANCH, KODF, A017, UUU, ZZZ, PATH_O, DATF, NOM, KF) 
--        select POLICY_GROUP, branch, kodf_, a017, uuu, zzz, path_o, TO_DATE('01/01/2018','DD/MM/YYYY'), '1', kf
--        from kl_f00$LOCAL
--        where kodf='01' and a017 in ('C','G','D')
--          and kf='300465';

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

  l_file_code := 'F5X';

  NBUR_FILES.SET_FILE
  ( p_file_id          => l_file_id
  , p_file_code        => l_file_code
  , p_scm_code         => 'C'
  , p_file_tp          => '1'                                     
  , p_file_nm          => 'F5X -Дані про збитки банку, держателів платіжних карток і торговців через незаконні дії/сумнівні операції з платіжними картками'
  , p_file_fmt         => 'XML'
  , p_scm_num          => '03'
  , p_unit_code        => '01'
  , p_period_tp        => 'P'
  , p_location_code    => '1'
  , p_file_code_alt    => null
  , p_cnsl_tp          => null
  , p_val_tp_ind       => 'N'
  , p_view_nm          => 'V_NBUR_F5X'
  , p_f_turns          => 0
  );

  update nbur_ref_files
    set file_code ='#F5'
   where file_code ='F5X';

  dbms_output.put_line( 'Created new file #' || to_char(l_file_id) );

  if l_file_id is not null  then

      for l in ( select *
                   from NBUR_REF_FILES_LOCAL
                  where FILE_ID = ( select ID  from nbur_ref_files
                                     where file_code ='#01' )
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
       , p_proc_name => 'NBUR_P_FF5X_NC'
       , p_description => 'F5X піврічний'
       , p_version => 'v.18.001'
       , p_date_start => date '2018-01-01'
       );
   end if;

end;
/
commit;

-- опис для підготовки XML
begin
    delete from BARS.NBUR_REF_PREPARE_XML WHERE FILE_CODE = '#F5'; 

    Insert into NBUR_REF_PREPARE_XML
       (DATE_START, FILE_CODE, DESC_XML)
     Values
       (TO_DATE('01/01/2018 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), '#F5',
 'select EKP, Z230, Z350, K045, Z130, Z140, Z150, KU, T070, T080
    from nbur_log_ff5X 
   where report_date = :p_rpt_dt
     and kf = :p_kf ' );
    COMMIT;
end;
/

