

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/WCS_SUBPRODUCT_SOLVENCY.sql =========*
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to WCS_SUBPRODUCT_SOLVENCY ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''WCS_SUBPRODUCT_SOLVENCY'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_SUBPRODUCT_SOLVENCY'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_SUBPRODUCT_SOLVENCY'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table WCS_SUBPRODUCT_SOLVENCY ***
begin 
  execute immediate '
  CREATE TABLE BARS.WCS_SUBPRODUCT_SOLVENCY 
   (	SUBPRODUCT_ID VARCHAR2(100), 
	SOLV_ID VARCHAR2(100)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to WCS_SUBPRODUCT_SOLVENCY ***
 exec bpa.alter_policies('WCS_SUBPRODUCT_SOLVENCY');


COMMENT ON TABLE BARS.WCS_SUBPRODUCT_SOLVENCY IS 'Карта кредитоспособности субпродукта';
COMMENT ON COLUMN BARS.WCS_SUBPRODUCT_SOLVENCY.SUBPRODUCT_ID IS 'Идентификатор субродукта';
COMMENT ON COLUMN BARS.WCS_SUBPRODUCT_SOLVENCY.SOLV_ID IS 'Идентификатор карты кредитоспособности';




PROMPT *** Create  constraint PK_SPRDSOLV ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SUBPRODUCT_SOLVENCY ADD CONSTRAINT PK_SPRDSOLV PRIMARY KEY (SUBPRODUCT_ID, SOLV_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SPRDSOLV_SBPID_SBPS_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SUBPRODUCT_SOLVENCY ADD CONSTRAINT FK_SPRDSOLV_SBPID_SBPS_ID FOREIGN KEY (SUBPRODUCT_ID)
	  REFERENCES BARS.WCS_SUBPRODUCTS (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SPRDSOLV_SID_SOLVS_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SUBPRODUCT_SOLVENCY ADD CONSTRAINT FK_SPRDSOLV_SID_SOLVS_ID FOREIGN KEY (SOLV_ID)
	  REFERENCES BARS.WCS_SOLVENCIES (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SPRDSOLV ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SPRDSOLV ON BARS.WCS_SUBPRODUCT_SOLVENCY (SUBPRODUCT_ID, SOLV_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  WCS_SUBPRODUCT_SOLVENCY ***
grant SELECT                                                                 on WCS_SUBPRODUCT_SOLVENCY to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on WCS_SUBPRODUCT_SOLVENCY to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/WCS_SUBPRODUCT_SOLVENCY.sql =========*
PROMPT ===================================================================================== 
