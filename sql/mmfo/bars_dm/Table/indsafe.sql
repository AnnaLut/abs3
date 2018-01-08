

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS_DM/Table/INDSAFE.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  table INDSAFE ***
begin 
  execute immediate '
  CREATE TABLE BARS_DM.INDSAFE 
   (	PER_ID NUMBER, 
	BRANCH VARCHAR2(30), 
	KF VARCHAR2(12), 
	VIDP_PERS VARCHAR2(100), 
	PHONE VARCHAR2(20), 
	SAFENUM NUMBER(*,0), 
	STAN VARCHAR2(20), 
	NTYPE VARCHAR2(50), 
	HEIGHT NUMBER, 
	WIDTH NUMBER, 
	DEPTH NUMBER, 
	PRICE NUMBER, 
	CUST_BRANCH VARCHAR2(30), 
	CUST_KF VARCHAR2(12), 
	CUST_RNK NUMBER, 
	DAT_BEGIN DATE, 
	NDOG VARCHAR2(20), 
	DAT_END DATE
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARS_DM.INDSAFE IS 'Індивідуальний сейф';
COMMENT ON COLUMN BARS_DM.INDSAFE.PER_ID IS 'Ідентифікатор періоду';
COMMENT ON COLUMN BARS_DM.INDSAFE.BRANCH IS 'Відділення';
COMMENT ON COLUMN BARS_DM.INDSAFE.KF IS 'МФО РУ';
COMMENT ON COLUMN BARS_DM.INDSAFE.VIDP_PERS IS 'Відповідальна особа';
COMMENT ON COLUMN BARS_DM.INDSAFE.PHONE IS 'Контактний номер телефону працівника';
COMMENT ON COLUMN BARS_DM.INDSAFE.SAFENUM IS 'Номер сейфу';
COMMENT ON COLUMN BARS_DM.INDSAFE.STAN IS 'Стан';
COMMENT ON COLUMN BARS_DM.INDSAFE.NTYPE IS 'Назва типу скриньки';
COMMENT ON COLUMN BARS_DM.INDSAFE.HEIGHT IS 'Висота, см';
COMMENT ON COLUMN BARS_DM.INDSAFE.WIDTH IS 'Ширина, см';
COMMENT ON COLUMN BARS_DM.INDSAFE.DEPTH IS 'Глибина, см';
COMMENT ON COLUMN BARS_DM.INDSAFE.PRICE IS 'Вартість';
COMMENT ON COLUMN BARS_DM.INDSAFE.CUST_BRANCH IS 'Клієнт, Відділення';
COMMENT ON COLUMN BARS_DM.INDSAFE.CUST_KF IS 'Клієнт, Регіональне управління';
COMMENT ON COLUMN BARS_DM.INDSAFE.CUST_RNK IS 'Клієнт, РНК';
COMMENT ON COLUMN BARS_DM.INDSAFE.DAT_BEGIN IS 'Договір від ';
COMMENT ON COLUMN BARS_DM.INDSAFE.NDOG IS '№ договору';
COMMENT ON COLUMN BARS_DM.INDSAFE.DAT_END IS 'Дата закінчення договору';




PROMPT *** Create  constraint CC_INDSAFE_PERID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS_DM.INDSAFE MODIFY (PER_ID CONSTRAINT CC_INDSAFE_PERID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INDSAFE_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS_DM.INDSAFE MODIFY (BRANCH CONSTRAINT CC_INDSAFE_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INDSAFE_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS_DM.INDSAFE MODIFY (KF CONSTRAINT CC_INDSAFE_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_INDSAFE_PERID ***
begin   
 execute immediate '
  CREATE INDEX BARS_DM.I_INDSAFE_PERID ON BARS_DM.INDSAFE (PER_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  INDSAFE ***
grant SELECT                                                                 on INDSAFE         to BARS;
grant SELECT                                                                 on INDSAFE         to BARSREADER_ROLE;
grant SELECT                                                                 on INDSAFE         to BARSUPL;
grant SELECT                                                                 on INDSAFE         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS_DM/Table/INDSAFE.sql =========*** End *** ==
PROMPT ===================================================================================== 
