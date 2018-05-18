UPDATE vidd_tip set force_open = 0  where vidd in (2,3) and tip <> 'CR9';

commit;