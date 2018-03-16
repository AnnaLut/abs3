

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_NBUR_#3KX_DTL.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_NBUR_3KX_DTL ***

CREATE OR REPLACE FORCE VIEW BARS.V_NBUR_3KX_DTL
(
   REPORT_DATE,
   KF,
   VERSION_ID,
   NBUC,
   FIELD_CODE,
   SEG_01,
   SEG_02,
   FIELD_VALUE,
   DESCRIPTION,
   ACC_ID,
   ACC_NUM,
   KV,
   MATURITY_DATE,
   CUST_ID,
   CUST_CODE,
   CUST_NAME,
   ND,
   AGRM_NUM,
   BEG_DT,
   END_DT,
   REF,
   BRANCH
)
AS
     SELECT p.REPORT_DATE,
            p.KF,
            p.VERSION_ID,
            p.NBUC,
            p.FIELD_CODE,
            SUBSTR (p.FIELD_CODE, 1, 4) AS SEG_01,
            SUBSTR (p.FIELD_CODE, 5, 3) AS SEG_02,
            p.FIELD_VALUE,
            p.DESCRIPTION,
            p.ACC_ID,
            p.ACC_NUM,
            p.KV,
            p.MATURITY_DATE,
            p.CUST_ID,
            c.CUST_CODE,
            c.CUST_NAME,
            p.ND,
            a.AGRM_NUM,
            a.BEG_DT,
            a.END_DT,
            p.REF,
            p.BRANCH
       FROM NBUR_DETAIL_PROTOCOLS_ARCH p
            JOIN NBUR_REF_FILES f ON (f.FILE_CODE = p.REPORT_CODE)
            JOIN
            NBUR_LST_FILES v
               ON (    v.REPORT_DATE = p.REPORT_DATE
                   AND v.KF = p.KF
                   AND v.VERSION_ID = p.VERSION_ID
                   AND v.FILE_ID = f.ID)
            LEFT OUTER JOIN
            V_NBUR_DM_CUSTOMERS c
               ON (    p.REPORT_DATE = c.REPORT_DATE
                   AND p.KF = c.KF
                   AND p.CUST_ID = c.CUST_ID)
            LEFT OUTER JOIN
            V_NBUR_DM_AGREEMENTS a
               ON (    p.REPORT_DATE = a.REPORT_DATE
                   AND p.KF = a.KF
                   AND p.nd = a.AGRM_ID)
      WHERE p.REPORT_CODE = '#3K' AND v.FILE_STATUS IN ('FINISHED', 'BLOCKED')
   ORDER BY nbuc, SUBSTR (FIELD_CODE, 5, 3), 
            (case SUBSTR (FIELD_CODE, 1, 4) 
            when 'F091' then 1 
            when 'R030' then 2 
            when 'T071' then 3
            when 'K020' then 4
            when 'K021' then 5 
            when 'Q001' then 6
            when 'Q024' then 7 
            when 'D100' then 8
            when 'S180' then 9 
            when 'F089' then 10 
            when 'F092' then 11
            when 'Q003' then 12 
            when 'Q007' then 13
            when 'Q006' then 14
            else 15
            end)
/

COMMENT ON TABLE BARS.V_NBUR_3KX_DTL IS 'Детальний протокол файлу 3KX'
/

COMMENT ON COLUMN BARS.V_NBUR_3KX_DTL.REPORT_DATE IS 'Звітна дата'
/

COMMENT ON COLUMN BARS.V_NBUR_3KX_DTL.KF IS 'Код фiлiалу (МФО)'
/

COMMENT ON COLUMN BARS.V_NBUR_3KX_DTL.VERSION_ID IS 'Ід. версії файлу'
/

COMMENT ON COLUMN BARS.V_NBUR_3KX_DTL.NBUC IS 'Код розрізу даних у звітному файлі'
/

COMMENT ON COLUMN BARS.V_NBUR_3KX_DTL.FIELD_CODE IS 'Код показника'
/

COMMENT ON COLUMN BARS.V_NBUR_3KX_DTL.SEG_01 IS 'Елемент'
/

COMMENT ON COLUMN BARS.V_NBUR_3KX_DTL.SEG_02 IS 'Умовний номер'
/

COMMENT ON COLUMN BARS.V_NBUR_3KX_DTL.FIELD_VALUE IS 'Значення показника'
/

COMMENT ON COLUMN BARS.V_NBUR_3KX_DTL.DESCRIPTION IS 'Опис (коментар)'
/

COMMENT ON COLUMN BARS.V_NBUR_3KX_DTL.ACC_ID IS 'Ід. рахунка'
/

COMMENT ON COLUMN BARS.V_NBUR_3KX_DTL.ACC_NUM IS 'Номер рахунка'
/

COMMENT ON COLUMN BARS.V_NBUR_3KX_DTL.KV IS 'Ід. валюти'
/

COMMENT ON COLUMN BARS.V_NBUR_3KX_DTL.MATURITY_DATE IS 'Дата Погашення'
/

COMMENT ON COLUMN BARS.V_NBUR_3KX_DTL.CUST_ID IS 'Ід. клієнта'
/

COMMENT ON COLUMN BARS.V_NBUR_3KX_DTL.CUST_CODE IS 'Код клієнта'
/

COMMENT ON COLUMN BARS.V_NBUR_3KX_DTL.CUST_NAME IS 'Назва клієнта'
/

COMMENT ON COLUMN BARS.V_NBUR_3KX_DTL.ND IS 'Ід. договору'
/

COMMENT ON COLUMN BARS.V_NBUR_3KX_DTL.AGRM_NUM IS 'Номер договору'
/

COMMENT ON COLUMN BARS.V_NBUR_3KX_DTL.BEG_DT IS 'Дата початку договору'
/

COMMENT ON COLUMN BARS.V_NBUR_3KX_DTL.END_DT IS 'Дата закінчення договору'
/

COMMENT ON COLUMN BARS.V_NBUR_3KX_DTL.REF IS 'Ід. платіжного документа'
/

COMMENT ON COLUMN BARS.V_NBUR_3KX_DTL.BRANCH IS 'Код підрозділу'
/



GRANT SELECT ON BARS.V_NBUR_3KX_DTL TO BARSREADER_ROLE
/

GRANT SELECT ON BARS.V_NBUR_3KX_DTL TO BARS_ACCESS_DEFROLE
/

GRANT SELECT ON BARS.V_NBUR_3KX_DTL TO UPLD
/


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_NBUR_3KX_DTL.sql =========*** End ***
PROMPT ===================================================================================== 
