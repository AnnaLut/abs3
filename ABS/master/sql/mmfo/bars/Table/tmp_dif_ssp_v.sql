

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_DIF_SSP_V.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_DIF_SSP_V ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_DIF_SSP_V ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.TMP_DIF_SSP_V 
   (	TRANS_ID VARCHAR2(12), 
	TRANS_LN NUMBER(*,0), 
	X CHAR(1), 
	LINE VARCHAR2(444), 
	SIGN RAW(128), 
	OTM CHAR(1)
   ) ON COMMIT DELETE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_DIF_SSP_V ***
 exec bpa.alter_policies('TMP_DIF_SSP_V');


COMMENT ON TABLE BARS.TMP_DIF_SSP_V IS 'Таблиця розб_жностей при зв_рц_ виписки СТП';
COMMENT ON COLUMN BARS.TMP_DIF_SSP_V.TRANS_ID IS '_дентиф_катор трансакц_ї';
COMMENT ON COLUMN BARS.TMP_DIF_SSP_V.TRANS_LN IS 'Порядковий номер _Р у пакет_ 1.08';
COMMENT ON COLUMN BARS.TMP_DIF_SSP_V.X IS 'Джерело документу: V - _з виписки СТП, A - _з таблиц_ ARC_RRP';
COMMENT ON COLUMN BARS.TMP_DIF_SSP_V.LINE IS 'Буфер документу';
COMMENT ON COLUMN BARS.TMP_DIF_SSP_V.SIGN IS 'Цифровий п_дпис документу';
COMMENT ON COLUMN BARS.TMP_DIF_SSP_V.OTM IS 'Флаг квитовки: " ","Y" ';



PROMPT *** Create  grants  TMP_DIF_SSP_V ***
grant SELECT                                                                 on TMP_DIF_SSP_V   to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_DIF_SSP_V   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_DIF_SSP_V   to TOSS;
grant SELECT                                                                 on TMP_DIF_SSP_V   to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TMP_DIF_SSP_V   to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_DIF_SSP_V.sql =========*** End ***
PROMPT ===================================================================================== 
