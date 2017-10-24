

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/S6_REG_C.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to S6_REG_C ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''S6_REG_C'', ''FILIAL'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table S6_REG_C ***
begin 
  execute immediate '
  CREATE TABLE BARS.S6_REG_C 
   (	ID NUMBER(3,0), 
	NAME VARCHAR2(80), 
	TypeClient NUMBER(3,0), 
	NameTempl CHAR(25), 
	KeySearch NUMBER(3,0), 
	FullName NUMBER(3,0), 
	Insider NUMBER(3,0), 
	IdCountry NUMBER(3,0), 
	TinKey NUMBER(3,0), 
	FormXoz NUMBER(3,0), 
	FormPrivat NUMBER(3,0), 
	Sector NUMBER(3,0), 
	Otrasl NUMBER(3,0), 
	VidEco NUMBER(3,0), 
	Ministry NUMBER(3,0), 
	CodNal NUMBER(3,0), 
	IdReg NUMBER(3,0), 
	IdNal NUMBER(3,0), 
	D_RegSa NUMBER(3,0), 
	D_RegSti NUMBER(3,0), 
	Budget NUMBER(3,0), 
	Fund NUMBER(3,0), 
	Working NUMBER(3,0), 
	NumberAdm NUMBER(3,0), 
	B010 NUMBER(3,0), 
	Sex NUMBER(3,0), 
	DateBirth NUMBER(3,0), 
	Description NUMBER(3,0), 
	DF__IdCode VARCHAR2(10), 
	DF__Rezident NUMBER(3,0), 
	DF__Insider NUMBER(3,0), 
	DF__IdCountry NUMBER(5,0), 
	DF__TinKey NUMBER(3,0), 
	DF__FormXoz NUMBER(5,0), 
	DF__FormPrivat NUMBER(3,0), 
	DF__Sector VARCHAR2(5), 
	DF__Otrasl NUMBER(10,0), 
	DF__VidEco NUMBER(10,0), 
	DF__Ministry NUMBER(5,0), 
	DF__CodNal NUMBER(5,0), 
	DF__IdReg NUMBER(3,0), 
	DF__IdNal NUMBER(3,0), 
	DF__Budget NUMBER(3,0), 
	DF__B010 VARCHAR2(10), 
	DF__IdCorpClient NUMBER(10,0), 
	DF__IdCorpDepart NUMBER(10,0), 
	IdCorpClient NUMBER(3,0), 
	IdCorpDepart NUMBER(3,0), 
	SmBusines NUMBER(3,0), 
	DF__SmBusines NUMBER(3,0), 
	Detail_Name NUMBER(3,0), 
	CliNumCode NUMBER(3,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to S6_REG_C ***
 exec bpa.alter_policies('S6_REG_C');


COMMENT ON TABLE BARS.S6_REG_C IS '';
COMMENT ON COLUMN BARS.S6_REG_C.IdReg IS '';
COMMENT ON COLUMN BARS.S6_REG_C.IdNal IS '';
COMMENT ON COLUMN BARS.S6_REG_C.D_RegSa IS '';
COMMENT ON COLUMN BARS.S6_REG_C.D_RegSti IS '';
COMMENT ON COLUMN BARS.S6_REG_C.Budget IS '';
COMMENT ON COLUMN BARS.S6_REG_C.Fund IS '';
COMMENT ON COLUMN BARS.S6_REG_C.Working IS '';
COMMENT ON COLUMN BARS.S6_REG_C.NumberAdm IS '';
COMMENT ON COLUMN BARS.S6_REG_C.B010 IS '';
COMMENT ON COLUMN BARS.S6_REG_C.Sex IS '';
COMMENT ON COLUMN BARS.S6_REG_C.DateBirth IS '';
COMMENT ON COLUMN BARS.S6_REG_C.Description IS '';
COMMENT ON COLUMN BARS.S6_REG_C.DF__IdCode IS '';
COMMENT ON COLUMN BARS.S6_REG_C.DF__Rezident IS '';
COMMENT ON COLUMN BARS.S6_REG_C.DF__Insider IS '';
COMMENT ON COLUMN BARS.S6_REG_C.DF__IdCountry IS '';
COMMENT ON COLUMN BARS.S6_REG_C.DF__TinKey IS '';
COMMENT ON COLUMN BARS.S6_REG_C.DF__FormXoz IS '';
COMMENT ON COLUMN BARS.S6_REG_C.DF__FormPrivat IS '';
COMMENT ON COLUMN BARS.S6_REG_C.DF__Sector IS '';
COMMENT ON COLUMN BARS.S6_REG_C.DF__Otrasl IS '';
COMMENT ON COLUMN BARS.S6_REG_C.DF__VidEco IS '';
COMMENT ON COLUMN BARS.S6_REG_C.DF__Ministry IS '';
COMMENT ON COLUMN BARS.S6_REG_C.DF__CodNal IS '';
COMMENT ON COLUMN BARS.S6_REG_C.DF__IdReg IS '';
COMMENT ON COLUMN BARS.S6_REG_C.DF__IdNal IS '';
COMMENT ON COLUMN BARS.S6_REG_C.DF__Budget IS '';
COMMENT ON COLUMN BARS.S6_REG_C.DF__B010 IS '';
COMMENT ON COLUMN BARS.S6_REG_C.DF__IdCorpClient IS '';
COMMENT ON COLUMN BARS.S6_REG_C.DF__IdCorpDepart IS '';
COMMENT ON COLUMN BARS.S6_REG_C.IdCorpClient IS '';
COMMENT ON COLUMN BARS.S6_REG_C.IdCorpDepart IS '';
COMMENT ON COLUMN BARS.S6_REG_C.SmBusines IS '';
COMMENT ON COLUMN BARS.S6_REG_C.DF__SmBusines IS '';
COMMENT ON COLUMN BARS.S6_REG_C.Detail_Name IS '';
COMMENT ON COLUMN BARS.S6_REG_C.CliNumCode IS '';
COMMENT ON COLUMN BARS.S6_REG_C.ID IS '';
COMMENT ON COLUMN BARS.S6_REG_C.NAME IS '';
COMMENT ON COLUMN BARS.S6_REG_C.TypeClient IS '';
COMMENT ON COLUMN BARS.S6_REG_C.NameTempl IS '';
COMMENT ON COLUMN BARS.S6_REG_C.KeySearch IS '';
COMMENT ON COLUMN BARS.S6_REG_C.FullName IS '';
COMMENT ON COLUMN BARS.S6_REG_C.Insider IS '';
COMMENT ON COLUMN BARS.S6_REG_C.IdCountry IS '';
COMMENT ON COLUMN BARS.S6_REG_C.TinKey IS '';
COMMENT ON COLUMN BARS.S6_REG_C.FormXoz IS '';
COMMENT ON COLUMN BARS.S6_REG_C.FormPrivat IS '';
COMMENT ON COLUMN BARS.S6_REG_C.Sector IS '';
COMMENT ON COLUMN BARS.S6_REG_C.Otrasl IS '';
COMMENT ON COLUMN BARS.S6_REG_C.VidEco IS '';
COMMENT ON COLUMN BARS.S6_REG_C.Ministry IS '';
COMMENT ON COLUMN BARS.S6_REG_C.CodNal IS '';




PROMPT *** Create  constraint SYS_C0097476 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_REG_C MODIFY (Detail_Name NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0097475 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_REG_C MODIFY (SmBusines NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0097474 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_REG_C MODIFY (IdCorpDepart NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0097473 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_REG_C MODIFY (IdCorpClient NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0097472 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_REG_C MODIFY (Description NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0097471 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_REG_C MODIFY (DateBirth NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0097470 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_REG_C MODIFY (Sex NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0097469 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_REG_C MODIFY (B010 NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0097468 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_REG_C MODIFY (NumberAdm NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0097467 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_REG_C MODIFY (Working NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0097466 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_REG_C MODIFY (Fund NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0097465 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_REG_C MODIFY (Budget NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0097464 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_REG_C MODIFY (D_RegSti NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0097463 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_REG_C MODIFY (D_RegSa NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0097462 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_REG_C MODIFY (IdNal NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0097461 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_REG_C MODIFY (IdReg NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0097460 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_REG_C MODIFY (CodNal NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0097459 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_REG_C MODIFY (Ministry NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0097458 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_REG_C MODIFY (VidEco NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0097457 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_REG_C MODIFY (Otrasl NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0097456 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_REG_C MODIFY (Sector NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0097455 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_REG_C MODIFY (FormPrivat NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0097454 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_REG_C MODIFY (FormXoz NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0097453 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_REG_C MODIFY (TinKey NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0097452 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_REG_C MODIFY (IdCountry NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0097451 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_REG_C MODIFY (Insider NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0097450 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_REG_C MODIFY (FullName NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0097449 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_REG_C MODIFY (KeySearch NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0097448 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_REG_C MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0097477 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_REG_C MODIFY (CliNumCode NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/S6_REG_C.sql =========*** End *** ====
PROMPT ===================================================================================== 
