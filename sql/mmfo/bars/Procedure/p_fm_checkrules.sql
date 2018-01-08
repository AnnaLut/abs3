
PROMPT *** Create  procedure P_FM_CHECKRULES ***

create or replace procedure p_fm_checkrules (p_dat1 date, p_dat2 date, p_rules varchar2)
is
  i number;
  l_rules varchar2(254);
  type t_temp is table of tmp_fm_checkrules%rowtype;
  l_temp t_temp;
begin
  begin
      select * bulk collect into l_temp from tmp_fm_checkrules where id = user_id for update nowait;
  exception
      when others then
          if sqlcode = -54 then
              raise_application_error(-20000, 'Запит від цього користувача вже виконується; спробуйте через деякий час');
          end if;
  end;
  delete from tmp_fm_checkrules where id = user_id;

  for z in ( select ref, vdat
               from oper
              where vdat between p_dat1 and p_dat2
                and ( kv  = 980 and s >= 10000000
                   or kv <> 980 and gl.p_icurval (nvl(kv, 980), nvl(s, 0), vdat) >= 10000000 )
           )
  loop

     l_rules := null;

     for k in ( select * from fm_rules where ',' || p_rules || ',' like '%,' || id || ',%')
     loop
        begin
           execute immediate 'select unique ref from ' || k.v_name || ' where ref = :ref and vdat = :vdat'
           into i using z.ref, z.vdat;
           l_rules := l_rules || ', ' || k.id;
        exception when no_data_found then null;
--        when others then
--        bars_audit.info(h || 'REF=>' || z.ref || ' rule=>' || k.id || ' vdat=>' || to_char(z.vdat,'dd.mm.yyyy') || ' Error: ' || SqlErrm);
--        raise;
        end;
     end loop;

     if l_rules is not null then
        insert into tmp_fm_checkrules(id, ref, rules) values (user_id, z.ref, substr(l_rules,3));
     end if;

  end loop;

end;
/
show err;

PROMPT *** Create  grants  P_FM_CHECKRULES ***
grant EXECUTE                                                                on P_FM_CHECKRULES to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_FM_CHECKRULES to FINMON01;
grant EXECUTE                                                                on P_FM_CHECKRULES to START1;
