

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/S6_DOCUM_Y_VIEW.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to S6_DOCUM_Y_VIEW ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table S6_DOCUM_Y_VIEW ***
begin 
  execute immediate '
  CREATE TABLE BARS.S6_DOCUM_Y_VIEW 
   (	ID_OPER NUMBER(10,0), 
	ID_DOCUM NUMBER(3,0), 
	KB_A NUMBER(10,0), 
	KK_A VARCHAR2(25), 
	KB_B NUMBER(10,0), 
	KK_B VARCHAR2(25), 
	D_K NUMBER(3,0), 
	SUMMA NUMBER(20,2), 
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
	CUR_VS NUMBER(26,8), 
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
	DA_REC DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to S6_DOCUM_Y_VIEW ***
 exec bpa.alter_policies('S6_DOCUM_Y_VIEW');


COMMENT ON TABLE BARS.S6_DOCUM_Y_VIEW IS '';
COMMENT ON COLUMN BARS.S6_DOCUM_Y_VIEW.ID_OPER IS '';
COMMENT ON COLUMN BARS.S6_DOCUM_Y_VIEW.ID_DOCUM IS '';
COMMENT ON COLUMN BARS.S6_DOCUM_Y_VIEW.KB_A IS '';
COMMENT ON COLUMN BARS.S6_DOCUM_Y_VIEW.KK_A IS '';
COMMENT ON COLUMN BARS.S6_DOCUM_Y_VIEW.KB_B IS '';
COMMENT ON COLUMN BARS.S6_DOCUM_Y_VIEW.KK_B IS '';
COMMENT ON COLUMN BARS.S6_DOCUM_Y_VIEW.D_K IS '';
COMMENT ON COLUMN BARS.S6_DOCUM_Y_VIEW.SUMMA IS '';
COMMENT ON COLUMN BARS.S6_DOCUM_Y_VIEW.VID IS '';
COMMENT ON COLUMN BARS.S6_DOCUM_Y_VIEW.SKO IS '';
COMMENT ON COLUMN BARS.S6_DOCUM_Y_VIEW.ND IS '';
COMMENT ON COLUMN BARS.S6_DOCUM_Y_VIEW.I_VA IS '';
COMMENT ON COLUMN BARS.S6_DOCUM_Y_VIEW.DA_OD IS '';
COMMENT ON COLUMN BARS.S6_DOCUM_Y_VIEW.DA IS '';
COMMENT ON COLUMN BARS.S6_DOCUM_Y_VIEW.DA_DOC IS '';
COMMENT ON COLUMN BARS.S6_DOCUM_Y_VIEW.NK_A IS '';
COMMENT ON COLUMN BARS.S6_DOCUM_Y_VIEW.NK_B IS '';
COMMENT ON COLUMN BARS.S6_DOCUM_Y_VIEW.NP IS '';
COMMENT ON COLUMN BARS.S6_DOCUM_Y_VIEW.VS_REC IS '';
COMMENT ON COLUMN BARS.S6_DOCUM_Y_VIEW.KOD_NP IS '';
COMMENT ON COLUMN BARS.S6_DOCUM_Y_VIEW.KOD_A IS '';
COMMENT ON COLUMN BARS.S6_DOCUM_Y_VIEW.KOD_B IS '';
COMMENT ON COLUMN BARS.S6_DOCUM_Y_VIEW.NPACH IS '';
COMMENT ON COLUMN BARS.S6_DOCUM_Y_VIEW.REE_COUNT IS '';
COMMENT ON COLUMN BARS.S6_DOCUM_Y_VIEW.DB_S IS '';
COMMENT ON COLUMN BARS.S6_DOCUM_Y_VIEW.KR_S IS '';
COMMENT ON COLUMN BARS.S6_DOCUM_Y_VIEW.CUR_VS IS '';
COMMENT ON COLUMN BARS.S6_DOCUM_Y_VIEW.GROUP_U IS '';
COMMENT ON COLUMN BARS.S6_DOCUM_Y_VIEW.STATUS IS '';
COMMENT ON COLUMN BARS.S6_DOCUM_Y_VIEW.NF_IN IS '';
COMMENT ON COLUMN BARS.S6_DOCUM_Y_VIEW.NPP_IN IS '';
COMMENT ON COLUMN BARS.S6_DOCUM_Y_VIEW.ERR_IN IS '';
COMMENT ON COLUMN BARS.S6_DOCUM_Y_VIEW.SP_ZAP IS '';
COMMENT ON COLUMN BARS.S6_DOCUM_Y_VIEW.NF_OUT IS '';
COMMENT ON COLUMN BARS.S6_DOCUM_Y_VIEW.NPP_OUT IS '';
COMMENT ON COLUMN BARS.S6_DOCUM_Y_VIEW.ERR_OUT IS '';
COMMENT ON COLUMN BARS.S6_DOCUM_Y_VIEW.OPER_N IS '';
COMMENT ON COLUMN BARS.S6_DOCUM_Y_VIEW.DA_FACT IS '';
COMMENT ON COLUMN BARS.S6_DOCUM_Y_VIEW.PStatus IS '';
COMMENT ON COLUMN BARS.S6_DOCUM_Y_VIEW.DA_MB IS '';
COMMENT ON COLUMN BARS.S6_DOCUM_Y_VIEW.ISP_OWNER IS '';
COMMENT ON COLUMN BARS.S6_DOCUM_Y_VIEW.ID_PARENT IS '';
COMMENT ON COLUMN BARS.S6_DOCUM_Y_VIEW.ID_RULE IS '';
COMMENT ON COLUMN BARS.S6_DOCUM_Y_VIEW.TAG IS '';
COMMENT ON COLUMN BARS.S6_DOCUM_Y_VIEW.DA_REC IS '';




PROMPT *** Create  constraint SYS_C008659 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_DOCUM_Y_VIEW MODIFY (ID_OPER NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008660 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_DOCUM_Y_VIEW MODIFY (ID_DOCUM NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008670 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_DOCUM_Y_VIEW MODIFY (ID_PARENT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008669 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_DOCUM_Y_VIEW MODIFY (ISP_OWNER NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008668 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_DOCUM_Y_VIEW MODIFY (STATUS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008667 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_DOCUM_Y_VIEW MODIFY (GROUP_U NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008666 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_DOCUM_Y_VIEW MODIFY (KR_S NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008665 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_DOCUM_Y_VIEW MODIFY (DB_S NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008664 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_DOCUM_Y_VIEW MODIFY (REE_COUNT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008663 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_DOCUM_Y_VIEW MODIFY (DA_OD NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008662 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_DOCUM_Y_VIEW MODIFY (I_VA NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008661 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_DOCUM_Y_VIEW MODIFY (D_K NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  S6_DOCUM_Y_VIEW ***
grant DELETE,INSERT,SELECT,UPDATE                                            on S6_DOCUM_Y_VIEW to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on S6_DOCUM_Y_VIEW to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on S6_DOCUM_Y_VIEW to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/S6_DOCUM_Y_VIEW.sql =========*** End *
PROMPT ===================================================================================== 
