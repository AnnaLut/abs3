

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OTC_TMP_AUD.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OTC_TMP_AUD ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OTC_TMP_AUD ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.OTC_TMP_AUD 
   (	ACC NUMBER(*,0), 
	KV NUMBER(*,0), 
	NLS VARCHAR2(15), 
	TXT VARCHAR2(100)
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OTC_TMP_AUD ***
 exec bpa.alter_policies('OTC_TMP_AUD');


COMMENT ON TABLE BARS.OTC_TMP_AUD IS 'Протокол аудита СПЕЦ.параметров';
COMMENT ON COLUMN BARS.OTC_TMP_AUD.ACC IS 'Внутренний ключ';
COMMENT ON COLUMN BARS.OTC_TMP_AUD.KV IS 'Код вал';
COMMENT ON COLUMN BARS.OTC_TMP_AUD.NLS IS 'Счет';
COMMENT ON COLUMN BARS.OTC_TMP_AUD.TXT IS 'Сообщение об ошибке';



PROMPT *** Create  grants  OTC_TMP_AUD ***
grant DELETE,INSERT,SELECT,UPDATE                                            on OTC_TMP_AUD     to ABS_ADMIN;
grant SELECT                                                                 on OTC_TMP_AUD     to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on OTC_TMP_AUD     to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on OTC_TMP_AUD     to RPBN002;
grant SELECT                                                                 on OTC_TMP_AUD     to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on OTC_TMP_AUD     to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OTC_TMP_AUD.sql =========*** End *** =
PROMPT ===================================================================================== 
