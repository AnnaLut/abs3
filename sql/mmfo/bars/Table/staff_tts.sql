

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/STAFF_TTS.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to STAFF_TTS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''STAFF_TTS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''STAFF_TTS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''STAFF_TTS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table STAFF_TTS ***
begin 
  execute immediate '
  CREATE TABLE BARS.STAFF_TTS 
   (	TT CHAR(3), 
	ID NUMBER(38,0), 
	APPROVE NUMBER(1,0), 
	ADATE1 DATE, 
	ADATE2 DATE, 
	RDATE1 DATE, 
	RDATE2 DATE, 
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




PROMPT *** ALTER_POLICIES to STAFF_TTS ***
 exec bpa.alter_policies('STAFF_TTS');


COMMENT ON TABLE BARS.STAFF_TTS IS 'ОПЕРАЦИИ <-> ПОЛЬЗОВАТЕЛИ';
COMMENT ON COLUMN BARS.STAFF_TTS.TT IS 'Тип транзакции';
COMMENT ON COLUMN BARS.STAFF_TTS.ID IS 'Код пользователя';
COMMENT ON COLUMN BARS.STAFF_TTS.APPROVE IS 'Флаг подтверждения выдачи привилегии';
COMMENT ON COLUMN BARS.STAFF_TTS.ADATE1 IS 'Дата начала действия привилегии';
COMMENT ON COLUMN BARS.STAFF_TTS.ADATE2 IS 'Дата окончания действия привилегии';
COMMENT ON COLUMN BARS.STAFF_TTS.RDATE1 IS 'Дата начала бездействия привилегии';
COMMENT ON COLUMN BARS.STAFF_TTS.RDATE2 IS 'Дата окончания бездействия привилегии';
COMMENT ON COLUMN BARS.STAFF_TTS.REVOKED IS 'Флаг подтверждения изъятия привилегии';
COMMENT ON COLUMN BARS.STAFF_TTS.GRANTOR IS 'Пользователь, выдавший привелегию';




PROMPT *** Create  constraint CC_STAFFTTS_TT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF_TTS MODIFY (TT CONSTRAINT CC_STAFFTTS_TT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_STAFFTTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF_TTS ADD CONSTRAINT PK_STAFFTTS PRIMARY KEY (TT, ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STAFFTTS_ADATE1 ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF_TTS ADD CONSTRAINT CC_STAFFTTS_ADATE1 CHECK (adate1 <= adate2) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STAFFTTS_RDATE1 ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF_TTS ADD CONSTRAINT CC_STAFFTTS_RDATE1 CHECK (rdate1 <= rdate2) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STAFFTTS_APPROVE ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF_TTS ADD CONSTRAINT CC_STAFFTTS_APPROVE CHECK (approve in (0,1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STAFFTTS_REVOKED ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF_TTS ADD CONSTRAINT CC_STAFFTTS_REVOKED CHECK (revoked in (0,1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_STAFFTTS_TTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF_TTS ADD CONSTRAINT FK_STAFFTTS_TTS FOREIGN KEY (TT)
	  REFERENCES BARS.TTS (TT) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STAFFTTS_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF_TTS MODIFY (ID CONSTRAINT CC_STAFFTTS_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_STAFFTTS_STAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF_TTS ADD CONSTRAINT FK_STAFFTTS_STAFF FOREIGN KEY (ID)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_STAFFTTS_STAFF2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF_TTS ADD CONSTRAINT FK_STAFFTTS_STAFF2 FOREIGN KEY (GRANTOR)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_STAFFTTS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_STAFFTTS ON BARS.STAFF_TTS (TT, ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  STAFF_TTS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on STAFF_TTS       to ABS_ADMIN;
grant REFERENCES,SELECT                                                      on STAFF_TTS       to BARSAQ with grant option;
grant REFERENCES,SELECT                                                      on STAFF_TTS       to BARSAQ_ADM with grant option;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on STAFF_TTS       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on STAFF_TTS       to BARS_DM;
grant SELECT                                                                 on STAFF_TTS       to PYOD001;
grant DELETE,INSERT,SELECT,UPDATE                                            on STAFF_TTS       to STAFF_TTS;
grant SELECT                                                                 on STAFF_TTS       to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on STAFF_TTS       to WR_ALL_RIGHTS;
grant SELECT                                                                 on STAFF_TTS       to WR_DOC_INPUT;
grant FLASHBACK,SELECT                                                       on STAFF_TTS       to WR_REFREAD;



PROMPT *** Create SYNONYM  to STAFF_TTS ***

  CREATE OR REPLACE PUBLIC SYNONYM USER_TTS FOR BARS.STAFF_TTS;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/STAFF_TTS.sql =========*** End *** ===
PROMPT ===================================================================================== 
