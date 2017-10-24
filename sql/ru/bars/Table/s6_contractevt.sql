

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/S6_ContractEVT.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to S6_ContractEVT ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table S6_ContractEVT ***
begin 
  execute immediate '
  CREATE TABLE BARS.S6_ContractEVT 
   (	Id NUMBER(10,0), 
	IdVid_CalendarEvent NUMBER(3,0), 
	BIC NUMBER(10,0), 
	IdContract VARCHAR2(40), 
	D_Open DATE, 
	D_Plan DATE, 
	D_Fact DATE, 
	Summa NUMBER(16,2), 
	DA_OD DATE, 
	ID_OPER NUMBER(10,0), 
	ID_DOCUM NUMBER(3,0), 
	IdDoc NUMBER(10,0), 
	IdMethod NUMBER(10,0), 
	ISP_Modify NUMBER(5,0), 
	D_Modify DATE, 
	Description VARCHAR2(240), 
	I_VA NUMBER(5,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to S6_ContractEVT ***
 exec bpa.alter_policies('S6_ContractEVT');


COMMENT ON TABLE BARS.S6_ContractEVT IS '';
COMMENT ON COLUMN BARS.S6_ContractEVT.Id IS '';
COMMENT ON COLUMN BARS.S6_ContractEVT.IdVid_CalendarEvent IS '';
COMMENT ON COLUMN BARS.S6_ContractEVT.BIC IS '';
COMMENT ON COLUMN BARS.S6_ContractEVT.IdContract IS '';
COMMENT ON COLUMN BARS.S6_ContractEVT.D_Open IS '';
COMMENT ON COLUMN BARS.S6_ContractEVT.D_Plan IS '';
COMMENT ON COLUMN BARS.S6_ContractEVT.D_Fact IS '';
COMMENT ON COLUMN BARS.S6_ContractEVT.Summa IS '';
COMMENT ON COLUMN BARS.S6_ContractEVT.DA_OD IS '';
COMMENT ON COLUMN BARS.S6_ContractEVT.ID_OPER IS '';
COMMENT ON COLUMN BARS.S6_ContractEVT.ID_DOCUM IS '';
COMMENT ON COLUMN BARS.S6_ContractEVT.IdDoc IS '';
COMMENT ON COLUMN BARS.S6_ContractEVT.IdMethod IS '';
COMMENT ON COLUMN BARS.S6_ContractEVT.ISP_Modify IS '';
COMMENT ON COLUMN BARS.S6_ContractEVT.D_Modify IS '';
COMMENT ON COLUMN BARS.S6_ContractEVT.Description IS '';
COMMENT ON COLUMN BARS.S6_ContractEVT.I_VA IS '';




PROMPT *** Create  constraint SYS_C0097547 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_ContractEVT MODIFY (D_Modify NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0097546 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_ContractEVT MODIFY (ISP_Modify NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0097545 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_ContractEVT MODIFY (D_Open NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0097544 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_ContractEVT MODIFY (IdContract NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0097543 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_ContractEVT MODIFY (BIC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0097542 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_ContractEVT MODIFY (IdVid_CalendarEvent NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0097541 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_ContractEVT MODIFY (Id NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XIE_S6_ContractEVT_Id ***
begin   
 execute immediate '
  CREATE INDEX BARS.XIE_S6_ContractEVT_Id ON BARS.S6_ContractEVT (IdContract) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/S6_ContractEVT.sql =========*** End **
PROMPT ===================================================================================== 
