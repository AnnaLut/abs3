

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DFO.sql =========*** Run *** =========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DFO ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DFO'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DFO'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''DFO'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DFO ***
begin 
  execute immediate '
  CREATE TABLE BARS.DFO 
   (	BRANCH VARCHAR2(30), 
	PDFONAM VARCHAR2(38), 
	PDFONLS VARCHAR2(15), 
	PDFOID VARCHAR2(14), 
	PDFOMFO VARCHAR2(12), 
	PDFOVZB VARCHAR2(15)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DFO ***
 exec bpa.alter_policies('DFO');


COMMENT ON TABLE BARS.DFO IS '';
COMMENT ON COLUMN BARS.DFO.BRANCH IS '';
COMMENT ON COLUMN BARS.DFO.PDFONAM IS '';
COMMENT ON COLUMN BARS.DFO.PDFONLS IS '';
COMMENT ON COLUMN BARS.DFO.PDFOID IS '';
COMMENT ON COLUMN BARS.DFO.PDFOMFO IS '';
COMMENT ON COLUMN BARS.DFO.PDFOVZB IS '';



PROMPT *** Create  grants  DFO ***
grant SELECT                                                                 on DFO             to BARSREADER_ROLE;
grant SELECT                                                                 on DFO             to BARS_DM;
grant SELECT                                                                 on DFO             to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DFO.sql =========*** End *** =========
PROMPT ===================================================================================== 
