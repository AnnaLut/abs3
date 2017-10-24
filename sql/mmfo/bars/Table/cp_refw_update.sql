PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CP_REFW_UPDATE.sql =========*** Run *** =====
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
  CREATE TABLE CP_REFW_UPDATE
(
  idupd      NUMBER(15) not null,
  chgaction  CHAR(1),
  effectdate DATE,
  chgdate    DATE,
  doneby     NUMBER,
  ref        NUMBER not null,
  tag        VARCHAR2(7),
  value      VARCHAR2(500)
) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD  ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CP_REFW_UPDATE ***
 exec bpa.alter_policies('CP_REFW_UPDATE');


COMMENT ON COLUMN  CP_REFW_UPDATE.idupd
  IS 'Первичный ключ для таблицы обновления';
COMMENT ON COLUMN  CP_REFW_UPDATE.chgaction
  IS 'Код обновления (I/U/D)';
COMMENT ON COLUMN  CP_REFW_UPDATE.effectdate
  IS 'Банковская дата начала действия параметров';
COMMENT ON COLUMN  CP_REFW_UPDATE.chgdate
  IS 'Системаная дата обновления';
COMMENT ON COLUMN  CP_REFW_UPDATE.doneby
  IS 'Код пользователя. кто внес обновления(если в течении дня было несколько обновлений - остается только последнее)';
COMMENT ON COLUMN  CP_REFW_UPDATE.ref
  IS 'REF сделки по ЦБ';
COMMENT ON COLUMN  CP_REFW_UPDATE.tag
  IS 'ТЭГ -мнем.код доп.реквизита';
COMMENT ON COLUMN  CP_REFW_UPDATE.value
  IS 'Значение доп.реквизита';


  
PROMPT *** Create  constraint PK_CP_REFW_UPDATE  ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_REFW_UPDATE ADD CONSTARINT PK_CP_REFW_UPDATE PRIMARY KEY (IDUPD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

PROMPT *** Create  index XAI_CP_REFW_UPDATEPK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XAI_CP_REFW_UPDATEPK ON BARS.CP_REFW_UPDATE (EFFECTDATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

PROMPT *** Create  index INDREF_CP_REFW_UPDATE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.INDREF_CP_REFW_UPDATE ON BARS.CP_REFW_UPDATE (REF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  grants  CP_REFW_UPDATE ***
grant SELECT   on CP_REFW_UPDATE         to BARSUPL;
grant SELECT   on CP_REFW_UPDATE         to BARS_ACCESS_DEFROLE;
grant SELECT   on CP_REFW_UPDATE         to BARS_DM;
grant SELECT   on CP_REFW_UPDATE         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CP_REFW_UPDATE.sql =========*** End *** =====
PROMPT ===================================================================================== 
