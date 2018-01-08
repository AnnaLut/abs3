

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/STAFF_BANKS.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to STAFF_BANKS ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table STAFF_BANKS ***
begin 
  execute immediate '
  CREATE TABLE BARS.STAFF_BANKS 
   (	ID NUMBER, 
	MFO VARCHAR2(12)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to STAFF_BANKS ***
 exec bpa.alter_policies('STAFF_BANKS');


COMMENT ON TABLE BARS.STAFF_BANKS IS '';
COMMENT ON COLUMN BARS.STAFF_BANKS.ID IS '';
COMMENT ON COLUMN BARS.STAFF_BANKS.MFO IS '';



PROMPT *** Create  grants  STAFF_BANKS ***
grant SELECT                                                                 on STAFF_BANKS     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on STAFF_BANKS     to BARS_DM;
grant SELECT                                                                 on STAFF_BANKS     to PYOD001;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on STAFF_BANKS     to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to STAFF_BANKS ***

  CREATE OR REPLACE PUBLIC SYNONYM STAFF_BANKS FOR BARS.STAFF_BANKS;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/STAFF_BANKS.sql =========*** End *** =
PROMPT ===================================================================================== 
