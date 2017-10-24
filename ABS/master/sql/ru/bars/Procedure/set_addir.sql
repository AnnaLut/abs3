

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/SET_ADDIR.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  procedure SET_ADDIR ***

  CREATE OR REPLACE PROCEDURE BARS.SET_ADDIR (p_nd number, p_sour number) is
  -- Установить доп.реквизит КД 'ADDIR','Дополнительная ставка к базовой источника',
  uu cc_source%rowtype;
  l_acc8 number;
  l_kv   number;
  l_irb  number;
  l_ir   number;
  l_ir1  number;
  l_tag  nd_txt.tag%type :=  'ADDIR' ;
  l_txt  nd_txt.txt%type ;
begin

  -- Есть ли данный КД с плавающей ставкой В принципе ?
  begin
     select u.* into uu from cc_source u where u.sour = p_sour and u.br is not null and u.N_MON is not null ;
     select a.acc, a.kv into l_acc8, l_kv from accounts a, nd_acc n where a.tip='LIM' and a.acc=n.acc and n.nd = p_nd ;
  EXCEPTION WHEN NO_DATA_FOUND THEN RETURN ;
  end;

  -- Узнать значение % базовой
  begin
     SELECT RATE  INTO l_irb  FROM BR_NORMAL b  WHERE  b.kv=l_KV and  b.BR_ID=uu.BR and  b.BDATE =
               (select max(bb.BDATE) from BR_NORMAL bb where bb.kv=l_KV and bb.BR_ID=uu.BR and bb.bdate<= gl.bdate);
  EXCEPTION WHEN NO_DATA_FOUND THEN RETURN ;
  end;

  -- Узнать значение % по КД
  l_ir  := acrn.fprocn ( l_acc8, 0, gl.bdate);

  If uu.ir_max > 0  and  l_ir > 0   and   l_ir > uu.ir_max then
    raise_application_error( -(20203),
   '\8999 Set_pmt_instructions: Реф.КД '|| p_ND || ' % ст бiльше допустимої' || SQLERRM,  TRUE );
  end if;

  -- Расчитать собственную ставку банка по КД
  l_ir1 := nvl(l_ir,0) - nvl(l_irb,0);

  -- Сформировать доп.реквизит
  If l_ir1 >= 0 then
     l_txt := to_char(l_ir1);
     update nd_txt set txt = l_txt where nd = p_nd and tag = l_tag ;
     if SQL%rowcount = 0 then
       insert into nd_txt (nd, tag, txt) values (p_nd, l_tag, l_txt);
    end if;
    -- мутант ! cck_app.Set_ND_TXT (p_ND=>p_nd, p_TAG => l_tag ,p_TXT => l_txt );
  end if;
end set_ADDIR;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/SET_ADDIR.sql =========*** End ***
PROMPT ===================================================================================== 
