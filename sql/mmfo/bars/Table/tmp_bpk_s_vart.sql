

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_BPK_S_VART.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_BPK_S_VART ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_BPK_S_VART ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.TMP_BPK_S_VART 
   (	DT DATE, 
	SUMM NUMBER
   ) ON COMMIT DELETE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_BPK_S_VART ***
 exec bpa.alter_policies('TMP_BPK_S_VART');


COMMENT ON TABLE BARS.TMP_BPK_S_VART IS '';
COMMENT ON COLUMN BARS.TMP_BPK_S_VART.DT IS '';
COMMENT ON COLUMN BARS.TMP_BPK_S_VART.SUMM IS '';



PROMPT *** Create  grants  TMP_BPK_S_VART ***
grant SELECT                                                                 on TMP_BPK_S_VART  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_BPK_S_VART.sql =========*** End **
PROMPT ===================================================================================== 
