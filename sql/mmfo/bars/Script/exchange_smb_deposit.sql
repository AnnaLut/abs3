declare
    l_old_table varchar2(30) := 'SMB_DEPOSIT_TRANCHE';
    l_qty       number;
begin
     insert into smb_deposit (
                   id
                  ,currency_id
                  ,amount_tranche
                  ,is_replenishment_tranche
                  ,max_sum_tranche
                  ,min_replenishment_amount
                  ,last_replenishment_date
                  ,is_prolongation
                  ,number_prolongation
                  ,prolongation_interest_rate
                  ,apply_bonus_prolongation
                  ,frequency_payment
                  ,is_capitalization
                  ,is_individual_rate
                  ,number_tranche_days
                  ,penalty_interest_rate
                  ,general_interest_rate        
                  ,bonus_interest_rate
                  ,capitalization_interest_rate
                  ,payment_interest_rate        
                  ,replenishment_interest_rate
                  ,individual_interest_rate
                  )
        select 
               p.object_id
              ,x.currency_id
              ,x.amount_tranche
              ,x.is_replenishment_tranche
              ,0
              ,0
              ,x.last_replenishment_date
              ,x.is_prolongation
              ,trunc(x.number_prolongation)
              ,x.interest_rate_prolongation
              ,x.apply_bonus_prolongation
              ,x.frequency_payment
              ,x.is_capitalization
              ,x.is_individual_rate
              ,x.number_tranche_days
              ,x.penalty_interest_rate
              ,x.interest_rate_general
              ,x.interest_rate_bonus
              ,x.interest_rate_capitalization
              ,x.interest_rate_payment
              ,x.interest_rate_replenishment
              ,case when x.is_individual_rate = 0 then 0 else x.individual_interest_rate end
          from process_type t
              ,process p
              ,xmltable ('/SMBDepositTranche' passing xmltype(p.process_data) columns
                     Currency_Id                   number         path 'CurrencyId'
                    ,Amount_Tranche                number         path 'AmountTranche'
                    ,Is_Replenishment_Tranche      number         path 'IsReplenishmentTranche'
                    ,Last_Replenishment_Date       date           path 'LastReplenishmentDate'
                    ,Is_Prolongation               number         path 'IsProlongation'
                    ,number_tranche_days           number         path 'NumberTrancheDays'
                    ,Interest_Rate                 number         path 'InterestRate'
                    ,Number_Prolongation           number         path 'NumberProlongation'
                    ,Interest_Rate_Prolongation    number         path 'InterestRateProlongation'
                    ,Apply_Bonus_Prolongation      number         path 'ApplyBonusProlongation'
                    ,Frequency_Payment             number         path 'FrequencyPayment'
                    ,Is_Individual_Rate            number         path 'IsIndividualRate'
                    ,Individual_Interest_Rate      number         path 'IndividualInterestRate'
                    ,Is_Capitalization             number         path 'IsCapitalization'
                    ,penalty_interest_rate         number         path 'PenaltyRate'
                    ,interest_rate_capitalization  number         path 'InterestRateCapitalization'
                    ,interest_rate_bonus           number         path 'InterestRateBonus'
                    ,interest_rate_replenishment   number         path 'InterestRateReplenishment'
                    ,interest_rate_payment         number         path 'InterestRatePayment'
                    ,Interest_Rate_General         number         path 'InterestRateGeneral') x
         where p.process_type_id = t.id
           and t.process_code = 'NEW_TRANCHE'
           and not exists(
               select null
                 from smb_deposit t
                where p.object_id = t.id);   

    insert into smb_deposit  (
                   id
                  ,currency_id
                  ,amount_tranche
                  ,is_replenishment_tranche
                  ,is_prolongation
                  ,frequency_payment
                  ,is_capitalization
                  ,is_individual_rate
                  ,individual_interest_rate
                  ,calculation_type
                  )
        select 
               p.object_id
              ,x.currency_id
              ,null
              ,0
              ,0
              ,x.frequency_payment
              ,0
              ,x.is_individual_rate
              ,case when x.is_individual_rate = 0 then 0 else x.individual_interest_rate end
              ,x.calculation_type
          from process_type t
              ,process p
              ,xmltable ('/SMBDepositOnDemand' passing xmltype(p.process_data) columns
                     Currency_Id                   number         path 'CurrencyId'
                    ,Frequency_Payment             number         path 'FrequencyPayment'
                    ,Is_Individual_Rate            number         path 'IsIndividualRate'
                    ,Individual_Interest_Rate      number         path 'IndividualInterestRate'
                    ,calculation_type              number         path 'CalculationType') x
         where p.process_type_id = t.id
           and t.process_code = 'NEW_ON_DEMAND'
           and not exists(
               select null
                 from smb_deposit t
                where p.object_id = t.id);

    commit;
            
    select count(*)
      into l_qty
      from user_tables
     where table_name = l_old_table;
    if l_qty <> 0 then
        execute immediate 'drop table '||l_old_table;
    end if;
end;
/
