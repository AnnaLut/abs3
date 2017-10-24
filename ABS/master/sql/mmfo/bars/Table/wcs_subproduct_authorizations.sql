

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/WCS_SUBPRODUCT_AUTHORIZATIONS.sql ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to WCS_SUBPRODUCT_AUTHORIZATIONS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''WCS_SUBPRODUCT_AUTHORIZATIONS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_SUBPRODUCT_AUTHORIZATIONS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_SUBPRODUCT_AUTHORIZATIONS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table WCS_SUBPRODUCT_AUTHORIZATIONS ***
begin 
  execute immediate '
  CREATE TABLE BARS.WCS_SUBPRODUCT_AUTHORIZATIONS 
   (	SUBPRODUCT_ID VARCHAR2(100), 
	AUTH_ID VARCHAR2(100)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to WCS_SUBPRODUCT_AUTHORIZATIONS ***
 exec bpa.alter_policies('WCS_SUBPRODUCT_AUTHORIZATIONS');


COMMENT ON TABLE BARS.WCS_SUBPRODUCT_AUTHORIZATIONS IS 'Карта авторизации субпродукта';
COMMENT ON COLUMN BARS.WCS_SUBPRODUCT_AUTHORIZATIONS.SUBPRODUCT_ID IS 'Идентификатор субродукта';
COMMENT ON COLUMN BARS.WCS_SUBPRODUCT_AUTHORIZATIONS.AUTH_ID IS 'Идентификатор карты авторизации';




PROMPT *** Create  constraint PK_SBPAUTHORIZATIONS ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SUBPRODUCT_AUTHORIZATIONS ADD CONSTRAINT PK_SBPAUTHORIZATIONS PRIMARY KEY (SUBPRODUCT_ID, AUTH_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SBPAUTHS_SBPID_SBPS_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SUBPRODUCT_AUTHORIZATIONS ADD CONSTRAINT FK_SBPAUTHS_SBPID_SBPS_ID FOREIGN KEY (SUBPRODUCT_ID)
	  REFERENCES BARS.WCS_SUBPRODUCTS (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SBPAUTHS_AID_AUTHS_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SUBPRODUCT_AUTHORIZATIONS ADD CONSTRAINT FK_SBPAUTHS_AID_AUTHS_ID FOREIGN KEY (AUTH_ID)
	  REFERENCES BARS.WCS_AUTHORIZATIONS (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SBPAUTHORIZATIONS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SBPAUTHORIZATIONS ON BARS.WCS_SUBPRODUCT_AUTHORIZATIONS (SUBPRODUCT_ID, AUTH_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  WCS_SUBPRODUCT_AUTHORIZATIONS ***
grant SELECT                                                                 on WCS_SUBPRODUCT_AUTHORIZATIONS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on WCS_SUBPRODUCT_AUTHORIZATIONS to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/WCS_SUBPRODUCT_AUTHORIZATIONS.sql ====
PROMPT ===================================================================================== 
