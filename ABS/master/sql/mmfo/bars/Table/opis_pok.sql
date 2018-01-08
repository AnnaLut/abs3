

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OPIS_POK.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OPIS_POK ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OPIS_POK ***
begin 
  execute immediate '
  CREATE TABLE BARS.OPIS_POK 
   (	N_FILE VARCHAR2(2), 
	BEGIN NUMBER(2,0), 
	KOL NUMBER(2,0), 
	KL_FILE VARCHAR2(10), 
	IM_POL VARCHAR2(10), 
	DATA_O DATE, 
	DATA_C DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OPIS_POK ***
 exec bpa.alter_policies('OPIS_POK');


COMMENT ON TABLE BARS.OPIS_POK IS '';
COMMENT ON COLUMN BARS.OPIS_POK.N_FILE IS '';
COMMENT ON COLUMN BARS.OPIS_POK.BEGIN IS '';
COMMENT ON COLUMN BARS.OPIS_POK.KOL IS '';
COMMENT ON COLUMN BARS.OPIS_POK.KL_FILE IS '';
COMMENT ON COLUMN BARS.OPIS_POK.IM_POL IS '';
COMMENT ON COLUMN BARS.OPIS_POK.DATA_O IS '';
COMMENT ON COLUMN BARS.OPIS_POK.DATA_C IS '';



PROMPT *** Create  grants  OPIS_POK ***
grant SELECT                                                                 on OPIS_POK        to BARSREADER_ROLE;
grant SELECT                                                                 on OPIS_POK        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OPIS_POK.sql =========*** End *** ====
PROMPT ===================================================================================== 
