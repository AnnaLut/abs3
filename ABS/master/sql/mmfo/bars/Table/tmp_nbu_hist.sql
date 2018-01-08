

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_NBU_HIST.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_NBU_HIST ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_NBU_HIST ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_NBU_HIST 
   (	KODP VARCHAR2(100), 
	DATF DATE, 
	KODF CHAR(2), 
	ZNAP VARCHAR2(170), 
	KF VARCHAR2(6), 
	WS_US VARCHAR2(20), 
	DATCH DATE, 
	MDF VARCHAR2(20)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_NBU_HIST ***
 exec bpa.alter_policies('TMP_NBU_HIST');


COMMENT ON TABLE BARS.TMP_NBU_HIST IS '';
COMMENT ON COLUMN BARS.TMP_NBU_HIST.KODP IS '';
COMMENT ON COLUMN BARS.TMP_NBU_HIST.DATF IS '';
COMMENT ON COLUMN BARS.TMP_NBU_HIST.KODF IS '';
COMMENT ON COLUMN BARS.TMP_NBU_HIST.ZNAP IS '';
COMMENT ON COLUMN BARS.TMP_NBU_HIST.KF IS '';
COMMENT ON COLUMN BARS.TMP_NBU_HIST.WS_US IS '';
COMMENT ON COLUMN BARS.TMP_NBU_HIST.DATCH IS '';
COMMENT ON COLUMN BARS.TMP_NBU_HIST.MDF IS '';




PROMPT *** Create  constraint SYS_C006210 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_NBU_HIST MODIFY (KODP NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006211 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_NBU_HIST MODIFY (DATF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006212 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_NBU_HIST MODIFY (KODF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006213 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_NBU_HIST MODIFY (KF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_NBU_HIST ***
grant SELECT                                                                 on TMP_NBU_HIST    to BARSREADER_ROLE;
grant FLASHBACK,SELECT                                                       on TMP_NBU_HIST    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_NBU_HIST    to BARS_DM;
grant SELECT                                                                 on TMP_NBU_HIST    to UPLD;
grant FLASHBACK,SELECT                                                       on TMP_NBU_HIST    to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_NBU_HIST.sql =========*** End *** 
PROMPT ===================================================================================== 
