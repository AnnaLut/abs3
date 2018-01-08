

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ISPRO.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ISPRO ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ISPRO'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''ISPRO'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ISPRO'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ISPRO ***
begin 
  execute immediate '
  CREATE TABLE BARS.ISPRO 
   (	NPP NUMBER(9,0), 
	DEBET VARCHAR2(20), 
	KREDIT VARCHAR2(20), 
	SUMMA NUMBER(16,2), 
	NAZN VARCHAR2(160), 
	BRANCH VARCHAR2(50), 
	DT DATE, 
	REF NUMBER(*,0), 
	STMT NUMBER(*,0)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ISPRO ***
 exec bpa.alter_policies('ISPRO');


COMMENT ON TABLE BARS.ISPRO IS '';
COMMENT ON COLUMN BARS.ISPRO.NPP IS '';
COMMENT ON COLUMN BARS.ISPRO.DEBET IS '';
COMMENT ON COLUMN BARS.ISPRO.KREDIT IS '';
COMMENT ON COLUMN BARS.ISPRO.SUMMA IS '';
COMMENT ON COLUMN BARS.ISPRO.NAZN IS '';
COMMENT ON COLUMN BARS.ISPRO.BRANCH IS '';
COMMENT ON COLUMN BARS.ISPRO.DT IS '';
COMMENT ON COLUMN BARS.ISPRO.REF IS '';
COMMENT ON COLUMN BARS.ISPRO.STMT IS '';



PROMPT *** Create  grants  ISPRO ***
grant DELETE,INSERT,SELECT,UPDATE                                            on ISPRO           to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on ISPRO           to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ISPRO.sql =========*** End *** =======
PROMPT ===================================================================================== 
