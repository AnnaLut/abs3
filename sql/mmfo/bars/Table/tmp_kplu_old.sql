

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_KPLU_OLD.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_KPLU_OLD ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_KPLU_OLD ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_KPLU_OLD 
   (	NBW VARCHAR2(38), 
	MFO VARCHAR2(12), 
	SAB CHAR(4), 
	OP CHAR(1), 
	OTM CHAR(1), 
	KF VARCHAR2(6)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_KPLU_OLD ***
 exec bpa.alter_policies('TMP_KPLU_OLD');


COMMENT ON TABLE BARS.TMP_KPLU_OLD IS '';
COMMENT ON COLUMN BARS.TMP_KPLU_OLD.NBW IS '';
COMMENT ON COLUMN BARS.TMP_KPLU_OLD.MFO IS '';
COMMENT ON COLUMN BARS.TMP_KPLU_OLD.SAB IS '';
COMMENT ON COLUMN BARS.TMP_KPLU_OLD.OP IS '';
COMMENT ON COLUMN BARS.TMP_KPLU_OLD.OTM IS '';
COMMENT ON COLUMN BARS.TMP_KPLU_OLD.KF IS '';




PROMPT *** Create  constraint SYS_C006777 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_KPLU_OLD MODIFY (NBW NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006778 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_KPLU_OLD MODIFY (MFO NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006779 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_KPLU_OLD MODIFY (SAB NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006780 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_KPLU_OLD MODIFY (OP NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006781 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_KPLU_OLD MODIFY (KF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_KPLU_OLD ***
grant SELECT                                                                 on TMP_KPLU_OLD    to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_KPLU_OLD.sql =========*** End *** 
PROMPT ===================================================================================== 
