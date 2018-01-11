

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/PRVN_FIN_DEB.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to PRVN_FIN_DEB ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''PRVN_FIN_DEB'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''PRVN_FIN_DEB'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''PRVN_FIN_DEB'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table PRVN_FIN_DEB ***
begin 
  execute immediate '
  CREATE TABLE BARS.PRVN_FIN_DEB 
   (	ACC_SS NUMBER(24,0), 
	ACC_SP NUMBER(24,0), 
	EFFECTDATE DATE DEFAULT nvl(to_date(sys_context(''bars_gl'',''bankdate''),''MM/DD/YYYY''),trunc(sysdate)), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	AGRM_ID NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to PRVN_FIN_DEB ***
 exec bpa.alter_policies('PRVN_FIN_DEB');


COMMENT ON TABLE BARS.PRVN_FIN_DEB IS 'Таблиця умовних "дог" по Фін/деб.';
COMMENT ON COLUMN BARS.PRVN_FIN_DEB.AGRM_ID IS '';
COMMENT ON COLUMN BARS.PRVN_FIN_DEB.KF IS 'Код фiлiалу (МФО)';
COMMENT ON COLUMN BARS.PRVN_FIN_DEB.ACC_SS IS 'Рахунок нормального   тіла';
COMMENT ON COLUMN BARS.PRVN_FIN_DEB.ACC_SP IS 'Рахунок простроченого тіла';
COMMENT ON COLUMN BARS.PRVN_FIN_DEB.EFFECTDATE IS '';




PROMPT *** Create  constraint UK_PRVNFINDEB_ACCSS ***
begin   
 execute immediate '
  ALTER TABLE BARS.PRVN_FIN_DEB ADD CONSTRAINT UK_PRVNFINDEB_ACCSS UNIQUE (ACC_SS)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_PRVNFINDEB_ACCSP ***
begin   
 execute immediate '
  ALTER TABLE BARS.PRVN_FIN_DEB ADD CONSTRAINT UK_PRVNFINDEB_ACCSP UNIQUE (ACC_SP)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PRVNFINDEB_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PRVN_FIN_DEB MODIFY (KF CONSTRAINT CC_PRVNFINDEB_KF_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PRVNFINDEB_EFFECTDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PRVN_FIN_DEB MODIFY (EFFECTDATE CONSTRAINT CC_PRVNFINDEB_EFFECTDATE_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PRVNFINDEB_ACCSS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PRVN_FIN_DEB MODIFY (ACC_SS CONSTRAINT CC_PRVNFINDEB_ACCSS_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_PRVNFINDEB_ACCSS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_PRVNFINDEB_ACCSS ON BARS.PRVN_FIN_DEB (ACC_SS) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_PRVNFINDEB_ACCSP ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_PRVNFINDEB_ACCSP ON BARS.PRVN_FIN_DEB (ACC_SP) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index IDX_PRVNFINDEB_EFFECTDT_ACCSS ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_PRVNFINDEB_EFFECTDT_ACCSS ON BARS.PRVN_FIN_DEB (EFFECTDATE, ACC_SS) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  PRVN_FIN_DEB ***
grant SELECT                                                                 on PRVN_FIN_DEB    to BARSREADER_ROLE;
grant SELECT                                                                 on PRVN_FIN_DEB    to BARSUPL;
grant SELECT                                                                 on PRVN_FIN_DEB    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on PRVN_FIN_DEB    to BARS_DM;
grant SELECT                                                                 on PRVN_FIN_DEB    to START1;
grant SELECT                                                                 on PRVN_FIN_DEB    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/PRVN_FIN_DEB.sql =========*** End *** 
PROMPT ===================================================================================== 
