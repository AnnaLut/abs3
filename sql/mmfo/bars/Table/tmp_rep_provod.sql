

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_REP_PROVOD.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_REP_PROVOD ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_REP_PROVOD ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.TMP_REP_PROVOD 
   (	TT CHAR(3), 
	REF NUMBER, 
	KV NUMBER, 
	NLSA VARCHAR2(15), 
	S NUMBER, 
	SQ NUMBER, 
	NLSB VARCHAR2(15), 
	NAZN VARCHAR2(160), 
	PDAT DATE, 
	NAMTT VARCHAR2(70), 
	ISP NUMBER, 
	BRANCH VARCHAR2(30), 
	NMSA VARCHAR2(70), 
	NMSB VARCHAR2(70), 
	STMT NUMBER(*,0), 
	ACCD NUMBER, 
	ACCK NUMBER
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_REP_PROVOD ***
 exec bpa.alter_policies('TMP_REP_PROVOD');


COMMENT ON TABLE BARS.TMP_REP_PROVOD IS '';
COMMENT ON COLUMN BARS.TMP_REP_PROVOD.KV IS '';
COMMENT ON COLUMN BARS.TMP_REP_PROVOD.NLSA IS '';
COMMENT ON COLUMN BARS.TMP_REP_PROVOD.S IS '';
COMMENT ON COLUMN BARS.TMP_REP_PROVOD.SQ IS '';
COMMENT ON COLUMN BARS.TMP_REP_PROVOD.NLSB IS '';
COMMENT ON COLUMN BARS.TMP_REP_PROVOD.NAZN IS '';
COMMENT ON COLUMN BARS.TMP_REP_PROVOD.PDAT IS '';
COMMENT ON COLUMN BARS.TMP_REP_PROVOD.NAMTT IS '';
COMMENT ON COLUMN BARS.TMP_REP_PROVOD.ISP IS '';
COMMENT ON COLUMN BARS.TMP_REP_PROVOD.BRANCH IS '';
COMMENT ON COLUMN BARS.TMP_REP_PROVOD.NMSA IS '';
COMMENT ON COLUMN BARS.TMP_REP_PROVOD.NMSB IS '';
COMMENT ON COLUMN BARS.TMP_REP_PROVOD.STMT IS '';
COMMENT ON COLUMN BARS.TMP_REP_PROVOD.ACCD IS '';
COMMENT ON COLUMN BARS.TMP_REP_PROVOD.ACCK IS '';
COMMENT ON COLUMN BARS.TMP_REP_PROVOD.TT IS '';
COMMENT ON COLUMN BARS.TMP_REP_PROVOD.REF IS '';




PROMPT *** Create  index IDX_TMP_REP_PROVOD ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_TMP_REP_PROVOD ON BARS.TMP_REP_PROVOD (REF, STMT) ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_REP_PROVOD ***
grant SELECT                                                                 on TMP_REP_PROVOD  to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_REP_PROVOD  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_REP_PROVOD  to RPBN001;
grant SELECT                                                                 on TMP_REP_PROVOD  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_REP_PROVOD.sql =========*** End **
PROMPT ===================================================================================== 
