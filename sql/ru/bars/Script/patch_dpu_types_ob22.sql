-- ================================================================================
-- Module   : DPU
-- Author   : BAA
-- Modifier : BAA
-- Date     : dd.mm.yyyy
-- ================================== <Comments> ==================================
-- ОБ22 не міститиме ознаки строковості
-- ================================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET DEFINE       OFF
SET FEEDBACK     OFF
SET TERMOUT      ON
SET TRIMSPOOL    ON

declare
  e_col_not_exists       exception;
  pragma exception_init( e_col_not_exists,-00904 );
  e_dup_col_nm           exception;
  pragma exception_init( e_col_not_exists, -00957 );
begin
  execute immediate 'alter table DPU_TYPES_OB22 rename column S181 to IRVK';
  dbms_output.put_line('Table altered.');
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
  execute immediate 'alter table DPU_TYPES_OB22 drop constraint CC_DPUTYPESOB22_K013_S181';
  dbms_output.put_line( 'Table altered.' );
exception
  when E_CNSTRN_NOT_EXISTS
  then null;
end;
/

SET FEEDBACK ON

delete DPU_TYPES_OB22
 where ( K013, NBS_DEP ) not in ( select K013, NBS_DEP
                                    from DPU_NBS4CUST
                                   where NBS_DEP != ANY ('2615','2652')
                                );

commit;

update DPU_TYPES_OB22 d
   set d.IRVK = ( select s.IRVK
                    from DPU_NBS4CUST s
                   where s.K013    = d.K013
                     and s.NBS_DEP = d.NBS_DEP );

commit;
update DPU_TYPES_OB22 d
   set ( NBS_RED, OB22_RED ) = ( select s.R020_NEW, s.OB_NEW
                                   from TRANSFER_2017 s
                                  where s.R020_OLD = d.NBS_RED
                                    and s.OB_OLD   = d.OB22_RED )
 where ( NBS_RED,OB22_RED ) in ( select R020_OLD, OB_OLD
                                   from TRANSFER_2017 );

commit;

alter table DPU_TYPES_OB22 modify K013 CHAR(1);

alter table DPU_TYPES_OB22 modify NBS_DEP CHAR(4);
alter table DPU_TYPES_OB22 modify NBS_INT CHAR(4);
alter table DPU_TYPES_OB22 modify NBS_EXP CHAR(4);
alter table DPU_TYPES_OB22 modify NBS_RED CHAR(4);

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
  references DPU_NBS4CUST (K013,NBS_DEP) ON DELETE CASCADE]';
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
