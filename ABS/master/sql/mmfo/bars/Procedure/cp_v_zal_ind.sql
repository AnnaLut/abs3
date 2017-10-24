

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/CP_V_ZAL_IND.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure CP_V_ZAL_IND ***

 create or replace procedure CP_V_ZAL_IND
  (p_ref number, p_acc number, p_id number, p_kol_zal number, p_dat_zal date, p_mode int, p_rnk number, p_id_zal number)
is
  l_datz       date;
  l_datz2      date;
  l_datz3      date;
  l_spid       int:=85;
  r_cpvz       cp_v_zal_web%rowtype;
  r_accpv      accountspv%rowtype;
  r_accpv_next accountspv%rowtype;

  l_ref        cp_zal.ref%type;
  l_id         cp_zal.id%type;
  l_acc        accountspv.acc%type;
  l_id_zal     cp_zal.id_cp_zal%type;

BEGIN  null;
/* raise_application_error(-20001,'p_id_zal = '||p_id_zal \*p_rnk*\ ||' -------- ');*/
/* raise_application_error(-20001,'START '||'l_ref= ' ||l_ref ||' p_acc= '||p_acc||' l_id= '||l_id
                           ||' p_kol_zal= '||p_kol_zal||' p_dat_zal= '||to_char(p_dat_zal,'DD.MM.YYYY')||' p_mode= '||p_mode||' p_rnk= '||p_rnk);  */

 l_ref       := nvl(p_ref,      PUL.get('CP_ref'));
 l_id        := nvl(p_id,       PUL.get('CP_id')) ;
 l_acc       := nvl(p_acc,      PUL.get('CP_ACC'));
 l_id_zal    := p_id_zal ;
 /*l_id_zal := nvl(p_id_zal,PUL.get('CP_ID_ZAL')) ;*/
 
 
 l_datz:=p_DAT_ZAL;
 l_datz2:=nvl(p_DAT_ZAL, to_date('31.12.2099','dd.mm.yyyy'));

--CP_V_ZAL_IND(:REF, :ACC, :ID, :KOL_ZAL, :DAT_ZAL, -3)
--  ver 1.6  16/11-16  11/11-16   19/07-16
--  l_datz:=to_date(p_DAT_ZAL, 'DD-MON-YY' , 'nls_date_language =American');
--  l_datz2:=nvl(to_date(p_DAT_ZAL,'dd.mm.yyyy'), to_date('31012099','ddmmyyyy'));

  if l_datz2=to_date('31.12.2099','dd.mm.yyyy') then null;
     else  l_datz2:=l_datz2+1;
  end if;

  l_datz3:=p_DAT_ZAL;
  logger.error('Vxod '||l_acc||' '||p_dat_zal||' '||l_datz||' '||l_datz2||' '||p_kol_zal);

  begin
   select spid
     into l_spid
     from sparam_list
    where tag = 'CP_ZAL';
  exception when no_data_found then  l_spid:=85;
  end;
  ----------- p_mode=3
  if nvl(p_mode,0)=3 then  null;

     delete from accountspv where acc = l_acc and parid = l_spid    and dat2 = p_dat_zal;
     delete from cp_zal     where id_cp_zal = l_id_zal;
     logger.error('del ref '||l_ref||'/'||l_acc||' dat='||p_dat_zal||' '||l_spid);
  end if;
  ----------- p_mode= -3
  if nvl(p_mode,0)=-3 then  null;
    delete from accountspv where acc=l_acc and parid=l_spid and dat1>p_dat_zal;
     logger.error('del ref '||l_ref||'/'||l_acc||' dat1>'||p_dat_zal||' '||l_spid);
  end if;
  ----------- p_mode=2
  if nvl(p_mode,0)=2 then

  -- таблиця CPZAL т_льки для сум_сност_ в_д попередньої верс_ї вьюшки
   update cp_zal set kolz = p_KOL_ZAL,
                     datz = p_DAT_ZAL,
                     RNK  = p_rnk
              where  id_cp_zal = l_id_zal ;
   if SQL%rowcount = 0 then
      insert into cp_zal (ref, id, kolz, datz, RNK)
      values (l_ref, l_id, p_KOL_ZAL, p_DAT_ZAL, p_rnk);
   end if;

   logger.error('befor upd* '||l_acc||' p_dat_zal '||p_dat_zal||' '||l_spid||' datz='||l_datz||' datz2='||l_datz2);  ---||' nd='||p_new.nd);

  begin
  select pv.*
    into r_accpv_next
    from accountspv pv
   where pv.acc = l_acc
     and pv.parid = l_spid
     and pv.dat2 = (select min(dat2)
                      from accountspv
                     where acc = l_acc
                       and parid = l_spid
                       and dat2 > p_dat_zal);

  logger.error('next '||r_accpv_next.acc||' '||r_accpv_next.dat1||' '||r_accpv_next.dat2||' '||r_accpv_next.val);
  exception when no_data_found then
    null;
    r_accpv_next:=null;
    logger.error('next not found '||l_acc);
  end;

  begin
    select *
      into r_accpv
      from accountspv
     where acc   = l_acc
       and parid = l_spid
       and dat1  = p_dat_zal + 1;

    logger.error('select ' || r_accpv.dat1);
    logger.error('befor upd ' || l_acc || ' ' || p_dat_zal || ' ' ||
                 l_spid || ' ' || l_datz || ' ' || l_datz2);

    update accountspv
       set val = p_kol_zal --nvl(p_kol_zal,'0')
     where acc = l_acc
       and parid = l_spid
       and dat1 = (select max(dat1)
                     from accountspv
                    where acc = l_acc
                      and parid = l_spid
                      and dat1 <= p_dat_zal)
       and dat2 <= l_datz;

  exception  when no_data_found then
      null;

  if p_dat_zal != to_date('31122099','ddmmyyyy') then
  logger.error('befor ins * '||l_acc||' '||p_dat_zal||' '||l_spid||' '||l_datz||' '||l_datz2);

  begin
    insert into accountspv (acc  ,dat1      ,dat2,parid ,val)
           values          (l_acc,l_datz + 1,null,l_spid,r_accpv_next.val);
  exception when dup_val_on_index then
                 null;
                 logger.error('ins dup_val ' || l_acc || ' ' || p_dat_zal);
            when others then
                 logger.error('ins err' || l_acc || ' ' || p_dat_zal || ' ' || l_spid || ' ' ||l_datz + 1 || ' ' || l_datz2);
       raise;
  end;

  logger.error('upd ins '||l_acc||' '||p_dat_zal||' '||l_spid||' '||l_datz||' '||l_datz2);
  end if;

    begin
        select *
          into r_accpv
          from accountspv
         where acc   = l_acc
           and parid = l_spid
           and dat2  = p_dat_zal;

        update accountspv
           set val = p_kol_zal --nvl(p_kol_zal,'0')
         where acc   = l_acc
           and parid = l_spid
           and dat1  = r_accpv.dat1;

    exception when no_data_found
      then null;
        begin
        insert into accountspv(acc  ,dat1    ,dat2  ,parid ,val)
               values         (l_acc,bankdate,l_datz,l_spid,p_kol_zal);
        exception when dup_val_on_index then
             null;
             logger.error('ins dup_val 2 ' || l_acc || ' ' || p_dat_zal);
          end;
    end;
  end;
 end if;



END CP_V_ZAL_IND;
/
show err;

PROMPT *** Create  grants  CP_V_ZAL_IND ***
grant EXECUTE                                                                on CP_V_ZAL_IND    to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on CP_V_ZAL_IND    to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/CP_V_ZAL_IND.sql =========*** End 
PROMPT ===================================================================================== 
