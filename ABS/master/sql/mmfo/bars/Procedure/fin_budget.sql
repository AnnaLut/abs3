

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/FIN_BUDGET.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  procedure FIN_BUDGET ***

  CREATE OR REPLACE PROCEDURE BARS.FIN_BUDGET (fdat_ in date)
 is
    s integer;
	s1 integer;
	s2 integer;
	s3 integer;
	s4 integer;
	s5 integer;
	s6 integer;
	s7 integer;
	s5_7 integer;
	s7_5 integer;
	s9_10 integer;
	s8 integer;
	s9 integer;
	s10 integer;
	s11 integer;
	s12 integer;
	s13 integer;
	s14 integer;
	s15 integer;
	s16 integer;
	s17 integer;
	s18 integer;
	s19 integer;
	s20 integer;
	s21 integer;
	s22 integer;
	s23 integer;
	s24 integer;
	s25 integer;
	s26 integer;
	s27 integer;
	s28 integer;
	s29 integer;
	s30 integer;
	s31 integer;
	s32 integer;
	s33 integer;
	s34 integer;
	s35 integer;
	s36 integer;
	s37 integer;
	s38 integer;
	s39 integer;
	s40 integer;
	s41 integer;
	s42 integer;
	s43 integer;
	s44 integer;
	s45 integer;
	s46 integer;
	s47 integer;
	s48 integer;
	s49 integer;
	s50 integer;
	s51 integer;
	s52 integer;
	s53 integer;
	s54 integer;
	s55 integer;
	s56 integer;
	s57 integer;
	s58 integer;
	s59 integer;
	s60 integer;
	s61 integer;
	s62 integer;
	s63 integer;
	s64 integer;
	s65 integer;
	s66 integer;
	s67 integer;
	s68 integer;
	s69 integer;
	s70 integer;
	s71 integer;
	s72 integer;
	s73 integer;
	s74 integer;
	s75 integer;
	s76 integer;
	s77 integer;
	s78 integer;
	s79 integer;
	s80 integer;
	s81 integer;
	s82 integer;
	s83 integer;
	s84 integer;
	s85 integer;
	s86 integer;
	s87 integer;
	s88 integer;
	s89 integer;
	s90 integer;
	s91 integer;
	s92 integer;
	s93 integer;
	s94 integer;
	s95 integer;
	s96 integer;
	s97 integer;
	s98 integer;
	s99 integer;
	s100 integer;
	s101 integer;
	s102 integer;
	s103 integer;
	s104 integer;
	s105 integer;
	s106 integer;
	s107 integer;
	s108 integer;
	s109 integer;
	s110 integer;
	s111 integer;

 begin

	 -- create table temp_fin_budget(
     --        n600_602 number,
     --        n602 number
      --);

	  delete from temp_fin_budget;

--------------------------------------------------------------

	  select sum(ost) into s
      from sal
      where fdat=fdat_ and
            substr(nls,1,3) in ('600','601')
			and ost>=0;

	  select sum(ost) into s1
      from sal
      where fdat=fdat_ and
            substr(nls,1,3) in ('602')
			and ost>=0;

	  select sum(ost) into s2
      from sal
      where fdat=fdat_ and
            substr(nls,1,3) in ('603')
			and ost>=0;

	  select sum(ost) into s3
      from sal
      where fdat=fdat_ and
            substr(nls,1,3) in ('604')
			and ost>=0;

	  select sum(ost) into s4
      from sal
      where fdat=fdat_ and
            substr(nls,1,3) in ('605')
			and ost>=0;

	  select sum(ost) into s5
      from sal
      where fdat=fdat_ and
            substr(nls,1,3) in ('608')
			and ost>=0;

	  select sum(ost) into s6
      from sal
      where fdat=fdat_ and
            substr(nls,1,3) in ('609')
			and ost>=0;

	  select abs(sum(ost)) into s7
      from sal
      where fdat=fdat_ and
            substr(nls,1,3) in ('708')
			and ost<=0;

	  if s5-s7>0 then s5_7:=s5-s7;
	  else s5_7:=0;
	  end if;

	  if s7-s5>0 then s7_5:=s7-s5;
	  else s7_5:=0;
	  end if;

	  s22:=s+s1+s2+s3+s4+s5_7+s6;

	  select abs(sum(ost)) into s8
      from sal
      where fdat=fdat_ and
            substr(nls,1,3) in ('700','701')
			and ost<=0;

	  select abs(sum(ost)) into s9
      from sal
      where fdat=fdat_ and
            substr(nls,1,3) in ('702')
			and ost<=0;

	  select abs(sum(ost)) into s10
      from sal
      where fdat=fdat_ and
            substr(nls,1,3) in ('702')
			and ost>=0;

	  s9_10:=s9-s10;

	  select abs(sum(ost)) into s11
      from sal
      where fdat=fdat_ and
            substr(nls,1,3) in ('703')
			and ost<=0;


	  select nvl(abs(sum(ost)),0) into s12
      from sal
      where fdat=fdat_ and
            substr(nls,1,4) in ('7040')
			and ost<=0;

	  select nvl(abs(sum(ost)),0) into s13
      from sal
      where fdat=fdat_ and
            substr(nls,1,4) in ('7041')
			and ost<=0;

	  select nvl(sum(ost),0) into s15
      from sal
      where fdat=fdat_ and
            substr(nls,1,4) in ('7041')
			and ost>=0;

	  s16:=s13-s15;
	  s14:=s16+s12;

	  select nvl(abs(sum(ost)),0) into s17
      from sal
      where fdat=fdat_ and
            substr(nls,1,3) in ('705')
			and ost<=0;

	  select nvl(sum(ost),0) into s18
      from sal
      where fdat=fdat_ and
            substr(nls,1,3) in ('705')
			and ost>=0;

	  s19:=s17-s18;

	  select nvl(abs(sum(ost)),0) into s20
      from sal
      where fdat=fdat_ and
            substr(nls,1,3) in ('709')
			and ost<=0;

	  s21:=s19+s20+s14+s8+s9_10+s11+s7_5;

	  s23:=s22-s21;

	  select nvl(sum(ost),0) into s24
      from sal
      where fdat=fdat_ and
            substr(nls,1,3) in ('610','611')
			and ost>=0;

	  select nvl(sum(ost),0) into s25
      from sal
      where fdat=fdat_ and
            substr(nls,1,3) in ('618')
			and ost>=0;


	  select nvl(abs(sum(ost)),0) into s26
      from sal
      where fdat=fdat_ and
            substr(nls,1,3) in ('718')
			and ost<=0;

	  select nvl(abs(sum(ost)),0) into s27
      from sal
      where fdat=fdat_ and
            substr(nls,1,3) in ('710')
			and ost<=0;

	  if s25-s26>0 then s28:=s25-s26;
	  else
	  s28:=0;
	  end if;

	  if s26-s25>0 then s29:=s26-s25;
	  else
	  s29:=0;
	  end if;

	  s30:=s24+s28;
	  s31:=s27+s29;

	  s32:=s30-s31;

	  select nvl(sum(ost),0) into s33
      from sal
      where fdat=fdat_ and
            substr(nls,1,4) in ('6204')
			and ost>=0;


	  select nvl(abs(sum(ost)),0) into s34
      from sal
      where fdat=fdat_ and
            substr(nls,1,4) in ('6204')
			and ost<=0;

	  s35:=s33-s34;

	  select nvl(sum(ost),0) into s36
      from sal
      where fdat=fdat_ and
            substr(nls,1,4) in ('6203')
			and ost>=0;


	  select nvl(abs(sum(ost)),0) into s37
      from sal
      where fdat=fdat_ and
            substr(nls,1,4) in ('6203')
			and ost<=0;

	  select nvl(sum(ost),0) into s38
      from sal
      where fdat=fdat_ and
            substr(nls,1,4) in ('7703')
			and ost>=0;


	  select nvl(abs(sum(ost)),0) into s39
      from sal
      where fdat=fdat_ and
            substr(nls,1,4) in ('7703')
			and ost<=0;

	  s40:=s36-s37-(s39-s38);

	  select nvl(sum(ost),0) into s41
      from sal
      where fdat=fdat_ and
            substr(nls,1,4) in ('6209')
			and ost>=0;


	  select nvl(abs(sum(ost)),0) into s42
      from sal
      where fdat=fdat_ and
            substr(nls,1,4) in ('6209')
			and ost<=0;

	  s43:=s41-s42;

	  s44:=s43+s40+s35;

	  select nvl(sum(ost),0) into s45
      from sal
      where fdat=fdat_ and
            substr(nls,1,4) in ('6395','6396','6397','6399','6493','6497','6499','6801')
			and substr(nls,1,3) in ('630')
			and ost>=0;

	  select nvl(sum(ost),0) into s46
      from sal
      where fdat=fdat_ and
            substr(nls,1,4) in ('6490')
			and ost>=0;


	  select nvl(abs(sum(ost)),0) into s47
      from sal
      where fdat=fdat_ and
            substr(nls,1,4) in ('7490')
			and ost<=0;

	  if s46-s47>0 then s48:=s46-s47;
	  else s48:=0;
	  end if;

	  select nvl(sum(ost),0) into s49
      from sal
      where fdat=fdat_ and
            substr(nls,1,4) in ('6394')
			and ost>=0;


	  select nvl(abs(sum(ost)),0) into s50
      from sal
      where fdat=fdat_ and
            substr(nls,1,4) in ('7394')
			and ost<=0;

	  s51:=s49-s50;

	  select nvl(sum(ost),0) into s52
      from sal
      where fdat=fdat_ and
            substr(nls,1,3) in ('638')
			and ost>=0;


	  select nvl(abs(sum(ost)),0) into s53
      from sal
      where fdat=fdat_ and
            substr(nls,1,3) in ('738')
			and ost<=0;

	  if s52-s53>0 then s54:=s52-s53;
	  else s54:=0;
	  end if;

	  select nvl(sum(ost),0) into s55
      from sal
      where fdat=fdat_ and
            substr(nls,1,3) in ('648')
			and ost>=0;


	  select nvl(abs(sum(ost)),0) into s56
      from sal
      where fdat=fdat_ and
            substr(nls,1,3) in ('748')
			and ost<=0;

	  if s55-s56>0 then s57:=s55-s56;
	  else s57:=0;
	  end if;

	  s58:=s57+s54+s51+s48+s45;

	  s59:=s58+s44+s32+s23;

	  select nvl(abs(sum(ost)),0) into s60
      from sal
      where fdat=fdat_ and
            substr(nls,1,3) in ('741')
			and ost<=0;

	  select nvl(abs(sum(ost)),0) into s61
      from sal
      where fdat=fdat_ and
            substr(nls,1,4) in ('7420')
			and ost<=0;

	  select nvl(abs(sum(ost)),0) into s62
      from sal
      where fdat=fdat_ and
            substr(nls,1,4) in ('7430')
			and ost<=0;

	  select nvl(abs(sum(ost)),0) into s63
      from sal
      where fdat=fdat_ and
            substr(nls,1,4) in ('7431')
			and ost<=0;

	  select nvl(abs(sum(ost)),0) into s64
      from sal
      where fdat=fdat_ and
            substr(nls,1,4) in ('7432')
			and ost<=0;

	  select nvl(abs(sum(ost)),0) into s65
      from sal
      where fdat=fdat_ and
            substr(nls,1,4) in ('7433')
			and ost<=0;

	  select nvl(abs(sum(ost)),0) into s66
      from sal
      where fdat=fdat_ and
            substr(nls,1,3) in ('744')
			and ost<=0;

	  select nvl(abs(sum(ost)),0) into s67
      from sal
      where fdat=fdat_ and
            substr(nls,1,4) in ('7451')
			and ost<=0;

	  select nvl(abs(sum(ost)),0) into s68
      from sal
      where fdat=fdat_ and
            substr(nls,1,4) in ('7452')
			and ost<=0;

	  select nvl(abs(sum(ost)),0) into s69
      from sal
      where fdat=fdat_ and
            substr(nls,1,4) in ('7455')
			and ost<=0;

	  select nvl(abs(sum(ost)),0) into s70
      from sal
      where fdat=fdat_ and
            substr(nls,1,4) in ('7423')
			and ost<=0;

	  select nvl(abs(sum(ost)),0) into s71
      from sal
      where fdat=fdat_ and
            substr(nls,1,4) in ('7421')
			and ost<=0;

	  select nvl(abs(sum(ost)),0) into s72
      from sal
      where fdat=fdat_ and
            substr(nls,1,4) in ('7395')
			and ost<=0;

	  s73:=s71+s72;

	  select nvl(abs(sum(ost)),0) into s74
      from sal
      where fdat=fdat_ and
            substr(nls,1,4) in ('7390','7396','7397','7399','7801')
			and ost<=0;

	  if s53-s52>0 then s75:=s53-s52;
	  else s75:=0;
	  end if;

	  s76:=s74+s75;

	  select nvl(abs(sum(ost)),0) into s77
      from sal
      where fdat=fdat_ and
            substr(nls,1,4) in ('7450','7453','7454','7456','7493','7497','7499')
			and ost<=0;

	  if s56-s55>0 then s78:=s56-s55;
	  else s78:=0;
	  end if;

	  if s47-s46>0 then s79:=s47-s46;
	  else s79:=0;
	  end if;

	  s80:=s77+s78+s79;

	  s110:=s80+s76;

	  select nvl(abs(sum(ost)),0) into s81
      from sal
      where fdat=fdat_ and
            substr(nls,1,4) in ('7400')
			and ost<=0;

	  select nvl(abs(sum(ost)),0) into s82
      from sal
      where fdat=fdat_ and
            substr(nls,1,4) in ('7401','7402')
			and ost<=0;

	  select nvl(abs(sum(ost)),0) into s83
      from sal
      where fdat=fdat_ and
            substr(nls,1,4) in ('7403')
			and ost<=0;

	  select nvl(abs(sum(ost)),0) into s84
      from sal
      where fdat=fdat_ and
            substr(nls,1,4) in ('7409')
			and ost<=0;

	  s85:=s81+s82+s83+s84;

	  s86:=s60+s61+s62+s63+s64+s65+s66+s67+s68+s69;

	  s87:=s86+s70+s73+s76;

	  s88:=s59-s87-s85;

	  select nvl(sum(ost),0) into s89
      from sal
      where fdat=fdat_ and
            substr(nls,1,4) in ('7702','6712')
			and ost>=0;


	  select nvl(abs(sum(ost)),0) into s90
      from sal
      where fdat=fdat_ and
            substr(nls,1,4) in ('7702','7712')
			and ost<=0;

	  s91:=s90-s89;

	  select nvl(sum(ost),0) into s92
      from sal
      where fdat=fdat_ and
            substr(nls,1,4) in ('7701','7706','6711')
			and ost>=0;


	  select nvl(abs(sum(ost)),0) into s93
      from sal
      where fdat=fdat_ and
            substr(nls,1,4) in ('7701','7706','7711')
			and ost<=0;

	  s94:=s93-s92;

	  select nvl(sum(ost),0) into s95
      from sal
      where fdat=fdat_ and
            substr(nls,1,4) in ('7704','6713','6714')
			and ost>=0;


	  select nvl(abs(sum(ost)),0) into s96
      from sal
      where fdat=fdat_ and
            substr(nls,1,4) in ('7704','7713','7714')
			and ost<=0;

	  s97:=s96-s95;

	  select nvl(sum(ost),0) into s98
      from sal
      where fdat=fdat_ and
            substr(nls,1,4) in ('7700','7707','6715','6710')
			and ost>=0;


	  select nvl(abs(sum(ost)),0) into s99
      from sal
      where fdat=fdat_ and
            substr(nls,1,4) in ('7700','7707','7715','7710')
			and ost<=0;

	  s100:=s99-s98;

	  select nvl(sum(ost),0) into s101
      from sal
      where fdat=fdat_ and
            substr(nls,1,4) in ('6717','7707')
			and ost>=0;


	  select nvl(abs(sum(ost)),0) into s102
      from sal
      where fdat=fdat_ and
            substr(nls,1,4) in ('7717','7707')
			and ost<=0;

	  s103:=s96-s95;

	  select nvl(abs(sum(ost)),0) into s104
      from sal
      where fdat=fdat_ and
            substr(nls,1,4) in ('7900')
			and ost<=0;

	  select nvl(sum(ost),0) into s105
      from sal
      where fdat=fdat_ and
            substr(nls,1,4) in ('6809')
			and ost>=0;


	  select nvl(abs(sum(ost)),0) into s106
      from sal
      where fdat=fdat_ and
            substr(nls,1,4) in ('7809')
			and ost<=0;

	  s107:=s105-s106;

	  s109:=s91+s94+s97+s100+s103;

	  s108:=s88-s109-s104+s107;



-----------------------------------------------------------------

 --     insert into temp_fin_budget (n600_601,n602,n603,n604,n605,n608_708,n609,suma1,a708_p608,a700_a701,a702_p702,a703,s41_42,
 --  a7040,a_7041_p7041,a705_p705,a709,suma2,suma1_2,p610_611,a710,suma4_5,p6204_a6204,p6203_a6203,p6209_a6209,suma7,p6394,
 --	  SUMA3_6_7_8, SUMA10,SUMA1_10,A741,A7420,A7430,A7431,A7432,A7433,A744,A7451,A7452,A7455,A7423,SUMA31_32,A7421,
 --	  A7395,SUMA41_42,A7390,A7450,SUMA11,A7400,A7401,A7403,A7409,SUMA13,SUMA14,A7702,A7701,A7704,A7700,A7717,A7900,P6809_A7809,
 --	  SUMA13_14_15_16)
 --	  values (s,s1,s2,s3,s4,s5_7,s6,s22,s7_5,s8,s9_10,s11,s14,s12,s16,s19,s20,s21,s23,s30,s31,s32,s35,s40,s43,s44,s58,s59,
 --	  s87,s86,s60,s61,s62,s63,s64,s65,s66,s67,s68,s69,s70,s73,s71,s72,s110,s76,s80,s85,s81,s82,s83,s84,s88,s109,s91,s94,s97,
 --	  s100,s103,s104,s107,s108);

	  insert into temp_fin_budget2 (NMS,S) values ('І. Процентні доходи всього',s22);
	  insert into temp_fin_budget2 (NMS,S) values ('1. За коштами,розміщеними в банках',s);

 end fin_budget;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/FIN_BUDGET.sql =========*** End **
PROMPT ===================================================================================== 
