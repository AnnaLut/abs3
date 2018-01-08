

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/GRT_DEAL_STATUSES_HIST.sql =========**
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to GRT_DEAL_STATUSES_HIST ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''GRT_DEAL_STATUSES_HIST'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''GRT_DEAL_STATUSES_HIST'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''GRT_DEAL_STATUSES_HIST'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table GRT_DEAL_STATUSES_HIST ***
begin 
  execute immediate '
  CREATE TABLE BARS.GRT_DEAL_STATUSES_HIST 
   (	CHANGE_DATE TIMESTAMP (6) DEFAULT current_timestamp, 
	DEAL_ID NUMBER(38,0), 
	STATUS_ID NUMBER(3,0), 
	STAFF_ID NUMBER(38,0)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to GRT_DEAL_STATUSES_HIST ***
 exec bpa.alter_policies('GRT_DEAL_STATUSES_HIST');


COMMENT ON TABLE BARS.GRT_DEAL_STATUSES_HIST IS 'Історія зміни статусів договорів';
COMMENT ON COLUMN BARS.GRT_DEAL_STATUSES_HIST.CHANGE_DATE IS 'Дата зміни';
COMMENT ON COLUMN BARS.GRT_DEAL_STATUSES_HIST.DEAL_ID IS '';
COMMENT ON COLUMN BARS.GRT_DEAL_STATUSES_HIST.STATUS_ID IS 'Статус';
COMMENT ON COLUMN BARS.GRT_DEAL_STATUSES_HIST.STAFF_ID IS 'Користувач';




PROMPT *** Create  constraint CC_GRTDLSTATHIST_DEALID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.GRT_DEAL_STATUSES_HIST MODIFY (DEAL_ID CONSTRAINT CC_GRTDLSTATHIST_DEALID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_GRTDLSTATHIST_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.GRT_DEAL_STATUSES_HIST MODIFY (STATUS_ID CONSTRAINT CC_GRTDLSTATHIST_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_GRTDLSTATHIST_STAFFID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.GRT_DEAL_STATUSES_HIST MODIFY (STAFF_ID CONSTRAINT CC_GRTDLSTATHIST_STAFFID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_GRTDLSTATHIST ***
begin   
 execute immediate '
  ALTER TABLE BARS.GRT_DEAL_STATUSES_HIST ADD CONSTRAINT PK_GRTDLSTATHIST PRIMARY KEY (CHANGE_DATE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_GRTDLSTATHIST ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_GRTDLSTATHIST ON BARS.GRT_DEAL_STATUSES_HIST (CHANGE_DATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  GRT_DEAL_STATUSES_HIST ***
grant SELECT                                                                 on GRT_DEAL_STATUSES_HIST to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on GRT_DEAL_STATUSES_HIST to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on GRT_DEAL_STATUSES_HIST to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on GRT_DEAL_STATUSES_HIST to START1;
grant SELECT                                                                 on GRT_DEAL_STATUSES_HIST to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/GRT_DEAL_STATUSES_HIST.sql =========**
PROMPT ===================================================================================== 
