using System;
using System.Activities.Statements;
using System.Configuration;
using System.Data;
using System.IO;
using System.Linq;
using System.Xml.Serialization;
using Areas.Cdm.Models;
using Bars.Application;
using BarsWeb.Areas.Cdm.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Cdm.Models.Transport;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract;
using BarsWeb.Models;
using Oracle.DataAccess.Client;

namespace BarsWeb.Areas.Cdm.Infrastructure.Repository.DI.Implementation
{
    public class CdmRepository : ICdmRepository
    {
        private readonly CdmModel _entities;
        private readonly IBanksRepository _banksRepository;

        public CdmRepository(IBanksRepository banksRepository)
        {
            var connectionStr = EntitiesConnection.ConnectionString("CdmModel", "Cdm");
            _entities = new CdmModel(connectionStr);
            _banksRepository = banksRepository;
        }
        public void SaveRequestToTempTable(string packName, string packBody)
        {
            var sqlParams = new object[]
            {
                new OracleParameter("p_Name", OracleDbType.Varchar2) {Value = packName},
                new OracleParameter("p_Body", OracleDbType.Clob) {Value = packBody}
            };
            _entities.ExecuteStoreCommand("insert into BARS.TMP_KLP_CLOB (NAMEF,  C) values (:p_Name, :p_Body)", sqlParams);
        }

        public int PackAndSendClientCards(int? cardsCount, int packSize)
        {
            if (cardsCount == null)
            {
                return 0;
            }
            int allCardsSended = 0;

            while (allCardsSended < cardsCount)
            {
                var currentPackSize = GetNextCardsCount(packSize);
                if (currentPackSize == 0)
                {
                    break;
                }
                var sqlParams = new object[]
                {
                    new OracleParameter("p_Size", OracleDbType.Int16) {Value = ((cardsCount > packSize) ? packSize: cardsCount)}
                };
                //получаем массив карточек
                var login = ConfigurationManager.AppSettings["ebk.local.UserName"];
                var password = ConfigurationManager.AppSettings["ebk.local.Password"];

                bool isAuthenticated = CustomAuthentication.AuthenticateUser(login, password, true);
                if (!isAuthenticated)
                {
                    throw new Exception("Пимилка аутентифікації в БД!");
                }

                var packBody = _entities.ExecuteStoreQuery<BufClientData>(
                    "select * from EBK_QUEUE_UPDATECARD_V where rownum <= :p_Size order by rnk", sqlParams);

                //получаем параметры пакета
                int packNum = GetNextPackNumber();
                string ourMfo = _banksRepository.GetOurMfo();

                //строим пакет
                Card package = new Card(ourMfo, packNum.ToString(), packBody.ToList());
                XmlSerializer ser = new XmlSerializer(typeof(Card));
                TextWriter writer = new StreamWriter(string.Format(@"D:\temp\pack{0}.xml", packNum));
                ser.Serialize(writer, package);
                writer.Close();

                //отправляем данные в ЕБК


                //записываем результаты отправки

                allCardsSended = +currentPackSize;

            }
            return allCardsSended;
        }

        private int GetNextPackNumber()
        {
            return _entities.ExecuteStoreQuery<int>("SELECT EBK_PACKAGE_NMBR.NEXTVAL FROM DUAL").SingleOrDefault();
        }


        private int GetNextCardsCount(int packSize)
        {
            var sqlParams = new object[]
            {
                new OracleParameter("p_Size", OracleDbType.Int16) {Value = packSize}
            };
            return _entities.ExecuteStoreQuery<int>("select count(*) from EBK_QUEUE_UPDATECARD_V where rownum <= : p_Size", sqlParams).SingleOrDefault();
        }
    }
    
}