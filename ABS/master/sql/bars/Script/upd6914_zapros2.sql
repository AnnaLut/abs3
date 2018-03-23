
Prompt   update zapros for 'выгрузка протокола #A7'
BEGIN
    bc.home;

    update zapros
       set create_stmt =
'TOBO       [22,  '' '',L];
NLS       [14, '' '',L];
KV        [3,  '' '',L];
DATF    [10, '' '',L]; 
ACC      [10,  '' '',L];
DK        [1,'' '',L];
NBS      [4, '' '',L];
KV1      [3,  '' '',L];
R011     [1,  '' '',L];
S181     [1,  '' '',L];
R013     [1,  '' '',L];
S240     [1,  '' '',L];
K030     [1, '' '',L];
S190     [1,  '' '',L];
ZNAP    [14, '' '',L];
RNK      [10,  '' '',L];
OKPO    [14, '' '',L];
NMK      [70,  '' '',L];
MDATE  [10, '' '',L];
ISP        [6,  '' '',L];
ND        [10, '' '',L];
CC_ID   [50, '' '',L];
SDATE  [10, '' '',L];
WDATE  [10, '' '',L];
REF        [10, '' '',L];
COMM   [160,  '' '',L];
Delim='';''  '
     where pkey ='\BRS\SBM\OTC\4010';

COMMIT;
EXCEPTION WHEN OTHERS THEN 
   NULL;
END;
/
