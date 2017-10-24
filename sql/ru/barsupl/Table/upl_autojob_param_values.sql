

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSUPL/Table/UPL_AUTOJOB_PARAM_VALUES.sql ======
PROMPT ===================================================================================== 


PROMPT *** Create  table UPL_AUTOJOB_PARAM_VALUES ***
begin 
  execute immediate '
  CREATE TABLE BARSUPL.UPL_AUTOJOB_PARAM_VALUES 
   (	JOB_NAME VARCHAR2(200), 
	PARAM VARCHAR2(20), 
	VALUE VARCHAR2(500)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSUPLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSUPL.UPL_AUTOJOB_PARAM_VALUES IS 'Значения параметров авто-выгруждаемых заданий';
COMMENT ON COLUMN BARSUPL.UPL_AUTOJOB_PARAM_VALUES.JOB_NAME IS '';
COMMENT ON COLUMN BARSUPL.UPL_AUTOJOB_PARAM_VALUES.PARAM IS '';
COMMENT ON COLUMN BARSUPL.UPL_AUTOJOB_PARAM_VALUES.VALUE IS '';




PROMPT *** Create  constraint FK_UPLAUTOJOBS_JOB ***
begin   
 execute immediate '
  ALTER TABLE BARSUPL.UPL_AUTOJOB_PARAM_VALUES ADD CONSTRAINT FK_UPLAUTOJOBS_JOB FOREIGN KEY (JOB_NAME)
	  REFERENCES BARSUPL.UPL_AUTOJOBS (JOB_NAME) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_UPLAUTOJOB_PARAM ***
begin   
 execute immediate '
  ALTER TABLE BARSUPL.UPL_AUTOJOB_PARAM_VALUES ADD CONSTRAINT FK_UPLAUTOJOB_PARAM FOREIGN KEY (PARAM)
	  REFERENCES BARSUPL.UPL_AUTOJOB_PARAMS (PARAM) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UPLAUTOJOBSPARVAL ***
begin   
 execute immediate '
  ALTER TABLE BARSUPL.UPL_AUTOJOB_PARAM_VALUES ADD CONSTRAINT UPLAUTOJOBSPARVAL PRIMARY KEY (JOB_NAME, PARAM)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSUPLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index UPLAUTOJOBSPARVAL ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSUPL.UPLAUTOJOBSPARVAL ON BARSUPL.UPL_AUTOJOB_PARAM_VALUES (JOB_NAME, PARAM) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSUPLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  UPL_AUTOJOB_PARAM_VALUES ***
grant DELETE,INSERT,SELECT,UPDATE                                            on UPL_AUTOJOB_PARAM_VALUES to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSUPL/Table/UPL_AUTOJOB_PARAM_VALUES.sql ======
PROMPT ===================================================================================== 
