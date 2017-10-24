

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_KOR_PROV.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_KOR_PROV ***

  CREATE OR REPLACE PROCEDURE BARS.P_KOR_PROV (vob_ in number,
	   	  		  			acc_ in number, dat1_ in date, dat2_ in date,
	   	  		  			Dosnk_ out number, Kosnk_ out number,
							tp_ in number default 0, -- = 0 -номінал,
							-- = 1 - еквівалент залишки
							-- = 2 - еквівалент обороти
							kv_ in number default null, -- для розрахунку еквіваленту
							dat_ in date default null -- для розрахунку еквіваленту
							) is
begin
  begin
  	if tp_ = 0 then
		SELECT SUM(DECODE(d.dk, 0, d.s, 0)),
			   SUM(DECODE(d.dk, 1, d.s, 0))
		INTO Dosnk_, Kosnk_
		FROM  kor_prov d
		WHERE d.acc=acc_ AND
			  d.fdat between Dat1_ and Dat2_ AND
			  d.vob = vob_;
	elsif tp_ = 1 then
		SELECT SUM(DECODE(d.dk, 0, GL.P_ICURVAL(kv_, d.s, Dat_), 0)),
		       SUM(DECODE(d.dk, 1, GL.P_ICURVAL(kv_, d.s, Dat_), 0))
		INTO Dosnk_, Kosnk_
		FROM  kor_prov d
		WHERE d.acc=acc_                   AND
		      d.fdat between dat1_ and  dat2_ AND
		      d.vob = vob_;
	else
		SELECT SUM(DECODE(a.dk, 0, GL.P_ICURVAL(kv_, a.s, a.vDat), 0)),
		   	   SUM(DECODE(a.dk, 1, GL.P_ICURVAL(kv_, a.s, a.vDat), 0))
		INTO Dosnk_, Kosnk_
		FROM kor_prov a
		WHERE a.acc=acc_                   AND
		      a.fdat > Dat1_               AND
		      a.fdat <= Dat2_               AND
		      a.vob=vob_;
	end if;
  EXCEPTION WHEN NO_DATA_FOUND THEN
	Dosnk_ :=0 ;
	Kosnk_ :=0 ;
  end;

  Dosnk_ := nvl(Dosnk_,0);
  Kosnk_ := nvl(Kosnk_,0);

  return;
END;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_KOR_PROV.sql =========*** End **
PROMPT ===================================================================================== 
