

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KD_888.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KD_888 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KD_888'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KD_888'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KD_888'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KD_888 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KD_888 
   (	RNK NUMBER(*,0), 
	OKLAD NUMBER(*,0), 
	PR_K NUMBER(5,2), 
	PR_D NUMBER(5,2), 
	KOL_OKL NUMBER(*,0), 
	TIP NUMBER(*,0), 
	S_PR NUMBER(*,0), 
	N_KART VARCHAR2(20), 
	INV NUMBER(*,0), 
	FIO1 VARCHAR2(100), 
	ACC1 NUMBER(*,0), 
	ACC2 NUMBER(*,0), 
	ACC7 NUMBER(*,0), 
	ACC6 NUMBER(*,0), 
	SBON VARCHAR2(19), 
	TEX_N CHAR(10), 
	NLS NUMBER(14,0), 
	DATPR DATE, 
	DATPR2 DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KD_888 ***
 exec bpa.alter_policies('KD_888');


COMMENT ON TABLE BARS.KD_888 IS '';
COMMENT ON COLUMN BARS.KD_888.RNK IS '';
COMMENT ON COLUMN BARS.KD_888.OKLAD IS '';
COMMENT ON COLUMN BARS.KD_888.PR_K IS '';
COMMENT ON COLUMN BARS.KD_888.PR_D IS '';
COMMENT ON COLUMN BARS.KD_888.KOL_OKL IS '';
COMMENT ON COLUMN BARS.KD_888.TIP IS '';
COMMENT ON COLUMN BARS.KD_888.S_PR IS '';
COMMENT ON COLUMN BARS.KD_888.N_KART IS '';
COMMENT ON COLUMN BARS.KD_888.INV IS '';
COMMENT ON COLUMN BARS.KD_888.FIO1 IS '';
COMMENT ON COLUMN BARS.KD_888.ACC1 IS '';
COMMENT ON COLUMN BARS.KD_888.ACC2 IS '';
COMMENT ON COLUMN BARS.KD_888.ACC7 IS '';
COMMENT ON COLUMN BARS.KD_888.ACC6 IS '';
COMMENT ON COLUMN BARS.KD_888.SBON IS '';
COMMENT ON COLUMN BARS.KD_888.TEX_N IS '';
COMMENT ON COLUMN BARS.KD_888.NLS IS '';
COMMENT ON COLUMN BARS.KD_888.DATPR IS '';
COMMENT ON COLUMN BARS.KD_888.DATPR2 IS '';




PROMPT *** Create  constraint SYS_C007382 ***
begin   
 execute immediate '
  ALTER TABLE BARS.KD_888 MODIFY (DATPR NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007383 ***
begin   
 execute immediate '
  ALTER TABLE BARS.KD_888 MODIFY (DATPR2 NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  KD_888 ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on KD_888          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KD_888          to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on KD_888          to KD_888;
grant FLASHBACK,SELECT                                                       on KD_888          to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KD_888.sql =========*** End *** ======
PROMPT ===================================================================================== 
