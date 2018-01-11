

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_NLSLIST2.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_NLSLIST2 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_NLSLIST2 ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.TMP_NLSLIST2 
   (	NLS VARCHAR2(30), 
	KV NUMBER, 
	BRANCH VARCHAR2(30)
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_NLSLIST2 ***
 exec bpa.alter_policies('TMP_NLSLIST2');


COMMENT ON TABLE BARS.TMP_NLSLIST2 IS '';
COMMENT ON COLUMN BARS.TMP_NLSLIST2.NLS IS '';
COMMENT ON COLUMN BARS.TMP_NLSLIST2.KV IS '';
COMMENT ON COLUMN BARS.TMP_NLSLIST2.BRANCH IS '';



PROMPT *** Create  grants  TMP_NLSLIST2 ***
grant SELECT                                                                 on TMP_NLSLIST2    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_NLSLIST2.sql =========*** End *** 
PROMPT ===================================================================================== 
