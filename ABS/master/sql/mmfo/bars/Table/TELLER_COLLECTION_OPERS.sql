PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TELLER_COLLECTION_OPERS.sql =========*
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TELLER_COLLECTION_OPERS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TELLER_COLLECTION_OPERS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TELLER_COLLECTION_OPERS ***
begin 
  execute immediate '
  CREATE TABLE BARS.TELLER_COLLECTION_OPERS 
   (	ID NUMBER, 
	OPER_REF VARCHAR2(1000), 
	STATE VARCHAR2(2), 
	AMOUNT NUMBER, 
	CUR VARCHAR2(3), 
	PURPOSE VARCHAR2(160), 
	DOC_REF NUMBER, 
	LAST_DT DATE, 
	DIRECTION VARCHAR2(1), 
	USER_ID VARCHAR2(38), 
	CANDELETE NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TELLER_COLLECTION_OPERS ***
 exec bpa.alter_policies('TELLER_COLLECTION_OPERS');


COMMENT ON TABLE BARS.TELLER_COLLECTION_OPERS IS 'Операції по інкасації';
COMMENT ON COLUMN BARS.TELLER_COLLECTION_OPERS.ID IS 'ID операції інкасації';
COMMENT ON COLUMN BARS.TELLER_COLLECTION_OPERS.OPER_REF IS 'Посилання на teller_opers.id (список)';
COMMENT ON COLUMN BARS.TELLER_COLLECTION_OPERS.STATE IS 'Статус операції';
COMMENT ON COLUMN BARS.TELLER_COLLECTION_OPERS.AMOUNT IS 'Сума операції';
COMMENT ON COLUMN BARS.TELLER_COLLECTION_OPERS.CUR IS 'Код валюти операції';
COMMENT ON COLUMN BARS.TELLER_COLLECTION_OPERS.PURPOSE IS 'Призначення платежу';
COMMENT ON COLUMN BARS.TELLER_COLLECTION_OPERS.DOC_REF IS 'Сформований документ в АБС';
COMMENT ON COLUMN BARS.TELLER_COLLECTION_OPERS.LAST_DT IS 'Дата+час модифікації';
COMMENT ON COLUMN BARS.TELLER_COLLECTION_OPERS.DIRECTION IS 'Підкріплення (І) / Вилучення (О)';
COMMENT ON COLUMN BARS.TELLER_COLLECTION_OPERS.USER_ID IS 'Користувач';
COMMENT ON COLUMN BARS.TELLER_COLLECTION_OPERS.CANDELETE IS 'Можливість видалення (1/0)';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TELLER_COLLECTION_OPERS.sql =========*
PROMPT ===================================================================================== 
