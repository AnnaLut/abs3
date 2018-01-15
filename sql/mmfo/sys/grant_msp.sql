 grant exempt access policy to MSP;

  ALTER USER msp quota unlimited on users;
 /
  ALTER USER msp quota unlimited on brssmld;
 /
  ALTER USER msp quota unlimited on brssmli;
 /
  ALTER USER msp quota unlimited on BRSBIGD;
 /
  ALTER USER msp quota unlimited on BRSBIGI;
 /
  ALTER USER msp quota unlimited on BRSDYND;
 /
  ALTER USER msp quota unlimited on BRSDYNI;
 /


commit;
