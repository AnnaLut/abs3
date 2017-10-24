

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/PKBDN.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  procedure PKBDN ***

  CREATE OR REPLACE PROCEDURE BARS.PKBDN (id1_ IN NUMBER, id2_ IN NUMBER) IS
  ern  CONSTANT POSITIVE := 7772;  -- Cannot obtain PKBdn
begin

--возврат полномочий по  Ѕ (от id1_ на id2_)

  update klpacc
  set    neom=id2_
  where  neom=id1_ and
         acc in (select acc
                 from   accounts
                 where  isp=id2_);

  update klp
  set    eom=id2_
  where  eom=id1_ and
         fl<3     and
         (nls,kv) in (select nls,kv
                      from   accounts
                      where  isp=id2_);

--документы на визе

  begin
    for k in (select ref
              from   oper
              where  userid=id1_               and
                     tt in ('KL1','KL2','KLI') and
                     sos between 1 and 4       and
                     pdat>=gl.bd-30)
    loop
      update oper
      set    userid=id2_
      where  ref=k.ref;
      bars_audit.info('PKBdn: передача документа REF='||k.ref||
                      ' от пользовател€ '||id1_||' на пользовател€ '||id2_);
    end loop;
  end;

--delete
--from   klpvacc
--where  neom=id1_ and
--       acc in (select acc
--               from   accounts
--               where  isp=id2_);
--update klpv
--set    neom=id2_
--where  neom=id1_ and
--       fl<3      and
--       (nls,kv) in (select nls,kv
--                    from   accounts
--                    where  isp=id2_);
EXCEPTION WHEN OTHERS THEN
  raise_application_error(-(20000+ern),SQLERRM,TRUE);
end PKBdn;
/
show err;

PROMPT *** Create  grants  PKBDN ***
grant EXECUTE                                                                on PKBDN           to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on PKBDN           to TECH_MOM1;
grant EXECUTE                                                                on PKBDN           to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/PKBDN.sql =========*** End *** ===
PROMPT ===================================================================================== 
