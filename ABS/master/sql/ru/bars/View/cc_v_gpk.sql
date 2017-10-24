CREATE OR REPLACE  VIEW CC_V_GPK AS
   SELECT 1 GPK, '1.Погашення тіла кредиту рівними сумами'  name from dual union all
   SELECT 2 GPK, '2.Погашення тіла кредиту в кінці терміну' name from dual union all
   SELECT 3 GPK, '3.Погашенння кредиту рівними долями з %% ( ануїтет )' name from dual ;
