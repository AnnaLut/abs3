

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/SG_3739.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  procedure SG_3739 ***

  CREATE OR REPLACE PROCEDURE BARS.SG_3739 ( KF_ varchar2,tip_ number:=0)
IS
--  Авто-открытие счетов гашения.
--  Для установ в которых будет использоватся функция "погашение кредита готiвкою"
-- Необходимо перед выполнением скрипта открыть счет 37390  (5-ти значный)

--  KF_ - код МФО
--  tip - 0 - Все 2- ЮЛ 3- ФЛ


  ACC_    accounts.ACC%type;
  SPN_GRP  accounts.NLS%type;
  COM_GRP  PARAMS$BASE.comm%type := 'КП: Гл.рах. для погаш кредиту готiвкою';

  l_NLS    accounts%rowtype;
  l_s080   specparam.s080%type;
  l_count int:=0;



begin
  bc.set_context;
  begin
    Insert into NLSMASK (MASKID, DESCR, MASK)
    Values              ('SG ', 'Рахунок погашення КП', '3739_BBBNRRRRR');
  exception when dup_val_on_index then
    Update NLSMASK
       set mask='3739_'||nvl((select substr(MASK,6,9) from NLSMASK where MASKID='SS '),'BBBNRRRRR')
     where MASKID ='SG ';
  end;

  bars_context.subst_MFO(KF_);

  SPN_GRP := VKRZN( Substr(gl.aMFO,1,5), '37390');
  update PARAMS$BASE set val=SPN_GRP,comm=COM_GRP where par='SPN_GRP';
  if SQL%rowcount=0  then
     Insert into PARAMS$BASE (PAR,VAL,COMM) Values ('SPN_GRP',SPN_GRP,COM_GRP);
  end if;


  for k in ( select d.branch, d.nd, d.wdate
          from cc_deal d
          where d.sos<15 and d.vidd in (1,2,3,11,12,13)
            and ( (d.vidd in (1,2,3) and tip_ in (0,2))
                  or (d.vidd in (11,12,13) and tip_ in (0,3))
                )
            and not exists (select 1
                              from nd_acc n2,accounts a2
                             where n2.acc=a2.acc and n2.nd=d.nd and a2.dazs is null
                                  and  (a2.tip='SG ' or a2.nbs in (2909,3739))
                           )
            and 0!=(select sum(ostc)
                      from nd_acc n3,accounts a3
                     where n3.acc=a3.acc and n3.nd=d.nd and a3.dazs is null
                           and a3.tip in ('SS ','SP ','SN ','SPN')
                   )
           )
  loop
   bc.subst_BRANCH(k.branch);

   select a.kv, a.nls, a.isp, a.grp, s.s080
     into l_nls.kv ,l_nls.nls,l_nls.isp, l_nls.grp,l_s080
     from accounts a,nd_acc n,specparam s
    where n.nd=k.nd and n.acc=a.acc and a.tip in ('SS ','SP ','SN ','SPN')
          and a.dazs is null and rownum=1;

   cck.cc_op_nls( k.ND, l_nls.kv ,VKRZN(substr(gl.aMFO,1,5),'37390'||substr(l_nls.nls,6,9) ), 'SG ', l_nls.isp, l_nls.grp,l_s080,k.wdate, ACC_);
   l_count:=l_count+1;

  end loop;

  commit;

  bc.set_context;
  dbms_output.put_line('Открыто счетов с типом SG - '||l_count);
  logger.info('CCK2  migr открыто счетов гашения= '||l_count);

end SG_3739;
/
show err;

PROMPT *** Create  grants  SG_3739 ***
grant EXECUTE                                                                on SG_3739         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/SG_3739.sql =========*** End *** =
PROMPT ===================================================================================== 
