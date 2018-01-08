

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSUPL/Table/TEMP_SRC_INTRATES.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  table TEMP_SRC_INTRATES ***
begin 
  execute immediate '
  CREATE TABLE BARSUPL.TEMP_SRC_INTRATES 
   (	ACC NUMBER(*,0), 
	ID NUMBER(*,0), 
	BDAT DATE, 
	ISFIXED NUMBER(*,0), 
	RATE_NOM NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSUPLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSUPL.TEMP_SRC_INTRATES IS '';
COMMENT ON COLUMN BARSUPL.TEMP_SRC_INTRATES.ACC IS '';
COMMENT ON COLUMN BARSUPL.TEMP_SRC_INTRATES.ID IS '';
COMMENT ON COLUMN BARSUPL.TEMP_SRC_INTRATES.BDAT IS '';
COMMENT ON COLUMN BARSUPL.TEMP_SRC_INTRATES.ISFIXED IS '';
COMMENT ON COLUMN BARSUPL.TEMP_SRC_INTRATES.RATE_NOM IS '';



PROMPT *** Create  grants  TEMP_SRC_INTRATES ***
grant SELECT                                                                 on TEMP_SRC_INTRATES to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSUPL/Table/TEMP_SRC_INTRATES.sql =========*** 
PROMPT ===================================================================================== 
