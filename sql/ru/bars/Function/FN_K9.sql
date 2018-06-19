prompt ---------------------------------------------------------------
prompt  function FN_K9
prompt ---------------------------------------------------------------

create OR replace function FN_K9 ( p_IFRS    k9.IFRS%type,     p_POCI  K9.POCI%type )  return      K9.K9%type        IS    l_k9 K9.K9%type := null;
begin
  begin select x.K9 into l_K9 from k9 x where  x.IFRS = p_IFRS and x.POCI = p_POCI ;  
  EXCEPTION WHEN NO_DATA_FOUND THEN  null ;  
  end;
  Return l_K9 ;
end     FN_K9 ;
/
show err ;
