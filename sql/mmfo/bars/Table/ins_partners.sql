

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/INS_PARTNERS.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to INS_PARTNERS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''INS_PARTNERS'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''INS_PARTNERS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table INS_PARTNERS ***
begin 
  execute immediate '
  CREATE TABLE BARS.INS_PARTNERS 
   (	ID NUMBER, 
	NAME VARCHAR2(300), 
	RNK NUMBER, 
	AGR_NO VARCHAR2(100), 
	AGR_SDATE DATE, 
	AGR_EDATE DATE, 
	TARIFF_ID VARCHAR2(100), 
	FEE_ID VARCHAR2(100), 
	LIMIT_ID VARCHAR2(100), 
	ACTIVE NUMBER, 
	CUSTTYPE NUMBER, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	NLS VARCHAR2(15), 
	MFO VARCHAR2(12)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to INS_PARTNERS ***
 exec bpa.alter_policies('INS_PARTNERS');


COMMENT ON TABLE BARS.INS_PARTNERS IS 'Акредитовані страхові компанії';
COMMENT ON COLUMN BARS.INS_PARTNERS.KF IS '';
COMMENT ON COLUMN BARS.INS_PARTNERS.ID IS 'Ідентифікатор';
COMMENT ON COLUMN BARS.INS_PARTNERS.NAME IS 'Найменування';
COMMENT ON COLUMN BARS.INS_PARTNERS.NLS IS 'Рахунок';
COMMENT ON COLUMN BARS.INS_PARTNERS.MFO IS 'МФО рахунку';
COMMENT ON COLUMN BARS.INS_PARTNERS.RNK IS 'РНК контрагента-компанії';
COMMENT ON COLUMN BARS.INS_PARTNERS.AGR_NO IS 'Номер договору про співробітництво';
COMMENT ON COLUMN BARS.INS_PARTNERS.AGR_SDATE IS 'Дата початку дії договору про співробітництво';
COMMENT ON COLUMN BARS.INS_PARTNERS.AGR_EDATE IS 'Дата закінчення дії договору про співробітництво';
COMMENT ON COLUMN BARS.INS_PARTNERS.TARIFF_ID IS 'Ід. тарифу на компанію';
COMMENT ON COLUMN BARS.INS_PARTNERS.FEE_ID IS 'Ід. комісії на компанію';
COMMENT ON COLUMN BARS.INS_PARTNERS.LIMIT_ID IS 'Ід. ліміту на компанію';
COMMENT ON COLUMN BARS.INS_PARTNERS.ACTIVE IS 'Флаг активності відносин';
COMMENT ON COLUMN BARS.INS_PARTNERS.CUSTTYPE IS 'Тип контрагент';




PROMPT *** Create  constraint CC_INSPRTS_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_PARTNERS MODIFY (ID CONSTRAINT CC_INSPRTS_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INSPRTS_ID_ACTIVE ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_PARTNERS MODIFY (ACTIVE CONSTRAINT CC_INSPRTS_ID_ACTIVE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_INSPARTNERS ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_PARTNERS ADD CONSTRAINT PK_INSPARTNERS PRIMARY KEY (ID, KF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint СС_INSPARTNERS_ACTIVE ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_PARTNERS ADD CONSTRAINT СС_INSPARTNERS_ACTIVE CHECK (active in (0, 1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_INSPARTNERS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_INSPARTNERS ON BARS.INS_PARTNERS (ID, KF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  INS_PARTNERS ***
grant SELECT                                                                 on INS_PARTNERS    to BARSREADER_ROLE;
grant SELECT                                                                 on INS_PARTNERS    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on INS_PARTNERS    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/INS_PARTNERS.sql =========*** End *** 
PROMPT ===================================================================================== 
