

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CASH_LASTVISA_26102009.sql =========**
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CASH_LASTVISA_26102009 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CASH_LASTVISA_26102009 ***
begin 
  execute immediate '
  CREATE TABLE BARS.CASH_LASTVISA_26102009 
   (	KF VARCHAR2(6), 
	REF NUMBER, 
	DAT DATE, 
	USERID NUMBER, 
	BRANCH VARCHAR2(30)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CASH_LASTVISA_26102009 ***
 exec bpa.alter_policies('CASH_LASTVISA_26102009');


COMMENT ON TABLE BARS.CASH_LASTVISA_26102009 IS '';
COMMENT ON COLUMN BARS.CASH_LASTVISA_26102009.KF IS '';
COMMENT ON COLUMN BARS.CASH_LASTVISA_26102009.REF IS '';
COMMENT ON COLUMN BARS.CASH_LASTVISA_26102009.DAT IS '';
COMMENT ON COLUMN BARS.CASH_LASTVISA_26102009.USERID IS '';
COMMENT ON COLUMN BARS.CASH_LASTVISA_26102009.BRANCH IS '';




PROMPT *** Create  constraint SYS_C0098070 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CASH_LASTVISA_26102009 MODIFY (BRANCH NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CASH_LASTVISA_26102009.sql =========**
PROMPT ===================================================================================== 
