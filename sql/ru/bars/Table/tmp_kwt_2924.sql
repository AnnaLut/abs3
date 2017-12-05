

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_KWT_2924.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_KWT_2924 ***



PROMPT *** Create  table TMP_KWT_2924 ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.TMP_KWT_2924 
   (	FDAT DATE, 
	REF NUMBER, 
	S NUMBER, 
	TT2 CHAR(3)
   ) ON COMMIT DELETE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_KWT_2924 ***
 exec bpa.alter_policies('TMP_KWT_2924');


COMMENT ON TABLE BARS.TMP_KWT_2924 IS '';
COMMENT ON COLUMN BARS.TMP_KWT_2924.FDAT IS '';
COMMENT ON COLUMN BARS.TMP_KWT_2924.REF IS '';
COMMENT ON COLUMN BARS.TMP_KWT_2924.S IS '';
COMMENT ON COLUMN BARS.TMP_KWT_2924.TT2 IS '';




PROMPT *** Create  index IND_KWT_2924 ***
begin   
 execute immediate '
  CREATE INDEX BARS.IND_KWT_2924 ON BARS.TMP_KWT_2924 (S, REF) ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_KWT_2924.sql =========*** End *** 
PROMPT ===================================================================================== 
