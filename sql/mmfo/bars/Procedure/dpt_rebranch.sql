create or replace procedure BARS.DPT_REBRANCH
( OldBranch  in  branch.branch%type,
  NewBranch  in  branch.branch%type,
  p_trace    in  signtype default 0
) is
/*==============================================================================*/
/* Перенесення депозитного портфелю ТВБВ на інший бранч (тільки діючі договора) */
/*==============================================================================*/
  NewBran2   varchar2(15);
  OldBran2   varchar2(15);
  OldBrName  branch.name%type;
  NewBrName  branch.name%type;
  
  type t_tab_accd is table of accounts.acc%type;
  l_accdtab  t_tab_accd;
begin
  
  dbms_output.put_line('procedure start: '||to_char(sysdate, 'DD.MM.YYYY HH24:MI:SS'));
  dbms_output.new_line;
  dbms_output.put_line('------------------------------------');

  bc.subst_mfo(bc.extract_mfo(OldBranch));
  
  -- перевірка на існування бранчів
  begin
    select name into OldBrName from branch where branch=OldBranch;  
    dbms_output.put_line('Old_Branch: '||OldBranch||' - '||OldBrName);
  exception
    when NO_DATA_FOUND then
      raise_application_error(-20000, 'Бранч: '||OldBranch||' не найден', true);
  end;
    
  begin
    select name into NewBrName from branch where branch=NewBranch;
    dbms_output.put_line('New_Branch: '||NewBranch||' - '||NewBrName);
  exception
    when NO_DATA_FOUND then
      raise_application_error(-20000, 'Бранч: '||NewBranch||' не найден', true);
  end;

  begin
    
    begin
      select da.ACCID
        bulk collect
        into l_accdtab
        from DPT_ACCOUNTS da 
        join DPT_DEPOSIT  dd
          on ( dd.DEPOSIT_ID = da.DPTID )
       where dd.BRANCH = OldBranch;
    exception
      when NO_DATA_FOUND then
        l_accdtab := null;
    end;
  
    -- перевіряєм чи бранчі відносяться до одного 2-го рівня
    OldBran2 := subStr(OldBranch, 1, 15);
    NewBran2 := subStr(NewBranch, 1, 15);
      
    if (OldBran2 != NewBran2)
    then
      update int_accn i
         set i.acrb = ( select a2.acc 
                          from accounts a1 
                          join accounts a2
                            on (a1.nbs = a2.nbs and a1.ob22 = a2.ob22 )
                         where a1.acc  = i.acrb
                           and a2.BRANCH = NewBran2
                           and a2.dazs is Null
                           and rownum = 1 )
       where i.acc in ( select da.accid 
                          from DPT_ACCOUNTS da
                          join DPT_DEPOSIT  dd
                            on ( dd.DEPOSIT_ID = da.DPTID )
                         where dd.BRANCH = OldBranch )
         and i.id = 1;
      
      if p_trace = 1 
      then
        dbms_output.put_line('------------------------------------');
        dbms_output.put_line('INT_ACCN        -> '||sql%rowcount);
      end if;
      
    end if;
    
    -- Депозитный портфель ФО
    update DPT_DEPOSIT
       set branch = NewBranch
     where branch = OldBranch;
      
    if p_trace = 1 
    then
      dbms_output.put_line('DPT_DEPOSIT     -> '||sql%rowcount);
    end if;
    
    -- Депозитные договора (открытые и закрытые)
    update DPT_DEPOSIT_ALL
       set branch = NewBranch
     where branch = OldBranch;
    
    if p_trace = 1
    then
      dbms_output.put_line('DPT_DEPOSIT_ALL -> '||sql%rowcount);
    end if;
    
    -- Хранилище доп.реквизитов вкладов
    update DPT_DEPOSITW
       set branch = NewBranch
     where branch = OldBranch;
    
    if p_trace = 1
    then
      dbms_output.put_line('DPT_DEPOSITW    -> '||sql%rowcount);
    end if;
    
    -- Хранилище дополнительных соглашений (ДС) к деп.договорам ФЛ
    update DPT_AGREEMENTS
       set branch = NewBranch
     where branch = OldBranch;
      if p_trace = 1 then
        dbms_output.put_line('DPT_AGREEMENTS  -> '||sql%rowcount);
      end if;        
    
    -- Наследники деп.договоров ФО
    update DPT_INHERITORS
       set branch = NewBranch
     where branch = OldBranch;
    
    if p_trace = 1
    then
      dbms_output.put_line('DPT_INHERITORS  -> '||sql%rowcount);
    end if;
    
    -- Хранилище платежей по депозитным договорам ФЛ
    update DPT_PAYMENTS
       set branch = NewBranch
     where branch = OldBranch;
    
    if p_trace = 1 
    then
      dbms_output.put_line('DPT_PAYMENTS    -> '||sql%rowcount);
    end if;
    
    -- Депозитные договора. Запросы
    update DPT_REQUESTS
       set branch = NewBranch
     where branch = OldBranch;
    
    if p_trace = 1 
    then
      dbms_output.put_line('DPT_REQUESTS    -> '||sql%rowcount);
    end if;   
    
    -- Справочик 3-их лиц по вкладу
    update DPT_TRUSTEE
       set branch = NewBranch
     where branch = OldBranch;
 
    if p_trace = 1
    then
      dbms_output.put_line('DPT_TRUSTEE     -> '||sql%rowcount);
    end if;
    
    -- Довідник корисувачів для руку договорів
    delete DPT_STAFF
     where branch = OldBranch;
      
    if p_trace = 1 
    then
      dbms_output.put_line('DPT_STAFF       -> '||sql%rowcount);
    end if;
    
    -- Рахунки депозитних договорів
    forall i in l_accdtab.first .. l_accdtab.last
    update ACCOUNTS
       set TOBO   = NewBranch,
           BRANCH = NewBranch
     where ACC = l_accdtab(i);
    
    if p_trace = 1 
    then
      dbms_output.put_line('ACCOUNTS        -> '||sql%rowcount);
      dbms_output.put_line('------------------------------------');
    end if;
    
  exception
    when others then
      rollback;
      dbms_output.new_line;
      raise_application_error(-20001, 'Помилка: '||dbms_utility.format_error_stack()||chr(10)||dbms_utility.format_error_backtrace());
  end;
  
  bc.set_context;

  dbms_output.put_line('procedure finish: '||to_char(sysdate, 'DD.MM.YYYY HH24:MI:SS'));
  dbms_output.new_line;
  dbms_output.put_line( 'IF COMPLETED WITHOUT ERROR THEN RUN COMMIT!!!' );
  dbms_output.new_line;
  
end dpt_rebranch;
/

show error

GRANT EXECUTE ON BARS.DPT_REBRANCH2 TO DPT_ADMIN;
GRANT EXECUTE ON BARS.DPT_REBRANCH2 TO ABS_ADMIN;