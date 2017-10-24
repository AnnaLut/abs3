

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/GURN_ACC9.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  procedure GURN_ACC9 ***

  CREATE OR REPLACE PROCEDURE BARS.GURN_ACC9      (usid_ int, FROM_ DATE, TO_ date) IS
  CURSOR ALL_ACCOUNTS IS
    SELECT distinct ACC FROM ACCOUNTS_UPDATE WHERE CHGDATE >= FROM_ AND CHGDATE < TO_+1;
  CURSOR ALL_CHANGES (ACC_ NUMBER) IS
    SELECT ISP,NMS,PAP,VID,POS,BLKD,BLKK,CHGDATE,CHGACTION,dazs,idupd,doneby
       FROM ACCOUNTS_UPDATE
       WHERE CHGDATE >= FROM_ AND CHGDATE < TO_+1 AND ACC=ACC_
       ORDER BY trunc(CHGDATE),idupd;
  CURSOR PREV_CHANGE (ACC_ NUMBER, idupd_ number) IS
    SELECT ISP,NMS,PAP,VID,POS,BLKD,BLKK,CHGDATE,CHGACTION,dazs,idupd,doneby
           FROM ACCOUNTS_UPDATE
           WHERE ACC=ACC_ AND
	   idupd=(SELECT MAX(idupd) FROM ACCOUNTS_UPDATE WHERE idupd<idupd_ );
--
Acc_rec_k All_Changes%ROWTYPE;
TYPE    AccUpTyp IS TABLE OF Accounts_update%ROWTYPE INDEX BY BINARY_INTEGER;
type tb2_acc is table of Accounts_update.acc%type INDEX BY BINARY_INTEGER;
Acc_Up AccUpTyp; TB2 tb2_acc;
i       BINARY_INTEGER := 0;
rec2 Accounts_update%ROWTYPE;
type t_rec8 is record
     (chd date, acc int, fl int :=0, fl1 int :=0, fl2 int :=0, fl3 int :=0, frs int :=0);
rec8 t_rec8;
type t_tb8 is table of rec8%type INDEX BY BINARY_INTEGER;
tb8 t_tb8;  i8 BINARY_INTEGER := 0; i8a BINARY_INTEGER := 0;
type t_rec7 is record
     (ISP Accounts_update.isp%type, NMS Accounts_update.nms%type, PAP Accounts_update.pap%type,
      VID Accounts_update.vid%type, POS Accounts_update.pos%type,
      BLKD Accounts_update.blkd%type, BLKK Accounts_update.blkk%type, CHGDATE Accounts_update.chgdate%type,
      CHGACTION Accounts_update.chgaction%type, DAZS Accounts_update.dazs%type,
      idupd Accounts_update.idupd%type, doneby Accounts_update.doneby%type);
REC7 T_REC7;
rec31 t_rec7;
  type t_TB6 is table of Accounts_update.chgaction%type INDEX BY BINARY_INTEGER;
TB6 t_tb6;
TYPE T_TB5 IS TABLE OF rec31%type INDEX BY BINARY_INTEGER;
TB5 T_TB5;
type t_rec4 is record
     (fl_2 int :=0, i_mx int :=0);
rec4 t_rec4;
type t_tb4 is table of rec4%type INDEX BY BINARY_INTEGER;
tb4 t_tb4;
  PREV_ROW ALL_CHANGES%ROWTYPE;
---------
----   Select records from Accounts_update into Tmp_acc_regs
---------
  fla int; flb int; flc int; fl0 int;
  chd_f date; cha_f number; acc_f number;
  first int;  i_max int;
  CHG_ACT_ int;       kt_  varchar2(12) :=' .ÚÓ˜Í‡ ';
  FIRST_ROW NUMBER;
  NEED_WRITE NUMBER;
ern         CONSTANT POSITIVE := 208;
err         EXCEPTION;
erm         VARCHAR2(80);
BEGIN
     delete from tmp_acc_reg9  where usid=usid_;
  FOR C IN ALL_ACCOUNTS LOOP
    FIRST_ROW := 1;  i:=0; i_max:=0;
    FOR C2 IN ALL_CHANGES(C.ACC) LOOP
	  NEED_WRITE:=0;
          CHG_ACT_:=0;
       --Õ¿…“» œ–≈ƒ «¿œ»—‹ ƒÀﬂ œ≈–¬Œ… «¿œ»—» œŒ —◊≈“”
	  IF FIRST_ROW=1 THEN
	    FIRST_ROW:=0;
        OPEN PREV_CHANGE(C.ACC, C2.idupd);
	    FETCH PREV_CHANGE INTO PREV_ROW;
	    IF PREV_CHANGE %NOTFOUND THEN
	      --œ–≈ƒ. »«Ã≈Õ≈Õ»≈ Õ≈ Õ¿…ƒ≈ÕŒ
		  NEED_WRITE:=1;
            if c2.chgaction=2 then
               CHG_ACT_:=5;
            end if;
IF deb.debug THEN
   deb.trace( ern, '1. ACC,CHGACTION', c.acc ||','||c2.chgaction||',*'||c2.CHGDATE||'' );
END IF;
		END IF;
		CLOSE PREV_CHANGE;
	  END IF;
	  IF NEED_WRITE=0 THEN
        --—–¿¬Õ»“‹ — “≈ ”Ÿ≈…
	    IF C2.ISP<>PREV_ROW.ISP OR
		   C2.PAP<>PREV_ROW.PAP OR
                   C2.BLKD<>PREV_ROW.BLKD OR
                   C2.BLKK<>PREV_ROW.BLKK OR
                   C2.POS<>PREV_ROW.POS OR
		   C2.VID<>PREV_ROW.VID OR
		   C2.NMS<>PREV_ROW.NMS or
                   (c2.dazs is NULL and prev_row.dazs is not NULL)
                      then
		  NEED_WRITE:=1;
                  CHG_ACT_:=2;
		END IF;
            if c2.dazs is not NULL then
               need_write:=1; chg_act_:=3;
               end if;
IF deb.debug and NEED_WRITE=1 THEN
   deb.trace( ern, '2. ACC,CHGACTION', c.acc ||','||c2.chgaction||',*'||c2.CHGDATE||'+' );
END IF;
	  END IF;
       --≈—À» Œ“À»◊¿≈“—ﬂ - «¿œ»—¿“‹ ¬Œ ¬–≈Ã “¿¡À»÷”
	  IF NEED_WRITE=1 THEN
       i := i + 1;  i_max:=i;
        Acc_rec_k:=c2;  tb2(i):=c.acc;
         TB5(i).isp:=c2.ISP; TB5(i).nms:=c2.NMS; TB5(i).pap:=c2.PAP; TB5(i).vid:=c2.VID;
         TB5(i).pos:=c2.POS; TB5(i).blkd:=c2.BLKD; TB5(i).blkk:=c2.BLKK;
         TB5(i).CHGDATE:=c2.CHGDATE; TB5(i).CHGACTION:=c2.CHGACTION;
         TB5(i).dazs:=c2.dazs;       tb5(i).idupd:=c2.idupd;
         TB5(i).doneby:=c2.doneby;
         tb6(i):=7;
	  END IF;
	  --—Œ’–¿Õ»“‹ “≈  «¿œ»—‹
	  PREV_ROW := C2;
	END LOOP;            -- C2
        chd_f:=trunc(TB5(1).CHGDATE); cha_f:=8;  i8:=1; tb8(i8).chd:=chd_f;
        acc_f:=tb2(1);
        tb8(i8).frs:=0; tb8(i8).fl:=0; tb8(i8).fl1:=0; tb8(i8).fl2:=0; tb8(i8).fl3:=0;
        tb4(i8).i_mx:=0;
 FOR i IN 1 .. i_max
   loop
--  !! ‡Î„ÓËÚÏ ‡·ÓÚ‡ÂÚ ‚ ‰Ë‡Ô‡ÁÓÌÂ ‰‡Ú
         if trunc(TB5(i).chgdate)<>chd_f then
            chd_f:= trunc(TB5(i).chgdate); i8:=i8+1; tb8(i8).chd:=chd_f;
            tb8(i8).acc:=acc_f;
            tb8(i8).frs:=0; tb8(i8).fl:=0; tb8(i8).fl1:=0; tb8(i8).fl2:=0; tb8(i8).fl3:=0;
            tb4(i8).i_mx:=0;
--            tb4(i8).id_o:=0; tb4(i8).id_m:=0; tb4(i8).id_c:=0; tb4(i8).id_r:=0;
         end if;
          if  TB5(i).chgaction=1 then tb8(i8).fl1:=1;  --tb6(i):=1;
              elsif  TB5(i).chgaction=2 then tb8(i8).fl2:=1;  tb4(i8).i_mx:=i;
              elsif  TB5(i).chgaction=3 then tb8(i8).fl3:=1;
              else tb8(i8).fl:=1;
          end if;
          if tb8(i8).fl1=1 and tb8(i8).fl3=0 then tb8(i8).frs:=1; end if;
          if tb8(i8).fl2=1 and tb8(i8).frs=0 then tb8(i8).frs:=2; end if;
          if tb8(i8).fl3=1 and tb8(i8).fl1=0 then tb8(i8).frs:=3; end if;
          if tb8(i8).fl=1 then tb8(i8).frs:=4; end if;
IF deb.debug THEN
   deb.trace( ern, '3. tb8', tb2(i)||','||TB5(i).chgaction||','||tb8(i8).frs||tb8(i8).fl||tb8(i8).fl1||tb8(i8).fl2||tb8(i8).fl3||'' );
END IF;
   end loop;
                         i8a:=1;
   FOR i IN 1 .. i_max
   loop
         if tb8(i8a).chd<>trunc(TB5(i).chgdate) then
            i8a:=i8a+1; end if;
                   if (tb8(i8a).frs=4 and TB5(i).chgaction=1)
                      or (tb8(i8a).frs=4 and TB5(i).chgaction=0 and tb8(i8a).fl1=0) then
                -- insert first OPEN or reanimation
         INSERT INTO TMP_ACC_REG9
                	VALUES (tb2(i),
      TB5(i).ISP, TB5(i).NMS, TB5(i).PAP, TB5(i).VID, TB5(i).POS,
      TB5(i).BLKD, TB5(i).BLKK, TB5(i).CHGDATE, TB5(i).CHGACTion, TB5(i).dazs,
      tb5(i).idupd, tb5(i).doneby, usid_);
                    end if;
             if tb8(i8a).frs=1 then
          if TB5(i).chgaction<>2 then
                -- insert all bat modif
    	  INSERT INTO TMP_ACC_REG9
                	VALUES (tb2(i),
      TB5(i).ISP, TB5(i).NMS, TB5(i).PAP, TB5(i).VID, TB5(i).POS,
      TB5(i).BLKD, TB5(i).BLKK, TB5(i).CHGDATE, TB5(i).CHGACTion, TB5(i).dazs,
      tb5(i).idupd, tb5(i).doneby, usid_);
       end if;   end if;
               if tb8(i8a).frs=2 then
          if TB5(i).chgaction=2 and tb4(i8).i_mx=i  then
                -- insert last modif
    	  INSERT INTO TMP_ACC_REG9
                	VALUES (tb2(i),
      TB5(i).ISP, TB5(i).NMS, TB5(i).PAP, TB5(i).VID, TB5(i).POS,
      TB5(i).BLKD, TB5(i).BLKK, TB5(i).CHGDATE, TB5(i).CHGACTion, TB5(i).dazs,
      tb5(i).idupd, tb5(i).doneby, usid_);
       end if;   end if;
       if (tb8(i8a).frs=3 and TB5(i).chgaction=3) then
                -- insert only closed
    	  INSERT INTO TMP_ACC_REG9
                	VALUES (tb2(i),
      TB5(i).ISP, TB5(i).NMS, TB5(i).PAP, TB5(i).VID, TB5(i).POS,
      TB5(i).BLKD, TB5(i).BLKK, TB5(i).CHGDATE, TB5(i).CHGACTion, TB5(i).dazs,
      tb5(i).idupd, tb5(i).doneby, usid_);
       end if;
   end loop;
  END LOOP;
  commit;
END;
 
/
show err;

PROMPT *** Create  grants  GURN_ACC9 ***
grant EXECUTE                                                                on GURN_ACC9       to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on GURN_ACC9       to RPBN001;
grant EXECUTE                                                                on GURN_ACC9       to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/GURN_ACC9.sql =========*** End ***
PROMPT ===================================================================================== 
