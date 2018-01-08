

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ADM_STAFF_ACCESS.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ADM_STAFF_ACCESS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ADM_STAFF_ACCESS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''ADM_STAFF_ACCESS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ADM_STAFF_ACCESS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ADM_STAFF_ACCESS ***
begin 
  execute immediate '
  CREATE TABLE BARS.ADM_STAFF_ACCESS 
   (	TABID NUMBER(38,0), 
	COLID NUMBER(38,0), 
	SEC NUMBER(1,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ADM_STAFF_ACCESS ***
 exec bpa.alter_policies('ADM_STAFF_ACCESS');


COMMENT ON TABLE BARS.ADM_STAFF_ACCESS IS 'Справочник таблиц доп.доступа пользователей';
COMMENT ON COLUMN BARS.ADM_STAFF_ACCESS.TABID IS 'Колонка 'Пользователь'';
COMMENT ON COLUMN BARS.ADM_STAFF_ACCESS.COLID IS 'Код колонки, соответств.коду польз-ля';
COMMENT ON COLUMN BARS.ADM_STAFF_ACCESS.SEC IS 'Признак подтверждения ресурса Безопасностью';




PROMPT *** Create  constraint PK_ADMSTAFFACCESS ***
begin   
 execute immediate '
  ALTER TABLE BARS.ADM_STAFF_ACCESS ADD CONSTRAINT PK_ADMSTAFFACCESS PRIMARY KEY (TABID, COLID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ADMSTAFFACCESS_SEC ***
begin   
 execute immediate '
  ALTER TABLE BARS.ADM_STAFF_ACCESS ADD CONSTRAINT CC_ADMSTAFFACCESS_SEC CHECK (sec in (0,1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ADMSTAFFACCESS_TABID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ADM_STAFF_ACCESS MODIFY (TABID CONSTRAINT CC_ADMSTAFFACCESS_TABID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ADMSTAFFACCESS_COLID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ADM_STAFF_ACCESS MODIFY (COLID CONSTRAINT CC_ADMSTAFFACCESS_COLID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ADMSTAFFACCESS_SEC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ADM_STAFF_ACCESS MODIFY (SEC CONSTRAINT CC_ADMSTAFFACCESS_SEC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ADMSTAFFACCESS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ADMSTAFFACCESS ON BARS.ADM_STAFF_ACCESS (TABID, COLID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ADM_STAFF_ACCESS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on ADM_STAFF_ACCESS to ABS_ADMIN;
grant SELECT                                                                 on ADM_STAFF_ACCESS to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on ADM_STAFF_ACCESS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ADM_STAFF_ACCESS to BARS_DM;
grant SELECT                                                                 on ADM_STAFF_ACCESS to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on ADM_STAFF_ACCESS to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on ADM_STAFF_ACCESS to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ADM_STAFF_ACCESS.sql =========*** End 
PROMPT ===================================================================================== 
