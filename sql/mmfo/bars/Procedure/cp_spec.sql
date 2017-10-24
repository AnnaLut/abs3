

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/CP_SPEC.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  procedure CP_SPEC ***


CREATE OR REPLACE PROCEDURE 
BARS.cp_spec (p_dat date default null, p_days int default 5)
is

-- Дозаповнення спецпараметрів для нових рах-в портфеля ЦП
--  ***    v.3.5 від 25/04-17   -- prv v.3.3a 

--  25/04    включаю аналіз CP_ARCH
--  21/04    якщо спецпар-р НЕ пустий - НЕ міняємо
--  20/04-17 зміни через Accreg.setAccountSParam

l_dat date;
l_s180 varchar2(1); l_r011 varchar2(1); l_r013 varchar2(1);
l_r016 varchar2(2); l_s080 varchar2(1); l_s580 varchar2(1);
l_ob22 char(2);
l_ob22d char(2);
l_s130 specparam.s130%type; l_r012 varchar2(1);
r_spec specparam%rowtype;
fl int; fl1 int;

begin
l_dat:=p_dat;
if p_dat is null then l_dat:=bankdate; end if;
logger.info('CP_SPEC: start l_dat='||l_dat||' days='||p_days);

for k0 in (select c.id,c.ref,ar.dat_ug from cp_deal c, oper o, cp_arch ar
           where 1=1 --and dat_ug > l_dat - p_days and op in (1,3)
                 and c.ref=o.ref and o.sos>0 and c.dazs is null
                 and ar.ref=o.ref and ar.dat_ug > l_dat - p_days and ar.op in (1,3)
           order by c.ref)
loop
for k in (
SELECT c.ACC,c.ref,a.nls,a.kv,a.accc FROM CP_DEAL c, accounts a
       WHERE ref=k0.ref and c.acc is not NULL and a.acc=c.acc and a.dazs is null   
UNION ALL    
SELECT c.ACCD,c.ref,a.nls,a.kv,a.accc FROM CP_DEAL c, accounts a 
       WHERE ref=k0.ref and c.accd is not NULL and a.acc=c.accd(+) and a.dazs is null  
UNION ALL    
SELECT c.ACCP,c.ref,a.nls,a.kv,a.accc FROM CP_DEAL c, accounts a 
       WHERE ref=k0.ref and c.accp is not NULL and a.acc=c.accp(+) and a.dazs is null
UNION ALL    
SELECT c.ACCr,c.ref,a.nls,a.kv,a.accc FROM CP_DEAL c, accounts a 
       WHERE ref=k0.ref and c.accr is not NULL and a.acc=c.accr(+) and a.dazs is null
UNION ALL    
SELECT c.ACCR2,c.ref,a.nls,a.kv,a.accc FROM CP_DEAL c, accounts a 
       WHERE ref=k0.ref and c.accr2 is not NULL and a.acc=c.accr2(+) and a.dazs is null
UNION ALL    
SELECT c.ACCS,c.ref,a.nls,a.kv,a.accc FROM CP_DEAL c, accounts a 
       WHERE ref=k0.ref and c.accs is not NULL and a.acc=c.accs(+) and a.dazs is null   
UNION ALL    
SELECT c.ACCR3,c.ref,a.nls,a.kv,a.accc FROM CP_DEAL c, accounts a 
       WHERE ref=k0.ref and c.accr3 is not NULL and a.acc=c.accr3(+) and a.dazs is null
UNION ALL    
SELECT c.ACCEXPN,c.ref,a.nls,a.kv,a.accc FROM CP_DEAL c, accounts a 
       WHERE ref=k0.ref and c.accexpn is not NULL and a.acc=c.accexpn(+) and a.dazs is null  
UNION ALL    
SELECT c.ACCEXPR,c.ref,a.nls,a.kv,a.accc FROM CP_DEAL c, accounts a 
       WHERE ref=k0.ref and c.accexpr is not NULL and a.acc=c.accexpr(+) and a.dazs is null  
UNION ALL    
SELECT c.ACCUNREC,c.ref,a.nls,a.kv,a.accc FROM CP_DEAL c, accounts a 
       WHERE ref=k0.ref and c.accunrec is not NULL and a.acc=c.accunrec(+) and a.dazs is null  
         order by ref,1)
loop

begin
  select ob22 into l_ob22 from accounts where acc=k.accc;
  if l_ob22 is not null then
     select F_GET_OB22(kv,nls) into l_ob22d from accounts where acc=k.acc;
     if l_ob22d is null then
        Accreg.setAccountSParam( k.acc, 'OB22', l_ob22 );
     end if;
  end if;
exception when NO_DATA_FOUND then null; l_ob22:=null;
  -- такого бути НЕ може
end;

begin
fl:=0;
select r011, r012, r013, r016, s080, s180, s580, s130 
into l_r011, l_r012, l_r013, l_r016, l_s080, l_s180, l_s580, l_s130
from specparam where acc=k.accc;
fl:=1;
exception when NO_DATA_FOUND then null;
l_r011:=null; l_r012:=null; l_r013:=null; l_r016:=null; 
l_s080:=null; l_s180:=null; l_s580:=null;
l_s130:=null;
end;

if fl=1 then  fl1:=0;

   begin
   select * into r_spec from specparam where acc=k.acc;
   exception when NO_DATA_FOUND then null;  r_spec:=null;
   end;

   --logger.info('CP_SPEC: upd '||k.nls||'/'||k.acc||' spec=...'||' ref='||k.ref);

   if l_r011 is not null  and r_spec.r011 is null then
      Accreg.setAccountSParam( k.acc, 'R011', l_r011);  fl1:=1;
   end if;
  
   if l_r012 is not null  and r_spec.r012 is null then
      Accreg.setAccountSParam( k.acc, 'R012', l_r012);  fl1:=1;
   end if;

   if l_r013 is not null  and r_spec.r013 is null then
      Accreg.setAccountSParam( k.acc, 'R013', l_r013);  fl1:=1;
   end if;

   if l_r016 is not null  and r_spec.r016 is null then
      Accreg.setAccountSParam( k.acc, 'R016', l_r016);  fl1:=1;
   end if;

   if l_s080 is not null  and r_spec.s080 is null then
      Accreg.setAccountSParam( k.acc, 'S080', l_s080);  fl1:=1;
   end if;

   if l_s130 is not null  and r_spec.s130 is null then
   Accreg.setAccountSParam( k.acc, 'S130', l_s130);     fl1:=1;
   end if;

   if l_s180 is not null  and r_spec.s180 is null then
      Accreg.setAccountSParam( k.acc, 'S180', l_s180);  fl1:=1;
   end if;

   if l_s580 is not null  and r_spec.s580 is null then
      Accreg.setAccountSParam( k.acc, 'S580', l_s580);  fl1:=1;
   end if;

   if fl1=1 then
      logger.info('CP_SPEC: upd '||k.nls||'/'||k.acc||' spec=...'||' ref='||k.ref);
   end if;

end if;

end loop;
end loop; -- k0

--commit;
logger.info('CP_SPEC: finish');
end; -- cp_spec
/

--grant execute on cp_spec to start1;

GRANT EXECUTE ON cp_spec TO bars_access_defrole;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/CP_SPEC.sql =========*** End *** =
PROMPT ===================================================================================== 
