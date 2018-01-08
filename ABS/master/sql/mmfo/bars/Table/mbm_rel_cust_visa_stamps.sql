

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/MBM_REL_CUST_VISA_STAMPS.sql =========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to MBM_REL_CUST_VISA_STAMPS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''MBM_REL_CUST_VISA_STAMPS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''MBM_REL_CUST_VISA_STAMPS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table MBM_REL_CUST_VISA_STAMPS ***
begin 
  execute immediate '
  CREATE TABLE BARS.MBM_REL_CUST_VISA_STAMPS 
   (	REL_CUST_ID NUMBER, 
	VISA_ID NUMBER, 
	USER_ID VARCHAR2(128), 
	VISA_DATE DATE, 
	KEY_ID VARCHAR2(200), 
	SIGNATURE CLOB
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND 
 LOB (SIGNATURE) STORE AS BASICFILE (
  TABLESPACE BRSDYND ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to MBM_REL_CUST_VISA_STAMPS ***
 exec bpa.alter_policies('MBM_REL_CUST_VISA_STAMPS');


COMMENT ON TABLE BARS.MBM_REL_CUST_VISA_STAMPS IS 'Підписи профіля користувача до CorpLight';
COMMENT ON COLUMN BARS.MBM_REL_CUST_VISA_STAMPS.REL_CUST_ID IS '';
COMMENT ON COLUMN BARS.MBM_REL_CUST_VISA_STAMPS.VISA_ID IS '';
COMMENT ON COLUMN BARS.MBM_REL_CUST_VISA_STAMPS.USER_ID IS '';
COMMENT ON COLUMN BARS.MBM_REL_CUST_VISA_STAMPS.VISA_DATE IS '';
COMMENT ON COLUMN BARS.MBM_REL_CUST_VISA_STAMPS.KEY_ID IS '';
COMMENT ON COLUMN BARS.MBM_REL_CUST_VISA_STAMPS.SIGNATURE IS '';




PROMPT *** Create  constraint SYS_C00111431 ***
begin   
 execute immediate '
  ALTER TABLE BARS.MBM_REL_CUST_VISA_STAMPS ADD FOREIGN KEY (REL_CUST_ID)
	  REFERENCES BARS.MBM_REL_CUSTOMERS (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00111417 ***
begin   
 execute immediate '
  ALTER TABLE BARS.MBM_REL_CUST_VISA_STAMPS MODIFY (REL_CUST_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00111418 ***
begin   
 execute immediate '
  ALTER TABLE BARS.MBM_REL_CUST_VISA_STAMPS MODIFY (VISA_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  MBM_REL_CUST_VISA_STAMPS ***
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on MBM_REL_CUST_VISA_STAMPS to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/MBM_REL_CUST_VISA_STAMPS.sql =========
PROMPT ===================================================================================== 
