CREATE OR REPLACE FORCE VIEW BARS.INV_V_ZAL  AS 
select z.dat, 
       d.rnk, 
       c.nmk, 
       c.okpo, 
       z.nd,  
       p.cc_idz, 
       z.pawn, 
       nvl(n.name_351,name) name, 
       a.kv KV_nls, 
       z.kv KV_ND,  
       abs(ost_korr(z.accz,Dat_last_work(TO_DATE(pul.get_mas_ini_val ('sFdat1'),'dd.mm.yyyy')-1),null,nvl(a.nbs,substr(a.nls,1,4))))/100 BV_ZAL, 
       decode(a.kv,z.kv, SUM(z.sall)/100, inv_f_val(z.kv, a.kv, SUM(z.sall), TO_DATE (pul.get_mas_ini_val ('sFdat1'), 'dd.mm.yyyy'))/100)  BV_R, 
       z.accz,
       a.nls,
       z.kf  
from   tmp_rez_obesp23 z, accounts a, customer c,pawn_acc p, cc_pawn n, cc_deal d, nd_acc nd  
where  z.dat = TO_DATE (pul.get_mas_ini_val ('sFdat1'), 'dd.mm.yyyy') and z.accz = a.acc and d.rnk = c.rnk and z.accz = p.acc and z.pawn = n.pawn and 
       d.nd=nd.nd and z.accs=nd.acc 
group  by z.dat, d.rnk, c.nmk, c.okpo, z.nd, p.cc_idz, z.pawn, nvl(n.name_351,name), a.kv, z.kv , z.accz, a.nls, z.kf, a.nbs, a.nls; 

COMMENT ON TABLE   BARS.INV_V_ZAL             IS 'Аналіз забезпечення';  
COMMENT ON COLUMN  BARS.INV_V_ZAL.DAT         IS 'Звітна дата';
COMMENT ON COLUMN  BARS.INV_V_ZAL.RNK         IS 'РНК';	
COMMENT ON COLUMN  BARS.INV_V_ZAL.NMK         IS 'Назва клієнта'; 
COMMENT ON COLUMN  BARS.INV_V_ZAL.ND          IS 'Реф. кред. договору'; 	
COMMENT ON COLUMN  BARS.INV_V_ZAL.CC_IDZ      IS 'Номер договору забезпечення';	
COMMENT ON COLUMN  BARS.INV_V_ZAL.PAWN        IS 'Вид забезпечення';	
COMMENT ON COLUMN  BARS.INV_V_ZAL.NAME        IS 'Назва забезпечення';	
COMMENT ON COLUMN  BARS.INV_V_ZAL.OKPO        IS 'ЕДРПОУ';	
COMMENT ON COLUMN  BARS.INV_V_ZAL.KV_NLs      IS 'Код валюти'; 
COMMENT ON COLUMN  BARS.INV_V_ZAL.BV_ZAL      IS 'Балансова вартість забезпечення (ном.)';
COMMENT ON COLUMN  BARS.INV_V_ZAL.BV_R        IS 'Балансова вартість забезпечення, розподілена на актив (ном.)';
COMMENT ON COLUMN  BARS.INV_V_ZAL.ACCZ        IS 'ACC рахунку забезпечення';
COMMENT ON COLUMN  BARS.INV_V_ZAL.NLS         IS 'Рахунок забезпечення';
                        
grant SELECT on INV_v_ZAL to BARS_ACCESS_DEFROLE;
grant SELECT on INV_v_ZAL to START1;


