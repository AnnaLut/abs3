

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CIM_BENEFICIARIES.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CIM_BENEFICIARIES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CIM_BENEFICIARIES'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CIM_BENEFICIARIES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CIM_BENEFICIARIES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CIM_BENEFICIARIES ***
begin 
  execute immediate '
  CREATE TABLE BARS.CIM_BENEFICIARIES 
   (	BENEF_ID NUMBER, 
	BENEF_NAME VARCHAR2(256 CHAR), 
	COUNTRY_ID NUMBER(3,0), 
	BENEF_ADR VARCHAR2(256 CHAR), 
	COMMENTS VARCHAR2(256 CHAR), 
	DELETE_DATE DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ROWDEPENDENCIES ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CIM_BENEFICIARIES ***
 exec bpa.alter_policies('CIM_BENEFICIARIES');


COMMENT ON TABLE BARS.CIM_BENEFICIARIES IS 'Довідник контрагентів v1.0';
COMMENT ON COLUMN BARS.CIM_BENEFICIARIES.BENEF_ID IS 'Код контрагента';
COMMENT ON COLUMN BARS.CIM_BENEFICIARIES.BENEF_NAME IS 'Назва контрагента';
COMMENT ON COLUMN BARS.CIM_BENEFICIARIES.COUNTRY_ID IS 'Код країни контрагента';
COMMENT ON COLUMN BARS.CIM_BENEFICIARIES.BENEF_ADR IS '';
COMMENT ON COLUMN BARS.CIM_BENEFICIARIES.COMMENTS IS 'Коментар';
COMMENT ON COLUMN BARS.CIM_BENEFICIARIES.DELETE_DATE IS 'Дата видалення';




PROMPT *** Create  constraint PK_CIMBENEFICIARIES ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_BENEFICIARIES ADD CONSTRAINT PK_CIMBENEFICIARIES PRIMARY KEY (BENEF_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMBENEF_BENEFID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_BENEFICIARIES MODIFY (BENEF_ID CONSTRAINT CC_CIMBENEF_BENEFID_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMBENEF_BENEFNAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_BENEFICIARIES MODIFY (BENEF_NAME CONSTRAINT CC_CIMBENEF_BENEFNAME_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CIMBENEFICIARIES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CIMBENEFICIARIES ON BARS.CIM_BENEFICIARIES (BENEF_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CIM_BENEFICIARIES ***
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_BENEFICIARIES to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CIM_BENEFICIARIES to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_BENEFICIARIES to CIM_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_BENEFICIARIES to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CIM_BENEFICIARIES.sql =========*** End
PROMPT ===================================================================================== 
