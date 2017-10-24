using System.Data.Entity;
using System.Data.Entity.ModelConfiguration;
using BarsWeb.Areas.Docs.Models.Bases;
using BarsWeb.Areas.Docs.Models.Permission;

namespace BarsWeb.Areas.Docs.Models
{

    public class DocsDbContext : DbContext
    {
        public DocsDbContext(string connectionString) : base(connectionString)
        {
            Configuration.LazyLoadingEnabled = false;
            //Configuration.ProxyCreationEnabled = true;
        }
        public DbSet<Payment> Payments { get; set; }
        public DbSet<PaymentUserIn> PaymentsUserIn { get; set; }
        public DbSet<PaymentUserOut> PaymentsUserOut { get; set; }
        public DbSet<PaymentBranchIn> PaymentsBranchIn { get; set; }
        public DbSet<PaymentBranchOut> PaymentsBranchOut { get; set; }

        public DbSet<PaymentArcsUserIn> PaymentsArchUserIn { get; set; }
        public DbSet<PaymentArcsUserOut> PaymentsArchUserOut { get; set; }
        public DbSet<PaymentArcsBranchIn> PaymentsArchBranchIn { get; set; }
        public DbSet<PaymentArcsBranchOut> PaymentsArchBranchOut { get; set; }


        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Configurations.Add(new PaymentsConfiguration());          

            modelBuilder.Configurations.Add(new PaymentsUserInConfiguration());
            modelBuilder.Configurations.Add(new PaymentsUserOutConfiguration());

            modelBuilder.Configurations.Add(new PaymentsBranchInConfiguration());
            modelBuilder.Configurations.Add(new PaymentsBranchOutConfiguration());

            modelBuilder.Configurations.Add(new PaymentsArcsUserInConfiguration());
            modelBuilder.Configurations.Add(new PaymentsArcsUserOutConfiguration());

            modelBuilder.Configurations.Add(new PaymentsArcsBranchInConfiguration());
            modelBuilder.Configurations.Add(new PaymentsArcsBranchOutConfiguration()); 
        }
    }

    public class PaymentBaseEntityConfiguration<T> : EntityTypeConfiguration<T> where T : PaymentBase
    {
        public string SchemaName = "BARS";
        public PaymentBaseEntityConfiguration()
        {
            HasKey(i => i.Id);

            Property(i => i.Id).HasColumnName("REF");
            Property(i => i.Number).HasColumnName("ND");
            Property(i => i.UserId).HasColumnName("USERID");
            Property(i => i.CurrencyId).HasColumnName("KV");
            Property(i => i.Summa).HasColumnName("S");
            Property(i => i.SummaEquivalent).HasColumnName("SQ");
            Property(i => i.Status).HasColumnName("SOS");
            Property(i => i.Date).HasColumnName("DATD");
            Property(i => i.DateReceipt).HasColumnName("DATP");
            Property(i => i.DateSystem).HasColumnName("PDAT");
            Property(i => i.DateCurrency).HasColumnName("VDAT");
            Property(i => i.Purpose).HasColumnName("NAZN");
            Property(i => i.TransactionType).HasColumnName("TT");
            Property(i => i.DocumentType).HasColumnName("VOB");

            Property(i => i.SenderAccount).HasColumnName("NLSA");
            Property(i => i.SenderMfo).HasColumnName("MFOA");
            Property(i => i.SenderName).HasColumnName("NAM_A");
            Property(i => i.SenderCode).HasColumnName("ID_A");

            Property(i => i.RecipientSumma).HasColumnName("S2");
            Property(i => i.RecipientCurrencyId).HasColumnName("KV2");
            Property(i => i.RecipientAccount).HasColumnName("NLSB");
            Property(i => i.RecipientMfo).HasColumnName("MFOB");
            Property(i => i.RecipientName).HasColumnName("NAM_B");
            Property(i => i.RecipientCode).HasColumnName("ID_B");
            Property(i => i.DebitKredit).HasColumnName("DK");

            Property(i => i.Branch).HasColumnName("BRANCH");
            Property(i => i.FilialCode).HasColumnName("KF");
        }
    }

    public class PaymentsConfiguration : PaymentBaseEntityConfiguration<Payment>
    {
        public PaymentsConfiguration()
        {
            // Table Specific & Column Mappings
            ToTable("OPER",SchemaName);
        }
    }

    public class PaymentsUserInConfiguration : PaymentBaseEntityConfiguration<PaymentUserIn>
    {
        public PaymentsUserInConfiguration()
        {
            // Table Specific & Column Mappings
            ToTable("V_DOCS_USER_IN", SchemaName);
        }
    }
    public class PaymentsUserOutConfiguration : PaymentBaseEntityConfiguration<PaymentUserOut>
    {
        public PaymentsUserOutConfiguration()
        {
            // Table Specific & Column Mappings
            ToTable("V_DOCS_USER_OUT", SchemaName);
        }
    }
    public class PaymentsBranchInConfiguration : PaymentBaseEntityConfiguration<PaymentBranchIn>
    {
        public PaymentsBranchInConfiguration()
        {
            // Table Specific & Column Mappings
            ToTable("V_DOCS_TOBO_IN", SchemaName);
        }
    }
    public class PaymentsBranchOutConfiguration : PaymentBaseEntityConfiguration<PaymentBranchOut>
    {
        public PaymentsBranchOutConfiguration()
        {
            // Table Specific & Column Mappings
            ToTable("V_DOCS_TOBO_OUT", SchemaName);
        }
    }
    

    //архівна схема
    public class PaymentsArcsUserInConfiguration : PaymentBaseEntityConfiguration<PaymentArcsUserIn>
    {
        public PaymentsArcsUserInConfiguration()
        {
            // Table Specific & Column Mappings
            ToTable("V_DOCS_ARCS_USER_IN", SchemaName);
        }
    }
    public class PaymentsArcsUserOutConfiguration : PaymentBaseEntityConfiguration<PaymentArcsUserOut>
    {
        public PaymentsArcsUserOutConfiguration()
        {
            // Table Specific & Column Mappings
            ToTable("V_DOCS_ARCS_USER_OUT", SchemaName);
        }
    }
    public class PaymentsArcsBranchInConfiguration : PaymentBaseEntityConfiguration<PaymentArcsBranchIn>
    {
        public PaymentsArcsBranchInConfiguration()
        {
            // Table Specific & Column Mappings
            ToTable("V_DOCS_ARCS_TOBO_IN", SchemaName);
        }
    }
    public class PaymentsArcsBranchOutConfiguration : PaymentBaseEntityConfiguration<PaymentArcsBranchOut>
    {
        public PaymentsArcsBranchOutConfiguration()
        {
            // Table Specific & Column Mappings
            ToTable("V_DOCS_ARCS_TOBO_OUT", SchemaName);
        }
    }


}
