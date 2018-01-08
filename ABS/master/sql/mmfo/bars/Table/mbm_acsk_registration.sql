

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/MBM_ACSK_REGISTRATION.sql =========***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to MBM_ACSK_REGISTRATION ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''MBM_ACSK_REGISTRATION'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''MBM_ACSK_REGISTRATION'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table MBM_ACSK_REGISTRATION ***
begin 
  execute immediate '
  CREATE TABLE BARS.MBM_ACSK_REGISTRATION 
   (	REGISTRATION_ID NUMBER, 
	REL_CUST_ID NUMBER, 
	ACSK_USER_ID VARCHAR2(128), 
	REGISTRATION_DATE DATE DEFAULT sysdate
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to MBM_ACSK_REGISTRATION ***
 exec bpa.alter_policies('MBM_ACSK_REGISTRATION');


COMMENT ON TABLE BARS.MBM_ACSK_REGISTRATION IS 'Çàðåºñòðîâàí³ â ÀÖÑÊ êë³ºíòà';
COMMENT ON COLUMN BARS.MBM_ACSK_REGISTRATION.REGISTRATION_ID IS '';
COMMENT ON COLUMN BARS.MBM_ACSK_REGISTRATION.REL_CUST_ID IS '';
COMMENT ON COLUMN BARS.MBM_ACSK_REGISTRATION.ACSK_USER_ID IS '';
COMMENT ON COLUMN BARS.MBM_ACSK_REGISTRATION.REGISTRATION_DATE IS '';




PROMPT *** Create  constraint SYS_C00111420 ***
begin   
 execute immediate '
  ALTER TABLE BARS.MBM_ACSK_REGISTRATION MODIFY (REGISTRATION_DATE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00111421 ***
begin   
 execute immediate '
  ALTER TABLE BARS.MBM_ACSK_REGISTRATION ADD PRIMARY KEY (REGISTRATION_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00111432 ***
begin   
 execute immediate '
  ALTER TABLE BARS.MBM_ACSK_REGISTRATION ADD FOREIGN KEY (REL_CUST_ID)
	  REFERENCES BARS.MBM_REL_CUSTOMERS (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00111419 ***
begin   
 execute immediate '
  ALTER TABLE BARS.MBM_ACSK_REGISTRATION MODIFY (REL_CUST_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index SYS_C00111421 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.SYS_C00111421 ON BARS.MBM_ACSK_REGISTRATION (REGISTRATION_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  MBM_ACSK_REGISTRATION ***
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on MBM_ACSK_REGISTRATION to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/MBM_ACSK_REGISTRATION.sql =========***
PROMPT ===================================================================================== 
