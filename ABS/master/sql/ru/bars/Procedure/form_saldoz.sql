CREATE OR REPLACE PROCEDURE BARS.form_saldoz
( z_dat31 DATE
, p_acc   number default null
) IS
-- Перенакопичення виправних оборотів за звітну дату
-- $Ver: 0.0.21716 2017-04-12 09:35:54Z% $
  l_dat    DATE := trunc( z_dat31, 'MM' ); -- 1e число звітного місяця
-- Інтервал накопичення:
  l_dat0   DATE := add_months( l_dat, 1 );
  l_dat1   DATE := last_day(l_dat0);
BEGIN
  
  bars_audit.info('FORM_SALDOZ START:'||to_char(l_dat,'dd/mm/yyyy')||' по '||to_char(z_dat31,'dd/mm/yyyy'));
  bars_audit.info('FORM_SALDOZ обороти:'||to_char(l_dat0,'dd/mm/yyyy')||' < '||to_char(l_dat1,'dd/mm/yyyy')); 
    
  if p_acc is null 
  then
      
    bars_audit.info('FORM_SALDOZ -- all accounts --'); 

    DELETE FROM saldoz WHERE fdat = l_dat;
    
    INSERT INTO saldoz (  FDAT, ACC, DOS, KOS, DOSQ, KOSQ )
    SELECT  l_dat, o.ACC,
           SUM (DECODE (o.dk, 0, o.s, 0)) dos,
           SUM (DECODE (o.dk, 1, o.s, 0)) kos,
           SUM (DECODE (o.dk, 0, o.sq, 0)) dosq,
           SUM (DECODE (o.dk, 1, o.sq, 0)) kosq
      FROM opldok o
      join oper d
        on (  d.REF = o.REF )
     WHERE o.FDAT between l_dat0 AND l_dat1
--     and o.kf = '300465'
       AND o.sos = 5
       and d.VDAT = z_dat31 
       and d.VOB = 96
     GROUP BY  o.ACC;
    
    insert
      into SALDOZ ( FDAT, ACC, DOS, KOS, DOSQ, KOSQ ) 
    select  s.FDAT, a.ACCC
         , sum(s.DOS)  as DOS
         , sum(s.KOS)  as KOS
         , sum(s.DOSQ) as DOSQ
         , sum(s.KOSQ) as KOSQ  
      from saldoz s
      join accounts a
        on (  a.ACC = s.ACC )
     WHERE s.FDAT = l_dat
       and a.NBS Is Null
     group by  s.FDAT, a.ACCC;
     
  else
    
    bars_audit.info('FORM_SALDOZ -- acc = '||p_acc||' --' ); 
    
    DELETE FROM saldoz WHERE fdat = l_dat and acc = p_acc;
    
    INSERT INTO saldoz (acc, fdat,dos,kos,dosq,kosq)
    SELECT acc, l_dat,
           SUM(DECODE( dk, 0, s,  0 )) dos,
           SUM(DECODE( dk, 1, s,  0 )) kos,
           SUM(DECODE( dk, 0, sq, 0 )) dosq,
           SUM(DECODE( dk, 1, sq, 0 )) kosq
      FROM OPLDOK o
     WHERE o.FDAT between l_dat0 AND l_dat1 
       AND o.SOS = 5
       and o.ACC = p_acc
       AND EXISTS ( SELECT 1 FROM oper
                     WHERE vob = 96
                       AND REF = o.REF
                       AND ( (vdat >= l_dat AND vdat<=z_dat31) OR vdat=to_date('01012017','ddmmyyyy') )
                  )
     GROUP BY acc;
    
  end if;
  
  bars_audit.info( 'FORM_SALDOZ: Finish: сформовано '||to_char(sql%rowcount)||' записів.' );
   
END;
/