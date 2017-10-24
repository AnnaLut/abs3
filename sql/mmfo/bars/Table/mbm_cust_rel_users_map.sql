

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/MBM_CUST_REL_USERS_MAP.sql =========**
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to MBM_CUST_REL_USERS_MAP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''MBM_CUST_REL_USERS_MAP'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''MBM_CUST_REL_USERS_MAP'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table MBM_CUST_REL_USERS_MAP ***
begin 
  execute immediate '
  CREATE TABLE BARS.MBM_CUST_REL_USERS_MAP 
   (	CUST_ID NUMBER, 
	REL_CUST_ID NUMBER, 
	SIGN_NUMBER NUMBER(10,0) DEFAULT 0, 
	USER_ID VARCHAR2(128), 
	IS_APPROVED NUMBER, 
	APPROVED_TYPE VARCHAR2(100)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to MBM_CUST_REL_USERS_MAP ***
 exec bpa.alter_policies('MBM_CUST_REL_USERS_MAP');


COMMENT ON TABLE BARS.MBM_CUST_REL_USERS_MAP IS 'Повязані особи котрим надано доступ до CorpLight';
COMMENT ON COLUMN BARS.MBM_CUST_REL_USERS_MAP.CUST_ID IS 'ID клієнта';
COMMENT ON COLUMN BARS.MBM_CUST_REL_USERS_MAP.REL_CUST_ID IS 'ID повязаної особи';
COMMENT ON COLUMN BARS.MBM_CUST_REL_USERS_MAP.SIGN_NUMBER IS '№ підпису';
COMMENT ON COLUMN BARS.MBM_CUST_REL_USERS_MAP.USER_ID IS 'Id користувача з CorpLight';
COMMENT ON COLUMN BARS.MBM_CUST_REL_USERS_MAP.IS_APPROVED IS 'Признак чи підтверджено зміни бек офісом';
COMMENT ON COLUMN BARS.MBM_CUST_REL_USERS_MAP.APPROVED_TYPE IS 'Тип змін, що потрібно підтвердити';




PROMPT *** Create  constraint SYS_C00111427 ***
begin   
 execute immediate '
  ALTER TABLE BARS.MBM_CUST_REL_USERS_MAP ADD FOREIGN KEY (REL_CUST_ID)
	  REFERENCES BARS.MBM_REL_CUSTOMERS (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00111428 ***
begin   
 execute immediate '
  ALTER TABLE BARS.MBM_CUST_REL_USERS_MAP ADD FOREIGN KEY (CUST_ID)
	  REFERENCES BARS.CUSTOMER (RNK) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00111412 ***
begin   
 execute immediate '
  ALTER TABLE BARS.MBM_CUST_REL_USERS_MAP MODIFY (CUST_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00111413 ***
begin   
 execute immediate '
  ALTER TABLE BARS.MBM_CUST_REL_USERS_MAP MODIFY (REL_CUST_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00111414 ***
begin   
 execute immediate '
  ALTER TABLE BARS.MBM_CUST_REL_USERS_MAP MODIFY (SIGN_NUMBER NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  MBM_CUST_REL_USERS_MAP ***
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on MBM_CUST_REL_USERS_MAP to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/MBM_CUST_REL_USERS_MAP.sql =========**
PROMPT ===================================================================================== 
