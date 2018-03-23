

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OKPOF659.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OKPOF659 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OKPOF659'', ''FILIAL'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OKPOF659 ***
begin 
  execute immediate '
  CREATE TABLE BARS.OKPOF659 
   (	NNNNN NUMBER(5,0), 
	EDRPOU NUMBER(8,0), 
	TXT VARCHAR2(120), 
	ZVITDATE DATE, 
	PAR_MAX NUMBER(1,0), 
	PAR_ATO NUMBER(1,0), 
	PAR_C1 VARCHAR2(1), 
	OBS NUMBER(1,0), 
	KAT NUMBER(1,0), 
	K NUMBER, 
        PAR_SK VARCHAR2(1),
        PAR_LINK VARCHAR2(3),
        PAR_INVEST VARCHAR2(1)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OKPOF659 ***
 exec bpa.alter_policies('OKPOF659');


COMMENT ON TABLE BARS.OKPOF659 IS '';
COMMENT ON COLUMN BARS.OKPOF659.NNNNN IS '';
COMMENT ON COLUMN BARS.OKPOF659.EDRPOU IS '';
COMMENT ON COLUMN BARS.OKPOF659.TXT IS '';
COMMENT ON COLUMN BARS.OKPOF659.ZVITDATE IS '';
COMMENT ON COLUMN BARS.OKPOF659.PAR_MAX IS '';
COMMENT ON COLUMN BARS.OKPOF659.PAR_ATO IS '';
COMMENT ON COLUMN BARS.OKPOF659.PAR_C1 IS '';
COMMENT ON COLUMN BARS.OKPOF659.OBS IS '';
COMMENT ON COLUMN BARS.OKPOF659.KAT IS '';
COMMENT ON COLUMN BARS.OKPOF659.K IS '';




PROMPT *** Create  constraint OKPOF659_U02 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OKPOF659 ADD CONSTRAINT OKPOF659_U02 UNIQUE (NNNNN)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint OKPOF659_U01 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OKPOF659 ADD CONSTRAINT OKPOF659_U01 UNIQUE (EDRPOU)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index OKPOF659_U01 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.OKPOF659_U01 ON BARS.OKPOF659 (EDRPOU) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index OKPOF659_U02 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.OKPOF659_U02 ON BARS.OKPOF659 (NNNNN) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT *** Create SYNONYM  to OKPOF659 ***

  CREATE OR REPLACE PUBLIC SYNONYM OKPOF659 FOR BARS.OKPOF659;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OKPOF659.sql =========*** End *** ====
PROMPT ===================================================================================== 
