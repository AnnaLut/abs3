

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/EBKC_CUST_TYPES.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to EBKC_CUST_TYPES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''EBKC_CUST_TYPES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''EBKC_CUST_TYPES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table EBKC_CUST_TYPES ***
begin 
  execute immediate '
  CREATE TABLE BARS.EBKC_CUST_TYPES 
   (	CUST_TYPE VARCHAR2(1), 
	TXT VARCHAR2(100), 
	 CONSTRAINT PK_EBKC_CUST_TYPES PRIMARY KEY (CUST_TYPE) ENABLE
   ) ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING
  TABLESPACE BRSDYND 
 PCTTHRESHOLD 50';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to EBKC_CUST_TYPES ***
 exec bpa.alter_policies('EBKC_CUST_TYPES');


COMMENT ON TABLE BARS.EBKC_CUST_TYPES IS 'Òèï êë³ºíòà';
COMMENT ON COLUMN BARS.EBKC_CUST_TYPES.CUST_TYPE IS 'L - þðîñîáà, P - ÔÎÏ';
COMMENT ON COLUMN BARS.EBKC_CUST_TYPES.TXT IS '';




PROMPT *** Create  constraint PK_EBKC_CUST_TYPES ***
begin   
 execute immediate '
  ALTER TABLE BARS.EBKC_CUST_TYPES ADD CONSTRAINT PK_EBKC_CUST_TYPES PRIMARY KEY (CUST_TYPE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_EBKC_CUST_TYPES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_EBKC_CUST_TYPES ON BARS.EBKC_CUST_TYPES (CUST_TYPE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  EBKC_CUST_TYPES ***
grant SELECT                                                                 on EBKC_CUST_TYPES to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on EBKC_CUST_TYPES to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on EBKC_CUST_TYPES to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/EBKC_CUST_TYPES.sql =========*** End *
PROMPT ===================================================================================== 
