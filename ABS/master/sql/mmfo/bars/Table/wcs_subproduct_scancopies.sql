

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/WCS_SUBPRODUCT_SCANCOPIES.sql ========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to WCS_SUBPRODUCT_SCANCOPIES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''WCS_SUBPRODUCT_SCANCOPIES'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_SUBPRODUCT_SCANCOPIES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_SUBPRODUCT_SCANCOPIES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table WCS_SUBPRODUCT_SCANCOPIES ***
begin 
  execute immediate '
  CREATE TABLE BARS.WCS_SUBPRODUCT_SCANCOPIES 
   (	SUBPRODUCT_ID VARCHAR2(100), 
	SCOPY_ID VARCHAR2(100)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to WCS_SUBPRODUCT_SCANCOPIES ***
 exec bpa.alter_policies('WCS_SUBPRODUCT_SCANCOPIES');


COMMENT ON TABLE BARS.WCS_SUBPRODUCT_SCANCOPIES IS 'Карта сканкопий субпродукта';
COMMENT ON COLUMN BARS.WCS_SUBPRODUCT_SCANCOPIES.SUBPRODUCT_ID IS 'Идентификатор субродукта';
COMMENT ON COLUMN BARS.WCS_SUBPRODUCT_SCANCOPIES.SCOPY_ID IS 'Идентификатор карты сканкопий';




PROMPT *** Create  constraint PK_SUBPRODUCTSCANCOPIES ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SUBPRODUCT_SCANCOPIES ADD CONSTRAINT PK_SUBPRODUCTSCANCOPIES PRIMARY KEY (SUBPRODUCT_ID, SCOPY_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SBPSC_SBPID_SBPS_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SUBPRODUCT_SCANCOPIES ADD CONSTRAINT FK_SBPSC_SBPID_SBPS_ID FOREIGN KEY (SUBPRODUCT_ID)
	  REFERENCES BARS.WCS_SUBPRODUCTS (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SBPSC_SID_SCOPIES_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SUBPRODUCT_SCANCOPIES ADD CONSTRAINT FK_SBPSC_SID_SCOPIES_ID FOREIGN KEY (SCOPY_ID)
	  REFERENCES BARS.WCS_SCANCOPIES (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SUBPRODUCTSCANCOPIES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SUBPRODUCTSCANCOPIES ON BARS.WCS_SUBPRODUCT_SCANCOPIES (SUBPRODUCT_ID, SCOPY_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  WCS_SUBPRODUCT_SCANCOPIES ***
grant SELECT                                                                 on WCS_SUBPRODUCT_SCANCOPIES to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on WCS_SUBPRODUCT_SCANCOPIES to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/WCS_SUBPRODUCT_SCANCOPIES.sql ========
PROMPT ===================================================================================== 
