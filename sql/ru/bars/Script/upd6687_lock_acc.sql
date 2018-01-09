begin
  BARS.BC.SUBST_MFO(BARS.F_OURMFO_G());
  for c in ( SELECT ACC
               FROM accounts
              where NBS  = '2620'
                and OB22 = '34'
                and DAZS is null
                and BLKD <> 2 )
  loop
    update BARS.ACCOUNTS
       set BLKD = 2
     where ACC = c.ACC;
    BARS.accreg.setAccountSob( c.ACC, Null, bars.gl.aUID, bars.gl.bDATE, 'Заблоковано здійснення видаткових операцій згідно COBUSUPABS-5211' );
  end loop;
  BARS.BC.HOME;
end;
/

commit;
