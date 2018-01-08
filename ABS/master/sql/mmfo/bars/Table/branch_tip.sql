

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BRANCH_TIP.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BRANCH_TIP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BRANCH_TIP'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''BRANCH_TIP'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''BRANCH_TIP'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BRANCH_TIP ***
begin 
  execute immediate '
  CREATE TABLE BARS.BRANCH_TIP 
   (	TIP VARCHAR2(5), 
	NAME VARCHAR2(90), 
	NAME1 VARCHAR2(50), 
	NAME2 VARCHAR2(50)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BRANCH_TIP ***
 exec bpa.alter_policies('BRANCH_TIP');


COMMENT ON TABLE BARS.BRANCH_TIP IS 'Типы бранчей';
COMMENT ON COLUMN BARS.BRANCH_TIP.TIP IS '';
COMMENT ON COLUMN BARS.BRANCH_TIP.NAME IS '';
COMMENT ON COLUMN BARS.BRANCH_TIP.NAME1 IS '';
COMMENT ON COLUMN BARS.BRANCH_TIP.NAME2 IS '';




PROMPT *** Create  constraint XPK_BRANCH_TIP ***
begin   
 execute immediate '
  ALTER TABLE BARS.BRANCH_TIP ADD CONSTRAINT XPK_BRANCH_TIP PRIMARY KEY (TIP)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BRANCHTIP_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BRANCH_TIP MODIFY (NAME CONSTRAINT CC_BRANCHTIP_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_BRANCH_TIP ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_BRANCH_TIP ON BARS.BRANCH_TIP (TIP) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BRANCH_TIP ***
grant DELETE,INSERT,SELECT,UPDATE                                            on BRANCH_TIP      to ABS_ADMIN;
grant SELECT                                                                 on BRANCH_TIP      to BARSUPL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on BRANCH_TIP      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on BRANCH_TIP      to BARS_DM;
grant SELECT                                                                 on BRANCH_TIP      to CUST001;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on BRANCH_TIP      to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on BRANCH_TIP      to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BRANCH_TIP.sql =========*** End *** ==
PROMPT ===================================================================================== 
