

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_SWI_OPER_LIST.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_SWI_OPER_LIST ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_SWI_OPER_LIST ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_SWI_OPER_LIST 
   (	OPER_ID NUMBER(2,0), 
	TT CHAR(3), 
	DESCRIPTION VARCHAR2(256), 
	NAZN_TEMPLATE VARCHAR2(160), 
	TT_980 CHAR(3), 
	TT_PA CHAR(3)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_SWI_OPER_LIST ***
 exec bpa.alter_policies('TMP_SWI_OPER_LIST');


COMMENT ON TABLE BARS.TMP_SWI_OPER_LIST IS '';
COMMENT ON COLUMN BARS.TMP_SWI_OPER_LIST.OPER_ID IS '';
COMMENT ON COLUMN BARS.TMP_SWI_OPER_LIST.TT IS '';
COMMENT ON COLUMN BARS.TMP_SWI_OPER_LIST.DESCRIPTION IS '';
COMMENT ON COLUMN BARS.TMP_SWI_OPER_LIST.NAZN_TEMPLATE IS '';
COMMENT ON COLUMN BARS.TMP_SWI_OPER_LIST.TT_980 IS '';
COMMENT ON COLUMN BARS.TMP_SWI_OPER_LIST.TT_PA IS '';




PROMPT *** Create  constraint SYS_C00119148 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_SWI_OPER_LIST MODIFY (OPER_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00119151 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_SWI_OPER_LIST MODIFY (NAZN_TEMPLATE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00119150 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_SWI_OPER_LIST MODIFY (DESCRIPTION NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00119149 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_SWI_OPER_LIST MODIFY (TT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_SWI_OPER_LIST.sql =========*** End
PROMPT ===================================================================================== 
