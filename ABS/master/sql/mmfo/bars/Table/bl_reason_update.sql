

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BL_REASON_UPDATE.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BL_REASON_UPDATE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BL_REASON_UPDATE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''BL_REASON_UPDATE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''BL_REASON_UPDATE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BL_REASON_UPDATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.BL_REASON_UPDATE 
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
	SVZ_ID NUMBER, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BL_REASON_UPDATE ***
 exec bpa.alter_policies('BL_REASON_UPDATE');


COMMENT ON TABLE BARS.BL_REASON_UPDATE IS 'ПРИЧИНЫ ПОСТАНОВКИ В ЧЕРНЫЙ СПИСОК';
COMMENT ON COLUMN BARS.BL_REASON_UPDATE.KF IS '';
COMMENT ON COLUMN BARS.BL_REASON_UPDATE.REASON_ID IS 'Уникальный идентификатор';
COMMENT ON COLUMN BARS.BL_REASON_UPDATE.PERSON_ID IS 'Link to BL_PERSON. Не уникальный столбец значений.';
COMMENT ON COLUMN BARS.BL_REASON_UPDATE.REASON_GROUP IS 'Link to BL_REASON_DICT';
COMMENT ON COLUMN BARS.BL_REASON_UPDATE.BASE IS 'База данных';
COMMENT ON COLUMN BARS.BL_REASON_UPDATE.INFO_SOURCE IS 'Источник получения информации';
COMMENT ON COLUMN BARS.BL_REASON_UPDATE.COMMENT_TEXT IS 'Комментарий';
COMMENT ON COLUMN BARS.BL_REASON_UPDATE.INS_DATE IS 'Дата добавления записи';
COMMENT ON COLUMN BARS.BL_REASON_UPDATE.USER_ID IS 'Код пользователя';
COMMENT ON COLUMN BARS.BL_REASON_UPDATE.BASE_ID IS '';
COMMENT ON COLUMN BARS.BL_REASON_UPDATE.TYPE_ID IS 'Тип идентификатора связи 0 - bid_id,  2 - rnk';
COMMENT ON COLUMN BARS.BL_REASON_UPDATE.SVZ_ID IS 'Идентификатор связи';




PROMPT *** Create  constraint CC_BLREASONUPDATE_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BL_REASON_UPDATE MODIFY (KF CONSTRAINT CC_BLREASONUPDATE_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NN_BL_REASON_REASON_ID_UPD ***
begin   
 execute immediate '
  ALTER TABLE BARS.BL_REASON_UPDATE MODIFY (REASON_ID CONSTRAINT NN_BL_REASON_REASON_ID_UPD NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NN_BL_REASON_PERSON_ID_UPD ***
begin   
 execute immediate '
  ALTER TABLE BARS.BL_REASON_UPDATE MODIFY (PERSON_ID CONSTRAINT NN_BL_REASON_PERSON_ID_UPD NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NN_BL_REASON_USER_UPD ***
begin   
 execute immediate '
  ALTER TABLE BARS.BL_REASON_UPDATE MODIFY (USER_ID CONSTRAINT NN_BL_REASON_USER_UPD NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index BL_REASON_PERS_UPD ***
begin   
 execute immediate '
  CREATE INDEX BARS.BL_REASON_PERS_UPD ON BARS.BL_REASON_UPDATE (PERSON_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index BL_REASON_P ***
begin   
 execute immediate '
  CREATE INDEX BARS.BL_REASON_P ON BARS.BL_REASON_UPDATE (REASON_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BL_REASON_UPDATE ***
grant SELECT                                                                 on BL_REASON_UPDATE to BARSREADER_ROLE;
grant SELECT                                                                 on BL_REASON_UPDATE to BARS_DM;
grant INSERT,SELECT                                                          on BL_REASON_UPDATE to RBL;
grant SELECT                                                                 on BL_REASON_UPDATE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BL_REASON_UPDATE.sql =========*** End 
PROMPT ===================================================================================== 
