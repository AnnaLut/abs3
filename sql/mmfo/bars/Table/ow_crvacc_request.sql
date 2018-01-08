

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OW_CRVACC_REQUEST.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OW_CRVACC_REQUEST ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OW_CRVACC_REQUEST'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''OW_CRVACC_REQUEST'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''OW_CRVACC_REQUEST'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OW_CRVACC_REQUEST ***
begin 
  execute immediate '
  CREATE TABLE BARS.OW_CRVACC_REQUEST 
   (	ACC NUMBER(22,0), 
	REQUEST_ID NUMBER(22,0), 
	REQUEST_DATE DATE DEFAULT sysdate, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OW_CRVACC_REQUEST ***
 exec bpa.alter_policies('OW_CRVACC_REQUEST');


COMMENT ON TABLE BARS.OW_CRVACC_REQUEST IS 'OpenWay-ЦРВ. Запросы для Way4 по нац.карте';
COMMENT ON COLUMN BARS.OW_CRVACC_REQUEST.ACC IS 'ACC';
COMMENT ON COLUMN BARS.OW_CRVACC_REQUEST.REQUEST_ID IS 'Код запроса';
COMMENT ON COLUMN BARS.OW_CRVACC_REQUEST.REQUEST_DATE IS 'Дата запроса';
COMMENT ON COLUMN BARS.OW_CRVACC_REQUEST.KF IS '';




PROMPT *** Create  constraint PK_OWCRVACCREQUEST ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_CRVACC_REQUEST ADD CONSTRAINT PK_OWCRVACCREQUEST PRIMARY KEY (ACC, REQUEST_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OWCRVACCREQUEST_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_CRVACC_REQUEST MODIFY (KF CONSTRAINT CC_OWCRVACCREQUEST_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_OWCRVACCREQUEST ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_OWCRVACCREQUEST ON BARS.OW_CRVACC_REQUEST (ACC, REQUEST_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OW_CRVACC_REQUEST ***
grant SELECT                                                                 on OW_CRVACC_REQUEST to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on OW_CRVACC_REQUEST to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on OW_CRVACC_REQUEST to OW;
grant SELECT                                                                 on OW_CRVACC_REQUEST to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OW_CRVACC_REQUEST.sql =========*** End
PROMPT ===================================================================================== 
