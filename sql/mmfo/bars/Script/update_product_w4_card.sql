begin
    for lc_kf in (select kf from bars.mv_kf)
    loop
        bars.bc.go(lc_kf.kf);
update w4_card t
   set t.haveins = 1,
       t.ins_ukr_id =3730,
       t.ins_wrd_id = 3238,
       t.tmp_id_ukr = 91,
       t.tmp_id_wrd = 92
 where t.code in ('STND_UAH_8_VGOLDPW_1/2',
                  'STND_UAH_8_MGOLDPP_1/2');

update w4_card t
   set t.haveins = 1,
       t.ins_ukr_id = 3088,
       t.ins_wrd_id = null,
       t.tmp_id_ukr = 103,
       t.tmp_id_wrd = null
 where t.code in ('STND_UAH_8_VPLATPW_1/2',
                  'STND_UAH_8_MPLATPP_1/2');

update w4_card t
   set t.haveins = 1,
       t.ins_ukr_id = 3087,
       t.ins_wrd_id = null,
       t.tmp_id_ukr = 103,
       t.tmp_id_wrd = null
 where t.code in ('STND_UAH_8_VINFINPW_1/2', 
                  'STND_UAH_8_MELITPP_1/2');

update w4_card t
   set t.haveins = 1,
       t.ins_ukr_id = 3730,
       t.ins_wrd_id = 3238,
       t.tmp_id_ukr = 91,
       t.tmp_id_wrd = 92
 where t.code in ('STND_UAH_8_MGOLDPP_600',
                  'STND_UAH_8_VGOLDPW_600');
                  
update w4_card t
   set t.haveins = 1,
       t.ins_ukr_id = 3087,
       t.ins_wrd_id = null,
       t.tmp_id_ukr = 103,
       t.tmp_id_wrd = null
 where t.code in ('STND_UAH_8_MELITPP_5000', 
                  'STND_UAH_8_VINFINPW_5000');
 
update w4_card t
   set t.haveins = 1,
       t.ins_ukr_id = 3088,
       t.ins_wrd_id = null,
       t.tmp_id_ukr = 103,
       t.tmp_id_wrd = null
 where t.code in ('STND_UAH_8_MPLATPP_1500',
                  'STND_UAH_8_VPLATPW_1500');
 
update w4_card t
   set t.haveins = 0
 where t.code not in ('STND_UAH_8_MGOLDPP_600',
                      'STND_UAH_8_MPLATPP_1500',
                      'STND_UAH_8_MELITPP_5000',
                      'STND_UAH_8_VINFINPW_5000',
                      'STND_UAH_8_VGOLDPW_600',
                      'STND_UAH_8_VPLATPW_1500',
                       'STND_UAH_8_VGOLDPW_1/2',
                       'STND_UAH_8_MGOLDPP_1/2',
                       'STND_UAH_8_VPLATPW_1/2',
                       'STND_UAH_8_MPLATPP_1/2',
                       'STND_UAH_8_VINFINPW_1/2',
                       'STND_UAH_8_MELITPP_1/2');
 
        commit;
    end loop;
end;
/

begin
bars.bc.home;
end;
/
