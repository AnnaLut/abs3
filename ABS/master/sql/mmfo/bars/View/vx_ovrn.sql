/*
60` 6026*17	����.������  ���.��� �� 2067              === 2017  ==> 6025*17
60  6020*06	����.������  �� ���.��� �� 2600 ( � �.�. � � ����� ����) 	
61  6020*06     ���.��� �� ��� 1 ��	
62  6020*06	���.��� �� ��� ����.	
63  6020*06	���.��� �� ���� NPP	
70  7020*06	����.�������  �� ���.���
*/

-------------------------------------

create or replace view  BARS.vX_ovrn as 
select  t.rnk, t.kv,  t.nms, t.NLS, i.acr_dat,  y.dat1, y.dat2, x.acc8, x.acc,  round( abs(x.pr) ,0) PR, 
        decode ( x.vn, 70, acrn.fprocn(x.acc8,1,y.dat2) , null) ip8,  
        decode ( x.vn, 60, acrn.fprocn(x.acc8,0,y.dat2) , null) ia8,  
        decode ( x.vn, 70, acrn.fprocn(x.acc ,1,y.dat2) , null) ip2,  
        decode ( x.vn, 60, acrn.fprocn(x.acc ,0,y.dat2) , null) ia2, 
        1- i.id ID , aa.nls NLSA, aa.nms NAM_a , x.vn,
        Substr( CASE WHEN aa.tip in ('SPN'      ) THEN CASE WHEN OVRN.F2017 = 1 THEN nbs_ob22_null ( '6025', '17', t.branch)  else nbs_ob22_null ( '6026', '17', t.branch)   end 
                     WHEN x.vn   in (60,61,62,63) THEN nbs_ob22_null ( '6020', '06', t.branch)
                     WHEN x.vn   in (70         ) THEN nbs_ob22_null ( '7020', '06', t.branch) 
                     else null 
                     end ,  1, 15 ) NLSB, 
        Decode ( x.vn, 70, '����.������� �� ���.���.', '����.�� ����.���.' ) || ' �� ���.���'  NAM_B ,
        Substr( decode ( x.vn, 60, '���.%% ���.�� ��� ', 
                               70, '���.%% ����.', 
                               61, '���.��� �� ��� 1 ��',
                               62, '���.��� �� ��� ����.',
                               63, '���.��� �� ���� NPP',
                                   null   
                        ),   1,38)  NAzn
from int_accn i, accounts aa, accounts t,  
     (select acc, min(cdat) dat1, max(cdat) dat2 from ovr_intx where mod1=1 group by        acc     ) y, 
     (select acc8, acc, VN,       sum(pr) pr     from ovr_intx where mod1=1 group by acc8,  acc, VN ) x
where x.acc = y.acc and x.acc = t.acc and t.acc = i.acc and i.id = decode ( sign(x.pr),1 ,1,0 )  and aa.acc = i.acra ;

grant select on   BARS.vX_ovrn  to start1;
grant SELECT                                                                 on VX_OVRN         to BARS_ACCESS_DEFROLE;

