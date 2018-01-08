

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DOC_ROOT.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DOC_ROOT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DOC_ROOT'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DOC_ROOT'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''DOC_ROOT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DOC_ROOT ***
begin 
  execute immediate '
  CREATE TABLE BARS.DOC_ROOT 
   (	VIDD NUMBER(38,0), 
	ID VARCHAR2(35), 
	 CONSTRAINT PK_DOCROOT PRIMARY KEY (VIDD, ID) ENABLE
   ) ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING
  TABLESPACE BRSSMLI 
 PCTTHRESHOLD 50';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DOC_ROOT ***
 exec bpa.alter_policies('DOC_ROOT');


COMMENT ON TABLE BARS.DOC_ROOT IS 'Корневые шаблоны';
COMMENT ON COLUMN BARS.DOC_ROOT.VIDD IS 'ID';
COMMENT ON COLUMN BARS.DOC_ROOT.ID IS 'Название шаблона (вид)';




PROMPT *** Create  constraint CC_DOCROOT_VIDD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DOC_ROOT MODIFY (VIDD CONSTRAINT CC_DOCROOT_VIDD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DOCROOT_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DOC_ROOT MODIFY (ID CONSTRAINT CC_DOCROOT_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_DOCROOT ***
begin   
 execute immediate '
  ALTER TABLE BARS.DOC_ROOT ADD CONSTRAINT PK_DOCROOT PRIMARY KEY (VIDD, ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DOCROOT_CCVIDD ***
begin   
 execute immediate '
  ALTER TABLE BARS.DOC_ROOT ADD CONSTRAINT FK_DOCROOT_CCVIDD FOREIGN KEY (VIDD)
	  REFERENCES BARS.CC_VIDD (VIDD) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DOCROOT_DOCSCHEME ***
begin   
 execute immediate '
  ALTER TABLE BARS.DOC_ROOT ADD CONSTRAINT FK_DOCROOT_DOCSCHEME FOREIGN KEY (ID)
	  REFERENCES BARS.DOC_SCHEME (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DOCROOT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DOCROOT ON BARS.DOC_ROOT (VIDD, ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DOC_ROOT ***
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on DOC_ROOT        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DOC_ROOT        to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on DOC_ROOT        to CC_DOC;
grant DELETE,INSERT,SELECT,UPDATE                                            on DOC_ROOT        to DPT_ADMIN;
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on DOC_ROOT        to RCC_DEAL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DOC_ROOT        to WR_ALL_RIGHTS;
grant SELECT                                                                 on DOC_ROOT        to WR_CREDIT;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DOC_ROOT.sql =========*** End *** ====
PROMPT ===================================================================================== 
