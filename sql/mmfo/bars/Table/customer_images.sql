-- ======================================================================================
-- Module : 
-- Author : 
-- Date   : 21.06.2013
-- ======================================================================================
-- create table CUSTOMER_IMAGES
-- ======================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET FEEDBACK     OFF
SET TIMING       OFF
SET DEFINE       OFF
SET LINES        200
SET PAGES        100
SET TERMOUT      ON
SET TRIMSPOOL    ON

prompt -- ======================================================
prompt -- create table CUSTOMER_IMAGES
prompt -- ======================================================

begin
  bpa.alter_policy_info( 'CUSTOMER_IMAGES', 'WHOLE',  null, null, null, null ); 
  bpa.alter_policy_info( 'CUSTOMER_IMAGES', 'FILIAL', null, null, null, null );
  bpa.alter_policy_info( 'CUSTOMER_IMAGES', 'CENTER', null, null, null, null );
end;
/

declare
  e_tab_exists           exception;
  pragma exception_init( e_tab_exists, -00955 );
begin
  execute immediate 'create table CUSTOMER_IMAGES
( RNK        NUMBER(38)                      constraint CC_CUSTOMERIMGS_RNK_NN      NOT NULL
, TYPE_IMG   VARCHAR2(10)                    constraint CC_CUSTOMERIMGS_TYPEIMG_NN  NOT NULL
, DATE_IMG   DATE          DEFAULT SYSDATE   constraint CC_CUSTOMERIMGS_DATEIMG_NN  NOT NULL
, IMAGE      BLOB
, constraint PK_CUSTOMERIMGS primary key ( RNK, TYPE_IMG )
) tablespace BRSMDLD
LOB (IMAGE) STORE AS
( tablespace BRSBIGD
  CHUNK 8192
  RETENTION
  NOCACHE
  NOLOGGING )';
  
  dbms_output.put_line( 'Table "CUSTOMER_IMAGES" created.');
  
exception
  when e_tab_exists then
    dbms_output.put_line( 'Table "CUSTOMER_IMAGES" already exists.' );
end;
/

begin
  bars.bpa.alter_policies( 'CUSTOMER_IMAGES' );
end;
/

commit;

prompt -- ======================================================
prompt -- Comments
prompt -- ======================================================

SET FEEDBACK ON

COMMENT ON TABLE  CUSTOMER_IMAGES           IS 'Графічна інформація клієнта';

COMMENT ON COLUMN CUSTOMER_IMAGES.RNK       IS 'Реєстраційний номер клієнта';
COMMENT ON COLUMN CUSTOMER_IMAGES.TYPE_IMG  IS 'Тип  зображення';
COMMENT ON COLUMN CUSTOMER_IMAGES.DATE_IMG  IS 'Дата зображення';
COMMENT ON COLUMN CUSTOMER_IMAGES.IMAGE     IS 'Дані зображення';

prompt -- ======================================================
prompt -- Grants
prompt -- ======================================================

grant SELECT                         ON BARS.CUSTOMER_IMAGES to START1;
grant SELECT                         on CUSTOMER_IMAGES      to BARS_DM;
grant SELECT, INSERT, UPDATE, DELETE ON BARS.CUSTOMER_IMAGES to BARS_ACCESS_DEFROLE;
grant SELECT, INSERT, UPDATE, DELETE ON BARS.CUSTOMER_IMAGES to ABS_ADMIN;
grant SELECT, INSERT, UPDATE, DELETE ON BARS.CUSTOMER_IMAGES to WR_ALL_RIGHTS;

prompt -- create FOREIGN_KEYS

prompt -- ======================================================
prompt -- Constraints ( foreign keys )
prompt -- ======================================================

begin 
  execute immediate 'alter table CUSTOMER_IMAGES add constraint FK_CUSTOMERIMGS_TYPEIMG foreign key (TYPE_IMG) references CUSTOMER_IMAGE_TYPES (TYPE_IMG)';
  dbms_output.put_line( 'Table altered.' );
exception 
  when others then 
    if sqlcode = -2275
    then null;
    else raise;
    end if;
end;
/

begin 
  execute immediate 'alter table CUSTOMER_IMAGES add constraint FK_CUSTOMERIMGS_RNK foreign key (RNK) references CUSTOMER (RNK)';
  dbms_output.put_line( 'Table altered.' );
exception 
  when others then 
    if sqlcode = -2275
    then null;
    else raise;
    end if;
end;
/

prompt -- ======================================================
prompt -- FINISH
prompt -- ======================================================
