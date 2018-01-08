

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BOPCOUNT.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BOPCOUNT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BOPCOUNT'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''BOPCOUNT'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''BOPCOUNT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BOPCOUNT ***
begin 
  execute immediate '
  CREATE TABLE BARS.BOPCOUNT 
   (	ISO_COUNTR CHAR(3), 
	KODC CHAR(3), 
	COUNTRY VARCHAR2(36), 
	PR CHAR(2), 
	A2 CHAR(2)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BOPCOUNT ***
 exec bpa.alter_policies('BOPCOUNT');


COMMENT ON TABLE BARS.BOPCOUNT IS '';
COMMENT ON COLUMN BARS.BOPCOUNT.ISO_COUNTR IS '';
COMMENT ON COLUMN BARS.BOPCOUNT.KODC IS '';
COMMENT ON COLUMN BARS.BOPCOUNT.COUNTRY IS '';
COMMENT ON COLUMN BARS.BOPCOUNT.PR IS '';
COMMENT ON COLUMN BARS.BOPCOUNT.A2 IS '';




PROMPT *** Create  constraint XPK_BOPCOUNT ***
begin   
 execute immediate '
  ALTER TABLE BARS.BOPCOUNT ADD CONSTRAINT XPK_BOPCOUNT PRIMARY KEY (ISO_COUNTR)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_BOPCOUNT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_BOPCOUNT ON BARS.BOPCOUNT (ISO_COUNTR) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BOPCOUNT ***
grant DELETE,INSERT,SELECT,UPDATE                                            on BOPCOUNT        to ABS_ADMIN;
grant SELECT                                                                 on BOPCOUNT        to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on BOPCOUNT        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on BOPCOUNT        to BARS_DM;
grant SELECT                                                                 on BOPCOUNT        to OPERKKK;
grant DELETE,INSERT,SELECT,UPDATE                                            on BOPCOUNT        to PB1;
grant SELECT                                                                 on BOPCOUNT        to PYOD001;
grant SELECT                                                                 on BOPCOUNT        to START1;
grant SELECT                                                                 on BOPCOUNT        to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on BOPCOUNT        to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on BOPCOUNT        to WR_REFREAD;



PROMPT *** Create SYNONYM  to BOPCOUNT ***

  CREATE OR REPLACE PUBLIC SYNONYM BOPCOUNT FOR BARS.BOPCOUNT;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BOPCOUNT.sql =========*** End *** ====
PROMPT ===================================================================================== 
