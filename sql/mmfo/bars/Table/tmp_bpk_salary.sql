

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_BPK_SALARY.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_BPK_SALARY ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_BPK_SALARY ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.TMP_BPK_SALARY 
   (	NLS VARCHAR2(14), 
	NMS VARCHAR2(38), 
	OKPO VARCHAR2(10), 
	S NUMBER(22,0)
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_BPK_SALARY ***
 exec bpa.alter_policies('TMP_BPK_SALARY');


COMMENT ON TABLE BARS.TMP_BPK_SALARY IS '';
COMMENT ON COLUMN BARS.TMP_BPK_SALARY.NLS IS '';
COMMENT ON COLUMN BARS.TMP_BPK_SALARY.NMS IS '';
COMMENT ON COLUMN BARS.TMP_BPK_SALARY.OKPO IS '';
COMMENT ON COLUMN BARS.TMP_BPK_SALARY.S IS '';



PROMPT *** Create  grants  TMP_BPK_SALARY ***
grant SELECT                                                                 on TMP_BPK_SALARY  to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_BPK_SALARY  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_BPK_SALARY  to OBPC;
grant SELECT                                                                 on TMP_BPK_SALARY  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_BPK_SALARY.sql =========*** End **
PROMPT ===================================================================================== 
