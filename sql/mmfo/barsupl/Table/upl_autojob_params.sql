

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSUPL/Table/UPL_AUTOJOB_PARAMS.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  table UPL_AUTOJOB_PARAMS ***
begin 
  execute immediate '
  CREATE TABLE BARSUPL.UPL_AUTOJOB_PARAMS 
   (	PARAM VARCHAR2(20), 
	DEFVAL VARCHAR2(500), 
	DESCRIPT VARCHAR2(200)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSUPLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSUPL.UPL_AUTOJOB_PARAMS IS '';
COMMENT ON COLUMN BARSUPL.UPL_AUTOJOB_PARAMS.PARAM IS '';
COMMENT ON COLUMN BARSUPL.UPL_AUTOJOB_PARAMS.DEFVAL IS '';
COMMENT ON COLUMN BARSUPL.UPL_AUTOJOB_PARAMS.DESCRIPT IS '';




PROMPT *** Create  constraint UPLAUTOJOBSPAR ***
begin   
 execute immediate '
  ALTER TABLE BARSUPL.UPL_AUTOJOB_PARAMS ADD CONSTRAINT UPLAUTOJOBSPAR PRIMARY KEY (PARAM)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSUPLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index UPLAUTOJOBSPAR ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSUPL.UPLAUTOJOBSPAR ON BARSUPL.UPL_AUTOJOB_PARAMS (PARAM) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSUPLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  UPL_AUTOJOB_PARAMS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on UPL_AUTOJOB_PARAMS to BARS;
grant SELECT                                                                 on UPL_AUTOJOB_PARAMS to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on UPL_AUTOJOB_PARAMS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSUPL/Table/UPL_AUTOJOB_PARAMS.sql =========***
PROMPT ===================================================================================== 
