

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/FM_CATEGORY.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to FM_CATEGORY ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''FM_CATEGORY'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''FM_CATEGORY'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''FM_CATEGORY'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table FM_CATEGORY ***
begin 
  execute immediate '
  CREATE TABLE BARS.FM_CATEGORY 
   (	ID NUMBER(10,0), 
	NAME VARCHAR2(1000), 
	REZID NUMBER(1,0), 
	INUSE NUMBER(1,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to FM_CATEGORY ***
 exec bpa.alter_policies('FM_CATEGORY');


COMMENT ON TABLE BARS.FM_CATEGORY IS 'ФМ. Особові категорії';
COMMENT ON COLUMN BARS.FM_CATEGORY.ID IS 'Ід.';
COMMENT ON COLUMN BARS.FM_CATEGORY.NAME IS 'Назва';
COMMENT ON COLUMN BARS.FM_CATEGORY.REZID IS '';
COMMENT ON COLUMN BARS.FM_CATEGORY.INUSE IS 'Ознака використання';




PROMPT *** Create  constraint CC_FMCATEGORY_REZID ***
begin   
 execute immediate '
  ALTER TABLE BARS.FM_CATEGORY ADD CONSTRAINT CC_FMCATEGORY_REZID CHECK (rezid in (1,2)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_FMCATEGORY_INUSE ***
begin   
 execute immediate '
  ALTER TABLE BARS.FM_CATEGORY ADD CONSTRAINT CC_FMCATEGORY_INUSE CHECK (inuse in (0,1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_FMCATEGORY ***
begin   
 execute immediate '
  ALTER TABLE BARS.FM_CATEGORY ADD CONSTRAINT PK_FMCATEGORY PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_FMCATEGORY_INUSE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.FM_CATEGORY MODIFY (INUSE CONSTRAINT CC_FMCATEGORY_INUSE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_FMCATEGORY ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_FMCATEGORY ON BARS.FM_CATEGORY (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  FM_CATEGORY ***
grant SELECT                                                                 on FM_CATEGORY     to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on FM_CATEGORY     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on FM_CATEGORY     to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on FM_CATEGORY     to CUST001;
grant DELETE,INSERT,SELECT,UPDATE                                            on FM_CATEGORY     to FINMON01;
grant SELECT                                                                 on FM_CATEGORY     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/FM_CATEGORY.sql =========*** End *** =
PROMPT ===================================================================================== 
