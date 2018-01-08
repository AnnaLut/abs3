

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SB_PARA.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SB_PARA ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SB_PARA'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SB_PARA'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SB_PARA'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SB_PARA ***
begin 
  execute immediate '
  CREATE TABLE BARS.SB_PARA 
   (	NLS_SP NUMBER(14,0), 
	I_VA_SP NUMBER(*,0), 
	R011 CHAR(1), 
	R013 CHAR(1), 
	S230 CHAR(3), 
	K120 CHAR(3), 
	S180 NUMBER(*,0), 
	START_DAT DATE, 
	END_DAT DATE, 
	FIRST_DAT DATE, 
	VID_KRE NUMBER(*,0), 
	OBESP NUMBER(*,0), 
	RISK NUMBER(*,0), 
	TARGET NUMBER(*,0), 
	K_PROLONA NUMBER(*,0), 
	EMITENT NUMBER(*,0), 
	COUNTRY NUMBER(*,0), 
	S120 CHAR(1), 
	BIRGA NUMBER(*,0), 
	VID_CB CHAR(1), 
	NLS_PRO CHAR(4), 
	KOD_PRO NUMBER(*,0), 
	NLG_DEC VARCHAR2(35), 
	PR_DBS NUMBER(14,0), 
	PR_KRS NUMBER(14,0), 
	RS_DBS NUMBER(14,0), 
	RS_KRS NUMBER(14,0), 
	P080 CHAR(4), 
	OB22 CHAR(2), 
	MFO CHAR(6), 
	R020_FA CHAR(4)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SB_PARA ***
 exec bpa.alter_policies('SB_PARA');


COMMENT ON TABLE BARS.SB_PARA IS '';
COMMENT ON COLUMN BARS.SB_PARA.NLS_SP IS '';
COMMENT ON COLUMN BARS.SB_PARA.I_VA_SP IS '';
COMMENT ON COLUMN BARS.SB_PARA.R011 IS '';
COMMENT ON COLUMN BARS.SB_PARA.R013 IS '';
COMMENT ON COLUMN BARS.SB_PARA.S230 IS '';
COMMENT ON COLUMN BARS.SB_PARA.K120 IS '';
COMMENT ON COLUMN BARS.SB_PARA.S180 IS '';
COMMENT ON COLUMN BARS.SB_PARA.START_DAT IS '';
COMMENT ON COLUMN BARS.SB_PARA.END_DAT IS '';
COMMENT ON COLUMN BARS.SB_PARA.FIRST_DAT IS '';
COMMENT ON COLUMN BARS.SB_PARA.VID_KRE IS '';
COMMENT ON COLUMN BARS.SB_PARA.OBESP IS '';
COMMENT ON COLUMN BARS.SB_PARA.RISK IS '';
COMMENT ON COLUMN BARS.SB_PARA.TARGET IS '';
COMMENT ON COLUMN BARS.SB_PARA.K_PROLONA IS '';
COMMENT ON COLUMN BARS.SB_PARA.EMITENT IS '';
COMMENT ON COLUMN BARS.SB_PARA.COUNTRY IS '';
COMMENT ON COLUMN BARS.SB_PARA.S120 IS '';
COMMENT ON COLUMN BARS.SB_PARA.BIRGA IS '';
COMMENT ON COLUMN BARS.SB_PARA.VID_CB IS '';
COMMENT ON COLUMN BARS.SB_PARA.NLS_PRO IS '';
COMMENT ON COLUMN BARS.SB_PARA.KOD_PRO IS '';
COMMENT ON COLUMN BARS.SB_PARA.NLG_DEC IS '';
COMMENT ON COLUMN BARS.SB_PARA.PR_DBS IS '';
COMMENT ON COLUMN BARS.SB_PARA.PR_KRS IS '';
COMMENT ON COLUMN BARS.SB_PARA.RS_DBS IS '';
COMMENT ON COLUMN BARS.SB_PARA.RS_KRS IS '';
COMMENT ON COLUMN BARS.SB_PARA.P080 IS '';
COMMENT ON COLUMN BARS.SB_PARA.OB22 IS '';
COMMENT ON COLUMN BARS.SB_PARA.MFO IS '';
COMMENT ON COLUMN BARS.SB_PARA.R020_FA IS '';



PROMPT *** Create  grants  SB_PARA ***
grant SELECT                                                                 on SB_PARA         to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on SB_PARA         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SB_PARA         to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on SB_PARA         to START1;
grant SELECT                                                                 on SB_PARA         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SB_PARA.sql =========*** End *** =====
PROMPT ===================================================================================== 
