

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/S6_ContractPR.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to S6_ContractPR ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table S6_ContractPR ***
begin 
  execute immediate '
  CREATE TABLE BARS.S6_ContractPR 
   (	BIC NUMBER(10,0), 
	IdContract VARCHAR2(40), 
	VidContract NUMBER(5,0), 
	ID_SH NUMBER(5,0), 
	Percen NUMBER(16,8), 
	DA DATE, 
	NLS_6 VARCHAR2(25), 
	ISP_Modify NUMBER(5,0), 
	D_Modify DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to S6_ContractPR ***
 exec bpa.alter_policies('S6_ContractPR');


COMMENT ON TABLE BARS.S6_ContractPR IS '';
COMMENT ON COLUMN BARS.S6_ContractPR.BIC IS '';
COMMENT ON COLUMN BARS.S6_ContractPR.IdContract IS '';
COMMENT ON COLUMN BARS.S6_ContractPR.VidContract IS '';
COMMENT ON COLUMN BARS.S6_ContractPR.ID_SH IS '';
COMMENT ON COLUMN BARS.S6_ContractPR.Percen IS '';
COMMENT ON COLUMN BARS.S6_ContractPR.DA IS '';
COMMENT ON COLUMN BARS.S6_ContractPR.NLS_6 IS '';
COMMENT ON COLUMN BARS.S6_ContractPR.ISP_Modify IS '';
COMMENT ON COLUMN BARS.S6_ContractPR.D_Modify IS '';




PROMPT *** Create  constraint SYS_C0097836 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_ContractPR MODIFY (DA NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0097835 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_ContractPR MODIFY (Percen NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0097834 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_ContractPR MODIFY (ID_SH NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0097833 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_ContractPR MODIFY (VidContract NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0097832 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_ContractPR MODIFY (IdContract NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0097831 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_ContractPR MODIFY (BIC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XIE_S6_CONTRACTPR_ID ***
begin   
 execute immediate '
  CREATE INDEX BARS.XIE_S6_CONTRACTPR_ID ON BARS.S6_ContractPR (IdContract) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/S6_ContractPR.sql =========*** End ***
PROMPT ===================================================================================== 
