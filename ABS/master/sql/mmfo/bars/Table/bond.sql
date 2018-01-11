

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BOND.sql =========*** Run *** ========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BOND ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BOND'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''BOND'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''BOND'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BOND ***
begin 
  execute immediate '
  CREATE TABLE BARS.BOND 
   (	INST_NUM NUMBER, 
	BOND_CAT VARCHAR2(3), 
	MDATE DATE DEFAULT SYSDATE, 
	CPON_KV NUMBER(*,0), 
	CPON_XRATE NUMBER(9,4), 
	XRATE_IND CHAR(1) DEFAULT ''M'', 
	FIRST_ACRL_DATE DATE DEFAULT SYSDATE, 
	FIRST_CPON_IND CHAR(1) DEFAULT ''N'', 
	FIRST_CPON_DATE DATE DEFAULT SYSDATE, 
	REDEM_PRICE NUMBER(24,0), 
	REDEM_KV NUMBER(*,0)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BOND ***
 exec bpa.alter_policies('BOND');


COMMENT ON TABLE BARS.BOND IS '';
COMMENT ON COLUMN BARS.BOND.INST_NUM IS '';
COMMENT ON COLUMN BARS.BOND.BOND_CAT IS '';
COMMENT ON COLUMN BARS.BOND.MDATE IS '';
COMMENT ON COLUMN BARS.BOND.CPON_KV IS '';
COMMENT ON COLUMN BARS.BOND.CPON_XRATE IS '';
COMMENT ON COLUMN BARS.BOND.XRATE_IND IS '';
COMMENT ON COLUMN BARS.BOND.FIRST_ACRL_DATE IS '';
COMMENT ON COLUMN BARS.BOND.FIRST_CPON_IND IS '';
COMMENT ON COLUMN BARS.BOND.FIRST_CPON_DATE IS '';
COMMENT ON COLUMN BARS.BOND.REDEM_PRICE IS '';
COMMENT ON COLUMN BARS.BOND.REDEM_KV IS '';




PROMPT *** Create  constraint SYS_C009762 ***
begin   
 execute immediate '
  ALTER TABLE BARS.BOND MODIFY (INST_NUM NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009763 ***
begin   
 execute immediate '
  ALTER TABLE BARS.BOND MODIFY (XRATE_IND NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009764 ***
begin   
 execute immediate '
  ALTER TABLE BARS.BOND MODIFY (FIRST_CPON_IND NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XPK_BOND ***
begin   
 execute immediate '
  ALTER TABLE BARS.BOND ADD CONSTRAINT XPK_BOND PRIMARY KEY (INST_NUM)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_BOND ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_BOND ON BARS.BOND (INST_NUM) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BOND ***
grant SELECT                                                                 on BOND            to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on BOND            to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on BOND            to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on BOND            to START1;
grant SELECT                                                                 on BOND            to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BOND.sql =========*** End *** ========
PROMPT ===================================================================================== 
