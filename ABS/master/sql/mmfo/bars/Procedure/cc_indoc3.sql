

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/CC_INDOC3.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  procedure CC_INDOC3 ***

  CREATE OR REPLACE PROCEDURE BARS.CC_INDOC3 (P_NLS VARCHAR2,P_KV NUMBER, P_NLS2 VARCHAR2,P_KV2 NUMBER , P_S number, typ VARCHAR2) IS
tmpVar NUMBER;
l_access_user number;
l_rep_id number;
REF_   int ;
l_FL38 int;


BEGIN
-- Узнаем наличие доступу у пользователя до основной  автоматической функции
l_rep_id:=  to_number(   PUL.GET_MAS_INI_VAL ('cc_reports_id' ) );

select max (o.codeoper)
   into l_access_user
  from operlist o, applist a, operapp oa, applist_staff af
where O.CODEOPER=l_rep_id and O.CODEOPER = OA.CODEOPER
          and OA.CODEAPP= A.CODEAPP and OA.APPROVE=1 and (nvl(OA.ADATE2,gl.bd)>=gl.bd)
          and af.id=user_id  and af.CODEAPP =oa.CODEAPP and af.APPROVE=1 and  (nvl(af.ADATE2,gl.bd)>=gl.bd);

-- Если пользователь сможет создать проводки в будущем пишем факт удаления в журнал
 if l_access_user>1 and typ ='DELETE' then
    logger.info ('CCK: Автоматичний документ  '||P_NLS||'('||to_char(P_KV)||') '|| P_NLS2||'('||to_char(P_KV2)||') - видален');
    delete from tmp_cck_rep where nlsa=P_NLS and kv= P_KV and nlsb= P_NLS2 and kv2= P_KV2;
 end if;


if l_access_user=0 then
   logger.info ('CCK: Користувач  '||user_id||' спробував створити документи по автоматичній функції '||to_char(l_rep_id)||'до якої не має доступу ');
elsif l_access_user>1 and typ ='EXECUTE' then

   for p in (select t.rowid,t.*, aa.nms nmsd,  a2.nms nmsk, ca.okpo, cb.okpo okpo2
                  from tmp_cck_rep t,  accounts aa, accounts a2, customer ca, customer cb
                where t.nlsa=AA.NLS and t.kv=aa.kv and t.nlsb=A2.NLS and t.kv2=a2.kv and aa.rnk=ca.rnk  and a2.rnk=cb.rnk and t.tt in ('ASP','CR9')

              )
   loop

    if l_FL38 is null then
      select nvl(to_number(substr(flags,38,1)),0) into l_FL38 from tts where tt=p.tt;
    end if;

        begin
      GL.REF (REF_);

      GL.IN_DOC3 ( REF_,  p.tt,   p.vob,  REF_, SYSDATE,GL.BDATE,       p.dk,      P.KV,     p.S,   P.KV2,    p.S2,   null,GL.BDATE,GL.BDATE,
                           substr(p.nmsd,1,38),  p.nlsa, gl.AMFO, substr(p.nmsk,1,38), P.NLSB,gl.AMFO, p.NAZN,  NULL, p.OKPO, p.OKPO2,  null,   null, 0, null, null);

      GL.PAYV(L_FL38,REF_,GL.BDATE,p.tt,p.dk,P.KV,p.NLSA,p.S,P.KV,P.NLSB,p.S2);
      exception when others then
       logger.info (SQLERRM);
      end;

      delete from tmp_cck_rep where rowid=p.rowid;

      if  p.tt='ASP'  then
         update cc_deal set sos = 13 where nd =  p.ND;
      end if;

   end loop;
 commit;
end if;
END cc_indoc3;
/
show err;

PROMPT *** Create  grants  CC_INDOC3 ***
grant EXECUTE                                                                on CC_INDOC3       to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on CC_INDOC3       to RCC_DEAL;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/CC_INDOC3.sql =========*** End ***
PROMPT ===================================================================================== 
