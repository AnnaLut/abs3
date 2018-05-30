PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/DPT_REBRANCH2.sql =========*** Run 
PROMPT ===================================================================================== 

create or replace procedure DPT_REBRANCH2
( p_dptid   in    DPT_DEPOSIT.DEPOSIT_ID%type,
  NewBranch in    DPT_DEPOSIT.BRANCH%type,
  p_trace   in    number default 0
) is
/*=====================================*/
/* Перенесення депозиту на інший бранч */
/*=====================================*/
  NewBranch_2   varchar2(15);
  OldBranch     branch.branch%type;
  NewBrName     branch.name%type;
  l_outmsg      varchar2(1000) := 'DPT_REBRANCH2: ';
  
  type t_tab_accd is table of accounts.acc%type;
  l_accdtab  t_tab_accd;
  
  procedure msg_output( p_msg in varchar2 )
  is
  begin
    case
      when p_trace = 1 then
        l_outmsg := l_outmsg || p_msg || chr(10);
      when p_trace = 2 then
        dbms_output.put_line( p_msg );
      else
        null;
    end case;
  end msg_output;

begin

  -- перевірка на існування вказаного бранча  
  begin

    select name 
      into NewBrName 
      from branch 
     where branch=NewBranch
       and length(branch) = 22;
    
    msg_output( 'New_Branch: '||NewBranch||' - '||NewBrName );
    
  exception
    when no_data_found then
     raise_application_error(-20000, 'Бранч: '||NewBranch||' не найден', true);
  end;

  -- Перевірка існування вказаного депозиту ФО
  begin

    select branch 
      into OldBranch 
      from dpt_deposit 
     where deposit_id = p_dptid;

    msg_output( 'DPT_ID: '||to_char(p_dptid)||' OldBranch = '||OldBranch );

  exception
    when no_data_found then
      raise_application_error(-20000, 'Депозит: '||OldBranch||' не знайдено!', true);
  end;

  begin

    -- Депозитный портфель ФЛ
    update DPT_DEPOSIT
       set branch = NewBranch
     where deposit_id  = p_dptid;

    msg_output( 'DPT_DEPOSIT     -> '||sql%rowcount );

    begin

      select accid
        bulk collect
        into l_accdtab
        from DPT_ACCOUNTS
       where DPTID = p_dptid;

      forall i in l_accdtab.first .. l_accdtab.last
      update ACCOUNTS
         set BRANCH = NewBranch
           , TOBO   = NewBranch
       where ACC  = l_accdtab(i);

      msg_output( 'ACCOUNTS        -> '||sql%rowcount );

    exception
      when NO_DATA_FOUND
        then l_accdtab := null;
    end;

    --  перевіряєм чи бранчі відносяться до одного 2-го рівня
    NewBranch_2 := substr(NewBranch,1,15);

    if NewBranch_2 != substr(OldBranch,1,15)
    then

      update int_accn i
         set acrb = ( select a2.acc 
                        from accounts a1,
                             accounts a2
                       where a1.acc  = i.acrb
                         and a1.nbs  = a2.nbs
                         and a1.ob22 = a2.ob22
                         and a2.BRANCH = NewBranch_2
                         and a2.dazs is null
                         and rownum = 1 )
       where acc in ( select accid 
                        from DPT_ACCOUNTS
                       where DPTID = p_dptid )
         and id = 1;
      
    msg_output( 'INT_ACCN        -> '||sql%rowcount );

    end if;
    
    -- Депозитные договора (открытые и закрытые)
    update DPT_DEPOSIT_ALL  
       set branch = NewBranch 
     where deposit_id  = p_dptid;
    
    msg_output( 'DPT_DEPOSIT_ALL -> '||sql%rowcount );

    -- Хранилище дополнительных соглашений (ДС) к деп.договорам ФЛ
    update DPT_AGREEMENTS
       set branch = NewBranch 
     where dpt_id = p_dptid;

    msg_output( 'DPT_AGREEMENTS  -> '||sql%rowcount );
    
    -- Наследники деп.договоров физ.лиц
    update DPT_INHERITORS   
       set branch = NewBranch 
     where dpt_id = p_dptid;
     
    msg_output( 'DPT_INHERITORS  -> '||sql%rowcount );

    -- Депозитные договора. Запросы
    update DPT_REQUESTS     
       set branch = NewBranch 
     where dpt_id = p_dptid;
     
    msg_output( 'DPT_REQUESTS    -> '||sql%rowcount );
    
    -- Справочик 3-их лиц по вкладу
    update DPT_TRUSTEE
       set branch = NewBranch
     where dpt_id = p_dptid;

    msg_output( 'DPT_TRUSTEE     -> '||sql%rowcount );

  end;

  insert into REBRANCH_DEPOSIT
    ( DPT_ID, BRANCH_NEW, OUTMSG )
  values
    ( p_dptid, NewBranch, 'Змінено бранч для депозиту '||to_char(p_dptid) );

  if p_trace = 1 
  then
     bars_audit.info(l_outmsg);
  end if;

  bc.set_context;

exception
  when others then
    rollback;
    bc.set_context;
    raise_application_error( -20000, 'Помилка: '||SQLERRM||chr(10)||dbms_utility.format_error_backtrace(), true );
end DPT_REBRANCH2;
/

show errors;

GRANT EXECUTE ON DPT_REBRANCH2 TO BARS_ACCESS_DEFROLE;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/DPT_REBRANCH2.sql =========*** End  
PROMPT ===================================================================================== 
