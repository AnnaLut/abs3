

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ACCOUNTS_ITS.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ACCOUNTS_ITS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ACCOUNTS_ITS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''ACCOUNTS_ITS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ACCOUNTS_ITS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ACCOUNTS_ITS ***
begin 
  execute immediate '
  CREATE TABLE BARS.ACCOUNTS_ITS 
   (	NLS VARCHAR2(15), 
	KV NUMBER(38,0), 
	NBS CHAR(4), 
	DAPP DATE, 
	OSTC NUMBER(24,0) DEFAULT 0, 
	DOS NUMBER(24,0) DEFAULT 0, 
	KOS NUMBER(24,0) DEFAULT 0
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ACCOUNTS_ITS ***
 exec bpa.alter_policies('ACCOUNTS_ITS');


COMMENT ON TABLE BARS.ACCOUNTS_ITS IS '';
COMMENT ON COLUMN BARS.ACCOUNTS_ITS.NLS IS '';
COMMENT ON COLUMN BARS.ACCOUNTS_ITS.KV IS '';
COMMENT ON COLUMN BARS.ACCOUNTS_ITS.NBS IS '';
COMMENT ON COLUMN BARS.ACCOUNTS_ITS.DAPP IS '';
COMMENT ON COLUMN BARS.ACCOUNTS_ITS.OSTC IS '';
COMMENT ON COLUMN BARS.ACCOUNTS_ITS.DOS IS '';
COMMENT ON COLUMN BARS.ACCOUNTS_ITS.KOS IS '';




PROMPT *** Create  constraint XPK_ACCOUNTS_ITS ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS_ITS ADD CONSTRAINT XPK_ACCOUNTS_ITS PRIMARY KEY (NLS, KV)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009376 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS_ITS MODIFY (OSTC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009377 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS_ITS MODIFY (DOS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009378 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS_ITS MODIFY (KOS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_ACCOUNTS_ITS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_ACCOUNTS_ITS ON BARS.ACCOUNTS_ITS (NLS, KV) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ACCOUNTS_ITS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on ACCOUNTS_ITS    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ACCOUNTS_ITS    to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on ACCOUNTS_ITS    to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ACCOUNTS_ITS.sql =========*** End *** 
PROMPT ===================================================================================== 
