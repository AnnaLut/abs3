

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/MBM_REL_CUSTOMERS_ADDRESS.sql ========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to MBM_REL_CUSTOMERS_ADDRESS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''MBM_REL_CUSTOMERS_ADDRESS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''MBM_REL_CUSTOMERS_ADDRESS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table MBM_REL_CUSTOMERS_ADDRESS ***
begin 
  execute immediate '
  CREATE TABLE BARS.MBM_REL_CUSTOMERS_ADDRESS 
   (	REL_CUST_ID NUMBER, 
	REGION_ID NUMBER, 
	CITY VARCHAR2(200), 
	STREET VARCHAR2(500), 
	HOUSE_NUMBER VARCHAR2(100), 
	ADDITION VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to MBM_REL_CUSTOMERS_ADDRESS ***
 exec bpa.alter_policies('MBM_REL_CUSTOMERS_ADDRESS');


COMMENT ON TABLE BARS.MBM_REL_CUSTOMERS_ADDRESS IS 'Адреси повязаних осіб котрим надано доступ до CorpLight';
COMMENT ON COLUMN BARS.MBM_REL_CUSTOMERS_ADDRESS.REL_CUST_ID IS '';
COMMENT ON COLUMN BARS.MBM_REL_CUSTOMERS_ADDRESS.REGION_ID IS '';
COMMENT ON COLUMN BARS.MBM_REL_CUSTOMERS_ADDRESS.CITY IS '';
COMMENT ON COLUMN BARS.MBM_REL_CUSTOMERS_ADDRESS.STREET IS '';
COMMENT ON COLUMN BARS.MBM_REL_CUSTOMERS_ADDRESS.HOUSE_NUMBER IS '';
COMMENT ON COLUMN BARS.MBM_REL_CUSTOMERS_ADDRESS.ADDITION IS '';




PROMPT *** Create  constraint SYS_C00111416 ***
begin   
 execute immediate '
  ALTER TABLE BARS.MBM_REL_CUSTOMERS_ADDRESS MODIFY (REL_CUST_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  MBM_REL_CUSTOMERS_ADDRESS ***
grant SELECT                                                                 on MBM_REL_CUSTOMERS_ADDRESS to BARSREADER_ROLE;
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on MBM_REL_CUSTOMERS_ADDRESS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on MBM_REL_CUSTOMERS_ADDRESS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/MBM_REL_CUSTOMERS_ADDRESS.sql ========
PROMPT ===================================================================================== 
