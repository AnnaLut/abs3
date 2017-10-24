

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/POLICY_TABLE_LT.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to POLICY_TABLE_LT ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table POLICY_TABLE_LT ***
begin 
  execute immediate '
  CREATE TABLE BARS.POLICY_TABLE_LT 
   (	TABLE_NAME VARCHAR2(30), 
	SELECT_POLICY VARCHAR2(10), 
	INSERT_POLICY VARCHAR2(10), 
	UPDATE_POLICY VARCHAR2(10), 
	DELETE_POLICY VARCHAR2(10), 
	REPL_TYPE VARCHAR2(10), 
	POLICY_GROUP VARCHAR2(30) DEFAULT ''FILIAL'', 
	OWNER VARCHAR2(30) DEFAULT ''BARS'', 
	POLICY_COMMENT VARCHAR2(4000), 
	CHANGE_TIME DATE, 
	APPLY_TIME DATE, 
	WHO_ALTER VARCHAR2(256), 
	WHO_CHANGE VARCHAR2(256), 
	VERSION NUMBER(*,0), 
	NEXTVER VARCHAR2(500), 
	DELSTATUS NUMBER(*,0), 
	LTLOCK VARCHAR2(100)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to POLICY_TABLE_LT ***
 exec bpa.alter_policies('POLICY_TABLE_LT');


COMMENT ON TABLE BARS.POLICY_TABLE_LT IS 'Таблица политик';
COMMENT ON COLUMN BARS.POLICY_TABLE_LT.TABLE_NAME IS 'Название таблицы';
COMMENT ON COLUMN BARS.POLICY_TABLE_LT.SELECT_POLICY IS 'Выбор политики';
COMMENT ON COLUMN BARS.POLICY_TABLE_LT.INSERT_POLICY IS 'Вставка политики';
COMMENT ON COLUMN BARS.POLICY_TABLE_LT.UPDATE_POLICY IS 'Обновление политики';
COMMENT ON COLUMN BARS.POLICY_TABLE_LT.DELETE_POLICY IS 'Удаление политики';
COMMENT ON COLUMN BARS.POLICY_TABLE_LT.REPL_TYPE IS 'Тип репликации для данного объекта';
COMMENT ON COLUMN BARS.POLICY_TABLE_LT.POLICY_GROUP IS '';
COMMENT ON COLUMN BARS.POLICY_TABLE_LT.OWNER IS '';
COMMENT ON COLUMN BARS.POLICY_TABLE_LT.POLICY_COMMENT IS '';
COMMENT ON COLUMN BARS.POLICY_TABLE_LT.CHANGE_TIME IS 'Время изменения';
COMMENT ON COLUMN BARS.POLICY_TABLE_LT.APPLY_TIME IS 'Время применения политик';
COMMENT ON COLUMN BARS.POLICY_TABLE_LT.WHO_ALTER IS 'Кто проальтерил политику';
COMMENT ON COLUMN BARS.POLICY_TABLE_LT.VERSION IS '';
COMMENT ON COLUMN BARS.POLICY_TABLE_LT.NEXTVER IS '';
COMMENT ON COLUMN BARS.POLICY_TABLE_LT.DELSTATUS IS '';
COMMENT ON COLUMN BARS.POLICY_TABLE_LT.LTLOCK IS '';
COMMENT ON COLUMN BARS.POLICY_TABLE_LT.WHO_CHANGE IS 'Кто изменил значения политик в полях *_policy';




PROMPT *** Create  constraint CC_POLICYTABLE_REPLTYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.POLICY_TABLE_LT ADD CONSTRAINT CC_POLICYTABLE_REPLTYPE CHECK (repl_type in (''RO'', ''RO+'', ''UPD'', ''UPD+'', ''UPD-'', ''L'', ''N'', ''P'')) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_POLICYTABLE_OWNER_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.POLICY_TABLE_LT MODIFY (OWNER CONSTRAINT CC_POLICYTABLE_OWNER_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_POLICYTABLE ***
begin   
 execute immediate '
  ALTER TABLE BARS.POLICY_TABLE_LT ADD CONSTRAINT PK_POLICYTABLE PRIMARY KEY (VERSION, OWNER, TABLE_NAME, POLICY_GROUP)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index POLICY_TABLE_PKI$ ***
begin   
 execute immediate '
  CREATE INDEX BARS.POLICY_TABLE_PKI$ ON BARS.POLICY_TABLE_LT (OWNER, TABLE_NAME, POLICY_GROUP) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_POLICYTABLE ***
begin   
 execute immediate '
  CREATE INDEX BARS.PK_POLICYTABLE ON BARS.POLICY_TABLE_LT (VERSION, OWNER, TABLE_NAME, POLICY_GROUP) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  POLICY_TABLE_LT ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on POLICY_TABLE_LT to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/POLICY_TABLE_LT.sql =========*** End *
PROMPT ===================================================================================== 
