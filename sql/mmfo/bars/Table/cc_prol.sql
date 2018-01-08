

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CC_PROL.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CC_PROL ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CC_PROL'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CC_PROL'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''CC_PROL'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CC_PROL ***
begin 
  execute immediate '
  CREATE TABLE BARS.CC_PROL 
   (	ND NUMBER(38,0), 
	FDAT DATE, 
	NPP NUMBER(*,0), 
	MDATE DATE, 
	TXT VARCHAR2(4000), 
	ACC NUMBER(38,0), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	DMDAT DATE, 
	PROL_TYPE NUMBER(1,0) DEFAULT 0
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CC_PROL ***
 exec bpa.alter_policies('CC_PROL');


COMMENT ON TABLE BARS.CC_PROL IS 'история пролонгаций сроков погашения';
COMMENT ON COLUMN BARS.CC_PROL.ND IS 'Реф КД';
COMMENT ON COLUMN BARS.CC_PROL.FDAT IS 'Дата изм';
COMMENT ON COLUMN BARS.CC_PROL.NPP IS '№ пп';
COMMENT ON COLUMN BARS.CC_PROL.MDATE IS 'Срок';
COMMENT ON COLUMN BARS.CC_PROL.TXT IS '';
COMMENT ON COLUMN BARS.CC_PROL.ACC IS '';
COMMENT ON COLUMN BARS.CC_PROL.KF IS '';
COMMENT ON COLUMN BARS.CC_PROL.DMDAT IS '';
COMMENT ON COLUMN BARS.CC_PROL.PROL_TYPE IS 'Тип пролонгації: 0 - зміна строку, 1 - зміна ставки, 2 - зміна ліміту.';




PROMPT *** Create  constraint PK_CCPROL ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_PROL ADD CONSTRAINT PK_CCPROL PRIMARY KEY (ND, FDAT, NPP)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CCPROL_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_PROL ADD CONSTRAINT FK_CCPROL_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CCPROL_ACCOUNTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_PROL ADD CONSTRAINT FK_CCPROL_ACCOUNTS FOREIGN KEY (KF, ACC)
	  REFERENCES BARS.ACCOUNTS (KF, ACC) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_CC_PROL_ND ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_PROL MODIFY (ND CONSTRAINT NK_CC_PROL_ND NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_CC_PROL_NPP ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_PROL MODIFY (NPP CONSTRAINT NK_CC_PROL_NPP NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CCPROL_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_PROL MODIFY (KF CONSTRAINT CC_CCPROL_KF_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CCPROL_PROLTYPE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_PROL MODIFY (PROL_TYPE CONSTRAINT CC_CCPROL_PROLTYPE_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CCPROL ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CCPROL ON BARS.CC_PROL (ND, FDAT, NPP) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CC_PROL ***
grant SELECT                                                                 on CC_PROL         to BARSDWH_ACCESS_USER;
grant SELECT                                                                 on CC_PROL         to BARSUPL;
grant DELETE,INSERT,SELECT,UPDATE                                            on CC_PROL         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CC_PROL         to BARS_DM;
grant SELECT                                                                 on CC_PROL         to FOREX;
grant DELETE,INSERT,SELECT,UPDATE                                            on CC_PROL         to RCC_DEAL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CC_PROL         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CC_PROL.sql =========*** End *** =====
PROMPT ===================================================================================== 
