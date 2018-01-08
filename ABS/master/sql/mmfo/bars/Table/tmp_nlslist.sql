

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_NLSLIST.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_NLSLIST ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_NLSLIST ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.TMP_NLSLIST 
   (	NLS VARCHAR2(14), 
	KV NUMBER, 
	BRANCH VARCHAR2(30)
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_NLSLIST ***
 exec bpa.alter_policies('TMP_NLSLIST');


COMMENT ON TABLE BARS.TMP_NLSLIST IS 'Временная таблица для содержания списка счетов для выписок';
COMMENT ON COLUMN BARS.TMP_NLSLIST.NLS IS '';
COMMENT ON COLUMN BARS.TMP_NLSLIST.KV IS '';
COMMENT ON COLUMN BARS.TMP_NLSLIST.BRANCH IS '';



PROMPT *** Create  grants  TMP_NLSLIST ***
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_NLSLIST     to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_NLSLIST     to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_NLSLIST.sql =========*** End *** =
PROMPT ===================================================================================== 
