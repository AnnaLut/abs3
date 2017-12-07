-- ======================================================================================
-- Module : DPU
-- Author : BAA
-- Date   : 28.11.2017
-- ===================================== <Comments> =====================================
-- reorganization PRIMARY KEY on table DPU_VIDD
-- creation       UNIQUE  KEY on table DPU_VIDD
-- recreation     FOREIGN KEY on table DPU_VIDD
-- add column     EXN_MTH_ID
-- ОБ22 не міститиме ознаки строковості
-- ======================================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET DEFINE       OFF
SET FEEDBACK     OFF
SET LINES        500
SET PAGES        500
SET TERMOUT      ON
SET TIMING       OFF
SET TRIMSPOOL    ON
set VERIFY       OFF

--
-- drop PRIMARY KEY
--
begin
  execute immediate 'ALTER TABLE DPU_VIDD DROP PRIMARY KEY CASCADE DROP INDEX';
  dbms_output.put_line( 'Table altered.' );
exception
  when OTHERS then 
    case
      when (sqlcode = -02441) 
      then dbms_output.put_line( 'Cannot drop nonexistent primary key.' );
      when (sqlcode = -02429)
      then dbms_output.put_line( 'Cannot drop index used for enforcement of unique/primary key' );
      else raise;
    end case;  
end;
/

--
-- create INDEX
--
begin
  execute immediate 'CREATE INDEX IDX_DPUVIDD_VIDD_TYPEID ON DPU_VIDD ( VIDD, TYPE_ID ) TABLESPACE BRSSMLI';
  dbms_output.put_line('Index "IDX_DPUVIDD_VIDD_TYPEID" created.');
exception
  when OTHERS then
    case
      when (sqlcode = -00955)
      then dbms_output.put_line('Index IDX_DPUVIDD_VIDD_TYPEID already exists in the table.');
      when (sqlcode = -01408)
      then dbms_output.put_line('Such column list already indexed.');
      else raise;
    end case;
end;
/

--
-- create PRIMARY KEY
--
begin
  execute immediate 'ALTER TABLE DPU_VIDD ADD CONSTRAINT PK_DPUVIDD PRIMARY KEY ( VIDD ) USING INDEX IDX_DPUVIDD_VIDD_TYPEID';
  dbms_output.put_line( 'Table altered.' );
exception
  when OTHERS then 
    if (sqlcode = -02260) 
    then dbms_output.put_line( 'Table can have only one primary key.' );
    else raise;
    end if;  
end;
/

--
-- create UNIQUE KEY
--
BEGIN
  execute immediate 'ALTER TABLE DPU_VIDD ADD CONSTRAINT UK_DPUVIDD UNIQUE ( VIDD, TYPE_ID ) USING INDEX IDX_DPUVIDD_VIDD_TYPEID';
  dbms_output.put_line('Unique key UK_DPUVIDD created.');
EXCEPTION
  when OTHERS then
    if (sqlcode = -02261) 
    then dbms_output.put_line('Such unique or primary key already exists in the table.');
    else raise;
    end if;
END;
/

--
-- recreate FOREIGN KEYs
--
begin
  execute immediate 'ALTER TABLE DPU_DEAL ADD CONSTRAINT FK_DPUDEAL_DPUVIDD FOREIGN KEY (VIDD) REFERENCES DPU_VIDD (VIDD)';  
  dbms_output.put_line('Foreign key FK_DPUDEAL_DPUVIDD created.');
exception
  when OTHERS then
    case 
      when (sqlcode = -02275)
      then dbms_output.put_line('Such a referential constraint already exists in the table.');
      when (sqlcode = -00942)
      then dbms_output.put_line('Table DPU_DEAL does not exist.');
      when (sqlcode = -00904) -- "COL_NAME": invalid identifier
      then dbms_output.put_line('Column "VIDD" does not exist in table "DPU_DEAL".'); 
      when (sqlcode = -02298) -- cannot validate - parent keys not found
      then 
        execute immediate 'ALTER TABLE DPU_DEAL ADD CONSTRAINT FK_DPUDEAL_DPUVIDD FOREIGN KEY (VIDD) REFERENCES DPU_VIDD (VIDD) ENABLE NOVALIDATE';
        dbms_output.put_line('Foreign key FK_DPUDEAL_DPUVIDD created with ENABLE NOVALIDATE.');
      else raise;
    end case;
end;
/

declare
  e_col_exists           exception;
  pragma exception_init( e_col_exists, -01430 );
begin
  execute immediate 'alter table DPU_VIDD add EXN_MTH_ID NUMBER(38)';
  dbms_output.put_line('Table altered.');
exception
  when e_col_exists then
    dbms_output.put_line( 'Column "EXN_MTH_ID" already exists in table.' );
end;
/

declare
  e_col_not_exists exception;
  pragma exception_init(e_col_not_exists,-00904);
begin
  execute immediate 'alter table DPU_VIDD drop column IRREVOCABLE';
  dbms_output.put_line( 'Table altered.' );
exception
  when e_col_not_exists then
    dbms_output.put_line( 'Column "IRREVOCABLE" does not exist in table.' );
end;
/

declare
  e_col_not_exists       exception;
  pragma exception_init( e_col_not_exists,-00904 );
  e_dup_col_nm           exception;
  pragma exception_init( e_dup_col_nm, -00957 );
begin
  execute immediate 'alter table DPU_VIDD rename column DPU_TYPE to IRVK';
  dbms_output.put_line( 'Table altered.' );
exception
  when e_col_not_exists
  then null;
  when e_dup_col_nm
  then dbms_output.put_line('Duplicate column name.');
end;
/

declare
  E_CNSTRN_NOT_EXISTS     exception;
  pragma exception_init( E_CNSTRN_NOT_EXISTS, -02443 );
begin
  execute immediate 'alter table DPU_VIDD drop constraint CC_DPUVIDD_SROK_NN';
  dbms_output.put_line( 'Table altered.' );
exception
  when E_CNSTRN_NOT_EXISTS
  then null;
end;
/

declare
  E_CHK_CNSTRN_EXISTS exception;
  pragma exception_init( E_CHK_CNSTRN_EXISTS, -02264 );
begin
  execute immediate 'alter table DPU_VIDD add constraint CC_DPUVIDD_COMPROC_FREQ check ( COMPROC = decode(FREQ_V,5,COMPROC,0) )';
  dbms_output.put_line( 'Table altered.' );
exception
  when E_CHK_CNSTRN_EXISTS
  then null;
end;
/

SET FEEDBACK ON

comment on column DPU_VIDD.COMPROC is 'Allowed compound interest';
comment on column DPU_VIDD.FREQ_V  is 'Frequency of interest payment';
comment on column DPU_VIDD.IRVK    is '1 - Irrevocable (terminable) / 0 - Revocable (on demand)';

update DPU_VIDD
   set TT  = 'DU%'
 where lnnvl( TT = 'DU%' );

commit;
