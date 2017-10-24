

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CHECK_TAG.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CHECK_TAG ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CHECK_TAG'', ''CENTER'' , null, null, null, null);
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




PROMPT *** Create  constraint SYS_C008167 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CHECK_TAG MODIFY (TT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008168 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CHECK_TAG MODIFY (TAG_PARENT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008169 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CHECK_TAG MODIFY (TAG_CHILD NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CHECK_TAG ***
grant DELETE,INSERT,SELECT,UPDATE                                            on CHECK_TAG       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CHECK_TAG       to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CHECK_TAG.sql =========*** End *** ===
PROMPT ===================================================================================== 
