

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_NAEK_CUSTOMER_MAP.sql =========***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_NAEK_CUSTOMER_MAP ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_NAEK_CUSTOMER_MAP ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_NAEK_CUSTOMER_MAP 
   (	RNK NUMBER(*,0), 
	ECODE VARCHAR2(4), 
	KF VARCHAR2(6)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_NAEK_CUSTOMER_MAP ***
 exec bpa.alter_policies('TMP_NAEK_CUSTOMER_MAP');


COMMENT ON TABLE BARS.TMP_NAEK_CUSTOMER_MAP IS '';
COMMENT ON COLUMN BARS.TMP_NAEK_CUSTOMER_MAP.RNK IS '';
COMMENT ON COLUMN BARS.TMP_NAEK_CUSTOMER_MAP.ECODE IS '';
COMMENT ON COLUMN BARS.TMP_NAEK_CUSTOMER_MAP.KF IS '';




PROMPT *** Create  constraint SYS_C00119332 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_NAEK_CUSTOMER_MAP MODIFY (RNK NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00119334 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_NAEK_CUSTOMER_MAP MODIFY (KF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00119333 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_NAEK_CUSTOMER_MAP MODIFY (ECODE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_NAEK_CUSTOMER_MAP.sql =========***
PROMPT ===================================================================================== 
