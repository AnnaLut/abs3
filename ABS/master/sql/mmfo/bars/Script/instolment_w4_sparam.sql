begin
for i in (select GRP_CODE, TIP, NBS, SP_ID, CASE WHEN SP_ID = 56 THEN '90' 
                                       WHEN NBS = 9129 AND SP_ID = 2 THEN '9' ELSE VALUE END AS VALUE, 

'I'||SUBSTR(tipad, 2) AS tipad
from W4_SPARAM where tipad in ('KSS', 'KSP', 'KKN', 'KPN', 'KK0', 'KK9', 'KR9')) loop

begin
insert into W4_SPARAM values i;
exception when dup_val_on_index then
null;
end;
end loop;
end;
/
commit;
/