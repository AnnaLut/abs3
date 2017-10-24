

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ND_ACC.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ND_ACC ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ND_ACC'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''ND_ACC'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''ND_ACC'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ND_ACC ***
begin 
  execute immediate '
  CREATE TABLE BARS.ND_ACC 
   (	ND NUMBER(38,0), 
	ACC NUMBER(38,0), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ND_ACC ***
 exec bpa.alter_policies('ND_ACC');


COMMENT ON TABLE BARS.ND_ACC IS 'Связка договоров и счетов';
COMMENT ON COLUMN BARS.ND_ACC.ND IS 'Номер договора';
COMMENT ON COLUMN BARS.ND_ACC.ACC IS 'Внутренний номер счета';
COMMENT ON COLUMN BARS.ND_ACC.KF IS '';




PROMPT *** Create  constraint FK_NDACC_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.ND_ACC ADD CONSTRAINT FK_NDACC_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_NDACC_ACCOUNTS2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ND_ACC ADD CONSTRAINT FK_NDACC_ACCOUNTS2 FOREIGN KEY (KF, ACC)
	  REFERENCES BARS.ACCOUNTS (KF, ACC) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_NDACC ***
begin   
 execute immediate '
  ALTER TABLE BARS.ND_ACC ADD CONSTRAINT PK_NDACC PRIMARY KEY (ND, ACC)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_NDACC_ND_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ND_ACC MODIFY (ND CONSTRAINT CC_NDACC_ND_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_NDACC_ACC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ND_ACC MODIFY (ACC CONSTRAINT CC_NDACC_ACC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_NDACC_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ND_ACC MODIFY (KF CONSTRAINT CC_NDACC_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_NDACC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_NDACC ON BARS.ND_ACC (KF, ND, ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_NDACC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_NDACC ON BARS.ND_ACC (ND, ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_ND_ACC ***
begin   
 execute immediate '
  CREATE INDEX BARS.UK_ND_ACC ON BARS.ND_ACC (ACC, ND) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ND_ACC ***
grant DELETE,INSERT,SELECT,UPDATE                                            on ND_ACC          to ABS_ADMIN;
grant SELECT                                                                 on ND_ACC          to BARSDWH_ACCESS_USER;
grant SELECT                                                                 on ND_ACC          to BARSUPL;
grant ALTER,DELETE,FLASHBACK,INSERT,SELECT,UPDATE                            on ND_ACC          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ND_ACC          to BARS_DM;
grant SELECT                                                                 on ND_ACC          to CC_DOC;
grant SELECT                                                                 on ND_ACC          to DPT;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on ND_ACC          to FOREX;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on ND_ACC          to RCC_DEAL;
grant SELECT                                                                 on ND_ACC          to RPBN001;
grant SELECT                                                                 on ND_ACC          to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on ND_ACC          to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on ND_ACC          to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ND_ACC.sql =========*** End *** ======
PROMPT ===================================================================================== 
