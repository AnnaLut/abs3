-- ======================================================================================
-- Module : UPL
-- ======================================================================================
-- ENABLE ALL CONSTRAINTS ON TABLE
-- ======================================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET FEEDBACK OFF

-- UPL_FILES -> UPL_SQL
BEGIN
  execute immediate 'alter table UPL_FILES enable constraint FK_UPLFILES_SQLID';
  dbms_output.put_line('Table UPL_FILES altered.');
EXCEPTION
  when OTHERS then
    if ( sqlcode = -02291 )
    then
      dbms_output.put_line('Error: integrity constraint (BARSUPL.FK_UPLFILES_SQLID) violated - parent key not found' );
      begin 
        for k in ( select unique f.SQL_ID
                     from UPL_FILES f
                     left
                     join UPL_SQL   s
                       on (s.SQL_ID = f.SQL_ID) 
                    where s.SQL_ID is null )
        loop
          dbms_output.put_line('Statement with ID = ' || to_char(k.SQL_ID) || 'does not exist in UPL_SQL.' );
        end loop;
      end;
    else
      dbms_output.put_line('Error else: ' || SQLERRM );
    end if;
END;
/

SET FEEDBACK ON

--
alter table UPL_STATS                enable constraint FK_UPLSTATSSQLID;

-- AUTOJOBS
alter table UPL_AUTOJOB_PARAM_VALUES ENABLE constraint FK_UPLAUTOJOBS_JOB;

SET FEEDBACK OFF

-- UPL_COLUMNS -> UPL_FILES
BEGIN
  execute immediate 'alter table UPL_COLUMNS enable constraint FK_UPLCOLUMNS_FILEID';
  dbms_output.put_line('Table UPL_COLUMNS altered.');
EXCEPTION
  when OTHERS then
    if ( sqlcode = -02291 )
    then
      dbms_output.put_line('Error: integrity constraint (BARSUPL.FK_UPLCOLUMNS_FILEID) violated - parent key not found' );
      begin
        for k in ( select unique c.file_id
                     from UPL_COLUMNS c
                     left
                     join UPL_FILES   f
                       on (f.file_id = c.file_id) 
                    where f.file_id is null )
        loop
          dbms_output.put_line('File with ID = ' || to_char(k.file_id) || 'does not exist in UPL_FILES.' );
        end loop;
      end;
    else
      dbms_output.put_line('Error: ' || SQLERRM );
    end if;
END;
/

-- UPL_FILEGROUPS_RLN -> UPL_FILES
BEGIN
  execute immediate 'alter table UPL_FILEGROUPS_RLN  enable constraint FK_FILESID';
  dbms_output.put_line('Table UPL_FILEGROUPS_RLN altered.');
EXCEPTION
  when OTHERS then
    if ( sqlcode = -02298 )
    then
      -- ( sqlcode = -02291 ) dbms_output.put_line('Error: integrity constraint (BARSUPL.FK_FILESID) violated - parent key not found' );
      dbms_output.put_line('Error: cannot validate (BARSUPL.FK_FILESID) - parent keys not found' );
      begin
        for k in ( select unique r.file_id
                     from UPL_FILEGROUPS_RLN r
                     left
                     join UPL_FILES   f
                       on (f.file_id = r.file_id) 
                    where f.file_id is null )
        loop
          dbms_output.put_line('File with ID = ' || to_char(k.file_id) || 'does not exist in UPL_FILES.' );
        end loop;
      end;
    else
      dbms_output.put_line('Error: ' || SQLERRM );
    end if;
END;
/

-- UPL_FILEGROUPS_RLN -> UPL_SQL
BEGIN
  execute immediate 'alter table UPL_FILEGROUPS_RLN  enable constraint FK_SQLID';
  dbms_output.put_line('Table UPL_FILEGROUPS_RLN altered.');
  dbms_output.new_line;
EXCEPTION
  when OTHERS then
    if ( sqlcode = -02298 )
    then
      -- ( sqlcode = -02291 ) dbms_output.put_line( 'Error: integrity constraint (BARSUPL.FK_SQLID) violated - parent key not found' );
      dbms_output.put_line('Error: cannot validate (BARSUPL.FK_SQLID) - parent keys not found' );
      begin
        for k in ( select unique r.SQL_ID
                     from UPL_FILEGROUPS_RLN r
                     left
                     join UPL_SQL s
                       on ( s.SQL_ID = r.SQL_ID ) 
                    where s.SQL_ID is null )
        loop
          dbms_output.put_line('Statement with ID = ' || to_char(k.SQL_ID) || ' does not exist in UPL_SQL.' );
        end loop;
        dbms_output.new_line;
      end;
    else
      dbms_output.put_line('Error: ' || SQLERRM );
      dbms_output.new_line;
    end if;
END;
/

SET FEEDBACK ON

alter table UPL_FILE_COUNTERS   enable constraint FK_UPLFILECOUNTS_FILEID;
alter table UPL_CONSTRAINTS     enable constraint FK_UPLCONSTRAINTS_FILEID;
alter table UPL_CONSTRAINTS     enable constraint FK_UPLCONSTRAINTS_FKFILEID;
alter table UPL_STATS           enable constraint FK_UPLSTATSFILEID;

-- CONSTRAINTS
alter table UPL_CONS_COLUMNS    enable constraint FK_UPLCONSCOLUMNS_FILEID;
-- COLUMNS
alter table UPL_CONS_COLUMNS    enable constraint FK_UPLCONSCOLUMNS_FILEIDCOLN;
/*
select unique cl.FILE_ID, cl.CONSTR_NAME
                     from UPL_CONS_COLUMNS cl
                     left
                     join UPL_CONSTRAINTS  cs
                       on ( cs.FILE_ID = cl.FILE_ID AND cs.CONSTR_NAME = cl.CONSTR_NAME ) 
                    where cs.CONSTR_NAME is null
*/



-- FILEGROUPS_RLN
alter table UPL_FILEGROUPS_RLN  enable constraint FK_GROUPID; 

-- TAG_LISTS
alter table UPL_TAG_LISTS enable constraint FK_UPLTAGLISTS_TAGTABLE;
alter table UPL_TAG_LISTS enable constraint FK_UPLTAGLISTS_UPLTAGREF;

-- UPL_FILES -> UPL_DOMAINS
BEGIN
  execute immediate 'alter table UPL_FILES enable constraint FK_DOMAINCODE';
  dbms_output.put_line('Table UPL_FILES (FK_DOMAINCODE) altered.');
EXCEPTION
  when OTHERS then
    if ( sqlcode = -02291 )
    then
      dbms_output.put_line('Error: integrity constraint UPL_FILES -> UPL_DOMAINS (BARSUPL.FK_DOMAINCODE) violated - parent key not found' );
      begin
        for k in ( select unique f.domain_code
                     from UPL_FILES f
                     left
                     join upl_domains   s
                       on (s.domain_code = f.domain_code) 
                    where s.domain_code is null )
        loop
          dbms_output.put_line('Statement with DOMAIN_CODE = ' || to_char(k.domain_code) || 'does not exist in UPL_DOMAINS.' );
        end loop;
      end;
    else
      dbms_output.put_line('Error: ' || SQLERRM );
    end if;
END;
/


prompt ...
prompt ... invalid objects for BARSUPL
prompt ...
--exec sys.utl_recomp.recomp_serial('BARSUPL');
select object_name as INVALID_OBJECT from all_objects
where status = 'INVALID'   and owner='BARSUPL';

--
prompt -- ======================================================
prompt -- BARS_UPLOAD_UTL.CHECK_SQL_STATEMENT
prompt -- ======================================================
--
begin
  for l_kf in (select kf from bars.mv_kf)
  loop
    bars.bc.go(l_kf.kf);
    for c in ( --select SQL_ID
               --  from BARSUPL.UPL_FILEGROUPS_RLN
               -- where GROUP_ID = 7
               -- UNION
               select distinct SQL_ID
                 from BARSUPL.UPL_FILEGROUPS_RLN
                where GROUP_ID = decode(l_kf.kf,'300465',4,2)
                   or GROUP_ID = decode(l_kf.kf,'300465',5,2)
                   or GROUP_ID = 99
                   or GROUP_ID = 7
             )
    loop
      BARSUPL.BARS_UPLOAD_UTL.CHECK_SQL_STATEMENT( c.SQL_ID );
    end loop;
  end loop;
  bars.bc.go('/');
end;
/
