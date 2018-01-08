

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ZAY_DEBT.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ZAY_DEBT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ZAY_DEBT'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''ZAY_DEBT'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''ZAY_DEBT'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ZAY_DEBT ***
begin 
  execute immediate '
  CREATE TABLE BARS.ZAY_DEBT 
   (	REF NUMBER, 
	REFD NUMBER, 
	TIP NUMBER, 
	SOS NUMBER DEFAULT 0, 
	ZAY_SUM NUMBER, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	SALE_TP NUMBER(1,0) GENERATED ALWAYS AS (CASE  WHEN (REFD IS NOT NULL AND ZAY_SUM IS NULL) THEN 1 WHEN (REFD IS NOT NULL AND ZAY_SUM IS NOT NULL) THEN 2 WHEN (REFD IS NULL AND ZAY_SUM IS NOT NULL) THEN 3 ELSE 0 END) VIRTUAL VISIBLE 
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ZAY_DEBT ***
 exec bpa.alter_policies('ZAY_DEBT');


COMMENT ON TABLE BARS.ZAY_DEBT IS 'Картотека поступлений валюты на распред.счета клиентов';
COMMENT ON COLUMN BARS.ZAY_DEBT.REF IS 'Референс документа-зачисления';
COMMENT ON COLUMN BARS.ZAY_DEBT.REFD IS 'Референс документа-списания';
COMMENT ON COLUMN BARS.ZAY_DEBT.TIP IS 'Тип списания: 1 = вся сумма на 2600, 2 = 50:50';
COMMENT ON COLUMN BARS.ZAY_DEBT.SOS IS 'Статус: 0-не обработан, 1-снят с контроля, 2-обработан';
COMMENT ON COLUMN BARS.ZAY_DEBT.ZAY_SUM IS 'Сумма заявки на обяз.продажу';
COMMENT ON COLUMN BARS.ZAY_DEBT.KF IS '';
COMMENT ON COLUMN BARS.ZAY_DEBT.SALE_TP IS '';




PROMPT *** Create  constraint FK_ZAYDEBT_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAY_DEBT ADD CONSTRAINT FK_ZAYDEBT_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ZAYDEBT_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAY_DEBT MODIFY (KF CONSTRAINT CC_ZAYDEBT_KF_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XPK_ZAY_DEBT ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAY_DEBT ADD CONSTRAINT XPK_ZAY_DEBT UNIQUE (REF, REFD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ZAYDEBT_TIP ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAY_DEBT ADD CONSTRAINT CC_ZAYDEBT_TIP CHECK (tip in (1, 2)) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ZAYDEBT_SOS ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAY_DEBT ADD CONSTRAINT CC_ZAYDEBT_SOS CHECK (sos in (0, 1, 2)) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_ZAY_DEBT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_ZAY_DEBT ON BARS.ZAY_DEBT (REF, REFD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index IDX_ZAYDEBT_REF_SALETP ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_ZAYDEBT_REF_SALETP ON BARS.ZAY_DEBT (REF, SALE_TP) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ZAY_DEBT ***
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on ZAY_DEBT        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ZAY_DEBT        to BARS_DM;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on ZAY_DEBT        to WR_ALL_RIGHTS;
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on ZAY_DEBT        to ZAY;



PROMPT *** Create SYNONYM  to ZAY_DEBT ***

  CREATE OR REPLACE PUBLIC SYNONYM ZAY_DEBT FOR BARS.ZAY_DEBT;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ZAY_DEBT.sql =========*** End *** ====
PROMPT ===================================================================================== 
