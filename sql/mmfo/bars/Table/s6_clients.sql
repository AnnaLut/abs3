

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/S6_Clients.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to S6_Clients ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''S6_Clients'', ''FILIAL'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table S6_Clients ***
begin 
  execute immediate '
  CREATE TABLE BARS.S6_Clients 
   (	BIC NUMBER(10,0), 
	GROUP_C NUMBER(3,0), 
	IdClient NUMBER(10,0), 
	TypeClient NUMBER(3,0), 
	IdCode VARCHAR2(10), 
	Name VARCHAR2(40), 
	KeySearch VARCHAR2(40), 
	FullName VARCHAR2(150), 
	Rezident NUMBER(3,0), 
	Insider NUMBER(3,0), 
	IdCountry NUMBER(5,0), 
	TinKey NUMBER(3,0), 
	D_Open DATE, 
	D_Close DATE, 
	ISP_OWNER NUMBER(5,0), 
	FormXoz NUMBER(5,0), 
	FormPrivat NUMBER(3,0), 
	Sector NUMBER(10,0), 
	Otrasl NUMBER(10,0), 
	VidEco NUMBER(10,0), 
	Ministry NUMBER(5,0), 
	CodNal NUMBER(5,0), 
	IdReg NUMBER(3,0), 
	IdNal NUMBER(3,0), 
	D_RegSa DATE, 
	D_RegSti DATE, 
	Budget NUMBER(3,0), 
	Fund NUMBER(16,2), 
	Working NUMBER(10,0), 
	NumberAdm VARCHAR2(20), 
	B010 VARCHAR2(10), 
	Sex NUMBER(3,0), 
	DateBirth DATE, 
	Description VARCHAR2(2000), 
	Address NUMBER(10,0), 
	D_Modify DATE, 
	IdCorpClient NUMBER(10,0), 
	IdCorpDepart NUMBER(10,0), 
	SmBusines NUMBER(3,0), 
	Doc_Modify NUMBER(10,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to S6_Clients ***
 exec bpa.alter_policies('S6_Clients');


COMMENT ON TABLE BARS.S6_Clients IS '';
COMMENT ON COLUMN BARS.S6_Clients.BIC IS '';
COMMENT ON COLUMN BARS.S6_Clients.GROUP_C IS '';
COMMENT ON COLUMN BARS.S6_Clients.IdClient IS '';
COMMENT ON COLUMN BARS.S6_Clients.TypeClient IS '';
COMMENT ON COLUMN BARS.S6_Clients.IdCode IS '';
COMMENT ON COLUMN BARS.S6_Clients.Name IS '';
COMMENT ON COLUMN BARS.S6_Clients.KeySearch IS '';
COMMENT ON COLUMN BARS.S6_Clients.FullName IS '';
COMMENT ON COLUMN BARS.S6_Clients.Rezident IS '';
COMMENT ON COLUMN BARS.S6_Clients.Insider IS '';
COMMENT ON COLUMN BARS.S6_Clients.IdCountry IS '';
COMMENT ON COLUMN BARS.S6_Clients.TinKey IS '';
COMMENT ON COLUMN BARS.S6_Clients.D_Open IS '';
COMMENT ON COLUMN BARS.S6_Clients.D_Close IS '';
COMMENT ON COLUMN BARS.S6_Clients.ISP_OWNER IS '';
COMMENT ON COLUMN BARS.S6_Clients.FormXoz IS '';
COMMENT ON COLUMN BARS.S6_Clients.FormPrivat IS '';
COMMENT ON COLUMN BARS.S6_Clients.Sector IS '';
COMMENT ON COLUMN BARS.S6_Clients.Otrasl IS '';
COMMENT ON COLUMN BARS.S6_Clients.VidEco IS '';
COMMENT ON COLUMN BARS.S6_Clients.Ministry IS '';
COMMENT ON COLUMN BARS.S6_Clients.CodNal IS '';
COMMENT ON COLUMN BARS.S6_Clients.IdReg IS '';
COMMENT ON COLUMN BARS.S6_Clients.IdNal IS '';
COMMENT ON COLUMN BARS.S6_Clients.D_RegSa IS '';
COMMENT ON COLUMN BARS.S6_Clients.D_RegSti IS '';
COMMENT ON COLUMN BARS.S6_Clients.Budget IS '';
COMMENT ON COLUMN BARS.S6_Clients.Fund IS '';
COMMENT ON COLUMN BARS.S6_Clients.Working IS '';
COMMENT ON COLUMN BARS.S6_Clients.NumberAdm IS '';
COMMENT ON COLUMN BARS.S6_Clients.B010 IS '';
COMMENT ON COLUMN BARS.S6_Clients.Sex IS '';
COMMENT ON COLUMN BARS.S6_Clients.DateBirth IS '';
COMMENT ON COLUMN BARS.S6_Clients.Description IS '';
COMMENT ON COLUMN BARS.S6_Clients.Address IS '';
COMMENT ON COLUMN BARS.S6_Clients.D_Modify IS '';
COMMENT ON COLUMN BARS.S6_Clients.IdCorpClient IS '';
COMMENT ON COLUMN BARS.S6_Clients.IdCorpDepart IS '';
COMMENT ON COLUMN BARS.S6_Clients.SmBusines IS '';
COMMENT ON COLUMN BARS.S6_Clients.Doc_Modify IS '';




PROMPT *** Create  constraint SYS_C008652 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_Clients MODIFY (BIC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008653 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_Clients MODIFY (GROUP_C NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008654 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_Clients MODIFY (IdClient NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008655 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_Clients MODIFY (TypeClient NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008656 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_Clients MODIFY (IdCode NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008657 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_Clients MODIFY (Name NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008658 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_Clients MODIFY (Rezident NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XIE_S6_Clients ***
begin   
 execute immediate '
  CREATE INDEX BARS.XIE_S6_Clients ON BARS.S6_Clients (IdClient, GROUP_C) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/S6_Clients.sql =========*** End *** ==
PROMPT ===================================================================================== 
