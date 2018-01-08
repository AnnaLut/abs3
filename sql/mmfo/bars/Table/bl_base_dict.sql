

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BL_BASE_DICT.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BL_BASE_DICT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BL_BASE_DICT'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''BL_BASE_DICT'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''BL_BASE_DICT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BL_BASE_DICT ***
begin 
  execute immediate '
  CREATE TABLE BARS.BL_BASE_DICT 
   (	BASE_ID NUMBER, 
	NAME VARCHAR2(50)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BL_BASE_DICT ***
 exec bpa.alter_policies('BL_BASE_DICT');


COMMENT ON TABLE BARS.BL_BASE_DICT IS 'Тип використовуваного первинного ключа';
COMMENT ON COLUMN BARS.BL_BASE_DICT.BASE_ID IS 'Ідентифікатор';
COMMENT ON COLUMN BARS.BL_BASE_DICT.NAME IS 'Назва ідентифікатора';




PROMPT *** Create  constraint BL_BASE_DICT_PK ***
begin   
 execute immediate '
  ALTER TABLE BARS.BL_BASE_DICT ADD CONSTRAINT BL_BASE_DICT_PK PRIMARY KEY (BASE_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007829 ***
begin   
 execute immediate '
  ALTER TABLE BARS.BL_BASE_DICT MODIFY (BASE_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007830 ***
begin   
 execute immediate '
  ALTER TABLE BARS.BL_BASE_DICT MODIFY (NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index BL_BASE_DICT_PK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.BL_BASE_DICT_PK ON BARS.BL_BASE_DICT (BASE_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BL_BASE_DICT ***
grant SELECT                                                                 on BL_BASE_DICT    to BARSREADER_ROLE;
grant SELECT                                                                 on BL_BASE_DICT    to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on BL_BASE_DICT    to RBL;
grant SELECT                                                                 on BL_BASE_DICT    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BL_BASE_DICT.sql =========*** End *** 
PROMPT ===================================================================================== 
