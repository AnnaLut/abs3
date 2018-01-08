

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CUSTCOUNT.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CUSTCOUNT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CUSTCOUNT'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CUSTCOUNT'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CUSTCOUNT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CUSTCOUNT ***
begin 
  execute immediate '
  CREATE TABLE BARS.CUSTCOUNT 
   (	RNK NUMBER(*,0), 
	TIP CHAR(1), 
	COUNT NUMBER(*,0), 
	DFORM DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CUSTCOUNT ***
 exec bpa.alter_policies('CUSTCOUNT');


COMMENT ON TABLE BARS.CUSTCOUNT IS '';
COMMENT ON COLUMN BARS.CUSTCOUNT.RNK IS '';
COMMENT ON COLUMN BARS.CUSTCOUNT.TIP IS '';
COMMENT ON COLUMN BARS.CUSTCOUNT.COUNT IS '';
COMMENT ON COLUMN BARS.CUSTCOUNT.DFORM IS '';




PROMPT *** Create  constraint XPK_CUSTCOUNT ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTCOUNT ADD CONSTRAINT XPK_CUSTCOUNT PRIMARY KEY (RNK, TIP)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XFK_TIP_CUSTCOUNT ***
begin   
 execute immediate '
  CREATE INDEX BARS.XFK_TIP_CUSTCOUNT ON BARS.CUSTCOUNT (TIP) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index XFK_RNK_CUSTCOUNT ***
begin   
 execute immediate '
  CREATE INDEX BARS.XFK_RNK_CUSTCOUNT ON BARS.CUSTCOUNT (RNK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_CUSTCOUNT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_CUSTCOUNT ON BARS.CUSTCOUNT (RNK, TIP) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CUSTCOUNT ***
grant SELECT                                                                 on CUSTCOUNT       to BARSREADER_ROLE;
grant INSERT,SELECT,UPDATE                                                   on CUSTCOUNT       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CUSTCOUNT       to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CUSTCOUNT       to OPERKKK;
grant INSERT,SELECT,UPDATE                                                   on CUSTCOUNT       to TECH_MOM1;
grant SELECT                                                                 on CUSTCOUNT       to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CUSTCOUNT       to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to CUSTCOUNT ***

  CREATE OR REPLACE PUBLIC SYNONYM CUSTCOUNT FOR BARS.CUSTCOUNT;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CUSTCOUNT.sql =========*** End *** ===
PROMPT ===================================================================================== 
