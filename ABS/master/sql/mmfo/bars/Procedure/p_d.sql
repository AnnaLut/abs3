

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_D.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_D ***

  CREATE OR REPLACE PROCEDURE BARS.P_D (id_ SMALLINT, p_s DATE) IS

--================================================================
-- Module : SBB
-- Author : MOM
-- Date   : 18.10.2007
--================================================================
-- Процедура отбора документов для расширенной технической выписки
--================================================================

  acc_        INT;
  fdat_       DATE;
  datd_       DATE;
  nd_         varchar2(10);
  vob_        number(2);
  dk_         number(1);
  nlsar_      varchar2(15);
  kvar_       SMALLINT;
  nlsbr_      varchar2(15);
  kvbr_       SMALLINT;
  mfoa_       varchar2(12);
  nlsa_       varchar2(15);
  kva_        SMALLINT;
  nama_       varchar2(38);
  okpoa_      varchar2(14);
  mfob_       varchar2(12);
  nlsb_       varchar2(15);
  kvb_        SMALLINT;
  namb_       varchar2(38);
  s_          number(16);
  kv_         SMALLINT;
  sq_         number(16);
  nazn_       varchar2(160);
  dat_a_      DATE;
  FA_T_ARM3_  varchar2(4);
  FA_T_ARM2_  varchar2(4);
  FB_T_ARM2_  varchar2(4);
  FB_T_ARM3_  varchar2(4);
  FB_D_ARM3_  date;
  okpob_      varchar2(14);
  ref_        number(9);

  amfo_       varchar2(12);
  id_kli_     varchar2(2);
  ref92_      number(9);

  T00980acc_  INT;
  accrr_      INT;

BEGIN

   delete from tmp_tvdoc where id=id_;

   begin
      select TO_CHAR(f_ourmfo)
      into amfo_
      from dual;
   exception when no_data_found then
      amfo_:='300465';
   end;

   begin
      select acc
      into T00980acc_
      from accounts
      where tip='T00' and kv=980 and dazs is null;
   exception when no_data_found then
      T00980acc_:=0;
   end;

   FOR c0 IN (SELECT a.nls,a.kv,a.acc,c.okpo,c.nmk,o.id_kli
              FROM   accounts a, cust_acc cu, customer c, okpo_afd o,
                     saldoa s
              WHERE  cu.acc=a.acc and a.acc=s.acc and cu.rnk=c.rnk and
                     c.okpo=o.okpo and a.daos<=p_s and
                     (a.dazs is null or a.dazs>p_s) and
                     s.fdat=p_s and
                     substr(a.nls,1,4) in (select nbs from tv_nbs) and
                     a.tip not in
              ('N99','L99','N00','T00','T0D','TNB','TND','TUR','TUD','L00')
             )
   LOOP

      FOR c1 IN (SELECT ref,dk,tt,s,sq,txt,stmt
                 FROM   opldok
                 WHERE  acc=c0.acc and sos=5 and fdat=p_s
                )
      LOOP

         FOR c2 IN (SELECT o.vdat,mod(o.vob,100) vob,o.nd,o.datd,o.mfoa,
                           o.nlsa,o.nam_a,o.id_a,o.mfob,o.nlsb,o.nam_b,o.id_b,
                           o.pdat,o.dk,
                           decode(o.tt,c1.tt,o.nazn,
                                       'R00',o.nazn,
                                       'R01',o.nazn,
                                       'D01',o.nazn,
                                       decode(c1.tt,'R00',o.nazn,
                                                    'R01',o.nazn,
                                                    'D01',o.nazn,
                                                          t.name)) nazn,
                           o.kv,o.d_rec,o.tt,o.kv2
                    FROM   oper o, tts t
                    WHERE  o.ref=c1.ref and c1.tt=t.tt
                   )
         LOOP

            kva_   := c0.kv;

            datd_  := c2.datd;
            nazn_  := c2.nazn;
            dat_a_ := c2.pdat;
            nlsa_  := c2.nlsa;
            nlsar_ := c2.nlsa;
            nlsb_  := c2.nlsb;
            nlsbr_ := c2.nlsb;
            kvb_   := c2.kv;
            nama_  := c2.nam_a;
            namb_  := c2.nam_b;
            okpoa_ := c2.id_a;
            okpob_ := c2.id_b;
            mfoa_  := c2.mfoa;
            mfob_  := c2.mfob;

            if mfoa_<>mfob_ then
               begin
                  select datp,FA_T_ARM3,FA_T_ARM2,FB_T_ARM2,FB_T_ARM3,
                         FB_D_ARM3
                  into   dat_a_,FA_T_ARM3_,FA_T_ARM2_,FB_T_ARM2_,FB_T_ARM3_,
                         FB_D_ARM3_
                  from   arc_rrp
                  where  ref=c1.ref and bis<=1;
               exception when no_data_found then
                  FA_T_ARM3_ := null;
                  FA_T_ARM2_ := null;
                  FB_T_ARM2_ := null;
                  FB_T_ARM3_ := null;
                  FB_D_ARM3_ := null;
               end;
            else
               FA_T_ARM3_ := null;
               FA_T_ARM2_ := null;
               FB_T_ARM2_ := null;
               FB_T_ARM3_ := null;
               FB_D_ARM3_ := null;
            end if;

-- если не совпадают коды TT в OPER и OPLDOK (дочерняя операция),
-- то выбрать реквизиты второй стороны из нужных таблиц
-- (счёт в основном, OKPO, наименование корресп. --- VOB=6 поставить)

            if mfoa_=mfob_ and kva_=980 and (c1.tt='R00' or c1.tt='R01') then

--             logger.info('TV: OPLDOK.ref = '||c1.ref);

               SELECT acc
               into   accrr_
               FROM   opldok
               WHERE  ref  = c1.ref  AND
                      dk   = 1-c1.dk AND
                      s    = c1.s    AND
                      stmt = c1.stmt;
               if accrr_=T00980acc_ then
                  nazn_ := c2.nazn;
               end if;
            end if;

            IF (c1.tt<>c2.tt and c1.tt<>'901' and c1.tt<>'R00' and
                c1.tt<>'R01') or c2.kv<>c2.kv2 THEN
               if c1.dk=0 then
                  SELECT a.kv,a.nls,o.txt,trim(substr(trim(a.nms),1,38)),
                         c.okpo
                  into   kvb_,nlsb_,nazn_,namb_,okpob_
                  FROM   accounts a, opldok o, customer c, cust_acc cu
                  WHERE  a.acc   = o.acc   AND
                         o.acc  <> c0.acc  AND
                         o.ref   = c1.ref  AND
                         o.dk    = 1-c1.dk AND
                         o.s     = c1.s    AND
                         c1.stmt = o.stmt  AND
                         cu.acc  = a.acc   AND
                         cu.rnk  = c.rnk;
               else
                  SELECT a.kv,a.nls,o.txt,trim(substr(trim(a.nms),1,38)),c.okpo
                  into   kva_,nlsa_,nazn_,nama_,okpoa_
                  FROM   accounts a, opldok o, customer c, cust_acc cu
                  WHERE  a.acc   = o.acc   AND
                         o.acc  <> c0.acc  AND
                         o.ref   = c1.ref  AND
                         o.dk    = 1-c1.dk AND
                         o.s     = c1.s    AND
                         c1.stmt = o.stmt  AND
                         cu.acc  = a.acc   AND
                         cu.rnk  = c.rnk;
               end if;
               mfoa_:=amfo_;
               mfob_:=amfo_;
            END IF;

            if c1.tt='901' then
               begin
                  select to_number(value)
                  into   ref92_
                  from   operw
                  where  ref=c1.ref;
               exception when others then
                  ref92_ := null;
               end;

               if ref92_ is not null then
                  select nlsa,nazn
                  into   nlsar_,nazn_
                  from   oper
                  where  ref=ref92_;
--             else
--                nlsar_ := nlsa_;
               end if;
--          else
--             nlsar_ := nlsa_;
            end if;

        /*  logger.info('  id_             =' || id_              ||
                        '  p_s             =' || p_s              ||
                        '  c2.datd         =' || c2.datd          ||
                        '  c2.nd           =' || c2.nd            ||
                        '  c2.vob          =' || c2.vob           ||
                        '  to_char(c2.dk)  =' || to_char(c2.dk)   ||
                        '  to_number(mfoa_)=' || to_number(mfoa_) ||
                        '  to_number(nlsa_)=' || to_number(nlsa_) ||
                        '  kva_            =' || kva_             ||
                        '  nama_           =' || nama_            ||
                        '  okpoa_          =' || okpoa_           ||
                        '  to_number(mfob_)=' || to_number(mfob_) ||
                        '  to_number(nlsb_)=' || to_number(nlsb_) ||
                        '  kva_            =' || kva_             ||
                        '  namb_           =' || namb_            ||
                        '  c1.s            =' || c1.s             ||
                        '  kva_            =' || kva_             ||
                        '  c1.sq           =' || c1.sq            ||
                        '  nazn_           =' || nazn_            ||
                        '  dat_a_          =' || dat_a_           ||
                        '  FA_T_ARM3_      =' || FA_T_ARM3_       ||
                        '  FA_T_ARM2_      =' || FA_T_ARM2_       ||
                        '  FB_T_ARM2_      =' || FB_T_ARM2_       ||
                        '  FB_T_ARM3_      =' || FB_T_ARM3_       ||
                        '  FB_D_ARM3_      =' || FB_D_ARM3_       ||
                        '  okpob_          =' || okpob_           ||
                        '  c1.ref          =' || c1.ref           ||
                        '  c0.id_kli       =' || c0.id_kli);
        */

            insert
            into tmp_tvdoc (id,
                            fdat,
                            datd,
                            nd,
                            vob,
                            dk,
                            nlsa_r,
                            kva_r,
                            nlsb_r,
                            kvb_r,
                            mfoa,
                            nlsa,
                            kva,
                            nama,
                            okpoa,
                            mfob,
                            nlsb,
                            kvb,
                            namb,
                            s,
                            kv,
                            sq,
                            nazn,
                            datp,
                            FA_T_ARM3,
                            FA_T_ARM2,
                            FB_T_ARM2,
                            FB_T_ARM3,
                            FB_D_ARM3,
                            okpob,
                            ref,
                            rezerv,
                            id_kli)
            values (id_,              /* id        */
                    p_s,              /* fdat      */
                    c2.datd,          /* datd      */
                    c2.nd,            /* nd        */
                    c2.vob,           /* vob       */
                    to_char(c2.dk),   /* dk        */  /* 1-c1.dk  */ /* c1.dk    */
                    null,             /* nlsa_r    */                 /* nlsar_   */
                    null,             /* kva_r     */                 /* kva_     */
                    null,             /* nlsb_r    */  /* c2.nlsb  */ /* nlsb_    */
                    null,             /* kvb_r     */  /* c2.kv    */ /* kvb_     */
                    to_number(mfoa_), /* mfoa      */                 /* c2.mfoa  */
                    to_number(nlsa_), /* nlsa      */
                    kva_,             /* kva       */                 /* c2.kv    */
                    nama_,            /* nama      */                 /* c2.nam_a */
                    okpoa_,           /* okpoa     */                 /* c2.id_a  */
                    to_number(mfob_), /* mfob      */                 /* c2.mfob  */
                    to_number(nlsb_), /* nlsb      */  /* c2.nlsb  */
                    kva_,             /* kvb       */  /* c2.kv    */ /* kvb_     */
                    namb_,            /* namb      */  /* c2.nam_b */
                    c1.s,             /* s         */
                    kva_,             /* kv        */                 /* c2.kv    */
                    c1.sq,            /* sq        */
                    nazn_,            /* nazn      */
                    dat_a_,           /* datp      */
                    FA_T_ARM3_,       /* FA_T_ARM3 */
                    FA_T_ARM2_,       /* FA_T_ARM2 */
                    FB_T_ARM2_,       /* FB_T_ARM2 */
                    FB_T_ARM3_,       /* FB_T_ARM3 */
                    FB_D_ARM3_,       /* FB_D_ARM3 */
                    okpob_,           /* okpob     */  /* c2.id_b  */
                    c1.ref,           /* ref       */
                    null,             /* rezerv    */
                    c0.id_kli);       /* id_kli    */

         END LOOP;
      END LOOP;
   END LOOP;

---------- информационные -------------------------------------------------
                                     /* r.s*DECODE(r.dk,2,-1,1) s */
   FOR c3 IN (SELECT a.acc,r.dat_a,a.nls,a.kv,a.isp,
                     trim(substr(trim(a.nms),1,38)) nms,c.okpo,r.dk,
                     mod(r.vob,100) vob,r.s,r.nd,r.mfoa,r.nlsa,r.nam_a,
                     r.nazn,r.id_a,r.datd,r.FA_T_ARM3,o.id_kli,r.FA_T_ARM2,
                     r.FB_T_ARM2,r.FB_T_ARM3,r.FB_D_ARM3
              FROM   arc_rrp r, accounts a, customer c, cust_acc cu,
                     okpo_afd o
              WHERE  r.dk>1 AND r.s>0 AND a.nls=r.nlsb AND r.kv=980 AND
                     a.kv=980 AND a.acc=cu.acc and cu.rnk=c.rnk and
                     c.okpo=o.okpo and (r.dat_a>=p_s AND r.dat_a-1<=p_s)
             )
   LOOP

      INSERT
      INTO tmp_tvdoc (id,
                      fdat,
                      datd,
                      nd,
                      vob,
                      dk,
                      nlsa_r,
                      kva_r,
                      nlsb_r,
                      kvb_r,
                      mfoa,
                      nlsa,
                      kva,
                      nama,
                      okpoa,
                      mfob,
                      nlsb,
                      kvb,
                      namb,
                      s,
                      kv,
                      sq,
                      nazn,
                      datp,
                      FA_T_ARM3,
                      FA_T_ARM2,
                      FB_T_ARM2,
                      FB_T_ARM3,
                      FB_D_ARM3,
                      okpob,
                      ref,
                      rezerv,
                      id_kli)
      VALUES (id_,           /* id        */
              p_s,           /* fdat      */
              c3.datd,       /* datd      */
              c3.nd,         /* nd        */
              c3.vob,        /* vob       */
              c3.dk,         /* dk        */
              c3.nls,        /* nlsa_r    */
              c3.kv,         /* kva_r     */
              c3.nlsa,       /* nlsb_r    */
              c3.kv,         /* kvb_r     */
              amfo_,         /* mfoa      */
              c3.nls,        /* nlsa      */
              c3.kv,         /* kva       */
              c3.nms,        /* nama      */
              c3.id_a,       /* okpoa     */
              c3.mfoa,       /* mfob      */
              c3.nlsa,       /* nlsb      */
              c3.kv,         /* kvb       */
              c3.nam_a,      /* namb      */
              c3.s,          /* s         */
              c3.kv,         /* kv        */
              c3.s,          /* sq        */
              c3.nazn,       /* nazn      */
              c3.dat_a,      /* datp      */
              c3.FA_T_ARM3,  /* FA_T_ARM3 */
              c3.FA_T_ARM2,  /* FA_T_ARM2 */
              c3.FB_T_ARM2,  /* FB_T_ARM2 */
              c3.FB_T_ARM3,  /* FB_T_ARM3 */
              c3.FB_D_ARM3,  /* FB_D_ARM3 */
              c3.id_a,       /* okpob     */
              null,          /* ref       */
              null,          /* rezerv    */
              c3.id_kli      /* id_kli    */);
   END LOOP;

END p_d;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_D.sql =========*** End *** =====
PROMPT ===================================================================================== 
