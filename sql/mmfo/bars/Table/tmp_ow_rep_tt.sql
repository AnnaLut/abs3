

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_OW_REP_TT.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_OW_REP_TT ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_OW_REP_TT ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_OW_REP_TT 
   (	TT CHAR(3), 
	NAZN VARCHAR2(160)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_OW_REP_TT ***
 exec bpa.alter_policies('TMP_OW_REP_TT');


COMMENT ON TABLE BARS.TMP_OW_REP_TT IS '';
COMMENT ON COLUMN BARS.TMP_OW_REP_TT.TT IS '';
COMMENT ON COLUMN BARS.TMP_OW_REP_TT.NAZN IS '';




PROMPT *** Create  constraint SYS_C00119191 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_OW_REP_TT MODIFY (NAZN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00119190 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_OW_REP_TT MODIFY (TT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_OW_REP_TT.sql =========*** End ***
PROMPT ===================================================================================== 
