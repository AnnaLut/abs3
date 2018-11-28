begin
update META_NSIFUNCTION t
set t.custom_options = ' [{  "Value":"KF" , "Name":"МФО" }, 
                        {  "Value":"NUMB" , "Name":"№з/п" }, 
                        {  "Value":"BRANCH" , "Name":"Обласне управління, ТВБВ" }, 
                        {  "Value":"NMK" , "Name":"ПІБ клієнта" }, 
                        {  "Value":"OKPO" , "Name":"ІПН клієнта" }, 
                        {  "Value":"TYPEZP" , "Name":"Вид продукту (зарплатні, військові, соціальні)" }, 
                        {  "Value":"ZALLAST" , "Name":"Залишок за останній день періода в грн. екв." }, 
                        {  "Value":"ZABDAY" , "Name":"Середньоденна кредитна заборгованість за Звітний місяць, грн." }, 
                        {  "Value":"RATE" , "Name":"Річна процентна ставка,%" }, 
                        {  "Value":"SUM" , "Name":"Страхова сума, грн." }, 
                        {  "Value":"TAR" , "Name":"Щомісячний страховий тариф, %" }, 
                        {  "Value":"STRSUM" , "Name":"Страховий платіж за Звітний місяць, грн.          (к.7 х к.8)" }, 
                        {  "Value":"RANGE" , "Name":"В діапазоні 930,75-6167" }, 
                        {  "Value":"NLS" , "Name":"Поточний рахунок клієнта на який встановлено КЛ" }, 
                        {  "Value":"KV" , "Name":"Валюта рахунку" }, 
                        {  "Value":"RNK" , "Name":"РНК" }, 
                        {  "Value":"ND" , "Name":"Референс договору" }, 
                        {  "Value":"NLS" , "Name":"Поточний рахунок клієнта на який встановлено КЛ" }, 
                        {  "Value":"NLS" , "Name":"Поточний рахунок клієнта на який встановлено КЛ" }
]
'
where proc_name like 'BARS.P_NBU_CREDIT_INS(:p_file_name,:p_ddate,:p_clob,:p_message)';
end;
/
commit;
/
