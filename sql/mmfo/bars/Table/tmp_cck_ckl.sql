

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_CCK_CKL.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_CCK_CKL ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_CCK_CKL ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.TMP_CCK_CKL 
   (	NLS VARCHAR2(15), 
	KV NUMBER(*,0), 
	FDAT0 DATE, 
	DOS0 NUMBER(24,2), 
	FDAT1 DATE, 
	KOS1 NUMBER(24,2), 
	SUMP NUMBER(24,2)
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_CCK_CKL ***
 exec bpa.alter_policies('TMP_CCK_CKL');


COMMENT ON TABLE BARS.TMP_CCK_CKL IS 'Графiк погашення Циклiчних Кредитних Лiнiй';
COMMENT ON COLUMN BARS.TMP_CCK_CKL.NLS IS '';
COMMENT ON COLUMN BARS.TMP_CCK_CKL.KV IS '';
COMMENT ON COLUMN BARS.TMP_CCK_CKL.FDAT0 IS 'Дата~видачi~траншу';
COMMENT ON COLUMN BARS.TMP_CCK_CKL.DOS0 IS 'Сума~виданого траншу';
COMMENT ON COLUMN BARS.TMP_CCK_CKL.FDAT1 IS 'План-дата~погашення';
COMMENT ON COLUMN BARS.TMP_CCK_CKL.KOS1 IS 'Факт-сума~погашення';
COMMENT ON COLUMN BARS.TMP_CCK_CKL.SUMP IS 'Сума виноса~на проср.';



PROMPT *** Create  grants  TMP_CCK_CKL ***
grant SELECT                                                                 on TMP_CCK_CKL     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_CCK_CKL     to RCC_DEAL;
grant SELECT                                                                 on TMP_CCK_CKL     to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_CCK_CKL.sql =========*** End *** =
PROMPT ===================================================================================== 
