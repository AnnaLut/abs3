

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CUST_REQ_ACCESS.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CUST_REQ_ACCESS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CUST_REQ_ACCESS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CUST_REQ_ACCESS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CUST_REQ_ACCESS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CUST_REQ_ACCESS ***
begin 
  execute immediate '
  CREATE TABLE BARS.CUST_REQ_ACCESS 
   (	REQ_ID NUMBER(38,0), 
	CONTRACT_ID NUMBER(38,0), 
	AMOUNT NUMBER, 
	FLAGS CHAR(5) DEFAULT ''00000''
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CUST_REQ_ACCESS ***
 exec bpa.alter_policies('CUST_REQ_ACCESS');


COMMENT ON TABLE BARS.CUST_REQ_ACCESS IS 'Параметри запитів про надання доступу через бек-офіс';
COMMENT ON COLUMN BARS.CUST_REQ_ACCESS.REQ_ID IS 'Ідентифікатор запиту';
COMMENT ON COLUMN BARS.CUST_REQ_ACCESS.CONTRACT_ID IS 'Ідентифікатор договору, по якому оформлюється доступ';
COMMENT ON COLUMN BARS.CUST_REQ_ACCESS.AMOUNT IS 'Сума для зняття (по дорученню) / частка спадщини';
COMMENT ON COLUMN BARS.CUST_REQ_ACCESS.FLAGS IS 'Флаги запиту (доручення)';




PROMPT *** Create  constraint PK_CUSTREQACCESS ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUST_REQ_ACCESS ADD CONSTRAINT PK_CUSTREQACCESS PRIMARY KEY (REQ_ID, CONTRACT_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTREQACCESS_FLAGS ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUST_REQ_ACCESS ADD CONSTRAINT CC_CUSTREQACCESS_FLAGS CHECK (regexp_like(FLAGS,''^\d+$'')) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTREQACCESS_REQID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUST_REQ_ACCESS MODIFY (REQ_ID CONSTRAINT CC_CUSTREQACCESS_REQID_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTREQACCESS_DEALID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUST_REQ_ACCESS MODIFY (CONTRACT_ID CONSTRAINT CC_CUSTREQACCESS_DEALID_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTREQACCESS_FLAGS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUST_REQ_ACCESS MODIFY (FLAGS CONSTRAINT CC_CUSTREQACCESS_FLAGS_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CUSTREQACCESS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CUSTREQACCESS ON BARS.CUST_REQ_ACCESS (REQ_ID, CONTRACT_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CUST_REQ_ACCESS ***
grant SELECT                                                                 on CUST_REQ_ACCESS to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CUST_REQ_ACCESS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CUST_REQ_ACCESS to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CUST_REQ_ACCESS to DPT_ADMIN;
grant SELECT                                                                 on CUST_REQ_ACCESS to START1;
grant SELECT                                                                 on CUST_REQ_ACCESS to UPLD;
grant DELETE,INSERT,SELECT,UPDATE                                            on CUST_REQ_ACCESS to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CUST_REQ_ACCESS.sql =========*** End *
PROMPT ===================================================================================== 
