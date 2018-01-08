

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_UI_BROWSER_STAT.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_UI_BROWSER_STAT ***

  CREATE OR REPLACE FORCE VIEW BARS.V_UI_BROWSER_STAT ("HOST", "BROWSER", "VERSION", "TYPE", "PLATFORM", "ID") AS 
  select
  --t.user_data,
  substr(user_data, instr(user_data, 'UserHostAddress'), instr(user_data, ';')) host,
  substr(user_data, instr(user_data, 'Browser'), instr(user_data, ';', 1, 2) - instr(user_data, ';', 1, 1)) browser,
  substr(user_data, instr(user_data, 'Version'), instr(user_data, ';', 1, 3) - instr(user_data, ';', 1, 2)) version,
  substr(user_data, instr(user_data, 'Type'), instr(user_data, ';', 1, 4) - instr(user_data, ';', 1, 3)) type,
  substr(user_data, instr(user_data, 'Platform'), instr(user_data, ';', 1, 5) - instr(user_data, ';', 1, 4)) platform,
  substr(user_data, instr(user_data, 'Id'), instr(user_data, ';', 1, 6) - instr(user_data, ';', 1, 5)) id
from ui_func_stats t
where t.user_data is not null;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_UI_BROWSER_STAT.sql =========*** End 
PROMPT ===================================================================================== 
