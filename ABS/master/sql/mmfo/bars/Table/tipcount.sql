

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TIPCOUNT.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TIPCOUNT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TIPCOUNT'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''TIPCOUNT'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''TIPCOUNT'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TIPCOUNT ***
begin 
  execute immediate '
  CREATE TABLE BARS.TIPCOUNT 
   (	TIP CHAR(1), 
	NAME VARCHAR2(35), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TIPCOUNT ***
 exec bpa.alter_policies('TIPCOUNT');


COMMENT ON TABLE BARS.TIPCOUNT IS '';
COMMENT ON COLUMN BARS.TIPCOUNT.TIP IS '';
COMMENT ON COLUMN BARS.TIPCOUNT.NAME IS '';
COMMENT ON COLUMN BARS.TIPCOUNT.KF IS '';




PROMPT *** Create  constraint XPK_TIPCOUNT ***
begin   
 execute immediate '
  ALTER TABLE BARS.TIPCOUNT ADD CONSTRAINT XPK_TIPCOUNT PRIMARY KEY (TIP)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008061 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TIPCOUNT MODIFY (TIP NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_TIPCOUNT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_TIPCOUNT ON BARS.TIPCOUNT (TIP) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TIPCOUNT ***
grant SELECT                                                                 on TIPCOUNT        to BARSREADER_ROLE;
grant INSERT,SELECT                                                          on TIPCOUNT        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TIPCOUNT        to BARS_DM;
grant INSERT,SELECT                                                          on TIPCOUNT        to OPERKKK;
grant INSERT,SELECT                                                          on TIPCOUNT        to TECH_MOM1;
grant SELECT                                                                 on TIPCOUNT        to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TIPCOUNT        to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to TIPCOUNT ***

  CREATE OR REPLACE PUBLIC SYNONYM TIPCOUNT FOR BARS.TIPCOUNT;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TIPCOUNT.sql =========*** End *** ====
PROMPT ===================================================================================== 
