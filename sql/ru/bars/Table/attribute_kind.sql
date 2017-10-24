

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ATTRIBUTE_KIND.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ATTRIBUTE_KIND ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ATTRIBUTE_KIND'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''ATTRIBUTE_KIND'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ATTRIBUTE_KIND ***
begin 
  execute immediate '
	create table ATTRIBUTE_KIND
	(
		id                     NUMBER(5),
		attribute_code         VARCHAR2(50 CHAR),
		attribute_name         VARCHAR2(300 CHAR),
		attribute_type_id      NUMBER(5),
		object_type_id         NUMBER(5),
		value_type_id          NUMBER(5),
		value_table_owner      VARCHAR2(30 CHAR),
		value_table_name       VARCHAR2(30 CHAR),
		key_column_name        VARCHAR2(30 CHAR),
		value_column_name      VARCHAR2(30 CHAR),
		regular_expression     VARCHAR2(200 CHAR),
		list_type_id           NUMBER(5),
		multy_value_flag       CHAR(1),
		history_saving_mode_id NUMBER(5),
		get_value_function     VARCHAR2(100 CHAR),
		get_values_function    VARCHAR2(100 CHAR),
		set_value_procedure    VARCHAR2(100 CHAR),
		del_value_procedure    VARCHAR2(100 CHAR),
		state_id               NUMBER(5)
	) tablespace BRSDYND';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


-- Add/modify columns 
alter table ATTRIBUTE_KIND modify attribute_code VARCHAR2(50 CHAR);



PROMPT *** ALTER_POLICIES to ATTRIBUTE_KIND ***
 exec bpa.alter_policies('ATTRIBUTE_KIND');


COMMENT ON TABLE BARS.ATTRIBUTE_KIND IS '������� �������� ��''����. ������ ������� �������� ��������';
COMMENT ON COLUMN BARS.ATTRIBUTE_KIND.ATTRIBUTE_CODE IS '��� ��������';
COMMENT ON COLUMN BARS.ATTRIBUTE_KIND.ATTRIBUTE_NAME IS '����� ��������';
COMMENT ON COLUMN BARS.ATTRIBUTE_KIND.ATTRIBUTE_TYPE_ID IS '��� �������� - ���������� �������� ��������� ��� �������� � �������� ����, ������� �������� ��������� �������� �� ���� � ������������ ��������, ������������ �������� �� ��������� ��������, � ������ ���� ����������� ��� �����';
COMMENT ON COLUMN BARS.ATTRIBUTE_KIND.OBJECT_TYPE_ID IS '��� ��''����, ���� ��������� ����� �������';
COMMENT ON COLUMN BARS.ATTRIBUTE_KIND.VALUE_TYPE_ID IS '��� �������� ��������';
COMMENT ON COLUMN BARS.ATTRIBUTE_KIND.VALUE_TABLE_OWNER IS '';
COMMENT ON COLUMN BARS.ATTRIBUTE_KIND.VALUE_TABLE_NAME IS '';
COMMENT ON COLUMN BARS.ATTRIBUTE_KIND.KEY_COLUMN_NAME IS '';
COMMENT ON COLUMN BARS.ATTRIBUTE_KIND.VALUE_COLUMN_NAME IS '����� ����, �� ������ �������� ��������, � ������� ������������ ��������';
COMMENT ON COLUMN BARS.ATTRIBUTE_KIND.REGULAR_EXPRESSION IS '���������� ����� ��� �������� ������� ��� ����������� �������� �������� (����� ��� ��������� ��������)';
COMMENT ON COLUMN BARS.ATTRIBUTE_KIND.LIST_TYPE_ID IS '������������� ������, � ������� ������� ����� ���� ���������� �������� ������ ��������';
COMMENT ON COLUMN BARS.ATTRIBUTE_KIND.MULTY_VALUE_FLAG IS '������ ����, �� �� ������ ���� �������� ���� ���� ��������� ������� ������� ��� ���� �����';
COMMENT ON COLUMN BARS.ATTRIBUTE_KIND.HISTORY_SAVING_MODE_ID IS '����� ���������� ����� ������� �������� (�� �������� ������, �������� ������ �������, �������� ������ ������� �� ����)';
COMMENT ON COLUMN BARS.ATTRIBUTE_KIND.GET_VALUE_FUNCTION IS '�������, �� ����������� ��� ��������� �������� �������������� ��������';
COMMENT ON COLUMN BARS.ATTRIBUTE_KIND.GET_VALUES_FUNCTION IS '�������, �� ����������� ��� ��������� ������ ������� �������������� ��������, ���� ��� ������ �������� ������������ ������� ��������';
COMMENT ON COLUMN BARS.ATTRIBUTE_KIND.SET_VALUE_PROCEDURE IS '���������, �� ����������� ����� ������������� �������� ��������, ��� ������ ������� �������� ������������ ��������';
COMMENT ON COLUMN BARS.ATTRIBUTE_KIND.DEL_VALUE_PROCEDURE IS '���������, �� ����������� ����� ���������� �������� ��������, ��� ������ ��������� �������� ������������ ��������';
COMMENT ON COLUMN BARS.ATTRIBUTE_KIND.STATE_ID IS '������, � ����� �������� ������� (����� �������������, ��������, ��������)';
COMMENT ON COLUMN BARS.ATTRIBUTE_KIND.ID IS '������������� ��������';




PROMPT *** Create  constraint FK_ATTRIBUT_REFERENCE_OBJECT_T ***
begin   
 execute immediate '
  ALTER TABLE BARS.ATTRIBUTE_KIND ADD CONSTRAINT FK_ATTRIBUT_REFERENCE_OBJECT_T FOREIGN KEY (OBJECT_TYPE_ID)
	  REFERENCES BARS.OBJECT_TYPE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ATTRIBUT_REFERENCE_LIST_TYP ***
begin   
 execute immediate '
  ALTER TABLE BARS.ATTRIBUTE_KIND ADD CONSTRAINT FK_ATTRIBUT_REFERENCE_LIST_TYP FOREIGN KEY (LIST_TYPE_ID)
	  REFERENCES BARS.LIST_TYPE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_ATTRIBUTE_KIND ***
begin   
 execute immediate '
  ALTER TABLE BARS.ATTRIBUTE_KIND ADD CONSTRAINT UK_ATTRIBUTE_KIND UNIQUE (ATTRIBUTE_CODE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_ATTRIBUTE_KIND ***
begin   
 execute immediate '
  ALTER TABLE BARS.ATTRIBUTE_KIND ADD CONSTRAINT PK_ATTRIBUTE_KIND PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ATTR_HIST_MODE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ATTRIBUTE_KIND ADD CONSTRAINT CC_ATTR_HIST_MODE_NN CHECK (HISTORY_SAVING_MODE_ID IS NOT NULL) DEFERRABLE INITIALLY DEFERRED ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ATTR_MULTY_VALUE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ATTRIBUTE_KIND ADD CONSTRAINT CC_ATTR_MULTY_VALUE_NN CHECK (MULTY_VALUE_FLAG IS NOT NULL) DEFERRABLE INITIALLY DEFERRED ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ATTR_VALUE_TYPE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ATTRIBUTE_KIND ADD CONSTRAINT CC_ATTR_VALUE_TYPE_NN CHECK (VALUE_TYPE_ID IS NOT NULL) DEFERRABLE INITIALLY DEFERRED ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ATTR_OBJ_TYPE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ATTRIBUTE_KIND ADD CONSTRAINT CC_ATTR_OBJ_TYPE_NN CHECK (OBJECT_TYPE_ID IS NOT NULL) DEFERRABLE INITIALLY DEFERRED ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ATTR_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ATTRIBUTE_KIND ADD CONSTRAINT CC_ATTR_NAME_NN CHECK (ATTRIBUTE_NAME IS NOT NULL) DEFERRABLE INITIALLY DEFERRED ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ATTR_STATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ATTRIBUTE_KIND MODIFY (STATE_ID CONSTRAINT CC_ATTR_STATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ATTR_TYPE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ATTRIBUTE_KIND MODIFY (ATTRIBUTE_TYPE_ID CONSTRAINT CC_ATTR_TYPE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ATTR_CODE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ATTRIBUTE_KIND MODIFY (ATTRIBUTE_CODE CONSTRAINT CC_ATTR_CODE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ATTR_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ATTRIBUTE_KIND MODIFY (ID CONSTRAINT CC_ATTR_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ATTRIBUTE_KIND ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ATTRIBUTE_KIND ON BARS.ATTRIBUTE_KIND (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_ATTRIBUTE_KIND ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_ATTRIBUTE_KIND ON BARS.ATTRIBUTE_KIND (ATTRIBUTE_CODE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ATTRIBUTE_KIND ***
grant ALTER,DEBUG,DELETE,FLASHBACK,INDEX,INSERT,ON COMMIT REFRESH,QUERY REWRITE,REFERENCES,SELECT,UPDATE on ATTRIBUTE_KIND  to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ATTRIBUTE_KIND.sql =========*** End **
PROMPT ===================================================================================== 
