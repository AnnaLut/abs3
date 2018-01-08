

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/D_DPA.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to D_DPA ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''D_DPA'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''D_DPA'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''D_DPA'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table D_DPA ***
begin 
  execute immediate '
  CREATE TABLE BARS.D_DPA 
   (	KOD VARCHAR2(14), 
	T01 NUMBER(*,0), 
	TYP_OPER NUMBER(*,0), 
	MFO NUMBER(*,0), 
	NLS NUMBER(14,0), 
	DK CHAR(1), 
	S NUMBER(16,0), 
	KV NUMBER(*,0), 
	D_OPER CHAR(6), 
	C_REG NUMBER(*,0), 
	KISP CHAR(6), 
	SIGN VARCHAR2(64), 
	REC_O NUMBER(*,0), 
	REF NUMBER(*,0), 
	ND CHAR(10), 
	RNK NUMBER(*,0), 
	NMK VARCHAR2(38), 
	C_AG NUMBER(*,0), 
	POLU VARCHAR2(38), 
	NAZ1 VARCHAR2(160), 
	OTM CHAR(2), 
	FN_I VARCHAR2(12), 
	DAT_I CHAR(10), 
	REC_I NUMBER(*,0), 
	FN_O VARCHAR2(12), 
	K_ER CHAR(4), 
	NLSK VARCHAR2(14)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to D_DPA ***
 exec bpa.alter_policies('D_DPA');


COMMENT ON TABLE BARS.D_DPA IS '';
COMMENT ON COLUMN BARS.D_DPA.KOD IS '';
COMMENT ON COLUMN BARS.D_DPA.T01 IS '';
COMMENT ON COLUMN BARS.D_DPA.TYP_OPER IS '';
COMMENT ON COLUMN BARS.D_DPA.MFO IS '';
COMMENT ON COLUMN BARS.D_DPA.NLS IS '';
COMMENT ON COLUMN BARS.D_DPA.DK IS '';
COMMENT ON COLUMN BARS.D_DPA.S IS '';
COMMENT ON COLUMN BARS.D_DPA.KV IS '';
COMMENT ON COLUMN BARS.D_DPA.D_OPER IS '';
COMMENT ON COLUMN BARS.D_DPA.C_REG IS '';
COMMENT ON COLUMN BARS.D_DPA.KISP IS '';
COMMENT ON COLUMN BARS.D_DPA.SIGN IS '';
COMMENT ON COLUMN BARS.D_DPA.REC_O IS '';
COMMENT ON COLUMN BARS.D_DPA.REF IS '';
COMMENT ON COLUMN BARS.D_DPA.ND IS '';
COMMENT ON COLUMN BARS.D_DPA.RNK IS '';
COMMENT ON COLUMN BARS.D_DPA.NMK IS '';
COMMENT ON COLUMN BARS.D_DPA.C_AG IS '';
COMMENT ON COLUMN BARS.D_DPA.POLU IS '';
COMMENT ON COLUMN BARS.D_DPA.NAZ1 IS '';
COMMENT ON COLUMN BARS.D_DPA.OTM IS '';
COMMENT ON COLUMN BARS.D_DPA.FN_I IS '';
COMMENT ON COLUMN BARS.D_DPA.DAT_I IS '';
COMMENT ON COLUMN BARS.D_DPA.REC_I IS '';
COMMENT ON COLUMN BARS.D_DPA.FN_O IS '';
COMMENT ON COLUMN BARS.D_DPA.K_ER IS '';
COMMENT ON COLUMN BARS.D_DPA.NLSK IS '';



PROMPT *** Create  grants  D_DPA ***
grant SELECT                                                                 on D_DPA           to BARSREADER_ROLE;
grant FLASHBACK,SELECT                                                       on D_DPA           to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on D_DPA           to BARS_DM;
grant SELECT                                                                 on D_DPA           to UPLD;
grant FLASHBACK,SELECT                                                       on D_DPA           to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/D_DPA.sql =========*** End *** =======
PROMPT ===================================================================================== 
