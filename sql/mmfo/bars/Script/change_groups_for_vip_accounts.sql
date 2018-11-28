set serveroutput on size 100000

declare 
  l_new_group_list varchar2(100);
begin 
     bc.go('300465');
    for c in (
            select a.acc, c.rnk,c.okpo,a.nls, (select listagg(column_value,',')  within group (order by column_value) from table(sec.getagrp(a.acc) )   ) group_list,   
                   a.kv,c.nmk ,c.branch customer_branch, a.branch accounts_branch
            from customer c, accounts a
            where a.rnk = c.rnk 
                  and a.kf = '300465'
                  and c.kf = '300465'
                  and (a.nbs in ('2625', '2630') or (a.nls like '2620%' and a.tip like 'W4%'))
             and c.rnk in 
            (50029201,
            90382301,
            90111101,
            90273401,
            90681201,
            50100001,
            50089801,
            50056001,
            94498301,
            50106201,
            93532101,
            94654501,
            91531101,
            97561601,
            97301601,
            94470701,
            92025101,
            50074201,
            94764001,
            95018901,
            50055101,
            90552501,
            93972201,
            90767701,
            93322301,
            93707301,
            90501001,
            40207301,
            95332201,
            90644301,
            94367901,
            94452801,
            50067301,
            90797101,
            50030001,
            93532801,
            90337601,
            90553601,
            90552601,
            90553401,
            50020301,
            96082401,
            50028501,
            90756501,
            96396201,
            90553701,
            94244801,
            94727401,
            90044201,
            50031401,
            90591101,
            90339701,
            93530601,
            93694301,
            90619201,
            94482601,
            50025301,
            90120601,
            90479101,
            93562201,
            95824301,
            90571801,
            95317201,
            90605801,
            50040401,
            94368201,
            93605301,
            93712401,
            96107801,
            90521001,
            97625701,
            97197701,
            97025601,
            96699901,
            96907601,
            95597601,
            95463301,
            95323201,
            93710401,
            90619701,
            90258501,
            95676601,
            93890201,
            50087201,
            90553801,
            90298701,
            50026701,
            50074001,
            90324601,
            95204901,
            93601501,
            50052401,
            90234501,
            93632201,
            94475901,
            94104201,
            90554701,
            90096201,
            90426301,
            90644401,
            93376301,
            50049301,
            50017001,
            94849201,
            90564401,
            90019701,
            50041201,
            50021301,
            50269501,
            50060301,
            93794901,
            50018301,
            50038901,
            50029801,
            94214201)
            ) loop
            
            null;
            
            if instr(c.group_list, '6')  > 0 then sec.delagrp (c.acc, 6); end if;
            if instr(c.group_list, '10') > 0  then sec.delagrp (c.acc, 10); end if;
            if instr(c.group_list, '11') > 0 then sec.delagrp (c.acc, 11); end if;
            if instr(c.group_list, '44') > 0 then sec.delagrp (c.acc, 44); end if;
            if instr(c.group_list, '17') = 0 then sec.addagrp (c.acc, 17); end if;
                        
            select listagg(column_value,',')  within group (order by column_value) into l_new_group_list  from table(sec.getagrp(c.acc) );  
            
            bars_audit.info('change VIP accounts  group for acc = '||c.acc||', nls='||c.nls||' from '||c.group_list||' to '||l_new_group_list);
            --dbms_output.put_line('change VIP accounts  group for acc = '||c.acc||', nls='||c.nls||' from '||c.group_list||' to '||l_new_group_list);
                         
            end loop;

            bc.go('/');

end;
/

commit;