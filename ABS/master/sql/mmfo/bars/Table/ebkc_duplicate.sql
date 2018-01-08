

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/EBKC_DUPLICATE.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to EBKC_DUPLICATE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''EBKC_DUPLICATE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''EBKC_DUPLICATE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table EBKC_DUPLICATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.EBKC_DUPLICATE 
   (	KF VARCHAR2(6), 
	RNK NUMBER(15,0), 
	DUP_KF VARCHAR2(6), 
	DUP_RNK NUMBER(15,0), 
	CUST_TYPE VARCHAR2(1), 
	INSDATE DATE DEFAULT trunc(sysdate)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to EBKC_DUPLICATE ***
 exec bpa.alter_policies('EBKC_DUPLICATE');


COMMENT ON TABLE BARS.EBKC_DUPLICATE IS '“‡·ÎËˆˇ ‰Û·Î≥Í‡Ú≥‚ –Õ  ﬁŒ, ‘Œœ';
COMMENT ON COLUMN BARS.EBKC_DUPLICATE.KF IS '';
COMMENT ON COLUMN BARS.EBKC_DUPLICATE.RNK IS '';
COMMENT ON COLUMN BARS.EBKC_DUPLICATE.DUP_KF IS '';
COMMENT ON COLUMN BARS.EBKC_DUPLICATE.DUP_RNK IS '';
COMMENT ON COLUMN BARS.EBKC_DUPLICATE.CUST_TYPE IS '';
COMMENT ON COLUMN BARS.EBKC_DUPLICATE.INSDATE IS '';




PROMPT *** Create  constraint CC_EBKCDUPL_RNK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.EBKC_DUPLICATE MODIFY (RNK CONSTRAINT CC_EBKCDUPL_RNK_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index U1_EBKC_DUPL ***
begin   
 execute immediate '
  CREATE INDEX BARS.U1_EBKC_DUPL ON BARS.EBKC_DUPLICATE (RNK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  EBKC_DUPLICATE ***
grant SELECT                                                                 on EBKC_DUPLICATE  to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on EBKC_DUPLICATE  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on EBKC_DUPLICATE  to BARS_DM;
grant SELECT                                                                 on EBKC_DUPLICATE  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/EBKC_DUPLICATE.sql =========*** End **
PROMPT ===================================================================================== 
