

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/FINMON/Table/METACOLS.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  table METACOLS ***
begin 
  execute immediate '
  CREATE TABLE FINMON.METACOLS 
   (	TABNAME VARCHAR2(30), 
	COLNAME VARCHAR2(30), 
	COLPOS NUMBER(3,0), 
	COLTYPE VARCHAR2(1), 
	COLWIDTH NUMBER(4,0), 
	COLMAXCHAR NUMBER(4,0), 
	COLVISIBLE NUMBER(1,0), 
	COLPK NUMBER(1,0), 
	COLALIGN VARCHAR2(1), 
	COLMASK VARCHAR2(30), 
	INMODAL NUMBER(1,0), 
	COLFK NUMBER(1,0), 
	COLEDITABLE NUMBER(1,0), 
	EDITORCLASS VARCHAR2(254)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE USERS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE FINMON.METACOLS IS 'Метаописание таблиц приложения';
COMMENT ON COLUMN FINMON.METACOLS.TABNAME IS 'Имя таблицы';
COMMENT ON COLUMN FINMON.METACOLS.COLNAME IS 'Имя колонки';
COMMENT ON COLUMN FINMON.METACOLS.COLPOS IS 'Позиция в наборе';
COMMENT ON COLUMN FINMON.METACOLS.COLTYPE IS 'Тип колонки';
COMMENT ON COLUMN FINMON.METACOLS.COLWIDTH IS 'Визуальная ширина';
COMMENT ON COLUMN FINMON.METACOLS.COLMAXCHAR IS 'Макс. кол-во символов';
COMMENT ON COLUMN FINMON.METACOLS.COLVISIBLE IS 'Видимая?';
COMMENT ON COLUMN FINMON.METACOLS.COLPK IS 'Первичный ключ';
COMMENT ON COLUMN FINMON.METACOLS.COLALIGN IS 'Выравнивание';
COMMENT ON COLUMN FINMON.METACOLS.COLMASK IS 'Маска';
COMMENT ON COLUMN FINMON.METACOLS.INMODAL IS 'Показывать в модальном режиме';
COMMENT ON COLUMN FINMON.METACOLS.COLFK IS 'Foreign Key';
COMMENT ON COLUMN FINMON.METACOLS.COLEDITABLE IS 'Признак редактируемости';
COMMENT ON COLUMN FINMON.METACOLS.EDITORCLASS IS 'Имя класса для редактирования колонки';




PROMPT *** Create  constraint XPK_METACOLS ***
begin   
 execute immediate '
  ALTER TABLE FINMON.METACOLS ADD CONSTRAINT XPK_METACOLS PRIMARY KEY (TABNAME, COLNAME)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE USERS  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_METACOLS_POS ***
begin   
 execute immediate '
  ALTER TABLE FINMON.METACOLS MODIFY (COLPOS CONSTRAINT NK_METACOLS_POS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_METACOLS_TYPE ***
begin   
 execute immediate '
  ALTER TABLE FINMON.METACOLS MODIFY (COLTYPE CONSTRAINT NK_METACOLS_TYPE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_METACOLS_WIDTH ***
begin   
 execute immediate '
  ALTER TABLE FINMON.METACOLS MODIFY (COLWIDTH CONSTRAINT NK_METACOLS_WIDTH NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_METACOLS_MAXC ***
begin   
 execute immediate '
  ALTER TABLE FINMON.METACOLS MODIFY (COLMAXCHAR CONSTRAINT NK_METACOLS_MAXC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_METACOLS_VISIBL ***
begin   
 execute immediate '
  ALTER TABLE FINMON.METACOLS MODIFY (COLVISIBLE CONSTRAINT NK_METACOLS_VISIBL NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_METACOLS_PK ***
begin   
 execute immediate '
  ALTER TABLE FINMON.METACOLS MODIFY (COLPK CONSTRAINT NK_METACOLS_PK NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_METACOLS_ALIGN ***
begin   
 execute immediate '
  ALTER TABLE FINMON.METACOLS MODIFY (COLALIGN CONSTRAINT NK_METACOLS_ALIGN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_METACOLS_INMOD ***
begin   
 execute immediate '
  ALTER TABLE FINMON.METACOLS MODIFY (INMODAL CONSTRAINT NK_METACOLS_INMOD NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_METACOLS_FK ***
begin   
 execute immediate '
  ALTER TABLE FINMON.METACOLS MODIFY (COLFK CONSTRAINT NK_METACOLS_FK NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_METACOLS_EDITBL ***
begin   
 execute immediate '
  ALTER TABLE FINMON.METACOLS MODIFY (COLEDITABLE CONSTRAINT NK_METACOLS_EDITBL NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_METACOLS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX FINMON.XPK_METACOLS ON FINMON.METACOLS (TABNAME, COLNAME) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE USERS ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  METACOLS ***
grant SELECT                                                                 on METACOLS        to BARSREADER_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/FINMON/Table/METACOLS.sql =========*** End *** ==
PROMPT ===================================================================================== 
