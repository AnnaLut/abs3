

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_REZ_PROTOCOL.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_REZ_PROTOCOL ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_REZ_PROTOCOL ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_REZ_PROTOCOL 
   (	USERID NUMBER, 
	DAT DATE, 
	BRANCH VARCHAR2(30), 
	DAT_BANK DATE, 
	DAT_SYS DATE, 
	DAT_OTCN DATE, 
	CRC VARCHAR2(64)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_REZ_PROTOCOL ***
 exec bpa.alter_policies('TMP_REZ_PROTOCOL');


COMMENT ON TABLE BARS.TMP_REZ_PROTOCOL IS '';
COMMENT ON COLUMN BARS.TMP_REZ_PROTOCOL.USERID IS '';
COMMENT ON COLUMN BARS.TMP_REZ_PROTOCOL.DAT IS '';
COMMENT ON COLUMN BARS.TMP_REZ_PROTOCOL.BRANCH IS '';
COMMENT ON COLUMN BARS.TMP_REZ_PROTOCOL.DAT_BANK IS '';
COMMENT ON COLUMN BARS.TMP_REZ_PROTOCOL.DAT_SYS IS '';
COMMENT ON COLUMN BARS.TMP_REZ_PROTOCOL.DAT_OTCN IS '';
COMMENT ON COLUMN BARS.TMP_REZ_PROTOCOL.CRC IS '';




PROMPT *** Create  constraint SYS_C008830 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_REZ_PROTOCOL MODIFY (BRANCH NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_REZ_PROTOCOL ***
grant SELECT                                                                 on TMP_REZ_PROTOCOL to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_REZ_PROTOCOL.sql =========*** End 
PROMPT ===================================================================================== 
