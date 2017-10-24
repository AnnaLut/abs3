

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SKRYNKA_SYNC_QUEUE.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SKRYNKA_SYNC_QUEUE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SKRYNKA_SYNC_QUEUE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SKRYNKA_SYNC_QUEUE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SKRYNKA_SYNC_QUEUE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SKRYNKA_SYNC_QUEUE ***
begin 
  execute immediate '
  CREATE TABLE BARS.SKRYNKA_SYNC_QUEUE 
   (	ID NUMBER, 
	SYNC_TYPE VARCHAR2(3), 
	OBJ_ID NUMBER, 
	MSG_STATUS VARCHAR2(25), 
	MSG_TIME DATE, 
	ERR_TEXT VARCHAR2(2000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SKRYNKA_SYNC_QUEUE ***
 exec bpa.alter_policies('SKRYNKA_SYNC_QUEUE');


COMMENT ON TABLE BARS.SKRYNKA_SYNC_QUEUE IS 'Черга повідомлень на синхронізацію';
COMMENT ON COLUMN BARS.SKRYNKA_SYNC_QUEUE.ID IS '';
COMMENT ON COLUMN BARS.SKRYNKA_SYNC_QUEUE.SYNC_TYPE IS '';
COMMENT ON COLUMN BARS.SKRYNKA_SYNC_QUEUE.OBJ_ID IS '';
COMMENT ON COLUMN BARS.SKRYNKA_SYNC_QUEUE.MSG_STATUS IS '';
COMMENT ON COLUMN BARS.SKRYNKA_SYNC_QUEUE.MSG_TIME IS '';
COMMENT ON COLUMN BARS.SKRYNKA_SYNC_QUEUE.ERR_TEXT IS '';




PROMPT *** Create  constraint FK_BR_SKRYN_SYNC_QUEUE_TYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_SYNC_QUEUE ADD CONSTRAINT FK_BR_SKRYN_SYNC_QUEUE_TYPE FOREIGN KEY (SYNC_TYPE)
	  REFERENCES BARS.SKRYNKA_SYNC_TYPE (TYPE) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SKRYNKA_SYNC_QUEUE ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_SYNC_QUEUE ADD CONSTRAINT SKRYNKA_SYNC_QUEUE PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010148 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_SYNC_QUEUE MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010149 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_SYNC_QUEUE MODIFY (SYNC_TYPE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010150 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_SYNC_QUEUE MODIFY (OBJ_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010151 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_SYNC_QUEUE MODIFY (MSG_STATUS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010152 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_SYNC_QUEUE MODIFY (MSG_TIME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index SKRYNKA_SYNC_QUEUE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.SKRYNKA_SYNC_QUEUE ON BARS.SKRYNKA_SYNC_QUEUE (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SKRYNKA_SYNC_QUEUE ***
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on SKRYNKA_SYNC_QUEUE to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SKRYNKA_SYNC_QUEUE.sql =========*** En
PROMPT ===================================================================================== 
