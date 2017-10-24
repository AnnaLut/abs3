
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/fin_zp.sql =========*** Run *** ====
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.FIN_ZP IS
   G_HEADER_VERSION  CONSTANT VARCHAR2(64)  := 'version 1.1.8  20.05.2015';


  aOKPO_      int;      -- активный код ОКПО
  aND_      int;      -- активный код ОКПО
  aDAT_       date;     -- активна дата



  ern CONSTANT POSITIVE   := 208;
  err EXCEPTION;
  erm VARCHAR2(80);



---------------------------------------------------------------
--
-- Розрахунок фінансових коефіцієнтів
--
---------------------------------------------------------------
  FUNCTION Calculation_KAT23 (aOBS_   int,
                              CLASS_  int,
                              cus_    int
						      ) RETURN  number;



---------------------------------------------------------------
--
-- Вичитуємо значення показника
--
---------------------------------------------------------------
  FUNCTION ZN_P (KOD_   char,
                 IDF_   int default 1,
				 DAT_   date default aDAT_,
				 OKPO_  int default  aOKPO_
			   ) RETURN  number;

  FUNCTION ZN_P_ND (KOD_   char,
                    IDF_   int default 1,
				    DAT_   date default aDAT_,
				    ND_    int default  aND_
			        ) RETURN  number;


procedure get_kat23(
                      RNK_ number,
					  DAT_ in date
					);

 procedure calculation_ZPRK(
                      rnk_ number,
                      ND_ number,
					  DAT_ in date,
					  fin23_ number,
					  obs23_ number,
					  kat23_ in out number,
					  vncr_ varchar2,
					  Err_Code    out int,
                      Err_Message out varchar2,
					  prk_ out number
					       );

procedure get_ZPRK(   RNK_ number,
                      ND_ number,
					  DAT_ in date,
					  VNCR_ in char default null,
					  Err_Code    out int,
                      Err_Message out varchar2
					);

 function zn_vncrr(
                    rnk_ number,
					nd_  number
					) return varchar2;

procedure set_nd_vncrr(
                         p_ND  in number ,
						 p_rnk in number ,
						 p_TXT in  varchar2
					    );

function zn_obs(
                    rnk_ number,
					dat_ date,
					okpo_ number
				)
                      return  number;


 procedure calculation_ZPRK_fl(
                      rnk_ number,
                      ND_ number,
					  DAT_ in date,
					  fin23_ number,
					  obs23_ number,
					  kat23_ number,
					  vncr_ varchar2,
					  Err_Code    out int,
                      Err_Message out varchar2,
					  prk_ out number
					       );

procedure get_ZPRK_fl(RNK_ number,
                      ND_ number,
					  DAT_ in date,
					  VNCR_ in char default null,
					  Err_Code    out int,
                      Err_Message out varchar2
					);

 function f_get_fin_nd (
                             rnk_ int,
                             nd_ int  default 0,
                             kod_ varchar2,
                             dat_p date,
                             dat_ date default sysdate
                            )
  return number;

procedure get_subpok (RNK_ number,
                      ND_ number,
					  DAT_ in date);

procedure calculation_ZPRK_bd(
                      rnk_ number,
                      ND_ number,
					  DAT_ in date,
					  fin23_ number,
					  obs23_ number,
					  kat23_ number,
					  vncr_ varchar2,
					  Err_Code    out int,
                      Err_Message out varchar2,
					  prk_ out number
					       );

procedure get_ZPRK_bd(RNK_ number,
                      ND_ number,
					  DAT_ in date,
					  VNCR_ in char default null,
					  Err_Code    out int,
                      Err_Message out varchar2
					);

function header_version return varchar2;

function body_version   return varchar2;


END fin_ZP;
/
CREATE OR REPLACE PACKAGE BODY BARS.FIN_ZP IS

 G_BODY_VERSION  CONSTANT VARCHAR2(64)  :=  'version 1.1.8  20.05.2015';
--------------------------------------------

  FUNCTION Calculation_KAT23 (aOBS_   int,
                              CLASS_  int,
							  cus_    int
						      ) RETURN  number
IS
KK_ number;

BEGIN



           begin
                             select kat
                               into KK_
                               from FIN_OBS_KAT
                                 where fin = CLASS_  and obs = aOBS_ and cus = cus_ ;
            exception when NO_DATA_FOUND
		         THEN
		      raise_application_error(-(20001),'/' ||'     Не визначено категорію якості кредиту -'||CLASS_||'-'||aOBS_||'-'||cus_||'***',TRUE);
            END;



return KK_;
END Calculation_KAT23;





  FUNCTION ZN_P (KOD_   char,
                 IDF_   int default 1,
				 DAT_   date default aDAT_,
				 OKPO_  int default aOKPO_
                 ) RETURN  number IS

 sTmp_ number := 0 ;

BEGIN

    BEGIN
    select s
	  into sTmp_
	  from fin_rnk
	 where okpo = OKPO_
       and fdat = DAT_
       and kod  = KOD_
	   and idf  = IDF_;
          exception when NO_DATA_FOUND
		         THEN sTmp_ := 0;
		--raise_application_error(-(20000),'\' ||'     '||KOD_||'Відсутні дані за звітний період - '||DAT_,TRUE);
    END;
  RETURN sTmp_;

end ZN_P;

  FUNCTION ZN_P_ND (KOD_   char,
                 IDF_   int default 1,
				 DAT_   date default aDAT_,
				 ND_    int default aND_
                 ) RETURN  number IS

 sTmp_ number := 0 ;

BEGIN

    BEGIN
    select s
	  into sTmp_
	  from fin_nd
	 where nd = ND_
       and fdat = DAT_
       and kod  = KOD_
	   and idf  = IDF_;
          exception when NO_DATA_FOUND
		         THEN sTmp_ := 0;
		--raise_application_error(-(20000),'\' ||'     '||KOD_||'Відсутні дані за звітний період - '||DAT_,TRUE);
    END;
  RETURN sTmp_;

end ZN_P_ND;

procedure get_kat23(
                      RNK_ number,
					  DAT_ in date
					)
IS
okpo_  number;
class_ number;
fin_   number;
KK_    number;

 BEGIN

		 begin
			  select okpo into okpo_
			   from fin_customer
			  where rnk = rnk_;
			  exception when NO_DATA_FOUND THEN
					raise_application_error(-(20000),'\ ' ||'     Не знайдено клієнта з RNK - '||rnk_,TRUE);
		 END;

             begin
                   select max(obs23), max(fin23)
				     into class_, fin_
			         from v_fin_cc_deal
				    where rnk = rnk_ --and sos<15
					 --and vidd in (1,2,3)
					 ;
 			  exception when NO_DATA_FOUND THEN
					null;
		     END;

			    class_:= nvl(class_, zn_p('OBS', '6', dat_, okpo_));
 		    	fin_  := nvl(fin_, zn_p('110', '6', dat_, okpo_));

        if class_ is not null then     fin_nbu.record_fp('OBS', class_, 6, DAT_, OKPO_ );
        end if;

        KK_ := Calculation_KAT23(class_, fin_, 2);
		fin_nbu.record_fp('080', KK_, 6, DAT_, OKPO_ );

 begin
  for k in
			   (  select nd , rnk
						from  v_fin_cc_deal c
							  where c.rnk = RNK_ --and c.sos <15
							  --and vidd in (1,2,3)
				)
		loop

			  update v_fin_cc_deal
				set kat23 = KK_
				  where nd = k.nd and rnk = k.rnk;


        end loop;
	    end;

 end get_kat23;

 procedure calculation_ZPRK(
                      rnk_ number,
                      ND_ number,
					  DAT_ in date,
					  fin23_ number,
					  obs23_ number,
					  kat23_ in out number,
					  vncr_ varchar2,
					  Err_Code    out int,
                      Err_Message out varchar2,
					  prk_ out number
					       )
IS
STOP_PRC EXCEPTION;
okpo_   number;
--rnk_   number;
nmk_  varchar2(180);
i_      number := 0;  -- кількість субєктивних показників
k_      number := 0;  -- сма значень субєктивних показників
k_min_  number;         -- мін значення прк
k_max_  number;         -- мах значення прк
--prk_  number;            -- показник ризику кредиту
kpb_  number;            -- кофіциент покритя боргу
val_    number := 0;
s_ number;
max_  number;         -- мах значення прк
min_  number;         -- min значення прк
vncrr_  varchar2(3);
vncr_k  varchar2(3) := null;


/*



  max_  number;         -- мах значення прк
vncrr_  varchar2(3);
aVNCRR_ varchar2(3);

*/

BEGIN


	  -- OBU індивідуально для Ощадбанк

 begin
 for k in (
                  select a.fin23, a.obs23, a.kod, a.val, a.IDF, q.name from (
             select fin23, obs23, kod, val, IDF
              from fin_kat
              UNPIVOT INCLUDE NULLS (VAL FOR KOD IN (ip1, ip2, ip3, ip4, ip5))
                 ) a, fin_question q
                 where a.fin23 = fin23_
                    and a.obs23 = obs23_
                    AND a.IDF = 7 and val is not null
                    and a.kod = q.kod and a.idf = q.idf

           )
		   loop

             begin
     		   select s into s_
			    from  fin_nd
				where nd = nd_ and rnk = rnk_
				      and kod = k.kod and idf = k.idf and s <> -99;
		    exception when NO_DATA_FOUND THEN
			    begin
				select s into s_
			    from  fin_nd
				where rnk = rnk_ and nd = 0
				      and kod = k.kod and s <> -99;
		             exception when NO_DATA_FOUND THEN
--					raise_application_error(-(20000),'\ ' ||'     Не заповнено субєктивний показник '||k.kod,TRUE);
 					    ERR_Code    := 1;
                        ERR_Message := '     Не заповнено субєктивний показник "'||k.name||'"';
					    raise STOP_PRC;
              end;
		    END;

		   if s_> k.val then k_ := 1;
		                else k_ := 0;
		   end if;

		   i_ := i_ + 1;
		   val_ := val_ + k_;

		   end loop;
		   end;

		   val_ := val_/i_;
	--	   logger.info('FIN0  val_='||val_||' i='||i_);

/* 		   select k, k2, vncrr--, kat23
		     into k_min_, k_max_, vncrr_--, kat23_
		     from fin_kat
            where obs23 = obs23_ and fin23 = fin23_
			  AND IDF = 7   ; */

			select k.k, k.k2, r.ord--, k.vncrr--, kat23
             into k_min_, k_max_, vncrr_--, kat23_
             from fin_kat k, (select distinct * from cck_rating) r
            where obs23 = obs23_ and fin23 = fin23_
              and k.vncrr = r.code
              AND k.IDF = 7   ;

	--	    logger.info('FIN=1- k_min_='||k_min_||' k_max_='|| k_max_||' vncrr_='|| vncrr_||' val='||val_);

		       begin
				select  k_max , k_min
				  into  max_ , min_
				  from stan_kat23
				 where kat = kat23_ ;
			  exception when NO_DATA_FOUND THEN
--					raise_application_error(-(20000),'\ ' ||'     Не визначено категорію якості для RNK - '||rnk_,TRUE);
 					    ERR_Code    := 1;
                        ERR_Message := '     Не визначено категорію якості для RNK - '||rnk_;
					    raise STOP_PRC;

    		 END;




          -- VNCR_ := zn_vncrr(rnk_);


    --       if  aVNCRR_ is null then aVNCRR_ := VNCR_; --'ААА';
	--	   end if;

		   select max(ord)
		     into vncr_k
		     from cck_rating
			where code = VNCR_;

		   if   vncr_k  is null or to_number(vncr_k) = 0   -- вивалить ошибку
 		                  then --raise_application_error(-(20000),'\ ' ||'     Не визначено внутрішній кредитний рейтинг для RNK - '||rnk_,TRUE);
						ERR_Code    := 1;
                        ERR_Message := '     Не визначено внутрішній кредитний рейтинг для RNK - '||rnk_;
					    raise STOP_PRC;

		   elsif  to_number(vncr_k) <= to_number(vncrr_)
		                 then
							   if val_<= 0.5 then prk_ := k_min_;
	--						    logger.info('FIN=3- prk_='||prk_||' k_min_='|| k_min_||' '|| ' val='||val_);

							   else prk_ := k_max_;
							   end if;

		   else prk_ := max_;
     --         logger.info('FIN=4- prk_='||prk_||' max_='|| max_||' '|| ' val='||val_);
		   end if;

   -- Заявка 10.12.2013 р. № 14/1-1348

	if 	(kat23_-1) >= 1 and
	    fin_nbu.zn_p_nd('INV', '32', dat_, nd_, rnk_)  = 2  and
		fin_nbu.zn_p_nd('IKY', '32', dat_, nd_, rnk_)  = 1
		   then
		               kat23_ := (kat23_-1);
		   		       begin
								select  k_max , k_min
								  into  max_ , min_
								  from stan_kat23
								 where kat = kat23_ ;
							  exception when NO_DATA_FOUND THEN
				--					raise_application_error(-(20000),'\ ' ||'     Не визначено категорію якості для RNK - '||rnk_,TRUE);
										ERR_Code    := 1;
										ERR_Message := '     Не визначено категорію якості для RNK - '||rnk_;
										raise STOP_PRC;
                		 END;

		        prk_   := max_;

	else null;
	end if;



	fin_nbu.record_fp_nd('KPB', round(prk_,2), 9, DAT_, ND_ , rnk_);

 exception
    when others then
      --rollback;
      if ERR_Message is null then
         ERR_Code    := 1;
         ERR_Message := SQLERRM;
      end if;
null;
END calculation_ZPRK;


procedure get_ZPRK(   RNK_ number,
                      ND_ number,
					  DAT_ in date,
					  VNCR_ in char default null,
					  Err_Code    out int,
                      Err_Message out varchar2
					)
IS
okpo_   number;       -- окпо
--rnk_    number;       -- окпо
nmk_    varchar2(180);
kat23_  number;       -- категорія якості
obs23_  number;       --
fin23_  number;       --
i_      number := 0;  -- кількість субєктивних показників
k_      number := 0;  -- сма значень субєктивних показників
val_    number := 0;
s_ number;
k_min_  number;         -- мін значення прк
k_max_  number;         -- мах значення прк
  max_  number;         -- мах значення прк
vncrr_  varchar2(3);
aVNCRR_ varchar2(3);
prk_  number;            -- показник ризику кредиту
kpb_  number;            -- кофіциент покритя боргу

STOP_PRC EXCEPTION;

 BEGIN

    ERR_Code    := null;
    ERR_Message := NULL;


 		 begin
			  select okpo, upper(nmk) into okpo_, nmk_
			   from fin_customer
			  where rnk = rnk_;
			  exception when NO_DATA_FOUND THEN
					     --raise_application_error(-(20000),'\ ' ||'     Не знайдено клієнта з RNK - '||rnk_,TRUE);
					    ERR_Code    := 1;
                        ERR_Message := '     Не знайдено клієнта з RNK - '||rnk_;
					    raise STOP_PRC;
		 END;


 begin


 if nd_ = 0 then

 		    begin
                   select max(kat23 ),  max(obs23), max(fin23)
					 into kat23_, obs23_,     fin23_
			         from v_fin_cc_deal
				    where rnk = rnk_ --and sos<15 -- and vidd in (1,2,3)
					                            ;
 			  exception when NO_DATA_FOUND THEN
                    null;
		     END;

 else
            begin
                   select max(kat23 ),  max(obs23), max(fin23)
					 into kat23_, obs23_,     fin23_
			         from v_fin_cc_deal
				    where nd = nd_ and rnk = rnk_ --and vidd in (1,2,3)
					                            ;
 			  exception when NO_DATA_FOUND THEN
                    null;
		     END;
 end if;

	                obs23_:= nvl(obs23_,fin_nbu.zn_p_nd('OBS', '6', dat_, nd_, rnk_));
 					fin23_:= nvl(fin23_,fin_nbu.zn_p_nd('110', '6', dat_, nd_, rnk_));
					kat23_:= Calculation_KAT23(obs23_, fin23_, 2);

					if fin23_ is null  or fin23_ = 0
					      then     ERR_Code    := 1;
                                   ERR_Message := 'Для РНК'||rnk_||' '||nmk_||' не визначено клас боржника. Для розрахунку значення показника ризику необхідно спочатку розрахувати інтегровані показники та клас боржника';
					               raise STOP_PRC;
					elsif obs23_ is null
					      then     ERR_Code    := 1;
                                   ERR_Message := 'Для РНК'||rnk_||' '||nmk_||' не визначено стан обслуговування боргу.';
					               raise STOP_PRC;
                    elsif kat23_ is null
					      then     ERR_Code    := 1;
                                   ERR_Message := 'Для РНК'||rnk_||' '||nmk_||' не визначено категорію якості.';
					               raise STOP_PRC;
					end if;

------


           calculation_ZPRK(rnk_, nd_, DAT_, fin23_, obs23_, kat23_, nvl(zn_vncrr(rnk_, nd_),VNCR_), ERR_Code, ERR_Message, prk_);
		   if ERR_Code = 1 then raise STOP_PRC;  end if;


		   begin
		   for i in (
		   	   select *
			    from v_fin_cc_deal c
			   where (c.nd = nd_  or nd_ = 0) and rnk = rnk_
		             )
		  loop

		  	--calculation_ZPRK(rnk_, i.nd, DAT_, fin23_, obs23_, kat23_, nvl(zn_vncrr(rnk_, i.nd),VNCR_), ERR_Code, ERR_Message, prk_);
		    --if ERR_Code = 1 then raise STOP_PRC;  end if;


				  update v_fin_cc_deal
					 set k23 = prk_, kat23 = kat23_
				   where nd = i.nd and rnk = i.rnk;


		  end loop;
		  end;

 				   --calculation_ZPRK(rnk_, nd_, DAT_, fin23_, obs23_, kat23_, nvl(zn_vncrr(rnk_, nd_),VNCR_), ERR_Code, ERR_Message, prk_);
				   fin_nbu.record_fp_nd('080', round(kat23_,2), 6, DAT_, ND_, rnk_ );
				   fin_nbu.record_fp_nd('KPB', round(prk_,2),   6, DAT_, ND_, rnk_ );
				   fin_nbu.record_fp_nd('OBS', round(obs23_,2), 6, DAT_, ND_, rnk_ );
				   fin_nbu.record_fp_nd('110', round(fin23_,2), 6, DAT_, ND_, rnk_ );


/*	fin_nbu.record_fp_nd('KPB', round(prk_,2), 9, DAT_, ND_, rnk_ );

  END LOOP;
 END; */

 end;

 exception
    when others then
      --rollback;
      if ERR_Message is null then
         ERR_Code    := 0;
         ERR_Message := SQLERRM;
      end if;

  -- <<exit_err>>


 END get_ZPRK;



 function zn_vncrr(
                    rnk_ number,
					nd_  number
					)
                      return  varchar2
IS
aVNCRR_ varchar2(3);
aVNCR_  varchar2(3);
l_tip   varchar2(10);
 begin

  begin
	 select tip
	   into l_tip
	 from v_fin_cc_deal
	where rnk = rnk_ and nd = nd_ and rownum =1;
  		 exception when NO_DATA_FOUND THEN
			l_tip := 'ACC';
   END;

   case

	 when l_tip in ( 'CCK','OVR' ) then

          aVNCRR_ := cck_app.get_nd_txt(nd_, 'VNCRR');

	 when l_tip in ( 'OW4','BPK' ) then

	 aVNCRR_ := bars_ow.get_nd_param(nd_, 'VNCRR');

     else

          aVNCRR_ := nvl(aVNCRR_, substr(f_get_custw_h (rnk_, 'VNCRR', gl.bd),1,3));

   end case;


		begin
		   select code
		   into  aVNCR_
		   from CCK_RATING
		  where code = aVNCRR_;
		     exception when NO_DATA_FOUND THEN
          return	null;
       	END;


	 return aVNCR_;


 end zn_vncrr;

 procedure set_nd_vncrr(
                         p_ND  in  number ,
						 p_rnk in  number ,
						 p_TXT in  varchar2
					    )
IS
deal_ varchar2(3);
l_col number:=0;
aVNCR_ varchar2(3);
l_vid  varchar2(3);
 begin

 		begin
		   select code
		   into  aVNCR_
		   from CCK_RATING
		  where code = p_TXT;
		     exception when NO_DATA_FOUND THEN
		             aVNCR_ := null;
       	END;

		if  aVNCR_ is not null and p_rnk > 0 then

		-------- запишем в карточку клієнта
		null;


        -- записуємо ВНКР в карточку клієнта
		select count(1) into l_col from customerw where rnk=p_rnk and tag='VNCRR' and isp !=0;
		if l_col >= 1 then
		   delete from customerw where rnk=p_rnk and tag='VNCRR';
		   kl.setCustomerElement(p_Rnk, 'VNCRR', aVNCR_, 0);
		else
		   kl.setCustomerElement(p_Rnk, 'VNCRR', aVNCR_, 0);
		end if;


		begin
		select tip
		  into l_vid
		  from v_fin_cc_deal
		 where nd = p_ND
    	  and rnk = p_rnk
		  and rownum = 1;
	    exception when NO_DATA_FOUND THEN
			deal_ := null;
     	END;

	  -- записуємо ВНКР в карточку кредитного модуля
		if l_vid in ( 'CCK','OVR' ) and p_nd > 0 then
		cck_app.Set_ND_TXT(p_ND, 'VNCRR',  trim (aVNCR_) );
		end if;

    	  -- OBU індивідуально для Ощадбанк

		 -- записуємо ВНКР в карточку БПК
        if l_vid in ( 'BPK','OW4' ) and p_nd > 0 then

		-- первинний ВНКР
		begin
		insert into BPK_PARAMETERS (nd, tag, value) values (p_ND , 'VNCRP' , trim (aVNCR_));
		exception when dup_val_on_index then null;
		end;

		-- поточний ВНКР   --VNCRR
		merge into BPK_PARAMETERS t using (
		select p_ND nd, 'VNCRR' tag, trim (aVNCR_) value from dual) tu
		on (t.nd=tu.nd and t.tag = tu.tag)
		when matched then update set value = tu.value
		when not matched then insert(t.nd, t.tag, t.value)
		values(tu.nd, tu.tag, tu.value);

		end if;





		end if;


 end set_nd_vncrr;



 function zn_obs(
                    rnk_ number,
					dat_ date,
					okpo_ number
				)
                      return  number
IS
obs23_ number;
 begin
 		    begin
                   select  max(obs23)
					 into obs23_
			         from v_fin_cc_deal
				    where rnk = rnk_ --and sos<15  and vidd in (1,2,3)
					;
 			  exception when NO_DATA_FOUND THEN
                    null;
		     END;


	                obs23_:= nvl(obs23_,zn_p('OBS', '6', dat_, okpo_));

					return obs23_;

 end zn_obs;

 procedure calculation_ZPRK_fl(
                      rnk_ number,
                      ND_ number,
					  DAT_ in date,
					  fin23_ number,
					  obs23_ number,
					  kat23_ number,
					  vncr_ varchar2,
					  Err_Code    out int,
                      Err_Message out varchar2,
					  prk_ out number
					       )
IS
STOP_PRC EXCEPTION;
okpo_   number;
--rnk_   number;
nmk_  varchar2(180);
i_      number := 0;  -- кількість субєктивних показників
k_      number := 0;  -- сма значень субєктивних показників
ip1_      number := 0;  -- значень субєктивних показників IP1
ip2_      number := 0;  -- значень субєктивних показників IP2
k_min_  number;         -- мін значення прк
k_max_  number;         -- мах значення прк
--prk_  number;            -- показник ризику кредиту
kpb_  number;            -- кофіциент покритя боргу
val_    number := 0;
s_ number;
max_  number;         -- мах значення прк
vncrr_  varchar2(3);
vncr_k  varchar2(3) := null;
l_idf  number;

BEGIN



	  -- OBU індивідуально для Ощадбанк


	    -- logger.info('KP0='||fin_nbu.zn_p_nd('KP0', '5', dat_, nd_, rnk_));
	  		   -- для спрощеної оцінки:
		   if nvl(fin_nbu.zn_p_nd('KP0', '5', dat_, nd_, rnk_),1) = 2
		              then i_    := 1;
					       l_idf := 25;
					  else l_idf := 20;
		   end if;

 begin
 for k in (
                  select a.fin23, a.obs23, a.kod, a.val, a.IDF, q.name from (
             select fin23, obs23, kod, val, IDF
              from fin_kat
              UNPIVOT INCLUDE NULLS (VAL FOR KOD IN (ip1, ip2, ip3, ip4, ip5))
                 ) a, fin_question q
                 where a.fin23 = fin23_
                    and a.obs23 = obs23_
                    AND a.IDF = l_idf and val is not null
                    and a.kod = q.kod and a.idf = q.idf

           )
		   loop

             begin
     		   select s into s_
			    from  fin_nd
				where nd = nd_
				      and kod = k.kod and rnk = rnk_ and idf = k.idf and s <> -99;
		    exception when NO_DATA_FOUND THEN
 					    ERR_Code    := 0;
                        ERR_Message := '     Не заповнено субєктивний показник "'||k.name||'"';
					    --raise STOP_PRC;
						s_ := 10;

		    END;

		   if s_> k.val then k_ := 1;
		                else k_ := 0;
		   end if;

		   i_ := i_ + 1;
		   val_ := val_ + k_;

		   end loop;
		   end;


		   if i_ = 0 then
		                ERR_Code    := 1;
                        ERR_Message := '     Невірно визначений клас "'||fin23_||'" або стан ослуговування боргу "'||obs23_||'" для фізичних осіб';
					    raise STOP_PRC;
		   end if;

		   val_ := val_/i_;
		--   logger.info('FIN0  val_='||val_||' i='||i_||' l_idf='||l_idf);


			select k.k, k.k2, r.ord--, k.vncrr--, kat23
             into k_min_, k_max_, vncrr_--, kat23_
             from fin_kat k, (select distinct * from cck_rating) r
            where obs23 = obs23_ and fin23 = fin23_
              and k.vncrr = r.code
              AND k.IDF = l_idf;

	    -- logger.info('FIN=1- k_min_='||k_min_||' k_max_='|| k_max_||' vncrr_='|| vncrr_||' val='||val_||' l_idf='||l_idf);

		       begin
				select  k_max
				  into  max_
				  from stan_kat23
				 where kat = kat23_ ;
			  exception when NO_DATA_FOUND THEN
--					raise_application_error(-(20000),'\ ' ||'     Не визначено категорію якості для RNK - '||rnk_,TRUE);
 					    ERR_Code    := 1;
                        ERR_Message := '     Не визначено категорію якості для RNK - '||rnk_;
					    raise STOP_PRC;

    		 END;



		   select max(ord)
		     into vncr_k
		     from cck_rating
			where code = VNCR_;

		   if   vncr_k  is null or to_number(vncr_k) = 0   -- вивалить ошибку
 		                  then --raise_application_error(-(20000),'\ ' ||'     Не визначено внутрішній кредитний рейтинг для RNK - '||rnk_,TRUE);
						ERR_Code    := 1;
                        ERR_Message := '     Не визначено внутрішній кредитний рейтинг для RNK - '||rnk_;
					    raise STOP_PRC;

		   elsif  to_number(vncr_k) <= to_number(vncrr_)
		                 then
							   if val_<= 0.5 then prk_ := k_min_;
	    --  logger.info('FIN=3- prk_='||prk_||' k_min_='|| k_min_||' '|| ' val='||val_);

							   else prk_ := k_max_;
							   end if;

		   else prk_ := max_;
         --     logger.info('FIN=4- prk_='||prk_||' max_='|| max_||' '|| ' val='||val_);
		   end if;




	fin_nbu.record_fp_nd('KPB', round(prk_,2), 9, DAT_, ND_ , rnk_);

 exception
    when others then
      --rollback;
      if ERR_Message is null then
         ERR_Code    := 0;
         ERR_Message := SQLERRM;
      end if;
null;
END calculation_ZPRK_fl;


procedure get_ZPRK_fl(RNK_ number,
                      ND_ number,
					  DAT_ in date,
					  VNCR_ in char default null,
					  Err_Code    out int,
                      Err_Message out varchar2
					)
IS
okpo_   number;       -- окпо
--rnk_    number;       -- окпо
nmk_    varchar2(180);
kat23_  number;       -- категорія якості
obs23_  number;       --
fin23_  number;       --
i_      number := 0;  -- кількість субєктивних показників
k_      number := 0;  -- сма значень субєктивних показників
val_    number := 0;
s_ number;
k_min_  number;         -- мін значення прк
k_max_  number;         -- мах значення прк
  max_  number;         -- мах значення прк
vncrr_  varchar2(3);
aVNCRR_ varchar2(3);
prk_  number;            -- показник ризику кредиту
kpb_  number;            -- кофіциент покритя боргу

STOP_PRC EXCEPTION;

 BEGIN

    ERR_Code    := null;
    ERR_Message := NULL;




  		 begin
			  select okpo, upper(nmk) into okpo_, nmk_
			   from fin_customer
			  where rnk = rnk_;
			  exception when NO_DATA_FOUND THEN
					     --raise_application_error(-(20000),'\ ' ||'     Не знайдено клієнта з RNK - '||rnk_,TRUE);
					    ERR_Code    := 1;
                        ERR_Message := '     Не знайдено клієнта з RNK - '||rnk_;
					    raise STOP_PRC;
		 END;


 begin


 if nd_ = 0 then

 		    begin
                   select max(kat23 ),  max(obs23), max(fin23)
					 into kat23_, obs23_,     fin23_
			         from v_fin_cc_deal
				    where rnk = rnk_ --and sos<15 -- and vidd in (1,2,3)
					                            ;
 			  exception when NO_DATA_FOUND THEN
                    null;
		     END;

 else
            begin
                   select max(kat23 ),  max(obs23), max(fin23)
					 into kat23_, obs23_,     fin23_
			         from v_fin_cc_deal
				    where nd = nd_ and rnk = rnk_
					                            ;
 			  exception when NO_DATA_FOUND THEN
                    null;
		     END;
 end if;

	                obs23_:= nvl(nvl(obs23_,fin_nbu.zn_p_nd('OBS', '6', dat_, nd_, rnk_)),1);
 					fin23_:= nvl(fin23_,fin_nbu.zn_p_nd('110', '6', dat_, nd_, rnk_));
					kat23_:= Calculation_KAT23(obs23_, fin23_, 3);

					if fin23_ is null  or fin23_ = 0
					      then     ERR_Code    := 1;
                                   ERR_Message := 'Для РНК'||rnk_||' '||nmk_||' не визначено клас боржника. Для розрахунку значення показника ризику необхідно спочатку розрахувати інтегровані показники та клас боржника';
					               raise STOP_PRC;
					elsif obs23_ is null
					      then     ERR_Code    := 1;
                                   ERR_Message := 'Для РНК'||rnk_||' '||nmk_||' не визначено стан обслуговування боргу.';
					               raise STOP_PRC;
                    elsif kat23_ is null
					      then     ERR_Code    := 1;
                                   ERR_Message := 'Для РНК'||rnk_||' '||nmk_||' не визначено категорію якості.';
					               raise STOP_PRC;
					end if;

			 /*
			  Субєктивні показники
			 */
------


		   begin
		   for i in (
		   	   select *
			    from v_fin_cc_deal c
			   where (c.nd = nd_  or nd_ = 0) and rnk = rnk_
				 --and c.sos < 15
				-- and --c.vidd in (1,2,3, 2600) )
		             )
		  loop

		   	calculation_ZPRK_fl(rnk_, i.nd, DAT_, fin23_, obs23_, kat23_, nvl(zn_vncrr(rnk_, i.nd),VNCR_), ERR_Code, ERR_Message, prk_);
		    if ERR_Code = 1 then raise STOP_PRC;  end if;


				  update v_fin_cc_deal
					 set k23 = prk_, kat23 = kat23_
				   where nd = i.nd and rnk = i.rnk;


		  end loop;
		  end;

 				   calculation_ZPRK_fl(rnk_, nd_, DAT_, fin23_, obs23_, kat23_, nvl(zn_vncrr(rnk_, nd_),VNCR_), ERR_Code, ERR_Message, prk_);
				   fin_nbu.record_fp_nd('080', round(kat23_,2), 6, DAT_, ND_, rnk_ );
				   fin_nbu.record_fp_nd('KPB', round(prk_,2),   6, DAT_, ND_, rnk_ );
				   fin_nbu.record_fp_nd('OBS', round(obs23_,2), 6, DAT_, ND_, rnk_ );
				   fin_nbu.record_fp_nd('110', round(fin23_,2), 6, DAT_, ND_, rnk_ );



/*	fin_nbu.record_fp_nd('KPB', round(prk_,2), 9, DAT_, ND_, rnk_ );

  END LOOP;
 END; */

 end;

 exception
    when others then
      --rollback;
      if ERR_Message is null then
         ERR_Code    := 0;
         ERR_Message := SQLERRM;
      end if;

  -- <<exit_err>>


 END get_ZPRK_fl;

 function f_get_fin_nd (
                             rnk_ int,
                             nd_ int  default 0,
                             kod_ varchar2,
                             dat_p date,
                             dat_ date default sysdate
                            )
  return number is

  s_ number(10,2);
begin

 select min(s)
      into s_
      from fin_nd_update u
     where idupd = (
                        select max(idupd)
                          from fin_nd_update
                         where nd = nd_
                           and kod = kod_
                           and rnk = rnk_
                           and fdat = dat_p
                           and trunc(chgdate) <= dat_
                       );


   IF s_ is null then
    -- берем текущее состояние
    select min(s)
      into s_
      from fin_nd
     where nd = nd_
               and rnk = rnk_
               and kod = kod_
               and fdat = dat_p;

  end if;

   /*  IF s_ is null then
    --
 select min(s)
      into s_
      from fin_nd_update u
     where idupd = (
                        select max(idupd)
                          from fin_nd_update
                         where nd = nd_
                           and kod = kod_
                           and rnk = rnk_
                           and fdat <=(select max(fdat) from fin_nd where fdat <=dat_p and rnk = rnk_ and kod = kod_)--<= dat_p
                           and trunc(chgdate) <= dat_
                       );

  end if;
   */
 /*    IF s_ is null then
    -- берем текущее состояние
    select min(s)
      into s_
      from fin_nd
     where nd = nd_
               and rnk = rnk_
               and kod = kod_
               and fdat <= dat_p ;

  end if; */




  return s_;
  End f_get_fin_nd;

procedure get_subpok (RNK_ number,
                      ND_ number,
					  DAT_ in date)
	is

	okpo_ number;
	datea_ date;
	ip1_ number;
	v_ip1_ number;

	T_diy_ number; -- Строк функціонування підприємства
	v_ip2  number;

	l_       number;
	l_coun_  number;

	k_ved_  number;

	l_chgp number; --Чистий грошовий потік
	l_vup_kd number; --Виплата за кредитними зобовязаннями.
	m_ number;
	n_ number;
	l_ip7 number;


	begin
null;
		begin
		select okpo, datea
   		into okpo_, datea_
		from fin_customer
		where rnk = rnk_;
		  exception when NO_DATA_FOUND THEN
					     raise_application_error(-(20000),'\ ' ||'     Не знайдено клієнта з RNK - '||rnk_,TRUE);

		 END;

--  IP1 Динаміка інтегрального показника

		  if zn_p('IPB',6, add_months(trunc(DAT_),-3), okpo_) != 0 then

			  	 if zn_p('IPB',6, add_months(trunc(DAT_),-3), okpo_) < zn_p('IPB',6, add_months(trunc(DAT_),-0), okpo_) then v_ip1_ := 1;
		      elsif zn_p('IPB',6, add_months(trunc(DAT_),-3), okpo_) = zn_p('IPB',6, add_months(trunc(DAT_),-0), okpo_) then v_ip1_ := 2;
		      else                                                                                                           v_ip1_ := 3;
		    end if;

		  else

		   if      -1 < zn_p('IPB',6, add_months(trunc(DAT_),-0), okpo_) then v_ip1_ := 1;
		   elsif   -1 = zn_p('IPB',6, add_months(trunc(DAT_),-0), okpo_) then v_ip1_ := 2;
		   else                                                               v_ip1_ := 3;
		    end if;
		  end if;

		fin_nbu.record_fp_nd('IP2', v_ip1_, 7, DAT_, ND_, rnk_ );


end get_subpok;




 procedure calculation_ZPRK_bd(
                      rnk_ number,
                      ND_ number,
					  DAT_ in date,
					  fin23_ number,
					  obs23_ number,
					  kat23_ number,
					  vncr_ varchar2,
					  Err_Code    out int,
                      Err_Message out varchar2,
					  prk_ out number
					       )
IS
STOP_PRC EXCEPTION;
okpo_   number;
nmk_  varchar2(180);
i_      number := 0;  -- кількість субєктивних показників
k_      number := 0;  -- сма значень субєктивних показників
k_min_  number;         -- мін значення прк
k_max_  number;         -- мах значення прк
kpb_  number;            -- кофіциент покритя боргу
val_    number := 0;
s_ number;
max_  number;         -- мах значення прк
vncrr_  varchar2(3);
vncr_k  varchar2(3) := null;

BEGIN

	  -- OBU індивідуально для Ощадбанк

 begin
 for k in (
                  select a.fin23, a.obs23, a.kod, a.val, a.IDF, q.name from (
             select fin23, obs23, kod, val, IDF
              from fin_kat
              UNPIVOT INCLUDE NULLS (VAL FOR KOD IN (ip1, ip2, ip3, ip4, ip5))
                 ) a, fin_question q
                 where a.fin23 = fin23_
                    and a.obs23 = obs23_
                    AND a.IDF = 23 and val is not null
                    and a.kod = q.kod and a.idf = q.idf

           )
		   loop

             begin
     		   select s into s_
			    from  fin_nd
				where nd = nd_
				      and kod = k.kod and rnk = rnk_ AND IDF = k.idf and s <> -99;
		    exception when NO_DATA_FOUND THEN
 					    ERR_Code    := 0;
                        ERR_Message := '     Не заповнено субєктивний показник "'||k.name||'"';
						s_ := 10;

		    END;

		   if s_> k.val then k_ := 1;
		                else k_ := 0;
		   end if;

		   i_ := i_ + 1;     val_ := val_ + k_;
		   end loop;
		   end;

		   if i_ = 0 then
		                ERR_Code    := 1;
                        ERR_Message := '     Невірно визначений клас "'||fin23_||'" або стан ослуговування боргу "'||obs23_||'" для фізичних осіб';
					    raise STOP_PRC;
		   end if;

		   val_ := val_/i_;

			select k.k, k.k2, r.ord
             into k_min_, k_max_, vncrr_
             from fin_kat k, (select distinct * from cck_rating) r
            where obs23 = obs23_ and fin23 = fin23_
              and k.vncrr = r.code
              AND k.IDF = 20   ;

		       begin
				select  k_max
				  into  max_
				  from stan_kat23
				 where kat = kat23_ ;
			  exception when NO_DATA_FOUND THEN
 					    ERR_Code    := 1;
                        ERR_Message := '     Не визначено категорію якості для RNK - '||rnk_;
					    raise STOP_PRC;
    		 END;



		   select max(ord)
		     into vncr_k
		     from cck_rating
			where code = VNCR_;

		   if   vncr_k  is null or to_number(vncr_k) = 0
 		                  then
						ERR_Code    := 1;
                        ERR_Message := '     Не визначено внутрішній кредитний рейтинг для RNK - '||rnk_;
					    raise STOP_PRC;

		   elsif  to_number(vncr_k) <= to_number(vncrr_)
		                 then
							   if val_<= 0.5 then prk_ := k_min_;
							   else prk_ := k_max_;
							   end if;

		   else prk_ := max_;
    	   end if;




	fin_nbu.record_fp_nd('KPB', round(prk_,2), 9, DAT_, ND_ , rnk_);

 exception
    when others then
      --rollback;
      if ERR_Message is null then
         ERR_Code    := 0;
         ERR_Message := SQLERRM;
      end if;
null;
END calculation_ZPRK_bd;


procedure get_ZPRK_bd(RNK_ number,
                      ND_ number,
					  DAT_ in date,
					  VNCR_ in char default null,
					  Err_Code    out int,
                      Err_Message out varchar2
					)
IS
okpo_   number;       -- окпо
nmk_    varchar2(180);
kat23_  number;       -- категорія якості
obs23_  number;       --
fin23_  number;       --
i_      number := 0;  -- кількість субєктивних показників
k_      number := 0;  -- сма значень субєктивних показників
val_    number := 0;
s_ number;
k_min_  number;         -- мін значення прк
k_max_  number;         -- мах значення прк
  max_  number;         -- мах значення прк
vncrr_  varchar2(3);
aVNCRR_ varchar2(3);
prk_  number;            -- показник ризику кредиту
kpb_  number;            -- кофіциент покритя боргу

STOP_PRC EXCEPTION;

 BEGIN

    ERR_Code    := null;
    ERR_Message := NULL;




  		 begin
			  select okpo, upper(nmk) into okpo_, nmk_
			   from fin_customer
			  where rnk = rnk_;
			  exception when NO_DATA_FOUND THEN
					    ERR_Code    := 1;
                        ERR_Message := '     Не знайдено клієнта з RNK - '||rnk_;
					    raise STOP_PRC;
		 END;

		 begin


 if nd_ = 0 then

 		    begin
                   select max(kat23 ),  max(obs23), max(fin23)
					 into kat23_, obs23_,     fin23_
			         from v_fin_cc_deal
				    where rnk = rnk_;
 			  exception when NO_DATA_FOUND THEN
                    null;
		     END;

 else
            begin
                   select max(kat23 ),  max(obs23), max(fin23)
					 into kat23_, obs23_,     fin23_
			         from v_fin_cc_deal
				    where nd = nd_ and rnk = rnk_
					                            ;
 			  exception when NO_DATA_FOUND THEN
                    null;
		     END;
 end if;

	                obs23_:= nvl(nvl(obs23_,fin_nbu.zn_p_nd('OBS', '6', dat_, nd_, rnk_)),1);
 					fin23_:= nvl(fin23_,fin_nbu.zn_p_nd('110', '6', dat_, nd_, rnk_));
					kat23_:= Calculation_KAT23(obs23_, fin23_, 4);

					if fin23_ is null  or fin23_ = 0
					      then     ERR_Code    := 1;
                                   ERR_Message := 'Для РНК'||rnk_||' '||nmk_||' не визначено клас боржника. Для розрахунку значення показника ризику необхідно спочатку розрахувати інтегровані показники та клас боржника';
					               raise STOP_PRC;
					elsif obs23_ is null
					      then     ERR_Code    := 1;
                                   ERR_Message := 'Для РНК'||rnk_||' '||nmk_||' не визначено стан обслуговування боргу.';
					               raise STOP_PRC;
                    elsif kat23_ is null
					      then     ERR_Code    := 1;
                                   ERR_Message := 'Для РНК'||rnk_||' '||nmk_||' не визначено категорію якості.';
					               raise STOP_PRC;
					end if;

			 /*
			  Субєктивні показники
			 */


		   begin
		   for i in (
		   	   select *
			    from v_fin_cc_deal c
			   where (c.nd = nd_  or nd_ = 0) and rnk = rnk_
		             )
		  loop
		   	calculation_ZPRK_bd(rnk_, i.nd, DAT_, fin23_, obs23_, kat23_, nvl(zn_vncrr(rnk_, i.nd),VNCR_), ERR_Code, ERR_Message, prk_);
		    if ERR_Code = 1 then raise STOP_PRC;  end if;
				  update v_fin_cc_deal
					 set k23 = prk_, kat23 = kat23_
				   where nd = i.nd and rnk = i.rnk;
		  end loop;
		  end;

 				   calculation_ZPRK_bd(rnk_, nd_, DAT_, fin23_, obs23_, kat23_, nvl(zn_vncrr(rnk_, nd_),VNCR_), ERR_Code, ERR_Message, prk_);
				   fin_nbu.record_fp_nd('080', round(kat23_,2), 6, DAT_, ND_, rnk_ );
				   fin_nbu.record_fp_nd('KPB', round(prk_,2),   6, DAT_, ND_, rnk_ );
 end;

 exception
    when others then
      --rollback;
      if ERR_Message is null then
         ERR_Code    := 0;
         ERR_Message := SQLERRM;
      end if;

 END get_ZPRK_bd;




/**
 * header_version - возвращает версию заголовка пакета fin_ZP
 */
function header_version return varchar2 is
begin
  return 'Package header fin_ZP '||G_HEADER_VERSION;
end header_version;

/**
 * body_version - возвращает версию тела пакета fin_ZP
 */
function body_version return varchar2 is
begin
  return 'Package body fin_ZP '||G_BODY_VERSION;
end body_version;
--------------
END fin_ZP;
/
 show err;
 
PROMPT *** Create  grants  FIN_ZP ***
grant EXECUTE                                                                on FIN_ZP          to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/fin_zp.sql =========*** End *** ====
 PROMPT ===================================================================================== 
 