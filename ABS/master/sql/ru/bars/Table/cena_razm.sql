

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CENA_RAZM.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CENA_RAZM ***


BEGIN 
        execute immediate  
          'begin  
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
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
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




PROMPT *** Create  constraint FK_CENARAZM_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.CENA_RAZM ADD CONSTRAINT FK_CENARAZM_ID FOREIGN KEY (ID)
	  REFERENCES BARS.CP_KOD (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CENA_RAZM.sql =========*** End *** ===
PROMPT ===================================================================================== 
