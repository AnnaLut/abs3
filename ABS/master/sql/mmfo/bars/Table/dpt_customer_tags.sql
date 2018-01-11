

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPT_CUSTOMER_TAGS.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPT_CUSTOMER_TAGS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPT_CUSTOMER_TAGS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DPT_CUSTOMER_TAGS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''DPT_CUSTOMER_TAGS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPT_CUSTOMER_TAGS ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPT_CUSTOMER_TAGS 
   (	TAG_CODE VARCHAR2(10), 
	TAG_NAME VARCHAR2(70), 
	TAG_TYPE VARCHAR2(10)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPT_CUSTOMER_TAGS ***
 exec bpa.alter_policies('DPT_CUSTOMER_TAGS');


COMMENT ON TABLE BARS.DPT_CUSTOMER_TAGS IS 'Перелік реквізитів клієнта';
COMMENT ON COLUMN BARS.DPT_CUSTOMER_TAGS.TAG_CODE IS 'Код реквізиту';
COMMENT ON COLUMN BARS.DPT_CUSTOMER_TAGS.TAG_NAME IS 'Назва реквізиту';
COMMENT ON COLUMN BARS.DPT_CUSTOMER_TAGS.TAG_TYPE IS '';




PROMPT *** Create  constraint PK_DPTCUSTOMERTAGS ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_CUSTOMER_TAGS ADD CONSTRAINT PK_DPTCUSTOMERTAGS PRIMARY KEY (TAG_CODE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint DPTCUSTOMERTAGS_TAGCODE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_CUSTOMER_TAGS MODIFY (TAG_CODE CONSTRAINT DPTCUSTOMERTAGS_TAGCODE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint DPTCUSTOMERTAGS_TAGNAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_CUSTOMER_TAGS MODIFY (TAG_NAME CONSTRAINT DPTCUSTOMERTAGS_TAGNAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint DPTCUSTOMERTAGS_TAGTYPE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_CUSTOMER_TAGS MODIFY (TAG_TYPE CONSTRAINT DPTCUSTOMERTAGS_TAGTYPE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DPTCUSTOMERTAGS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DPTCUSTOMERTAGS ON BARS.DPT_CUSTOMER_TAGS (TAG_CODE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPT_CUSTOMER_TAGS ***
grant SELECT                                                                 on DPT_CUSTOMER_TAGS to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_CUSTOMER_TAGS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPT_CUSTOMER_TAGS to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_CUSTOMER_TAGS to DPT_ADMIN;
grant SELECT                                                                 on DPT_CUSTOMER_TAGS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPT_CUSTOMER_TAGS.sql =========*** End
PROMPT ===================================================================================== 
