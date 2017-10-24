

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_RNK2RNK_LIST_CUSTOMER.sql ========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_RNK2RNK_LIST_CUSTOMER ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_RNK2RNK_LIST_CUSTOMER ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_RNK2RNK_LIST_CUSTOMER 
   (	RNKFROM NUMBER(*,0), 
	RNKTO NUMBER(*,0), 
	USERID NUMBER(*,0), 
	ERR VARCHAR2(250)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_RNK2RNK_LIST_CUSTOMER ***
 exec bpa.alter_policies('TMP_RNK2RNK_LIST_CUSTOMER');


COMMENT ON TABLE BARS.TMP_RNK2RNK_LIST_CUSTOMER IS '';
COMMENT ON COLUMN BARS.TMP_RNK2RNK_LIST_CUSTOMER.RNKFROM IS '';
COMMENT ON COLUMN BARS.TMP_RNK2RNK_LIST_CUSTOMER.RNKTO IS '';
COMMENT ON COLUMN BARS.TMP_RNK2RNK_LIST_CUSTOMER.USERID IS '';
COMMENT ON COLUMN BARS.TMP_RNK2RNK_LIST_CUSTOMER.ERR IS '';




PROMPT *** Create  constraint UK_TMP_RNK2RNK_LIST_CUSTOMER ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_RNK2RNK_LIST_CUSTOMER ADD CONSTRAINT UK_TMP_RNK2RNK_LIST_CUSTOMER UNIQUE (RNKFROM, RNKTO)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint TMP_RNK2RNK_LIST_CUSTOMER_PK ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_RNK2RNK_LIST_CUSTOMER ADD CONSTRAINT TMP_RNK2RNK_LIST_CUSTOMER_PK PRIMARY KEY (RNKFROM)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index TMP_RNK2RNK_LIST_CUSTOMER_PK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.TMP_RNK2RNK_LIST_CUSTOMER_PK ON BARS.TMP_RNK2RNK_LIST_CUSTOMER (RNKFROM) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_TMP_RNK2RNK_LIST_CUSTOMER ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_TMP_RNK2RNK_LIST_CUSTOMER ON BARS.TMP_RNK2RNK_LIST_CUSTOMER (RNKFROM, RNKTO) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_RNK2RNK_LIST_CUSTOMER ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TMP_RNK2RNK_LIST_CUSTOMER to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_RNK2RNK_LIST_CUSTOMER to START1;
grant FLASHBACK,SELECT                                                       on TMP_RNK2RNK_LIST_CUSTOMER to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_RNK2RNK_LIST_CUSTOMER.sql ========
PROMPT ===================================================================================== 
