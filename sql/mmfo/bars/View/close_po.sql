

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/CLOSE_PO.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view CLOSE_PO ***

  CREATE OR REPLACE FORCE VIEW BARS.CLOSE_PO ("ACC", "KF", "NLS", "KV", "BRANCH", "NLSALT", "NBS", "NBS2", "DAOS", "DAPP", "ISP", "NMS", "LIM", "OSTB", "OSTC", "OSTF", "OSTQ", "DOS", "KOS", "DOSQ", "KOSQ", "PAP", "TIP", "VID", "TRCN", "MDATE", "DAZS", "SEC", "ACCC", "BLKD", "BLKK", "POS", "SECI", "SECO", "GRP", "OSTX", "RNK", "NOTIFIER_REF", "TOBO", "BDATE", "OPT", "OB22", "DAPPQ", "SEND_SMS") AS 
  select a."ACC",a."KF",a."NLS",a."KV",a."BRANCH",a."NLSALT",a."NBS",a."NBS2",a."DAOS",a."DAPP",a."ISP",a."NMS",a."LIM",a."OSTB",a."OSTC",a."OSTF",a."OSTQ",a."DOS",a."KOS",a."DOSQ",a."KOSQ",a."PAP",a."TIP",a."VID",a."TRCN",a."MDATE",a."DAZS",a."SEC",a."ACCC",a."BLKD",a."BLKK",a."POS",a."SECI",a."SECO",a."GRP",a."OSTX",a."RNK",a."NOTIFIER_REF",a."TOBO",a."BDATE",a."OPT",a."OB22",a."DAPPQ",a."SEND_SMS"
from accounts a, specparam_int s
where a.acc = s.acc and (a.ostc <> 0 or a.dazs is null )
 and (         a.nbs='8020'
OR a.nbs='8000' and s.p080 in ('0001' , '0002' , '0003' , '0004' , '0005' , '0006' , '0007' , '0008' , '0009' , '0193' , '0030' ,
                               '0011' , '0012' , '0013' , '0014' , '0015' , '0016' , '0017' , '0018' , '0019' , '0310' , '0184' ,
                               '0020' , '0021' , '0022' , '0023' , '0024' , '0025' , '0026' , '0027' , '0181' , '0028' , '0029' ,
                               '0031' , '0032' , '0033' , '0034' , '0035' , '0036' , '0037' , '0038' , '0039' , '0040' , '0182' )
OR a.nbs='8002' and s.p080 in ('0041' , '0183' , '0185' , '0316' , '0317' , '0318' )
OR a.nbs='8010' and s.p080 in ('0042' , '0044' , '0045' , '0046' , '0047' , '0048' , '0049' , '0050' , '0051' , '0052' , '0053' ,
                               '0054' , '0055' , '0056' , '0057' , '0058' , '0059' , '0060' , '0061' , '0062' , '0063' , '0064' ,
                               '0066' , '0068' , '0080' , '0083' , '0085' , '0086' , '0087' , '0088' , '0065' , '0067' , '0081' ,
                               '0082' , '0089' , '0090' , '0091' , '0092' , '0093' , '0094' , '0095' , '0096' , '0097' , '0098' ,
                               '0099' , '0100' , '0101' , '0104' , '0105' , '0106' , '0107' , '0108' , '0109' , '0110' , '0111' ,
                               '0112' , '0115' , '0117' , '0084' , '0102' , '0103' , '0118' , '0079' , '0186' , '0188' , '0190' ,
                               '0313' )
OR a.nbs='8013' and s.p080 in ('0043' , '0116' , '0114' , '0187' , '0189' , '0191' , '0308' , '0309' , '0319' , '0320' , '0321' )
OR a.nbs='8031' and s.p080 in ('0192' , '0322' , '0323' , '0206' , '0207' )
OR a.nbs='8032' and s.p080 in ('0134' , '0135' )
OR a.nbs='8030' and s.p080 in ('0180' )
OR a.nbs='8051' and s.p080 in ('0208' , '0209' , '0210' , '0211' , '0212' , '0213' , '2014' , '0215' , '0216' , '0217' , '0218' ,
                               '0219' , '0220' , '0237' , '0238' , '0239' , '0240' , '0241' , '0242' , '0243' , '0244' , '0245' ,
                               '0246' , '0247' , '0248' , '0249' , '0250' , '0251' , '0252' , '0253' , '0286' , '0287' , '0288' ,
                               '0289' , '0290' , '0291' , '0292' , '0293' , '0324' , '0325' , '0326' , '0327' , '0335' , '0336' ,
                               '0337' , '0338' , '0339' , '0338' , '0339' , '0305' , '0306' , '0311' , '0312' )
OR a.nbs='8053' and s.p080 in ('0221' , '0254' , '0328' , '0340' )
OR a.nbs='8052' and s.p080 in ('0222' , '0223' , '0024' , '0225' , '0226' , '0227' , '0029' , '0230' , '0231' , '0232' , '0233' ,
                               '0234' , '0255' , '0256' , '0257' , '0258' , '0259' , '0260' , '0261' , '0262' , '0263' , '0264' ,
                               '0265' , '0266' , '0268' , '0269' , '0270' , '0271' , '0272' , '0273' , '0274' , '0275' , '0276' ,
                               '0277' , '0278' , '0279' , '0280' , '0281' , '0283' , '0284' , '0294' , '0295' , '0296' , '0297' ,
                               '0298' , '0299' , '0300' , '0301' , '0329' , '0330' , '0331' , '0332' , '0341' , '0342' , '0343' ,
                               '0344' , '0345' , '0346' , '0314' , '0315' )
OR a.nbs='8054' and s.p080 in ('0235' , '0333' , '0347' )
OR a.nbs='8050' and s.p080 in ('0236' , '0334' , '0348' )
OR a.nbs='8055' and s.p080 in ('0282')
     )
union all
select "ACC","KF","NLS","KV","BRANCH","NLSALT","NBS","NBS2","DAOS","DAPP","ISP","NMS","LIM","OSTB","OSTC","OSTF","OSTQ","DOS","KOS","DOSQ","KOSQ","PAP","TIP","VID","TRCN","MDATE","DAZS","SEC","ACCC","BLKD","BLKK","POS","SECI","SECO","GRP","OSTX","RNK","NOTIFIER_REF","TOBO","BDATE","OPT","OB22","DAPPQ","SEND_SMS" from accounts a
where  (a.ostc <> 0 or a.dazs is null )
 and nls in (select distinct nls from  SPEC1_INT_PO
             where nls like '8010%' and p080 = '0078' and r020_FA = '7423' and ob22 in ('26','28')
            )
;

PROMPT *** Create  grants  CLOSE_PO ***
grant SELECT                                                                 on CLOSE_PO        to BARSREADER_ROLE;
grant SELECT                                                                 on CLOSE_PO        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/CLOSE_PO.sql =========*** End *** =====
PROMPT ===================================================================================== 
