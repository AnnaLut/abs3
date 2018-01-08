

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_WAY4_LIST.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_WAY4_LIST ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_WAY4_LIST ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.TMP_WAY4_LIST 
   (	FILENAME VARCHAR2(255)
   ) ON COMMIT DELETE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_WAY4_LIST ***
 exec bpa.alter_policies('TMP_WAY4_LIST');


COMMENT ON TABLE BARS.TMP_WAY4_LIST IS '';
COMMENT ON COLUMN BARS.TMP_WAY4_LIST.FILENAME IS '';



PROMPT *** Create  grants  TMP_WAY4_LIST ***
grant SELECT                                                                 on TMP_WAY4_LIST   to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_WAY4_LIST.sql =========*** End ***
PROMPT ===================================================================================== 
