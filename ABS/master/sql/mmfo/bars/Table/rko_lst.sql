

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/RKO_LST.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to RKO_LST ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''RKO_LST'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''RKO_LST'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''RKO_LST'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table RKO_LST ***
begin 
  execute immediate '
  CREATE TABLE BARS.RKO_LST 
   (	ACC NUMBER, 
	ACCD NUMBER, 
	DAT0A DATE, 
	DAT0B DATE, 
	S0 NUMBER DEFAULT 0, 
	DAT1A DATE, 
	DAT1B DATE, 
	ACC1 NUMBER, 
	DAT2A DATE, 
	DAT2B DATE, 
	ACC2 NUMBER, 
	COMM VARCHAR2(250), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	KOLDOK NUMBER(*,0) DEFAULT 0, 
	SUMDOK NUMBER(24,0) DEFAULT 0, 
	ND NUMBER, 
	CC_ID VARCHAR2(50), 
	SDATE DATE, 
	SOS NUMBER(*,0) DEFAULT 10
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to RKO_LST ***
 exec bpa.alter_policies('RKO_LST');


COMMENT ON TABLE BARS.RKO_LST IS '';
COMMENT ON COLUMN BARS.RKO_LST.ACC IS 'Рахунок нарахування';
COMMENT ON COLUMN BARS.RKO_LST.ACCD IS 'Рахунок стягнення';
COMMENT ON COLUMN BARS.RKO_LST.DAT0A IS 'Дата нарахування З';
COMMENT ON COLUMN BARS.RKO_LST.DAT0B IS 'Дата нарахування ПО';
COMMENT ON COLUMN BARS.RKO_LST.S0 IS 'Сума нарахування';
COMMENT ON COLUMN BARS.RKO_LST.DAT1A IS 'Дата боргу З';
COMMENT ON COLUMN BARS.RKO_LST.DAT1B IS 'Дата боргу ПО';
COMMENT ON COLUMN BARS.RKO_LST.ACC1 IS 'Рахунок боргу 3570';
COMMENT ON COLUMN BARS.RKO_LST.DAT2A IS 'Дата просроченого боргу З';
COMMENT ON COLUMN BARS.RKO_LST.DAT2B IS 'Дата просроченого боргу ПО';
COMMENT ON COLUMN BARS.RKO_LST.ACC2 IS 'Рахунок просроченого боргу 3579';
COMMENT ON COLUMN BARS.RKO_LST.COMM IS '';
COMMENT ON COLUMN BARS.RKO_LST.KF IS '';
COMMENT ON COLUMN BARS.RKO_LST.KOLDOK IS 'Количество документов';
COMMENT ON COLUMN BARS.RKO_LST.SUMDOK IS 'Сумма документов';
COMMENT ON COLUMN BARS.RKO_LST.ND IS 'Реф. договору';
COMMENT ON COLUMN BARS.RKO_LST.CC_ID IS 'Номер договору';
COMMENT ON COLUMN BARS.RKO_LST.SDATE IS 'Дата початку дії договору';
COMMENT ON COLUMN BARS.RKO_LST.SOS IS 'Стан договору';




PROMPT *** Create  constraint PK_RKO_LST ***
begin   
 execute immediate '
  ALTER TABLE BARS.RKO_LST ADD CONSTRAINT PK_RKO_LST PRIMARY KEY (ACC)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_RKO_LST_S0_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.RKO_LST MODIFY (S0 CONSTRAINT CC_RKO_LST_S0_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_RKOLST_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.RKO_LST MODIFY (KF CONSTRAINT CC_RKOLST_KF_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_RKO_LST_KOLDOK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.RKO_LST MODIFY (KOLDOK CONSTRAINT CC_RKO_LST_KOLDOK_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_RKO_LST_SUMDOK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.RKO_LST MODIFY (SUMDOK CONSTRAINT CC_RKO_LST_SUMDOK_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_RKOLST_SOS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.RKO_LST MODIFY (SOS CONSTRAINT CC_RKOLST_SOS_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_RKO_LST ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_RKO_LST ON BARS.RKO_LST (ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index IDX_RKOLST_ND_ACC1_ACC2 ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_RKOLST_ND_ACC1_ACC2 ON BARS.RKO_LST (ND, ACC1, ACC2) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  RKO_LST ***
grant SELECT                                                                 on RKO_LST         to BARSREADER_ROLE;
grant SELECT                                                                 on RKO_LST         to BARSUPL;
grant DELETE,INSERT,SELECT,UPDATE                                            on RKO_LST         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on RKO_LST         to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on RKO_LST         to RKO;
grant SELECT                                                                 on RKO_LST         to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on RKO_LST         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/RKO_LST.sql =========*** End *** =====
PROMPT ===================================================================================== 
