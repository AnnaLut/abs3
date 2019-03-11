PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_nbur_3px.sql ========== *** Run *** =
PROMPT ===================================================================================== 

DROP VIEW BARS.V_NBUR_3PX;

/* Formatted on 17/01/2019 9:30:14 (QP5 v5.227.12220.39754) */
CREATE OR REPLACE FORCE VIEW BARS.V_NBUR_3PX
(
   REPORT_DATE,
   KF,
   VERSION_ID,
   NBUC,
   FIELD_CODE,
   EKP,
   KU,
   K020,
   R030_1,
   R030_2,
   K040,
   S050,
   S184,
   F009,
   F010,
   F011,
   F012,
   F014,
   F028,
   F036,
   F045,
   F047,
   F048,
   F050,
   F052,
   F054,
   F055,
   F070,
   Q001_1,
   Q001_2,
   Q001_3,
   Q001_4,
   Q003_1,
   Q003_2,
   Q003_3,
   Q006,
   Q007_1,
   Q007_2,
   Q007_3,
   Q007_4,
   Q007_5,
   Q007_6,
   Q007_7,
   Q007_8,
   Q007_9,
   Q009,
   Q010_1,
   Q010_2,
   Q010_3,
   Q011_1,
   Q011_2,
   Q012_1,
   Q012_2,
   Q013,
   Q021,
   T071
)
AS
   SELECT t.REPORT_DATE,
          t.KF,
          t.VERSION_ID,
          t.KF AS NBUC,
          t.EKP || t.R030_1 || t.K020 || t.Q003_3 || t.Q007_9 || t.Q006
             AS FIELD_CODE,
          t.EKP,
          t.KU,
          t.K020,
          t.R030_1,
          t.R030_2,
          t.K040,
          t.S050,
          t.S184,
          t.F009,
          t.F010,
          t.F011,
          t.F012,
          t.F014,
          t.F028,
          t.F036,
          t.F045,
          t.F047,
          t.F048,
          t.F050,
          t.F052,
          t.F054,
          t.F055,
          t.F070,
          t.Q001_1,
          t.Q001_2,
          t.Q001_3,
          t.Q001_4,
          t.Q003_1,
          t.Q003_2,
          t.Q003_3,
          t.Q006,
          t.Q007_1,
          t.Q007_2,
          t.Q007_3,
          t.Q007_4,
          t.Q007_5,
          t.Q007_6,
          t.Q007_7,
          t.Q007_8,
          t.Q007_9,
          t.Q009,
          t.Q010_1,
          t.Q010_2,
          t.Q010_3,
          t.Q011_1,
          t.Q011_2,
          t.Q012_1,
          t.Q012_2,
          t.Q013,
          t.Q021,
          t.T071
     FROM (SELECT v.REPORT_DATE,
                  v.KF,
                  v.version_id,
                  EXTRACTVALUE (COLUMN_VALUE, 'DATA/EKP') AS EKP,
                  EXTRACTVALUE (COLUMN_VALUE, 'DATA/KU') AS KU,
                  EXTRACTVALUE (COLUMN_VALUE, 'DATA/K020') AS K020,
                  EXTRACTVALUE (COLUMN_VALUE, 'DATA/R030_1') AS R030_1,
                  EXTRACTVALUE (COLUMN_VALUE, 'DATA/R030_2') AS R030_2,
                  EXTRACTVALUE (COLUMN_VALUE, 'DATA/K040') AS K040,
                  EXTRACTVALUE (COLUMN_VALUE, 'DATA/S050') AS S050,
                  EXTRACTVALUE (COLUMN_VALUE, 'DATA/S184') AS S184,
                  EXTRACTVALUE (COLUMN_VALUE, 'DATA/F009') AS F009,
                  EXTRACTVALUE (COLUMN_VALUE, 'DATA/F010') AS F010,
                  EXTRACTVALUE (COLUMN_VALUE, 'DATA/F011') AS F011,
                  EXTRACTVALUE (COLUMN_VALUE, 'DATA/F012') AS F012,
                  EXTRACTVALUE (COLUMN_VALUE, 'DATA/F014') AS F014,
                  EXTRACTVALUE (COLUMN_VALUE, 'DATA/F028') AS F028,
                  EXTRACTVALUE (COLUMN_VALUE, 'DATA/F036') AS F036,
                  EXTRACTVALUE (COLUMN_VALUE, 'DATA/F045') AS F045,
                  EXTRACTVALUE (COLUMN_VALUE, 'DATA/F047') AS F047,
                  EXTRACTVALUE (COLUMN_VALUE, 'DATA/F048') AS F048,
                  EXTRACTVALUE (COLUMN_VALUE, 'DATA/F050') AS F050,
                  EXTRACTVALUE (COLUMN_VALUE, 'DATA/F052') AS F052,
                  EXTRACTVALUE (COLUMN_VALUE, 'DATA/F054') AS F054,
                  EXTRACTVALUE (COLUMN_VALUE, 'DATA/F055') AS F055,
                  EXTRACTVALUE (COLUMN_VALUE, 'DATA/F070') AS F070,
                  EXTRACTVALUE (COLUMN_VALUE, 'DATA/Q001_1') AS Q001_1,
                  EXTRACTVALUE (COLUMN_VALUE, 'DATA/Q001_2') AS Q001_2,
                  EXTRACTVALUE (COLUMN_VALUE, 'DATA/Q001_3') AS Q001_3,
                  EXTRACTVALUE (COLUMN_VALUE, 'DATA/Q001_4') AS Q001_4,
                  EXTRACTVALUE (COLUMN_VALUE, 'DATA/Q003_1') AS Q003_1,
                  EXTRACTVALUE (COLUMN_VALUE, 'DATA/Q003_2') AS Q003_2,
                  EXTRACTVALUE (COLUMN_VALUE, 'DATA/Q003_3') AS Q003_3,
                  EXTRACTVALUE (COLUMN_VALUE, 'DATA/Q006') AS Q006,
                  EXTRACTVALUE (COLUMN_VALUE, 'DATA/Q007_1') AS Q007_1,
                  EXTRACTVALUE (COLUMN_VALUE, 'DATA/Q007_2') AS Q007_2,
                  EXTRACTVALUE (COLUMN_VALUE, 'DATA/Q007_3') AS Q007_3,
                  EXTRACTVALUE (COLUMN_VALUE, 'DATA/Q007_4') AS Q007_4,
                  EXTRACTVALUE (COLUMN_VALUE, 'DATA/Q007_5') AS Q007_5,
                  EXTRACTVALUE (COLUMN_VALUE, 'DATA/Q007_6') AS Q007_6,
                  EXTRACTVALUE (COLUMN_VALUE, 'DATA/Q007_7') AS Q007_7,
                  EXTRACTVALUE (COLUMN_VALUE, 'DATA/Q007_8') AS Q007_8,
                  EXTRACTVALUE (COLUMN_VALUE, 'DATA/Q007_9') AS Q007_9,
                  EXTRACTVALUE (COLUMN_VALUE, 'DATA/Q009') AS Q009,
                  EXTRACTVALUE (COLUMN_VALUE, 'DATA/Q010_1') AS Q010_1,
                  EXTRACTVALUE (COLUMN_VALUE, 'DATA/Q010_2') AS Q010_2,
                  EXTRACTVALUE (COLUMN_VALUE, 'DATA/Q010_3') AS Q010_3,
                  EXTRACTVALUE (COLUMN_VALUE, 'DATA/Q011_1') AS Q011_1,
                  EXTRACTVALUE (COLUMN_VALUE, 'DATA/Q011_2') AS Q011_2,
                  EXTRACTVALUE (COLUMN_VALUE, 'DATA/Q012_1') AS Q012_1,
                  EXTRACTVALUE (COLUMN_VALUE, 'DATA/Q012_2') AS Q012_2,
                  EXTRACTVALUE (COLUMN_VALUE, 'DATA/Q013') AS Q013,
                  EXTRACTVALUE (COLUMN_VALUE, 'DATA/Q021') AS Q021,
                  EXTRACTVALUE (COLUMN_VALUE, 'DATA/T071') AS T071
             FROM NBUR_REF_FILES f,
                  NBUR_LST_FILES v,
                  TABLE (
                     XMLSEQUENCE (
                        XMLType (v.FILE_BODY).EXTRACT ('/NBUSTATREPORT/DATA'))) t
            WHERE     f.ID = v.FILE_ID
                  AND f.FILE_CODE = '#3P'
                  AND f.FILE_FMT = 'XML'
                  AND v.FILE_STATUS IN ('FINISHED', 'BLOCKED')) t;

COMMENT ON TABLE BARS.V_NBUR_3PX IS '3PX Дані про окремий зовнішній державний борг та приватний борг, що гарантований державою';
COMMENT ON COLUMN BARS.V_NBUR_3PX.REPORT_DATE IS 'Звiтна дата';
COMMENT ON COLUMN BARS.V_NBUR_3PX.KF IS 'Фiлiя';
COMMENT ON COLUMN BARS.V_NBUR_3PX.VERSION_ID IS 'Номер версії файлу';
COMMENT ON COLUMN BARS.V_NBUR_3PX.NBUC IS 'Код областi розрiзу юридичної особи';
COMMENT ON COLUMN BARS.V_NBUR_3PX.FIELD_CODE IS 'Код показника';
COMMENT ON COLUMN BARS.V_NBUR_3PX.EKP IS 'Код показника';
COMMENT ON COLUMN BARS.V_NBUR_3PX.KU IS 'Територія';
COMMENT ON COLUMN BARS.V_NBUR_3PX.K020 IS 'Код позичальника';
COMMENT ON COLUMN BARS.V_NBUR_3PX.R030_1 IS 'Валюта (кредиту)';
COMMENT ON COLUMN BARS.V_NBUR_3PX.R030_2 IS 'Валюта (розрахунку)';
COMMENT ON COLUMN BARS.V_NBUR_3PX.K040 IS 'Код країни';
COMMENT ON COLUMN BARS.V_NBUR_3PX.S050 IS 'Код типу строковості';
COMMENT ON COLUMN BARS.V_NBUR_3PX.S184 IS 'Початковий строк погашення';
COMMENT ON COLUMN BARS.V_NBUR_3PX.F009 IS 'Код  типу джерела фінансування';
COMMENT ON COLUMN BARS.V_NBUR_3PX.F010 IS 'Код типу угоди';
COMMENT ON COLUMN BARS.V_NBUR_3PX.F011 IS 'Код графіка погашення платежів';
COMMENT ON COLUMN BARS.V_NBUR_3PX.F012 IS 'Код типу форми власності';
COMMENT ON COLUMN BARS.V_NBUR_3PX.F014 IS 'Код виду подання звіту';
COMMENT ON COLUMN BARS.V_NBUR_3PX.F028 IS 'Вид заборгованості';
COMMENT ON COLUMN BARS.V_NBUR_3PX.F036 IS 'Код використання процентної ставки';
COMMENT ON COLUMN BARS.V_NBUR_3PX.F045 IS 'Ознака кредита';
COMMENT ON COLUMN BARS.V_NBUR_3PX.F047 IS 'Код виду позичальника';
COMMENT ON COLUMN BARS.V_NBUR_3PX.F048 IS 'Тип відсоткової ставки за кредитом';
COMMENT ON COLUMN BARS.V_NBUR_3PX.F050 IS 'Цілі використання кредиту';
COMMENT ON COLUMN BARS.V_NBUR_3PX.F052 IS 'Тип кредитора';
COMMENT ON COLUMN BARS.V_NBUR_3PX.F054 IS 'Періодичність здійснення платежів';
COMMENT ON COLUMN BARS.V_NBUR_3PX.F055 IS 'Код типу кредиту';
COMMENT ON COLUMN BARS.V_NBUR_3PX.F070 IS 'Код типу реорганізації';
COMMENT ON COLUMN BARS.V_NBUR_3PX.Q001_1 IS 'назва позичальника/клієнта банку';
COMMENT ON COLUMN BARS.V_NBUR_3PX.Q001_2 IS 'назва організації, установи, що гарантує обслуговування зобов’язання з боку позичальника';
COMMENT ON COLUMN BARS.V_NBUR_3PX.Q001_3 IS 'назва кредитора';
COMMENT ON COLUMN BARS.V_NBUR_3PX.Q001_4 IS 'назва організації, установи, що виступає гарантом обслуговування зобов’язання з боку кредитора';
COMMENT ON COLUMN BARS.V_NBUR_3PX.Q003_1 IS 'номер  договору';
COMMENT ON COLUMN BARS.V_NBUR_3PX.Q003_2 IS 'номер реєстраційного свідоцтва, видане НБУ';
COMMENT ON COLUMN BARS.V_NBUR_3PX.Q003_3 IS 'порядковий номер траншу (операції з одержання кредиту в межах кредитної лінії)';
COMMENT ON COLUMN BARS.V_NBUR_3PX.Q006 IS 'примітка з додатковими роз’ясненнями у разі потреби';
COMMENT ON COLUMN BARS.V_NBUR_3PX.Q007_1 IS 'дата першого амортизаційного платежу';
COMMENT ON COLUMN BARS.V_NBUR_3PX.Q007_2 IS 'дата останнього амортизаційного платежу';
COMMENT ON COLUMN BARS.V_NBUR_3PX.Q007_3 IS 'початкова дата періоду консолідації';
COMMENT ON COLUMN BARS.V_NBUR_3PX.Q007_4 IS 'кінцева дата періоду консолідації';
COMMENT ON COLUMN BARS.V_NBUR_3PX.Q007_5 IS 'дата укладання угоди про надання кредиту';
COMMENT ON COLUMN BARS.V_NBUR_3PX.Q007_6 IS 'дата першого платежу за процентами';
COMMENT ON COLUMN BARS.V_NBUR_3PX.Q007_7 IS 'дата останнього платежу за процентами';
COMMENT ON COLUMN BARS.V_NBUR_3PX.Q007_8 IS 'дата, починаючи з якої проценти сплачуються за другою процентною ставкою або використовується друге значення маржі';
COMMENT ON COLUMN BARS.V_NBUR_3PX.Q007_9 IS 'дата реєстрації договору в Національному банку';
COMMENT ON COLUMN BARS.V_NBUR_3PX.Q009 IS 'мета позики';
COMMENT ON COLUMN BARS.V_NBUR_3PX.Q010_1 IS 'період часу (у місяцях) між одержанням кожної частини кредиту та першим амортизаційним платежем';
COMMENT ON COLUMN BARS.V_NBUR_3PX.Q010_2 IS 'період по місяцях, на які надається прогноз платежів за заборгованістю перед нерезидентами';
COMMENT ON COLUMN BARS.V_NBUR_3PX.Q010_3 IS 'період по роках, на які надається прогноз платежів за заборгованістю перед нерезидентами';
COMMENT ON COLUMN BARS.V_NBUR_3PX.Q011_1 IS 'кількість амортизаційних платежів за кожним надходженням за борговим зобов’язанням за рік';
COMMENT ON COLUMN BARS.V_NBUR_3PX.Q011_2 IS 'кількість платежів за рік (за основною сумою та відсотками залежно від типу платежу за класифікатором-параметром)';
COMMENT ON COLUMN BARS.V_NBUR_3PX.Q012_1 IS 'база 1 для обчислення плаваючої процентної ставки за кредитом';
COMMENT ON COLUMN BARS.V_NBUR_3PX.Q012_2 IS 'база 2 для обчислення плаваючої процентної ставки за кредитом';
COMMENT ON COLUMN BARS.V_NBUR_3PX.Q013 IS 'розмір маржі процентної ставки за кредитом';
COMMENT ON COLUMN BARS.V_NBUR_3PX.Q021 IS 'сума угоди за договором з нерезидентом';
COMMENT ON COLUMN BARS.V_NBUR_3PX.T071 IS 'сума';


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_nbur_3px.sql ========== *** End *** =
PROMPT ===================================================================================== 

