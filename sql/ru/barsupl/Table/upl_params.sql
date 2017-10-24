

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSUPL/Table/UPL_PARAMS.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  table UPL_PARAMS ***
begin 
  execute immediate '
  CREATE TABLE BARSUPL.UPL_PARAMS 
   (	PARAM VARCHAR2(20), 
	VALUE VARCHAR2(500), 
	DESCRIPT VARCHAR2(500), 
	GROUP_ID NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSUPLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSUPL.UPL_PARAMS IS 'Глобальные параметры выгрузки';
COMMENT ON COLUMN BARSUPL.UPL_PARAMS.PARAM IS '';
COMMENT ON COLUMN BARSUPL.UPL_PARAMS.VALUE IS '';
COMMENT ON COLUMN BARSUPL.UPL_PARAMS.DESCRIPT IS '';
COMMENT ON COLUMN BARSUPL.UPL_PARAMS.GROUP_ID IS '';




PROMPT *** Create  constraint FK_UPLPARAMS_GROUPID ***
begin   
 execute immediate '
  ALTER TABLE BARSUPL.UPL_PARAMS ADD CONSTRAINT FK_UPLPARAMS_GROUPID FOREIGN KEY (GROUP_ID)
	  REFERENCES BARSUPL.UPL_PARAM_GROUPS (GROUP_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_UPLPARAMS ***
begin   
 execute immediate '
  ALTER TABLE BARSUPL.UPL_PARAMS ADD CONSTRAINT PK_UPLPARAMS PRIMARY KEY (PARAM)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSUPLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_UPLPARAMS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSUPL.PK_UPLPARAMS ON BARSUPL.UPL_PARAMS (PARAM) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSUPLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  UPL_PARAMS ***
grant SELECT                                                                 on UPL_PARAMS      to BARS;
grant DELETE,INSERT,SELECT,UPDATE                                            on UPL_PARAMS      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSUPL/Table/UPL_PARAMS.sql =========*** End ***
PROMPT ===================================================================================== 
