

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CHECK_TAG.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CHECK_TAG ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CHECK_TAG'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CHECK_TAG'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CHECK_TAG ***
begin 
  execute immediate '
  CREATE TABLE BARS.CHECK_TAG 
   (	TT CHAR(3), 
	TAG_PARENT CHAR(5), 
	VALUE_PARENT VARCHAR2(256), 
	TAG_CHILD CHAR(5), 
	REQUIRED VARCHAR2(1) DEFAULT ''N''
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CHECK_TAG ***
 exec bpa.alter_policies('CHECK_TAG');


COMMENT ON TABLE BARS.CHECK_TAG IS '������� ������ ����������/�������� ��������, ������������ ������� f_check_tag';
COMMENT ON COLUMN BARS.CHECK_TAG.TT IS '��� �������� ��� �������� ������ ������������ ��������/��������/�������� ��������';
COMMENT ON COLUMN BARS.CHECK_TAG.TAG_PARENT IS '������������ �������� ��������';
COMMENT ON COLUMN BARS.CHECK_TAG.VALUE_PARENT IS '�������� ������������� ���������';
COMMENT ON COLUMN BARS.CHECK_TAG.TAG_CHILD IS '�������� ��������';
COMMENT ON COLUMN BARS.CHECK_TAG.REQUIRED IS '������� �������������� ���������� ��������� ���������, ��� ���������� �������� ������������� ���������';




PROMPT *** Create  constraint FK_CHECK_TAG_TAG_CHILD ***
begin   
 execute immediate '
  ALTER TABLE BARS.CHECK_TAG ADD CONSTRAINT FK_CHECK_TAG_TAG_CHILD FOREIGN KEY (TAG_CHILD)
	  REFERENCES BARS.OP_FIELD (TAG) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CHECK_TAG_TAG_PARENT ***
begin   
 execute immediate '
  ALTER TABLE BARS.CHECK_TAG ADD CONSTRAINT FK_CHECK_TAG_TAG_PARENT FOREIGN KEY (TAG_PARENT)
	  REFERENCES BARS.OP_FIELD (TAG) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CHECK_TAG_TT ***
begin   
 execute immediate '
  ALTER TABLE BARS.CHECK_TAG ADD CONSTRAINT FK_CHECK_TAG_TT FOREIGN KEY (TT)
	  REFERENCES BARS.TTS (TT) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002744658 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CHECK_TAG MODIFY (TAG_CHILD NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002744656 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CHECK_TAG MODIFY (TAG_PARENT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002744655 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CHECK_TAG MODIFY (TT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CHECK_TAG ***
grant DELETE,INSERT,SELECT,UPDATE                                            on CHECK_TAG       to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CHECK_TAG.sql =========*** End *** ===
PROMPT ===================================================================================== 
