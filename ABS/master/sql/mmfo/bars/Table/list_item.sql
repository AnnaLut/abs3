

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/LIST_ITEM.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to LIST_ITEM ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''LIST_ITEM'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''LIST_ITEM'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''LIST_ITEM'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table LIST_ITEM ***
begin 
  execute immediate '
  CREATE TABLE BARS.LIST_ITEM 
   (	LIST_TYPE_ID NUMBER(5,0), 
	LIST_ITEM_ID NUMBER(5,0), 
	LIST_ITEM_CODE VARCHAR2(30 CHAR), 
	LIST_ITEM_NAME VARCHAR2(4000), 
	PARENT_LIST_ITEM_ID NUMBER(5,0), 
	IS_ACTIVE CHAR(1)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to LIST_ITEM ***
 exec bpa.alter_policies('LIST_ITEM');


COMMENT ON TABLE BARS.LIST_ITEM IS 'Набір елементів списків';
COMMENT ON COLUMN BARS.LIST_ITEM.LIST_TYPE_ID IS '';
COMMENT ON COLUMN BARS.LIST_ITEM.LIST_ITEM_ID IS '';
COMMENT ON COLUMN BARS.LIST_ITEM.LIST_ITEM_CODE IS '';
COMMENT ON COLUMN BARS.LIST_ITEM.LIST_ITEM_NAME IS '';
COMMENT ON COLUMN BARS.LIST_ITEM.PARENT_LIST_ITEM_ID IS '';
COMMENT ON COLUMN BARS.LIST_ITEM.IS_ACTIVE IS '';




PROMPT *** Create  constraint PK_LIST_ITEM ***
begin   
 execute immediate '
  ALTER TABLE BARS.LIST_ITEM ADD CONSTRAINT PK_LIST_ITEM PRIMARY KEY (LIST_TYPE_ID, LIST_ITEM_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ENUM_VAL_REF_PARENT ***
begin   
 execute immediate '
  ALTER TABLE BARS.LIST_ITEM ADD CONSTRAINT FK_ENUM_VAL_REF_PARENT FOREIGN KEY (LIST_TYPE_ID, PARENT_LIST_ITEM_ID)
	  REFERENCES BARS.LIST_ITEM (LIST_TYPE_ID, LIST_ITEM_ID) DISABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ENUM_VAL_REF_EN_TYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.LIST_ITEM ADD CONSTRAINT FK_ENUM_VAL_REF_EN_TYPE FOREIGN KEY (LIST_TYPE_ID)
	  REFERENCES BARS.LIST_TYPE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008118 ***
begin   
 execute immediate '
  ALTER TABLE BARS.LIST_ITEM MODIFY (LIST_TYPE_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008119 ***
begin   
 execute immediate '
  ALTER TABLE BARS.LIST_ITEM MODIFY (LIST_ITEM_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008120 ***
begin   
 execute immediate '
  ALTER TABLE BARS.LIST_ITEM MODIFY (LIST_ITEM_CODE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008121 ***
begin   
 execute immediate '
  ALTER TABLE BARS.LIST_ITEM MODIFY (LIST_ITEM_NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008122 ***
begin   
 execute immediate '
  ALTER TABLE BARS.LIST_ITEM MODIFY (IS_ACTIVE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_LIST_ITEM ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_LIST_ITEM ON BARS.LIST_ITEM (LIST_TYPE_ID, LIST_ITEM_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index LIST_ITEM_IDX ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.LIST_ITEM_IDX ON BARS.LIST_ITEM (LIST_ITEM_CODE, CASE  WHEN LIST_ITEM_CODE IS NULL THEN NULL ELSE LIST_TYPE_ID END ) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  LIST_ITEM ***
grant SELECT                                                                 on LIST_ITEM       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on LIST_ITEM       to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/LIST_ITEM.sql =========*** End *** ===
PROMPT ===================================================================================== 
