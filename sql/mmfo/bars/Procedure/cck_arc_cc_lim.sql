

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/CCK_ARC_CC_LIM.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  procedure CCK_ARC_CC_LIM ***

  CREATE OR REPLACE PROCEDURE BARS.CCK_ARC_CC_LIM (P_DAT date,P_ND int ) is
-- 28-09-2015 LUDA Добавлен архив (ND_ACC) Связка договоров и счетов'
-- 03-07-2015 LUDA Добавлен архив траншей
-- наполнение таблицы архива ГПК
-- P_DAT -  Банковский день
-- P_ND   реф договора - замена и добавление
--
--        0 - По всем договорам
--            В последний БАНКОВСКИЙ день производит перенаполнение ГПК на 01 число
--            следующего месяца.  С 1 по 10 донаполнение (как страховочное).
--            В остальные дни ничего
--           (Выполняется на финише дня)
--        1 - По всем договорам
--            При P_DAT от 11 до 31 производит перенаполнение ГПК на 01 число
--            следующего месяца.  С 1 по 15 донаполнение (как страховочное)
--            Выдается пользователям


l_dat01 date;
l_change_month int:=0;
title constant varchar2(32) := 'zbd.cck_arc_cc_lim ';
l_error_message varchar2(4000);
begin
   logger.tms_info( title||'Start КП F6_FD: збереження актуальних ГПК на звітну дату');

   -- если последний БАНКОВСКИЙ день или первые 10 дней выполняем процедуру иначе выходим return
   -- LOCK TABLE HR.EMPLOYEES IN EXCLUSIVE MODE;
   if to_char(CCK.CORRECTDATE(980,P_DAT+1,P_DAT+2),'MM')!=to_char(P_DAT,'MM') then
      l_change_month:=1;
   end if;

   dbms_output.put_line ('change='||to_char(l_change_month));

   if l_change_month=0 and to_number(to_char(P_DAT,'DD'))>10 and P_ND=0 then
      return;
   end if;
   -- ищим первое число  ( если ввести дату 31.10.2012 или 01.11.2012 все равно будут сохр ГПК mdate=  01.11.2012)
   if  to_number(to_char(P_DAT,'dd')) between 1 and 10 then
      l_dat01:=trunc(P_DAT,'MM');
   else
      l_dat01:=trunc(ADD_MONTHS(P_DAT,1),'MM');
   end if;

   dbms_output.put_line ('l_dat01='||to_char(l_dat01,'ddmmyyyy'));
   -- Перенаполняем ГПК если:
   -- по одному договору
   -- по функции вызваной вручную
   -- в последный банковский день месяца
   if p_nd>0 or l_change_month=1 or (P_ND=-1 and to_number(to_char(P_DAT,'dd')) between 11 and 31  )   then
      delete from cc_lim_arc l where  l.mdat=l_dat01 and p_nd in (0,-1,l.ND);
      dbms_output.put_line ('delete');
   end if;

   -- производим вставку ГПК которых нет в архиве на отчетную дату  (Донаполняем).
   insert into cc_lim_arc (ND,MDAT,FDAT,LIM2,ACC,NOT_9129,SUMG,SUMO,OTM,SUMK,NOT_SN)
   select l.ND,l_dat01,l.FDAT,l.LIM2,l.ACC,l.NOT_9129,l.SUMG,l.SUMO,l.OTM,l.SUMK,l.NOT_SN
   from cc_lim l
   where not exists (select 1 from cc_lim_arc cl
                     where cl.mdat= l_dat01 and rownum=1) and p_nd in (0,-1,l.ND);

   -- архив траншей
   insert into cc_trans_arc (NPP,REF,ACC,FDAT,SV,SZ,D_PLAN,D_FAKT,DAPP,REFP,COMM,ID0,mdat)
   select t.NPP,t.REF,t.ACC,t.FDAT,t.SV,t.SZ,t.D_PLAN,t.D_FAKT,t.DAPP,t.REFP,t.COMM,t.ID0,l_dat01
   from cc_trans t
   where not exists (select 1 from cc_trans_arc cl where cl.mdat= l_dat01 and rownum=1);

   -- архив ND_ACC
   insert into nd_acc_arc (nd,acc,mdat)
   select n.nd,n.acc,l_dat01 from nd_acc n
   where not exists (select 1 from nd_acc_arc cl where cl.mdat= l_dat01 and rownum=1);

   commit;
   
 logger.tms_info( title||'Finish КП F6_FD: збереження актуальних ГПК на звітну дату');
	 
exception when others 
	then 
		l_error_message := substr(sqlerrm||dbms_utility.format_error_backtrace(), 1, 4000);
    logger.tms_error( title||'exception: '|| chr(10) ||l_error_message);	 	 
end;
/
show err;

PROMPT *** Create  grants  CCK_ARC_CC_LIM ***
grant EXECUTE                                                                on CCK_ARC_CC_LIM  to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on CCK_ARC_CC_LIM  to RCC_DEAL;
grant EXECUTE                                                                on CCK_ARC_CC_LIM  to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/CCK_ARC_CC_LIM.sql =========*** En
PROMPT ===================================================================================== 
