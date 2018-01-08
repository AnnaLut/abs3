

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DEPRICATED_BRANCH_TAGS.sql =========**
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DEPRICATED_BRANCH_TAGS ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DEPRICATED_BRANCH_TAGS ***
begin 
  execute immediate '
  CREATE TABLE BARS.DEPRICATED_BRANCH_TAGS 
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




PROMPT *** ALTER_POLICIES to DEPRICATED_BRANCH_TAGS ***
 exec bpa.alter_policies('DEPRICATED_BRANCH_TAGS');


COMMENT ON TABLE BARS.DEPRICATED_BRANCH_TAGS IS 'Тэги параметров безбалансовых отделений';
COMMENT ON COLUMN BARS.DEPRICATED_BRANCH_TAGS.TAG IS 'Тэг параметра';
COMMENT ON COLUMN BARS.DEPRICATED_BRANCH_TAGS.NAME IS 'Наименование параметра';
COMMENT ON COLUMN BARS.DEPRICATED_BRANCH_TAGS.NBS IS 'Умолч.БАЛ.сч';
COMMENT ON COLUMN BARS.DEPRICATED_BRANCH_TAGS.OB22 IS 'Умолч.ОБ22';




PROMPT *** Create  constraint CC_BRANCHTAGS_TAG_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEPRICATED_BRANCH_TAGS MODIFY (TAG CONSTRAINT CC_BRANCHTAGS_TAG_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BRANCHTAGS_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEPRICATED_BRANCH_TAGS MODIFY (NAME CONSTRAINT CC_BRANCHTAGS_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_BRANCHTAGS ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEPRICATED_BRANCH_TAGS ADD CONSTRAINT PK_BRANCHTAGS PRIMARY KEY (TAG)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_BRANCHTAGS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_BRANCHTAGS ON BARS.DEPRICATED_BRANCH_TAGS (TAG) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DEPRICATED_BRANCH_TAGS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on DEPRICATED_BRANCH_TAGS to ABS_ADMIN;
grant SELECT                                                                 on DEPRICATED_BRANCH_TAGS to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DEPRICATED_BRANCH_TAGS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DEPRICATED_BRANCH_TAGS to BARS_DM;
grant SELECT                                                                 on DEPRICATED_BRANCH_TAGS to KLBX;
grant SELECT                                                                 on DEPRICATED_BRANCH_TAGS to START1;
grant SELECT                                                                 on DEPRICATED_BRANCH_TAGS to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DEPRICATED_BRANCH_TAGS to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on DEPRICATED_BRANCH_TAGS to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DEPRICATED_BRANCH_TAGS.sql =========**
PROMPT ===================================================================================== 
