

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/LINES_TB.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to LINES_TB ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''LINES_TB'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''LINES_TB'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''LINES_TB'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table LINES_TB ***
begin 
  execute immediate '
  CREATE TABLE BARS.LINES_TB 
   (	FN VARCHAR2(15), 
	DAT DATE, 
	N NUMBER, 
	MFOA VARCHAR2(9), 
	NLSA VARCHAR2(14), 
	MFOB VARCHAR2(9), 
	NLSB VARCHAR2(14), 
	DK NUMBER(1,0), 
	S NUMBER(38,0), 
	KV NUMBER(3,0), 
	VOB NUMBER(2,0), 
	ND VARCHAR2(15), 
	DATD DATE, 
	NAMA VARCHAR2(100), 
	NAMB VARCHAR2(100), 
	NAZN VARCHAR2(200), 
	DREC VARCHAR2(100), 
	NAZNK VARCHAR2(5), 
	NAZNS VARCHAR2(5), 
	OKPO VARCHAR2(14), 
	REF_A VARCHAR2(15), 
	DAT_A DATE, 
	DAT_B DATE, 
	ERR VARCHAR2(4)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to LINES_TB ***
 exec bpa.alter_policies('LINES_TB');


COMMENT ON TABLE BARS.LINES_TB IS '';
COMMENT ON COLUMN BARS.LINES_TB.FN IS '';
COMMENT ON COLUMN BARS.LINES_TB.DAT IS '';
COMMENT ON COLUMN BARS.LINES_TB.N IS '';
COMMENT ON COLUMN BARS.LINES_TB.MFOA IS '';
COMMENT ON COLUMN BARS.LINES_TB.NLSA IS '';
COMMENT ON COLUMN BARS.LINES_TB.MFOB IS '';
COMMENT ON COLUMN BARS.LINES_TB.NLSB IS '';
COMMENT ON COLUMN BARS.LINES_TB.DK IS '';
COMMENT ON COLUMN BARS.LINES_TB.S IS '';
COMMENT ON COLUMN BARS.LINES_TB.KV IS '';
COMMENT ON COLUMN BARS.LINES_TB.VOB IS '';
COMMENT ON COLUMN BARS.LINES_TB.ND IS '';
COMMENT ON COLUMN BARS.LINES_TB.DATD IS '';
COMMENT ON COLUMN BARS.LINES_TB.NAMA IS '';
COMMENT ON COLUMN BARS.LINES_TB.NAMB IS '';
COMMENT ON COLUMN BARS.LINES_TB.NAZN IS '';
COMMENT ON COLUMN BARS.LINES_TB.DREC IS '';
COMMENT ON COLUMN BARS.LINES_TB.NAZNK IS '';
COMMENT ON COLUMN BARS.LINES_TB.NAZNS IS '';
COMMENT ON COLUMN BARS.LINES_TB.OKPO IS '';
COMMENT ON COLUMN BARS.LINES_TB.REF_A IS '';
COMMENT ON COLUMN BARS.LINES_TB.DAT_A IS '';
COMMENT ON COLUMN BARS.LINES_TB.DAT_B IS '';
COMMENT ON COLUMN BARS.LINES_TB.ERR IS '';




PROMPT *** Create  constraint XPK_LINES_TB ***
begin   
 execute immediate '
  ALTER TABLE BARS.LINES_TB ADD CONSTRAINT XPK_LINES_TB PRIMARY KEY (FN, DAT, N)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_LINES_TB ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_LINES_TB ON BARS.LINES_TB (FN, DAT, N) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  LINES_TB ***
grant SELECT                                                                 on LINES_TB        to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on LINES_TB        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on LINES_TB        to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on LINES_TB        to START1;
grant SELECT                                                                 on LINES_TB        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/LINES_TB.sql =========*** End *** ====
PROMPT ===================================================================================== 
