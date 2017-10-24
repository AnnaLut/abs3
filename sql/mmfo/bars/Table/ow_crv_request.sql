

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OW_CRV_REQUEST.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OW_CRV_REQUEST ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OW_CRV_REQUEST'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''OW_CRV_REQUEST'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''OW_CRV_REQUEST'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OW_CRV_REQUEST ***
begin 
  execute immediate '
  CREATE TABLE BARS.OW_CRV_REQUEST 
   (	ID NUMBER(22,0), 
	NAME VARCHAR2(100)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OW_CRV_REQUEST ***
 exec bpa.alter_policies('OW_CRV_REQUEST');


COMMENT ON TABLE BARS.OW_CRV_REQUEST IS 'OpenWay-ЦРВ. Запросы для Way4 по нац.карте';
COMMENT ON COLUMN BARS.OW_CRV_REQUEST.ID IS 'Код запроса';
COMMENT ON COLUMN BARS.OW_CRV_REQUEST.NAME IS 'Наименование запроса';




PROMPT *** Create  constraint PK_OWCRVREQUEST ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_CRV_REQUEST ADD CONSTRAINT PK_OWCRVREQUEST PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OWCRVREQUEST_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_CRV_REQUEST ADD CONSTRAINT CC_OWCRVREQUEST_NAME_NN CHECK (name is not null) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_OWCRVREQUEST ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_OWCRVREQUEST ON BARS.OW_CRV_REQUEST (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OW_CRV_REQUEST ***
grant DELETE,INSERT,SELECT,UPDATE                                            on OW_CRV_REQUEST  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on OW_CRV_REQUEST  to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on OW_CRV_REQUEST  to OW;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OW_CRV_REQUEST.sql =========*** End **
PROMPT ===================================================================================== 
