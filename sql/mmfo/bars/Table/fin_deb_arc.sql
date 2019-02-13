
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/FIN_DEB_ARC.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to FIN_DEB_ARC ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''FIN_DEB_ARC'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''FIN_DEB_ARC'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table FIN_DEB_ARC ***
begin 
  execute immediate '
  CREATE TABLE BARS.FIN_DEB_ARC 
   (	ACC_SS NUMBER(24,0), 
	ACC_SP NUMBER(24,0), 
	EFFECTDATE DATE DEFAULT nvl(to_date(sys_context(''bars_gl'',''bankdate''),''MM/DD/YYYY''),trunc(sysdate)), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	AGRM_ID NUMBER(38,0),
	MDAT DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

PROMPT *** ALTER_POLICIES to FIN_DEB_ARC ***
 exec bpa.alter_policies('FIN_DEB_ARC');

COMMENT ON TABLE  BARS.FIN_DEB_ARC IS 'Таблиця умовних "дог" по Фін/деб.';
COMMENT ON COLUMN BARS.FIN_DEB_ARC.AGRM_ID IS '';
COMMENT ON COLUMN BARS.FIN_DEB_ARC.KF IS 'Код фiлiалу (МФО)';
COMMENT ON COLUMN BARS.FIN_DEB_ARC.ACC_SS IS 'Рахунок нормального   тіла';
COMMENT ON COLUMN BARS.FIN_DEB_ARC.ACC_SP IS 'Рахунок простроченого тіла';
COMMENT ON COLUMN BARS.FIN_DEB_ARC.EFFECTDATE IS '';


begin
 execute immediate   'alter table FIN_DEB_ARC add (CHGDATE date ) ';
exception when others then
  -- ORA-01430: column being added already exists in table
  if SQLCODE = - 01430 then null;   else raise; end if; 
end;
/
COMMENT ON COLUMN FIN_DEB_ARC.CHGDATE  IS 'Дата формування';

PROMPT *** Create  constraint CC_PRVNFINDEB_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIN_DEB_ARC MODIFY (KF CONSTRAINT CC_FINDEBARC_KF_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/


PROMPT *** Create  constraint CC_FINDEBARC_EFFECTDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIN_DEB_ARC MODIFY (EFFECTDATE CONSTRAINT CC_FINDEBARC_EFFECTDATE_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

PROMPT *** Create  index IDX_FINDEBARC_CHGDATE_ACCSS ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_FINDEBARC_CHGDATE_ACCSS ON BARS.FIN_DEB_ARC (mdat, chgdate, ACC_SS) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

PROMPT *** Create  constraint CC_PRVNFINDEB_KF_NN ***
begin   
 execute immediate '
   ALTER TABLE BARS.FIN_DEB_ARC ADD (CONSTRAINT CC_FINDEBARC_ACCSS_NN       CHECK ("ACC_SS" IS NOT NULL)      ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2261 or sqlcode=-2264  then null; else raise; end if;
 end;
/

begin   
 execute immediate '
    alter table fin_deb_arc drop constraint UK_FINDEBARC_ACCSS cascade';
exception when others then
  if  sqlcode=-2443  then null; else raise; end if;
 end;
/

PROMPT *** Create  index UK_FINDEBARC_ACCSS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_FINDEBARC_ACCSS ON BARS.FIN_DEB_ARC (ACC_SS,mdat) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

PROMPT *** Create  index I1_FINDEBARC_ACCSP ***
begin   
 execute immediate '

  CREATE INDEX BARS.I1_FINDEBARC_ACCSP ON BARS.FIN_DEB_ARC (ACC_SP,mdat) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

PROMPT *** Create  grants  FIN_DEB_ARC ***
grant DELETE,INSERT,SELECT,UPDATE                                            on FIN_DEB_ARC     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on FIN_DEB_ARC     to START1;
grant SELECT                                                                 on FIN_DEB_ARC     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/FIN_DEB_ARC.sql =========*** End *** =
PROMPT ===================================================================================== 
