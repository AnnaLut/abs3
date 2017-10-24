

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BRANCH_TAGS.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BRANCH_TAGS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BRANCH_TAGS'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''BRANCH_TAGS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BRANCH_TAGS ***
begin 
  execute immediate '
  CREATE TABLE BARS.BRANCH_TAGS 
   (	TAG VARCHAR2(16), 
	NAME VARCHAR2(64), 
	NBS CHAR(4), 
	OB22 CHAR(2)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BRANCH_TAGS ***
 exec bpa.alter_policies('BRANCH_TAGS');


COMMENT ON TABLE BARS.BRANCH_TAGS IS '���� ���������� ������������� ���������';
COMMENT ON COLUMN BARS.BRANCH_TAGS.TAG IS '��� ���������';
COMMENT ON COLUMN BARS.BRANCH_TAGS.NAME IS '������������ ���������';
COMMENT ON COLUMN BARS.BRANCH_TAGS.NBS IS '�����.���.��';
COMMENT ON COLUMN BARS.BRANCH_TAGS.OB22 IS '�����.��22';




PROMPT *** Create  constraint FK_BRANCHTAGS_NBSOB22 ***
begin   
 execute immediate '
  ALTER TABLE BARS.BRANCH_TAGS ADD CONSTRAINT FK_BRANCHTAGS_NBSOB22 FOREIGN KEY (NBS, OB22)
	  REFERENCES BARS.SB_OB22 (R020, OB22) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_BRANCHTAGS ***
begin   
 execute immediate '
  ALTER TABLE BARS.BRANCH_TAGS ADD CONSTRAINT PK_BRANCHTAGS PRIMARY KEY (TAG)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BRANCHTAGS_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BRANCH_TAGS MODIFY (NAME CONSTRAINT CC_BRANCHTAGS_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BRANCHTAGS_TAG_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BRANCH_TAGS MODIFY (TAG CONSTRAINT CC_BRANCHTAGS_TAG_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_BRANCHTAGS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_BRANCHTAGS ON BARS.BRANCH_TAGS (TAG) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BRANCH_TAGS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on BRANCH_TAGS     to ABS_ADMIN;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on BRANCH_TAGS     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on BRANCH_TAGS     to KLBX;
grant SELECT                                                                 on BRANCH_TAGS     to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on BRANCH_TAGS     to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on BRANCH_TAGS     to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BRANCH_TAGS.sql =========*** End *** =
PROMPT ===================================================================================== 
