

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/MF1.sql =========*** Run *** =========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to MF1 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''MF1'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''MF1'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''MF1'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table MF1 ***
begin 
  execute immediate '
  CREATE TABLE BARS.MF1 
   (	NLSA VARCHAR2(14), 
	KVA NUMBER(*,0), 
	MFOB VARCHAR2(12), 
	NLSB VARCHAR2(14), 
	KVB NUMBER(*,0), 
	TT CHAR(3), 
	VOB NUMBER(*,0), 
	ND VARCHAR2(10), 
	DATD DATE, 
	S NUMBER, 
	NAM_A VARCHAR2(38), 
	NAM_B VARCHAR2(38), 
	NAZN VARCHAR2(160), 
	OKPOA VARCHAR2(14), 
	OKPOB VARCHAR2(14), 
	GRP NUMBER(*,0), 
	REF NUMBER(*,0), 
	SOS NUMBER(*,0), 
	ID NUMBER(*,0), 
	S_100 NUMBER(24,5), 
	DK NUMBER(*,0), 
	PRC NUMBER(24,5), 
	DELTA NUMBER(24,2), 
	ORD NUMBER(*,0), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'', ''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to MF1 ***
 exec bpa.alter_policies('MF1');


COMMENT ON TABLE BARS.MF1 IS '';
COMMENT ON COLUMN BARS.MF1.KF IS '';
COMMENT ON COLUMN BARS.MF1.NLSA IS '';
COMMENT ON COLUMN BARS.MF1.KVA IS '';
COMMENT ON COLUMN BARS.MF1.MFOB IS '';
COMMENT ON COLUMN BARS.MF1.NLSB IS '';
COMMENT ON COLUMN BARS.MF1.KVB IS '';
COMMENT ON COLUMN BARS.MF1.TT IS '';
COMMENT ON COLUMN BARS.MF1.VOB IS '';
COMMENT ON COLUMN BARS.MF1.ND IS '';
COMMENT ON COLUMN BARS.MF1.DATD IS '';
COMMENT ON COLUMN BARS.MF1.S IS '';
COMMENT ON COLUMN BARS.MF1.NAM_A IS '';
COMMENT ON COLUMN BARS.MF1.NAM_B IS '';
COMMENT ON COLUMN BARS.MF1.NAZN IS '';
COMMENT ON COLUMN BARS.MF1.OKPOA IS '';
COMMENT ON COLUMN BARS.MF1.OKPOB IS '';
COMMENT ON COLUMN BARS.MF1.GRP IS '';
COMMENT ON COLUMN BARS.MF1.REF IS '';
COMMENT ON COLUMN BARS.MF1.SOS IS '';
COMMENT ON COLUMN BARS.MF1.ID IS '';
COMMENT ON COLUMN BARS.MF1.S_100 IS '';
COMMENT ON COLUMN BARS.MF1.DK IS '';
COMMENT ON COLUMN BARS.MF1.PRC IS '';
COMMENT ON COLUMN BARS.MF1.DELTA IS '+ или - константа к сумме';
COMMENT ON COLUMN BARS.MF1.ORD IS '№ пп внутри макета';




PROMPT *** Create  constraint PK_MF1 ***
begin   
 execute immediate '
  ALTER TABLE BARS.MF1 ADD CONSTRAINT PK_MF1 PRIMARY KEY (ID, KF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_MF1 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_MF1 ON BARS.MF1 (ID, KF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  MF1 ***
grant DELETE,INSERT,SELECT,UPDATE                                            on MF1             to ABS_ADMIN;
grant DELETE,INSERT,SELECT,UPDATE                                            on MF1             to BARS015;
grant SELECT                                                                 on MF1             to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on MF1             to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on MF1             to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on MF1             to PYOD001;
grant SELECT                                                                 on MF1             to UPLD;
grant FLASHBACK,SELECT                                                       on MF1             to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/MF1.sql =========*** End *** =========
PROMPT ===================================================================================== 
