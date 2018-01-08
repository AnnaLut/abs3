

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/VOB_BARSDB.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to VOB_BARSDB ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table VOB_BARSDB ***
begin 
  execute immediate '
  CREATE TABLE BARS.VOB_BARSDB 
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




PROMPT *** ALTER_POLICIES to VOB_BARSDB ***
 exec bpa.alter_policies('VOB_BARSDB');


COMMENT ON TABLE BARS.VOB_BARSDB IS '';
COMMENT ON COLUMN BARS.VOB_BARSDB.VOB IS '';
COMMENT ON COLUMN BARS.VOB_BARSDB.NAME IS '';
COMMENT ON COLUMN BARS.VOB_BARSDB.FLV IS '';
COMMENT ON COLUMN BARS.VOB_BARSDB.REP_PREFIX IS '';
COMMENT ON COLUMN BARS.VOB_BARSDB.OVRD4IPMT IS '';
COMMENT ON COLUMN BARS.VOB_BARSDB.KDOC IS '';
COMMENT ON COLUMN BARS.VOB_BARSDB.REP_PREFIX_FR IS '';
COMMENT ON COLUMN BARS.VOB_BARSDB.KOD IS '';




PROMPT *** Create  constraint SYS_C005730 ***
begin   
 execute immediate '
  ALTER TABLE BARS.VOB_BARSDB MODIFY (VOB NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005731 ***
begin   
 execute immediate '
  ALTER TABLE BARS.VOB_BARSDB MODIFY (NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005732 ***
begin   
 execute immediate '
  ALTER TABLE BARS.VOB_BARSDB MODIFY (FLV NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  VOB_BARSDB ***
grant SELECT                                                                 on VOB_BARSDB      to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/VOB_BARSDB.sql =========*** End *** ==
PROMPT ===================================================================================== 
