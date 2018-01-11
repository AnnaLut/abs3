

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_F3D_NN.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_F3D_NN ***

  CREATE OR REPLACE PROCEDURE BARS.P_F3D_NN (Dat_ DATE ,
                                      sheme_ varchar2 default 'D') IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION : Процедура формирования #3D для КБ (универсальная)
% COPYRIGHT   : Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
% VERSION     : 22/02/2017 (05/12/2016, 09/11/2016)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
параметры: Dat_ - отчетная дата
           sheme_ - схема формирования
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
22.02.2017 - показатель 106 будем рассчитывать по формуле расчета %% за 
             квартал (кол-во дней в году 365)
05.12.2016 - для кода 208 будем формировать значение поля IN_BR 
             1 - котируется,  0 - не котируется 
06.11.2016 - для кода 111 и счетов кредита остаток формируем без счетов
             процентов
02.11.2016 - выполнены изменения по замечаниях от пользователей
20.10.2016 - новый файл на 01.11.2016 
             Данi про кредити наданi НБУ та про застави за кредитами НБУ
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
kodf_     varchar2(2) := '3D';
typ_      number;
acc_      Number;
nls_      varchar2(15);
kv_       Number;
Dat1_     Date;
kol1_     Number;
ost_      Number;
nnnn_     Number;
mmmm_     Number;
mmmm1_    Number;
nd_       Number;
mfo_      Varchar2(12);
mfou_     Number;
nbuc1_    Varchar2(12);
nbuc2_    Varchar2(12);
nbuc_     Varchar2(12);
rnk_      Number:=0;
rnka_     Number;
nmk_      Varchar2(70);
k040_     Varchar2(3);
obl_      Number;
ser_      Varchar2(15);
numdoc_   Varchar2(20);
fs_       Varchar2(2);
ise_      Varchar2(5);
ved_      Varchar2(5);
k074_     Varchar2(1);
k081_     Varchar2(1);
k110_     Varchar2(5);
k111_     Varchar2(2);
kodp_     Varchar2(35);
znap_     Varchar2(70);
userid_   Number;
cust_type number;
glb_      number;
ret_      NUMBER;
sql_acc_  VARCHAR2(2000):='';
comm_     rnbu_trace.comm%TYPE;
pawn_     Number;
okpo_     Varchar2(14);
name_b    Varchar2(70);
pok_226   Varchar2(70);
pok_106   Number;
day_106   Number;
spcnt_    Number;
ref_cp_   Number;
koef_     Number;
sum_dog_  Number;
sum_nd_   Number;
kol_9510  Number;


PROCEDURE p_ins (p_kodp_ IN VARCHAR2, p_znap_ IN VARCHAR2)
IS
   l_kodp_   VARCHAR2 (35);
BEGIN
   l_kodp_ := p_kodp_ ;

   INSERT INTO rnbu_trace
      (nls, kv, odate, kodp, znap, nbuc, acc, rnk, nd, comm)
   VALUES
      (nls_, kv_, dat_, l_kodp_, p_znap_, nbuc_, acc_, rnk_, nd_, comm_);

END;

-----------------------------------------------------------------------------
BEGIN
-------------------------------------------------------------------
   userid_ := user_id;
   EXECUTE IMMEDIATE 'TRUNCATE TABLE RNBU_TRACE';
-------------------------------------------------------------------
   mfo_ := F_Ourmfo();

   Dat1_  := TRUNC(add_months(Dat_,1),'MM');

   -- МФО "родителя"
   BEGIN
      SELECT mfou
         INTO mfou_
      FROM BANKS
      WHERE mfo = mfo_;
   EXCEPTION
      WHEN NO_DATA_FOUND
   THEN
      mfou_ := mfo_;
   END;

   -- параметры формирования файла
   p_proc_set(kodf_,sheme_,nbuc1_,typ_);

   nbuc2_ := nbuc1_;
   nbuc_ := nbuc1_;

   IF nbuc2_ IS NULL THEN
      nbuc2_ := '0';
   END IF;

   begin
      select nvl( trim(val), '00000000')
         into okpo_
      from params 
      where  trim(par) = 'OKPO';
   exception when no_data_found then
      null;
   end;    

   begin
      select nvl( trim(val), 'назва банку')
         into name_b
      from params 
      where  trim(par) = 'NAME';
   exception when no_data_found then
      null;
   end;    

   sql_acc_ := 'select  /*+parallel(8)*/ * from accounts a where nvl(nbs, substr(nls,1,4)) in ';
   sql_acc_ := sql_acc_ || '(''1322'',''1326'',''1327'',''1328'') ';

   ret_ := F_Pop_Otcn(Dat_, 2, sql_acc_, null, 0, 1);

   nnnn_ := 0;
   mmmm_ := 0;
   mmmm1_ := 0;
   nd_ := 0;

   -- общая сумма договоров кредитов НБУ
   select NVL(sum (o.ost - o.dos96 + o.kos96), 0)
      into sum_dog_
   from  otcn_saldo o, customer c, cc_deal cc, nd_acc n, 
         accountsw aw, nd_txt nt
   where o.nls like '132%' 
     and o.ost - o.dos96 + o.kos96 <> 0 
     and o.rnk = c.rnk 
     and o.acc = n.acc 
     and n.nd = cc.nd 
     and cc.sos <> 15 
--     and cc.nd in (373045501, 373065501) 
     and o.acc = aw.acc(+)
     and n.nd = nt.nd(+)
     and nt.tag(+) in ('REF_CP','REF_ND'); 


   for k in ( select o.acc, o.nls, o.kv, c.rnk RNK, NVL(c.okpo,'0000000000') OKPO,
                      c.codcagent CODC, c.nmk NMK, NVL(c.ise,'00000') ISE,
                      o.ost - o.dos96 + o.kos96 ost, 
                      cc.nd, cc.cc_id, cc.sdate, 
                      trim(nt.txt) ref
               from  otcn_saldo o, customer c, cc_deal cc, nd_acc n, 
                     accountsw aw, nd_txt nt
               where o.nls like '132%' 
                 and o.ost - o.dos96 + o.kos96 <> 0 
                 and o.rnk = c.rnk 
                 and o.acc = n.acc 
                 and n.nd = cc.nd 
                 and cc.sos <> 15 
--                 and cc.nd in (373045501, 373065501) 
                 and o.acc = aw.acc(+)
                 and n.nd = nt.nd(+)
                 and nt.tag(+) in ('REF_CP','REF_ND') 
               order by cc.nd 
             )
   loop

       acc_ := k.acc;
       nls_ := k.nls;
       kv_ := k.kv;
       rnk_ := k.rnk;
       comm_ := ' ';

       if nd_ = 0 OR nd_ <> k.nd
       then

          pok_106 := 0;
          nnnn_ := nnnn_ + 1;
          ---mmmm_ := mmmm_ + 1;
          nd_ := k.nd;
          --mmmm1_ := mmmm_;
          --if mmmm_ <> mmmm1_
          --then
          --   mmmm_ := mmmm1_ - 1;
          --end if;

          -- код 102
          kodp_ := '102'|| lpad(to_char(nnnn_), 5,'0') || '00' || '00000';
          p_ins (kodp_, k.cc_id );

          -- код 103
          kodp_ := '103'|| lpad(to_char(nnnn_), 5,'0') || '00' || '00000';
          p_ins (kodp_, k.sdate );

          if k.nls not like '13_8%'
          then
             -- код 104
             kodp_ := '104'|| lpad(to_char(nnnn_), 5,'0') || '00' || '00000';
             p_ins (kodp_, to_char(k.ost) );
          end if;

          if k.nls like '13_8%'
          then
             -- код 105
             kodp_ := '105'|| lpad(to_char(nnnn_), 5,'0') || '00' || '00000';
             p_ins (kodp_, to_char(k.ost) );
          end if;

          if k.nls not like '13_8%'
          then

             --select NVL(sum(sumo - sumg), 0) 
             --   into pok_106
             --from cc_lim 
             --where nd = nd_ 
             -- and fdat > dat_;
 
             select last_day(add_months(Dat_, 3)) - Dat_
                into day_106
             from dual; 

             spcnt_ := Acrn.fproc (acc_, dat_);

             pok_106 := round ((k.ost * spcnt_/100) * day_106 / 365);
 
             -- код 106
             kodp_ := '106'|| lpad(to_char(nnnn_), 5,'0') || '00' || '00000';
             p_ins (kodp_, to_char(pok_106) );
          end if;

          -- код 107
          kodp_ := '107'|| lpad(to_char(nnnn_), 5,'0') || '00' || '00000';
          p_ins (kodp_, '0' );

          for z in ( select a.acc, a.nls, a.kv, a.rnk, 
                            trim(aw.tag) tag, trim(aw.value) ref_cp, 
                            NVL(trim(aw1.value), '0') kor_k, 
                            NVL(trim(aw2.value), '0') rek_p,
                            NVL(trim(aw3.value), '0') kol_z, 
                            NVL(c.s031,'00') s031,
                            NVL(p.pawn,999999) pawn, NVL(p.cc_idz,'XXX') cc_idz, 
                            NVL(p.sdatz,Dat_) sdatz, fost(a.acc, Dat_) ost
                     from accounts a, nd_acc n, cc_pawn c, pawn_acc p, 
                          accountsw aw, accountsw aw1, accountsw aw2, accountsw aw3 
                     where n.nd = k.nd 
                       and n.acc = a.acc
                       and a.nls like '9510%'
                       and n.acc = aw.acc
                       and aw.tag in ('REF_CP', 'REF_ND') 
                       and n.acc = aw1.acc(+)
                       and aw1.tag(+) like 'KOR_K%'
                       and n.acc = aw2.acc(+)
                       and aw2.tag(+) like 'REK_P%'
                       and n.acc = aw3.acc(+)
                       and aw3.tag(+) like 'KOL_Z%'
                       and n.acc = p.acc(+)
                       and c.pawn = p.pawn 
                       and fost (a.acc, Dat_) <> 0
                   )

          loop
            
             acc_ := z.acc;            
             nls_ := z.nls;
             kv_ := z.kv;
             rnk_ := z.rnk;
             ref_cp_ := 0;

             begin
                select to_number(substr(kodp, -5))  
                   into mmmm1_
                from rnbu_trace 
                where nls like nls_ || '%'
                  and rownum = 1;
             exception when no_data_found then
                mmmm1_ := mmmm1_ + 1;
             end; 

             if z.tag = 'REF_CP'
             then
                ref_cp_ := z.ref_cp;
             end if;
 
             -- код 108
             kodp_ := '108'|| lpad(to_char(nnnn_), 5,'0') || z.s031 || lpad(to_char(mmmm1_), 5,'0');
             p_ins (kodp_, to_char(z.cc_idz) ) ; --'N дог.' );

             -- код 109
             kodp_ := '109'|| lpad(to_char(nnnn_), 5,'0') || z.s031 || lpad(to_char(mmmm1_), 5,'0');
             p_ins (kodp_, to_char(z.sdatz,'ddmmyyyy'));

             -- код 111
             if z.tag = 'REF_CP'
             then
                kodp_ := '111'|| lpad(to_char(nnnn_), 5,'0') || z.s031 || lpad(to_char(mmmm1_), 5,'0');
                p_ins (kodp_, to_char(round(z.ost * (k.ost / sum_dog_),0)) );
             end if;

             if z.tag = 'REF_ND'
             then
                select NVL(sum(o.bvq*100), 0)
                   into sum_nd_
                from nbu23_rez o, nd_acc n, accounts a
                where o.fdat = dat1_ 
                  and o.acc = n.acc 
                  and n.nd = z.ref_cp 
                  and a.acc = n.acc 
                  and a.nls like '2%'
                  and substr(a.nls, 4, 1) not in ('8','9');

                kodp_ := '111'|| lpad(to_char(nnnn_), 5,'0') || z.s031 || lpad(to_char(mmmm1_), 5,'0');
                p_ins (kodp_, to_char(round(sum_nd_ * (k.ost / sum_dog_),0)) );
             end if;

             -- код 112
             kodp_ := '112'|| lpad(to_char(nnnn_), 5,'0') || z.s031 || lpad(to_char(mmmm1_), 5,'0');
             p_ins (kodp_, z.kor_k );

             -- код 113
             kodp_ := '113'|| lpad(to_char(nnnn_), 5,'0') || z.s031 || lpad(to_char(mmmm1_), 5,'0');
             p_ins (kodp_, z.rek_p );

             for z1 in ( select n.nd, n.acc, n.nls, n.kv, n.rnk, n.okpo, n.nmk,  
                                n.bvq * 100 bvq, n.rezq * 100 rezq, 
                                NVL(c.bal_var1,0) bal_var1, 
                                NVL(c.mdate, Dat_) mdate,
                                NVL(c.emi, 9) emi,
                                NVL(c.cp_id, ' ') cp_id,
                                NVL(c.kol_cp, 1) kol_cp,  
                                decode(c1.in_br, 1, 'Котирується','Не котирується') pok_208
                         from nbu23_rez n, cp_pereoc_v c, cp_kod c1 
                         where n.fdat = Dat1_ 
                           and n.nd = ref_cp_
                           and ref_cp_ <> 0
                           and n.nd = c.ref(+)
                           and c1.cp_id(+) = c.cp_id 
                       )

               loop

                  acc_ := z1.acc;            
                  nls_ := z1.nls;
                  kv_ := z1.kv;
                  rnk_ := z1.rnk;
                  koef_ := z.kol_z / z1.kol_cp;
  
                  if z1.nd = 21747614901 then
                     koef_ := 1; 
                  end if;
                  
                  -- код 207
                  kodp_ := '207'|| lpad(to_char(nnnn_), 5,'0') || z.s031 || lpad(to_char(mmmm1_), 5,'0');
                  p_ins (kodp_, trim(z1.nmk) || ' ' || z1.cp_id );  --'назва майна/іпотеки');

                  -- код 208 (котируется/некотируется на рынке)
                  kodp_ := '208'|| lpad(to_char(nnnn_), 5,'0') || z.s031 || lpad(to_char(mmmm1_), 5,'0');
                  p_ins (kodp_, z1.pok_208);  --to_char(round((z1.bvq / z1.kol_cp)/100, 2)));  --to_char(round(z1.bal_var1,4)) );  --'хар-ка предмету застави');

                  -- код 209
                  kodp_ := '209'|| lpad(to_char(nnnn_), 5,'0') || z.s031 || lpad(to_char(mmmm1_), 5,'0');
                  p_ins (kodp_, z.kol_z);  --'кількісна хар-ка предмету застави');

                  -- код 210
                  kodp_ := '210'|| lpad(to_char(nnnn_), 5,'0') || z.s031 || lpad(to_char(mmmm1_), 5,'0');
                  p_ins (kodp_, trim(name_b) );

                  -- код 211
                  kodp_ := '211'|| lpad(to_char(nnnn_), 5,'0') || z.s031 || lpad(to_char(mmmm1_), 5,'0');
                  p_ins (kodp_, trim(okpo_) );

                  -- код 212
                  kodp_ := '212'|| lpad(to_char(nnnn_), 5,'0') || z.s031 || lpad(to_char(mmmm1_), 5,'0');
                  p_ins (kodp_, '0');  --'номер свідоцтва');

                  -- код 213
                  kodp_ := '213'|| lpad(to_char(nnnn_), 5,'0') || z.s031 || lpad(to_char(mmmm1_), 5,'0');
                  p_ins (kodp_, '0');  --'стан майна');

                  -- код 214
                  kodp_ := '214'|| lpad(to_char(nnnn_), 5,'0') || z.s031 || lpad(to_char(mmmm1_), 5,'0');
                  p_ins (kodp_, '0');  --'дата останньої перевірки');

                  -- код 215
                  kodp_ := '215'|| lpad(to_char(nnnn_), 5,'0') || z.s031 || lpad(to_char(mmmm1_), 5,'0');
                  p_ins (kodp_, '0');  --'стан майна на дату останньої перевірки');

                  -- код 216
                  kodp_ := '216'|| lpad(to_char(nnnn_), 5,'0') || z.s031 || lpad(to_char(mmmm1_), 5,'0');
                  if z1.nd = 21747614901 then
                     p_ins (kodp_, to_char(to_date('14122022','ddmmyyyy'),'DDMMYYYY') );  --('дата закінчення договору');
                  else 
                     p_ins (kodp_, to_char(z1.mdate,'DDMMYYYY') );  --('дата закінчення договору');
                  end if; 

                  if substr(z1.nls, 4, 1) not in ('5', '6', '7', '8', '9') 
                  then
                     -- код 217
                     kodp_ := '217'|| lpad(to_char(nnnn_), 5,'0') || z.s031 || lpad(to_char(mmmm1_), 5,'0');
                     p_ins (kodp_, to_char(round(z1.bvq * koef_,0)) );
                  end if;

                  -- код 218
                  kodp_ := '218'|| lpad(to_char(nnnn_), 5,'0') || z.s031 || lpad(to_char(mmmm1_), 5,'0');
                  p_ins (kodp_, to_char(round(z1.bvq * koef_,0)) );

                  -- код 219
                  kodp_ := '219'|| lpad(to_char(nnnn_), 5,'0') || z.s031 || lpad(to_char(mmmm1_), 5,'0');
                  p_ins (kodp_, to_char(round(z1.bvq * koef_,0)) );

                  -- код 220
                  kodp_ := '220'|| lpad(to_char(nnnn_), 5,'0') || z.s031 || lpad(to_char(mmmm1_), 5,'0');
                  p_ins (kodp_, '0');  --'оціночна вартість предмету застави');

                  -- код 221
                  kodp_ := '221'|| lpad(to_char(nnnn_), 5,'0') || z.s031 || lpad(to_char(mmmm1_), 5,'0');
                  p_ins (kodp_, to_char(z.ost) );  --'заставна вартість майна/предмету застави');

                  -- код 222
                  kodp_ := '222'|| lpad(to_char(nnnn_), 5,'0') || z.s031 || lpad(to_char(mmmm1_), 5,'0');
                  p_ins (kodp_, '0');  --'код регіону');

                  -- код 223
                  kodp_ := '223'|| lpad(to_char(nnnn_), 5,'0') || z.s031 || lpad(to_char(mmmm1_), 5,'0');
                  p_ins (kodp_, '0');  --'район місцезнаходження об єкта');

                  -- код 224
                  kodp_ := '224'|| lpad(to_char(nnnn_), 5,'0') || z.s031 || lpad(to_char(mmmm1_), 5,'0');
                  p_ins (kodp_, '0');  --'населений пункт місцезнаходження об єкта');

                  -- код 225
                  kodp_ := '225'|| lpad(to_char(nnnn_), 5,'0') || z.s031 || lpad(to_char(mmmm1_), 5,'0');
                  p_ins (kodp_, '0');  --'місцезнаходження об єкта');

                 pok_226 := '';
                 if substr(z1.nls,1,4) in ('1410','1420','1430','1440') or 
                    (substr(z1.nls,1,4) = '1412' and z1.emi='1')
                 then
                    pok_226 := 'депозитарій НБУ'; 
                 end if;

                 if substr(z1.nls,1,4) in ('1413','1414') or 
                    (substr(z1.nls,1,4) = '1412' and z1.emi='0')
                 then
                    pok_226 := 'ПАТ національний депозитарій України'; 
                 end if;

                 if substr(z1.nls,1,4) in ('1410','1420','1430','1440') or 
                    (substr(z1.nls,1,4) = '1412' and z1.emi='1') or 
                    substr(z1.nls,1,4) in ('1413','1414') or 
                    (substr(z1.nls,1,4) = '1412' and z1.emi='0')
                 then
                    -- код 226
                    kodp_ := '226'|| lpad(to_char(nnnn_), 5,'0') || z.s031 || lpad(to_char(mmmm1_), 5,'0');
                    p_ins (kodp_, pok_226);  --'депозитарій знерухомлення');
                 end if;
 
            end loop;
 
       end loop;

          acc_ := k.acc;
          nls_ := k.nls;
          kv_ := k.kv;
          rnk_ := k.rnk;
      
       end if;

   end loop;  
  ---------------------------------------------------
   DELETE FROM tmp_nbu where kodf = kodf_ and datf = dat_;
   ---------------------------------------------------
   for k in ( select kodp, to_char(sum(znap)) znap, nbuc 
              from rnbu_trace
              where substr(kodp,1,3) in ('217','218','219')
              group by kodp, nbuc
              union
              select distinct kodp, znap, nbuc   
              from rnbu_trace                    
              where substr(kodp,1,3) not in ('217','218','219')        
            )
   loop
       select count(*) into kol1_
       from tmp_nbu
       where kodf = kodf_ and
             datf = dat_ and
             kodp = k.kodp ;

       if kol1_ = 0 then
          INSERT INTO tmp_nbu (kodp, datf, kodf, nbuc, znap, kf) VALUES
                              (k.kodp, dat_, kodf_, k.nbuc, k.znap, '300465');
       end if;
   end loop;
  ----------------------------------------
END p_f3d_NN;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_F3D_NN.sql =========*** End *** 
PROMPT ===================================================================================== 
