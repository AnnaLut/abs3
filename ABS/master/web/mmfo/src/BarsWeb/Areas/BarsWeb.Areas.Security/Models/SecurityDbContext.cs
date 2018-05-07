using System.Data.Entity;

namespace BarsWeb.Areas.Security.Models
{

    public class SecurityDbContext : DbContext
    {
        private const string SchemaName = "BARS";

        public SecurityDbContext(string connectionString) : base(connectionString)
        {
            Configuration.LazyLoadingEnabled = false;
        }

        public DbSet<AuditMessage> AuditMessages { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            BuildBuildCustomers(modelBuilder);
        }

        private void BuildBuildCustomers(DbModelBuilder modelBuilder)
        {
            var customerBuilder = modelBuilder.Entity<AuditMessage>();

            customerBuilder.ToTable("V_SEC_AUDIT_UI", SchemaName);

            customerBuilder.Property(i => i.Id).HasColumnName("REC_ID");
            customerBuilder.Property(i => i.UId).HasColumnName("REC_UID");
            customerBuilder.Property(i => i.UserName).HasColumnName("REC_UNAME");
            customerBuilder.Property(i => i.UserProxy).HasColumnName("REC_UPROXY");
            customerBuilder.Property(i => i.SystemDate).HasColumnName("REC_DATE");
            customerBuilder.Property(i => i.BankDate).HasColumnName("REC_BDATE");
            customerBuilder.Property(i => i.Type).HasColumnName("REC_TYPE");
            customerBuilder.Property(i => i.Module).HasColumnName("REC_MODULE");
            customerBuilder.Property(i => i.Message).HasColumnName("REC_MESSAGE");
            customerBuilder.Property(i => i.Machine).HasColumnName("MACHINE");
            customerBuilder.Property(i => i.Object).HasColumnName("REC_OBJECT");
            customerBuilder.Property(i => i.UserId).HasColumnName("REC_USERID");
            customerBuilder.Property(i => i.Branch).HasColumnName("BRANCH");
            customerBuilder.Property(i => i.Stack).HasColumnName("REC_STACK");
            customerBuilder.Property(i => i.ClientIdentifier).HasColumnName("CLIENT_IDENTIFIER");
            customerBuilder.Property(i => i.TypeComment).HasColumnName("SEC_TYPECOMM");
        }
    }
}
