

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPT_FILE_ROW_ACCUM.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPT_FILE_ROW_ACCUM ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPT_FILE_ROW_ACCUM'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DPT_FILE_ROW_ACCUM'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''DPT_FILE_ROW_ACCUM'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPT_FILE_ROW_ACCUM ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPT_FILE_ROW_ACCUM 
   (	FILENAME VARCHAR2(16), 
	DAT DATE, 
	INFO_LENGTH NUMBER(6,0), 
	SUM NUMBER(19,0), 
	BRANCH VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch''), 
	HEADER_ID NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPT_FILE_ROW_ACCUM ***
 exec bpa.alter_policies('DPT_FILE_ROW_ACCUM');


COMMENT ON TABLE BARS.DPT_FILE_ROW_ACCUM IS '';
COMMENT ON COLUMN BARS.DPT_FILE_ROW_ACCUM.FILENAME IS '';
COMMENT ON COLUMN BARS.DPT_FILE_ROW_ACCUM.DAT IS '';
COMMENT ON COLUMN BARS.DPT_FILE_ROW_ACCUM.INFO_LENGTH IS '';
COMMENT ON COLUMN BARS.DPT_FILE_ROW_ACCUM.SUM IS '';
COMMENT ON COLUMN BARS.DPT_FILE_ROW_ACCUM.BRANCH IS '';
COMMENT ON COLUMN BARS.DPT_FILE_ROW_ACCUM.HEADER_ID IS '';




PROMPT *** Create  constraint PK_DPTFILEROWACCUM ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_FILE_ROW_ACCUM ADD CONSTRAINT PK_DPTFILEROWACCUM PRIMARY KEY (HEADER_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTFILEROWACCUM_INFO_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_FILE_ROW_ACCUM MODIFY (INFO_LENGTH CONSTRAINT CC_DPTFILEROWACCUM_INFO_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTFILEROWACCUM_SUM_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_FILE_ROW_ACCUM MODIFY (SUM CONSTRAINT CC_DPTFILEROWACCUM_SUM_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTFILEROWACCUM_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_FILE_ROW_ACCUM MODIFY (BRANCH CONSTRAINT CC_DPTFILEROWACCUM_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTFILEROWACCUM_HEADERID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_FILE_ROW_ACCUM MODIFY (HEADER_ID CONSTRAINT CC_DPTFILEROWACCUM_HEADERID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DPTFILEROWACCUM ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DPTFILEROWACCUM ON BARS.DPT_FILE_ROW_ACCUM (HEADER_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPT_FILE_ROW_ACCUM ***
grant SELECT                                                                 on DPT_FILE_ROW_ACCUM to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_FILE_ROW_ACCUM to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPT_FILE_ROW_ACCUM to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_FILE_ROW_ACCUM to DPT_ROLE;
grant SELECT                                                                 on DPT_FILE_ROW_ACCUM to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPT_FILE_ROW_ACCUM to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPT_FILE_ROW_ACCUM.sql =========*** En
PROMPT ===================================================================================== 
