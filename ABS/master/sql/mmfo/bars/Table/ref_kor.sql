

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/REF_KOR.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to REF_KOR ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table REF_KOR ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.REF_KOR 
   (	REF NUMBER(38,0), 
	VOB NUMBER(38,0), 
	VDAT DATE
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to REF_KOR ***
 exec bpa.alter_policies('REF_KOR');


COMMENT ON TABLE BARS.REF_KOR IS '';
COMMENT ON COLUMN BARS.REF_KOR.REF IS '';
COMMENT ON COLUMN BARS.REF_KOR.VOB IS '';
COMMENT ON COLUMN BARS.REF_KOR.VDAT IS '';



PROMPT *** Create  grants  REF_KOR ***
grant SELECT                                                                 on REF_KOR         to BARSREADER_ROLE;
grant SELECT                                                                 on REF_KOR         to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on REF_KOR         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/REF_KOR.sql =========*** End *** =====
PROMPT ===================================================================================== 
