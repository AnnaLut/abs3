

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/PRVN_FIN_DEB_ARCH.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to PRVN_FIN_DEB_ARCH ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''PRVN_FIN_DEB_ARCH'', ''FILIAL'' , ''M'', ''M'', ''M'', ''E'');
               bpa.alter_policy_info(''PRVN_FIN_DEB_ARCH'', ''WHOLE'' , null, null, null, ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table PRVN_FIN_DEB_ARCH ***
begin 
  execute immediate '
  CREATE TABLE BARS.PRVN_FIN_DEB_ARCH 
   (	CHG_ID NUMBER(38,0), 
	CHG_DT DATE, 
	CLS_DT DATE, 
	KF VARCHAR2(6), 
	ACC_SS NUMBER(38,0), 
	ACC_SP NUMBER(38,0), 
	EFFECTDATE DATE, 
	AGRM_ID NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

PROMPT *** ALTER_POLICIES to PRVN_FIN_DEB_ARCH ***
 exec bpa.alter_policies('PRVN_FIN_DEB_ARCH');

COMMENT ON TABLE BARS.PRVN_FIN_DEB_ARCH IS 'Архів зв`язків рах. Фін.Деб.';
COMMENT ON COLUMN BARS.PRVN_FIN_DEB_ARCH.CHG_ID IS '';
COMMENT ON COLUMN BARS.PRVN_FIN_DEB_ARCH.CHG_DT IS 'Календарна дата/час перенесення в архів';
COMMENT ON COLUMN BARS.PRVN_FIN_DEB_ARCH.CLS_DT IS 'Банківська дата закриття (перенесення в архів)';
COMMENT ON COLUMN BARS.PRVN_FIN_DEB_ARCH.KF IS 'Код фiлiалу (МФО)';
COMMENT ON COLUMN BARS.PRVN_FIN_DEB_ARCH.ACC_SS IS 'Рахунок нормального   тіла Фін.Деб.';
COMMENT ON COLUMN BARS.PRVN_FIN_DEB_ARCH.ACC_SP IS 'Рахунок простроченого тіла Фін.Деб.';
COMMENT ON COLUMN BARS.PRVN_FIN_DEB_ARCH.EFFECTDATE IS '';
COMMENT ON COLUMN BARS.PRVN_FIN_DEB_ARCH.AGRM_ID IS 'Ід. кредитного договору';

PROMPT *** Create  constraint CC_PRVNFINDEBARCH_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PRVN_FIN_DEB_ARCH MODIFY (KF CONSTRAINT CC_PRVNFINDEBARCH_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

PROMPT *** Create  constraint CC_PRVNFINDEBARCH_ACCSS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PRVN_FIN_DEB_ARCH MODIFY (ACC_SS CONSTRAINT CC_PRVNFINDEBARCH_ACCSS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

PROMPT *** Create  constraint CC_PRVNFINDEBARCH_ACCSP_NN ***
begin   
 --execute immediate '
 -- ALTER TABLE BARS.PRVN_FIN_DEB_ARCH MODIFY (ACC_SP CONSTRAINT CC_PRVNFINDEBARCH_ACCSP_NN NOT NULL ENABLE)';
 execute immediate '
 ALTER TABLE BARS.PRVN_FIN_DEB_ARCH DROP CONSTRAINT CC_PRVNFINDEBARCH_ACCSP_NN';
exception when others then
  if  sqlcode=-02443 then null; else raise; end if;
  --ORA-02443: Cannot drop constraint  - nonexistent constraint
 end;
/

PROMPT *** Create  constraint CC_PRVNFINDEBARCH_EFFDT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PRVN_FIN_DEB_ARCH MODIFY (EFFECTDATE CONSTRAINT CC_PRVNFINDEBARCH_EFFDT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

PROMPT *** Create  constraint PK_PRVNFINDEBARCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.PRVN_FIN_DEB_ARCH ADD CONSTRAINT PK_PRVNFINDEBARCH PRIMARY KEY (CHG_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

PROMPT *** Create  constraint CC_PRVNFINDEBARCH_CHGID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PRVN_FIN_DEB_ARCH MODIFY (CHG_ID CONSTRAINT CC_PRVNFINDEBARCH_CHGID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

PROMPT *** Create  constraint CC_PRVNFINDEBARCH_CHGDT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PRVN_FIN_DEB_ARCH MODIFY (CHG_DT CONSTRAINT CC_PRVNFINDEBARCH_CHGDT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

PROMPT *** Create  constraint CC_PRVNFINDEBARCH_CLSDT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PRVN_FIN_DEB_ARCH MODIFY (CLS_DT CONSTRAINT CC_PRVNFINDEBARCH_CLSDT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

PROMPT *** Create  index PK_PRVNFINDEBARCH ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_PRVNFINDEBARCH ON BARS.PRVN_FIN_DEB_ARCH (CHG_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

PROMPT *** Create  index IDX_PRVNFINDEBARCH_CLSDT_KF ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_PRVNFINDEBARCH_CLSDT_KF ON BARS.PRVN_FIN_DEB_ARCH (CLS_DT, KF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

PROMPT *** Create  grants  PRVN_FIN_DEB_ARCH ***
grant SELECT                                                                 on PRVN_FIN_DEB_ARCH to BARSUPL;
grant SELECT                                                                 on PRVN_FIN_DEB_ARCH to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on PRVN_FIN_DEB_ARCH to UPLD;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/PRVN_FIN_DEB_ARCH.sql =========*** End
PROMPT ===================================================================================== 
