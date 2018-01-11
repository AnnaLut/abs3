

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NAEK_CUSTOMER_MAP.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to NAEK_CUSTOMER_MAP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NAEK_CUSTOMER_MAP'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''NAEK_CUSTOMER_MAP'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''NAEK_CUSTOMER_MAP'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NAEK_CUSTOMER_MAP ***
begin 
  execute immediate '
  CREATE TABLE BARS.NAEK_CUSTOMER_MAP 
   (	RNK NUMBER(*,0), 
	ECODE VARCHAR2(4), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to NAEK_CUSTOMER_MAP ***
 exec bpa.alter_policies('NAEK_CUSTOMER_MAP');


COMMENT ON TABLE BARS.NAEK_CUSTOMER_MAP IS 'Ёлектронные коды корпоративных клиентов';
COMMENT ON COLUMN BARS.NAEK_CUSTOMER_MAP.RNK IS 'RNK клиента';
COMMENT ON COLUMN BARS.NAEK_CUSTOMER_MAP.ECODE IS 'Ёлектронный код';
COMMENT ON COLUMN BARS.NAEK_CUSTOMER_MAP.KF IS '';




PROMPT *** Create  constraint PK_NAEKCUSTOMERMAP ***
begin   
 execute immediate '
  ALTER TABLE BARS.NAEK_CUSTOMER_MAP ADD CONSTRAINT PK_NAEKCUSTOMERMAP PRIMARY KEY (KF, RNK)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_NAEKCUSTMAP_RNK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NAEK_CUSTOMER_MAP MODIFY (RNK CONSTRAINT CC_NAEKCUSTMAP_RNK_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_NAEKCUSTMAP_ECODE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NAEK_CUSTOMER_MAP MODIFY (ECODE CONSTRAINT CC_NAEKCUSTMAP_ECODE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_NAEKCUSTOMERMAP_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NAEK_CUSTOMER_MAP MODIFY (KF CONSTRAINT CC_NAEKCUSTOMERMAP_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_NAEKCUSTOMERMAP ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_NAEKCUSTOMERMAP ON BARS.NAEK_CUSTOMER_MAP (KF, RNK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  NAEK_CUSTOMER_MAP ***
grant DELETE,INSERT,SELECT,UPDATE                                            on NAEK_CUSTOMER_MAP to ABS_ADMIN;
grant SELECT                                                                 on NAEK_CUSTOMER_MAP to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on NAEK_CUSTOMER_MAP to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on NAEK_CUSTOMER_MAP to BARS_DM;
grant SELECT                                                                 on NAEK_CUSTOMER_MAP to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on NAEK_CUSTOMER_MAP to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on NAEK_CUSTOMER_MAP to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NAEK_CUSTOMER_MAP.sql =========*** End
PROMPT ===================================================================================== 
