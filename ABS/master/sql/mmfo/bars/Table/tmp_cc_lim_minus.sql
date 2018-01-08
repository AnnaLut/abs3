

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_CC_LIM_MINUS.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_CC_LIM_MINUS ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_CC_LIM_MINUS ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_CC_LIM_MINUS 
   (	ND NUMBER(38,0), 
	FDAT DATE, 
	LIM2 NUMBER(38,0), 
	ACC NUMBER(*,0), 
	NOT_9129 NUMBER(*,0), 
	SUMG NUMBER(38,0), 
	SUMO NUMBER(38,0), 
	OTM NUMBER(*,0), 
	KF VARCHAR2(6), 
	SUMK NUMBER, 
	NOT_SN NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_CC_LIM_MINUS ***
 exec bpa.alter_policies('TMP_CC_LIM_MINUS');


COMMENT ON TABLE BARS.TMP_CC_LIM_MINUS IS '';
COMMENT ON COLUMN BARS.TMP_CC_LIM_MINUS.ND IS '';
COMMENT ON COLUMN BARS.TMP_CC_LIM_MINUS.FDAT IS '';
COMMENT ON COLUMN BARS.TMP_CC_LIM_MINUS.LIM2 IS '';
COMMENT ON COLUMN BARS.TMP_CC_LIM_MINUS.ACC IS '';
COMMENT ON COLUMN BARS.TMP_CC_LIM_MINUS.NOT_9129 IS '';
COMMENT ON COLUMN BARS.TMP_CC_LIM_MINUS.SUMG IS '';
COMMENT ON COLUMN BARS.TMP_CC_LIM_MINUS.SUMO IS '';
COMMENT ON COLUMN BARS.TMP_CC_LIM_MINUS.OTM IS '';
COMMENT ON COLUMN BARS.TMP_CC_LIM_MINUS.KF IS '';
COMMENT ON COLUMN BARS.TMP_CC_LIM_MINUS.SUMK IS '';
COMMENT ON COLUMN BARS.TMP_CC_LIM_MINUS.NOT_SN IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_CC_LIM_MINUS.sql =========*** End 
PROMPT ===================================================================================== 
