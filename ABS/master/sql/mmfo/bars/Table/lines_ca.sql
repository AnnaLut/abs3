

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/LINES_CA.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to LINES_CA ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''LINES_CA'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''LINES_CA'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''LINES_CA'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table LINES_CA ***
begin 
  execute immediate '
  CREATE TABLE BARS.LINES_CA 
   (	FN VARCHAR2(15), 
	DAT DATE, 
	N NUMBER, 
	MFO VARCHAR2(9), 
	NB VARCHAR2(38), 
	NLS VARCHAR2(14), 
	VID VARCHAR2(1), 
	NUM_TVO VARCHAR2(3), 
	NAME_BLOK VARCHAR2(250), 
	DAOS DATE, 
	FIO_BLOK VARCHAR2(76), 
	FIO_ISP VARCHAR2(38), 
	INF_ISP VARCHAR2(38), 
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




PROMPT *** ALTER_POLICIES to LINES_CA ***
 exec bpa.alter_policies('LINES_CA');


COMMENT ON TABLE BARS.LINES_CA IS '';
COMMENT ON COLUMN BARS.LINES_CA.FN IS '';
COMMENT ON COLUMN BARS.LINES_CA.DAT IS '';
COMMENT ON COLUMN BARS.LINES_CA.N IS '';
COMMENT ON COLUMN BARS.LINES_CA.MFO IS '';
COMMENT ON COLUMN BARS.LINES_CA.NB IS '';
COMMENT ON COLUMN BARS.LINES_CA.NLS IS '';
COMMENT ON COLUMN BARS.LINES_CA.VID IS '';
COMMENT ON COLUMN BARS.LINES_CA.NUM_TVO IS '';
COMMENT ON COLUMN BARS.LINES_CA.NAME_BLOK IS '';
COMMENT ON COLUMN BARS.LINES_CA.DAOS IS '';
COMMENT ON COLUMN BARS.LINES_CA.FIO_BLOK IS '';
COMMENT ON COLUMN BARS.LINES_CA.FIO_ISP IS '';
COMMENT ON COLUMN BARS.LINES_CA.INF_ISP IS '';
COMMENT ON COLUMN BARS.LINES_CA.ID_O IS '';
COMMENT ON COLUMN BARS.LINES_CA.SIGN IS '';
COMMENT ON COLUMN BARS.LINES_CA.ERR IS '';
COMMENT ON COLUMN BARS.LINES_CA.KF IS '';




PROMPT *** Create  constraint CC_LINESCA_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.LINES_CA MODIFY (KF CONSTRAINT CC_LINESCA_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XPK_LINES_CA ***
begin   
 execute immediate '
  ALTER TABLE BARS.LINES_CA ADD CONSTRAINT XPK_LINES_CA PRIMARY KEY (FN, DAT, N)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_LINES_CA ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_LINES_CA ON BARS.LINES_CA (FN, DAT, N) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  LINES_CA ***
grant SELECT                                                                 on LINES_CA        to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on LINES_CA        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on LINES_CA        to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on LINES_CA        to RPBN002;
grant SELECT                                                                 on LINES_CA        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/LINES_CA.sql =========*** End *** ====
PROMPT ===================================================================================== 
