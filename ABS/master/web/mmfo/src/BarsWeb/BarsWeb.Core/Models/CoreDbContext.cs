using System.Data.Entity;

namespace BarsWeb.Core.Models
{

    public class CoreDbContext : DbContext
    {
        private string schemaName = "BARS";

        public CoreDbContext(string connectionString) : base(connectionString)
        {
            Configuration.LazyLoadingEnabled = false;
            //Configuration.ProxyCreationEnabled = true;
        }

        public DbSet<UserInfo> UserInfos { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            BuildBuildUserInfo(modelBuilder);
        }

        private void BuildBuildUserInfo(DbModelBuilder modelBuilder)
        {
            var customerBuilder = modelBuilder.Entity<UserInfo>();

            customerBuilder.ToTable("V_WEB_USERMAP", schemaName);

            customerBuilder.Property(i => i.Id).HasColumnName("USER_ID");
            customerBuilder.Property(i => i.Login).HasColumnName("WEBUSER");
            customerBuilder.Property(i => i.ChangeDate).HasColumnName("CHANGE_DATE");
            customerBuilder.Property(i => i.LogLevel).HasColumnName("LOG_LEVEL");
            customerBuilder.Property(i => i.BankDate).HasColumnName("BANK_DATE");
            customerBuilder.Property(i => i.ErrorMode).HasColumnName("ERRMODE");
            customerBuilder.Property(i => i.Blocked).HasColumnName("BLOCKED");
            customerBuilder.Property(i => i.Comment).HasColumnName("COMM");
            customerBuilder.Property(i => i.Password).HasColumnName("WEBPASS");
            customerBuilder.Property(i => i.AdminPassword).HasColumnName("ADMINPASS");
            customerBuilder.Property(i => i.Attempts).HasColumnName("ATTEMPTS");
        }
    }
}
