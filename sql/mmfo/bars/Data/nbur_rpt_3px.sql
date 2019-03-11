exec bc.home;

-- Действия необходимые  для подключения в NBUR xml-файла 3PX
declare

   kodf_   varchar2(2)   := '3P';    

begin

      delete from BARS.staff_klf00   where kodf =kodf_;
      delete from BARS.KL_F00$LOCAL  where kodf =kodf_;
      delete from BARS.KL_F00$GLOBAL where kodf =kodf_;

      Insert into KL_F00$GLOBAL (KODF, AA, A017, NN, PERIOD, PROCC, R, SEMANTIC, TYPE_ZNAP)
           Values ( kodf_, '03', 'C', '12', 'Y', '1', '1',
                    '3PX -Дані про окремий зовнішній державний борг та приватний борг', 'N' );
 
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
  l_file_code := '3PX';

  select *
    into 
         r_file
  from NBUR_REF_FILES
  where FILE_CODE = '#4P';

  NBUR_FILES.SET_FILE( 
                        p_file_id            => l_file_id
                        , p_file_code        => l_file_code
                        , p_scm_code         => r_file.SCHEME_CODE
                        , p_file_tp          => r_file.FILE_TYPE
                        , p_file_nm          => substr('3PX Дані про окремий зовнішній державний борг та приватний борг, що гарантований державою', 1, 70)
                        , p_file_fmt         => 'XML'
                        , p_scm_num          => r_file.SCHEME_NUMBER
                        , p_unit_code        => r_file.UNIT_CODE
                        , p_period_tp        => 'Y'
                        , p_location_code    => r_file.LOCATION_CODE
                        , p_file_code_alt    => null
                        , p_cnsl_tp          => r_file.CONSOLIDATION_TYPE
                        , p_val_tp_ind       => r_file.VALUE_TYPE_IND
                        , p_view_nm          => 'V_NBUR_3PX'
                        , p_f_turns          => r_file.flag_turns
                   );

  update nbur_ref_files
    set file_code ='#3P'
   where file_code ='3PX';

  dbms_output.put_line( 'Created new file #' || to_char(l_file_id) );

  for l in ( 
             select *
             from   NBUR_REF_FILES_LOCAL
             where  FILE_ID = r_file.ID 
           )
  loop
    NBUR_FILES.SET_FILE_LOCAL( 
                                 p_kf        => l.KF
                                 , p_file_id   => l_file_id
                                 , p_file_path => l.FILE_PATH
                                 , p_nbuc      => l.NBUC
                                 , p_e_address => l.E_ADDRESS
                            );
  end loop;
  
  update nbur_ref_files_local n
  set nbuc = (select max(b040) from branch where branch = '/'||n.kf||'/') 
  where file_id = l_file_id;  

  nbur_files.SET_FILE_PROC(
                              p_proc_id => l_proc_id
                              , p_file_id => l_file_id
                              , p_proc_type => 'O'
                              , p_proc_active => 'Y'
                              , p_scheme => 'BARS'
                              , p_proc_name => 'NBUR_P_F3PX'
                              , p_description => '3P  XML-формат'
                              , p_version => 'v.19.001'
                              , p_date_start => date '2017-01-01'
                          );

end;
/
commit;

begin
    delete from NBUR_REF_PREPARE_XML where FILE_CODE = '#3P';
    Insert into NBUR_REF_PREPARE_XML
       (FILE_CODE, ATTR_NIL, DATE_START, DESC_XML)
     Values
       ('#3P', 'Q013', TO_DATE('01/01/2018 00:00:00', 'MM/DD/YYYY HH24:MI:SS'),
        'select  EKP
          , KU
          , K040
          , K020
          , R030_1
          , nvl(R030_2, ''#'') as R030_2 
          , S050      , S184      , F009
          , F010      , F011      , F012
          , F014      , F028      , F036
          , nvl(F045, ''#'') as F045
          , nvl(F047, ''#'') as F047
          , nvl(F048, ''#'') as F048
          , nvl(F050, ''#'') as F050
          , nvl(F052, ''#'') as F052
          , nvl(F054, ''#'') as F054
          , nvl(F055, ''#'') as F055
          , nvl(F070, ''#'') as F070
          , Q001_1    , Q001_2    , Q001_3
          , Q001_4    , Q003_1    , Q003_2
          , Q003_3    , Q006      , Q007_1
          , Q007_2    , Q007_3    , Q007_4
          , Q007_5    , Q007_6    , Q007_7
          , Q007_8    , Q007_9    , Q009
          , Q010_1    , Q010_2    , Q010_3
          , Q011_1    , Q011_2    , Q012_1
          , Q012_2    , Q013      , Q021
          , (case when EKP =''A3P007''
                    then      trim(to_char(T071,''990.000''))
                  else        trim(to_char(T071))
              end)     as  T071
    from   nbur_log_f3px
    where  report_date = :p_rpt_dt
          and kf = :p_kf' );
    COMMIT;
end;
/