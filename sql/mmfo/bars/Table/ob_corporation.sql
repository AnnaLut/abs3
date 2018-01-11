

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OB_CORPORATION.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OB_CORPORATION ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OB_CORPORATION'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''OB_CORPORATION'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OB_CORPORATION ***
begin 
  execute immediate '
  CREATE TABLE BARS.OB_CORPORATION 
   (	ID NUMBER(5,0), 
	CORPORATION_CODE VARCHAR2(15 CHAR), 
	CORPORATION_NAME VARCHAR2(300 CHAR), 
	PARENT_ID NUMBER(5,0), 
	STATE_ID NUMBER(5,0), 
	EXTERNAL_ID VARCHAR2(30 CHAR)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OB_CORPORATION ***
 exec bpa.alter_policies('OB_CORPORATION');


COMMENT ON TABLE BARS.OB_CORPORATION IS '������� ���������� �� ���������';
COMMENT ON COLUMN BARS.OB_CORPORATION.ID IS '������������� ����������';
COMMENT ON COLUMN BARS.OB_CORPORATION.CORPORATION_CODE IS '��� ���������� �������';
COMMENT ON COLUMN BARS.OB_CORPORATION.CORPORATION_NAME IS '����� ����������';
COMMENT ON COLUMN BARS.OB_CORPORATION.PARENT_ID IS '������������� ����������� ��������';
COMMENT ON COLUMN BARS.OB_CORPORATION.STATE_ID IS '������ ����������� 1-�������. 0-�������';
COMMENT ON COLUMN BARS.OB_CORPORATION.EXTERNAL_ID IS '������� �������������';




PROMPT *** Create  constraint SYS_C00126426 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OB_CORPORATION MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CORPORATION_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OB_CORPORATION ADD CONSTRAINT CC_CORPORATION_NAME_NN CHECK (CORPORATION_NAME IS NOT NULL) DEFERRABLE INITIALLY DEFERRED ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_OB_CORPORATION ***
begin   
 execute immediate '
  ALTER TABLE BARS.OB_CORPORATION ADD CONSTRAINT PK_OB_CORPORATION PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00126430 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OB_CORPORATION ADD CHECK (EXTERNAL_ID IS NOT NULL) DEFERRABLE INITIALLY DEFERRED ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_OB_CORPORATION ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_OB_CORPORATION ON BARS.OB_CORPORATION (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OB_CORPORATION ***
grant SELECT                                                                 on OB_CORPORATION  to BARSREADER_ROLE;
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on OB_CORPORATION  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on OB_CORPORATION  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OB_CORPORATION.sql =========*** End **
PROMPT ===================================================================================== 
