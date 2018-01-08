

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/S6_DOCUM.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to S6_DOCUM ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table S6_DOCUM ***
begin 
  execute immediate '
  CREATE TABLE BARS.S6_DOCUM 
   (	ID_OPER NUMBER(10,0), 
	ID_DOCUM NUMBER(3,0), 
	KB_A NUMBER(10,0), 
	KK_A VARCHAR2(25), 
	KB_B NUMBER(10,0), 
	KK_B VARCHAR2(25), 
	D_K NUMBER(3,0), 
	SUMMA NUMBER(16,2), 
	VID NUMBER(3,0), 
	SKO NUMBER(3,0), 
	ND VARCHAR2(10), 
	I_VA NUMBER(5,0), 
	DA_OD DATE, 
	DA DATE, 
	DA_DOC DATE, 
	NK_A VARCHAR2(80), 
	NK_B VARCHAR2(80), 
	NP VARCHAR2(160), 
	VS_REC VARCHAR2(60), 
	KOD_NP VARCHAR2(3), 
	KOD_A VARCHAR2(14), 
	KOD_B VARCHAR2(14), 
	NPACH NUMBER(5,0), 
	REE_COUNT NUMBER(3,0), 
	DB_S VARCHAR2(25), 
	KR_S VARCHAR2(25), 
	CUR_VS NUMBER(16,8), 
	GROUP_U NUMBER(10,0), 
	STATUS NUMBER(3,0), 
	NF_IN CHAR(12), 
	NPP_IN NUMBER(5,0), 
	ERR_IN CHAR(4), 
	SP_ZAP VARCHAR2(2), 
	NF_OUT CHAR(12), 
	NPP_OUT NUMBER(5,0), 
	ERR_OUT CHAR(4), 
	OPER_N NUMBER(9,0), 
	DA_FACT DATE, 
	PStatus NUMBER(3,0), 
	DA_MB DATE, 
	ISP_OWNER NUMBER(5,0), 
	ID_PARENT NUMBER(3,0), 
	ID_RULE NUMBER(10,0), 
	TAG NUMBER(5,0), 
	DA_REC DATE, 
	NO_ARX NUMBER(3,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to S6_DOCUM ***
 exec bpa.alter_policies('S6_DOCUM');


COMMENT ON TABLE BARS.S6_DOCUM IS '';
COMMENT ON COLUMN BARS.S6_DOCUM.ID_OPER IS '';
COMMENT ON COLUMN BARS.S6_DOCUM.ID_DOCUM IS '';
COMMENT ON COLUMN BARS.S6_DOCUM.KB_A IS '';
COMMENT ON COLUMN BARS.S6_DOCUM.KK_A IS '';
COMMENT ON COLUMN BARS.S6_DOCUM.KB_B IS '';
COMMENT ON COLUMN BARS.S6_DOCUM.KK_B IS '';
COMMENT ON COLUMN BARS.S6_DOCUM.D_K IS '';
COMMENT ON COLUMN BARS.S6_DOCUM.SUMMA IS '';
COMMENT ON COLUMN BARS.S6_DOCUM.VID IS '';
COMMENT ON COLUMN BARS.S6_DOCUM.SKO IS '';
COMMENT ON COLUMN BARS.S6_DOCUM.ND IS '';
COMMENT ON COLUMN BARS.S6_DOCUM.I_VA IS '';
COMMENT ON COLUMN BARS.S6_DOCUM.DA_OD IS '';
COMMENT ON COLUMN BARS.S6_DOCUM.DA IS '';
COMMENT ON COLUMN BARS.S6_DOCUM.DA_DOC IS '';
COMMENT ON COLUMN BARS.S6_DOCUM.NK_A IS '';
COMMENT ON COLUMN BARS.S6_DOCUM.NK_B IS '';
COMMENT ON COLUMN BARS.S6_DOCUM.NP IS '';
COMMENT ON COLUMN BARS.S6_DOCUM.VS_REC IS '';
COMMENT ON COLUMN BARS.S6_DOCUM.KOD_NP IS '';
COMMENT ON COLUMN BARS.S6_DOCUM.KOD_A IS '';
COMMENT ON COLUMN BARS.S6_DOCUM.KOD_B IS '';
COMMENT ON COLUMN BARS.S6_DOCUM.NPACH IS '';
COMMENT ON COLUMN BARS.S6_DOCUM.REE_COUNT IS '';
COMMENT ON COLUMN BARS.S6_DOCUM.DB_S IS '';
COMMENT ON COLUMN BARS.S6_DOCUM.KR_S IS '';
COMMENT ON COLUMN BARS.S6_DOCUM.CUR_VS IS '';
COMMENT ON COLUMN BARS.S6_DOCUM.GROUP_U IS '';
COMMENT ON COLUMN BARS.S6_DOCUM.STATUS IS '';
COMMENT ON COLUMN BARS.S6_DOCUM.NF_IN IS '';
COMMENT ON COLUMN BARS.S6_DOCUM.NPP_IN IS '';
COMMENT ON COLUMN BARS.S6_DOCUM.ERR_IN IS '';
COMMENT ON COLUMN BARS.S6_DOCUM.SP_ZAP IS '';
COMMENT ON COLUMN BARS.S6_DOCUM.NF_OUT IS '';
COMMENT ON COLUMN BARS.S6_DOCUM.NPP_OUT IS '';
COMMENT ON COLUMN BARS.S6_DOCUM.ERR_OUT IS '';
COMMENT ON COLUMN BARS.S6_DOCUM.OPER_N IS '';
COMMENT ON COLUMN BARS.S6_DOCUM.DA_FACT IS '';
COMMENT ON COLUMN BARS.S6_DOCUM.PStatus IS '';
COMMENT ON COLUMN BARS.S6_DOCUM.DA_MB IS '';
COMMENT ON COLUMN BARS.S6_DOCUM.ISP_OWNER IS '';
COMMENT ON COLUMN BARS.S6_DOCUM.ID_PARENT IS '';
COMMENT ON COLUMN BARS.S6_DOCUM.ID_RULE IS '';
COMMENT ON COLUMN BARS.S6_DOCUM.TAG IS '';
COMMENT ON COLUMN BARS.S6_DOCUM.DA_REC IS '';
COMMENT ON COLUMN BARS.S6_DOCUM.NO_ARX IS '';




PROMPT *** Create  constraint SYS_C009794 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_DOCUM MODIFY (ID_OPER NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009795 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_DOCUM MODIFY (ID_DOCUM NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009805 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_DOCUM MODIFY (ID_PARENT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009804 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_DOCUM MODIFY (ISP_OWNER NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009803 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_DOCUM MODIFY (STATUS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009802 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_DOCUM MODIFY (GROUP_U NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009801 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_DOCUM MODIFY (CUR_VS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009800 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_DOCUM MODIFY (REE_COUNT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009799 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_DOCUM MODIFY (DA_OD NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009798 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_DOCUM MODIFY (I_VA NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009797 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_DOCUM MODIFY (SUMMA NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009796 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_DOCUM MODIFY (D_K NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XIE_S6_DOCUM ***
begin   
 execute immediate '
  CREATE INDEX BARS.XIE_S6_DOCUM ON BARS.S6_DOCUM (ID_OPER, DA_OD, ID_DOCUM) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  S6_DOCUM ***
grant DELETE,INSERT,SELECT,UPDATE                                            on S6_DOCUM        to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on S6_DOCUM        to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/S6_DOCUM.sql =========*** End *** ====
PROMPT ===================================================================================== 
