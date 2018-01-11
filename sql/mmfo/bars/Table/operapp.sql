

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OPERAPP.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OPERAPP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OPERAPP'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''OPERAPP'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''OPERAPP'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OPERAPP ***
begin 
  execute immediate '
  CREATE TABLE BARS.OPERAPP 
   (	CODEAPP VARCHAR2(30), 
	CODEOPER NUMBER(38,0), 
	HOTKEY VARCHAR2(1), 
	APPROVE NUMBER(1,0), 
	ADATE1 DATE, 
	ADATE2 DATE, 
	RDATE1 DATE, 
	RDATE2 DATE, 
	REVERSE NUMBER(1,0), 
	REVOKED NUMBER(1,0), 
	GRANTOR NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OPERAPP ***
 exec bpa.alter_policies('OPERAPP');


COMMENT ON TABLE BARS.OPERAPP IS 'ФУНКЦИИ  <->  АРМ - ы';
COMMENT ON COLUMN BARS.OPERAPP.CODEAPP IS 'Код приложения';
COMMENT ON COLUMN BARS.OPERAPP.CODEOPER IS 'Код функции';
COMMENT ON COLUMN BARS.OPERAPP.HOTKEY IS 'Клавиша';
COMMENT ON COLUMN BARS.OPERAPP.APPROVE IS 'Признак подтверждения';
COMMENT ON COLUMN BARS.OPERAPP.ADATE1 IS 'Дата начала действия привилегии';
COMMENT ON COLUMN BARS.OPERAPP.ADATE2 IS 'Дата окончания действия привилегии';
COMMENT ON COLUMN BARS.OPERAPP.RDATE1 IS 'Дата начала бездействия привилегии';
COMMENT ON COLUMN BARS.OPERAPP.RDATE2 IS 'Дата окончания бездействия привилегии';
COMMENT ON COLUMN BARS.OPERAPP.REVERSE IS 'Возврат';
COMMENT ON COLUMN BARS.OPERAPP.REVOKED IS 'Пометка на удаление ресурса';
COMMENT ON COLUMN BARS.OPERAPP.GRANTOR IS 'Пользователь, выдавший ресурс';




PROMPT *** Create  constraint CC_OPERAPP_REVOKED ***
begin   
 execute immediate '
  ALTER TABLE BARS.OPERAPP ADD CONSTRAINT CC_OPERAPP_REVOKED CHECK (revoked in (0,1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OPERAPP_ADATE1 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OPERAPP ADD CONSTRAINT CC_OPERAPP_ADATE1 CHECK (adate1 <= adate2) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OPERAPP_RDATE1 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OPERAPP ADD CONSTRAINT CC_OPERAPP_RDATE1 CHECK (rdate1 <= rdate2) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_OPERAPP ***
begin   
 execute immediate '
  ALTER TABLE BARS.OPERAPP ADD CONSTRAINT PK_OPERAPP PRIMARY KEY (CODEAPP, CODEOPER)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OPERAPP_APPROVE ***
begin   
 execute immediate '
  ALTER TABLE BARS.OPERAPP ADD CONSTRAINT CC_OPERAPP_APPROVE CHECK (approve in (0,1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OPERAPP_REVERSE ***
begin   
 execute immediate '
  ALTER TABLE BARS.OPERAPP ADD CONSTRAINT CC_OPERAPP_REVERSE CHECK (reverse in (0,1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OPERAPP_CODEAPP_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OPERAPP MODIFY (CODEAPP CONSTRAINT CC_OPERAPP_CODEAPP_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OPERAPP_CODEOPER_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OPERAPP MODIFY (CODEOPER CONSTRAINT CC_OPERAPP_CODEOPER_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_OPERAPP ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_OPERAPP ON BARS.OPERAPP (CODEAPP, CODEOPER) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OPERAPP ***
grant DELETE,INSERT,SELECT,UPDATE                                            on OPERAPP         to ABS_ADMIN;
grant SELECT                                                                 on OPERAPP         to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on OPERAPP         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on OPERAPP         to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on OPERAPP         to OPERAPP;
grant SELECT                                                                 on OPERAPP         to START1;
grant SELECT                                                                 on OPERAPP         to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on OPERAPP         to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on OPERAPP         to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OPERAPP.sql =========*** End *** =====
PROMPT ===================================================================================== 
