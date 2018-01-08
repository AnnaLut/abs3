

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/ELT_REG_EX.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  procedure ELT_REG_EX ***

  CREATE OR REPLACE PROCEDURE BARS.ELT_REG_EX (p_mode IN     INTEGER,
                     p_nd    IN     E_DEAL$BASE.ND%type,
                     p_rnk   IN     CUSTOMER.RNK%type,
                     p_nls   IN OUT VARCHAR2,
                     p_acc26 in     accounts.acc%type,
                     p_isp   IN     INT)
IS
-- ** ver 1.9  14/07-17

l_nls26 accounts.nls%type;
l_nls35 accounts.nls%type;
l_nms   accounts.nms%type;
l_isp   accounts.isp%type;
l_grp   accounts.grp%type;
l_acc35 accounts.acc%type;
l_ob22  accounts.ob22%type;
l_id    e_tarif.id%type;
l_ndf   e_DEAL$base.nd%type;
l_mask  nlsmask.mask%type;
l_Tobo  accounts.tobo%type;
l_mfo   bank_acc.mfo%type;
l_acc35f accounts.acc%type;
l_nls35f accounts.nls%type;
l_ob22f  accounts.ob22%type;
l_ret   number;
fl      int;
l_nn number; l_nns varchar2(2);  l_pos int;
l_rnk accounts.rnk%type;

pap_   ps.pap%type;

BEGIN

logger.info ('elt: nd ='||p_nd||',rnk='||p_rnk||',nls='||p_nls);

SELECT nls, isp, grp, tobo, mfo INTO l_nls26, l_isp, l_grp, l_Tobo, l_mfo
   FROM accounts a, bank_acc b WHERE a.acc=p_acc26 and a.acc=b.acc(+);

l_isp := p_isp;  --user_id;

l_ob22 :='02';

  begin
  select id into l_id from e_tar_nd where nd=p_nd and rownum=1;
  EXCEPTION  WHEN NO_DATA_FOUND then null;  l_id:=null;
  end;

  if l_id is not null then
  select nvl(F_GET_ELT_OB22 (l_id,'3570'),'02') into l_ob22 from dual;
  else l_ob22:='02';
  end if;

logger.trace ('elt: nd ='||p_nd||',id='||l_id||',ob22='||l_ob22);

SELECT to_char(BARS.F_NEWNLS2(NULL,'ELT','3570',p_RNK,NULL,NULL,NULL))
       into l_nls35 from dual;

select mask into l_mask from nlsmask where maskid='ELT';

--l_mask := Replace( l_mask, 'RRRRR', substr(p_rnk,-5));
-- !! доробити обробку  R  -  по кiлькостi знакiв

l_pos :=INSTR(l_mask,'NN');
--logger.info ('elt: nd ='||p_nd||',mask='||l_mask||',pos_NN='||l_pos);
logger.info ('elt: nd ='||p_nd||',nls35='||l_nls35||',mask='||l_mask||',pos_NN='||l_pos);

if l_pos > 0 then
l_nns:=substr(l_nls35,l_pos,2);
l_nn:=to_number(l_nns);
end if;

l_mask:=l_nls35;

l_nn:=01; l_nns:='01';  -- temp otladka

l_mask:=substr(l_mask,1,l_pos-1)||l_nns||substr(l_mask,l_pos+2);

fl:=0;

while (fl=0)
loop

  l_nls35 := VKRZN (SUBSTR (gl.AMFO, 1, 5), l_mask);
  logger.info ('elt: nd ='||p_nd||',mask='||l_mask);

  begin
    select acc, nls, ob22
    into  l_acc35f, l_nls35f, l_ob22f
    from accounts where nls=l_nls35;     -- and rnk=p_rnk  and dazs is null;

        --jeka begin 12.07.2017 не понимаю зачем это. убрал (Проблема в том, что если уже есть такой счет, на нашем контрагенте, тот же об22, но нет договора, то не пересчитывается)

        /*if l_ob22f != l_ob22 then null;
           l_nn:=l_nn+1;
           l_nns:=lpad(to_char(l_nn),2,'0');
           l_mask:=substr(l_mask,1,l_pos-1)||l_nns||substr(l_mask,l_pos+2);
        else
        begin
        select nd into l_ndf from e_deal_meta
        where nls36=l_nls35 and rownum=1;     -- and nls26!=l_nls26;
           l_nn:=l_nn+1;
           l_nns:=lpad(to_char(l_nn),2,'0');
           l_mask:=substr(l_mask,1,l_pos-1)||l_nns||substr(l_mask,l_pos+2);
           l_nls35 := VKRZN (SUBSTR (gl.AMFO, 1, 5), l_mask);
        fl:=0;
        EXCEPTION  WHEN NO_DATA_FOUND then null;
        fl:=1;
        end;
        end if;*/

       --всегда подбираем новый счет, если захотят оставить старый, то можно просто вставить в интерфейсе
       l_nn:=l_nn+1;
       l_nns:=lpad(to_char(l_nn),2,'0');
       l_mask:=substr(l_mask,1,l_pos-1)||l_nns||substr(l_mask,l_pos+2);
       --jeka end 12.07.2017

  EXCEPTION  WHEN NO_DATA_FOUND then null;
  fl:=1;
  end;

end loop;

-- l_nls35 := VKRZN (SUBSTR (gl.AMFO, 1, 5), l_nls35); --jeka  12.07.2017



begin

select 'Абонплата ' || substr(c.nmk, 1, 38) into l_NMS FROM customer c where c.rnk = p_rnk;
--SELECT Substr(F_NEWNMS (Null,'ELT',Null,p_RNK,Null),1,70) INTO l_NMS FROM dual;

end;

  OP_REG_EX (9, 0, 0, l_grp, l_ret, p_RNK, l_nls35, 980, l_NMS, 'ODB', l_isp, l_acc35, 1);

  logger.info ('elt: nd ='||p_nd||',acc='||l_acc35||',nls='||l_NLS35||' opened');


   UPDATE accounts  SET pap = 1, ob22=l_ob22   WHERE acc = l_acc35;

 begin
    insert into specparam (acc,r013,s180,s240)
    values (l_acc35,'2','1','1');
 exception when dup_val_on_index then NULL;
           when others then NULL;
 end;

 --UPDATE Specparam set s240 = '1', s180 = '1', r013='2' where acc=l_acc35;

 -- UPDATE bank_acc set mfo = :sPmfo where acc=l_acc35;
 -- INSERT into bank_acc (acc, mfo) values (l_acc35, :sPmfo)


   p_setAccessByAccMask(l_acc35,p_ACC26);

  SEC.addagrp(l_acc35,l_Grp);

  update e_deal$base set acc36=l_acc35 where nd=p_nd;


END elt_reg_ex;
/
show err;

PROMPT *** Create  grants  ELT_REG_EX ***
grant EXECUTE                                                                on ELT_REG_EX      to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/ELT_REG_EX.sql =========*** End **
PROMPT ===================================================================================== 
