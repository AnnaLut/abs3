

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/K23_DEF.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  procedure K23_DEF ***

  CREATE OR REPLACE PROCEDURE BARS.K23_DEF 
(p_fin23  IN  int,
 p_obs23  IN  int,
 p_cus    IN  int,
 p_nd     IN  number,
 p_rnk    IN  number,
 p_KAT23  OUT int,
 p_k23    OUT number,
 p_tip    varchar2 default 'CCK')  is
--------------------------
/*
 Список параметров для AWK.exe или  AW.bat
 -- WEB Установлен ВЕБ-модуь "Фин-Стан"
 вызов:
 AWK 06_3_k23_def.sql 06_3_k23_def.prc      |-- для Демарка, ....,  и Пертоком(но у них д.б. установленв ВЕБ)
 AWK 06_3_k23_def.sql 06_3_k23_def.web WEB  |-- для ОБ(в т.ч. ГОУ) Надра УПБ
*/

--     Установлен ВЕБ-модуь "Фин-Стан"

 l_k23   number; l_k23_  number;
 l_VNCRR int   ; l_KHIST int   ;      p_grp   NUMBER; nd_   NUMBER;
 l_NEINF int   ; l_VN2   varchar2(2); nbs_    varchar2(4);
 err_ int           ; err_text_ varchar2(2000);
 p_vnkr varchar2(5);

begin

  if nvl(p_fin23,0) = 0 or
     nvl(p_obs23,0) = 0 or
     nvl(p_cus,0) not in (1,2,3,4,5) then
     return;
  end if;
  logger.info ('k23_def 77 p_cus='||p_cus );
  ----------------------------------------------
  --по умолчательной методике ПЕТРОКОМ(ЮЛ) + она же ОЩАДБАНК (ФЛ)
  begin
     select kat into p_kat23 from FIN_OBS_KAT 
     where fin = p_fin23  and obs = p_obs23 and cus = decode(p_cus,5,1,p_cus) ;
     select k   into l_k23   from stan_kat23  where kat = p_kat23;
  EXCEPTION WHEN NO_DATA_FOUND THEN   return;
  end;
  -------------------------------------

  If p_cus in (1, 5) and p_ND is NOT null then
     -- методика ОБ с применением доп.реквизитов
     -- цикл всегда возвращает одну строку по сответствующему фин. стану и облуживанию долга
     --
     --   l_VNCRR_ORD
 --    begin
        -- определение кредит или коррсчета
        -- ищем в договорах (если нет, переопределяем NBS_ для коррсчетов)
 --       select nd into nd_ from cc_deal where nd=p_nd and rnk=p_rnk;
 --    EXCEPTION WHEN NO_DATA_FOUND THEN nbs_:=null;
     if p_cus=5 THEN
        -- не МБК - значит коррсчета
       /* begin
           select nbs into nbs_ from accounts where acc=p_ND;
        EXCEPTION WHEN NO_DATA_FOUND THEN return;
        end;

        logger.info ('k23_def 2 nbs_='||nbs_ );*/
     --   if nbs_ in ('1500', '1502', '1508', '1509') THEN

           begin
              select g.kat,1 into p_kat23,p_grp
              from customer c,tmp_grp_kat g,country co
              where rnk=p_rnk and c.country=co.country and co.grp=g.grp and c.country<>804;
           EXCEPTION WHEN NO_DATA_FOUND THEN p_grp:=0;
           end;
           if p_grp=1 THEN
              p_kat23:=greatest(p_kat23,p_obs23);
              for ob in (select B.FIN, B.OBS, R.ORD VNCRR, B.KHIST,B.NEINF,
                                B.KAT23, B.K23, S.k_max K3
                         from TMP_OB_KORR B, (select code,ord,min,max,i_min,i_max from CCK_RATING
                                              union all
                                              select 'Д' ,41,null,null,null,null from dual)  R , stan_kat23 S
                         where b.fin=decode(p_kat23,1,0,5,0,p_fin23) and B.kat23=p_kat23 and s.kat=p_kat23 and
                               R.code=decode(p_kat23,1,'Д',5,'Д',B.VNCRR) )
              loop
                 p_kat23:=ob.kat23;
                 begin
                    select r.ord  into l_VNCRR from nd_txt t,CCK_RATING r 
                    where t.nd = p_nd and t.tag = 'VNCRR' and r.code=t.txt;
                    --   select substr(trim(value),1,4) into l_VNCRR from accountsw 
                    --   where acc = p_nd and tag = 'VNCRR';
                 EXCEPTION WHEN NO_DATA_FOUND THEN   return;
                 end;
                 if  l_VNCRR<=ob.VNCRR then
                     begin
                        select decode(p_kat23,1,0,5,0,to_number (txt))  into  l_KHIST from nd_txt 
                        where nd = p_nd and tag = 'KHIST';
                        logger.info ('k23_def 6 l_KHIST='||l_KHIST );
                     EXCEPTION WHEN NO_DATA_FOUND    THEN  l_KHIST := null;
                     end;
                     begin
                        select decode(p_kat23,1,0,5,0,to_number (txt))  into  l_NEINF from nd_txt 
                        where nd = p_nd and tag = 'NEINF';
                        logger.info ('k23_def 8 l_NEINF='||l_NEINF );
                     EXCEPTION WHEN NO_DATA_FOUND    THEN  l_NEINF := null;
                     end;
                     if  l_KHIST<=ob.KHIST and l_NEINF<= ob.NEINF then
                         p_k23:=ob.K23;
                     else
                         IF p_fin23=5 then
                            p_k23:=ob.K3;
                         else
                            begin
                               select B.K23 into p_k23
                               from TMP_OB_KORR B
                               where b.fin=p_fin23+1 and B.kat23=p_kat23;
                            EXCEPTION WHEN NO_DATA_FOUND    THEN  null;
                            end;
                         end if;

                     end if;
                 else
                    p_k23:=ob.K3;
                 end if;
              end loop;
              return;

           else

              for ob in (select B.FIN, B.OBS, R.ORD VNCRR, B.KHIST, B.NEINF, B.KAT23, B.K23, S.k_max K3
                         from TMP_OB_KORR B, (select code,ord,min,max,i_min,i_max from CCK_RATING
                                              union all
                                              select 'Д' ,41,null,null,null,null from dual) R , stan_kat23 S
                         where B.obs=p_obs23 and B.fin=decode(p_obs23,1,0,5,0,p_fin23) 
                               and R.code=decode(p_obs23,1,'Д',5,'Д',B.VNCRR) and B.kat23=s.kat)
              loop
                 p_kat23:=ob.kat23;
                 begin
                    select r.ord  into l_VNCRR from nd_txt t,CCK_RATING r 
                    where t.nd = p_nd and t.tag = 'VNCRR' and r.code=t.txt;
                 EXCEPTION WHEN NO_DATA_FOUND THEN   return;
                 end;
                 if  l_VNCRR<=ob.VNCRR then
                     begin
                        select decode(p_obs23,1,0,5,0,to_number (txt))  into  l_KHIST from nd_txt 
                        where nd = p_nd and tag = 'KHIST';
                        logger.info ('k23_def 6 l_KHIST='||l_KHIST );
                     EXCEPTION WHEN NO_DATA_FOUND    THEN  l_KHIST := null;
                     end;
                     begin
                        select decode(p_obs23,1,0,5,0,to_number (txt))  into  l_NEINF from nd_txt 
                        where nd = p_nd and tag = 'NEINF';
                        logger.info ('k23_def 8 l_NEINF='||l_NEINF );
                     EXCEPTION WHEN NO_DATA_FOUND    THEN  l_NEINF := null;
                     end;
                     if  l_KHIST<=ob.KHIST or l_NEINF<= ob.NEINF then
                         p_k23:=ob.K23;
                     end if;
                 else
                    p_k23:=ob.K3;
                 end if;
              end loop;
              return;
           end if;
        end if;
    -- end if;
     -- МБК
     for ob in (select B.FIN, B.OBS, R.ORD VNCRR, B.KHIST, B.NEINF, B.KAT23, B.K23, B.K2, S.k_max K3
                  from REZ_OB_BANKS B, CCK_RATING R , stan_kat23 S
                 where B.obs=p_obs23 and B.fin=p_fin23 and R.code=B.VNCRR  and B.kat23=s.kat)
     loop

        -- ищем вн. кред рейтинг
        begin
           select r.ord  into l_VNCRR from nd_txt t,CCK_RATING r 
           where nd = p_nd and tag = 'VNCRR' and r.code=t.txt;
        EXCEPTION WHEN NO_DATA_FOUND THEN   l_VNCRR:=41;
        end;

        -- Если вн. кред рейтинг не удовлетворяет устанавливаем минимальный по НБУ
        if  l_VNCRR<=ob.VNCRR then
            -- вычитываем суб. показатели
            begin
               select to_number (txt)        into  l_KHIST from nd_txt where nd = p_nd and tag = 'KHIST';
            EXCEPTION WHEN NO_DATA_FOUND    THEN  l_KHIST := null;
            end;
            begin
               select to_number (txt)        into  l_NEINF from nd_txt where nd = p_nd and tag = 'NEINF';
            EXCEPTION WHEN NO_DATA_FOUND    THEN  l_NEINF := null;
            end;
            -- Если хотя бы один есть выбираем стандартный показатель иначе  K2 - ухудшенный
            if  l_KHIST<=ob.KHIST or l_NEINF<= ob.NEINF then
                l_k23:=ob.K23;
            else
                l_k23:=ob.K2;
            end if;
        else
            -- внутренний рейтинг не удовлетворяет выбираем худший коэф. по НБУ
            l_k23:=ob.K3;
        end if;

     end loop;
  end if;

  p_k23   := l_k23  ;
 
  if p_tip = 'OW4' 
       then   p_vnkr := nvl(bars_ow.get_nd_param(p_nd, 'VNCRR'),'Д');
       else   p_vnkr := nvl(cck_app.get_nd_txt(p_nd, 'VNCRR'),'Д');
  end if; 
    
   if p_cus = 2 and p_rnk is not null and p_nd is not null  then

      fin_zp.calculation_ZPRK( rnk_   => p_rnk,
                               nd_    => p_nd ,
                               DAT_   => trunc(gl.bd, 'Q') ,
                               fin23_ => p_fin23           ,
                               obs23_ => p_obs23           ,
                               kat23_ => p_kat23           ,
                               vncr_  => p_vnkr,
                             Err_Code => Err_,
                          Err_Message => Err_text_,
                     prk_ => l_k23_
                              );

      p_k23   := nvl(l_k23_,l_k23);
   end if;
   if p_cus = 3 and p_rnk is not null and p_nd is not null  then

      fin_zp.calculation_ZPRK_FL( rnk_   => p_rnk,
                               nd_    => p_nd ,
                               DAT_   => trunc(gl.bd) ,
                               fin23_ => p_fin23           ,
                               obs23_ => p_obs23           ,
                               kat23_ => p_kat23           ,
                               vncr_  => p_vnkr,
                             Err_Code => Err_,
                          Err_Message => Err_text_,
                     prk_ => l_k23_
                              );

      p_k23   := nvl(l_k23_,l_k23);
   end if;

     if p_cus = 4 and p_rnk is not null and p_nd is not null  then

      fin_zp.calculation_ZPRK_bd( rnk_   => p_rnk,
                               nd_    => p_nd ,
                               DAT_   => trunc(gl.bd) ,
                               fin23_ => p_fin23           ,
                               obs23_ => p_obs23           ,
                               kat23_ => p_kat23           ,
                               vncr_  => p_vnkr,
                               Err_Code => Err_,
                               Err_Message => Err_text_,
                               prk_ => l_k23_
                              );

      p_k23   := nvl(l_k23_,l_k23);
   end if;


end k23_def;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/K23_DEF.sql =========*** End *** =
PROMPT ===================================================================================== 
