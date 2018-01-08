

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CHKLIST.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CHKLIST ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CHKLIST'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CHKLIST'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CHKLIST'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CHKLIST ***
begin 
  execute immediate '
  CREATE TABLE BARS.CHKLIST 
   (	IDCHK NUMBER(*,0), 
	NAME VARCHAR2(35), 
	COMM VARCHAR2(35), 
	F_IN_CHARGE NUMBER(*,0) DEFAULT 1, 
	IDCHK_HEX VARCHAR2(2)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CHKLIST ***
 exec bpa.alter_policies('CHKLIST');


COMMENT ON TABLE BARS.CHKLIST IS 'Группы контроля';
COMMENT ON COLUMN BARS.CHKLIST.IDCHK IS 'Идентификатор Контролера';
COMMENT ON COLUMN BARS.CHKLIST.NAME IS 'Наименование Контролера';
COMMENT ON COLUMN BARS.CHKLIST.COMM IS 'Комментарий';
COMMENT ON COLUMN BARS.CHKLIST.F_IN_CHARGE IS 'Вид ЭЦП на визе: 0-Отсут, 1-Внутр, 2-СЭП, 3-Внутр+СЭП';
COMMENT ON COLUMN BARS.CHKLIST.IDCHK_HEX IS 'Код группы в hex';




PROMPT *** Create  constraint UK_CHKLIST ***
begin   
 execute immediate '
  ALTER TABLE BARS.CHKLIST ADD CONSTRAINT UK_CHKLIST UNIQUE (IDCHK_HEX)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_CHKLIST ***
begin   
 execute immediate '
  ALTER TABLE BARS.CHKLIST ADD CONSTRAINT PK_CHKLIST PRIMARY KEY (IDCHK)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008396 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CHKLIST MODIFY (IDCHK NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CHKLIST_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CHKLIST MODIFY (NAME CONSTRAINT CC_CHKLIST_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CHKLIST_INCHARGE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CHKLIST MODIFY (F_IN_CHARGE CONSTRAINT CC_CHKLIST_INCHARGE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CHKLIST_IDCHKHEX ***
begin   
 execute immediate '
  ALTER TABLE BARS.CHKLIST MODIFY (IDCHK_HEX CONSTRAINT CC_CHKLIST_IDCHKHEX NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CHKLIST ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CHKLIST ON BARS.CHKLIST (IDCHK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_CHKLIST ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_CHKLIST ON BARS.CHKLIST (IDCHK_HEX) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CHKLIST ***
grant DELETE,INSERT,SELECT,UPDATE                                            on CHKLIST         to ABS_ADMIN;
grant SELECT                                                                 on CHKLIST         to BARSREADER_ROLE;
grant SELECT                                                                 on CHKLIST         to BARSUPL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CHKLIST         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CHKLIST         to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CHKLIST         to CHKLIST;
grant SELECT                                                                 on CHKLIST         to START1;
grant SELECT                                                                 on CHKLIST         to TECH005;
grant SELECT                                                                 on CHKLIST         to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CHKLIST         to WR_ALL_RIGHTS;
grant SELECT                                                                 on CHKLIST         to WR_CHCKINNR_SELF;
grant FLASHBACK,SELECT                                                       on CHKLIST         to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CHKLIST.sql =========*** End *** =====
PROMPT ===================================================================================== 
