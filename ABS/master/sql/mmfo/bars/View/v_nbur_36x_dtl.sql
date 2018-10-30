PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_nbur_36X_dtl.sql =========*** Run *** =
PROMPT ===================================================================================== 

PROMPT *** Create  view v_nbur_36X_dtl ***

create or replace view v_nbur_36X_dtl as
select p.REPORT_DATE
     , p.KF
     , p.VERSION_ID
     , p.NBUC
     , p.EKP
     , p.KU
     , p.B040
     , p.F021
     , p.K020
     , p.K021
     , p.Q001_1
     , p.Q001_2
     , p.Q002
     , p.Q003_2
     , p.Q003_3
     , p.Q007_1
     , p.Q007_2
     , p.Q007_3
     , p.Q007_4
     , p.Q007_5
     , p.K040
     , p.D070
     , p.F008
     , p.K112
     , p.F019
     , p.F020
     , p.R030
     , p.Q023
     , p.Q006
     , p.T070
     , p.T071
     , p.ACC_ID
     , p.ACC_NUM
     , p.KV
     , p.CUST_ID
     , c.OKPO CUST_CODE
     , c.NMK  CUST_NAME
     , p.BRANCH
  from NBUR_LOG_F36X p
       join NBUR_REF_FILES f on (f.FILE_CODE = '#36')
       join NBUR_LST_FILES v on (v.REPORT_DATE = p.REPORT_DATE)
                                and (v.KF = p.KF)
                                and (v.VERSION_ID = p.VERSION_ID)
                                and (v.FILE_ID = f.ID )
       LEFT JOIN CUSTOMER c on (p.KF = c.KF)
                               and (p.CUST_ID = c.RNK )
 where v.FILE_STATUS IN ( 'FINISHED', 'BLOCKED' );
   
comment on table V_NBUR_36X_DTL              is 'Детальний протокол файлу 36X';
comment on column V_NBUR_36X_DTL.REPORT_DATE is 'Звітна дата';
comment on column V_NBUR_36X_DTL.KF          is 'Код фiлiалу (МФО)';
comment on column V_NBUR_36X_DTL.KU          is 'Код регіону';
comment on column V_NBUR_36X_DTL.VERSION_ID  is 'Ід. версії файлу';
comment on column V_NBUR_36X_DTL.NBUC        is 'Код розрізу даних у звітному файлі';
comment on column V_NBUR_36X_DTL.EKP         is 'Код показника';
comment on column V_NBUR_36X_DTL.B040        is 'Код стуктурного підрозділу';
comment on column V_NBUR_36X_DTL.F021        is 'Код повідомлення про взяття на контроль/зняття з контролю';        
comment on column V_NBUR_36X_DTL.K020        is 'Код резидента';        
comment on column V_NBUR_36X_DTL.K021        is 'Ознака коду';        
comment on column V_NBUR_36X_DTL.Q001_1      is 'Повне найменування резидента';        
comment on column V_NBUR_36X_DTL.Q001_2      is 'Повне найменування нерезидента (згідно з контрактом)';        
comment on column V_NBUR_36X_DTL.Q002        is 'Місцезнаходження резидента';        
comment on column V_NBUR_36X_DTL.Q003_2      is 'Умовний порядковий номер контракта';        
comment on column V_NBUR_36X_DTL.Q003_3      is 'Номер зовнішньоекономічного контракту';        
comment on column V_NBUR_36X_DTL.Q007_1      is 'Дата укладення зовнішньоекономічного контракту';        
comment on column V_NBUR_36X_DTL.Q007_2      is 'Дата першого дня перевищення строку розрахунків';        
comment on column V_NBUR_36X_DTL.Q007_3      is 'Дата внесення змін до інформації';        
comment on column V_NBUR_36X_DTL.Q007_4      is 'Дата зняття резидента з контролю';        
comment on column V_NBUR_36X_DTL.Q007_5      is 'Дата відвантаження продукції відповідно до митних декларацій або дата виконання відповідного платіжного доручення';        
comment on column V_NBUR_36X_DTL.K040        is 'Код країни нерезидента';        
comment on column V_NBUR_36X_DTL.D070        is 'Код зовнішньоекономічної операції клієнта';        
comment on column V_NBUR_36X_DTL.F008        is 'Код  змісту зовнішньоекономічної операції клієнта';        
comment on column V_NBUR_36X_DTL.K112        is 'Код секції виду економічної діяльності';        
comment on column V_NBUR_36X_DTL.F019        is 'Код причини виникнення заборгованості';        
comment on column V_NBUR_36X_DTL.F020        is 'Код відмітки про безнадійну заборгованість резидентів за зовнішньоекономічним контрактом';        
comment on column V_NBUR_36X_DTL.R030        is 'Код валюти розрахунку';        
comment on column V_NBUR_36X_DTL.Q023        is 'Код підрозділу банку, який ліквідовано';        
comment on column V_NBUR_36X_DTL.T071        is 'Сума неповернених коштів у валюті';        
comment on column V_NBUR_36X_DTL.T070        is 'Сума неповернених коштів у гривневому еквіваленті';        
comment on column V_NBUR_36X_DTL.Q006        is 'Примітка';  
comment on column V_NBUR_36X_DTL.ACC_ID      is 'Ід. рахунка';
comment on column V_NBUR_36X_DTL.ACC_NUM     is 'Номер рахунка';
comment on column V_NBUR_36X_DTL.KV          is 'Ід. валюти';
comment on column V_NBUR_36X_DTL.CUST_ID     is 'Ід. клієнта';
comment on column V_NBUR_36X_DTL.CUST_CODE   is 'Код клієнта';
comment on column V_NBUR_36X_DTL.CUST_NAME   is 'Назва клієнта';
comment on column V_NBUR_36X_DTL.BRANCH      is 'Код підрозділу';

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_nbur_36X_dtl.sql =========*** End *** =
PROMPT ===================================================================================== 