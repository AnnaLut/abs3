PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_nbur_A4x.sql =========*** Run *** ===
PROMPT ===================================================================================== 

CREATE OR REPLACE VIEW BARS.V_NBUR_A4X 
AS 
  select V.REPORT_DATE
       , V.KF
       , V.VERSION_ID
       , extractvalue( column_value, 'DATA/EKP'  ) as EKP
       , extractvalue( column_value, 'DATA/KU'   ) as KU
       , extractvalue( column_value, 'DATA/R020' ) as R020
       , extractvalue( column_value, 'DATA/T020' ) as T020
       , extractvalue( column_value, 'DATA/R030' ) as R030
       , extractvalue( column_value, 'DATA/K040' ) as K040
       , extractvalue( column_value, 'DATA/T070' ) as T070
       , extractvalue( column_value, 'DATA/T071' ) as T071
  from NBUR_REF_FILES F
     , NBUR_LST_FILES V
     , table( xmlsequence( XMLTYPE( V.FILE_BODY ).extract( '/NBUSTATREPORT/DATA' ) ) ) T
 where F.ID = V.FILE_ID
   and F.FILE_CODE = 'A4X'
   and F.FILE_FMT = 'XML'
   and V.FILE_STATUS in ( 'FINISHED', 'BLOCKED' )
 order by EKP,R020,R030;

   COMMENT ON TABLE V_NBUR_A4X  IS 'A4X - Данi про залишки та рiчнi корегуючi обороти (розгорнутi 6,7 клас)';

   COMMENT ON COLUMN V_NBUR_A4X.REPORT_DATE IS 'Звітна дата';
   COMMENT ON COLUMN V_NBUR_A4X.KF IS 'Код фiлiалу (МФО)';
   COMMENT ON COLUMN V_NBUR_A4X.VERSION_ID IS 'Ід. версії файлу';
   COMMENT ON COLUMN V_NBUR_A4X.EKP IS 'Код показника';
   COMMENT ON COLUMN V_NBUR_A4X.KU IS 'Код областi розрiзу юридичної особи';
   COMMENT ON COLUMN V_NBUR_A4X.R020 IS 'Номер рахунку';
   COMMENT ON COLUMN V_NBUR_A4X.T020 IS 'Код елементу даних за рахунком';
   COMMENT ON COLUMN V_NBUR_A4X.R030 IS 'Код валюти';
   COMMENT ON COLUMN V_NBUR_A4X.K040 IS 'Код країни';
   COMMENT ON COLUMN V_NBUR_A4X.T070 IS 'Сума в гривневому еквіваленті';
   COMMENT ON COLUMN V_NBUR_A4X.T071 IS 'Сума в іноземній валюті';

   GRANT SELECT ON V_NBUR_A4X TO UPLD;
   GRANT SELECT ON V_NBUR_A4X TO BARS_ACCESS_DEFROLE;
   GRANT SELECT ON V_NBUR_A4X TO BARSREADER_ROLE;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_nbur_A4x.sql =========*** End *** ===
PROMPT ===================================================================================== 

