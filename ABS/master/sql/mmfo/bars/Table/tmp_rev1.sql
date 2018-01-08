

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_REV1.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_REV1 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_REV1 ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.TMP_REV1 
   (	NBS CHAR(4), 
	KV NUMBER(*,0), 
	ACC NUMBER(*,0)
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_REV1 ***
 exec bpa.alter_policies('TMP_REV1');


COMMENT ON TABLE BARS.TMP_REV1 IS '';
COMMENT ON COLUMN BARS.TMP_REV1.NBS IS '';
COMMENT ON COLUMN BARS.TMP_REV1.KV IS '';
COMMENT ON COLUMN BARS.TMP_REV1.ACC IS '';



PROMPT *** Create  grants  TMP_REV1 ***
grant SELECT                                                                 on TMP_REV1        to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_REV1        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_REV1        to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_REV1        to START1;
grant SELECT                                                                 on TMP_REV1        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_REV1.sql =========*** End *** ====
PROMPT ===================================================================================== 
