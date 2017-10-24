

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/EBKC_CARD_ATTRIBUTES.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to EBKC_CARD_ATTRIBUTES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''EBKC_CARD_ATTRIBUTES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''EBKC_CARD_ATTRIBUTES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table EBKC_CARD_ATTRIBUTES ***
begin 
  execute immediate '
  CREATE TABLE BARS.EBKC_CARD_ATTRIBUTES 
   (	NAME VARCHAR2(50), 
	CUST_TYPE VARCHAR2(1), 
	GROUP_ID NUMBER(1,0), 
	TYPE VARCHAR2(15), 
	REQUIRED NUMBER(1,0) DEFAULT 0, 
	DESCR VARCHAR2(100), 
	SORT_NUM NUMBER(3,0), 
	ACTION VARCHAR2(450), 
	LIST_OF_VALUES VARCHAR2(100), 
	PAGE_ITEM_VIEW VARCHAR2(30)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to EBKC_CARD_ATTRIBUTES ***
 exec bpa.alter_policies('EBKC_CARD_ATTRIBUTES');


COMMENT ON TABLE BARS.EBKC_CARD_ATTRIBUTES IS 'Таблица реквизитов ЮО с типом, описанием ,списком значений и действием по их изменению';
COMMENT ON COLUMN BARS.EBKC_CARD_ATTRIBUTES.NAME IS '';
COMMENT ON COLUMN BARS.EBKC_CARD_ATTRIBUTES.CUST_TYPE IS '';
COMMENT ON COLUMN BARS.EBKC_CARD_ATTRIBUTES.GROUP_ID IS '';
COMMENT ON COLUMN BARS.EBKC_CARD_ATTRIBUTES.TYPE IS '';
COMMENT ON COLUMN BARS.EBKC_CARD_ATTRIBUTES.REQUIRED IS '';
COMMENT ON COLUMN BARS.EBKC_CARD_ATTRIBUTES.DESCR IS '';
COMMENT ON COLUMN BARS.EBKC_CARD_ATTRIBUTES.SORT_NUM IS '';
COMMENT ON COLUMN BARS.EBKC_CARD_ATTRIBUTES.ACTION IS '';
COMMENT ON COLUMN BARS.EBKC_CARD_ATTRIBUTES.LIST_OF_VALUES IS '';
COMMENT ON COLUMN BARS.EBKC_CARD_ATTRIBUTES.PAGE_ITEM_VIEW IS '';




PROMPT *** Create  constraint FK_EBKCCARDATTR_CUSTTYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.EBKC_CARD_ATTRIBUTES ADD CONSTRAINT FK_EBKCCARDATTR_CUSTTYPE FOREIGN KEY (CUST_TYPE)
	  REFERENCES BARS.EBKC_CUST_TYPES (CUST_TYPE) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_EBKC_CARDATTR ***
begin   
 execute immediate '
  ALTER TABLE BARS.EBKC_CARD_ATTRIBUTES ADD CONSTRAINT PK_EBKC_CARDATTR PRIMARY KEY (NAME, CUST_TYPE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_EBKC_CARDATTR ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_EBKC_CARDATTR ON BARS.EBKC_CARD_ATTRIBUTES (NAME, CUST_TYPE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  EBKC_CARD_ATTRIBUTES ***
grant DELETE,INSERT,SELECT,UPDATE                                            on EBKC_CARD_ATTRIBUTES to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on EBKC_CARD_ATTRIBUTES to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/EBKC_CARD_ATTRIBUTES.sql =========*** 
PROMPT ===================================================================================== 
