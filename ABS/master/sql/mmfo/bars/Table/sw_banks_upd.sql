

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SW_BANKS_UPD.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SW_BANKS_UPD ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SW_BANKS_UPD'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SW_BANKS_UPD'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SW_BANKS_UPD'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SW_BANKS_UPD ***
begin 
  execute immediate '
  CREATE TABLE BARS.SW_BANKS_UPD 
   (	IDUPD NUMBER(38,0), 
	BIC CHAR(11), 
	NAME VARCHAR2(254), 
	OFFICE VARCHAR2(254), 
	CITY VARCHAR2(35), 
	COUNTRY VARCHAR2(64), 
	CHRSET VARCHAR2(5), 
	TRANSBACK NUMBER(1,0), 
	ACTION CHAR(1), 
	DATUPD DATE, 
	OTMKB NUMBER(1,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SW_BANKS_UPD ***
 exec bpa.alter_policies('SW_BANKS_UPD');


COMMENT ON TABLE BARS.SW_BANKS_UPD IS '';
COMMENT ON COLUMN BARS.SW_BANKS_UPD.IDUPD IS '';
COMMENT ON COLUMN BARS.SW_BANKS_UPD.BIC IS '';
COMMENT ON COLUMN BARS.SW_BANKS_UPD.NAME IS '';
COMMENT ON COLUMN BARS.SW_BANKS_UPD.OFFICE IS '';
COMMENT ON COLUMN BARS.SW_BANKS_UPD.CITY IS '';
COMMENT ON COLUMN BARS.SW_BANKS_UPD.COUNTRY IS '';
COMMENT ON COLUMN BARS.SW_BANKS_UPD.CHRSET IS '';
COMMENT ON COLUMN BARS.SW_BANKS_UPD.TRANSBACK IS '';
COMMENT ON COLUMN BARS.SW_BANKS_UPD.ACTION IS '';
COMMENT ON COLUMN BARS.SW_BANKS_UPD.DATUPD IS '';
COMMENT ON COLUMN BARS.SW_BANKS_UPD.OTMKB IS '';




PROMPT *** Create  constraint PK_SWBANKSUPD ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_BANKS_UPD ADD CONSTRAINT PK_SWBANKSUPD PRIMARY KEY (IDUPD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SWBANKSUPD_SWCHRSETS ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_BANKS_UPD ADD CONSTRAINT FK_SWBANKSUPD_SWCHRSETS FOREIGN KEY (CHRSET)
	  REFERENCES BARS.SW_CHRSETS (SETID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWBANKSUPD_IDUPD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_BANKS_UPD MODIFY (IDUPD CONSTRAINT CC_SWBANKSUPD_IDUPD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWBANKSUPD_ACTION_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_BANKS_UPD MODIFY (ACTION CONSTRAINT CC_SWBANKSUPD_ACTION_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWBANKSUPD_DATUPD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_BANKS_UPD MODIFY (DATUPD CONSTRAINT CC_SWBANKSUPD_DATUPD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SWBANKSUPD ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SWBANKSUPD ON BARS.SW_BANKS_UPD (IDUPD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SW_BANKS_UPD ***
grant DELETE,INSERT,SELECT,UPDATE                                            on SW_BANKS_UPD    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SW_BANKS_UPD    to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on SW_BANKS_UPD    to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SW_BANKS_UPD.sql =========*** End *** 
PROMPT ===================================================================================== 
