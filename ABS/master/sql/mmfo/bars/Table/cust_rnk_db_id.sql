

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CUST_RNK_DB_ID.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CUST_RNK_DB_ID ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CUST_RNK_DB_ID'', ''CENTER'' , ''E'', ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CUST_RNK_DB_ID'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''CUST_RNK_DB_ID'', ''WHOLE'' , ''E'', ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CUST_RNK_DB_ID ***
begin 
  execute immediate '
  CREATE TABLE BARS.CUST_RNK_DB_ID 
   (	REL_INTEXT_DB NUMBER(*,0), 
	REL_RNK_DB NUMBER(*,0), 
	ID NUMBER(*,0), 
	MFO VARCHAR2(16)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CUST_RNK_DB_ID ***
 exec bpa.alter_policies('CUST_RNK_DB_ID');


COMMENT ON TABLE BARS.CUST_RNK_DB_ID IS '¬≥‰ÔÓ‚≥‰Ì≥ÒÚ¸ customer_rel.rel_rnk@dblink Ë customer_extern.id';
COMMENT ON COLUMN BARS.CUST_RNK_DB_ID.REL_INTEXT_DB IS 'customer_rel.rel_intext@dblink';
COMMENT ON COLUMN BARS.CUST_RNK_DB_ID.REL_RNK_DB IS 'customer_rel.rel_rnk@dblink';
COMMENT ON COLUMN BARS.CUST_RNK_DB_ID.ID IS 'customer_extern.id';
COMMENT ON COLUMN BARS.CUST_RNK_DB_ID.MFO IS 'Ã‘Œ';




PROMPT *** Create  constraint PK_CUST_RNK_DB_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUST_RNK_DB_ID ADD CONSTRAINT PK_CUST_RNK_DB_ID PRIMARY KEY (REL_INTEXT_DB, REL_RNK_DB, MFO)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CUST_RNK_DB_ID ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CUST_RNK_DB_ID ON BARS.CUST_RNK_DB_ID (REL_INTEXT_DB, REL_RNK_DB, MFO) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CUST_RNK_DB_ID ***
grant SELECT                                                                 on CUST_RNK_DB_ID  to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CUST_RNK_DB_ID  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CUST_RNK_DB_ID  to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CUST_RNK_DB_ID  to START1;
grant SELECT                                                                 on CUST_RNK_DB_ID  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CUST_RNK_DB_ID.sql =========*** End **
PROMPT ===================================================================================== 
