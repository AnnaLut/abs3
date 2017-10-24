

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_ACC_87_OPEN.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_ACC_87_OPEN ***

  CREATE OR REPLACE PROCEDURE BARS.P_ACC_87_OPEN (p_dat date, p_grp number) is
 l_tmp    integer:=null;
 l_acc    accounts.acc%type:=null;
 p_tip    accounts.tip%type:='ODB';
-- p_branch accounts.branch%type:=substr(SYS_CONTEXT('bars_context','user_branch_mask'),1,8);
 l_nms    accounts.nms%type;
 l_nls    accounts.nls%type;
 p_rnk    accounts.rnk%type;
 --l_pap    ps.pap%type;
 MODCODE   constant varchar2(3) := 'NAL';
begin
   begin
     select rnk  into p_rnk
          from accounts
          where nls=(select val from params where par='NU_KS7');
          exception when no_data_found then
                    bars_error.raise_nerror(MODCODE, 'NAL_NU_KS7');
   end;
 for k in
 (
  select  p.ap  pap,
          p.r020 r020,
          p.p080 p080,
          p.r020_fa r020_fa,
          p.ob22 ob22,
          substr(p.txt,1,35) name,
          R020||'_'||R020_FA||
     decode(substr(OB22,1,1),'A','10',
                             'B','11','C','12','D','13',
                             'E','14','F','15','G','16',
                             'H','17','I','18','J','19',
                             'K','20','L','21','M','22',
                             'N','23','O','24','P','25',substr(OB22,1,1))||
                             substr(OB22,2,1)   nls,
          substr(p.txt,1,70) nmsn,
          p.d_open
     from   sb_p0853 p
     where (p.d_close is null or p.d_close>gl.bd)
           and p.r020_fa<>'0000' and ob22<>'00' and  not exists
           (select 1 from  accounts a,specparam_int s
                     where  a.nbs=p.r020 and a.kv=980
                       and  a.acc=s.acc
                       and  s.p080=p.p080
                       and  s.r020_fa=p.r020_fa
                       and  s.ob22=p.ob22
                       and  a.dazs is null)
union all
select p.ap pap,
       p.r020 r020,
       p.p080 p080,
       p.r020_fa r020_fa,
       p.ob22 ob22,
       substr(p.txt,1,35) name,
       R020||'_'||P080 nls,
       substr(p.txt,1,70) nmsn,
       p.d_open
     from   sb_p0853 p
     where (p.d_close is null or p.d_close>gl.bd)
           and p.r020_fa='0000' and p.ob22='00' and
           not exists
           (select 1 from  accounts a,specparam_int s
                     where  a.nbs=p.r020 and a.kv=980
                       and  a.acc=s.acc
                       and  s.p080=p.p080
                       and  s.r020_fa=p.r020_fa
                       and  s.ob22=p.ob22
                       and  a.dazs is null)
 )
 loop
-- откроем счет
   begin
        op_reg_lock (99, 0, 0, p_grp,  l_tmp,  p_rnk,
                vkrzn(substr(f_ourmfo,1,5),k.nls),   980, k.nmsn, 'ODB',
                USER_ID, l_acc, '1', k.pap,  0, null, null, null, null, null,
                null, null, null, null, null );
   end;
   if l_acc is null
      then bars_error.raise_nerror(MODCODE, 'NAL_ACC_ERR');
   end if;

/* замена даты открытия счета, если открываем после даты ввода показателя */
   update accounts set daos=k.d_open
    where acc=l_acc;

/* установка спецпараметров */
   begin
   insert into specparam_int ( acc, p080, ob22, r020_fa)
   values (    l_acc, k.P080, k.OB22, k.R020_FA);
   exception when dup_val_on_index then
       update  specparam_int set p080=k.P080, r020_fa=k.R020_FA,
                                 ob22=k.OB22 where acc=l_acc;
   end;
 end loop;
commit;
end;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_ACC_87_OPEN.sql =========*** End
PROMPT ===================================================================================== 
