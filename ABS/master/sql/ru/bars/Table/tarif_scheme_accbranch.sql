

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TARIF_SCHEME_ACCBRANCH.sql =========**
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TARIF_SCHEME_ACCBRANCH ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TARIF_SCHEME_ACCBRANCH'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''TARIF_SCHEME_ACCBRANCH'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TARIF_SCHEME_ACCBRANCH ***
begin 
  execute immediate '
  CREATE TABLE BARS.TARIF_SCHEME_ACCBRANCH 
   (	ID NUMBER, 
	BRANCH VARCHAR2(30), 
	DAT_BEGIN DATE, 
	DAT_END DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TARIF_SCHEME_ACCBRANCH ***
 exec bpa.alter_policies('TARIF_SCHEME_ACCBRANCH');


COMMENT ON TABLE BARS.TARIF_SCHEME_ACCBRANCH IS '����� ������� � ������� ���������';
COMMENT ON COLUMN BARS.TARIF_SCHEME_ACCBRANCH.ID IS '��.';
COMMENT ON COLUMN BARS.TARIF_SCHEME_ACCBRANCH.BRANCH IS '���������';
COMMENT ON COLUMN BARS.TARIF_SCHEME_ACCBRANCH.DAT_BEGIN IS '���� ������';
COMMENT ON COLUMN BARS.TARIF_SCHEME_ACCBRANCH.DAT_END IS '���� ���������';




PROMPT *** Create  constraint FK_TARIFSCHEMEACCBR_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.TARIF_SCHEME_ACCBRANCH ADD CONSTRAINT FK_TARIFSCHEMEACCBR_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_TARIFSCHEMEACCBR_TARIFSCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.TARIF_SCHEME_ACCBRANCH ADD CONSTRAINT FK_TARIFSCHEMEACCBR_TARIFSCH FOREIGN KEY (ID)
	  REFERENCES BARS.TARIF_SCHEME (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_TARIFSCHEMEACCBRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.TARIF_SCHEME_ACCBRANCH ADD CONSTRAINT PK_TARIFSCHEMEACCBRANCH PRIMARY KEY (ID, BRANCH)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TARIFSCHEMEACCBR_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TARIF_SCHEME_ACCBRANCH MODIFY (BRANCH CONSTRAINT CC_TARIFSCHEMEACCBR_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TARIFSCHEMEACCBR_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TARIF_SCHEME_ACCBRANCH MODIFY (ID CONSTRAINT CC_TARIFSCHEMEACCBR_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_TARIFSCHEMEACCBRANCH ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_TARIFSCHEMEACCBRANCH ON BARS.TARIF_SCHEME_ACCBRANCH (ID, BRANCH) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TARIF_SCHEME_ACCBRANCH ***
grant DELETE,INSERT,SELECT,UPDATE                                            on TARIF_SCHEME_ACCBRANCH to ABS_ADMIN;
grant SELECT                                                                 on TARIF_SCHEME_ACCBRANCH to START1;
grant FLASHBACK,SELECT                                                       on TARIF_SCHEME_ACCBRANCH to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TARIF_SCHEME_ACCBRANCH.sql =========**
PROMPT ===================================================================================== 
