

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/GEO_TAB.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to GEO_TAB ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table GEO_TAB ***
begin 
  execute immediate '
  CREATE TABLE BARS.GEO_TAB 
   (	ACC NUMBER(*,0), 
	NLS VARCHAR2(15)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to GEO_TAB ***
 exec bpa.alter_policies('GEO_TAB');


COMMENT ON TABLE BARS.GEO_TAB IS '';
COMMENT ON COLUMN BARS.GEO_TAB.ACC IS '';
COMMENT ON COLUMN BARS.GEO_TAB.NLS IS '';



PROMPT *** Create  grants  GEO_TAB ***
grant DELETE,INSERT,SELECT,UPDATE                                            on GEO_TAB         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on GEO_TAB         to BARS_DM;



PROMPT *** Create SYNONYM  to GEO_TAB ***

  CREATE OR REPLACE PUBLIC SYNONYM GEO_TAB FOR BARS.GEO_TAB;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/GEO_TAB.sql =========*** End *** =====
PROMPT ===================================================================================== 
