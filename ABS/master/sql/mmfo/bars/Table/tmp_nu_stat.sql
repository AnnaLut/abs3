

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_NU_STAT.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_NU_STAT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TMP_NU_STAT'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_NU_STAT'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_NU_STAT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_NU_STAT ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.TMP_NU_STAT 
   (	NDOC CHAR(4), 
	NNDOC CHAR(2), 
	NPP CHAR(11), 
	NROW CHAR(2), 
	S_NPP NUMBER, 
	P080 VARCHAR2(4), 
	S_P080 NUMBER, 
	NBSF CHAR(4), 
	NLSN VARCHAR2(15), 
	NMSN VARCHAR2(40), 
	S_N NUMBER, 
	NLSF VARCHAR2(15), 
	NMSF VARCHAR2(40), 
	S_F NUMBER, 
	NBSN CHAR(4), 
	NOB22 CHAR(2), 
	ACCN NUMBER
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_NU_STAT ***
 exec bpa.alter_policies('TMP_NU_STAT');


COMMENT ON TABLE BARS.TMP_NU_STAT IS '';
COMMENT ON COLUMN BARS.TMP_NU_STAT.NDOC IS '';
COMMENT ON COLUMN BARS.TMP_NU_STAT.NNDOC IS '';
COMMENT ON COLUMN BARS.TMP_NU_STAT.NPP IS '';
COMMENT ON COLUMN BARS.TMP_NU_STAT.NROW IS '';
COMMENT ON COLUMN BARS.TMP_NU_STAT.S_NPP IS '';
COMMENT ON COLUMN BARS.TMP_NU_STAT.P080 IS '';
COMMENT ON COLUMN BARS.TMP_NU_STAT.S_P080 IS '';
COMMENT ON COLUMN BARS.TMP_NU_STAT.NBSF IS '';
COMMENT ON COLUMN BARS.TMP_NU_STAT.NLSN IS '';
COMMENT ON COLUMN BARS.TMP_NU_STAT.NMSN IS '';
COMMENT ON COLUMN BARS.TMP_NU_STAT.S_N IS '';
COMMENT ON COLUMN BARS.TMP_NU_STAT.NLSF IS '';
COMMENT ON COLUMN BARS.TMP_NU_STAT.NMSF IS '';
COMMENT ON COLUMN BARS.TMP_NU_STAT.S_F IS '';
COMMENT ON COLUMN BARS.TMP_NU_STAT.NBSN IS '';
COMMENT ON COLUMN BARS.TMP_NU_STAT.NOB22 IS '';
COMMENT ON COLUMN BARS.TMP_NU_STAT.ACCN IS '';



PROMPT *** Create  grants  TMP_NU_STAT ***
grant SELECT                                                                 on TMP_NU_STAT     to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_NU_STAT     to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_NU_STAT     to START1;
grant SELECT                                                                 on TMP_NU_STAT     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_NU_STAT.sql =========*** End *** =
PROMPT ===================================================================================== 
