

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/STO_PRODUCT_BRANCH.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to STO_PRODUCT_BRANCH ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''STO_PRODUCT_BRANCH'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''STO_PRODUCT_BRANCH'', ''FILIAL'' , null, ''B'', ''B'', ''B'');
               bpa.alter_policy_info(''STO_PRODUCT_BRANCH'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table STO_PRODUCT_BRANCH ***
begin 
  execute immediate '
  CREATE TABLE BARS.STO_PRODUCT_BRANCH 
   (	PRODUCT_ID NUMBER(5,0), 
	BRANCH VARCHAR2(30 CHAR)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to STO_PRODUCT_BRANCH ***
 exec bpa.alter_policies('STO_PRODUCT_BRANCH');


COMMENT ON TABLE BARS.STO_PRODUCT_BRANCH IS '';
COMMENT ON COLUMN BARS.STO_PRODUCT_BRANCH.PRODUCT_ID IS '';
COMMENT ON COLUMN BARS.STO_PRODUCT_BRANCH.BRANCH IS '';




PROMPT *** Create  constraint FK_PROD_BRANCH_REF_PROD ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_PRODUCT_BRANCH ADD CONSTRAINT FK_PROD_BRANCH_REF_PROD FOREIGN KEY (PRODUCT_ID)
	  REFERENCES BARS.STO_PRODUCT (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_PROD_BRANCH_REF_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_PRODUCT_BRANCH ADD CONSTRAINT FK_PROD_BRANCH_REF_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009357 ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_PRODUCT_BRANCH MODIFY (PRODUCT_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009358 ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_PRODUCT_BRANCH MODIFY (BRANCH NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/STO_PRODUCT_BRANCH.sql =========*** En
PROMPT ===================================================================================== 
