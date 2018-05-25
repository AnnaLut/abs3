CREATE OR REPLACE procedure BARS.p_populate_risk_s580 is
    sel_r020 varchar2(2000);
    sel_r011 varchar2(200);
    sel_r013 varchar2(200);    
    sel_t020 varchar2(200);
    sel_s245 varchar2(200);
    sel_s181 varchar2(200);
    sel_t097 varchar2(200);
    sel_s580 varchar2(200);
    l_pos number;
    l_r020_1 number;
    l_r020_2 number;
    sel_ALL varchar2(20000);
    sel_col varchar2(20000);
    error_txt varchar2(2000);
begin
    execute immediate 'truncate table tmp_txt';
    
    delete from NBUR_REF_RISK_S580;
    
    for k in (select trim(prm2) prm2, trim(prm4) prm4 
              from tmp_ekp_2_01 
              where trim(ek_pok) in ('460', '461', '462', '463', '465', '469') and
                    data_c is null
              order by prm2, prm4) 
    loop
        sel_r020 := rtrim(substr(k.prm2, 6), ')')||',';
        
        -- T020        
        l_pos := instr(k.prm4, 'T020');
        
        sel_t020 := substr(k.prm4, l_pos + 5);
        
        sel_t020 := nvl(trim(substr(sel_t020, 1, instr(sel_t020, ')') - 1))||',','*,');
        
        -- R011        
        l_pos := instr(k.prm4, 'R011');
        
        if l_pos <> 0 then
            sel_r011 := substr(k.prm4, l_pos + 5);
            
            sel_r011 := nvl(trim(substr(sel_r011, 1, instr(sel_r011, ')') - 1))||',','*,');
        else 
            sel_r011 := '*,';
        end if;
 
        -- R013        
        l_pos := instr(k.prm4, 'R013');
        
        if l_pos <> 0 then
            sel_r013 := substr(k.prm4, l_pos + 5);
            
            sel_r013 := nvl(trim(substr(sel_r013, 1, instr(sel_r013, ')') - 1))||',','*,');
        else 
            sel_r013 := '*,';
        end if;     
          
        -- s245        
        l_pos := instr(k.prm4, 'S245');
        
        if l_pos <> 0 then
            sel_s245 := substr(k.prm4, l_pos + 5);
            
            sel_s245 := nvl(trim(substr(sel_s245, 1, instr(sel_s245, ')') - 1))||',','*,');
        ELSE
            sel_s245 := '*,';
        end if;
        
        -- S181        
        l_pos := instr(k.prm4, 'S181');
        
        if l_pos<>0 then
            sel_S181 := substr(k.prm4, l_pos + 5);
        
            sel_S181 := nvl(trim(substr(sel_S181, 1, instr(sel_S181, ')') - 1))||',', '*,');
        else
            sel_s181 := '*,';
        end if;

        -- T097        
        l_pos := instr(k.prm4, 'T097');
        
        if l_pos<>0 then
            sel_T097 := substr(k.prm4, l_pos + 5);
        
            sel_T097 := nvl(trim(substr(sel_T097, 1, instr(sel_T097, ')') - 1))||',','*,');
        else
            sel_T097 := '*,';
        end if;

        -- S580        
        l_pos := instr(k.prm4, 'S580');
        
        if l_pos<>0 then
            sel_S580 := substr(k.prm4, l_pos + 5);
        
            sel_S580 := nvl(trim(substr(sel_S580, 1, instr(sel_S580, ')') - 1))||',','*,');
        else
            sel_S580 := '*,';
        end if;

        for l in (select  *
                  from  xmltable('ora:tokenize($r020,",")'
                                 passing sel_r020  as "r020"
                                 columns r020 varchar2(2000) path '.'
                                )
                  where r020 is not null )
        loop
            if instr(l.r020, ':')>0 
            then
                l_pos := instr(l.r020, ':');
                l_r020_1 := substr(l.r020, 1, l_pos-1);
                l_r020_2 := substr(l.r020, l_pos+1);
            else
                l_r020_1 := l.r020;
                l_r020_2 := l.r020;
            end if;
            
            for r in l_r020_1..l_r020_2 
            loop
                if trim(sel_t020) is not null then
                   sel_ALL := 'xmltable(''ora:tokenize($t020,",")''
                               passing :str as "t020"
                               columns t020 varchar2(2000) path ''.'' ) a';
                               
                   sel_col := 't020';
                end if;

                if trim(sel_r011) is not null then
                   sel_ALL := sel_ALL ||(case when trim(sel_ALL) is not null then ',' else '' end) ||
                              'xmltable(''ora:tokenize($r011,",")''
                               passing :str as "r011"
                               columns r011 varchar2(2000) path ''.'' ) b1';
                               
                   sel_col := sel_col ||(case when trim(sel_ALL) is not null then ',' else '' end) ||'r011';
                end if;

                if trim(sel_r013) is not null then
                   sel_ALL := sel_ALL ||(case when trim(sel_ALL) is not null then ',' else '' end) ||
                              'xmltable(''ora:tokenize($r013,",")''
                               passing :str as "r013"
                               columns r013 varchar2(2000) path ''.'' ) b2';
                               
                   sel_col := sel_col ||(case when trim(sel_ALL) is not null then ',' else '' end) ||'r013';
                end if;
                
                if trim(sel_s245) is not null then
                   sel_ALL := sel_ALL ||(case when trim(sel_ALL) is not null then ',' else '' end) ||
                              'xmltable(''ora:tokenize($s245,",")''
                               passing :str as "s245"
                               columns s245 varchar2(2000) path ''.'' ) b3';
                               
                   sel_col := sel_col ||(case when trim(sel_ALL) is not null then ',' else '' end) ||'s245';
                end if;

                if trim(sel_s181) is not null then
                   sel_ALL := sel_ALL ||(case when trim(sel_ALL) is not null then ',' else '' end) ||
                              'xmltable(''ora:tokenize($s181,",")''
                               passing :str as "s181"
                               columns s181 varchar2(2000) path ''.'' ) b4';
                               
                   sel_col := sel_col ||(case when trim(sel_ALL) is not null then ',' else '' end) ||'s181';
                end if;

                if trim(sel_t097) is not null then
                   sel_ALL := sel_ALL ||(case when trim(sel_ALL) is not null then ',' else '' end) ||
                              'xmltable(''ora:tokenize($t097,",")''
                               passing :str as "t097"
                               columns t097 varchar2(2000) path ''.'' ) b5';
                               
                   sel_col := sel_col ||(case when trim(sel_ALL) is not null then ',' else '' end) ||'t097';
                end if;

                if trim(sel_s580) is not null then
                   sel_ALL := sel_ALL ||(case when trim(sel_ALL) is not null then ',' else '' end) ||
                              'xmltable(''ora:tokenize($s580,",")''
                               passing :str as "s580"
                               columns s580 varchar2(2000) path ''.'' ) b6';
                               
                   sel_col := sel_col ||(case when trim(sel_ALL) is not null then ',' else '' end) ||'s580';
                end if;
                
                sel_ALL := 'insert into NBUR_REF_RISK_S580 (r020,'||sel_col||', comm) '||
                    'select '||to_char(r)||','||sel_col||','''||k.prm2||' '||k.prm4||''' from '||sel_ALL||
                    ' where t020 is not null and r011 is not null and r013 is not null and '||
                    's245 is not null and s181 is not null and t097 is not null and s580 is not null ';
                 
                begin   
                execute immediate sel_ALL
                using sel_t020, sel_r011, sel_r013, sel_s245, sel_s181, sel_t097, sel_s580; 
                exception
                    when others then
                        error_txt := sqlerrm;
                        
                        insert into tmp_txt(txt) values(error_txt);
                        insert into tmp_txt(txt) values(sel_ALL);
                        insert into tmp_txt(txt) values(sel_t020);
                        insert into tmp_txt(txt) values(sel_r011);
                        insert into tmp_txt(txt) values(sel_s245);
                        insert into tmp_txt(txt) values(sel_s181);
                        insert into tmp_txt(txt) values(sel_t097);
                        insert into tmp_txt(txt) values(sel_s580);
                end;
                
                commit;
            end loop;

        end loop;
    end loop;
    
    commit;
end;
/