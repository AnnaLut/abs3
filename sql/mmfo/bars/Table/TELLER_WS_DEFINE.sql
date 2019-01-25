PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TELLER_WS_DEFINE.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TELLER_WS_DEFINE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TELLER_WS_DEFINE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TELLER_WS_DEFINE ***
begin 
  execute immediate '
  CREATE TABLE BARS.TELLER_WS_DEFINE 
   (	OP_TYPE VARCHAR2(3), 
	WS_ID NUMBER, 
	WS_NAME VARCHAR2(100), 
	FUNCNAME VARCHAR2(100), 
	PARAMS SYS.XMLTYPE , 
	START_STATE VARCHAR2(100), 
	END_STATE VARCHAR2(100), 
	REQUIRED NUMBER, 
	OPER_START_STATE VARCHAR2(10), 
	OPER_END_STATE VARCHAR2(10), 
	WS_TYPE VARCHAR2(1)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND 
 XMLTYPE COLUMN PARAMS STORE AS SECUREFILE BINARY XML (
  TABLESPACE BRSDYND ENABLE STORAGE IN ROW CHUNK 8192
  NOCACHE LOGGING  NOCOMPRESS  KEEP_DUPLICATES ) ALLOW NONSCHEMA DISALLOW ANYSCHEMA ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TELLER_WS_DEFINE ***
 exec bpa.alter_policies('TELLER_WS_DEFINE');


COMMENT ON TABLE BARS.TELLER_WS_DEFINE IS '';
COMMENT ON COLUMN BARS.TELLER_WS_DEFINE.OP_TYPE IS 'Тип операции (IN - приход,  OUT - расход, ALL - приход/расход)';
COMMENT ON COLUMN BARS.TELLER_WS_DEFINE.WS_ID IS 'порядковый номер сервиса в пределах операции';
COMMENT ON COLUMN BARS.TELLER_WS_DEFINE.WS_NAME IS 'Имя вызываемого веб-сервиса';
COMMENT ON COLUMN BARS.TELLER_WS_DEFINE.FUNCNAME IS 'Имя функции/процедуры для вызова';
COMMENT ON COLUMN BARS.TELLER_WS_DEFINE.PARAMS IS 'перечень параметров для работы сервиса';
COMMENT ON COLUMN BARS.TELLER_WS_DEFINE.START_STATE IS 'Начальное состояние устройства';
COMMENT ON COLUMN BARS.TELLER_WS_DEFINE.END_STATE IS 'Конечное состояние устройства (ожидаемое)';
COMMENT ON COLUMN BARS.TELLER_WS_DEFINE.REQUIRED IS '1 - обязательный вызов в операции, 0 - нет';
COMMENT ON COLUMN BARS.TELLER_WS_DEFINE.OPER_START_STATE IS 'Начальный статус операции';
COMMENT ON COLUMN BARS.TELLER_WS_DEFINE.OPER_END_STATE IS 'Конечный статус операции';
COMMENT ON COLUMN BARS.TELLER_WS_DEFINE.WS_TYPE IS 'Тип WS (I - быстрый, D - долгий)';




PROMPT *** Create  constraint PK_TELLER_WS_DEFINE ***
begin   
 execute immediate '
  ALTER TABLE BARS.TELLER_WS_DEFINE ADD CONSTRAINT PK_TELLER_WS_DEFINE PRIMARY KEY (OP_TYPE, WS_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_TELLER_WS_DEFINE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_TELLER_WS_DEFINE ON BARS.TELLER_WS_DEFINE (OP_TYPE, WS_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TELLER_WS_DEFINE.sql =========*** End 
PROMPT ===================================================================================== 
