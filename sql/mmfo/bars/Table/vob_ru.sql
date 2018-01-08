

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/VOB_RU.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to VOB_RU ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table VOB_RU ***
begin 
  execute immediate '
  CREATE TABLE BARS.VOB_RU 
   (	VOB NUMBER(38,0), 
	NAME VARCHAR2(35), 
	FLV NUMBER(1,0), 
	REP_PREFIX VARCHAR2(8), 
	OVRD4IPMT VARCHAR2(1), 
	KDOC CHAR(2), 
	REP_PREFIX_FR VARCHAR2(11), 
	KOD CHAR(2)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to VOB_RU ***
 exec bpa.alter_policies('VOB_RU');


COMMENT ON TABLE BARS.VOB_RU IS '';
COMMENT ON COLUMN BARS.VOB_RU.VOB IS '';
COMMENT ON COLUMN BARS.VOB_RU.NAME IS '';
COMMENT ON COLUMN BARS.VOB_RU.FLV IS '';
COMMENT ON COLUMN BARS.VOB_RU.REP_PREFIX IS '';
COMMENT ON COLUMN BARS.VOB_RU.OVRD4IPMT IS '';
COMMENT ON COLUMN BARS.VOB_RU.KDOC IS '';
COMMENT ON COLUMN BARS.VOB_RU.REP_PREFIX_FR IS '';
COMMENT ON COLUMN BARS.VOB_RU.KOD IS '';




PROMPT *** Create  constraint SYS_C009620 ***
begin   
 execute immediate '
  ALTER TABLE BARS.VOB_RU MODIFY (VOB NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009621 ***
begin   
 execute immediate '
  ALTER TABLE BARS.VOB_RU MODIFY (NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009622 ***
begin   
 execute immediate '
  ALTER TABLE BARS.VOB_RU MODIFY (FLV NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  VOB_RU ***
grant SELECT                                                                 on VOB_RU          to BARSREADER_ROLE;
grant SELECT                                                                 on VOB_RU          to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/VOB_RU.sql =========*** End *** ======
PROMPT ===================================================================================== 
