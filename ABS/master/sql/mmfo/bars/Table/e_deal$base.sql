

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/E_DEAL$BASE.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to E_DEAL$BASE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''E_DEAL$BASE'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''E_DEAL$BASE'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''E_DEAL$BASE'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table E_DEAL$BASE ***
begin 
  execute immediate '
  CREATE TABLE BARS.E_DEAL$BASE 
   (	ND NUMBER(*,0), 
	RNK NUMBER(*,0), 
	SOS NUMBER(*,0) DEFAULT 10, 
	CC_ID VARCHAR2(20), 
	SDATE DATE, 
	WDATE DATE, 
	USER_ID NUMBER(*,0), 
	SA NUMBER, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	ACC26 NUMBER(*,0), 
	ACC36 NUMBER(*,0), 
	ACCD NUMBER(*,0), 
	ACCP NUMBER(*,0), 
	NDI NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to E_DEAL$BASE ***
 exec bpa.alter_policies('E_DEAL$BASE');


COMMENT ON TABLE BARS.E_DEAL$BASE IS '';
COMMENT ON COLUMN BARS.E_DEAL$BASE.ND IS 'Реф. договора';
COMMENT ON COLUMN BARS.E_DEAL$BASE.RNK IS 'Рег № клиента';
COMMENT ON COLUMN BARS.E_DEAL$BASE.SOS IS 'Состояние дог';
COMMENT ON COLUMN BARS.E_DEAL$BASE.CC_ID IS 'Ид. договора';
COMMENT ON COLUMN BARS.E_DEAL$BASE.SDATE IS 'Дата дог.';
COMMENT ON COLUMN BARS.E_DEAL$BASE.WDATE IS 'Дата пред.расч.';
COMMENT ON COLUMN BARS.E_DEAL$BASE.USER_ID IS 'Код инспектора по дог';
COMMENT ON COLUMN BARS.E_DEAL$BASE.SA IS 'Расч.сумма абонплаты';
COMMENT ON COLUMN BARS.E_DEAL$BASE.KF IS '';
COMMENT ON COLUMN BARS.E_DEAL$BASE.ACC26 IS '';
COMMENT ON COLUMN BARS.E_DEAL$BASE.ACC36 IS '';
COMMENT ON COLUMN BARS.E_DEAL$BASE.ACCD IS '';
COMMENT ON COLUMN BARS.E_DEAL$BASE.ACCP IS '';
COMMENT ON COLUMN BARS.E_DEAL$BASE.NDI IS '“нґкальнґй реф дог по рах асс36';




PROMPT *** Create  constraint UK_EDEAL$BASE ***
begin   
 execute immediate '
  ALTER TABLE BARS.E_DEAL$BASE ADD CONSTRAINT UK_EDEAL$BASE UNIQUE (KF, ND)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XPK_E_DEAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.E_DEAL$BASE ADD CONSTRAINT XPK_E_DEAL PRIMARY KEY (ND)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_E_DEAL_ND ***
begin   
 execute immediate '
  ALTER TABLE BARS.E_DEAL$BASE MODIFY (ND CONSTRAINT NK_E_DEAL_ND NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_E_DEAL_RNK ***
begin   
 execute immediate '
  ALTER TABLE BARS.E_DEAL$BASE MODIFY (RNK CONSTRAINT NK_E_DEAL_RNK NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_EDEAL_SOS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.E_DEAL$BASE MODIFY (SOS CONSTRAINT CC_EDEAL_SOS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_EDEAL_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.E_DEAL$BASE MODIFY (KF CONSTRAINT CC_EDEAL_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_EDEAL_ACC26_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.E_DEAL$BASE MODIFY (ACC26 CONSTRAINT CC_EDEAL_ACC26_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_E_DEAL ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_E_DEAL ON BARS.E_DEAL$BASE (ND) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_EDEAL$BASE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_EDEAL$BASE ON BARS.E_DEAL$BASE (KF, ND) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  E_DEAL$BASE ***
grant SELECT                                                                 on E_DEAL$BASE     to BARSREADER_ROLE;
grant SELECT                                                                 on E_DEAL$BASE     to BARSUPL;
grant DELETE,INSERT,SELECT,UPDATE                                            on E_DEAL$BASE     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on E_DEAL$BASE     to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on E_DEAL$BASE     to ELT;
grant SELECT                                                                 on E_DEAL$BASE     to START1;
grant SELECT                                                                 on E_DEAL$BASE     to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on E_DEAL$BASE     to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/E_DEAL$BASE.sql =========*** End *** =
PROMPT ===================================================================================== 
