

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SKRYNKA_SYNC_TYPE.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SKRYNKA_SYNC_TYPE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SKRYNKA_SYNC_TYPE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SKRYNKA_SYNC_TYPE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SKRYNKA_SYNC_TYPE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SKRYNKA_SYNC_TYPE ***
begin 
  execute immediate '
  CREATE TABLE BARS.SKRYNKA_SYNC_TYPE 
   (	TYPE VARCHAR2(3 CHAR), 
	DESCRIPTION VARCHAR2(30 CHAR)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SKRYNKA_SYNC_TYPE ***
 exec bpa.alter_policies('SKRYNKA_SYNC_TYPE');


COMMENT ON TABLE BARS.SKRYNKA_SYNC_TYPE IS 'Довідник видів повідомлень на синхронізацію';
COMMENT ON COLUMN BARS.SKRYNKA_SYNC_TYPE.TYPE IS 'тип повідомлення на синхронізацію';
COMMENT ON COLUMN BARS.SKRYNKA_SYNC_TYPE.DESCRIPTION IS 'опис повідомлення на синхронізацію';




PROMPT *** Create  constraint PK_SKRYNKA_SYNC_TYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_SYNC_TYPE ADD CONSTRAINT PK_SKRYNKA_SYNC_TYPE PRIMARY KEY (TYPE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010112 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_SYNC_TYPE MODIFY (TYPE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010113 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_SYNC_TYPE MODIFY (DESCRIPTION NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SKRYNKA_SYNC_TYPE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SKRYNKA_SYNC_TYPE ON BARS.SKRYNKA_SYNC_TYPE (TYPE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SKRYNKA_SYNC_TYPE ***
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on SKRYNKA_SYNC_TYPE to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SKRYNKA_SYNC_TYPE.sql =========*** End
PROMPT ===================================================================================== 
