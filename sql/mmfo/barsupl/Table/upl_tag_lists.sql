

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSUPL/Table/UPL_TAG_LISTS.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  table UPL_TAG_LISTS ***
begin 
  execute immediate '
  CREATE TABLE BARSUPL.UPL_TAG_LISTS 
   (TAG_TABLE  VARCHAR2(20),
    TAG        VARCHAR2(20),
    ISUSE      NUMBER(1),
    REF_ID     NUMBER(5) DEFAULT 0
   )
  TABLESPACE BRSUPLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

COMMENT ON TABLE  BARSUPL.UPL_TAG_LISTS IS '������� ���������� ��� ������ ������� ����� ��������� ��� ����������� � ��������';
COMMENT ON COLUMN BARSUPL.UPL_TAG_LISTS.TAG_TABLE IS '������� ������������ ������� ����������';
COMMENT ON COLUMN BARSUPL.UPL_TAG_LISTS.TAG IS '��������';
COMMENT ON COLUMN BARSUPL.UPL_TAG_LISTS.ISUSE IS '1-������������ ��� ��������';
COMMENT ON COLUMN BARSUPL.UPL_TAG_LISTS.REF_ID IS 'ID �����������';


PROMPT *** Create  constraint FK_UPLTAGLISTS_TAGTABLE ***
begin
  execute immediate 'ALTER TABLE BARSUPL.UPL_TAG_LISTS ADD (CONSTRAINT FK_UPLTAGLISTS_TAGTABLE FOREIGN KEY (TAG_TABLE) REFERENCES BARSUPL.UPL_TAG_TABLES (TAG_TABLE) ENABLE VALIDATE)';
  exception when others then
    if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
end;
/


PROMPT *** Create  index PK_UPLTAGLISTS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSUPL.PK_UPLTAGLISTS ON BARSUPL.UPL_TAG_LISTS (TAG_TABLE, TAG)
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSUPLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

PROMPT *** Create  constraint PK_UPLTAGLISTS ***
begin   
 execute immediate '
  ALTER TABLE BARSUPL.UPL_TAG_LISTS ADD CONSTRAINT PK_UPLTAGLISTS PRIMARY KEY (TAG_TABLE, TAG)
  USING INDEX PK_UPLTAGLISTS ENABLE VALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

PROMPT *** Add column UPL_TAG_LISTS.REF_ID ***
begin
  execute immediate 'ALTER TABLE BARSUPL.UPL_TAG_LISTS ADD REF_ID NUMBER(5)';
  exception when others then
    if  sqlcode=-01430 then null; else raise; end if;
end;
/

PROMPT *** Create  constraint FK_UPLTAGLISTS_UPLTAGREF ***
begin
  execute immediate 'ALTER TABLE BARSUPL.UPL_TAG_LISTS ADD (CONSTRAINT FK_UPLTAGLISTS_UPLTAGREF FOREIGN KEY (REF_ID) REFERENCES BARSUPL.UPL_TAG_REF (REF_ID) ENABLE VALIDATE)';
  exception when others then
    if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
end;
/

PROMPT *** Create  grants  UPL_TAG_LISTS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on UPL_TAG_LISTS   to BARS;
grant DELETE,INSERT,SELECT,UPDATE                                            on UPL_TAG_LISTS   to UPLD;
--grant DELETE,INSERT,SELECT,UPDATE                                            on UPL_TAG_LISTS   to BARS_ROLE;




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSUPL/Table/UPL_TAG_LISTS.sql =========*** End 
PROMPT ===================================================================================== 
