

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/S6_Credit_NLS.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to S6_Credit_NLS ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table S6_Credit_NLS ***
begin 
  execute immediate '
  CREATE TABLE BARS.S6_Credit_NLS 
   (	BIC NUMBER(10,0), 
	IdContract VARCHAR2(40), 
	NLS VARCHAR2(25), 
	KSS CHAR(1), 
	Type NUMBER(3,0), 
	NLS_N NUMBER(16,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to S6_Credit_NLS ***
 exec bpa.alter_policies('S6_Credit_NLS');


COMMENT ON TABLE BARS.S6_Credit_NLS IS '';
COMMENT ON COLUMN BARS.S6_Credit_NLS.BIC IS '';
COMMENT ON COLUMN BARS.S6_Credit_NLS.IdContract IS '';
COMMENT ON COLUMN BARS.S6_Credit_NLS.NLS IS '';
COMMENT ON COLUMN BARS.S6_Credit_NLS.KSS IS '';
COMMENT ON COLUMN BARS.S6_Credit_NLS.Type IS '';
COMMENT ON COLUMN BARS.S6_Credit_NLS.NLS_N IS '';




PROMPT *** Create  constraint SYS_C009787 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_Credit_NLS MODIFY (BIC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009788 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_Credit_NLS MODIFY (IdContract NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009789 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_Credit_NLS MODIFY (Type NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009790 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_Credit_NLS MODIFY (NLS_N NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  S6_Credit_NLS ***
grant SELECT                                                                 on S6_Credit_NLS   to BARSREADER_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/S6_Credit_NLS.sql =========*** End ***
PROMPT ===================================================================================== 
