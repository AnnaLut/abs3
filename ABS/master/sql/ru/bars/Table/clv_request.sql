

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CLV_REQUEST.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CLV_REQUEST ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CLV_REQUEST'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CLV_REQUEST'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CLV_REQUEST ***
begin 
  execute immediate '
  CREATE TABLE BARS.CLV_REQUEST 
   (	RNK NUMBER(38,0), 
	REQ_DATE DATE DEFAULT sysdate, 
	REQ_USERID NUMBER(22,0), 
	REQ_TYPE NUMBER(1,0), 
	REJ_DATE DATE, 
	REJ_USERID NUMBER(22,0)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CLV_REQUEST ***
 exec bpa.alter_policies('CLV_REQUEST');


COMMENT ON TABLE BARS.CLV_REQUEST IS '������ �� ���� �������� �볺���';
COMMENT ON COLUMN BARS.CLV_REQUEST.RNK IS '���';
COMMENT ON COLUMN BARS.CLV_REQUEST.REQ_DATE IS '���� ������';
COMMENT ON COLUMN BARS.CLV_REQUEST.REQ_USERID IS '��.�����������-������ ������';
COMMENT ON COLUMN BARS.CLV_REQUEST.REQ_TYPE IS '���: 0-��������� ��, 1-��������� ��, 2-�����(0) ��������';
COMMENT ON COLUMN BARS.CLV_REQUEST.REJ_DATE IS '���� ��������� ������ "���� ��"';
COMMENT ON COLUMN BARS.CLV_REQUEST.REJ_USERID IS '��.�����������, �� ������� ����� "���� ��"';




PROMPT *** Create  constraint FK_CLVREQUEST_STAFF2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CLV_REQUEST ADD CONSTRAINT FK_CLVREQUEST_STAFF2 FOREIGN KEY (REJ_USERID)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CLVREQUEST_STAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.CLV_REQUEST ADD CONSTRAINT FK_CLVREQUEST_STAFF FOREIGN KEY (REQ_USERID)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_CLVREQUEST ***
begin   
 execute immediate '
  ALTER TABLE BARS.CLV_REQUEST ADD CONSTRAINT PK_CLVREQUEST PRIMARY KEY (RNK)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CLVREQUEST_REQTYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.CLV_REQUEST ADD CONSTRAINT CC_CLVREQUEST_REQTYPE CHECK (req_type in (0,1,2)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CLVREQUEST_REQTYPE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CLV_REQUEST MODIFY (REQ_TYPE CONSTRAINT CC_CLVREQUEST_REQTYPE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CLVREQUEST_REQUSERID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CLV_REQUEST MODIFY (REQ_USERID CONSTRAINT CC_CLVREQUEST_REQUSERID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CLVREQUEST_REQDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CLV_REQUEST MODIFY (REQ_DATE CONSTRAINT CC_CLVREQUEST_REQDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CLVREQUEST_RNK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CLV_REQUEST MODIFY (RNK CONSTRAINT CC_CLVREQUEST_RNK_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CLVREQUEST ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CLVREQUEST ON BARS.CLV_REQUEST (RNK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CLV_REQUEST.sql =========*** End *** =
PROMPT ===================================================================================== 
