

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_GENERAL_DOC_TURNOVER.sql =========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_GENERAL_DOC_TURNOVER ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TMP_GENERAL_DOC_TURNOVER'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_GENERAL_DOC_TURNOVER'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_GENERAL_DOC_TURNOVER'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_GENERAL_DOC_TURNOVER ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.TMP_GENERAL_DOC_TURNOVER 
   (	ZVIT_DATE VARCHAR2(30), 
	USERID NUMBER, 
	FIO VARCHAR2(60), 
	WHOLE_KOL_DOC NUMBER, 
	WHOLE_KOL_PROV NUMBER, 
	WHOLE_UAH_SUMMA NUMBER, 
	KASSA_KOL_DOC NUMBER, 
	KASSA_UAH_SUMMA NUMBER, 
	AUTO_KOL_DOC NUMBER, 
	AUTO_UAH_SUMMA NUMBER, 
	FOLDER_KOL_DOC NUMBER, 
	FOLDER_UAH_SUMMA NUMBER
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_GENERAL_DOC_TURNOVER ***
 exec bpa.alter_policies('TMP_GENERAL_DOC_TURNOVER');


COMMENT ON TABLE BARS.TMP_GENERAL_DOC_TURNOVER IS '';
COMMENT ON COLUMN BARS.TMP_GENERAL_DOC_TURNOVER.ZVIT_DATE IS '';
COMMENT ON COLUMN BARS.TMP_GENERAL_DOC_TURNOVER.USERID IS '';
COMMENT ON COLUMN BARS.TMP_GENERAL_DOC_TURNOVER.FIO IS '';
COMMENT ON COLUMN BARS.TMP_GENERAL_DOC_TURNOVER.WHOLE_KOL_DOC IS '';
COMMENT ON COLUMN BARS.TMP_GENERAL_DOC_TURNOVER.WHOLE_KOL_PROV IS '';
COMMENT ON COLUMN BARS.TMP_GENERAL_DOC_TURNOVER.WHOLE_UAH_SUMMA IS '';
COMMENT ON COLUMN BARS.TMP_GENERAL_DOC_TURNOVER.KASSA_KOL_DOC IS '';
COMMENT ON COLUMN BARS.TMP_GENERAL_DOC_TURNOVER.KASSA_UAH_SUMMA IS '';
COMMENT ON COLUMN BARS.TMP_GENERAL_DOC_TURNOVER.AUTO_KOL_DOC IS '';
COMMENT ON COLUMN BARS.TMP_GENERAL_DOC_TURNOVER.AUTO_UAH_SUMMA IS '';
COMMENT ON COLUMN BARS.TMP_GENERAL_DOC_TURNOVER.FOLDER_KOL_DOC IS '';
COMMENT ON COLUMN BARS.TMP_GENERAL_DOC_TURNOVER.FOLDER_UAH_SUMMA IS '';



PROMPT *** Create  grants  TMP_GENERAL_DOC_TURNOVER ***
grant SELECT                                                                 on TMP_GENERAL_DOC_TURNOVER to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_GENERAL_DOC_TURNOVER to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_GENERAL_DOC_TURNOVER to START1;
grant SELECT                                                                 on TMP_GENERAL_DOC_TURNOVER to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_GENERAL_DOC_TURNOVER.sql =========
PROMPT ===================================================================================== 
