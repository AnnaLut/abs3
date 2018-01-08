

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_REV2.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_REV2 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_REV2 ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.TMP_REV2 
   (	ACC NUMBER(*,0), 
	KV NUMBER(*,0), 
	VXQ NUMBER, 
	KOS NUMBER, 
	DOS NUMBER, 
	TV NUMBER(*,0)
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_REV2 ***
 exec bpa.alter_policies('TMP_REV2');


COMMENT ON TABLE BARS.TMP_REV2 IS '';
COMMENT ON COLUMN BARS.TMP_REV2.ACC IS '';
COMMENT ON COLUMN BARS.TMP_REV2.KV IS '';
COMMENT ON COLUMN BARS.TMP_REV2.VXQ IS '';
COMMENT ON COLUMN BARS.TMP_REV2.KOS IS '';
COMMENT ON COLUMN BARS.TMP_REV2.DOS IS '';
COMMENT ON COLUMN BARS.TMP_REV2.TV IS '';



PROMPT *** Create  grants  TMP_REV2 ***
grant SELECT                                                                 on TMP_REV2        to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_REV2        to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_REV2        to START1;
grant SELECT                                                                 on TMP_REV2        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_REV2.sql =========*** End *** ====
PROMPT ===================================================================================== 
