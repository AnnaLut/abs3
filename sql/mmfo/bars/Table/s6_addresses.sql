

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/S6_Addresses.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to S6_Addresses ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''S6_Addresses'', ''FILIAL'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table S6_Addresses ***
begin 
  execute immediate '
  CREATE TABLE BARS.S6_Addresses 
   (	BIC NUMBER(10,0), 
	Id NUMBER(10,0), 
	TypeAddress NUMBER(3,0), 
	PostInd VARCHAR2(10), 
	Region VARCHAR2(40), 
	City VARCHAR2(40), 
	Street VARCHAR2(40), 
	House VARCHAR2(20), 
	Apartment VARCHAR2(20), 
	Description VARCHAR2(200), 
	D_Modify DATE, 
	ISP_Modify NUMBER(5,0), 
	Doc_Modify NUMBER(10,0), 
	Country VARCHAR2(20), 
	Rayon VARCHAR2(25), 
	Phone VARCHAR2(20), 
	Fax VARCHAR2(20), 
	Mobile VARCHAR2(20), 
	EMail VARCHAR2(20)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to S6_Addresses ***
 exec bpa.alter_policies('S6_Addresses');


COMMENT ON TABLE BARS.S6_Addresses IS '';
COMMENT ON COLUMN BARS.S6_Addresses.BIC IS '';
COMMENT ON COLUMN BARS.S6_Addresses.Id IS '';
COMMENT ON COLUMN BARS.S6_Addresses.TypeAddress IS '';
COMMENT ON COLUMN BARS.S6_Addresses.PostInd IS '';
COMMENT ON COLUMN BARS.S6_Addresses.Region IS '';
COMMENT ON COLUMN BARS.S6_Addresses.City IS '';
COMMENT ON COLUMN BARS.S6_Addresses.Street IS '';
COMMENT ON COLUMN BARS.S6_Addresses.House IS '';
COMMENT ON COLUMN BARS.S6_Addresses.Apartment IS '';
COMMENT ON COLUMN BARS.S6_Addresses.Description IS '';
COMMENT ON COLUMN BARS.S6_Addresses.D_Modify IS '';
COMMENT ON COLUMN BARS.S6_Addresses.ISP_Modify IS '';
COMMENT ON COLUMN BARS.S6_Addresses.Doc_Modify IS '';
COMMENT ON COLUMN BARS.S6_Addresses.Country IS '';
COMMENT ON COLUMN BARS.S6_Addresses.Rayon IS '';
COMMENT ON COLUMN BARS.S6_Addresses.Phone IS '';
COMMENT ON COLUMN BARS.S6_Addresses.Fax IS '';
COMMENT ON COLUMN BARS.S6_Addresses.Mobile IS '';
COMMENT ON COLUMN BARS.S6_Addresses.EMail IS '';




PROMPT *** Create  constraint SYS_C005750 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_Addresses MODIFY (BIC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005751 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_Addresses MODIFY (Id NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005752 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_Addresses MODIFY (TypeAddress NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  S6_Addresses ***
grant SELECT                                                                 on S6_Addresses    to BARSREADER_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/S6_Addresses.sql =========*** End *** 
PROMPT ===================================================================================== 
