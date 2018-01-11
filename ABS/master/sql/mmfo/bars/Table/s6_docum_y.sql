

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/S6_DOCUM_Y.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to S6_DOCUM_Y ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table S6_DOCUM_Y ***
begin 
  execute immediate '
  CREATE TABLE BARS.S6_DOCUM_Y 
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
	REF NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to S6_DOCUM_Y ***
 exec bpa.alter_policies('S6_DOCUM_Y');


COMMENT ON TABLE BARS.S6_DOCUM_Y IS '';
COMMENT ON COLUMN BARS.S6_DOCUM_Y.ID_OPER IS '';
COMMENT ON COLUMN BARS.S6_DOCUM_Y.ID_DOCUM IS '';
COMMENT ON COLUMN BARS.S6_DOCUM_Y.KB_A IS '';
COMMENT ON COLUMN BARS.S6_DOCUM_Y.KK_A IS '';
COMMENT ON COLUMN BARS.S6_DOCUM_Y.KB_B IS '';
COMMENT ON COLUMN BARS.S6_DOCUM_Y.KK_B IS '';
COMMENT ON COLUMN BARS.S6_DOCUM_Y.D_K IS '';
COMMENT ON COLUMN BARS.S6_DOCUM_Y.SUMMA IS '';
COMMENT ON COLUMN BARS.S6_DOCUM_Y.VID IS '';
COMMENT ON COLUMN BARS.S6_DOCUM_Y.SKO IS '';
COMMENT ON COLUMN BARS.S6_DOCUM_Y.ND IS '';
COMMENT ON COLUMN BARS.S6_DOCUM_Y.I_VA IS '';
COMMENT ON COLUMN BARS.S6_DOCUM_Y.DA_OD IS '';
COMMENT ON COLUMN BARS.S6_DOCUM_Y.DA IS '';
COMMENT ON COLUMN BARS.S6_DOCUM_Y.DA_DOC IS '';
COMMENT ON COLUMN BARS.S6_DOCUM_Y.NK_A IS '';
COMMENT ON COLUMN BARS.S6_DOCUM_Y.NK_B IS '';
COMMENT ON COLUMN BARS.S6_DOCUM_Y.NP IS '';
COMMENT ON COLUMN BARS.S6_DOCUM_Y.VS_REC IS '';
COMMENT ON COLUMN BARS.S6_DOCUM_Y.KOD_NP IS '';
COMMENT ON COLUMN BARS.S6_DOCUM_Y.KOD_A IS '';
COMMENT ON COLUMN BARS.S6_DOCUM_Y.KOD_B IS '';
COMMENT ON COLUMN BARS.S6_DOCUM_Y.NPACH IS '';
COMMENT ON COLUMN BARS.S6_DOCUM_Y.REE_COUNT IS '';
COMMENT ON COLUMN BARS.S6_DOCUM_Y.DB_S IS '';
COMMENT ON COLUMN BARS.S6_DOCUM_Y.KR_S IS '';
COMMENT ON COLUMN BARS.S6_DOCUM_Y.CUR_VS IS '';
COMMENT ON COLUMN BARS.S6_DOCUM_Y.GROUP_U IS '';
COMMENT ON COLUMN BARS.S6_DOCUM_Y.STATUS IS '';
COMMENT ON COLUMN BARS.S6_DOCUM_Y.NF_IN IS '';
COMMENT ON COLUMN BARS.S6_DOCUM_Y.NPP_IN IS '';
COMMENT ON COLUMN BARS.S6_DOCUM_Y.ERR_IN IS '';
COMMENT ON COLUMN BARS.S6_DOCUM_Y.SP_ZAP IS '';
COMMENT ON COLUMN BARS.S6_DOCUM_Y.NF_OUT IS '';
COMMENT ON COLUMN BARS.S6_DOCUM_Y.NPP_OUT IS '';
COMMENT ON COLUMN BARS.S6_DOCUM_Y.ERR_OUT IS '';
COMMENT ON COLUMN BARS.S6_DOCUM_Y.OPER_N IS '';
COMMENT ON COLUMN BARS.S6_DOCUM_Y.DA_FACT IS '';
COMMENT ON COLUMN BARS.S6_DOCUM_Y.PStatus IS '';
COMMENT ON COLUMN BARS.S6_DOCUM_Y.DA_MB IS '';
COMMENT ON COLUMN BARS.S6_DOCUM_Y.ISP_OWNER IS '';
COMMENT ON COLUMN BARS.S6_DOCUM_Y.ID_PARENT IS '';
COMMENT ON COLUMN BARS.S6_DOCUM_Y.ID_RULE IS '';
COMMENT ON COLUMN BARS.S6_DOCUM_Y.TAG IS '';
COMMENT ON COLUMN BARS.S6_DOCUM_Y.DA_REC IS '';
COMMENT ON COLUMN BARS.S6_DOCUM_Y.REF IS '';




PROMPT *** Create  constraint SYS_C008435 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_DOCUM_Y MODIFY (ID_OPER NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008436 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_DOCUM_Y MODIFY (ID_DOCUM NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008437 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_DOCUM_Y MODIFY (D_K NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008438 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_DOCUM_Y MODIFY (SUMMA NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008439 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_DOCUM_Y MODIFY (I_VA NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008440 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_DOCUM_Y MODIFY (DA_OD NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008441 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_DOCUM_Y MODIFY (REE_COUNT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008442 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_DOCUM_Y MODIFY (DB_S NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008443 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_DOCUM_Y MODIFY (KR_S NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008444 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_DOCUM_Y MODIFY (CUR_VS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008445 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_DOCUM_Y MODIFY (GROUP_U NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008446 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_DOCUM_Y MODIFY (STATUS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008447 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_DOCUM_Y MODIFY (ISP_OWNER NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008448 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_DOCUM_Y MODIFY (ID_PARENT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index I1_S6DY ***
begin   
 execute immediate '
  CREATE INDEX BARS.I1_S6DY ON BARS.S6_DOCUM_Y (DA_MB) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I2_S6DY ***
begin   
 execute immediate '
  CREATE INDEX BARS.I2_S6DY ON BARS.S6_DOCUM_Y (DA) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index XIE_S6_DOCUM_Y ***
begin   
 execute immediate '
  CREATE INDEX BARS.XIE_S6_DOCUM_Y ON BARS.S6_DOCUM_Y (ID_OPER, DA_OD, ID_DOCUM) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  S6_DOCUM_Y ***
grant SELECT                                                                 on S6_DOCUM_Y      to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on S6_DOCUM_Y      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on S6_DOCUM_Y      to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on S6_DOCUM_Y      to START1;
grant SELECT                                                                 on S6_DOCUM_Y      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/S6_DOCUM_Y.sql =========*** End *** ==
PROMPT ===================================================================================== 
