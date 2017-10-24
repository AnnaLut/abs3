

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BL_REASON.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BL_REASON ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BL_REASON'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''BL_REASON'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''BL_REASON'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BL_REASON ***
begin 
  execute immediate '
  CREATE TABLE BARS.BL_REASON 
   (	REASON_ID NUMBER, 
	PERSON_ID NUMBER, 
	REASON_GROUP NUMBER, 
	BASE VARCHAR2(30), 
	INFO_SOURCE VARCHAR2(30), 
	COMMENT_TEXT VARCHAR2(2000), 
	INS_DATE DATE, 
	USER_ID NUMBER, 
	BASE_ID NUMBER, 
	TYPE_ID NUMBER, 
	SVZ_ID NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BL_REASON ***
 exec bpa.alter_policies('BL_REASON');


COMMENT ON TABLE BARS.BL_REASON IS 'ПРИЧИНЫ ПОСТАНОВКИ В ЧЕРНЫЙ СПИСОК';
COMMENT ON COLUMN BARS.BL_REASON.REASON_ID IS 'Уникальный идентификатор';
COMMENT ON COLUMN BARS.BL_REASON.PERSON_ID IS 'Link to BL_PERSON. Не уникальный столбец значений.';
COMMENT ON COLUMN BARS.BL_REASON.REASON_GROUP IS 'Link to BL_REASON_DICT';
COMMENT ON COLUMN BARS.BL_REASON.BASE IS 'База данных';
COMMENT ON COLUMN BARS.BL_REASON.INFO_SOURCE IS 'Источник получения информации';
COMMENT ON COLUMN BARS.BL_REASON.COMMENT_TEXT IS 'Комментарий';
COMMENT ON COLUMN BARS.BL_REASON.INS_DATE IS 'Дата добавления записи';
COMMENT ON COLUMN BARS.BL_REASON.USER_ID IS 'Код пользователя';
COMMENT ON COLUMN BARS.BL_REASON.BASE_ID IS '';
COMMENT ON COLUMN BARS.BL_REASON.TYPE_ID IS 'Тип идентификатора связи 0 - bid_id,  2 - rnk';
COMMENT ON COLUMN BARS.BL_REASON.SVZ_ID IS '';




PROMPT *** Create  constraint BL_REASON_PK ***
begin   
 execute immediate '
  ALTER TABLE BARS.BL_REASON ADD CONSTRAINT BL_REASON_PK PRIMARY KEY (BASE_ID, REASON_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint BL_REASON_BASE ***
begin   
 execute immediate '
  ALTER TABLE BARS.BL_REASON ADD CONSTRAINT BL_REASON_BASE FOREIGN KEY (BASE_ID)
	  REFERENCES BARS.BL_BASE_DICT (BASE_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint BL_REASON_PERSON_FK ***
begin   
 execute immediate '
  ALTER TABLE BARS.BL_REASON ADD CONSTRAINT BL_REASON_PERSON_FK FOREIGN KEY (BASE_ID, PERSON_ID)
	  REFERENCES BARS.BL_PERSON (BASE_ID, PERSON_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint BL_REASON_REASON_FK ***
begin   
 execute immediate '
  ALTER TABLE BARS.BL_REASON ADD CONSTRAINT BL_REASON_REASON_FK FOREIGN KEY (REASON_GROUP)
	  REFERENCES BARS.BL_REASON_DICT (REASON_GROUP) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint BL_REASON_USER_FK ***
begin   
 execute immediate '
  ALTER TABLE BARS.BL_REASON ADD CONSTRAINT BL_REASON_USER_FK FOREIGN KEY (USER_ID)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NN_BL_REASON_REASON_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.BL_REASON MODIFY (REASON_ID CONSTRAINT NN_BL_REASON_REASON_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NN_BL_REASON_PERSON_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.BL_REASON MODIFY (PERSON_ID CONSTRAINT NN_BL_REASON_PERSON_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NN_BL_REASON_BASE_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.BL_REASON MODIFY (BASE_ID CONSTRAINT NN_BL_REASON_BASE_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NN_BL_REASON_USER ***
begin   
 execute immediate '
  ALTER TABLE BARS.BL_REASON MODIFY (USER_ID CONSTRAINT NN_BL_REASON_USER NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index BL_REASON_PK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.BL_REASON_PK ON BARS.BL_REASON (BASE_ID, REASON_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index BL_REASON_PERS ***
begin   
 execute immediate '
  CREATE INDEX BARS.BL_REASON_PERS ON BARS.BL_REASON (BASE_ID, PERSON_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BL_REASON ***
grant SELECT                                                                 on BL_REASON       to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on BL_REASON       to RBL;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BL_REASON.sql =========*** End *** ===
PROMPT ===================================================================================== 
