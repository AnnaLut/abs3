

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/XML_REFQUE.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to XML_REFQUE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''XML_REFQUE'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''XML_REFQUE'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''XML_REFQUE'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table XML_REFQUE ***
begin 
  execute immediate '
  CREATE TABLE BARS.XML_REFQUE 
   (	REF NUMBER, 
	DPT_ND VARCHAR2(35), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	DPTPR VARCHAR2(4)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to XML_REFQUE ***
 exec bpa.alter_policies('XML_REFQUE');


COMMENT ON TABLE BARS.XML_REFQUE IS 'список рефов док-тов первичного взноса для депозитов, которые еще не открылись';
COMMENT ON COLUMN BARS.XML_REFQUE.REF IS '';
COMMENT ON COLUMN BARS.XML_REFQUE.DPT_ND IS '';
COMMENT ON COLUMN BARS.XML_REFQUE.KF IS '';
COMMENT ON COLUMN BARS.XML_REFQUE.DPTPR IS 'Тип депозита DPT1 - обычный, DPT2 - соц.';




PROMPT *** Create  constraint CC_XMLREFQUE_DPTPR ***
begin   
 execute immediate '
  ALTER TABLE BARS.XML_REFQUE ADD CONSTRAINT CC_XMLREFQUE_DPTPR CHECK (dptpr in (''DPT1'',''DPT2'')) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_XMLREFQUE_REF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.XML_REFQUE MODIFY (REF CONSTRAINT CC_XMLREFQUE_REF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_XMLREFQUE_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.XML_REFQUE MODIFY (KF CONSTRAINT CC_XMLREFQUE_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XUK_XMLREFQUE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XUK_XMLREFQUE ON BARS.XML_REFQUE (DPT_ND, DPTPR) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  XML_REFQUE ***
grant SELECT                                                                 on XML_REFQUE      to BARSREADER_ROLE;
grant SELECT                                                                 on XML_REFQUE      to BARS_DM;
grant SELECT                                                                 on XML_REFQUE      to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on XML_REFQUE      to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/XML_REFQUE.sql =========*** End *** ==
PROMPT ===================================================================================== 
