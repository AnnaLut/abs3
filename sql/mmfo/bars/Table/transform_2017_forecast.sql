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
(
  KF              VARCHAR2(6 BYTE),
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
                                                   

begin
  execute immediate 'create index xuk_TRANSFORM_FORECAST on TRANSFORM_2017_FORECAST ( KF, NEW_NLS )';
exception
  when others then
    if sqlcode=-955 then null; else raise; end if;
end;
/

begin
  execute immediate 'create index xuk_TRANSFORM_FORECAST on TRANSFORM_2017_FORECAST ( KF, NLS )';
exception
  when others then
    if sqlcode=-955 then null; else raise; end if;
end;
/



begin
  execute immediate 'create index xak_TRANSFORM_FORECAST_acc on TRANSFORM_2017_FORECAST ( ACC)';
exception
  when others then
    if sqlcode=-955 then null; else raise; end if;
end;
/



grant select on TRANSFORM_2017_FORECAST to bars_access_defrole; 