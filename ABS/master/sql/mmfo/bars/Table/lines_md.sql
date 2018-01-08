

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/LINES_MD.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to LINES_MD ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''LINES_MD'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''LINES_MD'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''LINES_MD'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table LINES_MD ***
begin 
  execute immediate '
  CREATE TABLE BARS.LINES_MD 
   (	FN VARCHAR2(15), 
	DAT DATE, 
	N NUMBER, 
	MFO VARCHAR2(9), 
	OKPO VARCHAR2(14), 
	RTYPE NUMBER(1,0), 
	C_REG NUMBER(2,0), 
	OTYPE NUMBER(1,0), 
	ODATE DATE, 
	NLS VARCHAR2(14), 
	DK NUMBER(1,0), 
	S NUMBER(38,0), 
	KV NUMBER(3,0), 
	ERR VARCHAR2(4)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to LINES_MD ***
 exec bpa.alter_policies('LINES_MD');


COMMENT ON TABLE BARS.LINES_MD IS '';
COMMENT ON COLUMN BARS.LINES_MD.FN IS '';
COMMENT ON COLUMN BARS.LINES_MD.DAT IS '';
COMMENT ON COLUMN BARS.LINES_MD.N IS '';
COMMENT ON COLUMN BARS.LINES_MD.MFO IS '';
COMMENT ON COLUMN BARS.LINES_MD.OKPO IS '';
COMMENT ON COLUMN BARS.LINES_MD.RTYPE IS '';
COMMENT ON COLUMN BARS.LINES_MD.C_REG IS '';
COMMENT ON COLUMN BARS.LINES_MD.OTYPE IS '';
COMMENT ON COLUMN BARS.LINES_MD.ODATE IS '';
COMMENT ON COLUMN BARS.LINES_MD.NLS IS '';
COMMENT ON COLUMN BARS.LINES_MD.DK IS '';
COMMENT ON COLUMN BARS.LINES_MD.S IS '';
COMMENT ON COLUMN BARS.LINES_MD.KV IS '';
COMMENT ON COLUMN BARS.LINES_MD.ERR IS '';




PROMPT *** Create  constraint R_LINES_ZAG_MD ***
begin   
 execute immediate '
  ALTER TABLE BARS.LINES_MD ADD CONSTRAINT R_LINES_ZAG_MD FOREIGN KEY (FN, DAT)
	  REFERENCES BARS.ZAG_MD (FN, DAT) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XPK_LINES_MD ***
begin   
 execute immediate '
  ALTER TABLE BARS.LINES_MD ADD CONSTRAINT XPK_LINES_MD PRIMARY KEY (FN, DAT, N)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_LINES_MD ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_LINES_MD ON BARS.LINES_MD (FN, DAT, N) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  LINES_MD ***
grant DELETE,INSERT,SELECT,UPDATE                                            on LINES_MD        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on LINES_MD        to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on LINES_MD        to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/LINES_MD.sql =========*** End *** ====
PROMPT ===================================================================================== 
