

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/S6_CREDIT_NLS1.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to S6_CREDIT_NLS1 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table S6_CREDIT_NLS1 ***
begin 
  execute immediate '
  CREATE TABLE BARS.S6_CREDIT_NLS1 
   (	BIC NUMBER(10,0), 
	IDCONTRACT VARCHAR2(40), 
	NLS VARCHAR2(25), 
	KSS CHAR(1), 
	TYPE NUMBER(3,0), 
	NLS_N NUMBER(16,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to S6_CREDIT_NLS1 ***
 exec bpa.alter_policies('S6_CREDIT_NLS1');


COMMENT ON TABLE BARS.S6_CREDIT_NLS1 IS '';
COMMENT ON COLUMN BARS.S6_CREDIT_NLS1.BIC IS '';
COMMENT ON COLUMN BARS.S6_CREDIT_NLS1.IDCONTRACT IS '';
COMMENT ON COLUMN BARS.S6_CREDIT_NLS1.NLS IS '';
COMMENT ON COLUMN BARS.S6_CREDIT_NLS1.KSS IS '';
COMMENT ON COLUMN BARS.S6_CREDIT_NLS1.TYPE IS '';
COMMENT ON COLUMN BARS.S6_CREDIT_NLS1.NLS_N IS '';




PROMPT *** Create  constraint SYS_C0020243 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_CREDIT_NLS1 MODIFY (NLS_N NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0020242 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_CREDIT_NLS1 MODIFY (TYPE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0020241 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_CREDIT_NLS1 MODIFY (IDCONTRACT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0020240 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_CREDIT_NLS1 MODIFY (BIC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/S6_CREDIT_NLS1.sql =========*** End **
PROMPT ===================================================================================== 
