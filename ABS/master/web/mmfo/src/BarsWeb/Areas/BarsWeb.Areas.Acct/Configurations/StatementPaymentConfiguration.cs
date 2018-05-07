using System.Data.Entity.ModelConfiguration;
using BarsWeb.Areas.Acct.Models;

namespace BarsWeb.Areas.Acct.Configurations
{
    public class StatementPaymentConfiguration : EntityTypeConfiguration<StatementPayment>
    {
        /// <summary>
        ///     Constructor StatementPayment
        /// </summary>
        public StatementPaymentConfiguration(string schemaName)
        {
            ToTable("V_ACCT_STATEMENTS", schemaName);

            Property(i => i.Id).HasColumnName("STMT");
            Property(i => i.DocumentId).HasColumnName("REF");
            Property(i => i.Number).HasColumnName("ND");
            Property(i => i.TransactionType).HasColumnName("TT");
            Property(i => i.AccountId).HasColumnName("ACC");
            Property(i => i.StatusCode).HasColumnName("SOS");
            Property(i => i.CorrespBankId).HasColumnName("MFOB");
            Property(i => i.CorrespCurrencyId).HasColumnName("KV2");
            Property(i => i.CorrespAccountNumber).HasColumnName("NLSB"); 
            Property(i => i.CorrespAccountName).HasColumnName("NAM_B");
            Property(i => i.Debit).HasColumnName("DOS");
            Property(i => i.Kredit).HasColumnName("KOS");
            Property(i => i.Purpose).HasColumnName("COMM");
            Property(i => i.Date).HasColumnName("PDAT"); 
            Property(i => i.FactDate).HasColumnName("FDAT"); 
        }
    }
}
