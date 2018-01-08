

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NOTA_TR.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to NOTA_TR ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NOTA_TR'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''NOTA_TR'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''NOTA_TR'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NOTA_TR ***
begin 
  execute immediate '
  CREATE TABLE BARS.NOTA_TR 
   (	ID NUMBER(*,0), 
	TYPR VARCHAR2(64)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to NOTA_TR ***
 exec bpa.alter_policies('NOTA_TR');


COMMENT ON TABLE BARS.NOTA_TR IS '“ипи реЇстрац≥й нотар≥уса';
COMMENT ON COLUMN BARS.NOTA_TR.ID IS 'Iдентиф≥катор';
COMMENT ON COLUMN BARS.NOTA_TR.TYPR IS '“ип';



PROMPT *** Create  grants  NOTA_TR ***
grant SELECT                                                                 on NOTA_TR         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on NOTA_TR         to BARS_DM;
grant SELECT                                                                 on NOTA_TR         to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NOTA_TR.sql =========*** End *** =====
PROMPT ===================================================================================== 
