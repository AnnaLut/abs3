

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SW_950_ARCH.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SW_950_ARCH ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SW_950_ARCH'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SW_950_ARCH'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SW_950_ARCH'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SW_950_ARCH ***
begin 
  execute immediate '
  CREATE TABLE BARS.SW_950_ARCH 
   (	SWREF NUMBER(38,0), 
	NOSTRO_ACC NUMBER(38,0), 
	NUM VARCHAR2(35), 
	STMT_DATE DATE, 
	OBAL NUMBER(24,0), 
	CBAL NUMBER(24,0), 
	ADD_INFO VARCHAR2(400), 
	DONE NUMBER(1,0), 
	STMT_BDATE DATE, 
	KV NUMBER(3,0), 
	KF VARCHAR2(6)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SW_950_ARCH ***
 exec bpa.alter_policies('SW_950_ARCH');


COMMENT ON TABLE BARS.SW_950_ARCH IS '';
COMMENT ON COLUMN BARS.SW_950_ARCH.SWREF IS '';
COMMENT ON COLUMN BARS.SW_950_ARCH.NOSTRO_ACC IS '';
COMMENT ON COLUMN BARS.SW_950_ARCH.NUM IS '';
COMMENT ON COLUMN BARS.SW_950_ARCH.STMT_DATE IS '';
COMMENT ON COLUMN BARS.SW_950_ARCH.OBAL IS '';
COMMENT ON COLUMN BARS.SW_950_ARCH.CBAL IS '';
COMMENT ON COLUMN BARS.SW_950_ARCH.ADD_INFO IS '';
COMMENT ON COLUMN BARS.SW_950_ARCH.DONE IS '';
COMMENT ON COLUMN BARS.SW_950_ARCH.STMT_BDATE IS '';
COMMENT ON COLUMN BARS.SW_950_ARCH.KV IS '';
COMMENT ON COLUMN BARS.SW_950_ARCH.KF IS '';




PROMPT *** Create  constraint PK_SW_950_ARCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_950_ARCH ADD CONSTRAINT PK_SW_950_ARCH PRIMARY KEY (SWREF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009462 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_950_ARCH MODIFY (CBAL NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009458 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_950_ARCH MODIFY (SWREF NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009459 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_950_ARCH MODIFY (NUM NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009460 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_950_ARCH MODIFY (STMT_DATE NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009461 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_950_ARCH MODIFY (OBAL NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009463 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_950_ARCH MODIFY (STMT_BDATE NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009464 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_950_ARCH MODIFY (KV NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009465 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_950_ARCH MODIFY (KF NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SW_950_ARCH ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SW_950_ARCH ON BARS.SW_950_ARCH (SWREF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SW_950_ARCH ***
grant SELECT                                                                 on SW_950_ARCH     to BARSREADER_ROLE;
grant INSERT,SELECT,UPDATE                                                   on SW_950_ARCH     to BARS_ACCESS_DEFROLE;
grant INSERT,SELECT,UPDATE                                                   on SW_950_ARCH     to START1;
grant SELECT                                                                 on SW_950_ARCH     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SW_950_ARCH.sql =========*** End *** =
PROMPT ===================================================================================== 
