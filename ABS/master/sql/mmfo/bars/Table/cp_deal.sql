

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CP_DEAL.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CP_DEAL ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CP_DEAL'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CP_DEAL'', ''FILIAL'' , ''M'', ''M'', ''M'', ''E'');
               bpa.alter_policy_info(''CP_DEAL'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CP_DEAL ***
begin 
  execute immediate '
  CREATE TABLE BARS.CP_DEAL 
   (	ID NUMBER, 
	RYN NUMBER, 
	ACC NUMBER, 
	ACCD NUMBER, 
	ACCP NUMBER, 
	ACCR NUMBER, 
	ACCS NUMBER, 
	REF NUMBER, 
	ERAT NUMBER, 
	ACCR2 NUMBER, 
	ERATE NUMBER, 
	DAZS DATE, 
	REF_OLD NUMBER(*,0), 
	REF_NEW NUMBER(*,0), 
	OP NUMBER(*,0), 
	DAT_UG DATE, 
	PF NUMBER(*,0), 
	ACTIVE NUMBER(1,0) DEFAULT 0, 
	INITIAL_REF NUMBER(38,0), 
	DAT_BAY DATE, 
	ACCS5 NUMBER, 
	ACCS6 NUMBER, 
	ACCEXPN NUMBER, 
	ACCEXPR NUMBER, 
	ACCR3 NUMBER, 
	ACCUNREC NUMBER, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CP_DEAL ***
 exec bpa.alter_policies('CP_DEAL');


COMMENT ON TABLE BARS.CP_DEAL IS '';
COMMENT ON COLUMN BARS.CP_DEAL.ID IS 'Код ЦП';
COMMENT ON COLUMN BARS.CP_DEAL.RYN IS 'Код субпортфелю';
COMMENT ON COLUMN BARS.CP_DEAL.ACC IS 'ACC рахунку номіналу';
COMMENT ON COLUMN BARS.CP_DEAL.ACCD IS 'ACC рахунку дисконту';
COMMENT ON COLUMN BARS.CP_DEAL.ACCP IS 'ACC рахунку премії';
COMMENT ON COLUMN BARS.CP_DEAL.ACCR IS 'ACC рахунку купону R';
COMMENT ON COLUMN BARS.CP_DEAL.ACCS IS 'ACC рахунку переоцінки';
COMMENT ON COLUMN BARS.CP_DEAL.REF IS 'Референс угоди';
COMMENT ON COLUMN BARS.CP_DEAL.ERAT IS 'Реальная Эф.ст одного дня';
COMMENT ON COLUMN BARS.CP_DEAL.ACCR2 IS 'ACC рахунку купону R2';
COMMENT ON COLUMN BARS.CP_DEAL.ERATE IS 'Эталонная Эф.ст одного дня';
COMMENT ON COLUMN BARS.CP_DEAL.DAZS IS 'Дата закриття угоди';
COMMENT ON COLUMN BARS.CP_DEAL.REF_OLD IS '';
COMMENT ON COLUMN BARS.CP_DEAL.REF_NEW IS '';
COMMENT ON COLUMN BARS.CP_DEAL.OP IS 'Тип помещения (1 - покупка, 3 - перемещение)';
COMMENT ON COLUMN BARS.CP_DEAL.DAT_UG IS 'Дата заключения договора';
COMMENT ON COLUMN BARS.CP_DEAL.PF IS 'Код портфеля';
COMMENT ON COLUMN BARS.CP_DEAL.ACTIVE IS 'Ознака активності договору (0 - ні / 1 - так)';
COMMENT ON COLUMN BARS.CP_DEAL.INITIAL_REF IS 'Ідентифікатор первинного договору купівлі ЦП (лише для записів з OP = 3))';
COMMENT ON COLUMN BARS.CP_DEAL.DAT_BAY IS 'Дата придбання пакета';
COMMENT ON COLUMN BARS.CP_DEAL.ACCS5 IS 'НБУ.Доч.счет 5121.';
COMMENT ON COLUMN BARS.CP_DEAL.ACCS6 IS 'НБУ.Доч.счет 6300.';
COMMENT ON COLUMN BARS.CP_DEAL.ACCEXPN IS 'ACC Сч просрочки номинала';
COMMENT ON COLUMN BARS.CP_DEAL.ACCEXPR IS 'ACC Сч просрочки купона';
COMMENT ON COLUMN BARS.CP_DEAL.ACCR3 IS 'ACC Сч "кривого" купона R3';
COMMENT ON COLUMN BARS.CP_DEAL.ACCUNREC IS 'ACC Сч непризнанных доходов';
COMMENT ON COLUMN BARS.CP_DEAL.KF IS '';




PROMPT *** Create  constraint CC_CPDEAL_ACTIVE ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_DEAL ADD CONSTRAINT CC_CPDEAL_ACTIVE CHECK (ACTIVE in (-1,0,1,-2)) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CPDEAL_INITREF_REF ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_DEAL ADD CONSTRAINT CC_CPDEAL_INITREF_REF CHECK ( INITIAL_REF <> REF ) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CPDEAL_INITREF_OP ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_DEAL ADD CONSTRAINT CC_CPDEAL_INITREF_OP CHECK ( OP = NVL2(INITIAL_REF, 3, OP) ) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_CPDEAL_REF ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_DEAL ADD CONSTRAINT UK_CPDEAL_REF UNIQUE (REF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XPK_CP_ACC ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_DEAL ADD CONSTRAINT XPK_CP_ACC PRIMARY KEY (ACC)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C004841 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_DEAL MODIFY (ACC NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CPDEAL_ACTIVE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_DEAL MODIFY (ACTIVE CONSTRAINT CC_CPDEAL_ACTIVE_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CPDEAL_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_DEAL MODIFY (KF CONSTRAINT CC_CPDEAL_KF_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_CP_ACC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_CP_ACC ON BARS.CP_DEAL (ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_CPDEAL_REF ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_CPDEAL_REF ON BARS.CP_DEAL (REF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_CPDEAL ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_CPDEAL ON BARS.CP_DEAL (KF, REF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index IDXP_CPDEAL ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDXP_CPDEAL ON BARS.CP_DEAL (ACCP) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index IDXRYN_CPDEAL ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDXRYN_CPDEAL ON BARS.CP_DEAL (RYN) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index IDXID_CPDEAL ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDXID_CPDEAL ON BARS.CP_DEAL (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CP_DEAL ***
grant SELECT                                                                 on CP_DEAL         to BARSREADER_ROLE;
grant SELECT                                                                 on CP_DEAL         to BARSUPL;
grant DELETE,INSERT,SELECT,UPDATE                                            on CP_DEAL         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CP_DEAL         to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CP_DEAL         to CP_ROLE;
grant SELECT                                                                 on CP_DEAL         to RPBN001;
grant SELECT                                                                 on CP_DEAL         to RPBN002;
grant DELETE,INSERT,SELECT,UPDATE                                            on CP_DEAL         to START1;
grant SELECT                                                                 on CP_DEAL         to UPLD;



PROMPT *** Create SYNONYM  to CP_DEAL ***

  CREATE OR REPLACE PUBLIC SYNONYM CP_DEAL FOR BARS.CP_DEAL;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CP_DEAL.sql =========*** End *** =====
PROMPT ===================================================================================== 
