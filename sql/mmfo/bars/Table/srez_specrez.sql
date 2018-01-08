

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SREZ_SPECREZ.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SREZ_SPECREZ ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SREZ_SPECREZ'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SREZ_SPECREZ'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SREZ_SPECREZ'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SREZ_SPECREZ ***
begin 
  execute immediate '
  CREATE TABLE BARS.SREZ_SPECREZ 
   (	ID NUMBER, 
	ISTVAL NUMBER, 
	DT_BEGIN DATE, 
	DT_END DATE, 
	ID_NBS VARCHAR2(100), 
	CUSTTYPE VARCHAR2(100), 
	NAME VARCHAR2(100), 
	DESCRIPTION VARCHAR2(250)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SREZ_SPECREZ ***
 exec bpa.alter_policies('SREZ_SPECREZ');


COMMENT ON TABLE BARS.SREZ_SPECREZ IS '';
COMMENT ON COLUMN BARS.SREZ_SPECREZ.ID IS '';
COMMENT ON COLUMN BARS.SREZ_SPECREZ.ISTVAL IS '';
COMMENT ON COLUMN BARS.SREZ_SPECREZ.DT_BEGIN IS '';
COMMENT ON COLUMN BARS.SREZ_SPECREZ.DT_END IS '';
COMMENT ON COLUMN BARS.SREZ_SPECREZ.ID_NBS IS '';
COMMENT ON COLUMN BARS.SREZ_SPECREZ.CUSTTYPE IS '';
COMMENT ON COLUMN BARS.SREZ_SPECREZ.NAME IS '';
COMMENT ON COLUMN BARS.SREZ_SPECREZ.DESCRIPTION IS '';



PROMPT *** Create  grants  SREZ_SPECREZ ***
grant SELECT                                                                 on SREZ_SPECREZ    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SREZ_SPECREZ    to BARS_DM;
grant SELECT                                                                 on SREZ_SPECREZ    to RCC_DEAL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SREZ_SPECREZ    to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to SREZ_SPECREZ ***

  CREATE OR REPLACE PUBLIC SYNONYM SREZ_SPECREZ FOR BARS.SREZ_SPECREZ;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SREZ_SPECREZ.sql =========*** End *** 
PROMPT ===================================================================================== 
