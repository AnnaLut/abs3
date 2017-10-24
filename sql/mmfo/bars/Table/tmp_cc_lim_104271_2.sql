

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_CC_LIM_104271_2.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_CC_LIM_104271_2 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_CC_LIM_104271_2 ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_CC_LIM_104271_2 
   (	ND NUMBER, 
	MDAT DATE, 
	FDAT DATE, 
	LIM2 NUMBER, 
	ACC NUMBER, 
	NOT_9129 NUMBER(*,0), 
	SUMG NUMBER, 
	SUMO NUMBER, 
	OTM NUMBER(*,0), 
	SUMK NUMBER, 
	NOT_SN NUMBER(*,0), 
	TYPM VARCHAR2(5)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_CC_LIM_104271_2 ***
 exec bpa.alter_policies('TMP_CC_LIM_104271_2');


COMMENT ON TABLE BARS.TMP_CC_LIM_104271_2 IS '';
COMMENT ON COLUMN BARS.TMP_CC_LIM_104271_2.ND IS '';
COMMENT ON COLUMN BARS.TMP_CC_LIM_104271_2.MDAT IS '';
COMMENT ON COLUMN BARS.TMP_CC_LIM_104271_2.FDAT IS '';
COMMENT ON COLUMN BARS.TMP_CC_LIM_104271_2.LIM2 IS '';
COMMENT ON COLUMN BARS.TMP_CC_LIM_104271_2.ACC IS '';
COMMENT ON COLUMN BARS.TMP_CC_LIM_104271_2.NOT_9129 IS '';
COMMENT ON COLUMN BARS.TMP_CC_LIM_104271_2.SUMG IS '';
COMMENT ON COLUMN BARS.TMP_CC_LIM_104271_2.SUMO IS '';
COMMENT ON COLUMN BARS.TMP_CC_LIM_104271_2.OTM IS '';
COMMENT ON COLUMN BARS.TMP_CC_LIM_104271_2.SUMK IS '';
COMMENT ON COLUMN BARS.TMP_CC_LIM_104271_2.NOT_SN IS '';
COMMENT ON COLUMN BARS.TMP_CC_LIM_104271_2.TYPM IS '';



PROMPT *** Create  grants  TMP_CC_LIM_104271_2 ***
grant SELECT                                                                 on TMP_CC_LIM_104271_2 to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_CC_LIM_104271_2.sql =========*** E
PROMPT ===================================================================================== 
