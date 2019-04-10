PROMPT ===================================================================================== 
PROMPT *** Run *** ======= Scripts /Sql/BARS/Table/PROCESS_WORKFLOW.sql ======== *** Run *** 
PROMPT ===================================================================================== 

BEGIN 
   execute immediate  
      'begin  
          bpa.alter_policy_info(''PROCESS_WORKFLOW'', ''CENTER'' , null, null, null, null);
          bpa.alter_policy_info(''PROCESS_WORKFLOW'', ''FILIAL'' , null, null, null, null);
          bpa.alter_policy_info(''PROCESS_WORKFLOW'', ''WHOLE'' , null, null, null, null);
          null;
       end; 
      '; 
END; 
/

PROMPT *** Create  table PROCESS_WORKFLOW ***
begin 
   execute immediate '
   CREATE TABLE PROCESS_WORKFLOW  
   (
      ID                 NUMBER(38)    NOT NULL,
      PROCESS_TYPE_ID    NUMBER(38)            ,
      ACTIVITY_CODE      VARCHAR2(50)  NOT NULL,
      ACTIVITY_NAME      VARCHAR2(300) NOT NULL,
      MANUAL_RUN_FLAG    CHAR(1)       NOT NULL,
      MANUAL_REVERT_FLAG CHAR(1)       NOT NULL,
      NEED_CREATE        VARCHAR2(100)         ,
      CAN_CREATE         VARCHAR2(100)         ,
      CAN_RUN            VARCHAR2(100)         ,
      CAN_REVERT         VARCHAR2(100)         ,
      CAN_REMOVE         VARCHAR2(100)         ,
      CAN_OMIT           VARCHAR2(100)         ,
      ON_CREATE          VARCHAR2(100)         ,
      ON_RUN             VARCHAR2(100)         ,
      ON_REVERT          VARCHAR2(100)         ,
      ON_REMOVE          VARCHAR2(100)         ,
      IS_ACTIVE          CHAR(1)       NOT NULL
   ) SEGMENT CREATION IMMEDIATE 
   PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
   NOCOMPRESS LOGGING
   TABLESPACE BRSMDLD ';
exception when others then       
   if sqlcode=-955 then null; else raise; end if; 
end; 
/

PROMPT *** ALTER_POLICIES to PROCESS_WORKFLOW ***
exec bpa.alter_policies('PROCESS_WORKFLOW');

COMMENT ON TABLE  BARS.PROCESS_WORKFLOW                    IS '����� �������';
COMMENT ON COLUMN BARS.PROCESS_WORKFLOW.ID                 IS '������������� ����� �������';
COMMENT ON COLUMN BARS.PROCESS_WORKFLOW.PROCESS_TYPE_ID    IS '��� �������, �� ����� �������� ����� ����';
COMMENT ON COLUMN BARS.PROCESS_WORKFLOW.ACTIVITY_CODE      IS '��� ����� �������� �������';
COMMENT ON COLUMN BARS.PROCESS_WORKFLOW.ACTIVITY_NAME      IS '����� ����� �������� �������';
COMMENT ON COLUMN BARS.PROCESS_WORKFLOW.MANUAL_RUN_FLAG    IS '������ ����, �� ��������� ��������� ������ ����� ������� ������ ��� ���� ��������� - ����������� ���������� ����� ���� ������� ������� �� �������';
COMMENT ON COLUMN BARS.PROCESS_WORKFLOW.MANUAL_REVERT_FLAG IS '������ ����, �� ����� ���� ���������� ������� ����������� ��� �������� ��� ����� ���� �������- ���� ����� ������� ��������� ������ ��� ���� ���������';
COMMENT ON COLUMN BARS.PROCESS_WORKFLOW.NEED_CREATE        IS '��������� �������� ����������� ��������� ������ �����   ';                                                                                                                     
COMMENT ON COLUMN BARS.PROCESS_WORKFLOW.CAN_CREATE         IS '��������� �������� ���� �� ��������� ������ ����� �� ���������� � ���������� ���������� ����� ��� ��������� ����� �����';
COMMENT ON COLUMN BARS.PROCESS_WORKFLOW.CAN_RUN            IS '��������� �������� ���� �� ��������� ������ �����';
COMMENT ON COLUMN BARS.PROCESS_WORKFLOW.CAN_REVERT         IS '��������� �������� ���� �� ����� �����   ';
COMMENT ON COLUMN BARS.PROCESS_WORKFLOW.CAN_REMOVE         IS '��������� �������� ���� �� ����� ��������� �����';
COMMENT ON COLUMN BARS.PROCESS_WORKFLOW.CAN_OMIT           IS '��������� �������� ��������� ���������� ��������� ������ �����';
COMMENT ON COLUMN BARS.PROCESS_WORKFLOW.ON_CREATE          IS '��������� �������, �� �����������  ��� �������� ������ �����';
COMMENT ON COLUMN BARS.PROCESS_WORKFLOW.ON_RUN             IS '��������� �������, �� ����������� ��� �������� �����';
COMMENT ON COLUMN BARS.PROCESS_WORKFLOW.ON_REVERT          IS '��������� �������, �� ����������� ��� ���� ���, ��������� �� ������ �����';
COMMENT ON COLUMN BARS.PROCESS_WORKFLOW.ON_REMOVE          IS '��������� �������, �� ����������� ��� ������� �������� �����';
COMMENT ON COLUMN BARS.PROCESS_WORKFLOW.IS_ACTIVE          IS '������ ��������� ����� � ����� �������� �������'; 

PROMPT *** Create  constraint PK_PROCESS_WORKFLOW ***
begin   
   execute immediate '
   ALTER TABLE BARS.PROCESS_WORKFLOW ADD CONSTRAINT PK_PROCESS_WORKFLOW PRIMARY KEY (ID)
   USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
   TABLESPACE BRSMDLI ENABLE';
exception when others then
   if sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264
      or sqlcode=-2275 or sqlcode=-1442 then 
      null; 
   else 
      raise; 
   end if;
end;
/


PROMPT *** Create  constraint CC_PROCESS_WORKFLOW_IS_ACTIVE ***
begin   
   execute immediate '
   ALTER TABLE BARS.PROCESS_WORKFLOW 
   ADD CONSTRAINT CC_PROCESS_WORKFLOW_IS_ACTIVE CHECK (IS_ACTIVE IN (''N'', ''Y'')) 
   DEFERRABLE INITIALLY DEFERRED ENABLE';
exception when others then
   if sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264
      or sqlcode=-2275 or sqlcode=-1442 then 
      null; 
   else 
      raise; 
   end if;
end;
/

PROMPT *** Create  constraint CC_PROC_FLOW_MANUAL_RUN_FL   ***
begin   
   execute immediate '
   ALTER TABLE BARS.PROCESS_WORKFLOW 
   ADD CONSTRAINT CC_PROC_FLOW_MANUAL_RUN_FL CHECK (MANUAL_RUN_FLAG IN (''N'', ''Y'')) 
   DEFERRABLE INITIALLY DEFERRED ENABLE';
exception when others then
   if sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264
      or sqlcode=-2275 or sqlcode=-1442 then 
      null; 
   else 
      raise; 
   end if;
end;
/

PROMPT *** Create  constraint CC_PROC_FLOW_MANUAL_REVERT_FL ***
begin   
   execute immediate '
   ALTER TABLE BARS.PROCESS_WORKFLOW 
   ADD CONSTRAINT CC_PROC_FLOW_MANUAL_REVERT_FL CHECK (MANUAL_REVERT_FLAG IN (''N'', ''Y'')) 
   DEFERRABLE INITIALLY DEFERRED ENABLE';
exception when others then
   if sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264
      or sqlcode=-2275 or sqlcode=-1442 then 
      null; 
   else 
     raise; 
   end if;
end;
/

PROMPT *** Create unique index UIX_PROCESS_WORKFLOW ***
begin   
   execute immediate '
   CREATE UNIQUE INDEX BARS.UIX_PROCESS_WORKFLOW ON BARS.PROCESS_WORKFLOW (PROCESS_TYPE_ID, ACTIVITY_CODE) 
   PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
   TABLESPACE BRSMDLI ';
exception when others then
   if sqlcode=-955 then null; else raise; end if;
end;
/

PROMPT *** Create  grants  PROCESS_WORKFLOW ***
grant SELECT, INSERT, UPDATE, DELETE on PROCESS_WORKFLOW to BARS_ACCESS_DEFROLE;

PROMPT ===================================================================================== 
PROMPT *** End *** ======== Scripts /Sql/BARS/Table/PROCESS_WORKFLOW.sql ======= *** End ***
PROMPT ===================================================================================== 
