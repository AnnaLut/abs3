

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_DEM.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_DEM ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TMP_DEM'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_DEM'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_DEM'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_DEM ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_DEM 
   (	ID NUMBER(*,0), 
	ND NUMBER(*,0), 
	CC_ID VARCHAR2(20), 
	RNK NUMBER(*,0), 
	NMK VARCHAR2(38), 
	DATE1 DATE, 
	DATE2 DATE, 
	SS NUMBER(*,0), 
	ST NUMBER, 
	SPR NUMBER(*,0), 
	FIRMA VARCHAR2(20), 
	TEL VARCHAR2(50)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_DEM ***
 exec bpa.alter_policies('TMP_DEM');


COMMENT ON TABLE BARS.TMP_DEM IS '';
COMMENT ON COLUMN BARS.TMP_DEM.ID IS '';
COMMENT ON COLUMN BARS.TMP_DEM.ND IS '';
COMMENT ON COLUMN BARS.TMP_DEM.CC_ID IS '';
COMMENT ON COLUMN BARS.TMP_DEM.RNK IS '';
COMMENT ON COLUMN BARS.TMP_DEM.NMK IS '';
COMMENT ON COLUMN BARS.TMP_DEM.DATE1 IS '';
COMMENT ON COLUMN BARS.TMP_DEM.DATE2 IS '';
COMMENT ON COLUMN BARS.TMP_DEM.SS IS '';
COMMENT ON COLUMN BARS.TMP_DEM.ST IS '';
COMMENT ON COLUMN BARS.TMP_DEM.SPR IS '';
COMMENT ON COLUMN BARS.TMP_DEM.FIRMA IS '';
COMMENT ON COLUMN BARS.TMP_DEM.TEL IS '';



PROMPT *** Create  grants  TMP_DEM ***
grant SELECT                                                                 on TMP_DEM         to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_DEM         to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_DEM         to START1;
grant SELECT                                                                 on TMP_DEM         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_DEM.sql =========*** End *** =====
PROMPT ===================================================================================== 
