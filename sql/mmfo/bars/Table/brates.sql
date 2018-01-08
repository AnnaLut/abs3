

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BRATES.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BRATES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BRATES'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''BRATES'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''BRATES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BRATES ***
begin 
  execute immediate '
  CREATE TABLE BARS.BRATES 
   (	BR_ID NUMBER(38,0), 
	BR_TYPE NUMBER(38,0), 
	NAME VARCHAR2(35), 
	FORMULA VARCHAR2(250), 
	INUSE NUMBER(*,0) DEFAULT 1, 
	COMM VARCHAR2(255), 
	BR_TP NUMBER GENERATED ALWAYS AS (LEAST(BR_TYPE,2)) VIRTUAL VISIBLE 
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BRATES ***
 exec bpa.alter_policies('BRATES');


COMMENT ON TABLE BARS.BRATES IS 'Базовые процентные ставки';
COMMENT ON COLUMN BARS.BRATES.BR_TP IS '';
COMMENT ON COLUMN BARS.BRATES.BR_ID IS 'Код базовой ставки';
COMMENT ON COLUMN BARS.BRATES.BR_TYPE IS 'Тип базовой процентной ставки';
COMMENT ON COLUMN BARS.BRATES.NAME IS 'Название процентной ставки';
COMMENT ON COLUMN BARS.BRATES.FORMULA IS 'SQL-формула для типа ставки =4';
COMMENT ON COLUMN BARS.BRATES.INUSE IS '1 - діюча, 0 - недіюча';
COMMENT ON COLUMN BARS.BRATES.COMM IS '';




PROMPT *** Create  constraint PK_BRATES ***
begin   
 execute immediate '
  ALTER TABLE BARS.BRATES ADD CONSTRAINT PK_BRATES PRIMARY KEY (BR_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_BRATES ***
begin   
 execute immediate '
  ALTER TABLE BARS.BRATES ADD CONSTRAINT UK_BRATES UNIQUE (BR_ID, BR_TP)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BRATES_BRID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BRATES MODIFY (BR_ID CONSTRAINT CC_BRATES_BRID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BRATES_BRTYPE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BRATES MODIFY (BR_TYPE CONSTRAINT CC_BRATES_BRTYPE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BRATES_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BRATES MODIFY (NAME CONSTRAINT CC_BRATES_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_BRATES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_BRATES ON BARS.BRATES (BR_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_BRATES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_BRATES ON BARS.BRATES (BR_ID, BR_TP) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BRATES ***
grant DELETE,INSERT,SELECT,UPDATE                                            on BRATES          to ABS_ADMIN;
grant SELECT                                                                 on BRATES          to BARS009;
grant SELECT                                                                 on BRATES          to BARSAQ with grant option;
grant SELECT                                                                 on BRATES          to BARSREADER_ROLE;
grant SELECT                                                                 on BRATES          to BARSUPL;
grant ALTER,DELETE,FLASHBACK,INSERT,SELECT,UPDATE                            on BRATES          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on BRATES          to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on BRATES          to BRATES;
grant SELECT                                                                 on BRATES          to CUST001;
grant DELETE,INSERT,SELECT,UPDATE                                            on BRATES          to DPT_ADMIN;
grant SELECT,SELECT                                                          on BRATES          to KLBX;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on BRATES          to RCC_DEAL;
grant SELECT                                                                 on BRATES          to REFSYNC_USR;
grant DELETE,INSERT,SELECT,UPDATE                                            on BRATES          to SALGL;
grant SELECT                                                                 on BRATES          to START1;
grant SELECT                                                                 on BRATES          to UPLD;
grant SELECT                                                                 on BRATES          to WR_ACRINT;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on BRATES          to WR_ALL_RIGHTS;
grant SELECT                                                                 on BRATES          to WR_DEPOSIT_U;
grant FLASHBACK,SELECT                                                       on BRATES          to WR_REFREAD;
grant SELECT                                                                 on BRATES          to WR_VIEWACC;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BRATES.sql =========*** End *** ======
PROMPT ===================================================================================== 
