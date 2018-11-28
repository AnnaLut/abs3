

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSTRANS/Table/OUT_REQ_PARAMS.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  table OUT_REQ_PARAMS ***
begin 
  execute immediate '
  CREATE TABLE BARSTRANS.OUT_REQ_PARAMS 
   (REQ_ID VARCHAR2(36), 
	PARAM_TYPE VARCHAR2(10), 
	TAG VARCHAR2(30), 
	VALUE VARCHAR2(255)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSTRANS.OUT_REQ_PARAMS IS '��������� ������';
COMMENT ON COLUMN BARSTRANS.OUT_REQ_PARAMS.REQ_ID IS '�� ��������';
COMMENT ON COLUMN BARSTRANS.OUT_REQ_PARAMS.PARAM_TYPE IS '��� ��������� (GET, HEAD)';
COMMENT ON COLUMN BARSTRANS.OUT_REQ_PARAMS.TAG IS '���';
COMMENT ON COLUMN BARSTRANS.OUT_REQ_PARAMS.VALUE IS '��������';




PROMPT *** Create  constraint PK_OUT_REQ_PARAMS ***
begin   
 execute immediate '
  ALTER TABLE BARSTRANS.OUT_REQ_PARAMS ADD CONSTRAINT PK_OUT_REQ_PARAMS PRIMARY KEY (REQ_ID, PARAM_TYPE, TAG)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_OUT_REQ_PARAMS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSTRANS.PK_OUT_REQ_PARAMS ON BARSTRANS.OUT_REQ_PARAMS (REQ_ID, PARAM_TYPE, TAG) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSTRANS/Table/OUT_REQ_PARAMS.sql =========*** E
PROMPT ===================================================================================== 

