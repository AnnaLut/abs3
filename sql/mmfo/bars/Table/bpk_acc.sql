

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BPK_ACC.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BPK_ACC ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BPK_ACC'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''BPK_ACC'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''BPK_ACC'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BPK_ACC ***
begin 
  execute immediate '
  CREATE TABLE BARS.BPK_ACC 
   (	ACC_PK NUMBER(38,0), 
	ACC_OVR NUMBER(38,0), 
	ACC_9129 NUMBER(38,0), 
	ACC_TOVR NUMBER(38,0), 
	KF VARCHAR2(6) DEFAULT NULL, 
	ACC_3570 NUMBER(38,0), 
	ACC_2208 NUMBER(38,0), 
	ND NUMBER(38,0), 
	PRODUCT_ID NUMBER(38,0), 
	ACC_2207 NUMBER(38,0), 
	ACC_3579 NUMBER(38,0), 
	ACC_2209 NUMBER(38,0), 
	ACC_W4 NUMBER(22,0), 
	FIN NUMBER(*,0), 
	FIN23 NUMBER(*,0), 
	OBS23 NUMBER(*,0), 
	KAT23 NUMBER(*,0), 
	K23 NUMBER, 
	DAT_END DATE, 
	KOL_SP NUMBER, 
	S250 VARCHAR2(1), 
	GRP NUMBER(*,0), 
	DAT_CLOSE DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BPK_ACC ***
 exec bpa.alter_policies('BPK_ACC');


COMMENT ON TABLE BARS.BPK_ACC IS 'БПК. Таблица счетов';
COMMENT ON COLUMN BARS.BPK_ACC.DAT_CLOSE IS '';
COMMENT ON COLUMN BARS.BPK_ACC.ACC_PK IS 'Карточный счет 2625-ФЛ/2605-ЮЛ';
COMMENT ON COLUMN BARS.BPK_ACC.ACC_OVR IS 'Кред. БПК 2202(2203)-ФЛ/2062(2063)-ЮЛ';
COMMENT ON COLUMN BARS.BPK_ACC.ACC_9129 IS 'Неиспольз. лимит 9129';
COMMENT ON COLUMN BARS.BPK_ACC.ACC_TOVR IS 'Счет техн. овердрафта';
COMMENT ON COLUMN BARS.BPK_ACC.KF IS 'Код филиала';
COMMENT ON COLUMN BARS.BPK_ACC.ACC_3570 IS 'Счет комиссии';
COMMENT ON COLUMN BARS.BPK_ACC.ACC_2208 IS 'Счет проц.доходов за пользование кредитом 2208-ФЛ/2268-ЮЛ';
COMMENT ON COLUMN BARS.BPK_ACC.ND IS 'Номер договору';
COMMENT ON COLUMN BARS.BPK_ACC.PRODUCT_ID IS '';
COMMENT ON COLUMN BARS.BPK_ACC.ACC_2207 IS '';
COMMENT ON COLUMN BARS.BPK_ACC.ACC_3579 IS '';
COMMENT ON COLUMN BARS.BPK_ACC.ACC_2209 IS '';
COMMENT ON COLUMN BARS.BPK_ACC.ACC_W4 IS '';
COMMENT ON COLUMN BARS.BPK_ACC.FIN IS '';
COMMENT ON COLUMN BARS.BPK_ACC.FIN23 IS 'ФiнКлас по НБУ-23';
COMMENT ON COLUMN BARS.BPK_ACC.OBS23 IS 'Обсл.долга по НБУ-23';
COMMENT ON COLUMN BARS.BPK_ACC.KAT23 IS 'Категорiя якостi за кредитом по НБУ-23';
COMMENT ON COLUMN BARS.BPK_ACC.K23 IS 'Коеф.Показник ризику по НБУ-23';
COMMENT ON COLUMN BARS.BPK_ACC.DAT_END IS 'Дата закриття рах.2625 ACC_PK';
COMMENT ON COLUMN BARS.BPK_ACC.KOL_SP IS 'К-во дней просрочки по договору';
COMMENT ON COLUMN BARS.BPK_ACC.S250 IS 'Портфельный метод (8)';
COMMENT ON COLUMN BARS.BPK_ACC.GRP IS 'група активу портфельного методу';




PROMPT *** Create  constraint PK_BPKACC ***
begin   
 execute immediate '
  ALTER TABLE BARS.BPK_ACC ADD CONSTRAINT PK_BPKACC PRIMARY KEY (KF, ND)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK4_BPKACC ***
begin   
 execute immediate '
  ALTER TABLE BARS.BPK_ACC ADD CONSTRAINT UK4_BPKACC UNIQUE (ACC_3570)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK1_BPKACC ***
begin   
 execute immediate '
  ALTER TABLE BARS.BPK_ACC ADD CONSTRAINT UK1_BPKACC UNIQUE (ACC_PK)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_BPKACC ***
begin   
 execute immediate '
  ALTER TABLE BARS.BPK_ACC ADD CONSTRAINT UK_BPKACC UNIQUE (ACC_OVR)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK2_BPKACC ***
begin   
 execute immediate '
  ALTER TABLE BARS.BPK_ACC ADD CONSTRAINT UK2_BPKACC UNIQUE (ACC_9129)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK3_BPKACC ***
begin   
 execute immediate '
  ALTER TABLE BARS.BPK_ACC ADD CONSTRAINT UK3_BPKACC UNIQUE (ACC_TOVR)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK5_BPKACC ***
begin   
 execute immediate '
  ALTER TABLE BARS.BPK_ACC ADD CONSTRAINT UK5_BPKACC UNIQUE (ACC_2208)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK6_BPKACC ***
begin   
 execute immediate '
  ALTER TABLE BARS.BPK_ACC ADD CONSTRAINT UK6_BPKACC UNIQUE (ACC_2207)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK7_BPKACC ***
begin   
 execute immediate '
  ALTER TABLE BARS.BPK_ACC ADD CONSTRAINT UK7_BPKACC UNIQUE (ACC_3579)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK8_BPKACC ***
begin   
 execute immediate '
  ALTER TABLE BARS.BPK_ACC ADD CONSTRAINT UK8_BPKACC UNIQUE (ACC_2209)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BPKACC_ACC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BPK_ACC MODIFY (ACC_PK CONSTRAINT CC_BPKACC_ACC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_BPKACC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_BPKACC ON BARS.BPK_ACC (KF, ND) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_BPKACC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_BPKACC ON BARS.BPK_ACC (ACC_OVR) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK2_BPKACC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK2_BPKACC ON BARS.BPK_ACC (ACC_9129) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK3_BPKACC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK3_BPKACC ON BARS.BPK_ACC (ACC_TOVR) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK1_BPKACC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK1_BPKACC ON BARS.BPK_ACC (ACC_PK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK4_BPKACC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK4_BPKACC ON BARS.BPK_ACC (ACC_3570) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK5_BPKACC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK5_BPKACC ON BARS.BPK_ACC (ACC_2208) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK6_BPKACC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK6_BPKACC ON BARS.BPK_ACC (ACC_2207) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK7_BPKACC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK7_BPKACC ON BARS.BPK_ACC (ACC_3579) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK8_BPKACC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK8_BPKACC ON BARS.BPK_ACC (ACC_2209) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BPK_ACC ***
grant SELECT                                                                 on BPK_ACC         to BARSDWH_ACCESS_USER;
grant SELECT                                                                 on BPK_ACC         to BARSREADER_ROLE;
grant SELECT                                                                 on BPK_ACC         to BARSUPL;
grant INSERT,SELECT,UPDATE                                                   on BPK_ACC         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on BPK_ACC         to BARS_DM;
grant INSERT,SELECT,UPDATE                                                   on BPK_ACC         to OBPC;
grant SELECT                                                                 on BPK_ACC         to RPBN001;
grant SELECT                                                                 on BPK_ACC         to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on BPK_ACC         to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to BPK_ACC ***

  CREATE OR REPLACE PUBLIC SYNONYM BPK_ACC FOR BARS.BPK_ACC;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BPK_ACC.sql =========*** End *** =====
PROMPT ===================================================================================== 
