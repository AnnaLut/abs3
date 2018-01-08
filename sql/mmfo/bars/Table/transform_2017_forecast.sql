

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TRANSFORM_2017_FORECAST.sql =========*
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TRANSFORM_2017_FORECAST ***


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

PROMPT *** Create  table TRANSFORM_2017_FORECAST ***
begin 
  execute immediate '
  CREATE TABLE BARS.TRANSFORM_2017_FORECAST 
   (	KF VARCHAR2(6), 
	KV NUMBER(3,0), 
	ACC NUMBER(38,0), 
	NBS CHAR(4), 
	NLS VARCHAR2(15), 
	OB22 CHAR(2), 
	NEW_NBS CHAR(4), 
	NEW_OB22 CHAR(2), 
	NEW_NLS VARCHAR2(14), 
	INSERT_DATE DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TRANSFORM_2017_FORECAST ***
 exec bpa.alter_policies('TRANSFORM_2017_FORECAST');


COMMENT ON TABLE BARS.TRANSFORM_2017_FORECAST IS '';
COMMENT ON COLUMN BARS.TRANSFORM_2017_FORECAST.KF IS '';
COMMENT ON COLUMN BARS.TRANSFORM_2017_FORECAST.KV IS '';
COMMENT ON COLUMN BARS.TRANSFORM_2017_FORECAST.ACC IS '';
COMMENT ON COLUMN BARS.TRANSFORM_2017_FORECAST.NBS IS '';
COMMENT ON COLUMN BARS.TRANSFORM_2017_FORECAST.NLS IS '';
COMMENT ON COLUMN BARS.TRANSFORM_2017_FORECAST.OB22 IS '';
COMMENT ON COLUMN BARS.TRANSFORM_2017_FORECAST.NEW_NBS IS '';
COMMENT ON COLUMN BARS.TRANSFORM_2017_FORECAST.NEW_OB22 IS '';
COMMENT ON COLUMN BARS.TRANSFORM_2017_FORECAST.NEW_NLS IS '';
COMMENT ON COLUMN BARS.TRANSFORM_2017_FORECAST.INSERT_DATE IS '';




PROMPT *** Create  constraint SYS_C00139401 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TRANSFORM_2017_FORECAST MODIFY (ACC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XUK_TRANSFORM_FORECAST ***
begin   
 execute immediate '
  CREATE INDEX BARS.XUK_TRANSFORM_FORECAST ON BARS.TRANSFORM_2017_FORECAST (KF, NEW_NLS) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index XAK_TRANSFORM_FORECAST_ACC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XAK_TRANSFORM_FORECAST_ACC ON BARS.TRANSFORM_2017_FORECAST (ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TRANSFORM_2017_FORECAST ***
grant SELECT                                                                 on TRANSFORM_2017_FORECAST to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TRANSFORM_2017_FORECAST to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TRANSFORM_2017_FORECAST.sql =========*
PROMPT ===================================================================================== 
