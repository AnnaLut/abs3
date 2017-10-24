

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OW_XADATA.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OW_XADATA ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OW_XADATA'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''OW_XADATA'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''OW_XADATA'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OW_XADATA ***
begin 
  execute immediate '
  CREATE TABLE BARS.OW_XADATA 
   (	FILE_NAME VARCHAR2(100), 
	ACC NUMBER(22,0), 
	RESP_CLASS VARCHAR2(100), 
	RESP_CODE VARCHAR2(100), 
	RESP_TEXT VARCHAR2(254), 
	UNFORM_FLAG NUMBER(1,0), 
	UNFORM_USER NUMBER(22,0), 
	UNFORM_DATE DATE, 
	REGNUMBER VARCHAR2(20)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OW_XADATA ***
 exec bpa.alter_policies('OW_XADATA');


COMMENT ON TABLE BARS.OW_XADATA IS 'ЦРВ. Файлы на открытие карт';
COMMENT ON COLUMN BARS.OW_XADATA.FILE_NAME IS '';
COMMENT ON COLUMN BARS.OW_XADATA.ACC IS '';
COMMENT ON COLUMN BARS.OW_XADATA.RESP_CLASS IS '';
COMMENT ON COLUMN BARS.OW_XADATA.RESP_CODE IS '';
COMMENT ON COLUMN BARS.OW_XADATA.RESP_TEXT IS '';
COMMENT ON COLUMN BARS.OW_XADATA.UNFORM_FLAG IS '';
COMMENT ON COLUMN BARS.OW_XADATA.UNFORM_USER IS '';
COMMENT ON COLUMN BARS.OW_XADATA.UNFORM_DATE IS '';
COMMENT ON COLUMN BARS.OW_XADATA.REGNUMBER IS '';




PROMPT *** Create  constraint PK_OWXADATA ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_XADATA ADD CONSTRAINT PK_OWXADATA PRIMARY KEY (FILE_NAME, ACC)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_OWXADATA_STAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_XADATA ADD CONSTRAINT FK_OWXADATA_STAFF FOREIGN KEY (UNFORM_USER)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OWXADATA_FILENAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_XADATA MODIFY (FILE_NAME CONSTRAINT CC_OWXADATA_FILENAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OWXADATA_ACC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_XADATA MODIFY (ACC CONSTRAINT CC_OWXADATA_ACC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_OWXADATA ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_OWXADATA ON BARS.OW_XADATA (FILE_NAME, ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OW_XADATA ***
grant DELETE,INSERT,SELECT,UPDATE                                            on OW_XADATA       to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on OW_XADATA       to OW;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OW_XADATA.sql =========*** End *** ===
PROMPT ===================================================================================== 
