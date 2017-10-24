

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/PK_SET_SPARAM_2625K58.sql ========
PROMPT ===================================================================================== 


PROMPT *** Create  procedure PK_SET_SPARAM_2625K58 ***

  CREATE OR REPLACE PROCEDURE BARS.PK_SET_SPARAM_2625K58 ( ACC_2625 NUMBER, NLS_2625 VARCHAR2, KV_2625 NUMBER ) IS
--
-- version 12.11.2010
--
  TIP_     CHAR(3);
  TIP_OK   NUMBER;
  S080_    VARCHAR2(1);
  S180_    VARCHAR2(1);
  S240_    VARCHAR2(2);
  OB22_    VARCHAR2(2);
BEGIN
  --2625k50XXXXXXXX -  ‡Ú. Ò˜ÂÚ (œ‡ÒÒË‚Ì˚È)
  --2625k58XXXXXXXX - “Âı. Ó‚Â‰‡ÙÚ Í ÌÂÏÛ (¿ÍÚË‚Ì˚È)

  BARS_AUDIT.TRACE('PK_SET_SPARAM_2625K58 '||CHR(13)||CHR(10)||
                   '  ACC_2625='||ACC_2625|| CHR(13)||CHR(10)||
                   '  NLS_2625='||NLS_2625|| CHR(13)||CHR(10)||
                   '  KV_2625='||KV_2625 );

  --œŒÀ”◊≈Õ»≈ “»œ¿ Œ—Õ —◊≈“¿ 2625
  SELECT TIP INTO TIP_
    FROM ACCOUNTS
   WHERE SUBSTR(NLS,8,7) = SUBSTR(NLS_2625,8,7)
     and substr(nls,6,2) = case substr(NLS_2625,6,2)
                           when '59' then '51'
                           when '57' then '52'
                           when '56' then '53'
                           when '55' then '54'
                           else '50'
                           end
     AND SUBSTR(TIP,1,2) = 'PK' AND TIP NOT IN ('PKY', 'PKZ')
     AND KV = KV_2625;

  S080_:='1';
  S180_:='5';
  S240_:='5';

  --Œœ–≈ƒ≈À≈Õ»≈ «Õ¿◊≈Õ»… —œ≈÷œ¿–¿Ã≈“–Œ¬
  --≈—À» Õ≈Œ¡’Œƒ»ÃŒ Õ¿’Œ∆ƒ≈Õ»≈ —◊≈“¿ 2201
  TIP_OK:=0;
  IF TIP_='PK1' THEN
    OB22_:='01';
    TIP_OK:=1;
  ELSIF TIP_='PK2' THEN
    OB22_:='02';
    TIP_OK:=1;
  ELSIF TIP_='PK4' THEN
    OB22_:='04';
    TIP_OK:=1;
  ELSIF TIP_='PK5' THEN
    OB22_:='05';
    TIP_OK:=1;
  ELSIF TIP_='PK6' THEN
    OB22_:='06';
    TIP_OK:=1;
  ELSIF TIP_='PK8' THEN
    OB22_:='08';
    TIP_OK:=1;
  ELSIF TIP_='PK9' THEN
    OB22_:='09';
    TIP_OK:=1;
  END IF;

  BARS_AUDIT.TRACE('PK_SET_SPARAM_2625K58 '||CHR(13)||CHR(10)||
                   '  TIP_='||TIP_|| CHR(13)||CHR(10)||
                   '  S080_='||S080_|| CHR(13)||CHR(10)||
                   '  S180_='||S180_|| CHR(13)||CHR(10)||
                   '  S240_='||S240_|| CHR(13)||CHR(10)||
                   '  OB22_='||OB22_|| CHR(13)||CHR(10)||
                   '  TIP_OK='||TIP_OK|| CHR(13)||CHR(10)
                   );

  --¬—“¿¬ ¿ —œ≈÷œ¿–¿Ã≈“–Œ¬
  IF TIP_OK=1 THEN

     --¬ SPECPARAM
     UPDATE SPECPARAM SET S080=S080_,S180=S180_,S240=S240_ WHERE ACC=ACC_2625;
     if sql%rowcount = 0 then
       INSERT INTO SPECPARAM (ACC,S080,S180,S240)
       VALUES (ACC_2625,S080_,S180_,S240_);
     end if;

     --¬ SPECPARAM_INT
     UPDATE SPECPARAM_INT SET OB22=OB22_ WHERE ACC=ACC_2625;
     if sql%rowcount = 0 then
        INSERT INTO SPECPARAM_INT (ACC,OB22)
        VALUES (ACC_2625,OB22_);
     end if;

  END IF;

EXCEPTION
  WHEN OTHERS THEN
     BARS_AUDIT.TRACE('PK_SET_SPARAM_2625K58 - ERROR '||CHR(13)||CHR(10)|| SQLERRM );
END;
/
show err;

PROMPT *** Create  grants  PK_SET_SPARAM_2625K58 ***
grant EXECUTE                                                                on PK_SET_SPARAM_2625K58 to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/PK_SET_SPARAM_2625K58.sql ========
PROMPT ===================================================================================== 
