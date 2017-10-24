

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/WCS_SUBPRODUCT_INFOQUERIES.sql =======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to WCS_SUBPRODUCT_INFOQUERIES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''WCS_SUBPRODUCT_INFOQUERIES'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_SUBPRODUCT_INFOQUERIES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_SUBPRODUCT_INFOQUERIES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table WCS_SUBPRODUCT_INFOQUERIES ***
begin 
  execute immediate '
  CREATE TABLE BARS.WCS_SUBPRODUCT_INFOQUERIES 
   (	SUBPRODUCT_ID VARCHAR2(100), 
	IQUERY_ID VARCHAR2(100), 
	ACT_LEVEL NUMBER, 
	SERVICE_ID VARCHAR2(100), 
	IS_REQUIRED NUMBER DEFAULT 1, 
	ORD NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to WCS_SUBPRODUCT_INFOQUERIES ***
 exec bpa.alter_policies('WCS_SUBPRODUCT_INFOQUERIES');


COMMENT ON TABLE BARS.WCS_SUBPRODUCT_INFOQUERIES IS 'Карта информационных запросов суб-продукта';
COMMENT ON COLUMN BARS.WCS_SUBPRODUCT_INFOQUERIES.SUBPRODUCT_ID IS 'Идентификатор субпродукта';
COMMENT ON COLUMN BARS.WCS_SUBPRODUCT_INFOQUERIES.IQUERY_ID IS 'Идентификатор информационного запроса';
COMMENT ON COLUMN BARS.WCS_SUBPRODUCT_INFOQUERIES.ACT_LEVEL IS 'Уровень активации';
COMMENT ON COLUMN BARS.WCS_SUBPRODUCT_INFOQUERIES.SERVICE_ID IS 'Исполняющая служба (если ручной)';
COMMENT ON COLUMN BARS.WCS_SUBPRODUCT_INFOQUERIES.IS_REQUIRED IS 'Обязателен ли для выполнения';
COMMENT ON COLUMN BARS.WCS_SUBPRODUCT_INFOQUERIES.ORD IS 'Порядок';




PROMPT *** Create  constraint FK_SBPIQS_SBPID_SBPS_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SUBPRODUCT_INFOQUERIES ADD CONSTRAINT FK_SBPIQS_SBPID_SBPS_ID FOREIGN KEY (SUBPRODUCT_ID)
	  REFERENCES BARS.WCS_SUBPRODUCTS (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SBPIQS_IQID_IQS_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SUBPRODUCT_INFOQUERIES ADD CONSTRAINT FK_SBPIQS_IQID_IQS_ID FOREIGN KEY (IQUERY_ID)
	  REFERENCES BARS.WCS_INFOQUERIES (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SBPIQS_SID_SERV_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SUBPRODUCT_INFOQUERIES ADD CONSTRAINT FK_SBPIQS_SID_SERV_ID FOREIGN KEY (SERVICE_ID)
	  REFERENCES BARS.WCS_SERVICES (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SBPINFOQS_REQUIRED ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SUBPRODUCT_INFOQUERIES ADD CONSTRAINT CC_SBPINFOQS_REQUIRED CHECK (is_required in (0, 1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_SBPINFOQUERIES ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SUBPRODUCT_INFOQUERIES ADD CONSTRAINT PK_SBPINFOQUERIES PRIMARY KEY (SUBPRODUCT_ID, IQUERY_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SBPINFOQUERIES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SBPINFOQUERIES ON BARS.WCS_SUBPRODUCT_INFOQUERIES (SUBPRODUCT_ID, IQUERY_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  WCS_SUBPRODUCT_INFOQUERIES ***
grant DELETE,INSERT,SELECT,UPDATE                                            on WCS_SUBPRODUCT_INFOQUERIES to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on WCS_SUBPRODUCT_INFOQUERIES to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on WCS_SUBPRODUCT_INFOQUERIES to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/WCS_SUBPRODUCT_INFOQUERIES.sql =======
PROMPT ===================================================================================== 
