

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/DPT2PAY.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** Create  view DPT2PAY ***

  CREATE OR REPLACE FORCE VIEW BARS.DPT2PAY ("DEPOSIT_ID", "ACC", "DAT_BEGIN", "DAT_END", "FREQ", "DAT2PAY") AS 
  SELECT d.deposit_id, d.acc, d.dat_begin, d.dat_end, d.freq,
       decode(d.freq,
              3,            d.dat_begin+ 7*round((bankdate-d.dat_begin)/7,0),
              5, add_months(d.dat_begin,   round(months_between(bankdate,d.dat_begin),0)),
              7, add_months(d.dat_begin, 3*round(months_between(bankdate,d.dat_begin)/3,0)),
            180, add_months(d.dat_begin, 6*round(months_between(bankdate,d.dat_begin)/6,0)),
            360, add_months(d.dat_begin,12*round(months_between(bankdate,d.dat_begin)/12,0)),
            400, d.dat_end, bankdate)
FROM dpt_deposit d, int_accn i
WHERE decode(d.freq,
                3,            d.dat_begin+ 7*round((bankdate-d.dat_begin)/7,0),
                5, add_months(d.dat_begin,   round(months_between(bankdate,d.dat_begin),0)),
                7, add_months(d.dat_begin, 3*round(months_between(bankdate,d.dat_begin)/3,0)),
              180, add_months(d.dat_begin, 6*round(months_between(bankdate,d.dat_begin)/6,0)),
              360, add_months(d.dat_begin,12*round(months_between(bankdate,d.dat_begin)/12,0)),
              400, d.dat_end, bankdate) = bankdate AND
       d.dat_begin <= bankdate AND d.dat_end IS NOT NULL AND
         d.dat_end >= bankdate AND d.acc=i.acc AND i.id=1
 ;

PROMPT *** Create  grants  DPT2PAY ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPT2PAY         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/DPT2PAY.sql =========*** End *** ======
PROMPT ===================================================================================== 
