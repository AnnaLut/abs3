

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_VPKLB.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_VPKLB ***

  CREATE OR REPLACE PROCEDURE BARS.P_VPKLB (
                p_date      date,
                p_sab       varchar2,
                p_okpo_kl   varchar2,
				p_nlsmask   varchar2
				) IS
--====================================================================
-- Module      : REP
-- Author      : ANNY
-- Description : Процедцра формирования в?писок на ТВБВ - Ощадбанк
-- Version     : v1.3  27-01-2009
--====================================================================

l_nlsk     oper.nlsb%type;
l_namk     oper.nam_b%type;
l_mfob     oper.mfob%type;
l_bankb    banks.nb%type;
l_idk      oper.id_b%type;
l_nazn     oper.nazn%type;
l_kv2      oper.nazn%type;
l_sab      customer.sab%type;
l_trace    varchar2(1000) := 'p_vpklb:';
l_search   smallint;
l_acc      number;
l_branch   branch.branch%type;

G_SEARCH_OPLDOK    constant smallint := 1;
G_SEARCH_OPER      constant smallint := 2;

begin

   delete from tmp_vpklb;

   -- найти значение SAB
   select sab into l_sab
   from branch_parameters p, customer c
   where p.branch = sys_context('bars_context','user_branch')
     and tag = 'RNK'
     and val = c.rnk;

   bars_audit.trace(l_trace||'формирование данных для выписки');


   bars_audit.trace(l_trace||'для текущего бранча '||sys_context('bars_context','user_branch')||' нашли sab='||l_sab);
   -- предполагается, что перед выполнением функи был установлен бранч через bars_xmlklb.pretend_branch
      for c in (select  a.acc, l_sab sab ,a.nls,substr(a.nms,1,38) nms,
  			         a.isp, s.ostf-s.dos+s.kos ost,   s.pdat, a.rnk, kv, dapp
             from  saldoa s, saldo a
             where  a.acc=s.acc and s.fdat = p_date
 			    and nls like replace(replace(p_nlsmask, '?', '_'), '*', '%')
				and a.tip not in ('N99','L99','N00','T00','T0D','TNB','TND','TUR','TUD','L00','T0B')
			) loop



     for opl  in (  select p.dk, o.s2, o.sq,
	                       p.s,  p.ref,
						   p.tt as tt_opl, o.tt as tt_opr,
						   o.nd,   o.vob, o.nazn, o.nlsa, o.mfoa, o.nam_a,
	                       o.nlsb, o.mfob, o.nam_b, o.id_b, o.id_a, p.stmt, p.txt, w.value ref_a,
						   o.datd, o.datp, sk, userid, vdat, kv2, kv,  o.sos
                 from   opldok p, oper o, operw w
                 where  p.ref=o.ref and p.acc=c.acc and p.fdat=p_date
				        and p.sos=5 and o.ref = w.ref(+)  and w.tag(+) = 'CLBRF') loop


                 --  Корресподнетна ищем по
                 --
                 --  1) opldok (p_serchk=1) - если счет в дочерней операции ИЛИ счет не участует  в главной операции ИЛИ платеж внутренний
                 --  2) oper   (p_serchk=2) - (если счет в дочерней операции ИЛИ счет не участует  в главной операции)  И  если между разными бранчами
                 --  3) oper   (p_serchk=2) - иначе 
                 --
                 
                 
                 -- счет в дочерней операции ИЛИ счет не участует  в главной операции ИЛИ платеж внутренний
                 -- 
				 if (    (opl.tt_opr<>opl.tt_opl)
				      or (c.nls <> opl.nlsb and c.nls <> opl.nlsa)
				    ) then
                     l_search := G_SEARCH_OPLDOK;
                 else
                     l_search := G_SEARCH_OPER;  
                 end if;      
                       
                       

                 case l_search 
                      when G_SEARCH_OPLDOK then
                           begin
                              l_nazn:=opl.txt;
                              select a.nls,substr(a.nms,1,38), bars_context.extract_mfo(a.branch), c.okpo, a.kv
   	                          into l_nlsk, l_namk, l_mfob, l_idk, l_kv2
                              from opldok o, accounts a, customer c
          	                  where  a.acc = o.acc  and o.ref  = opl.ref
					            and  o.tt = opl.tt_opl and o.s   =  opl.s     and o.stmt = opl.stmt
							    and  c.rnk = a.rnk and o.dk = (1-opl.dk);
                           exception when no_data_found then                          
                              bars_audit.error(l_trace||' G_SEARCH_OPLDOK: не найдены данные для стороны B по реквизитам: dk='||(1-opl.dk)||' stmt='||opl.stmt||' tt='||opl.tt_opl||' s='||opl.s  );
                              raise;
                           end;
                      when G_SEARCH_OPER then
                           l_nazn:=opl.nazn;
                           if (c.nls = opl.nlsa and c.kv=opl.kv)  then
                              l_nlsk:= opl.nlsb;
						      l_namk:= opl.nam_b;
						      l_mfob:= opl.mfob;
						      l_idk := opl.id_b;
						      l_kv2 := opl.kv2;
                           end if;
					       if (c.nls = opl.nlsb and c.kv=opl.kv2)  then
                              l_nlsk:= opl.nlsa;
						      l_namk:= opl.nam_a;
						      l_mfob:= opl.mfoa;
 					          l_idk:=  opl.id_a;
   					          l_kv2 := opl.kv;
					       end if;
                       else 
                          bars_error.raise_error('KLB', 112, to_char(l_search) );
                       end case;
                 
					 
                 select nb into l_bankb from banks where mfo=l_mfob;

                 insert into tmp_vpklb(
                        acc,   nls,  kv,   nms,   nlsk,   namk,   mfo,    nb,      okpo,
                        s,     nd,     nazn,  vdat,       userid,
		                ref,      sk,   dapp,   datp,    ost,     vob,         fdat,
                        kv2, dk, sab,  tt, s2, sq, pond, sos  )
                 values  (c.acc, c.nls, c.kv, c.nms, l_nlsk, l_namk, l_mfob, l_bankb,  l_idk,
			           opl.s, opl.nd, l_nazn, opl.vdat,  opl.userid,
					   opl.ref,  opl.sk, c.dapp, opl.datp, c.ost, opl.vob,  p_date,
					   l_kv2, opl.dk, c.sab, opl.tt_opl, opl.s2, opl.sq, opl.ref_a, opl.sos);

	end loop;  --opl
   end loop; -- sal



 for c in (  select w.value as ref_a,
                     o.sos, o.vdat,
					 wb.value as blk_val
              from oper o, operw w, operw wb, operw ws
              where  o.vdat = p_date  AND o.sos < 0
					 and o.ref  = w.ref  and w.tag  = 'CLBRF'
					 AND o.ref  = wb.ref and wb.tag = 'BACKR'
					 and o.ref  = ws.ref and ws.tag = 'CLBSB' and ws.value = l_sab) loop

          insert into TMP_vpklb( sab,    sos,   blk_msg, pond, fdat)
                 values        (l_sab, c.sos, c.blk_val, c.ref_a, c.vdat);
  end loop;


END  p_vpklb; 
 
/
show err;

PROMPT *** Create  grants  P_VPKLB ***
grant EXECUTE                                                                on P_VPKLB         to JBOSS_USR;
grant EXECUTE                                                                on P_VPKLB         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_VPKLB.sql =========*** End *** =
PROMPT ===================================================================================== 
