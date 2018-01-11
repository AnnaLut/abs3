

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_INFLATION_SN8.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_INFLATION_SN8 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_INFLATION_SN8 ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_INFLATION_SN8 
   (	ND NUMBER, 
	ACC NUMBER, 
	FDAT_BEG DATE, 
	FDAT_END DATE, 
	DAT_BEG_K DATE, 
	DAT_END_K DATE, 
	S_NOM NUMBER, 
	S NUMBER, 
	S_K NUMBER, 
	S_SN8 NUMBER, 
	IR NUMBER, 
	IR_NBU NUMBER, 
	COMM VARCHAR2(1000), 
	DAT_IRR VARCHAR2(23), 
	TYP_KOD NUMBER, 
	ACC_SN8 NUMBER
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_INFLATION_SN8 ***
 exec bpa.alter_policies('TMP_INFLATION_SN8');


COMMENT ON TABLE BARS.TMP_INFLATION_SN8 IS '';
COMMENT ON COLUMN BARS.TMP_INFLATION_SN8.ND IS '';
COMMENT ON COLUMN BARS.TMP_INFLATION_SN8.ACC IS '';
COMMENT ON COLUMN BARS.TMP_INFLATION_SN8.FDAT_BEG IS '';
COMMENT ON COLUMN BARS.TMP_INFLATION_SN8.FDAT_END IS '';
COMMENT ON COLUMN BARS.TMP_INFLATION_SN8.DAT_BEG_K IS '';
COMMENT ON COLUMN BARS.TMP_INFLATION_SN8.DAT_END_K IS '';
COMMENT ON COLUMN BARS.TMP_INFLATION_SN8.S_NOM IS '';
COMMENT ON COLUMN BARS.TMP_INFLATION_SN8.S IS '';
COMMENT ON COLUMN BARS.TMP_INFLATION_SN8.S_K IS '';
COMMENT ON COLUMN BARS.TMP_INFLATION_SN8.S_SN8 IS '';
COMMENT ON COLUMN BARS.TMP_INFLATION_SN8.IR IS '';
COMMENT ON COLUMN BARS.TMP_INFLATION_SN8.IR_NBU IS '';
COMMENT ON COLUMN BARS.TMP_INFLATION_SN8.COMM IS '';
COMMENT ON COLUMN BARS.TMP_INFLATION_SN8.DAT_IRR IS '';
COMMENT ON COLUMN BARS.TMP_INFLATION_SN8.TYP_KOD IS '';
COMMENT ON COLUMN BARS.TMP_INFLATION_SN8.ACC_SN8 IS '';



PROMPT *** Create  grants  TMP_INFLATION_SN8 ***
grant SELECT                                                                 on TMP_INFLATION_SN8 to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_INFLATION_SN8 to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_INFLATION_SN8 to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_INFLATION_SN8.sql =========*** End
PROMPT ===================================================================================== 
