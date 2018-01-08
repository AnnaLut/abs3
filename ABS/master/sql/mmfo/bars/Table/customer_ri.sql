

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CUSTOMER_RI.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CUSTOMER_RI ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CUSTOMER_RI'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CUSTOMER_RI'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CUSTOMER_RI'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CUSTOMER_RI ***
begin 
  execute immediate '
  CREATE TABLE BARS.CUSTOMER_RI 
   (	ID NUMBER, 
	IDCODE VARCHAR2(10), 
	DOCT NUMBER(2,0), 
	DOCS VARCHAR2(10), 
	DOCN VARCHAR2(10), 
	INSFORM NUMBER(1,0), 
	K060 NUMBER(2,0), 
	FILERI VARCHAR2(12), 
	DATERI DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CUSTOMER_RI ***
 exec bpa.alter_policies('CUSTOMER_RI');


COMMENT ON TABLE BARS.CUSTOMER_RI IS 'Реєстр інсайдерів (з DBF)';
COMMENT ON COLUMN BARS.CUSTOMER_RI.ID IS '';
COMMENT ON COLUMN BARS.CUSTOMER_RI.IDCODE IS 'Код за ЄДРПОУ/ДРФО';
COMMENT ON COLUMN BARS.CUSTOMER_RI.DOCT IS 'Тип документа';
COMMENT ON COLUMN BARS.CUSTOMER_RI.DOCS IS 'Серія документа';
COMMENT ON COLUMN BARS.CUSTOMER_RI.DOCN IS 'Номер документа';
COMMENT ON COLUMN BARS.CUSTOMER_RI.INSFORM IS 'Ознака наявності анкети інсайдера (0-ні,1-так)';
COMMENT ON COLUMN BARS.CUSTOMER_RI.K060 IS 'Код ознаки інсайдера';
COMMENT ON COLUMN BARS.CUSTOMER_RI.FILERI IS 'файл';
COMMENT ON COLUMN BARS.CUSTOMER_RI.DATERI IS 'дата файлу';




PROMPT *** Create  index IX1_CUSTOMER_RI ***
begin   
 execute immediate '
  CREATE INDEX BARS.IX1_CUSTOMER_RI ON BARS.CUSTOMER_RI (IDCODE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index IX2_CUSTOMER_RI ***
begin   
 execute immediate '
  CREATE INDEX BARS.IX2_CUSTOMER_RI ON BARS.CUSTOMER_RI (DOCT, DOCS, DOCN) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CUSTOMER_RI ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CUSTOMER_RI ON BARS.CUSTOMER_RI (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CUSTOMER_RI ***
grant SELECT                                                                 on CUSTOMER_RI     to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CUSTOMER_RI     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CUSTOMER_RI     to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CUSTOMER_RI     to TECH005;
grant SELECT                                                                 on CUSTOMER_RI     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CUSTOMER_RI.sql =========*** End *** =
PROMPT ===================================================================================== 
