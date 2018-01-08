

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPT_IMMOBILE.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPT_IMMOBILE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPT_IMMOBILE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DPT_IMMOBILE'', ''FILIAL'' , null, ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''DPT_IMMOBILE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPT_IMMOBILE ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPT_IMMOBILE 
   (	DPT_ID NUMBER(38,0), 
	TRANSFER_REF NUMBER(38,0), 
	TRANSFER_DATE DATE, 
	TRANSFER_AUTHOR NUMBER(38,0), 
	BANK_DATE DATE, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPT_IMMOBILE ***
 exec bpa.alter_policies('DPT_IMMOBILE');


COMMENT ON TABLE BARS.DPT_IMMOBILE IS 'Депозитні договори перенесені в картотеку нерухомих';
COMMENT ON COLUMN BARS.DPT_IMMOBILE.DPT_ID IS 'Ідентифікатор депозитного договору';
COMMENT ON COLUMN BARS.DPT_IMMOBILE.TRANSFER_REF IS 'Референс документу перенесення коштів на рахунок нерухомих';
COMMENT ON COLUMN BARS.DPT_IMMOBILE.TRANSFER_DATE IS 'Календарна дата перенесення депозиту в нерухомі';
COMMENT ON COLUMN BARS.DPT_IMMOBILE.TRANSFER_AUTHOR IS 'Ідентифікатор користувача, що створив запит';
COMMENT ON COLUMN BARS.DPT_IMMOBILE.BANK_DATE IS 'Банківська дата перенесення депозиту в нерухомі';
COMMENT ON COLUMN BARS.DPT_IMMOBILE.KF IS '';




PROMPT *** Create  constraint PK_DPTIMMOBILE ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_IMMOBILE ADD CONSTRAINT PK_DPTIMMOBILE PRIMARY KEY (DPT_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTIMMOBILE_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_IMMOBILE ADD CONSTRAINT FK_DPTIMMOBILE_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTIMMOBILE_DPTID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_IMMOBILE MODIFY (DPT_ID CONSTRAINT CC_DPTIMMOBILE_DPTID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTIMMOBILE_TRANSFREF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_IMMOBILE MODIFY (TRANSFER_REF CONSTRAINT CC_DPTIMMOBILE_TRANSFREF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTIMMOBILE_TRANSFDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_IMMOBILE MODIFY (TRANSFER_DATE CONSTRAINT CC_DPTIMMOBILE_TRANSFDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTIMMOBILE_TRANSFAUTHOR_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_IMMOBILE MODIFY (TRANSFER_AUTHOR CONSTRAINT CC_DPTIMMOBILE_TRANSFAUTHOR_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTIMMOBILE_BANKDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_IMMOBILE MODIFY (BANK_DATE CONSTRAINT CC_DPTIMMOBILE_BANKDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTIMMOBILE_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_IMMOBILE MODIFY (KF CONSTRAINT CC_DPTIMMOBILE_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DPTIMMOBILE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DPTIMMOBILE ON BARS.DPT_IMMOBILE (DPT_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_DPTIMMOBILE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_DPTIMMOBILE ON BARS.DPT_IMMOBILE (TRANSFER_REF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPT_IMMOBILE ***
grant SELECT                                                                 on DPT_IMMOBILE    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPT_IMMOBILE    to BARS_DM;
grant SELECT                                                                 on DPT_IMMOBILE    to START1;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_IMMOBILE    to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPT_IMMOBILE.sql =========*** End *** 
PROMPT ===================================================================================== 
