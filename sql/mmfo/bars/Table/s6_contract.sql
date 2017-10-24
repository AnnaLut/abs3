

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/S6_Contract.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to S6_Contract ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''S6_Contract'', ''FILIAL'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table S6_Contract ***
begin 
  execute immediate '
  CREATE TABLE BARS.S6_Contract 
   (	BIC NUMBER(10,0), 
	IdContract VARCHAR2(40), 
	VidContract NUMBER(5,0), 
	Target NUMBER(5,0), 
	ContrParent VARCHAR2(40), 
	StrPercen NUMBER(9,4), 
	D_OPEN DATE, 
	D_CLOSE DATE, 
	D_BEGIN DATE, 
	D_DIST DATE, 
	D_RETURN DATE, 
	D_CANCEL DATE, 
	D_Modify DATE, 
	SUMMA NUMBER(16,2), 
	I_VA NUMBER(5,0), 
	IdClient NUMBER(10,0), 
	VID_KRED NUMBER(3,0), 
	V_MAIN NUMBER(3,0), 
	N_PROLONG NUMBER(5,0), 
	C_RISK NUMBER(3,0), 
	EMITENT NUMBER(3,0), 
	EMIS NUMBER(3,0), 
	PAPER NUMBER(3,0), 
	QUOT NUMBER(3,0), 
	TERM CHAR(1), 
	T_KR NUMBER(3,0), 
	PROLONG CHAR(1), 
	SOURCE NUMBER(3,0), 
	PerRep NUMBER(3,0), 
	N_APPL VARCHAR2(20), 
	D_APPL DATE, 
	N_DCC VARCHAR2(20), 
	D_DCC DATE, 
	Description VARCHAR2(150), 
	ISP_OWNER NUMBER(5,0), 
	GROUP_C NUMBER(3,0), 
	STATUS NUMBER(3,0), 
	ISP_Modify NUMBER(5,0), 
	Doc_Modify NUMBER(10,0), 
	JuridNumber VARCHAR2(40), 
	MethodCI NUMBER(3,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to S6_Contract ***
 exec bpa.alter_policies('S6_Contract');


COMMENT ON TABLE BARS.S6_Contract IS '';
COMMENT ON COLUMN BARS.S6_Contract.BIC IS '';
COMMENT ON COLUMN BARS.S6_Contract.IdContract IS '';
COMMENT ON COLUMN BARS.S6_Contract.VidContract IS '';
COMMENT ON COLUMN BARS.S6_Contract.Target IS '';
COMMENT ON COLUMN BARS.S6_Contract.ContrParent IS '';
COMMENT ON COLUMN BARS.S6_Contract.StrPercen IS '';
COMMENT ON COLUMN BARS.S6_Contract.D_OPEN IS '';
COMMENT ON COLUMN BARS.S6_Contract.D_CLOSE IS '';
COMMENT ON COLUMN BARS.S6_Contract.D_BEGIN IS '';
COMMENT ON COLUMN BARS.S6_Contract.D_DIST IS '';
COMMENT ON COLUMN BARS.S6_Contract.D_RETURN IS '';
COMMENT ON COLUMN BARS.S6_Contract.D_CANCEL IS '';
COMMENT ON COLUMN BARS.S6_Contract.D_Modify IS '';
COMMENT ON COLUMN BARS.S6_Contract.SUMMA IS '';
COMMENT ON COLUMN BARS.S6_Contract.I_VA IS '';
COMMENT ON COLUMN BARS.S6_Contract.IdClient IS '';
COMMENT ON COLUMN BARS.S6_Contract.VID_KRED IS '';
COMMENT ON COLUMN BARS.S6_Contract.V_MAIN IS '';
COMMENT ON COLUMN BARS.S6_Contract.N_PROLONG IS '';
COMMENT ON COLUMN BARS.S6_Contract.C_RISK IS '';
COMMENT ON COLUMN BARS.S6_Contract.EMITENT IS '';
COMMENT ON COLUMN BARS.S6_Contract.EMIS IS '';
COMMENT ON COLUMN BARS.S6_Contract.PAPER IS '';
COMMENT ON COLUMN BARS.S6_Contract.QUOT IS '';
COMMENT ON COLUMN BARS.S6_Contract.TERM IS '';
COMMENT ON COLUMN BARS.S6_Contract.T_KR IS '';
COMMENT ON COLUMN BARS.S6_Contract.PROLONG IS '';
COMMENT ON COLUMN BARS.S6_Contract.SOURCE IS '';
COMMENT ON COLUMN BARS.S6_Contract.PerRep IS '';
COMMENT ON COLUMN BARS.S6_Contract.N_APPL IS '';
COMMENT ON COLUMN BARS.S6_Contract.D_APPL IS '';
COMMENT ON COLUMN BARS.S6_Contract.N_DCC IS '';
COMMENT ON COLUMN BARS.S6_Contract.D_DCC IS '';
COMMENT ON COLUMN BARS.S6_Contract.Description IS '';
COMMENT ON COLUMN BARS.S6_Contract.ISP_OWNER IS '';
COMMENT ON COLUMN BARS.S6_Contract.GROUP_C IS '';
COMMENT ON COLUMN BARS.S6_Contract.STATUS IS '';
COMMENT ON COLUMN BARS.S6_Contract.ISP_Modify IS '';
COMMENT ON COLUMN BARS.S6_Contract.Doc_Modify IS '';
COMMENT ON COLUMN BARS.S6_Contract.JuridNumber IS '';
COMMENT ON COLUMN BARS.S6_Contract.MethodCI IS '';




PROMPT *** Create  constraint SYS_C007968 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_Contract MODIFY (BIC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007969 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_Contract MODIFY (IdContract NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007970 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_Contract MODIFY (VidContract NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007971 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_Contract MODIFY (IdClient NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007972 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_Contract MODIFY (GROUP_C NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007973 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_Contract MODIFY (STATUS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XIE_S6_Contract ***
begin   
 execute immediate '
  CREATE INDEX BARS.XIE_S6_Contract ON BARS.S6_Contract (IdClient, GROUP_C) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  S6_Contract ***
grant SELECT                                                                 on S6_Contract     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on S6_Contract     to RPBN002;



PROMPT *** Create SYNONYM  to S6_Contract ***

  CREATE OR REPLACE PUBLIC SYNONYM S6_Contract FOR BARS.S6_Contract;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/S6_Contract.sql =========*** End *** =
PROMPT ===================================================================================== 
