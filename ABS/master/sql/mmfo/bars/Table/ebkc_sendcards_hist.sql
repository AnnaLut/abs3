

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/EBKC_SENDCARDS_HIST.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to EBKC_SENDCARDS_HIST ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''EBKC_SENDCARDS_HIST'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''EBKC_SENDCARDS_HIST'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''EBKC_SENDCARDS_HIST'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table EBKC_SENDCARDS_HIST ***
begin 
  execute immediate '
  CREATE TABLE BARS.EBKC_SENDCARDS_HIST 
   (	RNK NUMBER(38,0), 
	SEND_DATE DATE DEFAULT sysdate, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to EBKC_SENDCARDS_HIST ***
 exec bpa.alter_policies('EBKC_SENDCARDS_HIST');


COMMENT ON TABLE BARS.EBKC_SENDCARDS_HIST IS '';
COMMENT ON COLUMN BARS.EBKC_SENDCARDS_HIST.KF IS '';
COMMENT ON COLUMN BARS.EBKC_SENDCARDS_HIST.RNK IS '';
COMMENT ON COLUMN BARS.EBKC_SENDCARDS_HIST.SEND_DATE IS '';




PROMPT *** Create  constraint CC_EBKCSENDCARDSHIST_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.EBKC_SENDCARDS_HIST MODIFY (KF CONSTRAINT CC_EBKCSENDCARDSHIST_KF_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_EBKCSENDCARDSHIST ***
begin   
 execute immediate '
  CREATE INDEX BARS.UK_EBKCSENDCARDSHIST ON BARS.EBKC_SENDCARDS_HIST (KF, RNK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  EBKC_SENDCARDS_HIST ***
grant SELECT                                                                 on EBKC_SENDCARDS_HIST to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on EBKC_SENDCARDS_HIST to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on EBKC_SENDCARDS_HIST to BARS_DM;
grant SELECT                                                                 on EBKC_SENDCARDS_HIST to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/EBKC_SENDCARDS_HIST.sql =========*** E
PROMPT ===================================================================================== 
