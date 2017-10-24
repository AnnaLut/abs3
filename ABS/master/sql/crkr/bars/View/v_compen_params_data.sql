CREATE OR REPLACE FORCE VIEW BARS.V_COMPEN_PARAMS_DATA (ID, PAR, VAL, DISCRIPTION, TYPE, TYPE_DISCR, KF, BRANCH, DATE_FROM, DATE_TO, ENABLE_DATES, IS_ENABLE, BD) AS 
  select d.id,
  c.par, 
  d.val,
  c.discription,
  c.type,
  case when c.type = 1 then 'Для всіх'
         when c.type = 2 then d.kf
         when c.type = 3 then d.branch end type_discr,
  d.kf,
  d.branch,
  d.date_from,
  d.date_to,
  'З '||to_char(d.date_from,'dd.mm.yyyy')||' по '||to_char(d.date_to,'dd.mm.yyyy') enable_dates,
  d.is_enable,
  gl.bd
from bars.compen_params c,
  compen_params_data d
where c.par = d.par;
  GRANT SELECT ON BARS.V_COMPEN_PARAMS_DATA TO BARS_ACCESS_DEFROLE;