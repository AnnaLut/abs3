

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/WCS_GARANTEE_INSURANCES.sql =========*
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to WCS_GARANTEE_INSURANCES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''WCS_GARANTEE_INSURANCES'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_GARANTEE_INSURANCES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_GARANTEE_INSURANCES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table WCS_GARANTEE_INSURANCES ***
begin 
  execute immediate '
  CREATE TABLE BARS.WCS_GARANTEE_INSURANCES 
   (	GARANTEE_ID VARCHAR2(100), 
	INSURANCE_ID VARCHAR2(100), 
	IS_REQUIRED NUMBER DEFAULT 1, 
	ORD NUMBER, 
	WS_QID VARCHAR2(100)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to WCS_GARANTEE_INSURANCES ***
 exec bpa.alter_policies('WCS_GARANTEE_INSURANCES');


COMMENT ON TABLE BARS.WCS_GARANTEE_INSURANCES IS 'Привязка страховок к залогам';
COMMENT ON COLUMN BARS.WCS_GARANTEE_INSURANCES.GARANTEE_ID IS 'Внутр. идентификатор типа залога';
COMMENT ON COLUMN BARS.WCS_GARANTEE_INSURANCES.INSURANCE_ID IS 'Идентификатор типа страховки';
COMMENT ON COLUMN BARS.WCS_GARANTEE_INSURANCES.IS_REQUIRED IS 'Обязательна ли для заполнения';
COMMENT ON COLUMN BARS.WCS_GARANTEE_INSURANCES.ORD IS 'Порядок';
COMMENT ON COLUMN BARS.WCS_GARANTEE_INSURANCES.WS_QID IS 'Идентификатор вопроса для хранения рабочего пространства';




PROMPT *** Create  constraint CC_WCSGRTINS_WSID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_GARANTEE_INSURANCES MODIFY (WS_QID CONSTRAINT CC_WCSGRTINS_WSID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_WCSGRTINS_REQUIRED ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_GARANTEE_INSURANCES ADD CONSTRAINT CC_WCSGRTINS_REQUIRED CHECK (is_required in (0, 1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_WCSGRTINS ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_GARANTEE_INSURANCES ADD CONSTRAINT PK_WCSGRTINS PRIMARY KEY (GARANTEE_ID, INSURANCE_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_WCSGRTINS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_WCSGRTINS ON BARS.WCS_GARANTEE_INSURANCES (GARANTEE_ID, INSURANCE_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  WCS_GARANTEE_INSURANCES ***
grant SELECT                                                                 on WCS_GARANTEE_INSURANCES to BARSREADER_ROLE;
grant SELECT                                                                 on WCS_GARANTEE_INSURANCES to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on WCS_GARANTEE_INSURANCES to BARS_DM;
grant SELECT                                                                 on WCS_GARANTEE_INSURANCES to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/WCS_GARANTEE_INSURANCES.sql =========*
PROMPT ===================================================================================== 
