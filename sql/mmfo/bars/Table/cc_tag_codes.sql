

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CC_TAG_CODES.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CC_TAG_CODES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CC_TAG_CODES'', ''CENTER'' , ''C'', ''C'', ''C'', null);
               bpa.alter_policy_info(''CC_TAG_CODES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CC_TAG_CODES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CC_TAG_CODES ***
begin 
  execute immediate '
  CREATE TABLE BARS.CC_TAG_CODES 
   (	CODE VARCHAR2(30), 
	NAME VARCHAR2(30), 
	ORD NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CC_TAG_CODES ***
 exec bpa.alter_policies('CC_TAG_CODES');


COMMENT ON TABLE BARS.CC_TAG_CODES IS 'Коды разделов доп.реквизитов для КД';
COMMENT ON COLUMN BARS.CC_TAG_CODES.CODE IS 'Код';
COMMENT ON COLUMN BARS.CC_TAG_CODES.NAME IS 'Наименование';
COMMENT ON COLUMN BARS.CC_TAG_CODES.ORD IS 'Сортировка';




PROMPT *** Create  constraint CC_CCTAGCODES_CODE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_TAG_CODES MODIFY (CODE CONSTRAINT CC_CCTAGCODES_CODE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_CCTAGCODES ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_TAG_CODES ADD CONSTRAINT PK_CCTAGCODES PRIMARY KEY (CODE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CCTAGCODES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CCTAGCODES ON BARS.CC_TAG_CODES (CODE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CC_TAG_CODES ***
grant SELECT                                                                 on CC_TAG_CODES    to BARSREADER_ROLE;
grant SELECT                                                                 on CC_TAG_CODES    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CC_TAG_CODES    to BARS_DM;
grant SELECT                                                                 on CC_TAG_CODES    to RCC_DEAL;
grant SELECT                                                                 on CC_TAG_CODES    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CC_TAG_CODES.sql =========*** End *** 
PROMPT ===================================================================================== 
