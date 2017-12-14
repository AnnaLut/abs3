CREATE OR REPLACE TRIGGER TIUD_EDEAL
instead of insert or update or delete ON BARS.E_DEAL for each row
declare
  -- version 1.6  15/04-16
  l_acc26    accounts.acc%type;
  l_acc36    accounts.acc%type;
  l_accd     accounts.acc%type;
  l_accp     accounts.acc%type;
  l_nbs      accounts.nbs%type;
  l_ob22     accounts.nbs%type;
  l_ob22t    accounts.nbs%type;
  l_nls36    accounts.nls%type;

begin

  if inserting or updating
  then

    -- 26*
    if ( :new.nls26 is not null )
    then
      select acc
        into l_acc26
        from accounts
       where nls = :new.nls26
         and kv  = nvl(:new.kv26, gl.baseVal);
    else
      l_acc26 := null;
    end if;

    -- 36*
    if ( :new.nls36 is not null )
    then -- 3570 02 - нараховані доходи за обсл. Суб.Госп. через системи дистанційного обслуговування

      select acc, nbs, nvl(ob22,'XX'), nls, f_check_elt_ob22(0,nbs,ob22)
        into l_acc36, l_nbs, l_ob22, l_nls36, l_ob22t
        from accounts
       where nls = :new.nls36
         and kv  = nvl(:new.kv36, gl.baseVal);

      case
        when ( l_nbs <> '3570' )
        then raise_application_error( -20444, 'Недопустиме значення балансового рахунка! '||l_nbs, true );
        when ( l_ob22t in ('-5'))
        then raise_application_error( -20444, l_nls36||' Недопустиме значення параметра ОБ22! '||l_ob22, true );
        else null;
      end case;

    else
      l_acc36 := null;
    end if;

    -- nls_d
    if ( :new.nls_d is not null )
    then -- 3579 24 - прострочені нараховані доходи за обсл. Суб.Госп. через системи дистанційного обслуговування

      begin
      select acc, nbs, nvl(ob22,'YY'), nls, f_check_elt_ob22(0,nbs,ob22)
        into l_accd, l_nbs, l_ob22, l_nls36, l_ob22t
        from accounts
       where nls = :new.nls_d
         and kv  = nvl(:new.kvd, gl.baseVal);

      if newnbs.g_state= 1 then  --переход на новый план счетов
      case
        when ( l_nbs <> '3570' )
        then raise_application_error( -20444, 'Недопустиме значення балансового рахунка! '||l_nbs, true );
        when ( l_ob22t in ('-5'))
        then raise_application_error( -20444, l_nls36||' Недопустиме значення параметра ОБ22! '||l_ob22, true );
        else null;
      end case;
      else
      case
        when ( l_nbs <> '3579' )
        then raise_application_error( -20444, 'Недопустиме значення балансового рахунка! '||l_nbs, true );
        when ( l_ob22t in ('-5'))
        then raise_application_error( -20444, l_nls36||' Недопустиме значення параметра ОБ22! '||l_ob22, true );
        else null;
      end case;        
      end if;

      exception
        when no_data_found then NULL;
          logger.error( 'E_DEAL вказаний рах-к Не знайдено для ND '||:old.nd||', nlsd='||:new.nls_d );
          raise_application_error( -20444, ' E_DEAL вказаний рах-к Не знайдено для ND '||:old.nd||', nlsd='||:new.nls_d, true );
        when others then null;
          raise_application_error( -20444, ' E_DEAL проблема НЕ визначена '||:old.nd||', nlsd='||:new.nls_d, true );
      end;

    else
      l_accd := null;
    end if;

    -- nls_p
    if ( :new.nls_p is not null )
    then

      begin

        select acc
          into l_accp
          from accounts
         where nls = :new.nls_p
           and kv  = nvl(:new.kvp, gl.baseVal);

        if ( :new.nls_p = :old.nls_p )
        then
          NULL;
        else
          logger.info( 'E_DEAL зміна рахунку, що платить для ND '||:old.nd||', nlsp='||:new.nls_p );
        end if;

      exception
        when no_data_found then NULL;
          logger.info( 'E_DEAL вказаний рах-к Не знайдено для ND '||:old.nd||', nlsp='||:new.nls_p );
      end;

    else
      l_accp := null;
    end if;

  end if;

  if inserting
  then

    insert into E_DEAL$BASE
      (nd, rnk, sos, cc_id, sdate, wdate, user_id, sa, acc26, acc36, accd, accp)
    values
      (:new.nd, :new.rnk, :new.sos, :new.cc_id, :new.sdate, :new.wdate, :new.user_id, :new.sa, l_acc26, l_acc36, l_accd, l_accp);

  elsif updating
  then

    update E_DEAL$BASE
       set rnk     = :new.rnk,
           sos     = :new.sos,
           cc_id   = :new.cc_id,
           sdate   = :new.sdate,
           wdate   = :new.wdate,
           user_id = :new.user_id,
           sa      = :new.sa,
           acc26   = l_acc26,
           acc36   = l_acc36,
           accd    = l_accd,
           accp    = l_accp
     where nd      =:old.nd;

  elsif deleting
  then

    delete from E_DEAL$BASE
     where nd=:old.nd;

    logger.info('E_DEAL видалено угоду № '||:old.nd);

  end if;

end TIUD_EDEAL;
/
