

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ESCR_BUILD_TYPES.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ESCR_BUILD_TYPES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ESCR_BUILD_TYPES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ESCR_BUILD_TYPES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ESCR_BUILD_TYPES ***
declare 
  v_num number;
begin
  select count(1)
    into v_num
    from user_tables 
    where table_name = 'ESCR_BUILD_TYPES';
  if v_num = 0 then
    execute immediate 'CREATE TABLE BARS.ESCR_BUILD_TYPES ("ID" NUMBER NOT NULL ENABLE NOVALIDATE, "TYPE" VARCHAR2(16) NOT NULL ENABLE NOVALIDATE, 
	"STATE" integer DEFAULT 1, 
	"REASON" VARCHAR2(1000)
        )';
  end if;
  select count(1) into v_num
    from user_tab_columns
    where table_name = 'ESCR_BUILD_TYPES'
      and column_name = 'STATE';
  if v_num = 0 then
    execute immediate 'alter table ESCR_BUILD_TYPES add state integer default 1';
    execute immediate 'alter table ESCR_BUILD_TYPES add reason varchar2(1000)';
  end if;
end;
/
 

update ESCR_BUILD_TYPES
  set state = 0
  where id = 3;
commit;




PROMPT *** ALTER_POLICIES to ESCR_BUILD_TYPES ***
 exec bpa.alter_policies('ESCR_BUILD_TYPES');


COMMENT ON TABLE BARS.ESCR_BUILD_TYPES IS '’ипи будинкґв';
COMMENT ON COLUMN BARS.ESCR_BUILD_TYPES.STATE IS 'Поточний статус запису (1 - активний, 0- неактивний)';
COMMENT ON COLUMN BARS.ESCR_BUILD_TYPES.REASON IS 'Причина блокування запису';
COMMENT ON COLUMN BARS.ESCR_BUILD_TYPES.ID IS '';
COMMENT ON COLUMN BARS.ESCR_BUILD_TYPES.TYPE IS '';




PROMPT *** Create  constraint PK_BUILD_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.ESCR_BUILD_TYPES ADD CONSTRAINT PK_BUILD_ID PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0018775 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ESCR_BUILD_TYPES MODIFY (ID NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0018776 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ESCR_BUILD_TYPES MODIFY (TYPE NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_BUILD_ID ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_BUILD_ID ON BARS.ESCR_BUILD_TYPES (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ESCR_BUILD_TYPES ***
grant SELECT                                                                 on ESCR_BUILD_TYPES to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on ESCR_BUILD_TYPES to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ESCR_BUILD_TYPES to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ESCR_BUILD_TYPES.sql =========*** End 
PROMPT ===================================================================================== 
 