

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/IBX_RECS.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to IBX_RECS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''IBX_RECS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''IBX_RECS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table IBX_RECS ***
begin 
  execute immediate '
  CREATE TABLE BARS.IBX_RECS 
   (	TYPE_ID VARCHAR2(256), 
	EXT_REF VARCHAR2(200), 
	EXT_DATE DATE, 
	EXT_SOURCE VARCHAR2(300), 
	DEAL_ID VARCHAR2(25), 
	SUMM NUMBER, 
	ABS_REF NUMBER, 
	FILE_NAME VARCHAR2(256), 
	KWT NUMBER
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to IBX_RECS ***
 exec bpa.alter_policies('IBX_RECS');


COMMENT ON TABLE BARS.IBX_RECS IS 'Таблица квитовки IBOX и АБС';
COMMENT ON COLUMN BARS.IBX_RECS.TYPE_ID IS 'Тип интерфейса';
COMMENT ON COLUMN BARS.IBX_RECS.EXT_REF IS 'Реф. пл. в IBOX';
COMMENT ON COLUMN BARS.IBX_RECS.EXT_DATE IS 'Дата/время в IBOX';
COMMENT ON COLUMN BARS.IBX_RECS.EXT_SOURCE IS 'Источник платежа в IBOX (№ терминала и тп)';
COMMENT ON COLUMN BARS.IBX_RECS.DEAL_ID IS 'Ид. сделки';
COMMENT ON COLUMN BARS.IBX_RECS.SUMM IS 'Сумма в целых';
COMMENT ON COLUMN BARS.IBX_RECS.ABS_REF IS 'Реф. пл. в АБC';
COMMENT ON COLUMN BARS.IBX_RECS.FILE_NAME IS 'Имя файла';
COMMENT ON COLUMN BARS.IBX_RECS.KWT IS 'КВТ: 1 - OK, 0 - ERR, Null - не обр';




PROMPT *** Create  constraint PK_IBXRECS ***
begin   
 execute immediate '
  ALTER TABLE BARS.IBX_RECS ADD CONSTRAINT PK_IBXRECS PRIMARY KEY (TYPE_ID, EXT_REF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_IBXRECS_TID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.IBX_RECS ADD CONSTRAINT CC_IBXRECS_TID_NN CHECK (TYPE_ID IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_IBXRECS_SUMM_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.IBX_RECS ADD CONSTRAINT CC_IBXRECS_SUMM_NN CHECK (SUMM IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_IBXRECS_EXTREF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.IBX_RECS ADD CONSTRAINT CC_IBXRECS_EXTREF_NN CHECK (EXT_REF IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_IBXRECS_EXTDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.IBX_RECS ADD CONSTRAINT CC_IBXRECS_EXTDATE_NN CHECK (EXT_DATE IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_IBXRECS_DEALID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.IBX_RECS ADD CONSTRAINT CC_IBXRECS_DEALID_NN CHECK (DEAL_ID IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_IBXRS_KWT ***
begin   
 execute immediate '
  ALTER TABLE BARS.IBX_RECS ADD CONSTRAINT CC_IBXRS_KWT CHECK (kwt is null or kwt in (0, 1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_IBXRECS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_IBXRECS ON BARS.IBX_RECS (TYPE_ID, EXT_REF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  IBX_RECS ***
grant SELECT                                                                 on IBX_RECS        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/IBX_RECS.sql =========*** End *** ====
PROMPT ===================================================================================== 
