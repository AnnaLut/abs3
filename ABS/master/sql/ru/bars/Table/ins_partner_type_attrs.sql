

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/INS_PARTNER_TYPE_ATTRS.sql =========**
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to INS_PARTNER_TYPE_ATTRS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''INS_PARTNER_TYPE_ATTRS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''INS_PARTNER_TYPE_ATTRS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table INS_PARTNER_TYPE_ATTRS ***
begin 
  execute immediate '
  CREATE TABLE BARS.INS_PARTNER_TYPE_ATTRS 
   (	ID NUMBER, 
	ATTR_ID VARCHAR2(100), 
	PARTNER_ID NUMBER, 
	TYPE_ID NUMBER, 
	IS_REQUIRED NUMBER DEFAULT 0
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to INS_PARTNER_TYPE_ATTRS ***
 exec bpa.alter_policies('INS_PARTNER_TYPE_ATTRS');


COMMENT ON TABLE BARS.INS_PARTNER_TYPE_ATTRS IS '�������� �� �� ���� ��';
COMMENT ON COLUMN BARS.INS_PARTNER_TYPE_ATTRS.ID IS '�������������';
COMMENT ON COLUMN BARS.INS_PARTNER_TYPE_ATTRS.ATTR_ID IS '��� ��������';
COMMENT ON COLUMN BARS.INS_PARTNER_TYPE_ATTRS.PARTNER_ID IS '������������� ��';
COMMENT ON COLUMN BARS.INS_PARTNER_TYPE_ATTRS.TYPE_ID IS '������������� ���� ���������� ��������';
COMMENT ON COLUMN BARS.INS_PARTNER_TYPE_ATTRS.IS_REQUIRED IS '�����������';




PROMPT *** Create  constraint FK_PTNTYPEATTRS_TID_TYPES ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_PARTNER_TYPE_ATTRS ADD CONSTRAINT FK_PTNTYPEATTRS_TID_TYPES FOREIGN KEY (TYPE_ID)
	  REFERENCES BARS.INS_TYPES (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_PTNTYPEATTRS_PID_PARTNERS ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_PARTNER_TYPE_ATTRS ADD CONSTRAINT FK_PTNTYPEATTRS_PID_PARTNERS FOREIGN KEY (PARTNER_ID)
	  REFERENCES BARS.INS_PARTNERS (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_PTNTYPEATTRS_AID_ATTRS ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_PARTNER_TYPE_ATTRS ADD CONSTRAINT FK_PTNTYPEATTRS_AID_ATTRS FOREIGN KEY (ATTR_ID)
	  REFERENCES BARS.INS_ATTRS (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PTNTYPEATTRS_ISREQ ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_PARTNER_TYPE_ATTRS ADD CONSTRAINT CC_PTNTYPEATTRS_ISREQ CHECK (is_required in (0, 1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_PTNTYPEATTRS ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_PARTNER_TYPE_ATTRS ADD CONSTRAINT UK_PTNTYPEATTRS UNIQUE (ATTR_ID, PARTNER_ID, TYPE_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_PTNTYPEATTRS ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_PARTNER_TYPE_ATTRS ADD CONSTRAINT PK_PTNTYPEATTRS PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PTNTYPEATTRS_ISREQ_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_PARTNER_TYPE_ATTRS MODIFY (IS_REQUIRED CONSTRAINT CC_PTNTYPEATTRS_ISREQ_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PTNTYPEATTRS_BRH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_PARTNER_TYPE_ATTRS MODIFY (ATTR_ID CONSTRAINT CC_PTNTYPEATTRS_BRH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003101242 ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_PARTNER_TYPE_ATTRS MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_PTNTYPEATTRS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_PTNTYPEATTRS ON BARS.INS_PARTNER_TYPE_ATTRS (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_PTNTYPEATTRS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_PTNTYPEATTRS ON BARS.INS_PARTNER_TYPE_ATTRS (ATTR_ID, PARTNER_ID, TYPE_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/INS_PARTNER_TYPE_ATTRS.sql =========**
PROMPT ===================================================================================== 
