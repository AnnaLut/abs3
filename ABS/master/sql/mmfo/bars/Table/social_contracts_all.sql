

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SOCIAL_CONTRACTS_ALL.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SOCIAL_CONTRACTS_ALL ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SOCIAL_CONTRACTS_ALL'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SOCIAL_CONTRACTS_ALL'', ''FILIAL'' , ''F'', ''F'', ''F'', ''F'');
               bpa.alter_policy_info(''SOCIAL_CONTRACTS_ALL'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SOCIAL_CONTRACTS_ALL ***
begin 
  execute immediate '
  CREATE TABLE BARS.SOCIAL_CONTRACTS_ALL 
   (	CONTRACT_ID NUMBER(38,0), 
	BRANCH VARCHAR2(30)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SOCIAL_CONTRACTS_ALL ***
 exec bpa.alter_policies('SOCIAL_CONTRACTS_ALL');


COMMENT ON TABLE BARS.SOCIAL_CONTRACTS_ALL IS 'Все социальные договора системы (в т.ч. архив)';
COMMENT ON COLUMN BARS.SOCIAL_CONTRACTS_ALL.CONTRACT_ID IS 'Идентификатор соц.договора';
COMMENT ON COLUMN BARS.SOCIAL_CONTRACTS_ALL.BRANCH IS 'Код подразделения';




PROMPT *** Create  constraint PK_SOCCONTRALL ***
begin   
 execute immediate '
  ALTER TABLE BARS.SOCIAL_CONTRACTS_ALL ADD CONSTRAINT PK_SOCCONTRALL PRIMARY KEY (CONTRACT_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SOCCONTRALL_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.SOCIAL_CONTRACTS_ALL ADD CONSTRAINT FK_SOCCONTRALL_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SOCCONTRALL_CONTRACTID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SOCIAL_CONTRACTS_ALL MODIFY (CONTRACT_ID CONSTRAINT CC_SOCCONTRALL_CONTRACTID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SOCCONTRALL_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SOCIAL_CONTRACTS_ALL MODIFY (BRANCH CONSTRAINT CC_SOCCONTRALL_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SOCCONTRALL ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SOCCONTRALL ON BARS.SOCIAL_CONTRACTS_ALL (CONTRACT_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SOCIAL_CONTRACTS_ALL ***
grant SELECT                                                                 on SOCIAL_CONTRACTS_ALL to BARS_DM;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SOCIAL_CONTRACTS_ALL to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SOCIAL_CONTRACTS_ALL.sql =========*** 
PROMPT ===================================================================================== 
