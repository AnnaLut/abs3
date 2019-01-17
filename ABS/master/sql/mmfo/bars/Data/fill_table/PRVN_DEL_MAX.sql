insert into PRVN_DEL_MAX ( KF , DEL_SDF, DEL_SDM , DEL_SDI ,DEL_SDA, DEL_SNA , DEL_SRR, DEL_REZ_SUM, DEL_REZ_PRC )
select x.kf, 
            MAX( x.B1-a.SDF ) DEL_SDF,
            MAX( x.B3-a.SDM ) DEL_SDM,
            MAX( x.B5-a.SDI ) DEL_SDI, 
            MAX( x.B7-a.SDA ) DEL_SDA, 
            MAX( x.A9-a.SNA ) DEL_SNA, 
            MAX( x.I9-a.SRR ) DEL_SRR,
           (select SUM(fv_abs) from prvn_osaq where kf = x.kf) DEL_REZ_SUM,
           (select decode(sum(rezb+rez9),0,0,(round(sum(fv_abs)*100/sum(rezb+rez9),4))) from prvn_osaq where kf = x.kf) DEL_REZ_PRC
From (select aa.KF, nn.ND, aa.KV, 
            NVL ( sum ( decode ( aa.tip,'SDF', gl.p_icurval(aa.kv,aa.ostc,sysdate) ) ), 0 ) SDF, 
            NVL ( sum ( decode ( aa.tip,'SDM', gl.p_icurval(aa.kv,aa.ostc,sysdate) ) ), 0 ) SDM, 
            NVL ( sum ( decode ( aa.tip,'SDI', gl.p_icurval(aa.kv,aa.ostc,sysdate) ) ), 0 ) SDI, 
            NVL ( sum ( decode ( aa.tip,'SDA', gl.p_icurval(aa.kv,aa.ostc,sysdate) ) ), 0 ) SDA, 
            NVL ( sum ( decode ( aa.tip,'SNA', gl.p_icurval(aa.kv,aa.ostc,sysdate) ) ), 0 ) SNA, 
            NVL ( sum ( decode ( aa.tip,'SRR', gl.p_icurval(aa.kv,aa.ostc,sysdate) ) ), 0 ) SRR
      from nd_acc nn, accounts aa  
      where aa.acc = nn.acc and aa.tip in ( 'SDF', 'SDM', 'SDI', 'SDA', 'SNA', 'SRR' )  
        and aa.kf = nn.kf and aa.kf not in (select kf from PRVN_DEL_MAX )   
      group by aa.kf, nn.ND, aa.KV   
     ) A,
     (select kf,nd,KV, NVL ( gl.p_icurval(kv,Round(b1      *100,0),sysdate ) , 0 ) b1, 
                       NVL ( gl.p_icurval(kv,Round(b3      *100,0),sysdate ) , 0 ) B3, 
                       NVL ( gl.p_icurval(kv,Round(b5      *100,0),sysdate ) , 0 ) B5, 
                       NVL ( gl.p_icurval(kv,Round(b7      *100,0),sysdate ) , 0 ) B7, 
                       NVL ( gl.p_icurval(kv,Round(AIRC_CCY*100,0),sysdate ) , 0 ) A9, 
                       NVL ( gl.p_icurval(kv,Round(FV_CCY  *100,0),sysdate ) , 0 ) I9
      from PRVN_Osaq where TIP = 3  and kf not in (select kf from PRVN_DEL_MAX  ) 
     )  X
WHERE   x.kf= a.KF and x.ND = a.ND and x.kv = a.KV 
  and ( x.B1 <> a.SDF  OR  x.B3 <> a.SDM  OR  x.B5 <> a.SDI  OR  x.B7 <> a.SDA  OR x.A9 <> a.SNA OR  x.I9 <> a.SRR  ) 
group by x.KF ;

commit;

insert into PRVN_DEL_MAX ( KF , DEL_SDF, DEL_SDM , DEL_SDI ,DEL_SDA, DEL_SNA , DEL_SRR, DEL_REZ_SUM, DEL_REZ_PRC )
select x.kf, 0,0,0,0,0,0,  (select SUM(fv_abs) from prvn_osaq where kf = x.kf) DEL_REZ_SUM,
                           (select decode(sum(rezb+rez9),0,0,(round(sum(fv_abs)*100/sum(rezb+rez9),4))) from prvn_osaq where kf = x.kf) DEL_REZ_PRC
from regions x where kf not in (select kf from  PRVN_DEL_MAX);

commit;

