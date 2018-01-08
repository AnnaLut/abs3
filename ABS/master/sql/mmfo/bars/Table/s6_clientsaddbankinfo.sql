

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/S6_ClientsAddBankInfo.sql =========***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to S6_ClientsAddBankInfo ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''S6_ClientsAddBankInfo'', ''FILIAL'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table S6_ClientsAddBankInfo ***
begin 
  execute immediate '
  CREATE TABLE BARS.S6_ClientsAddBankInfo 
   (	BIC NUMBER(10,0), 
	GROUP_C NUMBER(3,0), 
	IdClient NUMBER(10,0), 
	NumInfo NUMBER(3,0), 
	CodeBank VARCHAR2(40), 
	NameBank VARCHAR2(80), 
	Rezident NUMBER(3,0), 
	Account VARCHAR2(30), 
	NameAcc VARCHAR2(80), 
	I_VA NUMBER(5,0), 
	IdCode VARCHAR2(10), 
	D_Modify DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to S6_ClientsAddBankInfo ***
 exec bpa.alter_policies('S6_ClientsAddBankInfo');


COMMENT ON TABLE BARS.S6_ClientsAddBankInfo IS '';
COMMENT ON COLUMN BARS.S6_ClientsAddBankInfo.BIC IS '';
COMMENT ON COLUMN BARS.S6_ClientsAddBankInfo.GROUP_C IS '';
COMMENT ON COLUMN BARS.S6_ClientsAddBankInfo.IdClient IS '';
COMMENT ON COLUMN BARS.S6_ClientsAddBankInfo.NumInfo IS '';
COMMENT ON COLUMN BARS.S6_ClientsAddBankInfo.CodeBank IS '';
COMMENT ON COLUMN BARS.S6_ClientsAddBankInfo.NameBank IS '';
COMMENT ON COLUMN BARS.S6_ClientsAddBankInfo.Rezident IS '';
COMMENT ON COLUMN BARS.S6_ClientsAddBankInfo.Account IS '';
COMMENT ON COLUMN BARS.S6_ClientsAddBankInfo.NameAcc IS '';
COMMENT ON COLUMN BARS.S6_ClientsAddBankInfo.I_VA IS '';
COMMENT ON COLUMN BARS.S6_ClientsAddBankInfo.IdCode IS '';
COMMENT ON COLUMN BARS.S6_ClientsAddBankInfo.D_Modify IS '';




PROMPT *** Create  constraint SYS_C006763 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_ClientsAddBankInfo MODIFY (BIC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006764 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_ClientsAddBankInfo MODIFY (GROUP_C NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006765 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_ClientsAddBankInfo MODIFY (IdClient NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006766 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_ClientsAddBankInfo MODIFY (NumInfo NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/S6_ClientsAddBankInfo.sql =========***
PROMPT ===================================================================================== 
