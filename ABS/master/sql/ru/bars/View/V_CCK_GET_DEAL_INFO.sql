CREATE OR REPLACE VIEW V_CCK_GET_DEAL_INFO AS
select cc.nd, --0
       cc.cc_id, --1
       cc.dsdate, --2
       cc.dwdate, --3
       cc.abdate, --4
       cc.awdate, --5
       cc.kv, --6
       cc.s, --7
       cc.vidd, --8
       cc.sour, --9
       cc.aim, --10
       cc.prod, --11
       (select crisk
          from customer
         where rnk = cc.rnk
           and date_off is null) as nfin, --12
       cc.obs, --13
       cck_app.Get_ND_TXT(cc.nd, 'AIM') as saim, --14
       cc.acckred, --15
       cc.mfokred, --16
       cc.freq, --17
       (case
         when cc.pr = 0 then
          acrN.FPROCN(cc.acc8, 0, '')
         else
          cc.pr
       end) pr, --18
       ia.basey, --19
       cc.day, --20
       (select apl_dat
          from int_accn
         where acc = cc.acc8
           and id = 0) as apdate, --21
       cck_app.Get_ND_TXT(cc.nd, 'FREQP') as FREQP, --22
       trim(cck_app.Get_ND_TXT(cc.nd, 'R_CR9')) as nkom, --23
       cc.rnk, --24
       c.okpo, --25
       c.nmk, --26
       cck_app.Get_ND_TXT(cc.nd, 'INIC') as inic, --27
       cp.txt prod_name, --28
       ca.name as aim_name, --29
       cc.acc8, --30
       cc.basem, --31
       cck_app.Get_ND_TXT(cc.nd, 'S_SDI') as sdi, --32
       (select lcv || ' ' || name as lcv from tabval where kv = cc.kv) as kv_name, --33
       (select name from cc_vidd where vidd = cc.vidd) as vidd_name, --34
       (select name from cc_source where sour = cc.sour) as sour_name, --35
       (select name
          from stan_fin
         where fin in (select crisk
                         from customer
                        where rnk = cc.rnk
                          and date_off is null)) as nfin_name, --36
       (select name from stan_obs where obs = cc.obs) as obs_name, --37
       (select name from freq where freq = cc.freq) as freq_name, --38
       (select name from basey where basey = cc.basem) as basey_name, --39
       (select name
          from freq
         where freq = cck_app.Get_ND_TXT(cc.nd, 'FREQP')) as freqp_name, --40
       cck_app.Get_ND_TXT(cc.nd, 'CCRNG') as rang, --41
       (select name
          from cc_rang_name
         where rang = cck_app.Get_ND_TXT(cc.nd, 'CCRNG')) as rang_name, --42
       (select metr
          from int_accn
         where acc = cc.acc8
           and id = 2) as metr, --43
       (select name
          from int_metr
         where metr in (select metr
                          from int_accn
                         where acc = cc.acc8
                           and id = 2)) as metr_name, --44
       (select ir
          from int_ratn
         where acc = cc.acc8
           and id = 2) as metr_r, --45
       cck_app.Get_ND_TXT(cc.nd, 'SN8_R') as sn8, --46
       (SELECT r.ir
          FROM int_ratn r, int_accn i
         WHERE r.acc = i.acc
           and r.id = i.id
           and r.acc = cc.acc8
           and r.id = 4
           and r.bdat = (select max(bdat)
                           from int_ratn
                          WHERE acc = r.ACC
                            and id = r.id
                            and bdat <= gl.bd)) as sk4, --47
       cck_app.Get_ND_TXT(cc.nd, 'I_CR9') as icr9, --48
       decode(cck_app.Get_ND_TXT(cc.nd, 'I_CR9'),
              '0',
              'Відновлюваний',
              'Невідновлюваний') as icr9name, --49
       cck_app.Get_ND_TXT(cc.nd, 'DAYSN') as daysn, --50
       cck_app.Get_ND_TXT(cc.nd, 'DATSN') as datsn, --51
       cck_app.Get_ND_TXT(cc.nd, 'DAYNP') as daynp, --52
       decode(cck_app.Get_ND_TXT(cc.nd, 'DAYNP'),
              '0',
              'День',
              '1',
              'Місяць',
              'Інше') as daynp_name, --53
       (select nb from banks where mfo = cc.mfokred) as bank_name, --54
       cck_app.Get_ND_TXT(cc.nd, 'FLAGS') as FLAGS, --55
       cc.limit --56
  from cc_v cc, customer c, sb_ob22 cp, cc_aim ca, int_accn ia
 where cc.rnk = c.rnk
   and cc.prod = cp.r020 || cp.ob22
   and cc.aim = ca.aim
   and cc.acc8 = ia.acc
   and ia.id = 0
;
/