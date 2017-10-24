

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/PKBUP.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  procedure PKBUP ***

  CREATE OR REPLACE PROCEDURE BARS.PKBUP (id1_ IN NUMBER, id2_ IN NUMBER) IS
  ern   CONSTANT POSITIVE := 7771;  -- Cannot obtain PKBup
  fl_   number;
  dto_  date;
  dti_  date;
begin

--передача полномочий по  Ѕ

  begin
    select 1
    into   fl_
    from   klp_plpo
    where  tow=id1_                     and
           dti<sysdate                  and
           (dto>sysdate or dto is null) and
           mrk=1;
  exception when no_data_found then
    fl_ := 0;
            when too_many_rows then
    fl_ := 1;
  end;

  if fl_=1 then

    update klpacc
    set    neom=id2_
    where  neom=id1_;

    update klp
    set    eom=id2_
    where  eom=id1_ and
           fl<3;

    select dti,
           dto
    into   dti_,
           dto_
    from   klp_plpo
    where  otw=id1_ and
           tow=id2_ and
           mrk=0    and
           rownum<2;

    update klp_plpo
    set    tow=id2_,
           dti=dti_,
           dto=dto_
    where  tow=id1_                     and
           otw<>id2_                    and
           dti<sysdate                  and
           (dto>sysdate or dto is null) and
           mrk=1;

    delete
    from   klp_plpo
    where  otw=id2_ and
           tow=id1_ and
           mrk=1;

  else -- fl_=0

    insert
    into   klpacc (acc,
                   neom)
            select acc,
                   id2_
            from   accounts
            where  isp=id1_ and
                   acc not in (select acc
                               from   klpacc);

    update klpacc
    set    neom=id2_
    where  neom=id1_;

    update klp
    set    eom=id2_
    where  eom=id1_ and
           fl<3;

--  insert
--  into   klpvacc
--  select acc ,
--         id2_,
--         kf
--  from   accounts
--  where  isp=id1_ and
--         kv<>980  and
--         acc not in (select acc
--                     from   klpvacc);
--  update klpv
--  set    neom=id2_
--  where  neom=id1_ and
--         fl<3;
  end if;

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
      bars_audit.info('PKBup: передача документа REF='||k.ref||
                      ' от пользовател€ '||id1_||' на пользовател€ '||id2_);
    end loop;
  end;

EXCEPTION WHEN OTHERS THEN
  raise_application_error(-(20000+ern),SQLERRM,TRUE);
end PKBup;
/
show err;

PROMPT *** Create  grants  PKBUP ***
grant EXECUTE                                                                on PKBUP           to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on PKBUP           to TECH_MOM1;
grant EXECUTE                                                                on PKBUP           to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/PKBUP.sql =========*** End *** ===
PROMPT ===================================================================================== 
