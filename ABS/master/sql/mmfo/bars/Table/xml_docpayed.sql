

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/XML_DOCPAYED.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to XML_DOCPAYED ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''XML_DOCPAYED'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''XML_DOCPAYED'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''XML_DOCPAYED'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table XML_DOCPAYED ***
begin 
  execute immediate '
  CREATE TABLE BARS.XML_DOCPAYED 
   (	REF NUMBER(38,0), 
	TT CHAR(3), 
	DK NUMBER(1,0), 
	ACC NUMBER(38,0), 
	FDAT DATE, 
	S NUMBER(24,0), 
	SQ NUMBER(24,0), 
	TXT VARCHAR2(70), 
	STMT NUMBER(38,0), 
	SOS NUMBER(1,0), 
	ID NUMBER(38,0), 
	KF VARCHAR2(6), 
	OTM NUMBER(*,0), 
	ACTION CHAR(1), 
	CHANGE_DATE DATE, 
	CHANGE_NUMBER NUMBER, 
	SYSTEM_CHANGE_NUMBER NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to XML_DOCPAYED ***
 exec bpa.alter_policies('XML_DOCPAYED');


COMMENT ON TABLE BARS.XML_DOCPAYED IS 'Оплаченные проводки для синхронизации';
COMMENT ON COLUMN BARS.XML_DOCPAYED.REF IS '';
COMMENT ON COLUMN BARS.XML_DOCPAYED.TT IS '';
COMMENT ON COLUMN BARS.XML_DOCPAYED.DK IS '';
COMMENT ON COLUMN BARS.XML_DOCPAYED.ACC IS '';
COMMENT ON COLUMN BARS.XML_DOCPAYED.FDAT IS '';
COMMENT ON COLUMN BARS.XML_DOCPAYED.S IS '';
COMMENT ON COLUMN BARS.XML_DOCPAYED.SQ IS '';
COMMENT ON COLUMN BARS.XML_DOCPAYED.TXT IS '';
COMMENT ON COLUMN BARS.XML_DOCPAYED.STMT IS '';
COMMENT ON COLUMN BARS.XML_DOCPAYED.SOS IS '';
COMMENT ON COLUMN BARS.XML_DOCPAYED.ID IS '';
COMMENT ON COLUMN BARS.XML_DOCPAYED.KF IS '';
COMMENT ON COLUMN BARS.XML_DOCPAYED.OTM IS '';
COMMENT ON COLUMN BARS.XML_DOCPAYED.ACTION IS '';
COMMENT ON COLUMN BARS.XML_DOCPAYED.CHANGE_DATE IS '';
COMMENT ON COLUMN BARS.XML_DOCPAYED.CHANGE_NUMBER IS '';
COMMENT ON COLUMN BARS.XML_DOCPAYED.SYSTEM_CHANGE_NUMBER IS '';




PROMPT *** Create  constraint SYS_C005778 ***
begin   
 execute immediate '
  ALTER TABLE BARS.XML_DOCPAYED MODIFY (REF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005779 ***
begin   
 execute immediate '
  ALTER TABLE BARS.XML_DOCPAYED MODIFY (TT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005788 ***
begin   
 execute immediate '
  ALTER TABLE BARS.XML_DOCPAYED MODIFY (KF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005787 ***
begin   
 execute immediate '
  ALTER TABLE BARS.XML_DOCPAYED MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005786 ***
begin   
 execute immediate '
  ALTER TABLE BARS.XML_DOCPAYED MODIFY (SOS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005785 ***
begin   
 execute immediate '
  ALTER TABLE BARS.XML_DOCPAYED MODIFY (STMT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005784 ***
begin   
 execute immediate '
  ALTER TABLE BARS.XML_DOCPAYED MODIFY (SQ NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005783 ***
begin   
 execute immediate '
  ALTER TABLE BARS.XML_DOCPAYED MODIFY (S NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005782 ***
begin   
 execute immediate '
  ALTER TABLE BARS.XML_DOCPAYED MODIFY (FDAT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005781 ***
begin   
 execute immediate '
  ALTER TABLE BARS.XML_DOCPAYED MODIFY (ACC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005780 ***
begin   
 execute immediate '
  ALTER TABLE BARS.XML_DOCPAYED MODIFY (DK NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  XML_DOCPAYED ***
grant REFERENCES,SELECT                                                      on XML_DOCPAYED    to BARSAQ with grant option;
grant REFERENCES,SELECT                                                      on XML_DOCPAYED    to BARSAQ_ADM with grant option;
grant SELECT                                                                 on XML_DOCPAYED    to BARS_DM;
grant SELECT                                                                 on XML_DOCPAYED    to REFSYNC_USR;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on XML_DOCPAYED    to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/XML_DOCPAYED.sql =========*** End *** 
PROMPT ===================================================================================== 
