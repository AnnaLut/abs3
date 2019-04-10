using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using BarsWeb.Areas.WebApi.Deposit.Infrastructure.DI.Abstract;

namespace BarsWeb.Areas.WebApi.Deposit.Infrastructure.DI.Implementation
{
    public class DepositRepository:IDepositRepository
    {
        public DepositRepository()
        {
        }

        public string GetFileFromFileName(string fileName, out long fileSize)
        {
            String res = Path.GetTempPath() + fileName;

            if (!File.Exists(res))
            {
                throw new Exception("Не знайдено файлу зі звітом на сервері.");
            }

            fileSize = new FileInfo(res).Length;

            return res;
        }
    }
}