

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/LINES_CV.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to LINES_CV ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''LINES_CV'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''LINES_CV'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''LINES_CV'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table LINES_CV ***
begin 
  execute immediate '
  CREATE TABLE BARS.LINES_CV 
   (	FN VARCHAR2(15), 
	DAT DATE, 
	N NUMBER, 
	MFOA VARCHAR2(9), 
	NLSA VARCHAR2(14), 
	MFOB VARCHAR2(9), 
	NLSB VARCHAR2(14), 
	DK NUMBER, 
	S NUMBER, 
	VOB VARCHAR2(2), 
	ND VARCHAR2(10), 
	KV NUMBER, 
	DATD DATE, 
	NAMA VARCHAR2(38), 
	NAMB VARCHAR2(38), 
	NAZN VARCHAR2(160), 
	DREC VARCHAR2(60), 
	NAZNK VARCHAR2(3), 
	NAZNS VARCHAR2(2), 
	OKPOA VARCHAR2(14), 
	OKPOB VARCHAR2(14), 
	REF_A NUMBER, 
	DAT_A DATE, 
	DAT_B DATE, 
	ID_O VARCHAR2(6), 
	SIGN RAW(64), 
	ERR VARCHAR2(4), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to LINES_CV ***
 exec bpa.alter_policies('LINES_CV');


COMMENT ON TABLE BARS.LINES_CV IS '';
COMMENT ON COLUMN BARS.LINES_CV.FN IS '';
COMMENT ON COLUMN BARS.LINES_CV.DAT IS '';
COMMENT ON COLUMN BARS.LINES_CV.N IS '';
COMMENT ON COLUMN BARS.LINES_CV.MFOA IS '';
COMMENT ON COLUMN BARS.LINES_CV.NLSA IS '';
COMMENT ON COLUMN BARS.LINES_CV.MFOB IS '';
COMMENT ON COLUMN BARS.LINES_CV.NLSB IS '';
COMMENT ON COLUMN BARS.LINES_CV.DK IS '';
COMMENT ON COLUMN BARS.LINES_CV.S IS '';
COMMENT ON COLUMN BARS.LINES_CV.VOB IS '';
COMMENT ON COLUMN BARS.LINES_CV.ND IS '';
COMMENT ON COLUMN BARS.LINES_CV.KV IS '';
COMMENT ON COLUMN BARS.LINES_CV.DATD IS '';
COMMENT ON COLUMN BARS.LINES_CV.NAMA IS '';
COMMENT ON COLUMN BARS.LINES_CV.NAMB IS '';
COMMENT ON COLUMN BARS.LINES_CV.NAZN IS '';
COMMENT ON COLUMN BARS.LINES_CV.DREC IS '';
COMMENT ON COLUMN BARS.LINES_CV.NAZNK IS '';
COMMENT ON COLUMN BARS.LINES_CV.NAZNS IS '';
COMMENT ON COLUMN BARS.LINES_CV.OKPOA IS '';
COMMENT ON COLUMN BARS.LINES_CV.OKPOB IS '';
COMMENT ON COLUMN BARS.LINES_CV.REF_A IS '';
COMMENT ON COLUMN BARS.LINES_CV.DAT_A IS '';
COMMENT ON COLUMN BARS.LINES_CV.DAT_B IS '';
COMMENT ON COLUMN BARS.LINES_CV.ID_O IS '';
COMMENT ON COLUMN BARS.LINES_CV.SIGN IS '';
COMMENT ON COLUMN BARS.LINES_CV.ERR IS '';
COMMENT ON COLUMN BARS.LINES_CV.KF IS '';




PROMPT *** Create  constraint XPK_LINES_CV ***
begin   
 execute immediate '
  ALTER TABLE BARS.LINES_CV ADD CONSTRAINT XPK_LINES_CV PRIMARY KEY (FN, DAT, N)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_LINESCV_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.LINES_CV MODIFY (KF CONSTRAINT CC_LINESCV_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_LINES_CV ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_LINES_CV ON BARS.LINES_CV (FN, DAT, N) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  LINES_CV ***
grant SELECT                                                                 on LINES_CV        to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on LINES_CV        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on LINES_CV        to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on LINES_CV        to RPBN002;
grant SELECT                                                                 on LINES_CV        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/LINES_CV.sql =========*** End *** ====
PROMPT ===================================================================================== 
