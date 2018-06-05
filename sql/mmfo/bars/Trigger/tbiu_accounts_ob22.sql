CREATE OR REPLACE TRIGGER TBIU_ACCOUNTS_OB22
BEFORE INSERT OR UPDATE OF OB22 ON BARS.ACCOUNTS
FOR EACH ROW
 WHEN (
SubStr(nvl(NEW.NBS,'8'),1,1) <> '8'
      ) declare
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
        when ( l_d_open > gl.bd )
        then raise_application_error(-20666, '��� OB22 "'||:new.ob22||'" ��� ���.���. "'||:new.NBS||'" 䳺 � '    ||to_char(l_d_open,  'dd.MM.yyyy'), true);
        when ( l_d_close is not Null AND l_d_close <= gl.bd )
        then raise_application_error(-20666, '��� OB22 "'||:new.ob22||'" ��� ���.���. "'||:new.NBS||'" ������� � '||to_char(l_d_close, 'dd.MM.yyyy'), true);
        else null;
      end case;

    exception
      when NO_DATA_FOUND then
        raise_application_error(-20666, '��� OB22 "'||:new.ob22||'" ��� ���.���. "'||:new.NBS||'" ������� � ��������!', true);
    end;

  end if;

end TBIU_ACCOUNTS_OB22;
/
