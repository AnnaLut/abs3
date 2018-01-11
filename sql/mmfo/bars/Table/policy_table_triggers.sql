

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/POLICY_TABLE_TRIGGERS.sql =========***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to POLICY_TABLE_TRIGGERS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''POLICY_TABLE_TRIGGERS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''POLICY_TABLE_TRIGGERS'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''POLICY_TABLE_TRIGGERS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table POLICY_TABLE_TRIGGERS ***
begin 
  execute immediate '
  CREATE TABLE BARS.POLICY_TABLE_TRIGGERS 
   (	OWNER VARCHAR2(30), 
	TABLE_NAME VARCHAR2(30), 
	TRIGGERS VARCHAR2(256)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to POLICY_TABLE_TRIGGERS ***
 exec bpa.alter_policies('POLICY_TABLE_TRIGGERS');


COMMENT ON TABLE BARS.POLICY_TABLE_TRIGGERS IS 'Таблицы <--> триггера с политиками доступа';
COMMENT ON COLUMN BARS.POLICY_TABLE_TRIGGERS.OWNER IS 'Владелец таблицы(схема)';
COMMENT ON COLUMN BARS.POLICY_TABLE_TRIGGERS.TABLE_NAME IS 'Имя таблицы';
COMMENT ON COLUMN BARS.POLICY_TABLE_TRIGGERS.TRIGGERS IS 'Перечень префиксов триггеров через запятую';




PROMPT *** Create  constraint PK_PLCTABTRIGGERS ***
begin   
 execute immediate '
  ALTER TABLE BARS.POLICY_TABLE_TRIGGERS ADD CONSTRAINT PK_PLCTABTRIGGERS PRIMARY KEY (OWNER, TABLE_NAME)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PLCTABTRIGGERS_OWNER_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.POLICY_TABLE_TRIGGERS MODIFY (OWNER CONSTRAINT CC_PLCTABTRIGGERS_OWNER_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PLCTABTRIGGERS_TABLENAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.POLICY_TABLE_TRIGGERS MODIFY (TABLE_NAME CONSTRAINT CC_PLCTABTRIGGERS_TABLENAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PLCTABTRIGGERS_TRIGGERS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.POLICY_TABLE_TRIGGERS MODIFY (TRIGGERS CONSTRAINT CC_PLCTABTRIGGERS_TRIGGERS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_PLCTABTRIGGERS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_PLCTABTRIGGERS ON BARS.POLICY_TABLE_TRIGGERS (OWNER, TABLE_NAME) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  POLICY_TABLE_TRIGGERS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on POLICY_TABLE_TRIGGERS to ABS_ADMIN;
grant SELECT                                                                 on POLICY_TABLE_TRIGGERS to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on POLICY_TABLE_TRIGGERS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on POLICY_TABLE_TRIGGERS to BARS_DM;
grant SELECT                                                                 on POLICY_TABLE_TRIGGERS to START1;
grant SELECT                                                                 on POLICY_TABLE_TRIGGERS to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on POLICY_TABLE_TRIGGERS to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on POLICY_TABLE_TRIGGERS to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/POLICY_TABLE_TRIGGERS.sql =========***
PROMPT ===================================================================================== 
