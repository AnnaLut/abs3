

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/WCS_SYNC_DATASTORES.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to WCS_SYNC_DATASTORES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''WCS_SYNC_DATASTORES'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_SYNC_DATASTORES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_SYNC_DATASTORES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table WCS_SYNC_DATASTORES ***
begin 
  execute immediate '
  CREATE TABLE BARS.WCS_SYNC_DATASTORES 
   (	ID VARCHAR2(6), 
	NAME VARCHAR2(300), 
	ACTIVE NUMBER(1,0) DEFAULT 0, 
	DBLINK VARCHAR2(30)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to WCS_SYNC_DATASTORES ***
 exec bpa.alter_policies('WCS_SYNC_DATASTORES');


COMMENT ON TABLE BARS.WCS_SYNC_DATASTORES IS 'Источники данных для синхронизации';
COMMENT ON COLUMN BARS.WCS_SYNC_DATASTORES.ID IS 'Наименование';
COMMENT ON COLUMN BARS.WCS_SYNC_DATASTORES.NAME IS '';
COMMENT ON COLUMN BARS.WCS_SYNC_DATASTORES.ACTIVE IS 'Флаг активности';
COMMENT ON COLUMN BARS.WCS_SYNC_DATASTORES.DBLINK IS 'Имя DBLink';




PROMPT *** Create  constraint PK_WCSSYNCDSS ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SYNC_DATASTORES ADD CONSTRAINT PK_WCSSYNCDSS PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_WCSSYNCDSS_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SYNC_DATASTORES MODIFY (NAME CONSTRAINT CC_WCSSYNCDSS_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_WCSSYNCDSS_ACTIVE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SYNC_DATASTORES MODIFY (ACTIVE CONSTRAINT CC_WCSSYNCDSS_ACTIVE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_WCSSYNCDSS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_WCSSYNCDSS ON BARS.WCS_SYNC_DATASTORES (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  WCS_SYNC_DATASTORES ***
grant SELECT                                                                 on WCS_SYNC_DATASTORES to BARS_DM;
grant SELECT                                                                 on WCS_SYNC_DATASTORES to WCS_SYNC_USER;



PROMPT *** Create SYNONYM  to WCS_SYNC_DATASTORES ***

  CREATE OR REPLACE PUBLIC SYNONYM WCS_SYNC_DATASTORES FOR BARS.WCS_SYNC_DATASTORES;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/WCS_SYNC_DATASTORES.sql =========*** E
PROMPT ===================================================================================== 
