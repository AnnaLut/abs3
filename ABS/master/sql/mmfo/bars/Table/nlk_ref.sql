

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NLK_REF.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to NLK_REF ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NLK_REF'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''NLK_REF'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''NLK_REF'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NLK_REF ***
begin 
  execute immediate '
  CREATE TABLE BARS.NLK_REF 
   (	REF1 NUMBER(38,0), 
	REF2 NUMBER(38,0), 
	ACC NUMBER(38,0), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	REF2_STATE VARCHAR2(1), 
	ERR_TXT VARCHAR2(254), 
	AMOUNT NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

begin 
  execute immediate 


    ' ALTER TABLE BARS.NLK_REF ADD (AMOUNT NUMBER)';
exception when others then 
  if sqlcode=-1430 then null; else raise; end if;
end;
/



PROMPT *** ALTER_POLICIES to NLK_REF ***
 exec bpa.alter_policies('NLK_REF');


COMMENT ON TABLE BARS.NLK_REF IS 'Картотека кредитовых поступлений';
COMMENT ON COLUMN BARS.NLK_REF.REF1 IS 'Референс начального документа';
COMMENT ON COLUMN BARS.NLK_REF.REF2 IS 'Референс перекредитованного документа';
COMMENT ON COLUMN BARS.NLK_REF.ACC IS 'Идентификатор счета картотеки';
COMMENT ON COLUMN BARS.NLK_REF.KF IS '';
COMMENT ON COLUMN BARS.NLK_REF.REF2_STATE IS 'Состояние документа ref2: P - плановый, NULL - фактический.
Для ref2 is null всегда ref2_state is null';
COMMENT ON COLUMN BARS.NLK_REF.ERR_TXT IS '';
COMMENT ON COLUMN BARS.NLK_REF.AMOUNT IS 'Залишок суми картотеки по реф.';




PROMPT *** Create  constraint FK_NLKREF_ACCOUNTS2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.NLK_REF ADD CONSTRAINT FK_NLKREF_ACCOUNTS2 FOREIGN KEY (KF, ACC)
	  REFERENCES BARS.ACCOUNTS (KF, ACC) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_NLKREF_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.NLK_REF ADD CONSTRAINT FK_NLKREF_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006743 ***
begin   
 execute immediate '
  ALTER TABLE BARS.NLK_REF MODIFY (REF1 NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006744 ***
begin   
 execute immediate '
  ALTER TABLE BARS.NLK_REF MODIFY (ACC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_NLKREF_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NLK_REF MODIFY (KF CONSTRAINT CC_NLKREF_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_NLKREF ***
begin   
 execute immediate '
  ALTER TABLE BARS.NLK_REF ADD CONSTRAINT PK_NLKREF PRIMARY KEY (REF1)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_NLKREF_REF2STATE_CC ***
begin   
 execute immediate '
  ALTER TABLE BARS.NLK_REF ADD CONSTRAINT CC_NLKREF_REF2STATE_CC CHECK (ref2_state=''P'') ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_NLKREF ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_NLKREF ON BARS.NLK_REF (REF1) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I1_NLKREF ***
begin   
 execute immediate '
  CREATE INDEX BARS.I1_NLKREF ON BARS.NLK_REF (ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I2_NLKREF ***
begin   
 execute immediate '
  CREATE INDEX BARS.I2_NLKREF ON BARS.NLK_REF (CASE  WHEN REF2 IS NULL THEN ACC ELSE NULL END ) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I3_NLKREF ***
begin   
 execute immediate '
  CREATE INDEX BARS.I3_NLKREF ON BARS.NLK_REF (CASE REF2_STATE WHEN ''P'' THEN ACC ELSE NULL END ) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  NLK_REF ***
grant DELETE,INSERT,SELECT,UPDATE                                            on NLK_REF         to ABS_ADMIN;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on NLK_REF         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on NLK_REF         to BARS_DM;
grant DELETE,SELECT,UPDATE                                                   on NLK_REF         to PYOD001;
grant SELECT,UPDATE                                                          on NLK_REF         to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on NLK_REF         to WR_ALL_RIGHTS;
grant DELETE,SELECT,UPDATE                                                   on NLK_REF         to WR_DEPOSIT_U;
grant FLASHBACK,SELECT                                                       on NLK_REF         to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NLK_REF.sql =========*** End *** =====
PROMPT ===================================================================================== 
