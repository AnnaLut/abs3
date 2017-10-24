

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/STO_PROD_EXTRA_ATTRIBUTES.sql ========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to STO_PROD_EXTRA_ATTRIBUTES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''STO_PROD_EXTRA_ATTRIBUTES'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''STO_PROD_EXTRA_ATTRIBUTES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''STO_PROD_EXTRA_ATTRIBUTES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table STO_PROD_EXTRA_ATTRIBUTES ***
begin 
  execute immediate '
  CREATE TABLE BARS.STO_PROD_EXTRA_ATTRIBUTES 
   (	PRODUCT_ID NUMBER(5,0), 
	EXTRA_ATTRIBUTES_METADATA CLOB
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND 
 LOB (EXTRA_ATTRIBUTES_METADATA) STORE AS BASICFILE (
  TABLESPACE BRSDYND ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to STO_PROD_EXTRA_ATTRIBUTES ***
 exec bpa.alter_policies('STO_PROD_EXTRA_ATTRIBUTES');


COMMENT ON TABLE BARS.STO_PROD_EXTRA_ATTRIBUTES IS '';
COMMENT ON COLUMN BARS.STO_PROD_EXTRA_ATTRIBUTES.PRODUCT_ID IS '';
COMMENT ON COLUMN BARS.STO_PROD_EXTRA_ATTRIBUTES.EXTRA_ATTRIBUTES_METADATA IS '';




PROMPT *** Create  constraint PK_STO_PROD_EXTRA_ATTRIBUTES ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_PROD_EXTRA_ATTRIBUTES ADD CONSTRAINT PK_STO_PROD_EXTRA_ATTRIBUTES PRIMARY KEY (PRODUCT_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_EXT_ATTRIB_REF_STO_PROD ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_PROD_EXTRA_ATTRIBUTES ADD CONSTRAINT FK_EXT_ATTRIB_REF_STO_PROD FOREIGN KEY (PRODUCT_ID)
	  REFERENCES BARS.STO_PRODUCT (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010450 ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_PROD_EXTRA_ATTRIBUTES MODIFY (PRODUCT_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010451 ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_PROD_EXTRA_ATTRIBUTES MODIFY (EXTRA_ATTRIBUTES_METADATA NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_STO_PROD_EXTRA_ATTRIBUTES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_STO_PROD_EXTRA_ATTRIBUTES ON BARS.STO_PROD_EXTRA_ATTRIBUTES (PRODUCT_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/STO_PROD_EXTRA_ATTRIBUTES.sql ========
PROMPT ===================================================================================== 
