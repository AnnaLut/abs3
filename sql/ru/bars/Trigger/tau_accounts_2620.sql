

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAU_ACCOUNTS_2620.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAU_ACCOUNTS_2620 ***

  CREATE OR REPLACE TRIGGER BARS.TAU_ACCOUNTS_2620 
  AFTER UPDATE OF ostc ON accounts
----------------------------------------------------------------------------------------------------
--  ƒл€ задачи "—писанн€ ком≥с≥њ з неактивних 2620/05 в остан.день м≥с€ц€"
--
--  “риггер анализирует корреспонденции счетов 2620/05 и, в случае "реальных" (клиентских)
--  оборотов, мен€ет дату ACC262005.DAPP_REAL по этому 2620/05.
----------------------------------------------------------------------------------------------------
declare
 l_dk        opldok.DK%type := null;
 l_stmt      opldok.STMT%type :=null;
 l_acc_korr  accounts.ACC%type := null;
 l_nbs_korr  accounts.NBS%type := null;
 l_ob22      accounts.OB22%type := null;
begin

 if gl.acc.NBS <> '2620' then
    RETURN;
 else
    Begin
      Select OB22 into l_ob22 from Accounts where ACC=gl.opl.acc and OB22='05';
    exception when no_data_found then
      RETURN;
    End;
 end if;

 begin

    select ACC into l_acc_korr       --- ACC cчета-корреспондента
      from OPLDOK
     where REF=gl.opl.ref and STMT=gl.opl.stmt and DK=1-gl.opl.dk and TT<>'N12' ;


    select NBS into l_nbs_korr       --- NBS cчета-корреспондента
      from ACCOUNTS
     where ACC=l_acc_korr;


    if  l_nbs_korr not like '6%'  and
        l_nbs_korr <> '2628'      and
        l_nbs_korr <> '2638'      then

        begin
          update ACC262005 set DAPP_REAL = gl.bDATE  where ACC = gl.opl.acc ;
          if sql%rowcount=0 then
             insert into acc262005 (ACC,DAPP_REAL) values (gl.opl.acc, gl.bDATE);
          end if;
        end;

    end if;

 exception when others then
    null;
 end;

end;
/
ALTER TRIGGER BARS.TAU_ACCOUNTS_2620 ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAU_ACCOUNTS_2620.sql =========*** E
PROMPT ===================================================================================== 
