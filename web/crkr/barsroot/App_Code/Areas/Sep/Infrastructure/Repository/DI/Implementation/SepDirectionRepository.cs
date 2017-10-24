using Areas.Sep.Models;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Kernel.Models;
using BarsWeb.Areas.Sep.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Models;
using Kendo.Mvc.UI;

namespace BarsWeb.Areas.Sep.Infrastructure.Repository.DI.Implementation
{
    public class SepDirectionRepository : ISepDirectionRepository
    {
        private readonly SepFiles _entities;
        private readonly IKendoSqlTransformer _sqlTransformer;
        private BarsSql _baseSepDirectionSql;
        private readonly IParamsRepository _paramRepo;
        public SepDirectionRepository(IKendoSqlTransformer sqlTransformer, IParamsRepository paramRepo)
        {
            var connectionStr = EntitiesConnection.ConnectionString("SepFiles", "Sep");
            this._entities = new SepFiles(connectionStr);
            _sqlTransformer = sqlTransformer;
            _paramRepo = paramRepo;
        }
        public void SetDirection(DataSourceRequest request, string answer)
        {
            InitSepDirectionSql(answer);
            _entities.ExecuteStoreCommand(_baseSepDirectionSql.SqlText, null);
        }
        private void InitSepDirectionSql(string answer)
        {
            var getBankMFO = _paramRepo.GetParam("MFO");
            switch (answer)
            {
                case "1": //Блокировать начальные платежи
                    _baseSepDirectionSql = new BarsSql()
                    {
                        SqlText = string.Format(
                        @"UPDATE lkl_rrp SET blk=blk+1
                            WHERE blk IN (0,2) AND mfo in 
                            (select mfo from banks where mfop = {0} AND kodn IN(3,4))",
                        getBankMFO.Value),
                        SqlParams = new object[] { }
                    };
                    break;
                case "2": //Разблокировать начальные платежи
                    _baseSepDirectionSql = new BarsSql()
                    {
                        SqlText = string.Format(
                        @"UPDATE lkl_rrp SET blk=blk-1
                            WHERE blk IN (1,3) AND mfo in 
                            (select mfo from banks where mfop = {0} AND kodn IN(3,4))",
                        getBankMFO.Value),
                        SqlParams = new object[] { }
                    };
                    break;
                case "3": //Блокировать ответные платежи
                    _baseSepDirectionSql = new BarsSql()
                    {
                        SqlText = string.Format(
                        @"UPDATE lkl_rrp SET blk=blk+2
                            WHERE blk IN (0,1) AND mfo in 
                            (select mfo from banks where mfop = {0} AND kodn IN (3,4))",
                        getBankMFO.Value),
                        SqlParams = new object[] { }
                    };
                    break;
                case "4": //Разблокировать ответные платежи
                    _baseSepDirectionSql = new BarsSql()
                    {
                        SqlText = string.Format(
                        @"UPDATE lkl_rrp SET blk=blk-2
                            WHERE blk IN (2,3) AND mfo in 
                            (select mfo from banks where mfop = {0} AND kodn IN (3,4))",
                        getBankMFO.Value),
                        SqlParams = new object[] { }
                    };
                    break;
                case "5": //Блокировать все направления
                    _baseSepDirectionSql = new BarsSql()
                    {
                        SqlText = string.Format(
                        @"UPDATE lkl_rrp SET blk=3
                            WHERE mfo in 
                            (select mfo from banks where mfop = {0} AND kodn IN (3,4))",
                        getBankMFO.Value),
                        SqlParams = new object[] { }
                    };
                    break;
                case "6": //Разблокировать все направления
                    _baseSepDirectionSql = new BarsSql()
                    {
                        SqlText = string.Format(
                        @"UPDATE lkl_rrp SET blk=0
                            WHERE blk IN (1,2,3) AND mfo in 
                            (select mfo from banks where mfop = {0} AND kodn IN(3,4))",
                        getBankMFO.Value),
                        SqlParams = new object[] { }
                    };
                    break;
            }
        }
    }
}
