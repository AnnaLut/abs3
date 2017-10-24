

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CENA_RAZM.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CENA_RAZM ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CENA_RAZM'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CENA_RAZM'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CENA_RAZM'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CENA_RAZM ***
begin 
  execute immediate '
  CREATE TABLE BARS.CENA_RAZM 
   (	ID NUMBER(*,0), 
	DAT_BEG DATE, 
	DAT_END DATE, 
	NOM NUMBER, 
	KUPON NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CENA_RAZM ***
 exec bpa.alter_policies('CENA_RAZM');


COMMENT ON TABLE BARS.CENA_RAZM IS '';
COMMENT ON COLUMN BARS.CENA_RAZM.ID IS '';
COMMENT ON COLUMN BARS.CENA_RAZM.DAT_BEG IS '';
COMMENT ON COLUMN BARS.CENA_RAZM.DAT_END IS '';
COMMENT ON COLUMN BARS.CENA_RAZM.NOM IS '';
COMMENT ON COLUMN BARS.CENA_RAZM.KUPON IS '';



PROMPT *** Create  grants  CENA_RAZM ***
grant SELECT                                                                 on CENA_RAZM       to BARS_DM;
grant SELECT                                                                 on CENA_RAZM       to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CENA_RAZM.sql =========*** End *** ===
PROMPT ===================================================================================== 
