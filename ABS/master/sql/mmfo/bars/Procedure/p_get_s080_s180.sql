CREATE OR REPLACE PROCEDURE BARS.P_GET_S080_S180 (dat_ in date, mfou_ in varchar2,
   acc_ in out number, nls_ in varchar2, kv_ in accounts.KV%type, acc2_ in out number,
   nd_ in number, vidd_ in number, rezid_ in number, comm_ in out varchar2,
   s080_ in out specparam.S080%type, s180_ in out specparam.S180%type)
   -------------------------------------------------
   -- VERSION - 12/12/2018 (09/08/2017)
   --
   -- 23/05/2017 для определения S180 дополнительно обрабатываем счета типа 
   --            SS, SP при нулевых остатках и ненулевых Кт оборотах за месяц
   -- 09/08/2016 добавил условие  fost(a.acc, dat_) <> 0
   -- 08/08/2016 в одном из блоков для ACCOUNTS добавил условие
   --            and nvl(a.dazs, dat_+1) > dat_
   -- добавил обработку тип счета из ACCOUNTS (для типа SNA)
   -- переменную comm_ ограничил 200 символами
   
   -------------------------------------------------
is
   acco_    accounts.acc%type;
   nbs_     accounts.NLS%type:=substr(nls_,1,4);
   s080_os  specparam.S080%type;
   s080_r   specparam.S080%type;
   s180_k   specparam.S180%type;
   tips_sna accounts.TIP%type; 
   nls2_    accounts.NLS%type;
begin

   if substr(nls_,4,1) in ('8','9') 
   then
      select tip
         into tips_sna
      from accounts 
      where acc = acc_; 
   end if;

   if substr(nls_,4,1) in ('5','6','7','8','9') and
      nbs_ not in ('2607','2627','2657') then

      comm_ := substr(comm_ || 'ACC='||to_char(acc_)||' s080='||s080_||' s180='||s180_,1,200);

      BEGIN
         select k.acc, nvl(s.s180,'0'), k.nls
            into acc2_, s180_k, nls2_
         from nd_acc n1, nd_acc n, sal k, specparam s
         where n1.acc = acc_
           and n1.nd = n.nd
           and n.acc = k.acc
           and k.fdat = dat_
           and trim(k.tip) = 'SS'
           and nvl(s.s180,'0') not in ('0', '8', '9')
           and k.kv = kv_
           and k.ost <> 0
           and k.acc = s.acc
           and rownum = 1;
      EXCEPTION WHEN NO_DATA_FOUND THEN
          BEGIN
             select k.acc, nvl(s.s180,'0'), k.nls
                into acc2_, s180_k, nls2_
             from nd_acc n1, nd_acc n, sal k, specparam s
             where n1.acc = acc_
               and n1.nd = n.nd
               and n.acc = k.acc
               and k.fdat = dat_
               and trim(k.tip) = 'SP'
               and nvl(s.s180,'0') not in ('0', '8', '9')
               and k.kv = kv_
               and k.ost <> 0
               and k.acc = s.acc
               and rownum = 1;
          EXCEPTION WHEN NO_DATA_FOUND THEN
              BEGIN
                 select n.acc, nvl(s.s180,'0'), a.nls
                    into acc2_, s180_k, nls2_
                 from accounts a, specparam s, nd_acc n, nd_acc n1
                 where n1.acc = acc_
                   and n1.nd = n.nd
                   and n.acc = a.acc
                   and trim(a.tip) = 'SS'
                   and nvl(s.s180,'0') not in ('0', '8', '9')
                   and a.acc = s.acc
                   and nvl(a.dazs, dat_+1) > dat_ 
                   and fost(a.acc, dat_) <> 0  
                   and rownum = 1;
              EXCEPTION WHEN NO_DATA_FOUND THEN
                  BEGIN
                     select n.acc, nvl(s.s180,'0'), a.nls
                        into acc2_, s180_k, nls2_
                     from accounts a, specparam s, nd_acc n, nd_acc n1
                     where n1.acc = acc_
                       and n1.nd = n.nd
                       and n.acc = a.acc
                       and trim(a.tip) = 'SP'
                       and nvl(s.s180,'0') not in ('0', '8', '9')
                       --and a.acc <> acc_
                       and a.acc = s.acc
                       and nvl(a.dazs, dat_+1) > dat_ 
                       and fost(a.acc, dat_) <> 0 
                       and rownum = 1;
                  EXCEPTION WHEN NO_DATA_FOUND THEN
                      BEGIN
                         select n.acc, nvl(s.s180,'0'), a.nls
                            into acc2_, s180_k, nls2_
                         from accounts a, specparam s, nd_acc n, nd_acc n1
                         where n1.acc = acc_
                           and n1.nd = n.nd
                           and n.acc = a.acc
                           and trim(a.tip) in ('SS','SP')
                           and nvl(s.s180,'0') not in ('0', '8', '9')
                           --and a.acc <> acc_
                           and a.acc = s.acc
                           and fost(a.acc, dat_) <> 0
                           and nvl(a.dazs, dat_+1) > dat_
                           and rownum = 1;
                      EXCEPTION WHEN NO_DATA_FOUND THEN
                          BEGIN
                             select k.acc, nvl(s.s180,'0'), k.nls
                                into acc2_, s180_k, nls2_
                             from nd_acc n1, nd_acc n, sal k, specparam s
                             where n1.acc = acc_
                               and n1.nd = n.nd
                               and n.acc = k.acc
                               and k.fdat = dat_
                               and trim(k.tip) = 'SS'
                               and nvl(s.s180,'0') not in ('0', '8', '9')
                               and k.kv = kv_
                               and k.ost = 0
                               and FKOS(k.acc, trunc(dat_,'MM'), dat_) <> 0
                               and k.acc = s.acc
                               and rownum = 1;
                          EXCEPTION WHEN NO_DATA_FOUND THEN
                              BEGIN
                                 select k.acc, nvl(s.s180,'0'), k.nls
                                    into acc2_, s180_k, nls2_
                                 from nd_acc n1, nd_acc n, sal k, specparam s
                                 where n1.acc = acc_
                                   and n1.nd = n.nd
                                   and n.acc = k.acc
                                   and k.fdat = dat_
                                   and trim(k.tip) = 'SP'
                                   and nvl(s.s180,'0') not in ('0', '8', '9')
                                   and k.kv = kv_
                                   and k.ost = 0
                                   and FKOS(k.acc, trunc(dat_,'MM'), dat_) <> 0
                                   and k.acc = s.acc
                                   and rownum = 1;
                              EXCEPTION WHEN NO_DATA_FOUND THEN
                                 acc2_ := null;
                                 nls2_ := null;
                                 s180_k  := '0';
                              END;
                          END; 
                      END;
                  end;
              end;
          end;
      END;

      if acc2_ is not null then
          if s180_k <> '0' then 
             s180_ := s180_k;   
             comm_ := substr(comm_ || ' ACC1='||to_char(acc2_),1,200);
          end if;
      end if;
   elsif nbs_ IN ('2607', '2627', '2657')  
   THEN
      BEGIN
         SELECT max(i.acc)
            INTO acco_
         FROM int_accn i, accounts a
         WHERE i.acra = acc_
           AND ID = 0
           AND i.acc = a.acc
           AND a.nbs LIKE SUBSTR (nbs_, 1, 3) || '%'
           AND a.nbs <> nbs_;

         IF acco_ IS NOT NULL
         THEN
            acc_ := acco_;
            acc2_ := acc_;
         END IF;
      EXCEPTION WHEN NO_DATA_FOUND THEN
         NULL;
      END;
   else
      acc2_ := acc_;
   end if;
end;
/
show err;
