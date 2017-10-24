

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ROZNICABUSINESS.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ROZNICABUSINESS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ROZNICABUSINESS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''ROZNICABUSINESS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ROZNICABUSINESS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ROZNICABUSINESS ***
begin 
  execute immediate '
  CREATE TABLE BARS.ROZNICABUSINESS 
   (	OKPO VARCHAR2(10), 
	NAME VARCHAR2(110), 
	ND VARCHAR2(30), 
	ID NUMBER, 
	COUNTRY VARCHAR2(3), 
	NLS VARCHAR2(14)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ROZNICABUSINESS ***
 exec bpa.alter_policies('ROZNICABUSINESS');


COMMENT ON TABLE BARS.ROZNICABUSINESS IS '';
COMMENT ON COLUMN BARS.ROZNICABUSINESS.OKPO IS '';
COMMENT ON COLUMN BARS.ROZNICABUSINESS.NAME IS '';
COMMENT ON COLUMN BARS.ROZNICABUSINESS.ND IS '';
COMMENT ON COLUMN BARS.ROZNICABUSINESS.ID IS '';
COMMENT ON COLUMN BARS.ROZNICABUSINESS.COUNTRY IS '';
COMMENT ON COLUMN BARS.ROZNICABUSINESS.NLS IS '';




PROMPT *** Create  constraint SYS_C007805 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ROZNICABUSINESS MODIFY (NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ROZNICABUSINESS ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on ROZNICABUSINESS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ROZNICABUSINESS to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on ROZNICABUSINESS to START1;
grant FLASHBACK,SELECT                                                       on ROZNICABUSINESS to WR_REFREAD;



PROMPT *** Create SYNONYM  to ROZNICABUSINESS ***

  CREATE OR REPLACE PUBLIC SYNONYM ROZNICABUSINESS FOR BARS.ROZNICABUSINESS;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ROZNICABUSINESS.sql =========*** End *
PROMPT ===================================================================================== 
