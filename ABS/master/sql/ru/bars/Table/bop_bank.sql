

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BOP_BANK.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BOP_BANK ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BOP_BANK'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''BOP_BANK'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BOP_BANK ***
begin 
  execute immediate '
  CREATE TABLE BARS.BOP_BANK 
   (	REGNUM CHAR(4), 
	NAME VARCHAR2(36), 
	ADDRESS VARCHAR2(35), 
	FIO CHAR(3), 
	EDKPO CHAR(10)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BOP_BANK ***
 exec bpa.alter_policies('BOP_BANK');


COMMENT ON TABLE BARS.BOP_BANK IS '';
COMMENT ON COLUMN BARS.BOP_BANK.REGNUM IS '';
COMMENT ON COLUMN BARS.BOP_BANK.NAME IS '';
COMMENT ON COLUMN BARS.BOP_BANK.ADDRESS IS '';
COMMENT ON COLUMN BARS.BOP_BANK.FIO IS '';
COMMENT ON COLUMN BARS.BOP_BANK.EDKPO IS '';



PROMPT *** Create  grants  BOP_BANK ***
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on BOP_BANK        to ABS_ADMIN;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on BOP_BANK        to BARS_ACCESS_DEFROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on BOP_BANK        to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to BOP_BANK ***

  CREATE OR REPLACE PUBLIC SYNONYM BOP_BANK FOR BARS.BOP_BANK;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BOP_BANK.sql =========*** End *** ====
PROMPT ===================================================================================== 
