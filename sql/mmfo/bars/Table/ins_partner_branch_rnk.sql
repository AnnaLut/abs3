

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/INS_PARTNER_BRANCH_RNK.sql =========**
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to INS_PARTNER_BRANCH_RNK ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''INS_PARTNER_BRANCH_RNK'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''INS_PARTNER_BRANCH_RNK'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table INS_PARTNER_BRANCH_RNK ***
begin 
  execute immediate '
  CREATE TABLE BARS.INS_PARTNER_BRANCH_RNK 
   (	PARTNER_ID NUMBER, 
	BRANCH VARCHAR2(30), 
	RNK NUMBER, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to INS_PARTNER_BRANCH_RNK ***
 exec bpa.alter_policies('INS_PARTNER_BRANCH_RNK');


COMMENT ON TABLE BARS.INS_PARTNER_BRANCH_RNK IS '–Õ  —  Û ‚≥‰‰≥ÎÂÌÌˇı';
COMMENT ON COLUMN BARS.INS_PARTNER_BRANCH_RNK.PARTNER_ID IS '≤‰. — ';
COMMENT ON COLUMN BARS.INS_PARTNER_BRANCH_RNK.BRANCH IS ' Ó‰ ‚≥‰‰≥ÎÂÌÌˇ';
COMMENT ON COLUMN BARS.INS_PARTNER_BRANCH_RNK.RNK IS '–Õ  — ';
COMMENT ON COLUMN BARS.INS_PARTNER_BRANCH_RNK.KF IS '';




PROMPT *** Create  constraint PK_PTRBRANCHRNK ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_PARTNER_BRANCH_RNK ADD CONSTRAINT PK_PTRBRANCHRNK PRIMARY KEY (PARTNER_ID, BRANCH, KF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_PTRBRANCHRNK_PID_PARTNERS ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_PARTNER_BRANCH_RNK ADD CONSTRAINT FK_PTRBRANCHRNK_PID_PARTNERS FOREIGN KEY (PARTNER_ID, KF)
	  REFERENCES BARS.INS_PARTNERS (ID, KF) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PTRBRANCHRNK_RNK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_PARTNER_BRANCH_RNK MODIFY (RNK CONSTRAINT CC_PTRBRANCHRNK_RNK_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_PTRBRANCHRNK_B_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_PARTNER_BRANCH_RNK ADD CONSTRAINT FK_PTRBRANCHRNK_B_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_PTRBRANCHRNK_RNK_CUSTOMERS ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_PARTNER_BRANCH_RNK ADD CONSTRAINT FK_PTRBRANCHRNK_RNK_CUSTOMERS FOREIGN KEY (RNK)
	  REFERENCES BARS.CUSTOMER (RNK) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_PTRBRANCHRNK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_PTRBRANCHRNK ON BARS.INS_PARTNER_BRANCH_RNK (PARTNER_ID, BRANCH, KF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/INS_PARTNER_BRANCH_RNK.sql =========**
PROMPT ===================================================================================== 
