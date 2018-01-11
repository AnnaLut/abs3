

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/POLICY_TRIGGERS.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to POLICY_TRIGGERS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''POLICY_TRIGGERS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''POLICY_TRIGGERS'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''POLICY_TRIGGERS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table POLICY_TRIGGERS ***
begin 
  execute immediate '
  CREATE TABLE BARS.POLICY_TRIGGERS 
   (	TRIGGER_PREFIX VARCHAR2(20), 
	TRIGGER_BODY VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to POLICY_TRIGGERS ***
 exec bpa.alter_policies('POLICY_TRIGGERS');


COMMENT ON TABLE BARS.POLICY_TRIGGERS IS 'Тригера с политиками доступа';
COMMENT ON COLUMN BARS.POLICY_TRIGGERS.TRIGGER_PREFIX IS 'Префикс имени триггера';
COMMENT ON COLUMN BARS.POLICY_TRIGGERS.TRIGGER_BODY IS 'Тело триггера с макроподстановками: <TABLE_NAME> - имя таблицы, <TRIGGER_NAME> - имя триггера';




PROMPT *** Create  constraint PK_POLICYTRIGGERS ***
begin   
 execute immediate '
  ALTER TABLE BARS.POLICY_TRIGGERS ADD CONSTRAINT PK_POLICYTRIGGERS PRIMARY KEY (TRIGGER_PREFIX)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_POLICYTRIGGERS_PREFIX_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.POLICY_TRIGGERS MODIFY (TRIGGER_PREFIX CONSTRAINT CC_POLICYTRIGGERS_PREFIX_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_POLICYTRIGGERS_BODY_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.POLICY_TRIGGERS MODIFY (TRIGGER_BODY CONSTRAINT CC_POLICYTRIGGERS_BODY_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_POLICYTRIGGERS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_POLICYTRIGGERS ON BARS.POLICY_TRIGGERS (TRIGGER_PREFIX) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  POLICY_TRIGGERS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on POLICY_TRIGGERS to ABS_ADMIN;
grant SELECT                                                                 on POLICY_TRIGGERS to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on POLICY_TRIGGERS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on POLICY_TRIGGERS to BARS_DM;
grant SELECT                                                                 on POLICY_TRIGGERS to START1;
grant SELECT                                                                 on POLICY_TRIGGERS to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on POLICY_TRIGGERS to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on POLICY_TRIGGERS to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/POLICY_TRIGGERS.sql =========*** End *
PROMPT ===================================================================================== 
