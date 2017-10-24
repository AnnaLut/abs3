

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/PKBPP.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  procedure PKBPP ***

  CREATE OR REPLACE PROCEDURE BARS.PKBPP IS
begin
  tokf;
  for k in (select otw,tow,dti,dto,mrk
            from   klp_plpo
            where  mrk<2)
  loop

    if k.mrk=0 and k.dti<=sysdate then -- надо передать полномочия
      begin
        PKBup(k.otw,k.tow);
        update klp_plpo
        set    mrk=1
        where  otw=k.otw and tow=k.tow;
        commit;
        bars_audit.info('PKBup: переданы полномочия по КЛИЕНТ-БАНК от пользователя '||k.otw||
                        ' пользователю '||k.tow);
      exception when no_data_found then
        bars_audit.error('PKBup error: '||sqlerrm);
      end;
    end if;

    if k.mrk=1 and k.dto<=sysdate then -- надо возвратить полномочия
      begin
        PKBdn(k.tow,k.otw);
        delete from klp_plpo
        where  otw=k.otw and tow=k.tow;
        commit;
        bars_audit.info('PKBdn: возвращены полномочия по КЛИЕНТ-БАНК от пользователя '||k.tow||
                        ' пользователю '||k.otw);
      exception when no_data_found then
        bars_audit.error('PKBdn error: '||sqlerrm);
      end;
    end if;

--  рихтовка плохих EOM

    begin
      for k in (select k.id,
                       p.tow
                from   klp      k,
                       klp_plpo p
                where  k.fl=0      and
                       k.eom=p.otw and
                       p.mrk=1     and
                       (p.dto is null or p.dto>sysdate))
      loop
        update klp
        set    eom=k.tow
        where  id=k.id;
      end loop;
      commit;
    end;

  end loop;
  toroot;
end PKBpp;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/PKBPP.sql =========*** End *** ===
PROMPT ===================================================================================== 
