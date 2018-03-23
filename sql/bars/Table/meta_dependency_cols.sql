

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/META_DEPENDENCY_COLS.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to META_DEPENDENCY_COLS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''META_DEPENDENCY_COLS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table META_DEPENDENCY_COLS ***
begin 
  execute immediate '
  CREATE TABLE BARS.META_DEPENDENCY_COLS 
   (	ID NUMBER, 
	TABID NUMBER, 
	COLID NUMBER, 
	EVENT VARCHAR2(100), 
	DEPCOLID NUMBER, 
	ACTION_TYPE VARCHAR2(100), 
	ACTION_NAME VARCHAR2(4000), 
	DEFAULT_VALUE VARCHAR2(4000), 
	CONDITION VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to META_DEPENDENCY_COLS ***
 exec bpa.alter_policies('META_DEPENDENCY_COLS');


COMMENT ON TABLE BARS.META_DEPENDENCY_COLS IS 'Залежності між колонками таблиці';
COMMENT ON COLUMN BARS.META_DEPENDENCY_COLS.ID IS 'Ідентифікатор запису';
COMMENT ON COLUMN BARS.META_DEPENDENCY_COLS.TABID IS 'Код таблиці';
COMMENT ON COLUMN BARS.META_DEPENDENCY_COLS.COLID IS 'Код колонки';
COMMENT ON COLUMN BARS.META_DEPENDENCY_COLS.EVENT IS 'Подія, на яку ми реагуємо';
COMMENT ON COLUMN BARS.META_DEPENDENCY_COLS.DEPCOLID IS 'Код залежної колонки';
COMMENT ON COLUMN BARS.META_DEPENDENCY_COLS.ACTION_TYPE IS 'Тип дії';
COMMENT ON COLUMN BARS.META_DEPENDENCY_COLS.ACTION_NAME IS 'Ім''я процедури або url для запуску';
COMMENT ON COLUMN BARS.META_DEPENDENCY_COLS.DEFAULT_VALUE IS 'Значення за замовчуванням для залежної колонки. ';
COMMENT ON COLUMN BARS.META_DEPENDENCY_COLS.CONDITION IS '';




PROMPT *** Create  constraint FK_META_DEP_META_EVENT ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_DEPENDENCY_COLS ADD CONSTRAINT FK_META_DEP_META_EVENT FOREIGN KEY (EVENT)
	  REFERENCES BARS.META_DEP_EVENT (EVENT) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_META_DEP_META_COL ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_DEPENDENCY_COLS ADD CONSTRAINT FK_META_DEP_META_COL FOREIGN KEY (TABID, COLID)
	  REFERENCES BARS.META_COLUMNS (TABID, COLID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_META_DEP_META_ACTTYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_DEPENDENCY_COLS ADD CONSTRAINT FK_META_DEP_META_ACTTYPE FOREIGN KEY (ACTION_TYPE)
	  REFERENCES BARS.META_DEP_ACTIONTYPE (ACTION_TYPE) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_META_DEP_TABID_COLID ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_DEPENDENCY_COLS ADD CONSTRAINT UK_META_DEP_TABID_COLID UNIQUE (TABID, COLID, DEPCOLID, EVENT)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_META_DEPENDENCY_COLS ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_DEPENDENCY_COLS ADD CONSTRAINT PK_META_DEPENDENCY_COLS PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003215277 ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_DEPENDENCY_COLS MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_META_DEP_TABID_COLID ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_META_DEP_TABID_COLID ON BARS.META_DEPENDENCY_COLS (TABID, COLID, DEPCOLID, EVENT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_META_DEPENDENCY_COLS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_META_DEPENDENCY_COLS ON BARS.META_DEPENDENCY_COLS (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  META_DEPENDENCY_COLS ***
grant SELECT                                                                 on META_DEPENDENCY_COLS to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/META_DEPENDENCY_COLS.sql =========*** 
PROMPT ===================================================================================== 
