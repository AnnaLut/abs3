

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/WCS_BCK_XMLBLOCKS.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to WCS_BCK_XMLBLOCKS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''WCS_BCK_XMLBLOCKS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_BCK_XMLBLOCKS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_BCK_XMLBLOCKS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table WCS_BCK_XMLBLOCKS ***
begin 
  execute immediate '
  CREATE TABLE BARS.WCS_BCK_XMLBLOCKS 
   (	BLOCK_ID NUMBER(2,0), 
	BLOCK_NAME VARCHAR2(64), 
	BLOCK_TAG VARCHAR2(64)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to WCS_BCK_XMLBLOCKS ***
 exec bpa.alter_policies('WCS_BCK_XMLBLOCKS');


COMMENT ON TABLE BARS.WCS_BCK_XMLBLOCKS IS 'Справочник блоков XML-отчета кредитного бюро';
COMMENT ON COLUMN BARS.WCS_BCK_XMLBLOCKS.BLOCK_ID IS 'Идентификатор блока';
COMMENT ON COLUMN BARS.WCS_BCK_XMLBLOCKS.BLOCK_NAME IS 'Наименование блока';
COMMENT ON COLUMN BARS.WCS_BCK_XMLBLOCKS.BLOCK_TAG IS 'Родительский тэг блока';




PROMPT *** Create  constraint PK_WCSBCKXMLBLKS ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_BCK_XMLBLOCKS ADD CONSTRAINT PK_WCSBCKXMLBLKS PRIMARY KEY (BLOCK_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_WCSBCKXMLBLKS_BLKNAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_BCK_XMLBLOCKS MODIFY (BLOCK_NAME CONSTRAINT CC_WCSBCKXMLBLKS_BLKNAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_WCSBCKXMLBLKS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_WCSBCKXMLBLKS ON BARS.WCS_BCK_XMLBLOCKS (BLOCK_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  WCS_BCK_XMLBLOCKS ***
grant SELECT                                                                 on WCS_BCK_XMLBLOCKS to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on WCS_BCK_XMLBLOCKS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on WCS_BCK_XMLBLOCKS to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on WCS_BCK_XMLBLOCKS to START1;
grant SELECT                                                                 on WCS_BCK_XMLBLOCKS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/WCS_BCK_XMLBLOCKS.sql =========*** End
PROMPT ===================================================================================== 
