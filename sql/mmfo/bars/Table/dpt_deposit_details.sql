

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPT_DEPOSIT_DETAILS.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPT_DEPOSIT_DETAILS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPT_DEPOSIT_DETAILS'', ''CENTER'' , ''E'', ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''DPT_DEPOSIT_DETAILS'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''DPT_DEPOSIT_DETAILS'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPT_DEPOSIT_DETAILS ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPT_DEPOSIT_DETAILS 
   (	DPT_ID NUMBER(38,0), 
	DAT_TRANSFER_PF DATE, 
	RATE_OLD_ID NUMBER(38,0), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPT_DEPOSIT_DETAILS ***
 exec bpa.alter_policies('DPT_DEPOSIT_DETAILS');


COMMENT ON TABLE BARS.DPT_DEPOSIT_DETAILS IS 'Таблиця додаткових параметрів депозитів ФО';
COMMENT ON COLUMN BARS.DPT_DEPOSIT_DETAILS.DPT_ID IS '№ депозиту';
COMMENT ON COLUMN BARS.DPT_DEPOSIT_DETAILS.DAT_TRANSFER_PF IS 'Дата останнього зарахування на депозит від ПФ';
COMMENT ON COLUMN BARS.DPT_DEPOSIT_DETAILS.RATE_OLD_ID IS '';
COMMENT ON COLUMN BARS.DPT_DEPOSIT_DETAILS.KF IS '';




PROMPT *** Create  constraint PK_DPTDEPOSITDETAILS ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DEPOSIT_DETAILS ADD CONSTRAINT PK_DPTDEPOSITDETAILS PRIMARY KEY (DPT_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_DPTDEPOSITDETAILS ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DEPOSIT_DETAILS ADD CONSTRAINT UK_DPTDEPOSITDETAILS UNIQUE (DPT_ID, DAT_TRANSFER_PF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTDEPDETAILS__DPTID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DEPOSIT_DETAILS MODIFY (DPT_ID CONSTRAINT CC_DPTDEPDETAILS__DPTID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTDEPOSITDETAILS_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DEPOSIT_DETAILS MODIFY (KF CONSTRAINT CC_DPTDEPOSITDETAILS_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DPTDEPOSITDETAILS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DPTDEPOSITDETAILS ON BARS.DPT_DEPOSIT_DETAILS (DPT_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_DPTDEPOSITDETAILS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_DPTDEPOSITDETAILS ON BARS.DPT_DEPOSIT_DETAILS (DPT_ID, DAT_TRANSFER_PF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPT_DEPOSIT_DETAILS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_DEPOSIT_DETAILS to ABS_ADMIN;
grant SELECT                                                                 on DPT_DEPOSIT_DETAILS to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_DEPOSIT_DETAILS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPT_DEPOSIT_DETAILS to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_DEPOSIT_DETAILS to DPT_ADMIN;
grant SELECT                                                                 on DPT_DEPOSIT_DETAILS to START1;
grant SELECT                                                                 on DPT_DEPOSIT_DETAILS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPT_DEPOSIT_DETAILS.sql =========*** E
PROMPT ===================================================================================== 
