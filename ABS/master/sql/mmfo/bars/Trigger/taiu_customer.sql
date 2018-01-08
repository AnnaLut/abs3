create or replace trigger TAIU_CUSTOMER
after insert or update 
ON CUSTOMER
for each row
declare
  l_str  varchar2(256);
  l_int  pls_integer;
begin
  
  -- TIU_ZAPRET
  begin
    
    ZAPRET( l_int, :new.CODCAGENT, :new.ISE, :new.FS );
    
    if ( l_int <> 0 )
    then
      raise_application_error( -20666, 'Недопустима комбінація параметрів клієнта ( K030='||to_char(:new.COUNTRY)||
                                       ', K070='||to_char(:new.ISE)||', K080='||to_char(:new.FS)||')!', true );
    end if;
    
  exception
    when OTHERS then
      case
      when ( instr(sqlerrm,'\7777') > 0 )
      then raise_application_error( -20666, 'Недопустима комбінація параметрів [K030]+[K070]', true );
      when ( instr(sqlerrm,'\7778') > 0 )
      then raise_application_error( -20666, 'Недопустима комбінація параметрів [K030]+[K070]+[K080]', true );
      else raise_application_error( -20666, substr( sqlerrm, 12, instr( sqlerrm, 'ORA-06510' ) -12 ), true );
      end case;
  end;
  
  if ( inserting )
  then
    
    -- TAI_CUST_RIZIK
    kl.setCustomerElement( :new.RNK, 'RIZIK', 'Низький', 0 );
    
    -- TAI_CUSTOMER_BUSSL
    begin
      
      execute immediate 'select BUSSLINE from CUSTOMER_BUSS where EDRPOU = :cust_code and rownum < 2'
         into l_str
        using :new.okpo;
      
      if ( l_str is not null )
      then
        kl.setCustomerElement( :new.RNK, 'BUSSL', l_str, 0 );
      end if;
      
    exception
      when NO_DATA_FOUND then
        null;
      when OTHERS then
        bars_audit.error( 'TAI_CUSTOMER_BUSSL: '||sqlerrm );
    end;
    
    -- TIU_CUS_GR
    begin
      
      select NAME
        into l_str
        from COUNTRY
       where COUNTRY = :new.country;
      
      kl.setCustomerElement( :new.RNK, 'GR', l_str, 0 );
      
    exception
      when NO_DATA_FOUND then
        raise_application_error( -20666, 'Не знайдено країну з кодом '||to_char(:new.country), true );
      when others then
        bars_audit.error( 'TIU_CUS_GR: '||sqlerrm );
    end;
    
  end if;
  
end TAIU_CUSTOMER;
/

show errors
