--
-- drop TRIGGER
--
begin
  execute immediate 'drop trigger TBIU_SPECPARAMINT_OB22';
  dbms_output.put_line('Trigger dropped.');
exception
  when OTHERS then
    if (sqlcode = -04080)
    then dbms_output.put_line('Trigger TBIU_SPECPARAMINT_OB22 does not exist.');
    else raise;
    end if;
end;
/

CREATE OR REPLACE TRIGGER BARS.TBIU_ACCOUNTS_OB22
BEFORE INSERT OR UPDATE OF OB22 ON BARS.ACCOUNTS
FOR EACH ROW
WHEN ( SubStr(nvl(NEW.NBS,'8'),1,1) <> '8' ) -- для рахунків 1-7 та 9 класу
declare
  l_d_open   sb_ob22.d_open%type;
  l_d_close  sb_ob22.d_close%type;
begin
  if :new.ob22 is not null and (:old.ob22 is null or :new.ob22<>:old.ob22) 
  then
    
    begin
      
      select distinct 
               d_open,   d_close
        into l_d_open, l_d_close
        from SB_OB22
       where R020 = :new.NBS
         and OB22 = :new.OB22;
      
      case
        when ( l_d_open > :new.DAOS ) 
        then raise_application_error(-20666, 'Код OB22 "'||:new.ob22||'" для бал.рах. "'||:new.NBS||'" діє з '    ||to_char(l_d_open,  'dd.MM.yyyy'), true);
        when ( l_d_close is not Null AND l_d_close <= gl.bd )
        then raise_application_error(-20666, 'Код OB22 "'||:new.ob22||'" для бал.рах. "'||:new.NBS||'" закрито з '||to_char(l_d_close, 'dd.MM.yyyy'), true);
        else null;
      end case;

    exception
      when NO_DATA_FOUND then
        raise_application_error(-20666, 'Код OB22 "'||:new.ob22||'" для бал.рах. "'||:new.NBS||'" не відсутній в довіднику!', true);
    end;
    
  end if;
  
end TBIU_ACCOUNTS_OB22;
/

show err
