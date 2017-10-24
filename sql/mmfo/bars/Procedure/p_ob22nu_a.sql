

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_OB22NU_A.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_OB22NU_A ***

  CREATE OR REPLACE PROCEDURE BARS.P_OB22NU_A (p_dat1 date ) is
 l_prizn char(1) ;
 dat_tek DATE;
 l_kk    integer;       /* количество необработанных */
 l_grp   number;
 l_ks_a   varchar2(15);  /*контрсчет для активов*/
 l_ks_p   varchar2(15);  /*контрсчет для пасивов*/
 l_nms_ks_a  varchar2(70);  /* название контрсчета для акт.сч.НУ*/
 l_nms_ks_p  varchar2(70);  /* название контрсчета для пас.сч.НУ*/
/* процедура автоматической оплаты проводок ФУ в  НУ
14-04-2010   qwa

 */

MODCODE   constant varchar2(3) := 'NAL';

begin
execute immediate 'truncate table tmp_ob22_funu_auto';
execute immediate 'truncate table tmp_ob22nu_auto';

Dat_tek:=GL.bdate; -- СОХРАНЕНИЕ ТЕК ДАТЫ

begin
 select p.val , a.nms
   into l_ks_a, l_nms_ks_a
   from params p,accounts a
  where p.par='NU_KS6' and a.nls=ltrim(rtrim(p.val));
 exception when no_data_found then null;    -------------------обработка ошибки
end;
begin
 select p.val , a.nms
  into  l_ks_p, l_nms_ks_p
  from params p,accounts a
 where p.par='NU_KS7' and a.nls=ltrim(rtrim(p.val));
 exception when no_data_found then null;    -------------------обработка ошибки
end;
begin
 select to_number(ltrim(rtrim(p.val)))
   into l_grp
   from params p
  where p.par='NU_CHCK' ;
 exception when no_data_found then null;    -------------------обработка ошибки
end;
-- связная таблица, запомним ее во временной и подтянем контрсчета
for n in (select ACC, NLS, NMS, NBS, P080,  OB22, ACCN, NLSN, NMSN, NBSN,  NP080, NOB22, PRIZN, NMS8,AP
         from v_ob22nu)
loop
  begin
       insert into tmp_ob22nu_auto
               (ACC, NLS, NMS, NBS, P080,  OB22, ACCN, NLSN,
                NMSN, NBSN,  NP080, NOB22, PRIZN,
                NMS8,AP,KS)
         values  (n.ACC, n.NLS, n.NMS, n.NBS, n.P080,  n.OB22, n.ACCN, n.NLSN,
                n.NMSN, n.NBSN,  n.NP080, n.NOB22, n.PRIZN,
                n.NMS8,n.AP,decode(n.AP,'1',l_ks_a,'2',l_ks_p,l_ks_p));
       exception when dup_val_on_index then
       bars_error.raise_nerror(MODCODE, 'NAL_DUPACCN',n.nls,n.nlsn,n.np080);
  end;
end loop;

--
for t in (
          select   l.ref,l.stmt,l.acc,l.dk,l.fdat,l.otm,l.tt,l.s,   s.nlsn,s.ks,s.ap,s.nbs
           from    (select ref,stmt,acc,dk,fdat,otm,tt,s from opldok where fdat=p_dat1) l ,
                   tmp_ob22nu_auto s
          where    l.acc=s.acc
            and    s.nbs  not in ( '2066','2076','2086','2106', '2116','2126','2136','2206','2236','2637')
            and    s.nbs  not in ( '3400','3410','3500','3600','4500' )
            and    BITAND (NVL (l.otm, 0), 1) = 0
            and    BITAND (NVL (l.otm, 0), 2) = 0
          )
loop
-- блок оплаты PO3(авто)----------
-- все дебеты ФУ платим наоборот в НУ (счет А - КТ, счет Б - ДТ)
-- все кредиты ФУ платим как есть     (счет А - ДТ, счет Б - КТ)
  GL.bdate:=t.fdat;
  begin
    if  t.nlsn is not null  and  t.ks is not null  and t.dk=0  then
        gl.payv(1, t.ref,  t.fdat, 'PO3',0, 980, t.nlsn, t.S, 980, t.ks ,t.S);
    end if;
    exception when others then  goto CONTIN;
  end;
  begin
    if t.nlsn is not null  and  t.ks is not null  and t.dk=1  then
        gl.payv(1, t.ref,  t.fdat, 'PO3',0, 980, t.nlsn, t.S, 980, t.ks ,t.S);
    end if;
    exception when others then  goto CONTIN;
  end;

   update opldok    set otm= bitand(nvl(otm,0),254)+1 where ref=t.ref  and stmt=t.stmt;
-- проводка с t.stmt обработана, но возможно остались еще
-- проставим признак об оплате, если все проводки уже обработаны

  begin
    l_kk:=0;
    select count(*) into l_kk
      from  opldok o
     where  o.ref=t.ref
       and bitand(nvl(o.otm,0),1) = 0   -- не оплачена в НУ
       and bitand(nvl(o.otm,0),2) = 0   -- не снята с визы в НУ
       and o.tt<>'PO3' ;
       exception when no_data_found then null;
   end;
   if l_kk=0 then
      insert into oper_visa (ref, dat, userid, groupid, status, passive)
                                    values (t.ref, SYSDATE, USER_ID, l_grp, 2, null) ;
   end if;
   commit;
   <<contin>> null;
end loop;
GL.bdate:=dat_tek;
end  P_OB22NU_A ;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_OB22NU_A.sql =========*** End **
PROMPT ===================================================================================== 
