

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SOCIAL_AGENCY_MIGR.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SOCIAL_AGENCY_MIGR ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SOCIAL_AGENCY_MIGR'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SOCIAL_AGENCY_MIGR'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SOCIAL_AGENCY_MIGR ***
begin 
  execute immediate '
  CREATE TABLE BARS.SOCIAL_AGENCY_MIGR 
   (	ND NUMBER(38,0), 
	NAME VARCHAR2(100), 
	CREDIT VARCHAR2(15), 
	CARD VARCHAR2(15), 
	DEBIT VARCHAR2(15), 
	COMISS VARCHAR2(15), 
	AGENCYID NUMBER(38,0), 
	BRANCH VARCHAR2(30)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SOCIAL_AGENCY_MIGR ***
 exec bpa.alter_policies('SOCIAL_AGENCY_MIGR');


COMMENT ON TABLE BARS.SOCIAL_AGENCY_MIGR IS '';
COMMENT ON COLUMN BARS.SOCIAL_AGENCY_MIGR.ND IS '';
COMMENT ON COLUMN BARS.SOCIAL_AGENCY_MIGR.NAME IS '';
COMMENT ON COLUMN BARS.SOCIAL_AGENCY_MIGR.CREDIT IS '';
COMMENT ON COLUMN BARS.SOCIAL_AGENCY_MIGR.CARD IS '';
COMMENT ON COLUMN BARS.SOCIAL_AGENCY_MIGR.DEBIT IS '';
COMMENT ON COLUMN BARS.SOCIAL_AGENCY_MIGR.COMISS IS '';
COMMENT ON COLUMN BARS.SOCIAL_AGENCY_MIGR.AGENCYID IS '';
COMMENT ON COLUMN BARS.SOCIAL_AGENCY_MIGR.BRANCH IS '';




PROMPT *** Create  constraint SOCIAL_AGENCY_MIGR_PK ***
begin   
 execute immediate '
  ALTER TABLE BARS.SOCIAL_AGENCY_MIGR ADD CONSTRAINT SOCIAL_AGENCY_MIGR_PK PRIMARY KEY (ND, BRANCH)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index SOCIAL_AGENCY_MIGR_PK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.SOCIAL_AGENCY_MIGR_PK ON BARS.SOCIAL_AGENCY_MIGR (ND, BRANCH) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SOCIAL_AGENCY_MIGR ***
grant DELETE,INSERT,SELECT,UPDATE                                            on SOCIAL_AGENCY_MIGR to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on SOCIAL_AGENCY_MIGR to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SOCIAL_AGENCY_MIGR to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SOCIAL_AGENCY_MIGR.sql =========*** En
PROMPT ===================================================================================== 
