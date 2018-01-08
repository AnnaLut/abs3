

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_BACKUP_CHKLIST.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_BACKUP_CHKLIST ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_BACKUP_CHKLIST ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_BACKUP_CHKLIST 
   (	IDCHK NUMBER(*,0), 
	F_IN_CHARGE NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_BACKUP_CHKLIST ***
 exec bpa.alter_policies('TMP_BACKUP_CHKLIST');


COMMENT ON TABLE BARS.TMP_BACKUP_CHKLIST IS '';
COMMENT ON COLUMN BARS.TMP_BACKUP_CHKLIST.IDCHK IS '';
COMMENT ON COLUMN BARS.TMP_BACKUP_CHKLIST.F_IN_CHARGE IS '';




PROMPT *** Create  constraint SYS_C0048354 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_BACKUP_CHKLIST MODIFY (F_IN_CHARGE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0048353 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_BACKUP_CHKLIST MODIFY (IDCHK NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_BACKUP_CHKLIST.sql =========*** En
PROMPT ===================================================================================== 
