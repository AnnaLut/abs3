--drop table transform_2017_forecast;

BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TRANSFORM_2017_FORECAST'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''TRANSFORM_2017_FORECAST'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''TRANSFORM_2017_FORECAST'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/


begin 
  execute immediate '
CREATE TABLE BARS.TRANSFORM_2017_FORECAST
( KF              VARCHAR2(6 BYTE),
  KV              NUMBER(3),
  ACC             NUMBER(38)                    NOT NULL,
  NBS             CHAR(4 BYTE),
  NLS             VARCHAR2(15 BYTE),
  OB22            CHAR(2 BYTE),
  NEW_NBS         CHAR(4 BYTE),
  NEW_OB22        CHAR(2 BYTE),
  NEW_NLS         VARCHAR2(14 BYTE),
  INSERT_DATE     DATE
)';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/
                                                   
declare
  e_idx_exists           exception;
  pragma exception_init( e_idx_exists,      -00955 );
  e_col_already_idx      exception;
  pragma exception_init( e_col_already_idx, -01408 );
begin
  execute immediate 'create unique index UK_TRANSFORM_FORECAST_ACC ON TRANSFORM_2017_FORECAST ( ACC ) TABLESPACE BRSMDLI';

declare
  e_idx_exists           exception;
  pragma exception_init( e_idx_exists,      -00955 );
  e_col_already_idx      exception;
  pragma exception_init( e_col_already_idx, -01408 );
begin
  execute immediate 'create unique index UK_TRANSFORM_FORECAST_NLS ON TRANSFORM_2017_FORECAST ( KF, NEW_NLS, KV ) TABLESPACE BRSMDLI COMPRESS 1';
  dbms_output.put_line( 'Index created.' );
exception
  when e_idx_exists 
  then dbms_output.put_line( 'Name is already used by an existing object.' );
  when e_col_already_idx 
  then dbms_output.put_line( 'Such column list already indexed.' );
end;
/
grant select on TRANSFORM_2017_FORECAST to bars_access_defrole; 
