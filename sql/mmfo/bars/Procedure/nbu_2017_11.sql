

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/NBU_2017_11.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  procedure NBU_2017_11 ***

  CREATE OR REPLACE PROCEDURE BARS.NBU_2017_11 ( p_okpo varchar2) is
 tt TEST_NBU_2017%rowtype;
 l_acc number;
 l_ref number;
 p_KF varchar2(6) := '322669';
begin   bars.bc.go(p_KF);

   delete from bars.TEST_NBU_2017 where branch like '/'||p_KF||'/%' and okpo = p_okpo ;

for xx in (select  rnk, okpo, substr(nmk,1,50) nmk from bars.customer where okpo = p_okpo)
loop tt.rnk := xx.rnk; tt.okpo := xx.okpo; tt.nmk := xx.nmk;

   select min (sdate) into tt.dat1 from bars.cc_deal where vidd in (1,2,3) and rnk = xx.rnk;
   if tt.dat1 is null then goto NNN;  end if;


   for aa in (select * from bars.accounts where rnk = xx.RNK and dapp is NOT null and nls not like '8%' 
              union all 
              select za.*  from bars.accounts za, bars.cc_accp w , bars.accounts sa 
              where za.rnk <> sa.rnk 
                and za.rnk <> xx.RNK and sa.rnk = xx.RNK
               and za.dapp is NOT null and za.nls like '9%' 
               and sa.dapp is NOT null                
               and w.acc = za.acc and w.accs = sa.acc  
             )
   loop tt.kv := aa.kv;     tt.nls := aa.nls;     tt.nms := substr(aa.nms,1,50); tt.branch := aa.branch; 
        tt.rnk2 := null; tt.okpo2 := null; tt.nmk2 := null; 

        If xx.rnk <> aa.rnk then   tt.rnk2 := aa.rnk;
           select okpo, substr(nmk,1,50) into  tt.okpo2 , tt.nmk2 from customer where rnk = aa.rnk;
        end if;

        select min(nd) into tt.nd from bars.nd_acc where acc = aa.acc;
        l_acc := trunc(aa.acc/100) ;

        for ss in (select * from bars.saldoa where acc= aa.acc and fdat >= tt.dat1 ) -- order by fdat
        loop tt.fdat := ss.fdat; tt.vx := ss.ostf ;  tt.dos := ss.dos; tt.kos := ss.kos; tt.ix := ss.ostf - ss.dos + ss.kos;

             for oo in (select ref,dk,s,tt from bars.opldok             where fdat = ss.fdat and acc =  ss.acc and sos = 5
              union all select ref,dk,s,tt from bars.opldok@MGRS_322669.GRC.UA where fdat = ss.fdat and acc =  l_acc  and sos = 5
                       ) -- order by ref, dk, s
             loop tt.tt := oo.tt ;  tt.ref := oo.ref; if oo.dk = 0 then tt.dd := oo.s ; tt.kk := 0 ; else tt.dd  := 0 ; tt.kk := oo.s ; end if;
                  begin select CASE WHEN nlsa = aa.nls and kv = aa.kv and mfoa = aa.kf THEN nlsb else nlsa end NLSB ,
                               CASE WHEN nlsa = aa.nls and kv = aa.kv and mfoa = aa.kf THEN mfob else mfoa end  MFOB , nazn
                        into tt.nlsb, tt.mfob , tt.nazn                        from bars.oper   where ref = oo.ref  ;
                  exception when no_data_found then                   l_ref := trunc ( oo.ref /100);
                     begin select CASE WHEN nlsa = aa.nls and kv = aa.kv and mfoa = aa.kf THEN nlsb else nlsa end NLSB ,
                                  CASE WHEN nlsa = aa.nls and kv = aa.kv and mfoa = aa.kf THEN mfob else mfoa end  MFOB  , nazn
                           into tt.nlsb, tt.mfob , tt.nazn                     from bars.oper@MGRS_322669.GRC.UA where ref = l_ref ;
                      exception when no_data_found then tt.mfob := null;  tt.nlsb := null;
                      end;
                   end;

                  insert into TEST_NBU_2017 values tt;

             end loop ; --oo  OPLDOK
        end loop ; --ss SALDOA
   end loop ; --aa ACCOUNTS

   <<NNN>> null;
end loop; -- xx customer;
end;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/NBU_2017_11.sql =========*** End *
PROMPT ===================================================================================== 
