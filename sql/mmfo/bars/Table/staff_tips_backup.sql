

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/STAFF_TIPS_BACKUP.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to STAFF_TIPS_BACKUP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''STAFF_TIPS_BACKUP'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''STAFF_TIPS_BACKUP'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''STAFF_TIPS_BACKUP'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table STAFF_TIPS_BACKUP ***
begin 
  execute immediate '
  CREATE TABLE BARS.STAFF_TIPS_BACKUP 
   (	ID NUMBER(22,0), 
	NAME VARCHAR2(100)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to STAFF_TIPS_BACKUP ***
 exec bpa.alter_policies('STAFF_TIPS_BACKUP');


COMMENT ON TABLE BARS.STAFF_TIPS_BACKUP IS '';
COMMENT ON COLUMN BARS.STAFF_TIPS_BACKUP.ID IS '';
COMMENT ON COLUMN BARS.STAFF_TIPS_BACKUP.NAME IS '';




PROMPT *** Create  constraint SYS_C004811 ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF_TIPS_BACKUP MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  STAFF_TIPS_BACKUP ***
grant SELECT                                                                 on STAFF_TIPS_BACKUP to BARSREADER_ROLE;
grant SELECT                                                                 on STAFF_TIPS_BACKUP to BARS_DM;
grant SELECT                                                                 on STAFF_TIPS_BACKUP to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/STAFF_TIPS_BACKUP.sql =========*** End
PROMPT ===================================================================================== 
