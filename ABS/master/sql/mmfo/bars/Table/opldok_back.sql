

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OPLDOK_BACK.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OPLDOK_BACK ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OPLDOK_BACK ***
begin 
  execute immediate '
  CREATE TABLE BARS.OPLDOK_BACK 
   (	REF NUMBER, 
	TT CHAR(3), 
	DK NUMBER, 
	ACC NUMBER, 
	FDAT DATE, 
	S NUMBER(24,0), 
	SQ NUMBER(24,0), 
	TXT VARCHAR2(70), 
	STMT NUMBER, 
	SOS NUMBER, 
	ID NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OPLDOK_BACK ***
 exec bpa.alter_policies('OPLDOK_BACK');


COMMENT ON TABLE BARS.OPLDOK_BACK IS '';
COMMENT ON COLUMN BARS.OPLDOK_BACK.REF IS '';
COMMENT ON COLUMN BARS.OPLDOK_BACK.TT IS '';
COMMENT ON COLUMN BARS.OPLDOK_BACK.DK IS '';
COMMENT ON COLUMN BARS.OPLDOK_BACK.ACC IS '';
COMMENT ON COLUMN BARS.OPLDOK_BACK.FDAT IS '';
COMMENT ON COLUMN BARS.OPLDOK_BACK.S IS '';
COMMENT ON COLUMN BARS.OPLDOK_BACK.SQ IS '';
COMMENT ON COLUMN BARS.OPLDOK_BACK.TXT IS '';
COMMENT ON COLUMN BARS.OPLDOK_BACK.STMT IS '';
COMMENT ON COLUMN BARS.OPLDOK_BACK.SOS IS '';
COMMENT ON COLUMN BARS.OPLDOK_BACK.ID IS '';




PROMPT *** Create  constraint XPK_OPLDOK_BACK ***
begin   
 execute immediate '
  ALTER TABLE BARS.OPLDOK_BACK ADD CONSTRAINT XPK_OPLDOK_BACK PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0011812 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OPLDOK_BACK ADD CHECK (DK IN (0,1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_OPLDOK_BACK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_OPLDOK_BACK ON BARS.OPLDOK_BACK (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index XIE_FDAT_ACC_OPLDOK_BACK ***
begin   
 execute immediate '
  CREATE INDEX BARS.XIE_FDAT_ACC_OPLDOK_BACK ON BARS.OPLDOK_BACK (FDAT, ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OPLDOK_BACK ***
grant DELETE,INSERT,SELECT,UPDATE                                            on OPLDOK_BACK     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on OPLDOK_BACK     to BARS_DM;



PROMPT *** Create SYNONYM  to OPLDOK_BACK ***

  CREATE OR REPLACE PUBLIC SYNONYM OPLDOK_BACK FOR BARS.OPLDOK_BACK;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OPLDOK_BACK.sql =========*** End *** =
PROMPT ===================================================================================== 
