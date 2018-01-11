

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/S6_MailNLS.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to S6_MailNLS ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table S6_MailNLS ***
begin 
  execute immediate '
  CREATE TABLE BARS.S6_MailNLS 
   (	ABON CHAR(10), 
	NLS VARCHAR2(25), 
	KSS CHAR(1), 
	GROUP_U NUMBER(10,0), 
	I_VA NUMBER(5,0), 
	OKPO VARCHAR2(14), 
	NAME VARCHAR2(38), 
	VISIBLE NUMBER(3,0), 
	FLAGS VARCHAR2(20), 
	ISP NUMBER(5,0), 
	DEPART NUMBER(5,0), 
	ISP_OWNER NUMBER(5,0), 
	Limit NUMBER(16,2)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to S6_MailNLS ***
 exec bpa.alter_policies('S6_MailNLS');


COMMENT ON TABLE BARS.S6_MailNLS IS '';
COMMENT ON COLUMN BARS.S6_MailNLS.ABON IS '';
COMMENT ON COLUMN BARS.S6_MailNLS.NLS IS '';
COMMENT ON COLUMN BARS.S6_MailNLS.KSS IS '';
COMMENT ON COLUMN BARS.S6_MailNLS.GROUP_U IS '';
COMMENT ON COLUMN BARS.S6_MailNLS.I_VA IS '';
COMMENT ON COLUMN BARS.S6_MailNLS.OKPO IS '';
COMMENT ON COLUMN BARS.S6_MailNLS.NAME IS '';
COMMENT ON COLUMN BARS.S6_MailNLS.VISIBLE IS '';
COMMENT ON COLUMN BARS.S6_MailNLS.FLAGS IS '';
COMMENT ON COLUMN BARS.S6_MailNLS.ISP IS '';
COMMENT ON COLUMN BARS.S6_MailNLS.DEPART IS '';
COMMENT ON COLUMN BARS.S6_MailNLS.ISP_OWNER IS '';
COMMENT ON COLUMN BARS.S6_MailNLS.Limit IS '';




PROMPT *** Create  constraint SYS_C009316 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_MailNLS MODIFY (ABON NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009317 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_MailNLS MODIFY (NLS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009318 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_MailNLS MODIFY (GROUP_U NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009319 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_MailNLS MODIFY (I_VA NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009320 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_MailNLS MODIFY (OKPO NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009321 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_MailNLS MODIFY (NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009322 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_MailNLS MODIFY (VISIBLE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  S6_MailNLS ***
grant SELECT                                                                 on S6_MailNLS      to BARSREADER_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/S6_MailNLS.sql =========*** End *** ==
PROMPT ===================================================================================== 
