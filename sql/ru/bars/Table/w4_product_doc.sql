

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/W4_PRODUCT_DOC.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to W4_PRODUCT_DOC ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''W4_PRODUCT_DOC'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''W4_PRODUCT_DOC'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table W4_PRODUCT_DOC ***
begin 
  execute immediate '
  CREATE TABLE BARS.W4_PRODUCT_DOC 
   (	GRP_CODE VARCHAR2(32), 
	DOC_ID VARCHAR2(35)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to W4_PRODUCT_DOC ***
 exec bpa.alter_policies('W4_PRODUCT_DOC');


COMMENT ON TABLE BARS.W4_PRODUCT_DOC IS 'Way4. ������� ��������';
COMMENT ON COLUMN BARS.W4_PRODUCT_DOC.GRP_CODE IS '����� ��������';
COMMENT ON COLUMN BARS.W4_PRODUCT_DOC.DOC_ID IS '��� �������';




PROMPT *** Create  constraint FK_W4PRODUCTDOC_DOCSCHEME ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_PRODUCT_DOC ADD CONSTRAINT FK_W4PRODUCTDOC_DOCSCHEME FOREIGN KEY (DOC_ID)
	  REFERENCES BARS.DOC_SCHEME (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_W4PRODUCTDOC_W4PRODUCTGRP ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_PRODUCT_DOC ADD CONSTRAINT FK_W4PRODUCTDOC_W4PRODUCTGRP FOREIGN KEY (GRP_CODE)
	  REFERENCES BARS.W4_PRODUCT_GROUPS (CODE) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_W4PRODUCTDOC ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_PRODUCT_DOC ADD CONSTRAINT PK_W4PRODUCTDOC PRIMARY KEY (GRP_CODE, DOC_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_W4PRODUCTDOC_DOCID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_PRODUCT_DOC MODIFY (DOC_ID CONSTRAINT CC_W4PRODUCTDOC_DOCID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_W4PRODUCTDOC_GRPCODE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_PRODUCT_DOC MODIFY (GRP_CODE CONSTRAINT CC_W4PRODUCTDOC_GRPCODE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_W4PRODUCTDOC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_W4PRODUCTDOC ON BARS.W4_PRODUCT_DOC (GRP_CODE, DOC_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  W4_PRODUCT_DOC ***
grant DELETE,INSERT,SELECT,UPDATE                                            on W4_PRODUCT_DOC  to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on W4_PRODUCT_DOC  to OW;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/W4_PRODUCT_DOC.sql =========*** End **
PROMPT ===================================================================================== 
