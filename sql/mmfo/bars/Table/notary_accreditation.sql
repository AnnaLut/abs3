

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NOTARY_ACCREDITATION.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to NOTARY_ACCREDITATION ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NOTARY_ACCREDITATION'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''NOTARY_ACCREDITATION'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''NOTARY_ACCREDITATION'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NOTARY_ACCREDITATION ***
begin 
  execute immediate '
  CREATE TABLE BARS.NOTARY_ACCREDITATION 
   (	ID NUMBER(10,0), 
	NOTARY_ID NUMBER(10,0), 
	ACCREDITATION_TYPE_ID NUMBER(5,0), 
	START_DATE DATE, 
	EXPIRY_DATE DATE, 
	CLOSE_DATE DATE, 
	ACCOUNT_NUMBER VARCHAR2(15 CHAR), 
	ACCOUNT_MFO VARCHAR2(6 CHAR), 
	STATE_ID NUMBER(5,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to NOTARY_ACCREDITATION ***
 exec bpa.alter_policies('NOTARY_ACCREDITATION');


COMMENT ON TABLE BARS.NOTARY_ACCREDITATION IS 'Дані про акредитації нотаріусів';
COMMENT ON COLUMN BARS.NOTARY_ACCREDITATION.ID IS 'Ідентифікатор акредитації нотаріуса';
COMMENT ON COLUMN BARS.NOTARY_ACCREDITATION.NOTARY_ID IS 'Ідентифікатор нотаріуса';
COMMENT ON COLUMN BARS.NOTARY_ACCREDITATION.ACCREDITATION_TYPE_ID IS 'Тип акредитації (1 - постійна, 2 - разова)';
COMMENT ON COLUMN BARS.NOTARY_ACCREDITATION.START_DATE IS 'Дата початку дії акредитації';
COMMENT ON COLUMN BARS.NOTARY_ACCREDITATION.EXPIRY_DATE IS 'Дата планового завершення акредитації';
COMMENT ON COLUMN BARS.NOTARY_ACCREDITATION.CLOSE_DATE IS 'Дата припинення акредитації';
COMMENT ON COLUMN BARS.NOTARY_ACCREDITATION.ACCOUNT_NUMBER IS 'Номер рахунку, відкритого для розрахунків банку з нотаріусом';
COMMENT ON COLUMN BARS.NOTARY_ACCREDITATION.ACCOUNT_MFO IS 'МФО банківської установи, в якій відкритий рахунок нотаріуса';
COMMENT ON COLUMN BARS.NOTARY_ACCREDITATION.STATE_ID IS 'Стан акредитації (0 - запит на акредитацію, 1 - діюча акредитація, 2 - акредитацію припинено, 3 - разова акредитація використана)';




PROMPT *** Create  constraint FK_NOTARY_ACCRED_REF_NOTARY ***
begin   
 execute immediate '
  ALTER TABLE BARS.NOTARY_ACCREDITATION ADD CONSTRAINT FK_NOTARY_ACCRED_REF_NOTARY FOREIGN KEY (NOTARY_ID)
	  REFERENCES BARS.NOTARY (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_NOTARY_ACCR_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NOTARY_ACCREDITATION MODIFY (ID CONSTRAINT CC_NOTARY_ACCR_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_NOTARY_ACCR_TYPE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NOTARY_ACCREDITATION MODIFY (NOTARY_ID CONSTRAINT CC_NOTARY_ACCR_TYPE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_NOTARY_ACCR_STATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NOTARY_ACCREDITATION ADD CONSTRAINT CC_NOTARY_ACCR_STATE_NN CHECK (STATE_ID IS NOT NULL) DEFERRABLE INITIALLY DEFERRED ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_NOTARY_ACCREDITATION ***
begin   
 execute immediate '
  ALTER TABLE BARS.NOTARY_ACCREDITATION ADD CONSTRAINT PK_NOTARY_ACCREDITATION PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_NOTARY_ACCREDITATION ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_NOTARY_ACCREDITATION ON BARS.NOTARY_ACCREDITATION (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  NOTARY_ACCREDITATION ***
grant DELETE,INSERT,SELECT,UPDATE                                            on NOTARY_ACCREDITATION to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on NOTARY_ACCREDITATION to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NOTARY_ACCREDITATION.sql =========*** 
PROMPT ===================================================================================== 
