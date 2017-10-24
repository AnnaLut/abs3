

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SEC_DDL_AUDIT.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SEC_DDL_AUDIT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SEC_DDL_AUDIT'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SEC_DDL_AUDIT'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SEC_DDL_AUDIT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SEC_DDL_AUDIT ***
begin 
  execute immediate '
  CREATE TABLE BARS.SEC_DDL_AUDIT 
   (	REC_ID NUMBER, 
	REC_DATE DATE, 
	REC_BDATE DATE, 
	REC_UNAME VARCHAR2(30), 
	REC_MODULE VARCHAR2(30), 
	OBJ_NAME VARCHAR2(100), 
	OBJ_OWNER VARCHAR2(100), 
	SQL_TEXT VARCHAR2(4000), 
	MACHINE VARCHAR2(100), 
	OPERATION_TYPE VARCHAR2(30)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SEC_DDL_AUDIT ***
 exec bpa.alter_policies('SEC_DDL_AUDIT');


COMMENT ON TABLE BARS.SEC_DDL_AUDIT IS 'Журнал аудита DDL изменений схемы BARS';
COMMENT ON COLUMN BARS.SEC_DDL_AUDIT.REC_ID IS 'Порядковий номер';
COMMENT ON COLUMN BARS.SEC_DDL_AUDIT.REC_DATE IS 'Системна дата запису';
COMMENT ON COLUMN BARS.SEC_DDL_AUDIT.REC_BDATE IS 'Банківська дата запису';
COMMENT ON COLUMN BARS.SEC_DDL_AUDIT.REC_UNAME IS 'Імя користувача';
COMMENT ON COLUMN BARS.SEC_DDL_AUDIT.REC_MODULE IS 'Модуль';
COMMENT ON COLUMN BARS.SEC_DDL_AUDIT.OBJ_NAME IS 'Назва объекту, що змінювався';
COMMENT ON COLUMN BARS.SEC_DDL_AUDIT.OBJ_OWNER IS 'Схема обєкту';
COMMENT ON COLUMN BARS.SEC_DDL_AUDIT.SQL_TEXT IS 'Текст DDL, що було виконано';
COMMENT ON COLUMN BARS.SEC_DDL_AUDIT.MACHINE IS 'Імя машини (IP)';
COMMENT ON COLUMN BARS.SEC_DDL_AUDIT.OPERATION_TYPE IS 'Тип операції (CREATE,DROP,ALTER)';




PROMPT *** Create  index XAK_SECDDLAUDIT_BDATE ***
begin   
 execute immediate '
  CREATE INDEX BARS.XAK_SECDDLAUDIT_BDATE ON BARS.SEC_DDL_AUDIT (REC_BDATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index XAK_SECDDLAUDIT_DATE ***
begin   
 execute immediate '
  CREATE INDEX BARS.XAK_SECDDLAUDIT_DATE ON BARS.SEC_DDL_AUDIT (REC_DATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SEC_DDL_AUDIT ***
grant SELECT                                                                 on SEC_DDL_AUDIT   to BARSUPL;
grant SELECT                                                                 on SEC_DDL_AUDIT   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SEC_DDL_AUDIT   to BARS_DM;
grant SELECT                                                                 on SEC_DDL_AUDIT   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SEC_DDL_AUDIT.sql =========*** End ***
PROMPT ===================================================================================== 
