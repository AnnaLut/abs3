-- ================================================================================
-- Module   : DPU
-- Author   : BAA
-- Modifier : BAA
-- Date     : 12.12.2017
-- ================================== <Comments> ==================================
-- нецезурна лексика з приводу того, що 
-- ОБ22 міститиме ознаку строковості замінив крапками: ............................
-- ................................................................................
-- ............................................................................ять.
-- ================================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET DEFINE       OFF
SET FEEDBACK     OFF
SET TERMOUT      ON
SET TRIMSPOOL    ON

prompt -- ======================================================
prompt -- == Drop old PRIMARY KEY
prompt -- ======================================================

begin
  execute immediate 'alter table DPU_TYPES_OB22 drop primary key drop index';
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

prompt -- ======================================================
prompt -- == Create new PRIMARY KEY
prompt -- ======================================================

declare
  e_pk_exists  exception;
  pragma exception_init( e_pk_exists, -02260 );
begin
  execute immediate 'alter table DPU_TYPES_OB22 add constraint PK_DPUTYPESOB22
  primary key ( TYPE_ID, NBS_DEP, R034, S181 ) using index tablespace BRSSMLI';
  dbms_output.put_line( 'Table altered.' );
exception
  when E_PK_EXISTS then 
    dbms_output.put_line( 'Table can have only one primary key.' );
end;
/

prompt -- ======================================================
prompt -- == add column IRVK
prompt -- ======================================================

declare
  e_col_exists           exception;
  pragma exception_init( e_col_exists, -01430 );
begin
  execute immediate 'alter table DPU_TYPES_OB22 add ( IRVK varchar2(1) )';
  dbms_output.put_line('Table altered.');
exception
  when e_col_exists then
    dbms_output.put_line( 'Column "IRVK" already exists in table.' );
end;
/

begin
  execute immediate '
  update ( select d.TYPE_ID, d.NBS_DEP, d.R034, d.IRVK
              , s.IRVK as IRVK_NEW
           from DPU_TYPES_OB22 d
           join DPU_NBS4CUST s
             on ( s.K013 = d.K013 and s.NBS_DEP = d.NBS_DEP )
          where d.IRVK != s.IRVK
       )
   set IRVK = IRVK_NEW';
  commit;
exception
  when OTHERS
  then dbms_output.put_line( sqlerrm );
end;
/

SET FEEDBACK ON

alter table DPU_TYPES_OB22 modify K013     CHAR(1);
alter table DPU_TYPES_OB22 modify NBS_DEP  CHAR(4);
alter table DPU_TYPES_OB22 modify NBS_INT  CHAR(4);
alter table DPU_TYPES_OB22 modify NBS_EXP  CHAR(4);
alter table DPU_TYPES_OB22 modify NBS_RED  CHAR(4);
alter table DPU_TYPES_OB22 modify OB22_DEP CHAR(2);
alter table DPU_TYPES_OB22 modify OB22_INT CHAR(2);
alter table DPU_TYPES_OB22 modify OB22_EXP CHAR(2);
alter table DPU_TYPES_OB22 modify OB22_RED CHAR(2);

SET FEEDBACK OFF

declare
  E_CHK_CNSTRN_EXISTS exception;
  pragma exception_init( E_CHK_CNSTRN_EXISTS, -02264 );
begin
  execute immediate Q'[alter table DPU_TYPES_OB22 add constraint CC_DPUTYPESOB22_K013_IRVK
  check ( IRVK = case when K013 = '1' then '0' else IRVK end )]';
  dbms_output.put_line( 'Table altered.' );
exception
  when E_CHK_CNSTRN_EXISTS
  then null;
end;
/

declare
  E_REF_CNSTRN_EXISTS exception;
  pragma exception_init( E_REF_CNSTRN_EXISTS, -02275 );
begin
  execute immediate q'[alter table DPU_TYPES_OB22 add constraint FK_DPUTYPESOB22_DPUNBS4CUST foreign key (K013,NBS_DEP)
  references DPU_NBS4CUST (K013,NBS_DEP) ON DELETE CASCADE NOVALIDATE]';
  dbms_output.put_line( 'Table altered.' );
exception
  when E_REF_CNSTRN_EXISTS
  then null;
end;
/

declare
  E_REF_CNSTRN_EXISTS exception;
  pragma exception_init( E_REF_CNSTRN_EXISTS, -02275 );
begin
  execute immediate q'[alter table DPU_TYPES_OB22 add constraint FK_DPUTYPESOB22_SBOB22_DEP foreign key (NBS_DEP,OB22_DEP)
  references SB_OB22 (R020,OB22) ON DELETE CASCADE]';
  dbms_output.put_line( 'Table altered.' );
exception
  when E_REF_CNSTRN_EXISTS
  then null;
end;
/

declare
  E_REF_CNSTRN_EXISTS exception;
  pragma exception_init( E_REF_CNSTRN_EXISTS, -02275 );
begin
  execute immediate q'[alter table DPU_TYPES_OB22 add constraint FK_DPUTYPESOB22_SBOB22_INT foreign key (NBS_INT,OB22_INT)
  references SB_OB22 (R020,OB22) ON DELETE CASCADE]';
  dbms_output.put_line( 'Table altered.' );
exception
  when E_REF_CNSTRN_EXISTS
  then null;
end;
/

declare
  E_REF_CNSTRN_EXISTS exception;
  pragma exception_init( E_REF_CNSTRN_EXISTS, -02275 );
begin
  execute immediate q'[alter table DPU_TYPES_OB22 add constraint FK_DPUTYPESOB22_SBOB22_EXP foreign key (NBS_EXP,OB22_EXP)
  references SB_OB22 (R020,OB22) ON DELETE CASCADE]';
  dbms_output.put_line( 'Table altered.' );
exception
  when E_REF_CNSTRN_EXISTS
  then null;
end;
/

declare
  E_REF_CNSTRN_EXISTS exception;
  pragma exception_init( E_REF_CNSTRN_EXISTS, -02275 );
begin
  execute immediate q'[alter table DPU_TYPES_OB22 add constraint FK_DPUTYPESOB22_SBOB22_RED foreign key (NBS_RED,OB22_RED)
  references SB_OB22 (R020,OB22) ON DELETE CASCADE]';
  dbms_output.put_line( 'Table altered.' );
exception
  when E_REF_CNSTRN_EXISTS
  then null;
end;
/
