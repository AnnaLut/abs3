

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_FM_CHECKRULES.sql =========*** Run
PROMPT ===================================================================================== 


BEGIN 
    execute immediate 'drop table bars.TMP_FM_CHECKRULES'; 
exception
    when others then
        if sqlcode = -942 then null; else raise; end if;          
END; 
/

PROMPT *** Create  table TMP_FM_CHECKRULES ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_FM_CHECKRULES 
   (    
    ID NUMBER(22,0), 
    REF NUMBER(22,0), 
    RULES VARCHAR2(254)
   ) 
   TABLESPACE BRSDYND
  partition by list (ID)
  (
    partition usr_1 values (1)
  )';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARS.TMP_FM_CHECKRULES IS '';
COMMENT ON COLUMN BARS.TMP_FM_CHECKRULES.ID IS '';
COMMENT ON COLUMN BARS.TMP_FM_CHECKRULES.REF IS '';
COMMENT ON COLUMN BARS.TMP_FM_CHECKRULES.RULES IS '';

PROMPT *** Create  grants  TMP_FM_CHECKRULES ***
GRANT SELECT ON "BARS"."TMP_FM_CHECKRULES" TO "BARSREADER_ROLE";
GRANT SELECT ON "BARS"."TMP_FM_CHECKRULES" TO "BARS_DM";
GRANT SELECT ON "BARS"."TMP_FM_CHECKRULES" TO "FINMON01";
GRANT SELECT ON "BARS"."TMP_FM_CHECKRULES" TO "BARS_ACCESS_DEFROLE";