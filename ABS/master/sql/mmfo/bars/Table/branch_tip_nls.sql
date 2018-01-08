

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BRANCH_TIP_NLS.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BRANCH_TIP_NLS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BRANCH_TIP_NLS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''BRANCH_TIP_NLS'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''BRANCH_TIP_NLS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BRANCH_TIP_NLS ***
begin 
  execute immediate '
  CREATE TABLE BARS.BRANCH_TIP_NLS 
   (	TIP VARCHAR2(5), 
	NBS CHAR(4), 
	OB22 CHAR(2), 
	MASK VARCHAR2(14)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BRANCH_TIP_NLS ***
 exec bpa.alter_policies('BRANCH_TIP_NLS');


COMMENT ON TABLE BARS.BRANCH_TIP_NLS IS '';
COMMENT ON COLUMN BARS.BRANCH_TIP_NLS.TIP IS '';
COMMENT ON COLUMN BARS.BRANCH_TIP_NLS.NBS IS '';
COMMENT ON COLUMN BARS.BRANCH_TIP_NLS.OB22 IS '';
COMMENT ON COLUMN BARS.BRANCH_TIP_NLS.MASK IS '';




PROMPT *** Create  constraint XPK_BRANCHTIPNLS ***
begin   
 execute immediate '
  ALTER TABLE BARS.BRANCH_TIP_NLS ADD CONSTRAINT XPK_BRANCHTIPNLS PRIMARY KEY (TIP, NBS, OB22)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_BRANCHTIPNLS_NBSOB22 ***
begin   
 execute immediate '
  ALTER TABLE BARS.BRANCH_TIP_NLS ADD CONSTRAINT FK_BRANCHTIPNLS_NBSOB22 FOREIGN KEY (NBS, OB22)
	  REFERENCES BARS.SB_OB22 (R020, OB22) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_BRANCHTIPNLS_TIP ***
begin   
 execute immediate '
  ALTER TABLE BARS.BRANCH_TIP_NLS ADD CONSTRAINT FK_BRANCHTIPNLS_TIP FOREIGN KEY (TIP)
	  REFERENCES BARS.BRANCH_TIP (TIP) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_BRANCHTIPNLS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_BRANCHTIPNLS ON BARS.BRANCH_TIP_NLS (TIP, NBS, OB22) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BRANCH_TIP_NLS ***
grant SELECT                                                                 on BRANCH_TIP_NLS  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on BRANCH_TIP_NLS  to BARS_DM;
grant SELECT                                                                 on BRANCH_TIP_NLS  to CUST001;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on BRANCH_TIP_NLS  to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BRANCH_TIP_NLS.sql =========*** End **
PROMPT ===================================================================================== 
