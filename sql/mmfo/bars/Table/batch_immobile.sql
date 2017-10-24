

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BATCH_IMMOBILE.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BATCH_IMMOBILE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BATCH_IMMOBILE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''BATCH_IMMOBILE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''BATCH_IMMOBILE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BATCH_IMMOBILE ***
begin 
  execute immediate '
  CREATE TABLE BARS.BATCH_IMMOBILE 
   (	ID NUMBER, 
	CREATE_DATE DATE, 
	STATUS VARCHAR2(32), 
	LAST_TIME_REFRESH DATE, 
	DIRECTION VARCHAR2(20), 
	BSD VARCHAR2(10), 
	OB22 VARCHAR2(2), 
	KV VARCHAR2(6), 
	BRANCH VARCHAR2(35), 
	USERID NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BATCH_IMMOBILE ***
 exec bpa.alter_policies('BATCH_IMMOBILE');


COMMENT ON TABLE BARS.BATCH_IMMOBILE IS '';
COMMENT ON COLUMN BARS.BATCH_IMMOBILE.ID IS '';
COMMENT ON COLUMN BARS.BATCH_IMMOBILE.CREATE_DATE IS '';
COMMENT ON COLUMN BARS.BATCH_IMMOBILE.STATUS IS '';
COMMENT ON COLUMN BARS.BATCH_IMMOBILE.LAST_TIME_REFRESH IS '';
COMMENT ON COLUMN BARS.BATCH_IMMOBILE.DIRECTION IS '';
COMMENT ON COLUMN BARS.BATCH_IMMOBILE.BSD IS '';
COMMENT ON COLUMN BARS.BATCH_IMMOBILE.OB22 IS '';
COMMENT ON COLUMN BARS.BATCH_IMMOBILE.KV IS '';
COMMENT ON COLUMN BARS.BATCH_IMMOBILE.BRANCH IS '';
COMMENT ON COLUMN BARS.BATCH_IMMOBILE.USERID IS '';




PROMPT *** Create  constraint PK_BATCH_IMMOBILE ***
begin   
 execute immediate '
  ALTER TABLE BARS.BATCH_IMMOBILE ADD CONSTRAINT PK_BATCH_IMMOBILE PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_BATCH_IMMOBILE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_BATCH_IMMOBILE ON BARS.BATCH_IMMOBILE (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BATCH_IMMOBILE ***
grant INSERT,SELECT,UPDATE                                                   on BATCH_IMMOBILE  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on BATCH_IMMOBILE  to BARS_DM;
grant INSERT,SELECT,UPDATE                                                   on BATCH_IMMOBILE  to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BATCH_IMMOBILE.sql =========*** End **
PROMPT ===================================================================================== 
