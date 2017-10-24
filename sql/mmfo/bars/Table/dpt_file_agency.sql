

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPT_FILE_AGENCY.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPT_FILE_AGENCY ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPT_FILE_AGENCY'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DPT_FILE_AGENCY'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPT_FILE_AGENCY ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPT_FILE_AGENCY 
   (	HEADER_ID NUMBER(38,0), 
	BRANCH VARCHAR2(30), 
	AGENCY_ID NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPT_FILE_AGENCY ***
 exec bpa.alter_policies('DPT_FILE_AGENCY');


COMMENT ON TABLE BARS.DPT_FILE_AGENCY IS 'Співставлення відділень та органів соц. захисту при прийомі файла';
COMMENT ON COLUMN BARS.DPT_FILE_AGENCY.HEADER_ID IS 'Код файла';
COMMENT ON COLUMN BARS.DPT_FILE_AGENCY.BRANCH IS 'Відділення';
COMMENT ON COLUMN BARS.DPT_FILE_AGENCY.AGENCY_ID IS 'Код органа соц. захисту';




PROMPT *** Create  constraint PK_DPTFILEAGENCY ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_FILE_AGENCY ADD CONSTRAINT PK_DPTFILEAGENCY PRIMARY KEY (HEADER_ID, BRANCH)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTFILEAGENCY_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_FILE_AGENCY ADD CONSTRAINT FK_DPTFILEAGENCY_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTFILEAGENCY_AGENCYID ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_FILE_AGENCY ADD CONSTRAINT FK_DPTFILEAGENCY_AGENCYID FOREIGN KEY (AGENCY_ID)
	  REFERENCES BARS.SOCIAL_AGENCY (AGENCY_ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTFILEAGENCY_HEADERID ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_FILE_AGENCY ADD CONSTRAINT FK_DPTFILEAGENCY_HEADERID FOREIGN KEY (HEADER_ID)
	  REFERENCES BARS.DPT_FILE_HEADER (HEADER_ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTFILEAGENCY_HEADERID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_FILE_AGENCY MODIFY (HEADER_ID CONSTRAINT CC_DPTFILEAGENCY_HEADERID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTFILEAGENCY_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_FILE_AGENCY MODIFY (BRANCH CONSTRAINT CC_DPTFILEAGENCY_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTFILEAGENCY_AGENCYID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_FILE_AGENCY MODIFY (AGENCY_ID CONSTRAINT CC_DPTFILEAGENCY_AGENCYID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DPTFILEAGENCY ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DPTFILEAGENCY ON BARS.DPT_FILE_AGENCY (HEADER_ID, BRANCH) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPT_FILE_AGENCY ***
grant INSERT,SELECT,UPDATE                                                   on DPT_FILE_AGENCY to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPT_FILE_AGENCY to BARS_DM;
grant INSERT,SELECT,UPDATE                                                   on DPT_FILE_AGENCY to DPT_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPT_FILE_AGENCY to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPT_FILE_AGENCY.sql =========*** End *
PROMPT ===================================================================================== 
