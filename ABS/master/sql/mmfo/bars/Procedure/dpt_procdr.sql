create or replace procedure DPT_PROCDR
( p_modcode  in   bars_supp_modules.mod_code%type,
  p_clean    in   number  default null,
  p_open     in   number  default null    -- відкрити рахунок якщо не знайдений  
) IS
  -- 15.06.2017
  type  t_record is record ( vidd      dpu_vidd.vidd%type,
                             bsd       accounts.nbs%type,
                             bsn       accounts.nbs%type,
                             bsd7      accounts.nbs%type,
                             ob22_d7   accounts.ob22%type,
                             nbs_red   accounts.nbs%type,
                             ob22_red  accounts.ob22%type,
                             branch    accounts.branch%type );
  type  t_table  is table of t_record;
  
  l_tab           t_table;
  l_title         varchar2(20)                 := 'DPT_PROCDR:'; 
  l_branch        branch.branch%type           := '*';
  l_branch_mask   varchar2(16);
  
  l_nbs_d7        DPU_TYPES_OB22.NBS_EXP%type  := '*';
  l_ob22d7        DPU_TYPES_OB22.OB22_EXP%type := '*';
  l_nbs_red       DPU_TYPES_OB22.NBS_RED%type  := '*';
  l_ob22_red      DPU_TYPES_OB22.OB22_RED%type := '*';
  
  l_nls_exp       accounts.nls%type;
  l_nls_red       accounts.nls%type;
  
  --
  -- function
  --
  function get_nls
  ( p_nbs     in  accounts.nbs%type,
    p_ob22    in  accounts.ob22%type,
    p_branch  in  accounts.branch%type,
    p_kv      in  accounts.kv%type  default 980
  ) return accounts.nls%type
    RESULT_CACHE
  is
    l_nls  accounts.nls%type;
  begin
    begin
      select a.nls
        into l_nls 
        from ACCOUNTS a
       where a.ACC = ( select min(acc)
                         from accounts 
                        where nbs    = p_nbs
                          and ob22   = p_ob22
                          and branch = p_branch
                          and kv     = p_kv
                          and dazs is null );
    exception
      when NO_DATA_FOUND then
      
        if (length(p_branch) > 15)
        then
          
          l_nls := get_nls(p_nbs, p_ob22, SubStr(p_branch, 1, 15));
          
        else
          
          if ( p_open = 1 )
          then
            
            begin
              
              -- 1) Установить код вал
              pul.Set_Mas_Ini('OP_BSOB_KV', to_char(p_kv) , 'Код валюти для открытия счета');
              
              -- 2) проверить и открыть нужный счет (если не найден)
              OP_BS_OB1( p_branch, p_nbs||p_ob22 );
              
              -- 3) знайти відкритий рахунок
              l_nls := get_nls(p_nbs, p_ob22, p_branch);
              
            exception
              when OTHERS then
                
                l_nls := null;
                
                bars_audit.info( l_title || sqlerrm || dbms_utility.format_error_backtrace() );
            end;
            
          else
            
            l_nls := null;
            
          end if;
          
        end if;
    end;
    
    RETURN l_nls;
    
  end get_nls;
  ---
BEGIN

  -- Код депозитного модуля
  if ( p_modcode is null or p_modcode <> 'DPT' )
  then
    bars_error.raise_nerror( 'DPT', 'INVALID_PENALTY_MODCODE', nvl(p_modcode, 'null') );
  end if;
  
  -- рівень користувача (для відкриття рахунків)
  l_branch_mask := sys_context('bars_context', 'user_branch');
  
  if ( length(l_branch_mask) = 8 )
  then
    l_branch_mask := '/' || BC.EXTRACT_MFO(l_branch_mask) || '/______/%';
  else
    raise_application_error(-20666, 'ERR: Заборонено виконання вибраної функції користувачем не рівня МФО!', true);
  end if;
  
  if (p_modcode = 'DPT')
  then
    
    if ( p_clean = 1 )
    then -- з очищенням наявних записів
      
      delete PROC_DR$BASE
       where ( NBS, SOUR, REZID ) in ( select BSD, 4, VIDD
                                         from DPT_VIDD );
      
      bars_audit.trace( l_title || ' deleted: '||to_char(sql%rowcount)||' rows.' );
      
    end if;
    
    select o.vidd, 
           o.nbs_dep, o.nbs_int,
           o.nbs_exp, o.ob22_exp,
           o.nbs_red, o.ob22_red, 
           b.branch 
      bulk collect
      into l_tab
      from DPT_OB22 o
         , BRANCH   b
     where b.DATE_CLOSED is null
       and b.BRANCH like l_branch_mask
       and o.OB22_EXP is not null
       and not exists ( select 1
                          from PROC_DR$BASE
                         where NBS    = o.nbs_dep
                           and BRANCH = b.branch
                           and SOUR   = 4
                           and REZID  = o.vidd )
     order by o.nbs_exp, o.ob22_exp, b.branch;
    
  else  -- p_modcode = 'DPU'
    
    -- moved to package DPU_UTILS.FILL_PROCDR();
    null;
      
  end if;
  
  if ( l_tab.count > 0 )
  then
    
    bars_audit.trace( '%s Selected %s  rows!', l_title, to_char(l_tab.count) );
    
    for k in l_tab.first .. l_tab.last
    loop
      
      if ( (l_nbs_d7 != l_tab(k).bsd7) Or 
           (l_ob22d7 != l_tab(k).ob22_d7) Or 
           (l_branch != SubStr(l_tab(k).branch, 1, 15)) )
      then
        
        -- l_branch   := l_tab(k).branch;
        l_branch   := SubStr(l_tab(k).branch, 1, 15);
        l_nbs_d7   := l_tab(k).bsd7;
        l_ob22d7   := l_tab(k).ob22_d7;
        l_nbs_red  := l_tab(k).nbs_red;
        l_ob22_red := l_tab(k).ob22_red;
        
        -- пошук рахунка витрат
        l_nls_exp := get_nls( p_nbs    => l_nbs_d7,
                              p_ob22   => l_ob22d7,
                              p_branch => l_branch );
        
        -- пошук рахунка зменшення витрат
        if (l_ob22_red is Not Null) 
        then
          l_nls_red := get_nls( p_nbs    => l_nbs_red,
                                p_ob22   => l_ob22_red,
                                p_branch => l_branch );
        else
          l_nls_red := null;
        end if;
        
        bars_audit.trace( '%s branch = %s, nbs_exp = %s, ob22_exp = %s, nls_exp = %s, nbs_red = %s, ob22_red = %s, nls_red = %s,.',
                          l_title, l_branch, l_nbs_d7, l_ob22d7, l_nls_exp, 
                          nvl(l_nbs_red,'null'), nvl(l_ob22_red,'null'), nvl(l_nls_red,'null') );
        
      end if;
      
      if ( l_nls_exp is not null )
      then
        
        begin
          insert
            into PROC_DR$BASE
               (          nbs,       g67,       v67, sour,         nbsn,      g67n,      v67n,         rezid, io,          branch )
          values
               ( l_tab(k).bsd, l_nls_exp, l_nls_exp,    4, l_tab(k).bsn, l_nls_red, l_nls_red, l_tab(k).vidd,  1, l_tab(k).branch );
          
        exception
          when others then 
            bars_audit.error( l_title || chr(10) || dbms_utility.format_error_stack() || dbms_utility.format_error_backtrace() );
        end;
/*       
      else
        begin
          l_errmsg := ( l_errmsg || chr(10) || l_tab(k).branch||' ('||l_nbs_d7||'/'||l_ob22d7||')' );
        exception
          when OTHERS then
            if (sql%code = -06502) then  
              bars_audit.error( l_errmsg );
              l_errmsg := ( l_title || 'Не знайдено рахунок витрат для підрозділу:' || chr(10) || l_tab(k).branch||' ('||l_nbs_d7||'/'||l_ob22d7||')' );
            end if;
        end; 
*/
      end if;
      
    end loop;
    
    l_tab.delete();
    
  else
    bars_audit.info( l_title || ' No rows selected!' );
  end if;
  
END DPT_PROCDR;
/

show err

GRANT EXECUTE ON DPT_PROCDR TO BARS_ACCESS_DEFROLE;
