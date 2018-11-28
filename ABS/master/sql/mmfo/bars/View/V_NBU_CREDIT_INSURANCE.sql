create or replace view v_nbu_credit_insurance as
select "KF","NUMB","BRANCH","NMK","OKPO","TYPEZP","ZALLAST","ZABDAY","RATE","SUM","TAR","STRSUM","RANGE","NLS","KV","RNK","ND","PID",
case STATE when 0 then 'завантажено' when 1 then 'оброблено успішно' when 2 then 'оброблено з помилкою' end "STATE",
"MESSAGE" 
from NBU_CREDIT_INSURANCE;
comment on table V_NBU_CREDIT_INSURANCE is 'Реєстр добровільного страхування кредитів БПК';
comment on column V_NBU_CREDIT_INSURANCE.KF is 'РУ';
comment on column V_NBU_CREDIT_INSURANCE.NUMB is '№з/п';
comment on column V_NBU_CREDIT_INSURANCE.BRANCH is 'Обласне управління, ТВБВ';
comment on column V_NBU_CREDIT_INSURANCE.NMK is 'ПІБ клієнта';
comment on column V_NBU_CREDIT_INSURANCE.OKPO is 'ІПН клієнта';
comment on column V_NBU_CREDIT_INSURANCE.TYPEZP is 'Вид продукту (зарплатні, військові, соціальні)';
comment on column V_NBU_CREDIT_INSURANCE.ZALLAST is 'Залишок за останній день періода в грн. екв.';
comment on column V_NBU_CREDIT_INSURANCE.ZABDAY is 'Середньоденна кредитна заборгованість за Звітний місяць, грн.';
comment on column V_NBU_CREDIT_INSURANCE.RATE is 'Річна процентна ставка,%';
comment on column V_NBU_CREDIT_INSURANCE.SUM is 'Страхова сума, грн.';
comment on column V_NBU_CREDIT_INSURANCE.TAR is 'Щомісячний страховий тариф, %';
comment on column V_NBU_CREDIT_INSURANCE.STRSUM is 'Страховий платіж за Звітний місяць, грн.          (к.7 х к.8)';
comment on column V_NBU_CREDIT_INSURANCE.RANGE is 'В діапазоні
930,75-6167';
comment on column V_NBU_CREDIT_INSURANCE.NLS is 'Поточний рахунок клієнта на який встановлено КЛ';
comment on column V_NBU_CREDIT_INSURANCE.KV is 'Валюта рахунку';
comment on column V_NBU_CREDIT_INSURANCE.RNK is 'РНК ';
comment on column V_NBU_CREDIT_INSURANCE.ND is 'Референс договору';
comment on column V_NBU_CREDIT_INSURANCE.PID is 'ID родительской записи';
comment on column V_NBU_CREDIT_INSURANCE.STATE is 'статутс: 0-завантажено, 1 - оброблено успішно, 2 - оброблено з помилкою';
comment on column V_NBU_CREDIT_INSURANCE.MESSAGE is 'Помилка';

grant SELECT on v_nbu_credit_insurance to BARS_ACCESS_DEFROLE;
