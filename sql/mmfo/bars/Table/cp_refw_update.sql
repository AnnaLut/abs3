

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CP_REFW_UPDATE.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CP_REFW_UPDATE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CP_REFW_UPDATE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CP_REFW_UPDATE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CP_REFW_UPDATE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CP_REFW_UPDATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.CP_REFW_UPDATE 
   (	IDUPD NUMBER(15,0), 
	CHGACTION CHAR(1), 
	EFFECTDATE DATE, 
	CHGDATE DATE, 
	DONEBY NUMBER, 
	REF NUMBER, 
	TAG VARCHAR2(7), 
	VALUE VARCHAR2(500)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CP_REFW_UPDATE ***
 exec bpa.alter_policies('CP_REFW_UPDATE');


COMMENT ON TABLE BARS.CP_REFW_UPDATE IS '';
COMMENT ON COLUMN BARS.CP_REFW_UPDATE.IDUPD IS 'Первичный ключ для таблицы обновления';
COMMENT ON COLUMN BARS.CP_REFW_UPDATE.CHGACTION IS 'Код обновления (I/U/D)';
COMMENT ON COLUMN BARS.CP_REFW_UPDATE.EFFECTDATE IS 'Банковская дата начала действия параметров';
COMMENT ON COLUMN BARS.CP_REFW_UPDATE.CHGDATE IS 'Системаная дата обновления';
COMMENT ON COLUMN BARS.CP_REFW_UPDATE.DONEBY IS 'Код пользователя. кто внес обновления(если в течении дня было несколько обновлений - остается только последнее)';
COMMENT ON COLUMN BARS.CP_REFW_UPDATE.REF IS 'REF сделки по ЦБ';
COMMENT ON COLUMN BARS.CP_REFW_UPDATE.TAG IS 'ТЭГ -мнем.код доп.реквизита';
COMMENT ON COLUMN BARS.CP_REFW_UPDATE.VALUE IS 'Значение доп.реквизита';




PROMPT *** Create  constraint SYS_C00139608 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_REFW_UPDATE MODIFY (IDUPD NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00139609 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_REFW_UPDATE MODIFY (REF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index CP_REFW_UPDATE_EFFECTDATE ***
begin   
 execute immediate '
  CREATE INDEX BARS.CP_REFW_UPDATE_EFFECTDATE ON BARS.CP_REFW_UPDATE (EFFECTDATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index CP_REFW_UPDATE_REF ***
begin   
 execute immediate '
  CREATE INDEX BARS.CP_REFW_UPDATE_REF ON BARS.CP_REFW_UPDATE (REF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CP_REFW_UPDATE ***
grant SELECT                                                                 on CP_REFW_UPDATE  to BARSUPL;
grant SELECT                                                                 on CP_REFW_UPDATE  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CP_REFW_UPDATE  to BARS_DM;
grant SELECT                                                                 on CP_REFW_UPDATE  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CP_REFW_UPDATE.sql =========*** End **
PROMPT ===================================================================================== 
