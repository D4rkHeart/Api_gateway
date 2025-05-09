using i321;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Design;

public class ApplicationContextFactory : IDesignTimeDbContextFactory<ApplicationContext>
{
    public ApplicationContext CreateDbContext(string[] args)
    {
        var optionsBuilder = new DbContextOptionsBuilder<ApplicationContext>();

        IConfigurationRoot configuration = new ConfigurationBuilder()
            .AddJsonFile("appsettings.json")
            .Build();

        var serverVersion = new MariaDbServerVersion(new Version(1, 1));
        optionsBuilder.UseMySql(configuration["ConnectionStrings:ecommerceConnection"], serverVersion);

        return new ApplicationContext(optionsBuilder.Options);
    }
}

