

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/RNBU_TRACE1.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to RNBU_TRACE1 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''RNBU_TRACE1'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''RNBU_TRACE1'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''RNBU_TRACE1'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table RNBU_TRACE1 ***
begin 
  execute immediate '
  CREATE TABLE BARS.RNBU_TRACE1 
   (	RECID NUMBER, 
	USERID NUMBER, 
	NLS VARCHAR2(15), 
	KV NUMBER, 
	ODATE DATE, 
	KODP VARCHAR2(35), 
	ZNAP VARCHAR2(70), 
	NBUC VARCHAR2(30), 
	ISP NUMBER, 
	RNK NUMBER, 
	ACC NUMBER, 
	REF NUMBER, 
	COMM VARCHAR2(200), 
	ND NUMBER, 
	MDATE DATE, 
	FDAT DATE, 
	BKOL NUMBER(*,0), 
	IR NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to RNBU_TRACE1 ***
 exec bpa.alter_policies('RNBU_TRACE1');


COMMENT ON TABLE BARS.RNBU_TRACE1 IS '';
COMMENT ON COLUMN BARS.RNBU_TRACE1.RECID IS '';
COMMENT ON COLUMN BARS.RNBU_TRACE1.USERID IS '';
COMMENT ON COLUMN BARS.RNBU_TRACE1.NLS IS '';
COMMENT ON COLUMN BARS.RNBU_TRACE1.KV IS '';
COMMENT ON COLUMN BARS.RNBU_TRACE1.ODATE IS '';
COMMENT ON COLUMN BARS.RNBU_TRACE1.KODP IS '';
COMMENT ON COLUMN BARS.RNBU_TRACE1.ZNAP IS '';
COMMENT ON COLUMN BARS.RNBU_TRACE1.NBUC IS '';
COMMENT ON COLUMN BARS.RNBU_TRACE1.ISP IS '';
COMMENT ON COLUMN BARS.RNBU_TRACE1.RNK IS '';
COMMENT ON COLUMN BARS.RNBU_TRACE1.ACC IS '';
COMMENT ON COLUMN BARS.RNBU_TRACE1.REF IS '';
COMMENT ON COLUMN BARS.RNBU_TRACE1.COMM IS '';
COMMENT ON COLUMN BARS.RNBU_TRACE1.ND IS '';
COMMENT ON COLUMN BARS.RNBU_TRACE1.MDATE IS '';
COMMENT ON COLUMN BARS.RNBU_TRACE1.FDAT IS '';
COMMENT ON COLUMN BARS.RNBU_TRACE1.BKOL IS '';
COMMENT ON COLUMN BARS.RNBU_TRACE1.IR IS '';




PROMPT *** Create  constraint SYS_C006750 ***
begin   
 execute immediate '
  ALTER TABLE BARS.RNBU_TRACE1 MODIFY (FDAT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XIE_FDAT_RNBU_TRACE1 ***
begin   
 execute immediate '
  CREATE INDEX BARS.XIE_FDAT_RNBU_TRACE1 ON BARS.RNBU_TRACE1 (FDAT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  RNBU_TRACE1 ***
grant SELECT                                                                 on RNBU_TRACE1     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on RNBU_TRACE1     to BARS_DM;
grant SELECT                                                                 on RNBU_TRACE1     to SALGL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on RNBU_TRACE1     to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/RNBU_TRACE1.sql =========*** End *** =
PROMPT ===================================================================================== 
