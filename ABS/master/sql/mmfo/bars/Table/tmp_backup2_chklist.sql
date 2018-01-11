

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_BACKUP2_CHKLIST.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_BACKUP2_CHKLIST ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_BACKUP2_CHKLIST ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_BACKUP2_CHKLIST 
   (	IDCHK NUMBER(*,0), 
	NAME VARCHAR2(35), 
	COMM VARCHAR2(35), 
	F_IN_CHARGE NUMBER(*,0), 
	IDCHK_HEX VARCHAR2(2)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_BACKUP2_CHKLIST ***
 exec bpa.alter_policies('TMP_BACKUP2_CHKLIST');


COMMENT ON TABLE BARS.TMP_BACKUP2_CHKLIST IS '';
COMMENT ON COLUMN BARS.TMP_BACKUP2_CHKLIST.IDCHK IS '';
COMMENT ON COLUMN BARS.TMP_BACKUP2_CHKLIST.NAME IS '';
COMMENT ON COLUMN BARS.TMP_BACKUP2_CHKLIST.COMM IS '';
COMMENT ON COLUMN BARS.TMP_BACKUP2_CHKLIST.F_IN_CHARGE IS '';
COMMENT ON COLUMN BARS.TMP_BACKUP2_CHKLIST.IDCHK_HEX IS '';




PROMPT *** Create  constraint SYS_C0048364 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_BACKUP2_CHKLIST MODIFY (IDCHK NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0048365 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_BACKUP2_CHKLIST MODIFY (NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0048366 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_BACKUP2_CHKLIST MODIFY (F_IN_CHARGE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0048367 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_BACKUP2_CHKLIST MODIFY (IDCHK_HEX NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_BACKUP2_CHKLIST ***
grant SELECT                                                                 on TMP_BACKUP2_CHKLIST to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_BACKUP2_CHKLIST to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_BACKUP2_CHKLIST.sql =========*** E
PROMPT ===================================================================================== 
